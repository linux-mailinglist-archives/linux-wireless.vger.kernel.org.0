Return-Path: <linux-wireless+bounces-34038-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OK2HBv9Pxmk2IgUAu9opvQ
	(envelope-from <linux-wireless+bounces-34038-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 10:38:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E6A341D2F
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 10:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CFDF302FEB5
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 09:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880613DBD69;
	Fri, 27 Mar 2026 09:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="CvJb+rSu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA153D348B
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 09:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604232; cv=none; b=WGmyxYxJeP9uzcxLHPsx7sjiimxX8YMrhx7aHpqqXz4O9tyuMT50UOx4w7P1ERJyNjj122ra+5blTUlBAMt7RJtMOPeqVmfEzx4O9WpI0aPoopAYAPR/zPRqG0qFRtH8QVUKPR96IhO97rXZjRkVi/SRpdf7s4dIRsywqzONv30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604232; c=relaxed/simple;
	bh=js+4R6DAxXqgcZwdONouseru38+cEePwx0cv5QjyGwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VU7tQWaBm0Ksi3xfofyoFiR/zjndzGgzj8u7CvZOrUfQXhhEqPp1ruOasrLkPKR5hNSOlnX/cdOCCI7HZINbgOXIXrhm8Jct8RJaVkH95NphMJnS7VceROMm6Cy8MsUarohHOOuZwarMoWq6Buz229p7kKFJh/UHGhJ/Vup7Z/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=CvJb+rSu; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=YSvQ2CPigscPMaLKX9yHY2EhFU0OgvjrL7Ysq611px4=;
	t=1774604231; x=1775813831; b=CvJb+rSuhb25Gvxklo+8rryiE/zKvPi5qC7z0I8gB5OEgc2
	+KdC98uXUTMr0LBLb2tx5VbgMwZLu0pd7M50O+qICcA073dCxPQ/rg4E24ARhJJGU3JZ6uX+PKdHp
	YBiIjgHlXmucnG0P+F/mvBa7k0CNpk3Repijz3Ismw5V2MFDJdZlI/qTyGKg/U+AJ7qaVizDB3MnB
	Ps1UtvxIbeeiiR1EGxUXk9lkSYaaF2kObCbjFifrMmGk7mev/Z8HA5rm4+npK+eSxEshzlckCCn9n
	wp9FyOtOeitjpy3ChXxoCkCtZBg+TRD4EIMmcuvUiei3x3eawhdSIx5nhpwlq3Jg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w63cr-0000000E83L-1Aqy;
	Fri, 27 Mar 2026 10:37:09 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 12/19] wifi: cfg80211: remove HE/SAE H2E required fields
Date: Fri, 27 Mar 2026 10:31:38 +0100
Message-ID: <20260327103659.0c452edc60b1.Ifadd953e13133e7a45ee3318fb04b2ff9dde62e4@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327093659.711584-21-johannes@sipsolutions.net>
References: <20260327093659.711584-21-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34038-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 85E6A341D2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

These are not used by any drivers, even the HT/VHT ones
are only used by the qtnfmac driver. Remove the fields.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h | 4 +---
 net/wireless/nl80211.c | 4 ----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9d3639ff9c28..8bebf45af95d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1529,8 +1529,6 @@ struct cfg80211_s1g_short_beacon {
  * @ht_required: stations must support HT
  * @vht_required: stations must support VHT
  * @twt_responder: Enable Target Wait Time
- * @he_required: stations must support HE
- * @sae_h2e_required: stations must support direct H2E technique in SAE
  * @flags: flags, as defined in &enum nl80211_ap_settings_flags
  * @he_obss_pd: OBSS Packet Detection settings
  * @he_oper: HE operation IE (or %NULL if HE isn't enabled)
@@ -1566,7 +1564,7 @@ struct cfg80211_ap_settings {
 	const struct ieee80211_eht_cap_elem *eht_cap;
 	const struct ieee80211_eht_operation *eht_oper;
 	const struct ieee80211_uhr_operation *uhr_oper;
-	bool ht_required, vht_required, he_required, sae_h2e_required;
+	bool ht_required, vht_required;
 	bool twt_responder;
 	u32 flags;
 	struct ieee80211_he_obss_pd he_obss_pd;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index f334cdef8958..18fbe6c78e82 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6641,10 +6641,6 @@ static void nl80211_check_ap_rate_selectors(struct cfg80211_ap_settings *params,
 			params->ht_required = true;
 		if (rates->data[i] == BSS_MEMBERSHIP_SELECTOR_VHT_PHY)
 			params->vht_required = true;
-		if (rates->data[i] == BSS_MEMBERSHIP_SELECTOR_HE_PHY)
-			params->he_required = true;
-		if (rates->data[i] == BSS_MEMBERSHIP_SELECTOR_SAE_H2E)
-			params->sae_h2e_required = true;
 	}
 }
 
-- 
2.53.0


