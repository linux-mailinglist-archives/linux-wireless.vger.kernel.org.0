Return-Path: <linux-wireless+bounces-35801-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIiCJzgl+GmnqwIAu9opvQ
	(envelope-from <linux-wireless+bounces-35801-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 06:48:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DD54B8603
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 06:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C6773016C94
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 04:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A088D242925;
	Mon,  4 May 2026 04:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pH0F3FaW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96F221FF2E
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 04:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777870108; cv=none; b=bU40V5BvwXNZD69O+BQQHM9RtnlkCJH0z1w2kgZww08CRTwusm8k5/RyqG74+/pHWb3+efQc6Wz4/0VmXzl8p4Y1mKFUdAjwU7biCrARIopxIK/5lY2JUBgNYbL5RPJ4oBFCm+6b00ozEiIbx4pSlgoaYcfMjwRlRXxxI+ryp38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777870108; c=relaxed/simple;
	bh=xqkSirLZqyNtcti7euJFTit/ZGv+eCnKNp7Q8uuaLKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bh9Qr8UFZpC04EkMKXbkMTJx8lHYFGu7xxGA2P3L6QYTXdMDI1Ogq9+/Xoar+AVu/2NklLu592phcFLLpovKjnRd6EcV2NEWSIPSKzrFAcSSnx6WEc8A9HOX1b5uvsyUq+YkDs4lMBb5hI+dBPTah0cf2TEzGC+e2At01cscCYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pH0F3FaW; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4891cd41959so29116565e9.3
        for <linux-wireless@vger.kernel.org>; Sun, 03 May 2026 21:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777870105; x=1778474905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AV1IbUfw7RgigkpPNoxjPUh81DhbbqeKlGyNH4H9r2s=;
        b=pH0F3FaW+IXVZQI3GKXSeC4llDCRvYi1E39WPY9e0WEsZCyD72I45geF0Hg7dHidkM
         h24KmVKQOeU16ml3LMPIvXQHDoIVTmbDF9PLqudKYCvQ+SkPWwrMzrw0gItxT2JSneOm
         W5SVsjsUKQ4HfJj/K+qog7XR6xdQ7VhW0DpIZcpKmzQFooloKbFOOCCG2XB7MDWU41fJ
         8HMwyO5mmvaLRNNfRC1YL5nh3kh3pbuOmQMirwL8hTBJ8xjf2N9mZGTVDjGPQ8e5rTbb
         DDLwWSZmt1DDH/fEBkoNpyIExUIYgXuYTlpAS2SSKq4pTsYPkUzJD7bvAmwyrpzL6Ky2
         /+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777870105; x=1778474905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AV1IbUfw7RgigkpPNoxjPUh81DhbbqeKlGyNH4H9r2s=;
        b=ED81GlP6kD8e0ZHegNQSS/ptNUdQIz1BO2O5Qk+r7bvUK2MIeG4zlhQZTd0fb0qQ5i
         o+dEoVbdvup8qe2R1bo70AyoHt8ovhVzPXY4Q7IDoVx8BeQnwLlGfnwKEXEF+oT7Ozl4
         5Yn/0iowUVFvx02iakh5fZ7UGhr0dNJQRqF4lXzj9qWd1+fJIsdsIRpApi+pcfLvQ9yA
         FMkS0vDRJIeqBe5hg49meLe3JN62QOoBm1HYnHJ7iw1jFWe3Mb8wwFtmi1evqfcjnkWQ
         8fyJ1mdeLsLgajPYJpz2qCo8i6O+zS/TT1TNmQWI5Z5KWsIIvVJwMk1vD2IKXL19P/3a
         LyXw==
X-Gm-Message-State: AOJu0Yw+b/yjY1ClWxTxjj00WUVEF6cONZjiC8xSnLoBs7GeC62HGcn5
	Mlq0N/FhDAYG52j4UoxbbJ4rJ4+3BIRs41UDp7A+JTi3GHRCCXzKbkyj
X-Gm-Gg: AeBDievdNpX8hkTQL0cb8sx6pPQwGO1v8fy15rbnDf64jxIlTSI5OCXUBrOfUSbXMOc
	RuG0UjKdq3pH7+8iuIJ1wyC/z8Rtrclo/zsaM4vixtjLvbGjy8p/GObOtYYzcg3AdaBKErOFofI
	OY0yv7VEtky7EPZb257c7HSBTtap3K7O8mjXeajMhx7Fh7tB8qmYeWh7QPZrF6vbjmuL0gmRIw6
	EAkRjk3qKgWE1oC0KmZNIrT0ymLRqDYrmb3hgo1n38op/4aQtCwVtOR70Vcj+MzXbXHhJDwpC1r
	wulZdaIyh8yNKrcO2XFtVpaAYi2UrcBp+BTe4QHd8l6Wkj6veq6VYZybfbYucI4kcRyWVpNTs90
	PqERmlUSE2sw4ddl1kdMsnwAK7edd9kUfn8vOuVzTUo7JE+QJwa+TZ0ku16AzHIU3rO6iRfByCF
	XK3brgVPc+6FDeBtOn513MS5lR5mWmeycmO2jeCv5FAWM7sE+se1ueeOm0nQ==
X-Received: by 2002:a05:600c:8590:b0:485:7f02:afd5 with SMTP id 5b1f17b1804b1-48a98658a1dmr99553065e9.13.1777870105147;
        Sun, 03 May 2026 21:48:25 -0700 (PDT)
Received: from localhost ([102.128.173.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb72a17sm248742425e9.6.2026.05.03.21.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 21:48:24 -0700 (PDT)
From: Louis Kotze <loukot@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Louis Kotze <loukot@gmail.com>
Subject: [PATCH 1/4] wifi: rtw89: advertise EML Capabilities and Restricted TWT for 8922a
Date: Mon,  4 May 2026 06:48:14 +0200
Message-ID: <4da8b66602471a76c043c0066ee6ebb3aa2bc696.1777832019.git.loukot@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1777832019.git.loukot@gmail.com>
References: <cover.1777832019.git.loukot@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 00DD54B8603
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35801-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loukot@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Wi-Fi Alliance Certificate WFA129313 (RTL8922AE 802.11be and Bluetooth
combo module, 2024-05-23, FW 6102.24.109.0) certifies EMLSR (Enhanced
Multilink Single-Radio) and STR (Simultaneous Transmit and Receive) for
this chip. The driver currently sets eml_capabilities = 0 and
mld_capa_and_ops = 0 in the Station iftype-ext-cap, which prevents the
AP from negotiating EMLSR mode with this STA — multi-link association
either falls back to MLSR (single-link) or fails entirely.

Populate eml_capabilities with IEEE80211_EML_CAP_EMLSR_SUPP plus
EML padding delay (256 us, IEEE80211_EML_CAP_EML_PADDING_DELAY_256US
since commit 5858f5e1588f ("wifi: Rename EMLSR delay constants and
add EMLMR helpers and definitions")) and EMLSR transition delay
(32 us) to match the EMLSR negotiation parameters Realtek's
certified silicon supports.
mld_capa_and_ops is left at 0 (= MAX_SIMUL_LINKS field 0 = "1 max
simultaneous link"), consistent with the EMLSR-only operating mode the
driver implements per enum rtw89_mlo_mode {MLSR, EMLSR} (no STR mode
in the driver despite WFA-cert silicon support).

Also add IEEE80211_EHT_MAC_CAP0_RESTRICTED_TWT to mac_cap_info[0].
The RTL8922A EHT MAC supports R-TWT for latency-sensitive scheduling;
the cap bit was hard-zeroed alongside the other EHT mac/phy caps in
rtw89_init_eht_cap().

Tested on RTL8922AU (USB variant, same MAC + RF as cert'd PCIe AE)
against TP-Link Deco BE63 mesh: dual-link MLO assoc works
(active_links = 0x4 confirms expected EMLSR mode, Link 2 / 6 GHz
active), 60h+ stable association, 11/11 wifi-health-check probes
pass, no kernel warnings or wpa_supplicant errors.

Note on EMLMR (EML Cap bit 7, IEEE80211_EML_CAP_EMLMR_SUPPORT): not
advertised. The WFA cert does NOT list EMLMR for this chip.
RTL8922A has rf_path_num=2 (single 2T2R RF block shared across 2.4,
5, 6 GHz), and the driver has no EMLMR enum, firmware H2C path, or
PHY register block. EMLSR is the architectural ceiling for this
silicon.

Link: https://api.cert.wi-fi.org/api/certificate/download/public?variantId=129706 [WFA cert WFA129313]
Signed-off-by: Louis Kotze <loukot@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 70feab97dccb..056639db1dfa 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -217,7 +217,10 @@ static const struct wiphy_iftype_ext_capab rtw89_iftypes_ext_capa[] = {
 		.extended_capabilities_mask = rtw89_ext_capa_sta,
 		.extended_capabilities_len = sizeof(rtw89_ext_capa_sta),
 		/* relevant only if EHT is supported */
-		.eml_capabilities = 0,
+		.eml_capabilities =
+			IEEE80211_EML_CAP_EMLSR_SUPP |
+			(IEEE80211_EML_CAP_EML_PADDING_DELAY_256US << 1) |
+			(IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_32US << 4),
 		.mld_capa_and_ops = 0,
 	},
 };
@@ -5557,7 +5560,8 @@ static void rtw89_init_eht_cap(struct rtw89_dev *rtwdev,
 
 	eht_cap_elem->mac_cap_info[0] =
 		u8_encode_bits(chip->max_eht_mpdu_cap,
-			       IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_MASK);
+			       IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_MASK) |
+		IEEE80211_EHT_MAC_CAP0_RESTRICTED_TWT;
 	eht_cap_elem->mac_cap_info[1] = 0;
 
 	eht_cap_elem->phy_cap_info[0] =
-- 
2.54.0


