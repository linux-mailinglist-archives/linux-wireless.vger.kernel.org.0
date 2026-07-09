Return-Path: <linux-wireless+bounces-38815-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yyeWF0J7T2p2hwIAu9opvQ
	(envelope-from <linux-wireless+bounces-38815-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 12:43:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC3D72FC81
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 12:43:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=0sec.ai header.s=google header.b=nfyhnOVG;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38815-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38815-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC2403187340
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jul 2026 10:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1736440B369;
	Thu,  9 Jul 2026 10:08:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698CC409DF0
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jul 2026 10:08:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591687; cv=none; b=Ii+FTzSamsc4mDDqQTMU6gYNe8qyowzlMc+XtNj55Kj0NSALmQfSDvOP02R1AiJJRy6Ep59ejbG7A7yNa7hyoxI8lbmR3AvrfKEMw4Q0rJIRU14O/fq8UWShsX168OqUkSjwspnrVGZ04sa2hKuEqFeD1C6fRs0WLEIjUIa6Swc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591687; c=relaxed/simple;
	bh=UxU+JME5ebASSmQr4qIUB2ld2xMnnpTyCKBpBPioAwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kiAVx6ohZwKZ8KpPbDFFhLcdD9o2m4LzKNd/Cl3zpkOmDylTtucmpnBp2mt4rau/3+0YeAd33Za6vgttSe9rniVNd2UGPukm04LZXpduyfl/blHIRk50XP8BuxNxW/yUoU7YxjADFINn0R5CFkMoVE/YccmqnYJ3uEiwmpXp6rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=nfyhnOVG; arc=none smtp.client-ip=209.85.221.41
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-470174001a0so954671f8f.0
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jul 2026 03:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783591683; x=1784196483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0JbLxmjVDkQJsUyY2A+uFCQIi3MH0ZYtgFX/E0Ge6oo=;
        b=nfyhnOVGMPkEP9wTcYLV3irZJCg/XZrGJ3i94G3fnHK4843PUlLi09afkOQHd6wH9V
         ZQYFD2+jQWP+g38JHuNgfHzUUvwTWZgYJ9aMLmo61bIq2zHNNMGfbQN5L2zEf2wZV6FG
         BbzoAMMzm17nUAjCwvl85l4Ghd0JppU9bXHgJ/1ZhHRGcU0l7jIAaXGs00WEOWkqeiW8
         nvAdxQFA8BM+35p5nZo8bYLC7cgl38bUo7O2WVegF2uR9GbfxFzcQnMbs8Ew6VEHHAEM
         Qo6DJ+JcZTRYkkoo72GyaZ8giIZXIiuAvTpb7RrOY10cGyKHd7ejfP1HdpVISMqUhTZh
         mX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783591683; x=1784196483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0JbLxmjVDkQJsUyY2A+uFCQIi3MH0ZYtgFX/E0Ge6oo=;
        b=kNXnTPrvki3jOH8dFGx+x35vMtY7JWePl2VnKRabBsoyNUiTRpDEfBzQr0q95otdTP
         vZVCES3+q0oLR5Qh80urajfUnYQb4S0fpMvHJ4bw1hemsTG5pm+LtJPxM/+sumb7v8Wc
         N590KRFlF0ltl7gbPsI7g9InThhSBEtOLDrgN+13HZ8dc2zdG1lET8VihjeCNIttnBOs
         RBvSpe+s1HeuOiN2fYLz1fmcWgniLZGzH4R66fvtUv6N64ZqKD4IU4f+jPHmgsHCArZe
         XQHl4LZpW+tr0/slBSp9ac+rQY5UyITBzEHrIGXuR6V0ou0vkVc9uXTGU3FZWERQI1bf
         bK4Q==
X-Forwarded-Encrypted: i=1; AHgh+RoU8u3L/+6b+Eg+PdGc89kJ1WSdgBaSaWP4czkhx8GFcUGMvicfIGBXMPWIZffe0b/wqx5VZL4oFskkdNcP7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJt1noZw5NoUXlnpB14rugYSl3a7VL5wkUwyZ3602i5yuAtUQs
	19n8Wf3XmVKkuaai+eQADtyRJys8rEUUMiVFwnQbUItUR1i2to8sk47hvVUfQXu+5AY6
X-Gm-Gg: AfdE7cllio2V1p225fmdgJi5ohk9h5p0Tq3c1BOiJ7+1IuOsbGc2ZP04Ma/GibjKhhh
	KmJpRqEiXtwDBRzQVlb+FXbOnPdH2OhQlJ0vwHY39P9rTpL5qgevNs6tCn9+MJaujy5Z/t1pqar
	XIjqT+jXFgJWVQl7yzeMipJR4rFDd9Ku0hrGFC8rK0tXz9iLpA+5c4y+lsnIYpJ5nnX3DpMufHY
	ivd23Vmtyaxfwr0kU8t25HwhdJh91Z74QInb4tyWXFAz907BS2Ot1eWU3wRWcV+17Y9b1REgwlw
	FL4QmVE3EqtGWGrO1MoOMwAD1X7DkxMu7qyEWEM6iMXROy0eJdl+lyJnFTaSHGXPsRUitHo4L2U
	/jZeq5A7QUZdM/8/A/ZFxGrjLI9Yn8Nj6NEwi0OArPOjWH0fcKz7JGKDmvVHJx8z1RxKv22rx4G
	kwtvYBMXgjmWp8wqKH5Q4JO2x0zEde1PqvGclXqfVsWE7Di29k3JkqcAnz8u/EgOjV6Igx8Xbfw
	fk30neD5Cv0WvnnQR1SVp5zxt/jgHPPATZYrvfVUSzArA==
X-Received: by 2002:a05:6000:610:b0:45e:eaed:afd2 with SMTP id ffacd0b85a97d-47df073825emr6758798f8f.0.1783591682589;
        Thu, 09 Jul 2026 03:08:02 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d8cdsm53768227f8f.1.2026.07.09.03.08.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 09 Jul 2026 03:08:02 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Brian Norris <briannorris@chromium.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Kees Cook <kees@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH] wifi: mwifiex: validate HT/VHT capability and operation IE lengths
Date: Thu,  9 Jul 2026 12:08:00 +0200
Message-ID: <20260709100800.7026-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[0sec.ai:s=google];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[0sec.ai];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38815-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:briannorris@chromium.org,m:francesco@dolcini.it,m:kees@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:doruk@0sec.ai,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[doruk@0sec.ai,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[0sec.ai:-];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0sec.ai:from_mime,0sec.ai:url,0sec.ai:mid,0sec.ai:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8FC3D72FC81

mwifiex_update_bss_desc_with_ie() records raw pointers to the HT
Capabilities, HT Operation, VHT Capabilities, VHT Operation, 20/40 BSS
Coexistence and Operating Mode Notification elements taken straight out
of a beacon/probe-response buffer, without checking that each element is
long enough for the fixed-size structure that later consumers read. The
buffer is a tight kmemdup() of the on-air IEs (beacon_buf_size ==
ies->len), so a truncated element placed last leaves the stored pointer
one past the end of the allocation.

At association time these pointers are dereferenced at fixed offsets
regardless of the on-air length: mwifiex_cmd_append_11n_tlv() memcpy()s
sizeof(struct ieee80211_ht_cap) (26 bytes) from bcn_ht_cap and reads
bcn_ht_oper->ht_param, and mwifiex_cmd_append_11ac_tlv() memcpy()s
sizeof(struct ieee80211_vht_cap) (12 bytes) from bcn_vht_cap and reads
bcn_vht_oper->chan_width. A nearby AP (rogue / evil-twin; an open SSID
needs no credentials) advertising a BSS with a truncated HT/VHT cap
element therefore triggers a slab out-of-bounds read on the victim's
association attempt. This out-of-bounds read is the primary issue.

For the HT-Cap copy the over-read bytes are additionally placed into the
outgoing association request, so a limited amount of adjacent heap memory
can leak over the air. In station mode this is small (single-digit
bytes), because mwifiex_fill_cap_info() rewrites most of the copied
HT-Cap before transmission; the leak is a secondary effect.

mwifiex_set_sta_ht_cap() has the same missing-length pattern: in uAP mode
it reads two bytes of ieee80211_ht_cap.cap_info from a
cfg80211_find_ie(WLAN_EID_HT_CAPABILITY) result in a client association
request without checking the element length, a 1-2 byte out-of-bounds
read (used only to select an A-MSDU size, not leaked).

Reject (skip) any of these elements whose payload is shorter than the
structure the driver later reads, matching the length validation the
FH/DS/CF/IBSS parameter-set cases in the same beacon parser already
perform.

No dynamic reproducer: mwifiex is a fullmac driver for Marvell hardware
with no mac80211_hwsim equivalent, so this was confirmed by source and
structure-offset analysis only.

Found by 0sec automated security-research tooling (https://0sec.ai).

Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/net/wireless/marvell/mwifiex/scan.c | 12 ++++++++++++
 drivers/net/wireless/marvell/mwifiex/util.c |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index 97c0ec3b822e..997e7e19525b 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -1384,6 +1384,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 							bss_entry->beacon_buf);
 			break;
 		case WLAN_EID_HT_CAPABILITY:
+			if (element_len < sizeof(struct ieee80211_ht_cap))
+				break;
 			bss_entry->bcn_ht_cap = (struct ieee80211_ht_cap *)
 					(current_ptr +
 					sizeof(struct ieee_types_header));
@@ -1392,6 +1394,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 					bss_entry->beacon_buf);
 			break;
 		case WLAN_EID_HT_OPERATION:
+			if (element_len < sizeof(struct ieee80211_ht_operation))
+				break;
 			bss_entry->bcn_ht_oper =
 				(struct ieee80211_ht_operation *)(current_ptr +
 					sizeof(struct ieee_types_header));
@@ -1400,6 +1404,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 					bss_entry->beacon_buf);
 			break;
 		case WLAN_EID_VHT_CAPABILITY:
+			if (element_len < sizeof(struct ieee80211_vht_cap))
+				break;
 			bss_entry->disable_11ac = false;
 			bss_entry->bcn_vht_cap =
 				(void *)(current_ptr +
@@ -1409,6 +1415,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 					      bss_entry->beacon_buf);
 			break;
 		case WLAN_EID_VHT_OPERATION:
+			if (element_len < sizeof(struct ieee80211_vht_operation))
+				break;
 			bss_entry->bcn_vht_oper =
 				(void *)(current_ptr +
 					 sizeof(struct ieee_types_header));
@@ -1417,6 +1425,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 					      bss_entry->beacon_buf);
 			break;
 		case WLAN_EID_BSS_COEX_2040:
+			if (!element_len)
+				break;
 			bss_entry->bcn_bss_co_2040 = current_ptr;
 			bss_entry->bss_co_2040_offset =
 				(u16) (current_ptr - bss_entry->beacon_buf);
@@ -1427,6 +1437,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 				(u16) (current_ptr - bss_entry->beacon_buf);
 			break;
 		case WLAN_EID_OPMODE_NOTIF:
+			if (!element_len)
+				break;
 			bss_entry->oper_mode = (void *)current_ptr;
 			bss_entry->oper_mode_offset =
 					(u16)((u8 *)bss_entry->oper_mode -
diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index 7d3631d21223..844223c04e2e 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -721,7 +721,7 @@ mwifiex_set_sta_ht_cap(struct mwifiex_private *priv, const u8 *ies,
 
 	ht_cap_ie = (void *)cfg80211_find_ie(WLAN_EID_HT_CAPABILITY, ies,
 					     ies_len);
-	if (ht_cap_ie) {
+	if (ht_cap_ie && ht_cap_ie->len >= sizeof(struct ieee80211_ht_cap)) {
 		ht_cap = (void *)(ht_cap_ie + 1);
 		node->is_11n_enabled = 1;
 		node->max_amsdu = le16_to_cpu(ht_cap->cap_info) &
-- 
2.43.0


