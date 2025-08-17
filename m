Return-Path: <linux-wireless+bounces-26420-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E28B294D8
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Aug 2025 21:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF1DE5E193D
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Aug 2025 19:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07134221F0A;
	Sun, 17 Aug 2025 19:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="h3Xv9omE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C25221DB3
	for <linux-wireless@vger.kernel.org>; Sun, 17 Aug 2025 19:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755457500; cv=none; b=PKJ5RbBik35S2jpnT3BJBiusWmNpQqHP1DpxsaN+HDs+5ZwDGhPp1GqDVgISsuyIdsuS/AvZjHHv4u5uMVN0ajAKKxAhR7FNeHy04rjFBVuFPCS9em6XUDJdO0rKv8EOotoGXqenpaT+eFusNyulYWsyFm4aHBHb7HRuc5Fz3Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755457500; c=relaxed/simple;
	bh=P9eYuguAdZNzFRTrX57uaX3Xip1RK5VzuqN3gvKRNMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0fIMNZLnPo7KKCvSKJuHpcElvEqijlXE+CjpoqTY1+xNyGeyI00EA9gdwOhC9hNlcLfF4V4Xgw34xkdWDwOEwqebiHxb67ljLAYzziw2xyan3POsfA93PvoNxOboZA81/cSBiMGaPisDkTIg3paoNI6Lnh0kFsBQsCs52cllPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=h3Xv9omE; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b1099192b0so57594211cf.0
        for <linux-wireless@vger.kernel.org>; Sun, 17 Aug 2025 12:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755457498; x=1756062298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vppjgRt0sdRKtKXtygDz2yLmHtOPZjyKaaW7vcL4qfE=;
        b=h3Xv9omEWDaxOngsEy/hp8L4jLhtqHqC47QQyIXuCC1PY2n9YLzmJh297XJHqhGUyB
         ezXezeV6bHCIT3P0ZjVNXTInVVPVPU73i7e33959ybEFZt0MNsglWQDqsp2SUB8h8VT6
         dXd1CJPbUpDaJ4Y5uRQyW844qv5BExwgQ0O0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755457498; x=1756062298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vppjgRt0sdRKtKXtygDz2yLmHtOPZjyKaaW7vcL4qfE=;
        b=QDlrrjFsVTRU3NIBNJI96DaCFh4BxkBq57zJJZmFrMdsgF+Rz+zh81hvoBJvc9P9wL
         l9pOvfvoZv5Ow1oW0fCqi6xa4LOXDP/GD7k4RazOkuLSCzvuTV4q3UnCCk0cgcnlQO7R
         tqhjJzhfD64vxWwjcnXmrp8c4QiJEApLgF+oKmdH54bereqC6kT2AKZKwmuPnqccPPfG
         7jYcBlkfPvkRk2IkOF7ifIo8/1sDHoJ7zbbziN5lZBp5XHiIh1sdGsApSSmii5F7f+kz
         cCUZckf09YaDQbIELd2od5dmocrEqLQ+X7SWYi/IinEHp4ImA7ZKcd+83SjZiNpNmdRE
         AoZA==
X-Gm-Message-State: AOJu0Yw2Zsx2qBq9fhRuPehij4+4XO0KQGVXoZnvCeqfGuV++kQ4kZMj
	gySuu/DNEXqu43ZSq7bULxncixoFdcnPbqjiVTQRxdsAOeiyM1ZHry6oxm+2MMUF7W57QOpdZJU
	16wmT5Cqy
X-Gm-Gg: ASbGncvHswkb6Jp1piPh2MnwORhjE+Fq7Stmo713pE/UKN2a360vuGTd/+nO2Xg0WZS
	vChXn4UpphPnHnmzCvMbN3/NhwI3z0PIygiaVHeepRwiHeyGbCldcObNggoiBw2tpREjqEhtoAJ
	gv/DIe0eUmPHevTFGRJ5wPFTW1LHnb5eKWIeyZahP/g8j9z74H/EK0Br6AZp46t72Tksi10r3oC
	U5maf5zYkK2GSeYmuIo0bVLpPnQBZlasB0+H+Bpc90Euz9xorpDu7AajBc7Cqqc7C3tfHRLg79n
	d4HPyRb8Q8XSpCsDg075OKZZQe8DY4uWaBB1zC04LSV6Joy8+w+jqxhVjiUieclc2y0zZ7L0ldA
	F7rwwsFNXNuc2hV1h9P3jhsbhBjkrbFbO5aMDFKCeZ6kDpwn01moZEgWZzUPZvL+VErhXZk89+t
	rCpAICO3h20T03CvLl
X-Google-Smtp-Source: AGHT+IHUMkAK6BwidCsZPGQssLj0B/NoURQu+mf9bEy9g+tXqmDKGvXjG7+tfqkShGYV6sXz0pdlKg==
X-Received: by 2002:a05:622a:4d4d:b0:4af:c0b6:b297 with SMTP id d75a77b69052e-4b11e363f7fmr149063871cf.50.1755457498216;
        Sun, 17 Aug 2025 12:04:58 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11de50b31sm40382461cf.51.2025.08.17.12.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 12:04:57 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Wright Feng <wright.feng@cypress.com>,
	Chi-hsien Lin <chi-hsien.lin@cypress.com>,
	Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH wireless-next v2 4/4] wifi: brcmfmac: support AP isolation to restrict reachability between stations
Date: Sun, 17 Aug 2025 21:04:35 +0200
Message-ID: <20250817190435.1495094-5-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250817190435.1495094-1-arend.vanspriel@broadcom.com>
References: <20250817190435.1495094-1-arend.vanspriel@broadcom.com>
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
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 8af402555b5e..8afaffe31031 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5958,6 +5958,26 @@ static int brcmf_cfg80211_del_pmk(struct wiphy *wiphy, struct net_device *dev,
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
@@ -6005,6 +6025,7 @@ static struct cfg80211_ops brcmf_cfg80211_ops = {
 	.update_connect_params = brcmf_cfg80211_update_conn_params,
 	.set_pmk = brcmf_cfg80211_set_pmk,
 	.del_pmk = brcmf_cfg80211_del_pmk,
+	.change_bss = brcmf_cfg80211_change_bss,
 };
 
 struct cfg80211_ops *brcmf_cfg80211_get_ops(struct brcmf_mp_device *settings)
@@ -7659,6 +7680,8 @@ static int brcmf_setup_wiphy(struct wiphy *wiphy, struct brcmf_if *ifp)
 				    BIT(NL80211_BSS_SELECT_ATTR_BAND_PREF) |
 				    BIT(NL80211_BSS_SELECT_ATTR_RSSI_ADJUST);
 
+	wiphy->bss_param_support = WIPHY_BSS_PARAM_AP_ISOLATE;
+
 	wiphy->flags |= WIPHY_FLAG_NETNS_OK |
 			WIPHY_FLAG_PS_ON_BY_DEFAULT |
 			WIPHY_FLAG_HAVE_AP_SME |
-- 
2.43.5


