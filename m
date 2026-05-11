Return-Path: <linux-wireless+bounces-36206-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uL1AIY9/AWqkbQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36206-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 09:04:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F30D9508D68
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 09:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CD413022A86
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 07:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2DE19E839;
	Mon, 11 May 2026 07:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="DY4yv8q/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1026C296BAF
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 07:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482970; cv=none; b=SXujh0+uJ7REtNVJuOg0s6DnqFRf5M9s6+Mk2OpWhjpd0SOxKmhPTy72dXUdJ53XV8gqk7VrA3uDVQgPuL2SVDen8dwQk/swHG/Bn6NUCwOb84MVFi+X15YAysqYU8k7nvYhAq+DhPlOGio9eAbIAFu5PuReShpg9/pH7h/0vgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482970; c=relaxed/simple;
	bh=d+RDwKVyyhgjTCMISY2FdVId1ni3CyR0mSm034gYqMg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bP8JGaL+iWSFXhH6Mq9mzI9lXzpWH1sQQNMLI5H9kqWsawM1YlmyjUM2sAC4+YNN8iYDRODc35CuBpCVvRlOki9mzWFYGrZB0rvJ0Dw7/g1QS1db8exrHPh8WL4eirldlFPgRlbrKlnNXKAFUxW1FG3brbbcMsprnwWexRHNOkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=DY4yv8q/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64B72kuW62540652, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778482966; bh=N4NW+wd9LECW5+ZS0z8HSZyspyvOhvpkfwlj+SvoHFs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=DY4yv8q/lhTClXyudok5iqO54iCHwbnzKQFyUqylMy/LflnOOr6KM0GmMyWoC36BG
	 jVrwj2g1C5Vo9CAavixpIRGd+NC3LXr6SPqUFRyTuuAYgGRD5CihuhKY5UL4V3YZL8
	 VAsyCK/cxmgans1lxIyiG9DLau6hbmWMp9eYpWFzSTyfVfXfRjdTWtN63T09eqppPS
	 EcOg/xwJdUwkpuJ6/Soc7oNAQjJ5k1+2N6ndQ8mgSoXN/lFnEaU6DAaIaF0KGJAJX6
	 XoeU4SFZtsPghAe6B+Zv4UUyj3+hXnSmGJ9as8HIip8hJea6tXi8rKHPlQeyyhn2wu
	 rLnE6uZpypUHQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64B72kuW62540652
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 15:02:46 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 11 May 2026 15:02:47 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 11 May 2026 15:02:47 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 11 May 2026 15:02:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 10/11] wifi: rtw89: phy: configure control options of BB wrapper by RFSI band
Date: Mon, 11 May 2026 15:01:47 +0800
Message-ID: <20260511070148.25257-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260511070148.25257-1-pkshih@realtek.com>
References: <20260511070148.25257-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: F30D9508D68
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-36206-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:email,realtek.com:mid,realtek.com:dkim];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

The settings of control options are predefined per RFSI band (2GHz band or
not 5/6GHz band) and used for fine-tuning transmit power. Calculate and set
the RFSI band once creating channel context, and use it by BB wrapper
configurations.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c     | 2 ++
 drivers/net/wireless/realtek/rtw89/core.h     | 8 ++++++++
 drivers/net/wireless/realtek/rtw89/phy.h      | 8 +-------
 drivers/net/wireless/realtek/rtw89/phy_be.c   | 5 +++--
 drivers/net/wireless/realtek/rtw89/rtw8922d.c | 2 +-
 5 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index cd846cb81f0c..6f11335b4968 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -150,6 +150,8 @@ void rtw89_chan_create(struct rtw89_chan *chan, u8 center_chan, u8 primary_chan,
 						      primary_freq);
 	chan->pri_sb_idx = rtw89_get_primary_sb_idx(center_chan, primary_chan,
 						    bandwidth);
+	chan->rfsi_band = band == RTW89_BAND_2G ? RFSI_CTRL_BAND_2GHZ :
+						  RFSI_CTRL_BAND_5_6GHZ;
 }
 
 static void _rtw89_chan_update_punctured(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ab9165fcaf7d..205087fd0161 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -993,6 +993,13 @@ enum rtw89_sc_offset {
 	RTW89_SC_40_LOWER	= 10,
 };
 
+enum rtw89_rfsi_ctrl_band {
+	RFSI_CTRL_BAND_5_6GHZ,
+	RFSI_CTRL_BAND_2GHZ,
+
+	RFSI_CTRL_BAND_NUM,
+};
+
 /* only mgd features can be added to the enum */
 enum rtw89_wow_flags {
 	RTW89_WOW_FLAG_EN_MAGIC_PKT,
@@ -1016,6 +1023,7 @@ struct rtw89_chan {
 	enum rtw89_tx_comp_band tx_comp_band;
 	enum rtw89_sc_offset pri_ch_idx;
 	u8 pri_sb_idx;
+	enum rtw89_rfsi_ctrl_band rfsi_band;
 };
 
 struct rtw89_chan_rcd {
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index bfe647b2de25..ab3c8bb2e851 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -569,13 +569,6 @@ struct rtw89_phy_rfk_log_fmt {
 	const struct rtw89_fw_element_hdr *elm[RTW89_PHY_C2H_RFK_LOG_FUNC_NUM];
 };
 
-enum rtw89_rfsi_ctrl_band {
-	RFSI_CTRL_BAND_5_6GHZ,
-	RFSI_CTRL_BAND_2GHZ,
-
-	RFSI_CTRL_BAND_NUM,
-};
-
 enum rtw89_mdpd_onoff {
 	MDPD_ON = 0,
 	MDPD_OFF = 1,
@@ -1026,6 +1019,7 @@ static inline void rtw89_phy_bb_wrap_init(struct rtw89_dev *rtwdev)
 }
 
 void rtw89_phy_bb_wrap_set_rfsi_ct_opt(struct rtw89_dev *rtwdev,
+				       enum rtw89_rfsi_ctrl_band ctrl_band,
 				       enum rtw89_phy_idx phy_idx);
 void rtw89_phy_bb_wrap_set_rfsi_bandedge_ch(struct rtw89_dev *rtwdev,
 					    const struct rtw89_chan *chan,
diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index 23ed170f6d38..387a3e5fd15a 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -646,6 +646,7 @@ static u32 rtw89_phy_bb_wrap_be_bandedge_decision(struct rtw89_dev *rtwdev,
 }
 
 void rtw89_phy_bb_wrap_set_rfsi_ct_opt(struct rtw89_dev *rtwdev,
+				       enum rtw89_rfsi_ctrl_band rfsi_band,
 				       enum rtw89_phy_idx phy_idx)
 {
 	const struct rtw89_bb_wrap_data *d = rtwdev->phy_info.bb_wrap_data;
@@ -655,7 +656,7 @@ void rtw89_phy_bb_wrap_set_rfsi_ct_opt(struct rtw89_dev *rtwdev,
 	if (!d || !d->common)
 		return;
 
-	val = d->common->bands[0].rfsi_ct_opt;
+	val = d->common->bands[rfsi_band].rfsi_ct_opt;
 
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_RFSI_CT_OPT_0_BE4, phy_idx);
 	rtw89_write32(rtwdev, reg, val[0]);
@@ -1004,7 +1005,7 @@ static void rtw89_phy_bb_wrap_tx_rfsi_ctrl_init(struct rtw89_dev *rtwdev,
 	rtw89_phy_bb_set_mdpd_qam_comp_val(rtwdev, mac_idx);
 	rtw89_phy_bb_set_cim3k_val(rtwdev, mac_idx);
 
-	rtw89_phy_bb_wrap_set_rfsi_ct_opt(rtwdev, phy_idx);
+	rtw89_phy_bb_wrap_set_rfsi_ct_opt(rtwdev, 0, phy_idx);
 
 	rtw89_entity_get_conf(rtwdev, &conf);
 	chan = conf.chans[phy_idx];
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index ec94067aa1a5..ade89234afd6 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -2284,7 +2284,7 @@ static void rtw8922d_set_channel_bb(struct rtw89_dev *rtwdev,
 	u8 pri_sb = chan->pri_sb_idx;
 	u32 val;
 
-	rtw89_phy_bb_wrap_set_rfsi_ct_opt(rtwdev, phy_idx);
+	rtw89_phy_bb_wrap_set_rfsi_ct_opt(rtwdev, chan->rfsi_band, phy_idx);
 	rtw8922d_ctrl_ch(rtwdev, chan, phy_idx);
 	rtw8922d_ctrl_bw(rtwdev, pri_sb, chan->band_width, phy_idx);
 	rtw89_phy_bb_wrap_set_rfsi_bandedge_ch(rtwdev, chan, phy_idx);
-- 
2.25.1


