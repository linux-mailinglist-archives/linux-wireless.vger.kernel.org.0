Return-Path: <linux-wireless+bounces-23684-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA37CACDA5E
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 10:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B113E1895AEB
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 08:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4243D28C5AA;
	Wed,  4 Jun 2025 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UU6MD+lw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B00228C5CB
	for <linux-wireless@vger.kernel.org>; Wed,  4 Jun 2025 08:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749027354; cv=none; b=L+CMeqsWpQt6duJIQnMvrFXRLcQmE0hXrno/02ACONtgtPewoqZOmy/luIkwu0TOM2KPcG77xf9zlcDBdOeKxyEkXntQZ4KTOre1yDjz99PejKsfIVOTKOZO2JX4cZ1ovlAPWtLCgRLganPOc+oW0k7jdMvheWeOSjF4dnt/A6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749027354; c=relaxed/simple;
	bh=z6WEaSRRzmSUi0Q6zekoyJ82yGWKQJ5PgojomGPJGfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLdYoiv6nAc+yzGNRoGgC3YbHU9M43eGuIMNNCYg06ukEd66FI1E5UT4WQLbhp4uOw3QsSTsSoEVAoeGSVClOkt9UXuUXEepipF1AkJmYeT41wLHJOaWL76Ps4tJoutx/sfKdHUOVeTgn9p9dpWconVm1bJpmEktopB+HR5Q2eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UU6MD+lw; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-450cf214200so60840445e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 04 Jun 2025 01:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749027351; x=1749632151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npln1rqDrgl1K+9nJWKc53Wj/RcZI65TJQM3/tL+eGk=;
        b=UU6MD+lwiuhrCKnS61eZGig0veumN1mZlFdS6zwh1Dsy5cGRzXV8YAYgA74Pg8mu8u
         ukEFM4SF04IHSGv0EvhdsGKByD10ncCN5UKu6csCHA26eQ62wM203ZUoRMW4xZMXTsgM
         BB7fwMDeFl0kKeJOgjVJcjF4pllOjo3UvZ+hY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749027351; x=1749632151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npln1rqDrgl1K+9nJWKc53Wj/RcZI65TJQM3/tL+eGk=;
        b=BO9sX1IQGHyVPP1vS2N2ZRD4s2/ajJHoW0Pn5z+cb+ioBJ9IZ700/+zJZZAhpJrQUq
         N5Bfl1+SSTdj2DJYDlnC3JwjtFD5rWFNa1k9H/K+WrrvLU4dC2rb2TV8p7N1B3AnSin9
         q/x7l3PRgvMne/PA3mcmtEqcuVCuHRPowY39qvvLtFVsbS+qM31GW9voP0EpbgfDTfUm
         EtqtIE2qaRFC1xO6TnOOaJs4C2/Onm/gl/bT23cIe6Wv4YTG/7l/EDwOw2hspaN0zI4e
         /RPk9J7gumhS/tnDLSoryq/ApvkufICjhJ6CDLsZuRlb8kIDW5ws4ju+QFaM6x+zS2zq
         Ca/w==
X-Gm-Message-State: AOJu0Yz9xBIFBvloYP9QmTeHP/Je17GVBpb6qVcAxzwU6cBLfWeog4Rk
	ToZ81/XiEzi15Jfq6kgH2nU9QSAAJ3H/TBqE0abDqzd1j0nxas6kSmEA7OyMgTl2SQ==
X-Gm-Gg: ASbGncvSAizXijGoSplWoGrvKpGSf/bAdRRLHh9/QpVpqpILtq9VVZ/Hgi4OGzjqsKb
	B1HIAZKolhFfLklloTHWxeft+xU1stnqBMJZf2MjjTpmxiV5nwwYo+6GdJ/lY3iQMu0h76q/ZSN
	yZSTla5HYqb0zbIQKO0yREm4PWywloDXe90WkyhBI59z7DCqMq2YxH1L2QwZDfXub4CEADDcN2G
	fx6LYU6l9cVixTzBSOMKXOnuJpX6N7Q+jmCbbLMaDK9AWR36nsiSWdjI3kKQfcKoJTQY3/K/E9B
	KGDpfRnP2nA5YYIXl5HmapL4Mb7bSgm8yQU77GezWX9tN5YFB9S7ewFOrkcuQcarV/gm8/GEwnH
	RTFUQDt082NjJHgg9iZek6MYK+E5g3rs=
X-Google-Smtp-Source: AGHT+IGTMDZ6DOndio2bUo3XCz1JdKR3tgUwpoqpklu4SnkC8jdsv/XAXk7JuUEjc4UpllYz/1Udbg==
X-Received: by 2002:a05:600c:a14:b0:43d:fa59:be39 with SMTP id 5b1f17b1804b1-451f0b3d270mr14442625e9.33.1749027350745;
        Wed, 04 Jun 2025 01:55:50 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fb09a3sm189165695e9.24.2025.06.04.01.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 01:55:49 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Wright Feng <wright.feng@cypress.com>,
	Chi-hsien Lin <chi-hsien.lin@cypress.com>,
	Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [RFC 4/4] brcmfmac: support AP isolation to restrict reachability between stations
Date: Wed,  4 Jun 2025 10:55:38 +0200
Message-ID: <20250604085539.2803896-5-arend.vanspriel@broadcom.com>
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

From: Wright Feng <wright.feng@cypress.com>

hostapd & wpa_supplicant userspace daemons exposes an AP mode specific
config file parameter "ap_isolate" to the user, which is used to control
low-level bridging of frames between the stations associated in the BSS.

In driver, handle this user setting in the newly defined cfg80211_ops
function brcmf_cfg80211_change_bss() by enabling "ap_isolate" IOVAR in
the firmware.

In AP mode, the "ap_isolate" value from the cfg80211 layer represents,
 0 = allow low-level bridging of frames between associated stations
 1 = restrict low-level bridging of frames to isolate associated stations
-1 = do not change existing setting

Signed-off-by: Wright Feng <wright.feng@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
[arend: indicate ap_isolate support in struct wiphy::bss_param_support]
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index dc2383faddd1..d6c8ad7ebced 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5933,6 +5933,26 @@ static int brcmf_cfg80211_del_pmk(struct wiphy *wiphy, struct net_device *dev,
 	return brcmf_set_pmk(ifp, NULL, 0);
 }
 
+static int brcmf_cfg80211_change_bss(struct wiphy *wiphy, struct net_device *dev,
+				     struct bss_parameters *params)
+{
+	struct brcmf_if *ifp = netdev_priv(dev);
+	int ret = 0;
+
+	/* In AP mode, the "ap_isolate" value represents
+	 *  0 = allow low-level bridging of frames between associated stations
+	 *  1 = restrict low-level bridging of frames to isolate associated stations
+	 * -1 = do not change existing setting
+	 */
+	if (params->ap_isolate >= 0) {
+		ret = brcmf_fil_iovar_int_set(ifp, "ap_isolate", params->ap_isolate);
+		if (ret < 0)
+			brcmf_err("ap_isolate iovar failed: ret=%d\n", ret);
+	}
+
+	return ret;
+}
+
 static struct cfg80211_ops brcmf_cfg80211_ops = {
 	.add_virtual_intf = brcmf_cfg80211_add_iface,
 	.del_virtual_intf = brcmf_cfg80211_del_iface,
@@ -5980,6 +6000,7 @@ static struct cfg80211_ops brcmf_cfg80211_ops = {
 	.update_connect_params = brcmf_cfg80211_update_conn_params,
 	.set_pmk = brcmf_cfg80211_set_pmk,
 	.del_pmk = brcmf_cfg80211_del_pmk,
+	.change_bss = brcmf_cfg80211_change_bss,
 };
 
 struct cfg80211_ops *brcmf_cfg80211_get_ops(struct brcmf_mp_device *settings)
@@ -7634,6 +7655,9 @@ static int brcmf_setup_wiphy(struct wiphy *wiphy, struct brcmf_if *ifp)
 				    BIT(NL80211_BSS_SELECT_ATTR_BAND_PREF) |
 				    BIT(NL80211_BSS_SELECT_ATTR_RSSI_ADJUST);
 
+
+	wiphy->bss_param_support = WIPHY_BSS_PARAM_AP_ISOLATE;
+
 	wiphy->flags |= WIPHY_FLAG_NETNS_OK |
 			WIPHY_FLAG_PS_ON_BY_DEFAULT |
 			WIPHY_FLAG_HAVE_AP_SME |
-- 
2.43.5


