Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE8047ED74
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Dec 2021 09:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343657AbhLXIwz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Dec 2021 03:52:55 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:62138 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241541AbhLXIwy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Dec 2021 03:52:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640335974; x=1671871974;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T6yczIZsdajMiqnGS9NhC5afIZkzDMJoJouZGNwCQuI=;
  b=KHX2oTpvl8oNw0wExNeA/BJLlSnHfChKOO+pg+vohk8nThmp8Qd79u2O
   kZTaPDT7PSq6oCTmqlFDEqbCvW3Nl6HbfeOAstn92m4H8UbcXw451saKS
   mH2zJEDpt8YBKCuFJz+ZLDYviVJY7hfFaBPLGI4f5NQFqhzJBKdSVPHxZ
   U=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 24 Dec 2021 00:52:54 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2021 00:52:54 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 24 Dec 2021 00:52:54 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 24 Dec 2021 00:52:52 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v2 00/15] ath11k: add support for 6 GHz station for various modes : LPI, SP and VLP
Date:   Fri, 24 Dec 2021 03:52:21 -0500
Message-ID: <20211224085236.9064-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

v2: 
   1. change some minor comments by Kalle.
   2. rebased to ath.git ath-202112220603

Depends on one patch:
[v5] cfg80211: save power spectral density(psd) of regulatory rule
https://patchwork.kernel.org/project/linux-wireless/patch/20210928085211.26186-1-wgong@codeaurora.org/

It introduced some new concept:
power type of AP(STANDARD_POWER_AP, INDOOR_AP, VERY_LOW_POWER_AP)
power type of STATION(DEFAULT_CLIENT, SUBORDINATE_CLIENT)
power spectral density(psd)

This patchset is to implement the new rules for 6 GHz band in
ath11k.

ath11k parsed the reg rules from new wmi event
WMI_REG_CHAN_LIST_CC_EXT_EVENTID and parse the
transmit power envelope element in beacon of AP
and then set new wmi cmd WMI_VDEV_SET_TPC_POWER_CMDID
to firmware when connect to 6G AP, also support backward
compatibility with firmware which not support new wmi
cmd WMI_VDEV_SET_TPC_POWER_CMDID.

Wen Gong (15):
  ath11k: add support for extended wmi service bit
  ath11k: Add support to parse new wmi event for 6 GHz regulatory
  ath11k: add support to select 6 GHz Regulatory type
  ath11k: allow only one interface up simultaneously for WCN6855
  ath11k: store cur_regulatory_info for each radio
  ath11k: update regulatory rules when interface added
  ath11k: update regulatory rules when connect to AP on 6 GHz band for
    station
  ath11k: save power spectral density(psd) of regulatory rule
  ath11k: add parse of transmit power envelope element
  ath11k: save max tx power in vdev start response event from firmware
  ath11k: fill parameters for vdev_set_tpc_power wmi command
  ath11k: add WMI_TLV_SERVICE_EXT_TPC_REG_SUPPORT service bit
  ath11k: discard BSS_CHANGED_TXPOWER when EXT_TPC_REG_SUPPORT for 6 GHz
  ath11k: add handler for WMI_VDEV_SET_TPC_POWER_CMDID
  ath11k: send TPC power to firmware for 6 GHz station

 drivers/net/wireless/ath/ath11k/core.c |   6 +
 drivers/net/wireless/ath/ath11k/core.h |  40 ++
 drivers/net/wireless/ath/ath11k/hw.c   |  17 +
 drivers/net/wireless/ath/ath11k/hw.h   |   5 +
 drivers/net/wireless/ath/ath11k/mac.c  | 539 ++++++++++++++++-
 drivers/net/wireless/ath/ath11k/mac.h  |   5 +-
 drivers/net/wireless/ath/ath11k/reg.c  | 105 +++-
 drivers/net/wireless/ath/ath11k/reg.h  |   6 +-
 drivers/net/wireless/ath/ath11k/wmi.c  | 799 +++++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/wmi.h  | 219 ++++++-
 10 files changed, 1659 insertions(+), 82 deletions(-)


base-commit: e5da5e8c54e27d8fa86765cd733c1a05aee53ae9
prerequisite-patch-id: d0941cb1e08f82e9bd5feaf01b160807b4b0faa9
-- 
2.31.1

