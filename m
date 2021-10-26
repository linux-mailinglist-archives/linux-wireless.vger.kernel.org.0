Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1D543B10E
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Oct 2021 13:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbhJZLWM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Oct 2021 07:22:12 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:47817 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbhJZLWL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Oct 2021 07:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635247188; x=1666783188;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IDJx14GduesSW3sMZhDa1eGb0NCSZpY2io/2eR8Eot4=;
  b=t8wEaQXPyktIUfcUKOxwPKgM7YksqRNr1Qq4nW4/dzZEKDnPE2OrCciq
   nANXHEmvpkc+S54yMyfJkgcV5UQ/93pGfXc3Z4i40r/xSzHWgGYJcuXe9
   yQKQ7cCEx3unEd68L6E3y40fw5jiSu20TwsmkQ9kM6qV2cCeBd7oxFr70
   c=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 26 Oct 2021 04:19:48 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 04:19:48 -0700
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Tue, 26 Oct 2021 04:19:46 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH 00/15] ath11k: add support for 6 GHz station for various modes : LPI, SP and VLP
Date:   Tue, 26 Oct 2021 07:18:58 -0400
Message-ID: <20211026111913.7346-1-quic_wgong@quicinc.com>
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

It depends on the patches of mac80211/ieee80211/cfg80211
ad below links:

ieee80211: add definition of regulatory info in 6 GHz operation information
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a1ef61825469b874920f4afb889e1a92353680ff

ieee80211: add definition for transmit power envelope element
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ad31393b98e4addbc5f1ccc484bfbb8d07c92056

mac80211: parse transmit power envelope element
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b0345850ad770c5164bf6d4a0aa0c40ef2419cb0

mac80211: use ieee802_11_parse_elems() in ieee80211_prep_channel()
https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git/commit/?id=37123c3baaee4d6a189ad4abad804770d4a607e8

ieee80211: add power type definition for 6 GHz
https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git/commit/?id=405fca8a946168e71c04b82cc80727c3ea686e08

mac80211: add parse regulatory info in 6 GHz operation information
https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git/commit/?id=cb751b7a57e50d356ec8fc7712c245a05515e787

mac80211: save transmit power envelope element and power constraint
https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git/commit/?id=63214f02cff9ebd57be00e143de12107c66f5394

[v5] cfg80211: save power spectral density(psd) of regulatory rule
https://patchwork.kernel.org/project/linux-wireless/patch/20210928085211.26186-1-wgong@codeaurora.org/

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

 drivers/net/wireless/ath/ath11k/core.c |  10 +
 drivers/net/wireless/ath/ath11k/core.h |  57 ++
 drivers/net/wireless/ath/ath11k/hw.h   |   1 +
 drivers/net/wireless/ath/ath11k/mac.c  | 551 ++++++++++++++++-
 drivers/net/wireless/ath/ath11k/mac.h  |   5 +-
 drivers/net/wireless/ath/ath11k/reg.c  |  99 ++-
 drivers/net/wireless/ath/ath11k/reg.h  |   6 +-
 drivers/net/wireless/ath/ath11k/wmi.c  | 796 +++++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/wmi.h  | 217 ++++++-
 9 files changed, 1660 insertions(+), 82 deletions(-)

-- 
2.31.1

