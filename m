Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C52256523B
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jul 2022 12:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbiGDKZl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jul 2022 06:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbiGDKZU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jul 2022 06:25:20 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A315F60
        for <linux-wireless@vger.kernel.org>; Mon,  4 Jul 2022 03:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656930239; x=1688466239;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=2yMseNHhxDs2jFVL9E+gbcgyMuDTtJ/0jLAdYNnY4fE=;
  b=QBa92XBW6ypsBqln6aH6Qgz/gRulqXUkd/DJDQfAp+f0pQ17GCVw8O+C
   4u0fxDrGAJa5CIaEmRGPppJlKCLIlc/Rc9JiFZLbs7HeSySYQBgrDhC9M
   0li0Pj7C6mEb3+45Bx8pjuDAWKdmo7PXJPW2qRgNsl1QNAwIPplcBoXu8
   M=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 04 Jul 2022 03:23:58 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 03:23:58 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Jul 2022 03:23:58 -0700
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Jul 2022 03:23:56 -0700
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <johannes@sipsolutions.net>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH 0/7] cfg80211/mac80211: extend 6 GHz support for all power modes
Date:   Mon, 4 Jul 2022 15:53:34 +0530
Message-ID: <20220704102341.5692-1-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

6 GHz introduces various power modes of operation. Currently, based
on the power mode, channel's Power Spectral Density (PSD)  value as
well as channel disabled flag can change. For single interface,
current implementation works just fine. But for multi-interfaces, for
example AP-STA concurrency, two different channel context needs to be
maintained. This is because, STA power mode also depends on the AP's
power mode it is going to associate with. Hence, PSD value and channel
disabled flag might vary. In this case, same channel context cannot be
used for both AP and STA.

Therefore, to support multiple channel space for each power mode, the
6 GHz channels needs a separate storage space in data structure
ieee80211_supported_band. Because of this, the existing APIs to get the
channel/frequency from frequency/channel will not work for 6 GHz band.

Add support to store all possible 6 GHz channel pools according to the
power mode as well as add API support for getting channel/frequency info
from the new struct ieee80211_6ghz_channel.

Aditya Kumar Singh (6):
  mac80211: rework on 6 GHz power type definition
  mac80211: add combined power type definition for 6 GHz
  cfg80211: add NL command to set 6 GHz power mode
  mac80211: add support for 6 GHz channels and regulatory
  cfg80211: rework nl80211_parse_chandef for 6 GHz
  cfg80211: save 6 GHz power mode of the regulatory rules

Wen Gong (1):
  cfg80211: save Power Spectral Density (PSD) of the regulatory rule

 include/linux/ieee80211.h    |  10 +--
 include/net/cfg80211.h       |  68 +++++++++++++++
 include/net/regulatory.h     |   2 +
 include/uapi/linux/nl80211.h |  66 +++++++++++++++
 net/mac80211/cfg.c           |  35 ++++++++
 net/mac80211/util.c          |  42 ++++++++-
 net/wireless/ap.c            |   4 +
 net/wireless/nl80211.c       | 159 +++++++++++++++++++++++++++++++----
 net/wireless/nl80211.h       |   3 +-
 net/wireless/pmsr.c          |   8 +-
 net/wireless/rdev-ops.h      |  19 +++++
 net/wireless/reg.c           |  61 ++++++++++++--
 net/wireless/sme.c           |   3 +
 net/wireless/trace.h         |  21 +++++
 net/wireless/util.c          |  87 +++++++++++++++++++
 15 files changed, 552 insertions(+), 36 deletions(-)

-- 
2.17.1

