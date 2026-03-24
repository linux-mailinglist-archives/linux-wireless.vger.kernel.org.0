Return-Path: <linux-wireless+bounces-33771-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFKcBp5jwmmecAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33771-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 11:12:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C64A3064A7
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 11:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B8053098408
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 10:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2093DEAC9;
	Tue, 24 Mar 2026 10:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjNFJVzc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE233DDDCD
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 10:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774346792; cv=none; b=car+0xpumBr5FJ1QpPv/+58Nqu5dTKfZEddxblv9H1vu1/aoTB2POT7662eoxoDwvLgfEBX1wUicFAgoE4ZZJmYYPkpQcxs+QspBweh/o6AfbEhRifEWCJeg4Qo8s+UVKrOeTdW7d8gT5iKkF9Aeah/IWR6sM84tH8KntG1vvwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774346792; c=relaxed/simple;
	bh=VVONFl2fl2ZpU8zDmrnDP6QZw5tqSdxiSkPLZt966XY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eTPckYGUFhi5aDz97RG5OUPtCNlvEBL6TQcSQSaa6VsstMxDSfPNOfd1SCj5yH+A15JNJ5ppPEAuYIehmHcm13OMOd8ivQ179JqKGeGQln4nJd2d54hXUPMqt25l2/KMyhYW6ifItkCQ77MIoHh6tJRDl6rdOd/WY4Or1Br0Hk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pjNFJVzc; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-358d80f60ccso577630a91.3
        for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 03:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774346788; x=1774951588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WkF8ye71NZGMVLnGHI2bABTT6abAVxL653SKoXtm5Ug=;
        b=pjNFJVzcCiFybx3a7uQKzPxE83p6d34TDgSpS98wxvd8iiLBl4j+D/zG0Of0jo0BEc
         KeMBtv8H2ww68Ua85hx2vWoeL5xB/bDI3OLDsR7flahDEHHmIhVUPG9G5lEFL82Ait6U
         6EqFHz1NmoRC3pWGQ6MNWGXfxODQbNHlBRVeE9159Qp7esfjZfb8sZk0VpVsOJO9/0mo
         49Y4RcnsctlxuRUCV4OU/KInlf/BUyg1wmgz/Wd0cVvSjiCqTp/q4ptCMe42Csg8mb67
         hg6lE7+HzrXhuAIZFWGrzFOdW4HAokHMIa3374O56Ko16fqB1KG5L3A7OcUOr0s4LFDE
         uEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774346788; x=1774951588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkF8ye71NZGMVLnGHI2bABTT6abAVxL653SKoXtm5Ug=;
        b=IzaPcIE5ec8z13AvyMBjQ5dCeno4QTdC1878ya0vo5PNFbSCNETb8y27ZLrAEzYn0p
         xp0wNG2k0km6/2vVRc2amYakrE9HRhJb1Il9G13yTrwjawgf8GbS5+ZJxlKe9L7rMzPE
         O+0NN+KHuBs/i5EZiwGYHtusJme0a8YBd++mOtL6mXCFYuk9hr1jHVjEpBTknxtJdQYB
         BF0zDsQQZBjyPaE/56XBMZefDPt3EmRLtKE1p7C+UkOmo6RppSktkvIBiSGcmL5ztYBO
         +RNBNDe9uwd/+9y4gYDbW+XA61ZElUj6719soxZgLxvfgjZ2qFgqIGMEeKk8MPpftXb/
         A31Q==
X-Gm-Message-State: AOJu0Ywvavo7ckj57IwlrB4pUhqR2zkUNaM692+Oha1O55IjYz2jkYy3
	3dsX/AUos6oQ9riRK6LMroLWXSHaoFHOcHUT6f18A+3W7npv74QuYchUNQIPm1D/anY=
X-Gm-Gg: ATEYQzxTZu/8/w0RbCN/VuLO3CXSklTglMBcOcGGAcEU512BuDmUU6Jl3O1Osuu7LMf
	sdM+2xzy570Loy/JW7IAUXInjAMRbx5o8PjSXY9cprVdXwUK9+JAxD3QttZJinOvTb/rL5AhiHV
	pBUytCUfpGFHkNgKpOdd0O9NuRQpDISddOEgJcZz2l29TaWSEn6LIEsy8CquouUwORBvD4dVOH6
	JP7FIQ4bwKO8An6kVB25L+rMdoqnRFViqpiA44TdRQm4I+TSnGoscYhmmskQzqHEIfCYc4uQepQ
	ikLUu/cfuWCuf3Np0+skykCP6BDM/dWjCURtZ5IYAQa71jum7I4EV1+UWcW7lfrgelbOMVPfyJs
	CvfBTXTWIkcCKVH51MztcIgidpXvFwX6Uz5sNPEjXBnMoq89a0d5iiN33aEVFdHG8JcoMmVenqI
	90nQdOl1tOumTRqRDyahjw6nI=
X-Received: by 2002:a17:90b:3fcc:b0:35b:95f7:7182 with SMTP id 98e67ed59e1d1-35bd2d40a61mr11871791a91.32.1774346788249;
        Tue, 24 Mar 2026 03:06:28 -0700 (PDT)
Received: from nixos ([240b:10:ff26:df00:5eb5:51a7:1801:3c5b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c03134bd2sm1919731a91.5.2026.03.24.03.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 03:06:27 -0700 (PDT)
From: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: ajay.kathat@microchip.com,
	claudiu.beznea@tuxon.dev,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yasuaki Torimaru <yasuakitorimaru@gmail.com>
Subject: [PATCH] wifi: wilc1000: fix u8 overflow in SSID scan buffer size calculation
Date: Tue, 24 Mar 2026 19:06:24 +0900
Message-ID: <20260324100624.983458-1-yasuakitorimaru@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,tuxon.dev,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-33771-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yasuakitorimaru@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C64A3064A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The variable valuesize is declared as u8 but accumulates the total
length of all SSIDs to scan. Each SSID contributes up to 33 bytes
(IEEE80211_MAX_SSID_LEN + 1), and with WILC_MAX_NUM_PROBED_SSID (10)
SSIDs the total can reach 330, which wraps around to 74 when stored
in a u8.

This causes kmalloc to allocate only 75 bytes while the subsequent
memcpy writes up to 331 bytes into the buffer, resulting in a 256-byte
heap buffer overflow.

Widen valuesize from u8 to u32 to accommodate the full range.

Fixes: c5c77ba18ea6 ("staging: wilc1000: Add SDIO/SPI 802.11 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
---
 drivers/net/wireless/microchip/wilc1000/hif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index f354b11cb919..944b2a812b63 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -163,7 +163,7 @@ int wilc_scan(struct wilc_vif *vif, u8 scan_source,
 	u32 index = 0;
 	u32 i, scan_timeout;
 	u8 *buffer;
-	u8 valuesize = 0;
+	u32 valuesize = 0;
 	u8 *search_ssid_vals = NULL;
 	const u8 ch_list_len = request->n_channels;
 	struct host_if_drv *hif_drv = vif->hif_drv;
-- 
2.50.1


