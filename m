Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB0B546482
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jun 2022 12:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348360AbiFJKq0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jun 2022 06:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348532AbiFJKoY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jun 2022 06:44:24 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18067285AA5
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jun 2022 03:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654857667; x=1686393667;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=rlYaqe3k1Fi1wC88ZVmFonwFfbprf8cMFSxYBxhVBRk=;
  b=RzSJMD2grCuAs1L4vhdYZqYwPbaa7rfmU44PeAE4iyoa6UlmZAQUX4em
   4zgz1g1gykvZTvEYICGuEoePuxxoF83D4LGzD8ANw+7kivfQtUjdIULF5
   0BZfUrsEOxweyvvjio0PkQZQtv/R5pVmvDwIZkfjn089EwRnfYwkveeWw
   Y=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 10 Jun 2022 03:41:06 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 03:41:06 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 10 Jun 2022 03:41:06 -0700
Received: from srirrama-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 10 Jun 2022 03:41:04 -0700
From:   Sriram R <quic_srirrama@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH 0/3] Mesh Fast xmit support
Date:   Fri, 10 Jun 2022 16:10:36 +0530
Message-ID: <1654857639-12346-1-git-send-email-quic_srirrama@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently Fast xmit is supported for AP, STA and other device types where
the destination doesn't change for the lifetime of its association by
caching the static parts of the header that can be reused directly for
every Tx such as addresses and updates the mutable header fields such as
PN. This technique is not directly applicable for a Mesh device type
due to the dynamic nature of the topology and protocol. The header is
built based on the destination mesh device which is proxying a certain
external device and based on the Mesh destination the next hop changes.
And the RA/A1 which is the next hop for reaching the destination can
vary during runtime as per the best route based on airtime.  To
accommodate these changes and to come up with a solution to avoid
overhead during header generation, the headers comprising the MAC, Mesh
and LLC part are cached whenever data for a certain external destination
is sent. This cached header is reused every time a data is sent to that
external destination.

To ensure the changes in network are reflected in these cached headers,
the Mesh Proxy path table and Mesh path table changes are monitored
and corresponding headers are updated or flushed as applicable so that
the header used for a frame towards a certain destination is valid.

Old headers are flushed by the mesh housekeeping timers and based on the
cache size.

Only 6addr frame headers are cached currently.

Tested with ath11k driver.

Sriram R (3):
  cfg80211: increase mesh config attribute bitmask size
  cfg80211: Add provision for changing mesh header cache size
  mac80211: Mesh Fast xmit support

 include/net/cfg80211.h        |   5 +-
 include/uapi/linux/nl80211.h  |   4 +
 net/mac80211/cfg.c            |   6 +-
 net/mac80211/debugfs_netdev.c |   3 +
 net/mac80211/ieee80211_i.h    |  20 +++
 net/mac80211/mesh.c           |   2 +
 net/mac80211/mesh.h           |  45 +++++
 net/mac80211/mesh_hwmp.c      |   8 +-
 net/mac80211/mesh_pathtbl.c   | 396 ++++++++++++++++++++++++++++++++++++++++++
 net/mac80211/rx.c             |   9 +-
 net/mac80211/tx.c             |  90 ++++++++++
 net/wireless/mesh.c           |   3 +
 net/wireless/nl80211.c        |  12 +-
 net/wireless/rdev-ops.h       |   2 +-
 net/wireless/trace.h          |   6 +-
 15 files changed, 596 insertions(+), 15 deletions(-)

-- 
2.7.4

