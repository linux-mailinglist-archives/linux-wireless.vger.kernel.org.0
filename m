Return-Path: <linux-wireless+bounces-34680-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LDbIvaA3GmYSAkAu9opvQ
	(envelope-from <linux-wireless+bounces-34680-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 07:36:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E49CC3E7810
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 07:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6240F300B60A
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 05:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA20335BA;
	Mon, 13 Apr 2026 05:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Ugg9057o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B061D2C027C
	for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 05:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776058577; cv=none; b=pJ2/w1t16skUy041SU57Ld5bBhsUGWzyxT9l/d3/0iR7Wcq5E0auu/IZjBgUEpe5nW552n0cEaka2BOGT5wsDMMPmV1afmtBDqnEa60NsYCdu2mG4AJsISdnbLRkcPwUvRTaA2M4FracVvu4H0zqACspSmDBNxApa1GcipZYfsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776058577; c=relaxed/simple;
	bh=fgVbgp5OGkNnLW9u89p++tH57CKLIFJ/wMUJBjgLmU8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dZUzeQeh9l8M6EcoKRR8JOcIZhMt9u9DUpX/2qv58UufPro6vD+7efhGy1Ip15/+fIqaGwSY/mJ5Cz0V83PofHkdlpeQajltX2OfL1oxq+g/Ek6HXgAX4oJShLVvlD3DHshTaVgv3GZkCjHWEpqMuiQ/56sReia1s+P0vOaRyEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Ugg9057o; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63D5aDfkD3690143, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776058573; bh=N1nichLoO1xsin+Oa3HlbnIKTIlelN/PjlzC21S4twA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=Ugg9057oQ2VPCKVHDK8UnA4qqTnbLinazxRljM+wJmxNgUbw9LgglqnHdtBenoNdM
	 GFyVs+T8u+G7DHa8CgHWoitRCRIEFAymwS86+EzS/vJ/2PL6hcp6hilyRBdeAub6kU
	 hMQ6VHSWBUc9l0Aicopoq5XDPcSB4mlC5ShHG5fwFKy7C5QmwLWM6+1IX2+5ZRS7T0
	 +hemGTjR4byq1wXJ5ReyahRiMfcjg/cpnBg8S4rkvzbsz0pUpTFdRiEz2a2hvbHcFT
	 LDKXjeLbZ3Z12keHjUz9QmtUCO+kYorS/w4BpTjQEGOoa3PPMtn/dtmWjwl8GxTmvx
	 Bi37epQAwEGeg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63D5aDfkD3690143
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 13:36:13 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 13 Apr 2026 13:36:13 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 13 Apr 2026 13:36:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [RFT rtw/rtw-next] wifi: rtw88: check if center channel is supported before setting
Date: Mon, 13 Apr 2026 13:36:01 +0800
Message-ID: <20260413053601.13037-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34680-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:email,realtek.com:mid]
X-Rspamd-Queue-Id: E49CC3E7810
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Some unusual center channels may be assigned to driver. However, RF
doesn't really expect them, and then warnings happen due to lack of
TX power limit configurations. For example, center channel 114/130
with 80MHz. So, add a check before setting the channel.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac80211.c |  7 +++++--
 drivers/net/wireless/realtek/rtw88/main.c     | 13 +++++++++++--
 drivers/net/wireless/realtek/rtw88/main.h     |  2 +-
 drivers/net/wireless/realtek/rtw88/phy.c      | 18 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/phy.h      |  2 ++
 5 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 766f22d31079..9d97e8dd0c1e 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -92,8 +92,11 @@ static int rtw_ops_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 		}
 	}
 
-	if (changed & IEEE80211_CONF_CHANGE_CHANNEL)
-		rtw_set_channel(rtwdev);
+	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
+		ret = rtw_set_channel(rtwdev);
+		if (ret)
+			goto out;
+	}
 
 	if ((changed & IEEE80211_CONF_CHANGE_IDLE) &&
 	    (hw->conf.flags & IEEE80211_CONF_IDLE) &&
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index cd9254370fcc..08aebb3c5a78 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -868,23 +868,30 @@ void rtw_get_channel_params(struct cfg80211_chan_def *chandef,
 	chan_params->primary_chan = channel->hw_value;
 }
 
-void rtw_set_channel(struct rtw_dev *rtwdev)
+int rtw_set_channel(struct rtw_dev *rtwdev)
 {
 	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct ieee80211_hw *hw = rtwdev->hw;
 	struct rtw_hal *hal = &rtwdev->hal;
 	struct rtw_channel_params ch_param;
 	u8 center_chan, primary_chan, bandwidth, band;
+	int ch_idx;
 
 	rtw_get_channel_params(&hw->conf.chandef, &ch_param);
 	if (WARN(ch_param.center_chan == 0, "Invalid channel\n"))
-		return;
+		return -EINVAL;
 
 	center_chan = ch_param.center_chan;
 	primary_chan = ch_param.primary_chan;
 	bandwidth = ch_param.bandwidth;
 	band = ch_param.center_chan > 14 ? RTW_BAND_5G : RTW_BAND_2G;
 
+	ch_idx = rtw_band_channel_to_idx(band, center_chan);
+	if (ch_idx < 0) {
+		rtw_warn(rtwdev, "not support band %d ch %d\n", band, center_chan);
+		return -EOPNOTSUPP;
+	}
+
 	rtw_update_channel(rtwdev, center_chan, primary_chan, band, bandwidth);
 
 	if (rtwdev->scan_info.op_chan)
@@ -910,6 +917,8 @@ void rtw_set_channel(struct rtw_dev *rtwdev)
 	 */
 	if (!test_bit(RTW_FLAG_SCANNING, rtwdev->flags))
 		rtwdev->need_rfk = true;
+
+	return 0;
 }
 
 void rtw_chip_prepare_tx(struct rtw_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 9c0b746540b0..a368f1a4a003 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -2241,7 +2241,7 @@ bool ltecoex_reg_write(struct rtw_dev *rtwdev, u16 offset, u32 value);
 void rtw_restore_reg(struct rtw_dev *rtwdev,
 		     struct rtw_backup_info *bckp, u32 num);
 void rtw_desc_to_mcsrate(u16 rate, u8 *mcs, u8 *nss);
-void rtw_set_channel(struct rtw_dev *rtwdev);
+int rtw_set_channel(struct rtw_dev *rtwdev);
 void rtw_chip_prepare_tx(struct rtw_dev *rtwdev);
 void rtw_vif_port_config(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif,
 			 u32 config);
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index e2ac5c6fd500..a543eaa57f2c 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -1630,6 +1630,24 @@ static int rtw_channel_to_idx(u8 band, u8 channel)
 	return ch_idx;
 }
 
+int rtw_band_channel_to_idx(enum rtw_supported_band band, u8 channel)
+{
+	u8 phy_band;
+
+	switch (band) {
+	case RTW_BAND_2G:
+		phy_band = PHY_BAND_2G;
+		break;
+	case RTW_BAND_5G:
+		phy_band = PHY_BAND_5G;
+		break;
+	default:
+		return -1;
+	}
+
+	return rtw_channel_to_idx(phy_band, channel);
+}
+
 static void rtw_phy_set_tx_power_limit(struct rtw_dev *rtwdev, u8 regd, u8 band,
 				       u8 bw, u8 rs, u8 ch, s8 pwr_limit)
 {
diff --git a/drivers/net/wireless/realtek/rtw88/phy.h b/drivers/net/wireless/realtek/rtw88/phy.h
index 8449936497bb..98aeb576e24d 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.h
+++ b/drivers/net/wireless/realtek/rtw88/phy.h
@@ -201,4 +201,6 @@ enum rtw_phy_cck_pd_lv {
 #define RRSR_RATE_ORDER_MAX	0xfffff
 #define RRSR_RATE_ORDER_CCK_LEN	4
 
+int rtw_band_channel_to_idx(enum rtw_supported_band band, u8 channel);
+
 #endif
-- 
2.25.1


