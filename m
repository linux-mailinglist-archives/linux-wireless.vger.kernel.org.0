Return-Path: <linux-wireless+bounces-38818-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GFHFJ0d8T2rIhwIAu9opvQ
	(envelope-from <linux-wireless+bounces-38818-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 12:47:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F11572FD69
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 12:47:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=YFs3LkH9;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38818-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38818-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF09830A8DEF
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jul 2026 10:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7468F405C42;
	Thu,  9 Jul 2026 10:32:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0E4405C21
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jul 2026 10:32:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783593123; cv=none; b=sAYj0cvh/xxEypbDfl6iP111SgPQfDiuu3fzA9vp2+W8IuUN3UpVP212oAXWE80YqSswR1urPow2bYEhbJlc+7gnTrShJfFQHzOZ9winX+c7lzu8+qntpSb9P4J3nsGWAc7TQBHAJ7BEpA7OzvIW/dyZTt0P70XOYr42IMZntjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783593123; c=relaxed/simple;
	bh=NNmvmMFiSvKuSmWWjBp9FoknxILTLef0Ak79f4ZlafM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tUH4R7T/MtceF58tnQefsHKQYohiU0N4UEaX0+grcX0cULEUaIeSUC6yQT578n6liE4s3RHrQEeb0//GfTuX02pckoKYoI876aPFyYsDbA/osiD3krz3/DJjyV9E1twzvBZTUUPHSl8lPwQHJoTJJKyuy3BHJV/+lfB9WgPJl2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFs3LkH9; arc=none smtp.client-ip=209.85.221.53
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so1504416f8f.1
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jul 2026 03:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783593120; x=1784197920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zH3UvIyJssKv6bfHE7xFicyRPn7SV1QlAreFeCCuxRo=;
        b=YFs3LkH9QXgDdAgQ+kxVlP2KJLRfG834DTeftZlYsAbsn6S/Z2KOgLWx5jAbwR6xUM
         y19zE9/RXk58+HNfrIiEK82VuKFOIxID5vJHz+MXVUmRFf51CK/oKKCxkA6fY5iMG0ad
         fmn/afIPrjUbGmjujU23dFlJAhNOsc2T85nTv5SdE95Kragm4Osc7rJsRW6fZE9EZ3WY
         jII0x7UuvjWyYTcpaevjmXl0sstjI9fpI/75nZgDzqKbQt8mrU6OblngN/JhF9z3ebpq
         VsjgXwil4e6CPaj9lwjDfOsBLRkFON3y3cQDHWR/NZ1agec6CHuoCQz5KErQcyg8mSOw
         Sguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783593120; x=1784197920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zH3UvIyJssKv6bfHE7xFicyRPn7SV1QlAreFeCCuxRo=;
        b=pF1tflv8vqC+ZdbEocEDuUXAzjA+vgku+JkX3W3rOwyFlfPHQGs2Er/AH6BzqV3iXe
         lHaWGy+sFsu8JDPxS1VLXmhfn4yOUpChfqNmTpf717jv0F3tXCAbFjOzyrOGK9BditfL
         3BfQ1Ltc/RT2vRo3ms2u94F8/aR2EP5zqhuUmlY545eaApx8KeydDQxRPQOO3HcGoZtx
         UFMZyEC6utgBljc3zbdo8+/g1nNvD9jL4p/7D6RyHfcZPdw5U3iHwbrx7+BD85gxJcRk
         03SghjoguCCP/lDWYbpwQr11/6Ba3LdIxTS8Bq05rbOu+1m2YSl2J/uVtzcehlu4BVvp
         p/AQ==
X-Gm-Message-State: AOJu0YwKO6OyHugacbt8jgtPelSppD9KYAKFuEGXImsdRMCtCcnQ58kN
	kPLTQF3cr8LAQzPYX22RbzvtWhRx7c1Orph8MrBrXauTYgZtf7PE0y+OBS03bGru0vc=
X-Gm-Gg: AfdE7cl5UHQxunou4XVXERygqA1ybH8JpLD1NmESz2lWocGYURure4lQwzGnCiDPiUs
	55jQszaPhSU71xCZUYy7nPveKFNUUs77slH4IoDW6ZX0wUhErKwyWYJP4wc/hjTpTU4gZpujNLL
	0ifhqZq+cJOZiP+YtKE4tV0navkYhBVe/aWdeGp6cvC0SEnMmcQEJRgvmDSSxrfhvXpgb5eni+e
	h0l1mfHA527V7hVQrvgHGRwhaimUm4xCcqCs0c9pYGqMF+KSIQ+R1TgRY2Q4evSDIFmJGbulryp
	31Pr6UxjytFNtwXaCzHMOhU58ky1TyWXWc9vBE9tCmoaf5QEO1yxOo0Xdh5y2i7TqolTUTvnYT0
	NSUnd4/Z9TJcBxEBt7ws20f0uKLwrEZU72uMSR3lAoS2WDK6kUYqPR/UCQxX8tT7IRc+JUwMr0C
	d6BNv+IzKPvUhjxOQu0qLPQxZx4kBkGM5Ll6/k
X-Received: by 2002:a05:6000:1a86:b0:478:65a8:2635 with SMTP id ffacd0b85a97d-47df0714967mr7380351f8f.11.1783593120154;
        Thu, 09 Jul 2026 03:32:00 -0700 (PDT)
Received: from localhost ([102.128.173.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f21543sm46816067f8f.35.2026.07.09.03.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 03:31:59 -0700 (PDT)
From: Louis Kotze <loukot@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loukot@gmail.com
Subject: [PATCH v2] wifi: rtw89: advertise EML capabilities for 8922a
Date: Thu,  9 Jul 2026 12:31:56 +0200
Message-ID: <20260709103156.1271328-1-loukot@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-38818-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:loukot@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loukot@gmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loukot@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F11572FD69

The driver implements the EMLSR operating mode for 8922a and selects
it when an interface has more than one active link (enum
rtw89_mlo_mode, rtw89_ops_vif_cfg_changed()), but leaves
eml_capabilities = 0 in the STA iftype-ext-cap. mac80211 therefore
advertises no EML capabilities in the Multi-Link element, so an
EMLSR-capable AP cannot negotiate EMLSR with this STA.

Populate eml_capabilities with IEEE80211_EML_CAP_EMLSR_SUPP, an EML
padding delay of 256 us and an EMLSR transition delay of 32 us,
following the same layout iwlwifi uses (iwlwifi advertises 32 us and
64 us). These values have run stably on my RTL8922AU since late
April; if Realtek has recommended values for this silicon I am happy
to adjust them.

In A/B testing against a TP-Link Deco BE63 (EMLSR-capable Wi-Fi 7
AP), ML association without this change came up with a single link;
with it, both the 5 GHz and 6 GHz links are set up (debugfs shows
link-1 and link-2 with active_links behaving as expected for EMLSR),
stable across 60+ hour soaks with no kernel or wpa_supplicant
errors.

EMLMR is deliberately not advertised: the chip has a single shared
2T2R RF block (rf_path_num = 2) and the driver has no EMLMR mode, so
EMLSR is the architectural ceiling for this silicon. Realtek's Wi-Fi
Alliance certification of RTL8922AE (WFA129313) likewise lists EMLSR
but not EMLMR; the certification was obtained with the Windows
driver, so it is cited only as evidence of silicon and firmware
capability.

Signed-off-by: Louis Kotze <loukot@gmail.com>
---
Changes in v2 (was patch 1/4 of "advertise WFA-certified EHT
capabilities for 8922a"):
- Narrowed the series to this single patch; see the reply on the v1
  thread for why the other three capabilities are deferred.
- Dropped Restricted TWT from this patch: no in-tree driver
  advertises it for a STA yet and I cannot verify the firmware side.
- Dropped the WFA certificate Link: trailer; the certification was
  obtained with the Windows driver, so it is cited in the body only
  as silicon-side evidence.
- Stated the advertised delay values and their testing basis
  explicitly, and switched to the __bf_shf() layout iwlwifi uses.
- Rebased onto wireless-next; also applies cleanly on rtw-next
  (2b7858891b10).
 drivers/net/wireless/realtek/rtw89/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 0f0e46cb4260..69eaae3586cb 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -217,7 +217,12 @@ static const struct wiphy_iftype_ext_capab rtw89_iftypes_ext_capa[] = {
 		.extended_capabilities_mask = rtw89_ext_capa_sta,
 		.extended_capabilities_len = sizeof(rtw89_ext_capa_sta),
 		/* relevant only if EHT is supported */
-		.eml_capabilities = 0,
+		.eml_capabilities =
+			IEEE80211_EML_CAP_EMLSR_SUPP |
+			IEEE80211_EML_CAP_EML_PADDING_DELAY_256US <<
+				__bf_shf(IEEE80211_EML_CAP_EML_PADDING_DELAY) |
+			IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_32US <<
+				__bf_shf(IEEE80211_EML_CAP_EML_TRANSITION_DELAY),
 		.mld_capa_and_ops = 0,
 	},
 };

base-commit: ac798f757d6475dc6fee2ec899980d6740714596
-- 
2.55.0


