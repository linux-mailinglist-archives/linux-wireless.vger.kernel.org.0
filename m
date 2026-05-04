Return-Path: <linux-wireless+bounces-35802-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHrjCTAl+GmnqwIAu9opvQ
	(envelope-from <linux-wireless+bounces-35802-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 06:48:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E4B4B85F4
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 06:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B74633005320
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 04:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4365121A457;
	Mon,  4 May 2026 04:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9N0K28L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7CD22E3F0
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 04:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777870112; cv=none; b=G+AY4yeiTyyoExFBuif+Q5hesIkxK2EKxtA/fVftrR0oviu4SmalebPiWs5Z6s2j3emlgJWk3/syRqLNYIJAbBKuPJg7PDeMwmlUkZTYxwKQBtx6031MZWCj3VUygd5gtOsuDCJYhXqshgolTDzHImMgc6H67mkIhYuVHrM13VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777870112; c=relaxed/simple;
	bh=Fw3kNL7Ljp8t5qwpra4MbVRF0/mLJcHTu2HsuGtN4L8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFTkaFIkh/CK6nSOHJw/GObkGK+CJwS7VpOd6y9dNly68UBilrHe7tpfKos9fcs8RKnt6YSlb0HCi633WJLm+pEH1CTM0O8hJiXe1TNhy5lOE+5aUUvH4rcvomimMa7mv0WvvF2nfpjZ9b8jiACQv/UQhhYcW+wCCXqstpNIAwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o9N0K28L; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso24945595e9.1
        for <linux-wireless@vger.kernel.org>; Sun, 03 May 2026 21:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777870109; x=1778474909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egca39AIszzEyh+/4AOU9az5GVxYBh/JNz33o5XWs4o=;
        b=o9N0K28LmONKuvLpz1ifwkbYrM+lxd+kW2mWDho4uOCSiDe0FldVMaDKHuFnrl72as
         P9RW8enNeGIgQI8x0dmSAmHvBgguKx9XWmbmDQIryTCh7zRYTYN4sQYs0JKdiqrCkWNc
         me7oMqluJsy+EJUXqe0psi5ombiCWwoKP5wv1JlZUixGDaTyyPpbITMWgNZXdxgZSpN/
         0VB7yyL5lcKQd/U/uV6F92mtbTST3Yj840Q2h7VhDwBYIE2gZnrvjszJ4Qx+IQ8SfbFm
         +n5Gqn6xOlZ+PDAOAR8qphFnYVEgLqoExgwgi7m7bp7Q3Ny/0srTKd9L8KNQrn7odRuY
         Oq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777870109; x=1778474909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=egca39AIszzEyh+/4AOU9az5GVxYBh/JNz33o5XWs4o=;
        b=AJ7tWCbnUzBKqq3GmZPFaSNmn/8b036A+W/dufdPM9+XavbaZfOYIkaFod8ysllQ01
         1A2e0ft6Hg5LOyKB3geEHA/4OUs0e+TaGwipOu4Z2DrUJ62EzpxGmvp2LyroDmyX78jz
         lsWmBIHbtgW8aMNMpXH0Z/LiRNuCP3yFgd9ndW8lT5/SKYcvvKHOeJ17X3QLU5//8sbM
         zeO38dnYv3NUaRuRu+6kcrddNQgAC/E9FGAom49I+93Lapg6Me1t47sP80R1JYhhIubS
         oJW0DYVLPWVup5V4K8ApEi9Pd3u9Wbxk5oSnnDJjmkj45VPwxQfV5DqQVjthHILP3oDg
         fn7Q==
X-Gm-Message-State: AOJu0YzSXd+LILkCOtzsNvxBNq4+u0R+DG9C8TsKgRanMurIxfTVQDDk
	WU1BRwWRVB8DgR90pzBq84lhKaDzEGM2WADQRvDgMTII45J4l8ahFgogDJOqHUUpxgc=
X-Gm-Gg: AeBDiev0A4yl25flgc+DrRoDYw/axDR8i0HW2DntaIoxgeXzSWLVwOLNrwq+Cs7DwXp
	jFMj+ZAaKMZG9WL1Dv4YTKL0lZzU6gn4Ti7UJVMYzLy9wXpDkkrvP5w0kbCzcPPeXGjyNGDsUvG
	5vdizD6f7oh4a06dU3TVpo6O3GGXgiOz9l576PA7rKQIHdXliKOvc9K447QDuWxJ4l3C25tuQLS
	1+m7i6DMJIDZw7wgqj/Ts1bTQVzqwGVfxqABqr/xzGiFP1jjkHiDmRoAepJNDG39hyekVOQu5ve
	FDk72LzAzxvtQFiSOENasS0R+wf52E5acmlOY0qDGsPwhXSOGfnNwvdhPZwWswjwpJx756pcgLg
	wfLN7gqZ/EY8gsv5jFXipaxFOFTeWku4Jwp/Bl/0aDx4NucG5OJzLqk+qgzAOWP9Sq8XtXajkWx
	0ow/Om4DrjwLeQ31XVw6Uf9xDEZk/qr3VAo+Bub7vCfNE3y5I9hVRqyiV9gw==
X-Received: by 2002:a05:600c:4f47:b0:488:b8bc:6a32 with SMTP id 5b1f17b1804b1-48a988be27dmr148921755e9.23.1777870109022;
        Sun, 03 May 2026 21:48:29 -0700 (PDT)
Received: from localhost ([102.128.173.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb75fe8sm246100565e9.8.2026.05.03.21.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 21:48:28 -0700 (PDT)
From: Louis Kotze <loukot@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Louis Kotze <loukot@gmail.com>
Subject: [PATCH 2/4] wifi: rtw89: advertise Multi-RU OFDMA receive for 8922a per WFA cert
Date: Mon,  4 May 2026 06:48:15 +0200
Message-ID: <fe55fcddbbb3dcf41f77376795ab68024007256b.1777832019.git.loukot@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1777832019.git.loukot@gmail.com>
References: <cover.1777832019.git.loukot@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 20E4B4B85F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-35802-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loukot@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Wi-Fi Alliance Certificate WFA129313 (RTL8922AE, 2024-05-23, firmware
6102.24.109.0) attests "Multi-RU" as a certified Wi-Fi 7 feature for
this chip. The driver currently hard-zeroes the corresponding receive
cap bit in rtw89_init_eht_cap(), which prevents the AP from scheduling
Multi-RU OFDMA TBF (Trigger-Based Frame) payloads with sub-242-tone RU
allocations to this STA.

Set IEEE80211_EHT_PHY_CAP5_RX_LESS_242_TONE_RU_SUPP in phy_cap_info[5]
to match the certified silicon behaviour. The Tx-side bit
(CAP5_TX_LESS_242_TONE_RU_SUPP) remains zero since this driver is
STA-mode only and Tx of Multi-RU TBFs is an AP-mode capability.

Tested on RTL8922AU (USB variant, same MAC + RF as cert'd PCIe AE)
against TP-Link Deco BE63 mesh; STA associates and remains stable for
24h+ with no regression in single-RU traffic patterns or in EMLSR
multi-link assoc behavior introduced by the previous EML+R-TWT patch.

Link: https://api.cert.wi-fi.org/api/certificate/download/public?variantId=129706 [WFA cert WFA129313]
Signed-off-by: Louis Kotze <loukot@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 056639db1dfa..986deb2c1384 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -5598,7 +5598,8 @@ static void rtw89_init_eht_cap(struct rtw89_dev *rtwdev,
 
 	eht_cap_elem->phy_cap_info[5] =
 		u8_encode_bits(IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_20US,
-			       IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_MASK);
+			       IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_MASK) |
+		IEEE80211_EHT_PHY_CAP5_RX_LESS_242_TONE_RU_SUPP;
 
 	eht_cap_elem->phy_cap_info[6] = 0;
 	eht_cap_elem->phy_cap_info[7] = 0;
-- 
2.54.0


