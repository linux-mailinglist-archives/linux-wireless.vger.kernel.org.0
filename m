Return-Path: <linux-wireless+bounces-7997-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 033A18CD003
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 12:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE34A281488
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 10:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDF013D619;
	Thu, 23 May 2024 10:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="LTVypU7F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A8313DDA3
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716458993; cv=none; b=lz6/5AzJykLY3QFvH/Ld8/i7lGejCW5wjdHMDvTXSdPHXHHqF3OR+E+3aiVGDRJlex9qG7vT7ZkrONFHZeTf8G2LDgoge3Ff+wfZzD2AzFO63b3WN2AQ2IFlQLLUTEzIZCsYiV74ANJpG1gU+N3BNKjrtII4p8YwhNjEGeZRYHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716458993; c=relaxed/simple;
	bh=+EmxFJIW48IECxL2sICud/8mBuuplJc+9hL7Ipoy5dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aKTfvEDSDgf2kv8metYd9DQexbz43J1lkD/AAP4NiEW/jqUqypGD6Gkui9Nhugdz2olKjmbVgGj5R1KZcnpTd4kQMJ0iiFxqwPKS5UjHjsRYK5KPHqnv19vABN/XAEC5qMdqiFhCuCuYrJBj/TF8SEbZBcMMIC650klThWV7F6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=LTVypU7F; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9zl61TzvLrL6KzD24LvbKZY8Sl1OP51lnOkZoeOV95I=;
	t=1716458992; x=1717668592; b=LTVypU7FIAXwT9aY/Lgml/gVYCdw2l42No9CNXxXFDUkXSM
	g97czaO6vwfF3VpnDYx44tE8WbxXha9Ksawld7WWf9I5H21BZg7MbYIS6dt+tk2oVS0FreaH5tz7p
	XfeScZlPMe5U2f/uLglkhi0Bks2AnDp8VPCQNwC1e4AoJzxyvGl4DpZyfGiMVDdhhPBb6OrRlA+AX
	EzfyUVkwHXGBH2p/iV1EKaltSdIp8IhBY/xOkr+90XySHBFt/Aqa3Rvz93B00TUaAgYE6rUiOz0Yb
	0M+b4Sui6hzo/TGCfIJ7sW3BZwYOEZBRFStJW1otQ3eFd6pzU5SjyA8AytAwlcEw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sA5OP-00000005wvn-0gzP;
	Thu, 23 May 2024 12:09:49 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 2/8] wifi: cfg80211: use BIT() for flag enums
Date: Thu, 23 May 2024 12:09:43 +0200
Message-ID: <20240523120945.c21598fbf49c.Ib8f26c5e9f508aee19fdfa1fd4b5995f084c46d4@changeid>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523120945.9a2c19a51e53.I50fa1b1a18b70f63a5095131ac23dc2e71f3d426@changeid>
References: <20240523120945.9a2c19a51e53.I50fa1b1a18b70f63a5095131ac23dc2e71f3d426@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Use BIT(x) instead of 1<<x, in part because it's mostly
missing spaces anyway, in part because it reads nicer.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h | 102 ++++++++++++++++++++---------------------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d79180bec7a1..08d49fc6a55f 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -127,31 +127,31 @@ struct wiphy;
  *	even if it is otherwise disabled.
  */
 enum ieee80211_channel_flags {
-	IEEE80211_CHAN_DISABLED		= 1<<0,
-	IEEE80211_CHAN_NO_IR		= 1<<1,
-	IEEE80211_CHAN_PSD		= 1<<2,
-	IEEE80211_CHAN_RADAR		= 1<<3,
-	IEEE80211_CHAN_NO_HT40PLUS	= 1<<4,
-	IEEE80211_CHAN_NO_HT40MINUS	= 1<<5,
-	IEEE80211_CHAN_NO_OFDM		= 1<<6,
-	IEEE80211_CHAN_NO_80MHZ		= 1<<7,
-	IEEE80211_CHAN_NO_160MHZ	= 1<<8,
-	IEEE80211_CHAN_INDOOR_ONLY	= 1<<9,
-	IEEE80211_CHAN_IR_CONCURRENT	= 1<<10,
-	IEEE80211_CHAN_NO_20MHZ		= 1<<11,
-	IEEE80211_CHAN_NO_10MHZ		= 1<<12,
-	IEEE80211_CHAN_NO_HE		= 1<<13,
-	IEEE80211_CHAN_1MHZ		= 1<<14,
-	IEEE80211_CHAN_2MHZ		= 1<<15,
-	IEEE80211_CHAN_4MHZ		= 1<<16,
-	IEEE80211_CHAN_8MHZ		= 1<<17,
-	IEEE80211_CHAN_16MHZ		= 1<<18,
-	IEEE80211_CHAN_NO_320MHZ	= 1<<19,
-	IEEE80211_CHAN_NO_EHT		= 1<<20,
-	IEEE80211_CHAN_DFS_CONCURRENT	= 1<<21,
-	IEEE80211_CHAN_NO_6GHZ_VLP_CLIENT = 1<<22,
-	IEEE80211_CHAN_NO_6GHZ_AFC_CLIENT = 1<<23,
-	IEEE80211_CHAN_CAN_MONITOR	= 1<<24,
+	IEEE80211_CHAN_DISABLED			= BIT(0),
+	IEEE80211_CHAN_NO_IR			= BIT(1),
+	IEEE80211_CHAN_PSD			= BIT(2),
+	IEEE80211_CHAN_RADAR			= BIT(3),
+	IEEE80211_CHAN_NO_HT40PLUS		= BIT(4),
+	IEEE80211_CHAN_NO_HT40MINUS		= BIT(5),
+	IEEE80211_CHAN_NO_OFDM			= BIT(6),
+	IEEE80211_CHAN_NO_80MHZ			= BIT(7),
+	IEEE80211_CHAN_NO_160MHZ		= BIT(8),
+	IEEE80211_CHAN_INDOOR_ONLY		= BIT(9),
+	IEEE80211_CHAN_IR_CONCURRENT		= BIT(10),
+	IEEE80211_CHAN_NO_20MHZ			= BIT(11),
+	IEEE80211_CHAN_NO_10MHZ			= BIT(12),
+	IEEE80211_CHAN_NO_HE			= BIT(13),
+	IEEE80211_CHAN_1MHZ			= BIT(14),
+	IEEE80211_CHAN_2MHZ			= BIT(15),
+	IEEE80211_CHAN_4MHZ			= BIT(16),
+	IEEE80211_CHAN_8MHZ			= BIT(17),
+	IEEE80211_CHAN_16MHZ			= BIT(18),
+	IEEE80211_CHAN_NO_320MHZ		= BIT(19),
+	IEEE80211_CHAN_NO_EHT			= BIT(20),
+	IEEE80211_CHAN_DFS_CONCURRENT		= BIT(21),
+	IEEE80211_CHAN_NO_6GHZ_VLP_CLIENT	= BIT(22),
+	IEEE80211_CHAN_NO_6GHZ_AFC_CLIENT	= BIT(23),
+	IEEE80211_CHAN_CAN_MONITOR		= BIT(24),
 };
 
 #define IEEE80211_CHAN_NO_HT40 \
@@ -229,13 +229,13 @@ struct ieee80211_channel {
  * @IEEE80211_RATE_SUPPORTS_10MHZ: Rate can be used in 10 MHz mode
  */
 enum ieee80211_rate_flags {
-	IEEE80211_RATE_SHORT_PREAMBLE	= 1<<0,
-	IEEE80211_RATE_MANDATORY_A	= 1<<1,
-	IEEE80211_RATE_MANDATORY_B	= 1<<2,
-	IEEE80211_RATE_MANDATORY_G	= 1<<3,
-	IEEE80211_RATE_ERP_G		= 1<<4,
-	IEEE80211_RATE_SUPPORTS_5MHZ	= 1<<5,
-	IEEE80211_RATE_SUPPORTS_10MHZ	= 1<<6,
+	IEEE80211_RATE_SHORT_PREAMBLE	= BIT(0),
+	IEEE80211_RATE_MANDATORY_A	= BIT(1),
+	IEEE80211_RATE_MANDATORY_B	= BIT(2),
+	IEEE80211_RATE_MANDATORY_G	= BIT(3),
+	IEEE80211_RATE_ERP_G		= BIT(4),
+	IEEE80211_RATE_SUPPORTS_5MHZ	= BIT(5),
+	IEEE80211_RATE_SUPPORTS_10MHZ	= BIT(6),
 };
 
 /**
@@ -1957,9 +1957,9 @@ struct rate_info {
  * @BSS_PARAM_FLAGS_SHORT_SLOT_TIME: whether short slot time is enabled
  */
 enum bss_param_flags {
-	BSS_PARAM_FLAGS_CTS_PROT	= 1<<0,
-	BSS_PARAM_FLAGS_SHORT_PREAMBLE	= 1<<1,
-	BSS_PARAM_FLAGS_SHORT_SLOT_TIME	= 1<<2,
+	BSS_PARAM_FLAGS_CTS_PROT	= BIT(0),
+	BSS_PARAM_FLAGS_SHORT_PREAMBLE	= BIT(1),
+	BSS_PARAM_FLAGS_SHORT_SLOT_TIME	= BIT(2),
 };
 
 /**
@@ -2266,13 +2266,13 @@ static inline int cfg80211_get_station(struct net_device *dev,
  * @MONITOR_FLAG_ACTIVE: active monitor, ACKs frames on its MAC address
  */
 enum monitor_flags {
-	MONITOR_FLAG_CHANGED		= 1<<__NL80211_MNTR_FLAG_INVALID,
-	MONITOR_FLAG_FCSFAIL		= 1<<NL80211_MNTR_FLAG_FCSFAIL,
-	MONITOR_FLAG_PLCPFAIL		= 1<<NL80211_MNTR_FLAG_PLCPFAIL,
-	MONITOR_FLAG_CONTROL		= 1<<NL80211_MNTR_FLAG_CONTROL,
-	MONITOR_FLAG_OTHER_BSS		= 1<<NL80211_MNTR_FLAG_OTHER_BSS,
-	MONITOR_FLAG_COOK_FRAMES	= 1<<NL80211_MNTR_FLAG_COOK_FRAMES,
-	MONITOR_FLAG_ACTIVE		= 1<<NL80211_MNTR_FLAG_ACTIVE,
+	MONITOR_FLAG_CHANGED		= BIT(__NL80211_MNTR_FLAG_INVALID),
+	MONITOR_FLAG_FCSFAIL		= BIT(NL80211_MNTR_FLAG_FCSFAIL),
+	MONITOR_FLAG_PLCPFAIL		= BIT(NL80211_MNTR_FLAG_PLCPFAIL),
+	MONITOR_FLAG_CONTROL		= BIT(NL80211_MNTR_FLAG_CONTROL),
+	MONITOR_FLAG_OTHER_BSS		= BIT(NL80211_MNTR_FLAG_OTHER_BSS),
+	MONITOR_FLAG_COOK_FRAMES	= BIT(NL80211_MNTR_FLAG_COOK_FRAMES),
+	MONITOR_FLAG_ACTIVE		= BIT(NL80211_MNTR_FLAG_ACTIVE),
 };
 
 /**
@@ -3399,15 +3399,15 @@ enum cfg80211_connect_params_changed {
  * @WIPHY_PARAM_TXQ_QUANTUM: TXQ scheduler quantum
  */
 enum wiphy_params_flags {
-	WIPHY_PARAM_RETRY_SHORT		= 1 << 0,
-	WIPHY_PARAM_RETRY_LONG		= 1 << 1,
-	WIPHY_PARAM_FRAG_THRESHOLD	= 1 << 2,
-	WIPHY_PARAM_RTS_THRESHOLD	= 1 << 3,
-	WIPHY_PARAM_COVERAGE_CLASS	= 1 << 4,
-	WIPHY_PARAM_DYN_ACK		= 1 << 5,
-	WIPHY_PARAM_TXQ_LIMIT		= 1 << 6,
-	WIPHY_PARAM_TXQ_MEMORY_LIMIT	= 1 << 7,
-	WIPHY_PARAM_TXQ_QUANTUM		= 1 << 8,
+	WIPHY_PARAM_RETRY_SHORT		= BIT(0),
+	WIPHY_PARAM_RETRY_LONG		= BIT(1),
+	WIPHY_PARAM_FRAG_THRESHOLD	= BIT(2),
+	WIPHY_PARAM_RTS_THRESHOLD	= BIT(3),
+	WIPHY_PARAM_COVERAGE_CLASS	= BIT(4),
+	WIPHY_PARAM_DYN_ACK		= BIT(5),
+	WIPHY_PARAM_TXQ_LIMIT		= BIT(6),
+	WIPHY_PARAM_TXQ_MEMORY_LIMIT	= BIT(7),
+	WIPHY_PARAM_TXQ_QUANTUM		= BIT(8),
 };
 
 #define IEEE80211_DEFAULT_AIRTIME_WEIGHT	256
-- 
2.45.1


