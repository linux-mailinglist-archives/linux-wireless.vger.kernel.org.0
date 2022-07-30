Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5345858C5
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Jul 2022 07:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiG3F1B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Jul 2022 01:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiG3F1A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Jul 2022 01:27:00 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F131E0A2
        for <linux-wireless@vger.kernel.org>; Fri, 29 Jul 2022 22:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659158819; x=1690694819;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qOpZBvXB9YfdlEvTbenP9Cx72+A3T3feN34hCSuaxyM=;
  b=F6vPJ2z4XzZPxGOVcHBL0hTHi5D3b0b/EFcDYIYigRCRhGTnpyT+B3jO
   ZfZ0CYBof3IeU425Exp5mbDd02nGWUM+cw6pHnrGqOrsM3NZf8/bbo9H7
   SB/ccUz5rsWJ8hgb85bVyHuEsbaJEFW0C6QwPKrjNDpBwp0qAhCuX+6Fs
   0=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 29 Jul 2022 22:26:58 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 22:26:58 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Jul 2022 22:26:58 -0700
Received: from cnss-mw-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Jul 2022 22:26:56 -0700
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <quic_vjakkam@quicinc.com>
Subject: [PATCH v2 0/3] wifi: cfg80211: Add support for key operations on MLD
Date:   Sat, 30 Jul 2022 10:56:40 +0530
Message-ID: <20220730052643.1959111-1-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch series is to add support for various key operations on MLD.

Veerendranath Jakkam (3):
  wifi: cfg80211: reject connect response with MLO params for WEP
  wifi: cfg80211: Prevent cfg80211_wext_siwencodeext() on MLD
  wifi: cfg80211: Add link_id parameter to various key operations for
    MLO

 drivers/net/wireless/ath/ath6kl/cfg80211.c    |   8 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c   |  10 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  22 +--
 drivers/net/wireless/marvell/libertas/cfg.c   |   9 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  10 +-
 .../wireless/microchip/wilc1000/cfg80211.c    |  17 ++-
 .../net/wireless/quantenna/qtnfmac/cfg80211.c |  12 +-
 drivers/net/wireless/rndis_wlan.c             |  20 +--
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  13 +-
 drivers/staging/wlan-ng/cfg80211.c            |  12 +-
 include/net/cfg80211.h                        |  37 +++--
 include/uapi/linux/nl80211.h                  |  14 +-
 net/mac80211/cfg.c                            |  17 +--
 net/wireless/ibss.c                           |   2 +-
 net/wireless/nl80211.c                        | 126 ++++++++++++++----
 net/wireless/rdev-ops.h                       |  58 ++++----
 net/wireless/sme.c                            |   5 +-
 net/wireless/trace.h                          |  86 +++++++-----
 net/wireless/util.c                           |   4 +-
 net/wireless/wext-compat.c                    |  18 ++-
 20 files changed, 322 insertions(+), 178 deletions(-)

-- 
2.25.1

