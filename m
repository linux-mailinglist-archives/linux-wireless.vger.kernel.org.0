Return-Path: <linux-wireless+bounces-34041-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MwFKQxQxmk2IgUAu9opvQ
	(envelope-from <linux-wireless+bounces-34041-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 10:38:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAA9341D4B
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 10:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1490304A8A7
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 09:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EB13DCD99;
	Fri, 27 Mar 2026 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pj35svsi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93123DA7C4
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 09:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604233; cv=none; b=TAosNsaUcYwtysWaCdZ317UnzGcm6YdzmYX/jC3dIjVks8dnOAAdHo7G1mTXrVvK1z4s1hwAyUi0o1wcEmBLh99JCxwaiCwmGhPuO9TDnnikTydLB9620NnaCkDBZe1zYq+Ier5RjpNaMd9JP3UgBNyamGhpODL8yd8iVhbDyeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604233; c=relaxed/simple;
	bh=iL2YuVnWXK7rZJg9X2meSCuieH+5kjpd6fhLxQEzwMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GS2vH1dEJFz9Q8YllViYFluj3uhVY4wSi37BkeIObCfMoXfhQWtjoZ7U5UUoyKwvvfGWFGGo3o6jH0xECfW7rLfi2kri1qi27AjTETS7MHHdrFJqCrUzH0wxa7qWi+7Tfgdx5pd+5YVdr6bt/raNf50l7bV+IczmqZMTV2l/4Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pj35svsi; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=lvGLJdVJDvnq7neqTuC6d/dkcEJ3Ma1aXAZeh0gPU9w=;
	t=1774604231; x=1775813831; b=pj35svsiyO9Re7mhdiCf5gGXJl2x+gKuxml8eVaD/19+jfR
	NsEEa/OPvSOd2/wPwnnbM9FXQP33tZVw+/TeabdxQ5YsT4XPNCvLSca+N0sqpEvlKVWH1CpDA2nOW
	d8nV1S9cAcJSZhBHmnKUsYEJ1NO0Bon9C68OjnSLnc9Uf0RUjlT9p5j65j0wFsGpIeLWu1Su648KA
	aXOopziZ0VkMm0VgziGlnsls+ridQjyw0PaeEJS7IpKjYTBVgl++lCND6SaR6VunrhjpmcG6OzL75
	jgJaC0wJMN02y6eBrBFMHzGaiJGzmPHuSci+JB2xT3ABz3VAd6DNylNDlCaKgTOg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w63cr-0000000E83L-3TqP;
	Fri, 27 Mar 2026 10:37:10 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 13/19] wifi: nl80211: reject beacons with bad HE operation
Date: Fri, 27 Mar 2026 10:31:39 +0100
Message-ID: <20260327103659.6889b2880dc4.Iff7ff6bcb159584e756d0f825c65860cdd53c6ea@changeid>
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
	TAGGED_FROM(0.00)[bounces-34041-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 1CAA9341D4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

The HE operation element not only needs to be longer than
the fixed part, but also have an appropriate size for the
variable part inside of it. Check this.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 18fbe6c78e82..7a1c9faef443 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6673,8 +6673,12 @@ static int nl80211_calculate_ap_params(struct cfg80211_ap_settings *params)
 	if (cap && cap->datalen >= sizeof(*params->he_cap) + 1)
 		params->he_cap = (void *)(cap->data + 1);
 	cap = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_OPERATION, ies, ies_len);
-	if (cap && cap->datalen >= sizeof(*params->he_oper) + 1)
+	if (cap && cap->datalen >= sizeof(*params->he_oper) + 1) {
 		params->he_oper = (void *)(cap->data + 1);
+		/* takes extension ID into account */
+		if (cap->datalen < ieee80211_he_oper_size((void *)params->he_oper))
+			return -EINVAL;
+	}
 	cap = cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_CAPABILITY, ies, ies_len);
 	if (cap) {
 		if (!cap->datalen)
-- 
2.53.0


