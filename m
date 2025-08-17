Return-Path: <linux-wireless+bounces-26410-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E148AB2927B
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Aug 2025 11:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 972BE487076
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Aug 2025 09:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E0F217F27;
	Sun, 17 Aug 2025 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PrFKH2Pq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB532264B6
	for <linux-wireless@vger.kernel.org>; Sun, 17 Aug 2025 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755423681; cv=none; b=iHsJlCdUqJN3pzpaHlSOEa602Xd2geePMzpezIpOg6fORIOcBcZDe2OMQU4759uL/Z9swwhCjghvjUzgafziAtpxmmclAuG5Nn6J6k+jGn812hA5evUrfO5QDhwf24qr92/50O0amvN0fAbRgvSIVpNZqJaVwN3OiVBfBgegycE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755423681; c=relaxed/simple;
	bh=bm9ameICTWAWG5Jy1ubG2c1dgMT+WE7ecK44cg4vl18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aeykZteCllFH+rnqLfK0f0eOMkrhgOHJ2aKzVOTiOUS68CQTGfSDpNTcxSr8KWx6d99NizGjxKBDcgCCCdjfz/Ux2isyrY31Eifn6+78Cjxdzkyr7NjG53mCL3+kqKrxSEvJb3YCYA+uOI1QAueQmVwHoZurOfoY+33ddGcbJdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PrFKH2Pq; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7e87055e1b6so478864385a.1
        for <linux-wireless@vger.kernel.org>; Sun, 17 Aug 2025 02:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755423678; x=1756028478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OrqQdkvjTypRq+PS6iMhtbiTSOtVjO39vKdw57QER4U=;
        b=PrFKH2PqEhM04WI++YIVih34vxMrA4GA0iHydR4QzCNghAJIIgH4QVuWONRycHO1oE
         rzudKdQ66DbQikKYAMBzf8qqoSGBwPKaPcZN9Wf35UlLL3eQ3VpgSWtRbPm2Z0ly2O03
         JsGbSii+dQLjw543bZ2iTzSg2JTxKpSNSxU/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755423678; x=1756028478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OrqQdkvjTypRq+PS6iMhtbiTSOtVjO39vKdw57QER4U=;
        b=JI68XudeFJNT0PYsaaqfy0TMVIBiHGZXILmnQkrS2biwm3f1+mNu2DNZDJuhNYo9m+
         LTZN2UbTw1d/L3VsmbkBcUdtzbulrBFv0y4gBbjPaaF5P2XpvfDMVixMiKfjaofl1i5i
         qqzjGj/BpZ2R15FaGVKd1oqJyz2h0cnCaAjOBPveHqd7Ajvq67BSYng5dc0+PEzIqLKj
         Rw+rB1SBz9V7Bwr0cGJeiboaJnf2e+LY7gTI+tjyqOgzuhug9vwsYtkP+4SHj/DJUVuY
         8E1fs2lUfFVeKhnjS/5QwJfdSHrVC+WLhl2VyCWfaCNv80Kk98VJdHp0ivoLWHpUhMSx
         ZPuA==
X-Gm-Message-State: AOJu0Yzix+xV/a7T2+W9i4N6QqbPQ2crAuB7LbSbJSLS4U1OH7AkL663
	8zQHjacIxnPD9Z2oG5jPz2XUmxUy/0pHHlScaW6/3qH1cLMzuHsjkgHVqJ+ctdHXregDHJagmfd
	2uw52tSHO
X-Gm-Gg: ASbGncspR4mSSEH/3C7OjXnrgsCZLgeSJTN809uGY6HBJLDnOOd0BE1cCMefqAZoeR3
	j0oRD2nQaKkgPAar6xgqpF58mMJYmFxHkFGfFsAjqetLnH77wDNF6m9BQDDjTM6gfGM0mjq8ZbN
	UDSF8/tbQmbJEO861Rn44boNrNumnPbTXKKSWrQFLe5cQzMzoc1iKSW+V3+3o8fzTKBKV1kUpwg
	g6uBAxGGjDXHdrIlJ9KruI44fcOHlkBdmAY9Z3bqFs7Mn0F0Mu2RGAwTON+Uk7nfVHOmpii2w6n
	W2+Spmn0pGdZkZKGk7cLZBxlpLuj0EiFbHGQKvOy0bXucb9xewfba/zW7K92WhLlYoCji910SCz
	QlQepKS7mIlX1r3UN80khVj1jBeX4uiWsHtAz59fqwAVzoBIcID1i2UFzwhqrvoStqF4f1kZ7y8
	l/Y6f5pcSXY9o/qXEK
X-Google-Smtp-Source: AGHT+IFvwVk+h7Dlcv6kOxr1LiU1wUTVHzxHjtA7I0O6GDc1+/eZr1qqiq6CuV/RlqsGmOgh1i8YVg==
X-Received: by 2002:a05:620a:178a:b0:7e2:23c2:e55a with SMTP id af79cd13be357-7e87e031be9mr860910985a.27.1755423677523;
        Sun, 17 Aug 2025 02:41:17 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba902f819sm35706346d6.9.2025.08.17.02.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 02:41:16 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH wl-next 2/4] wifi: drivers; indicate support for attributes in NL80211_CMD_SET_BSS
Date: Sun, 17 Aug 2025 11:41:01 +0200
Message-ID: <20250817094103.941090-3-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250817094103.941090-1-arend.vanspriel@broadcom.com>
References: <20250817094103.941090-1-arend.vanspriel@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The command NL80211_CMD_SET_BSS has a number of individual attributes
and the driver can advertise which of those it will handle when it is
changed by user-space. For drivers providing an empty .change_bss()
the callback has been removed.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 drivers/net/wireless/ath/wil6210/cfg80211.c        | 1 +
 drivers/net/wireless/microchip/wilc1000/cfg80211.c | 9 +--------
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  | 8 --------
 net/mac80211/main.c                                | 8 ++++++++
 4 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index 7703a0933a14..7218fe70f3bc 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -2708,6 +2708,7 @@ static void wil_wiphy_init(struct wiphy *wiphy)
 	wiphy->n_cipher_suites = ARRAY_SIZE(wil_cipher_suites);
 	wiphy->mgmt_stypes = wil_mgmt_stypes;
 	wiphy->features |= NL80211_FEATURE_SK_TX_STATUS;
+	wiphy->bss_param_support = WIPHY_BSS_PARAM_AP_ISOLATE;
 
 	wiphy->n_vendor_commands = ARRAY_SIZE(wil_nl80211_vendor_commands);
 	wiphy->vendor_commands = wil_nl80211_vendor_commands;
diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index a395829ebadf..a934b39c9b2e 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -794,12 +794,6 @@ static int get_station(struct wiphy *wiphy, struct net_device *dev,
 	return 0;
 }
 
-static int change_bss(struct wiphy *wiphy, struct net_device *dev,
-		      struct bss_parameters *params)
-{
-	return 0;
-}
-
 static int set_wiphy_params(struct wiphy *wiphy, int radio_idx, u32 changed)
 {
 	int ret = -EINVAL;
@@ -1670,7 +1664,7 @@ static int set_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
 }
 
 static int get_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
-			int radio_idx, unsigned int link_id, int *dbm)
+			unsigned int link_id, int *dbm)
 {
 	int ret;
 	struct wilc_vif *vif = netdev_priv(wdev->netdev);
@@ -1709,7 +1703,6 @@ static const struct cfg80211_ops wilc_cfg80211_ops = {
 	.change_station = change_station,
 	.get_station = get_station,
 	.dump_station = dump_station,
-	.change_bss = change_bss,
 	.set_wiphy_params = set_wiphy_params,
 
 	.external_auth = external_auth,
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index ac3d085808e9..315bab373729 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -2441,13 +2441,6 @@ static int	cfg80211_rtw_dump_station(struct wiphy *wiphy,
 	return ret;
 }
 
-static int	cfg80211_rtw_change_bss(struct wiphy *wiphy,
-					struct net_device *ndev,
-					struct bss_parameters *params)
-{
-	return 0;
-}
-
 void rtw_cfg80211_rx_action(struct adapter *adapter, u8 *frame, uint frame_len, const char *msg)
 {
 	s32 freq;
@@ -2704,7 +2697,6 @@ static struct cfg80211_ops rtw_cfg80211_ops = {
 	.del_station = cfg80211_rtw_del_station,
 	.change_station = cfg80211_rtw_change_station,
 	.dump_station = cfg80211_rtw_dump_station,
-	.change_bss = cfg80211_rtw_change_bss,
 
 	.mgmt_tx = cfg80211_rtw_mgmt_tx,
 };
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 9c8f18b258a6..cfa3cc4dd446 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -862,6 +862,14 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 	if (emulate_chanctx || ops->remain_on_channel)
 		wiphy->flags |= WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
 
+	wiphy->bss_param_support = WIPHY_BSS_PARAM_CTS_PROT |
+				   WIPHY_BSS_PARAM_SHORT_PREAMBLE |
+				   WIPHY_BSS_PARAM_SHORT_SLOT_TIME |
+				   WIPHY_BSS_PARAM_BASIC_RATES |
+				   WIPHY_BSS_PARAM_AP_ISOLATE |
+				   WIPHY_BSS_PARAM_HT_OPMODE |
+				   WIPHY_BSS_PARAM_P2P_CTWINDOW |
+				   WIPHY_BSS_PARAM_P2P_OPPPS;
 	wiphy->features |= NL80211_FEATURE_SK_TX_STATUS |
 			   NL80211_FEATURE_SAE |
 			   NL80211_FEATURE_HT_IBSS |
-- 
2.43.5


