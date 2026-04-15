Return-Path: <linux-wireless+bounces-34785-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGT3CXmI32nSUgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34785-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:45:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FD2404643
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 52ADC3004927
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 12:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1020F3346BE;
	Wed, 15 Apr 2026 12:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XnvIf4To"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683D9257843
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257129; cv=none; b=mC5wjZj+j2Pkk6iy0g8N+edsjyHxz3vKw8cjBM6r820H7i8DPXwZIaO0tlt9FdenUz/fD/uGtvdPKLF7u3cTtcGdRsbXm8mp7mFBLjpBfDN/GfXsEByG9TFGKDeryT6nylMUBkaXrGf1upJdsraJ5KVlcQTajiKmFWUaV7XUmjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257129; c=relaxed/simple;
	bh=rfc1BVPX2T7dOrocJwwEeLwviODF0AiWkDPEpPh/Fh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6PlBA4UpIWaW8FIAoe3F9HtfHFtgkfk8l0vwYPWFqdXCgBuFP0ovDvdYSqNIuCcFIYTFVaaZRHrqtgaDNA+w9wO3fk2R8/9iZOcSbfrFPbnN2OnEqwuKZtxxitoAxFwlJM4vxaC7Iz6YyxgbEC6itgKyIZD0cZKipZ32Jwmw9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=XnvIf4To; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=wuRcMaNn1i86M8f8LuIc1WyOQ5hak5R+OifgMLCPN4I=;
	t=1776257128; x=1777466728; b=XnvIf4To1qZCT3HZXgLZoJAEqWQzWTZP53fsjhXa3mWFkkW
	yM0pmxbCchWKrMaQrNzUf6klpQ64ahBevcT/m0DCkO+js71KHq7yld+oBtw3Rh7hz/qvPN+DTTaXX
	fb8sSbMcC2qtuUBbIRtfb58LMXxrGZvZ4UAMMQsqjA0CM/pW/qVEPegbroJoCdvHcMxKarHNFkJcG
	dpoIRap8mtu1dSfLtsOODZDT3nOL4oa9t6Jczk2Ft3aWl78dpZkr9AQabSftX9PrUhjf+SWHst5Ws
	hstJa7F5AAZV8aGJZdSFrubm9siUMWfW2/CgfOVpe6uAZ0s1CC9HgrB+hrR82p3A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wCzcU-00000006OgW-0PPF;
	Wed, 15 Apr 2026 14:45:26 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 13/20] wifi: cfg80211: remove HE/SAE H2E required fields
Date: Wed, 15 Apr 2026 14:42:11 +0200
Message-ID: <20260415144514.a4a3ebb0f95a.Ifadd953e13133e7a45ee3318fb04b2ff9dde62e4@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415124514.284345-22-johannes@sipsolutions.net>
References: <20260415124514.284345-22-johannes@sipsolutions.net>
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
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-34785-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sipsolutions.net:dkim,intel.com:email]
X-Rspamd-Queue-Id: 05FD2404643
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

These are not used by any drivers, even the HT/VHT ones
are only used by the qtnfmac driver. Remove the fields.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

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
-- 
2.53.0


