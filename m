Return-Path: <linux-wireless+bounces-23682-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44943ACDA5A
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 10:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0314A1741EF
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 08:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC37228C5B5;
	Wed,  4 Jun 2025 08:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Kfwykae+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A8828C027
	for <linux-wireless@vger.kernel.org>; Wed,  4 Jun 2025 08:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749027351; cv=none; b=fsfvSgoFah3ARFzgpBaE1xkqsM2yR5bjPriTTdRjELQ2GjfJ30+5JmPCBMnzcqbN9Zbn4prmduzbN+1lBn2GGlmSZ5on2gUkMXIWLdwLrV2wD24gJkZIE3E5YAnDEmjz6W+n6qcODnPZAwZMhKrApctxo44AXGbX1bAJlbc13EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749027351; c=relaxed/simple;
	bh=JzdIFxN89UvVMLGBZu+Ng4fv3H84jeZ4S+fTBma0OJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m470Mb2BzE0Ih2SiXm1pZZKR7V75A71u16jag4VrJcRRreDV0OgdFEw34jbrJ4nQ5KwAfHHR+gx5zxB8uR1jAniZFCdolUNyJWjqjTbc1kPX11pPzaek6Ot/SvslnUUnS7Lqd18/t/fn7AB3t1s4aL6il01caeJH9ECsqXF0tjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Kfwykae+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450cfb79177so37167575e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 04 Jun 2025 01:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749027348; x=1749632148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUDlEPm6jmOZeCtkcr6viDVnpNEr9sSdhGNC+NOFhaw=;
        b=Kfwykae+hEIWxRVWTHh0JvfDhCmmBBDHiwFhsJsO8TUEtLcToK7rTURr/yVfSfeQ8U
         lQZzXcwU8yNoLLJcUEehkfcGn0BBUXlpw2Lv/ZZvqxr2G1l4cQx6D36RkDFBy267d2pB
         YRulR4Sq1OjYXoYZC4eTsKNf8ZDevoIalTA0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749027348; x=1749632148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUDlEPm6jmOZeCtkcr6viDVnpNEr9sSdhGNC+NOFhaw=;
        b=q20Rz6oIEsZFFJr+0sk76JrS46qpgFvhYTM1Y2U201C+VmpmBzvHjHkhQcKhsiWvC1
         PkiQT/Nz6A+AYhrZU+Rq5Rxveo4bRecJzfW+dvhLFrkPAzyap3Q6XJ0SUCaoRTEdNz+y
         AnNtT3WYf5ImHC83u526MEGkFr5mdcKmvwlKbjZpkEmWUxyPIntltR2fvd+6WESMRmIf
         kyYOInlYx70rx0q3Kcowvdf/B5H/9d5gTvCxebaG3HpJyep/ATxy6rQXbcOXlmjNszvX
         OrVLVTLRsay9gU8Hnio8lhBeGerrjY3iqNjDTcYZ3CD9c6yFMnM7nDa7IO4bguMC0rK8
         C8WA==
X-Gm-Message-State: AOJu0Yz47GUDX4F4x4FrBKJPVr8DlNeGhyHNphQPU/DycC5Eww3NEq83
	MybEiQqFYEPOQeeR0u+cbjdTn0u6ysfHLj6Z/13IZT7sNw9nQnsRSeY8Z5kQd0aagw==
X-Gm-Gg: ASbGnctKmQZihx5n/z0FnuMsl6YJgl9RQI7KRG7h03cWSVxeY4LkoyQ1CoJCi961JJV
	q6AWjnpaK6Zd016fecwt24GPO9OsoX007PWQBHjsyuqMsk+WXXdV0bMO2zWV6ap6buK4/X398Iv
	qHleLvmFnCcaHNUni5gcYNvhCA5GTXFXQkFmTNTWbY98bo9FXmFBX1333U9mUZul4KVJfGTyQ9f
	V2Anl4puLtNIJJ8YX+dkcNLvK5sruR1xDTjW0uKa3hQ2KHyTWmWXFxv9hCkMaOaCAf0R5BYV9c+
	7v7wJEBiEXWTBoAak6gb07alBDcfdddkTI4h86mpUSdifABAltNf93tZnL0eFFilRBddq+k4I64
	gEf8Q9nqF4vTZL2zQXOPP5LPEcyuBn+o=
X-Google-Smtp-Source: AGHT+IH2g156Dv1HcyjfP8L3Z1zZ65dH5IBSkLZk7ROj/KpJG+dfb3wAzFI6qgpgKgT0wk42MARcVg==
X-Received: by 2002:a05:600c:1e0d:b0:450:d4a6:799e with SMTP id 5b1f17b1804b1-451f0b105eemr11988725e9.20.1749027348207;
        Wed, 04 Jun 2025 01:55:48 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fb09a3sm189165695e9.24.2025.06.04.01.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 01:55:46 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [RFC 2/4] wifi: drivers; indicate support for attributes in NL80211_CMD_SET_BSS
Date: Wed,  4 Jun 2025 10:55:36 +0200
Message-ID: <20250604085539.2803896-3-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250604085539.2803896-1-arend.vanspriel@broadcom.com>
References: <20250604085539.2803896-1-arend.vanspriel@broadcom.com>
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
 drivers/net/wireless/microchip/wilc1000/cfg80211.c | 7 -------
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  | 8 --------
 net/mac80211/main.c                                | 1 +
 4 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index 5473c01cbe66..d1e8beebd148 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -2707,6 +2707,7 @@ static void wil_wiphy_init(struct wiphy *wiphy)
 	wiphy->n_cipher_suites = ARRAY_SIZE(wil_cipher_suites);
 	wiphy->mgmt_stypes = wil_mgmt_stypes;
 	wiphy->features |= NL80211_FEATURE_SK_TX_STATUS;
+	wiphy->bss_param_support = WIPHY_BSS_PARAM_AP_ISOLATE;
 
 	wiphy->n_vendor_commands = ARRAY_SIZE(wil_nl80211_vendor_commands);
 	wiphy->vendor_commands = wil_nl80211_vendor_commands;
diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index e7aa0f991923..4d2ffb009d7e 100644
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
 static int set_wiphy_params(struct wiphy *wiphy, u32 changed)
 {
 	int ret = -EINVAL;
@@ -1708,7 +1702,6 @@ static const struct cfg80211_ops wilc_cfg80211_ops = {
 	.change_station = change_station,
 	.get_station = get_station,
 	.dump_station = dump_station,
-	.change_bss = change_bss,
 	.set_wiphy_params = set_wiphy_params,
 
 	.external_auth = external_auth,
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 7fcc46a0bb48..21d3dbb2531d 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -2439,13 +2439,6 @@ static int	cfg80211_rtw_dump_station(struct wiphy *wiphy,
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
@@ -2702,7 +2695,6 @@ static struct cfg80211_ops rtw_cfg80211_ops = {
 	.del_station = cfg80211_rtw_del_station,
 	.change_station = cfg80211_rtw_change_station,
 	.dump_station = cfg80211_rtw_dump_station,
-	.change_bss = cfg80211_rtw_change_bss,
 
 	.mgmt_tx = cfg80211_rtw_mgmt_tx,
 };
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 6b6de43d9420..72bb443683a5 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -850,6 +850,7 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 	if (emulate_chanctx || ops->remain_on_channel)
 		wiphy->flags |= WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
 
+	wiphy->bss_param_support = WIPHY_BSS_PARAM_MASK;
 	wiphy->features |= NL80211_FEATURE_SK_TX_STATUS |
 			   NL80211_FEATURE_SAE |
 			   NL80211_FEATURE_HT_IBSS |
-- 
2.43.5


