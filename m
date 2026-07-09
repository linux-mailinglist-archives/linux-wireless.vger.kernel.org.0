Return-Path: <linux-wireless+bounces-38807-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mEYpKN4LT2raZgIAu9opvQ
	(envelope-from <linux-wireless+bounces-38807-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 04:47:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 965FE72C24D
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 04:47:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FUaxzpFJ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38807-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38807-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B15C300F790
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jul 2026 02:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19737261A;
	Thu,  9 Jul 2026 02:45:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAAAEEC0;
	Thu,  9 Jul 2026 02:45:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783565137; cv=none; b=I/qIoY799w/nnYFhEHlB8+0WczaABcyllZWyuOl2R9wHkUjR6I/M/a7oILgqagNA7TlN4Ptmxwk7PVxWKPuAiHXLmBqmqYSTmkJCTbxCqp1ozKkgJRezkfK8kzm+iVCLuCMz85iVdUyPelC77GwAaFyByuLKaewm09M5zxMUEOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783565137; c=relaxed/simple;
	bh=B4sB5XWE7cSAeuarIdTc/s0UhzdgTJZD73Hdg4hcUKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mrlw0MbAsOueEMKieirE/urHfjcWuNi8tLJYhTZPVTaLMRYH9ZGjnmUC1NI1f5fzHTDObA34ES3H1FVI4RMYkR6aDMZIhpZjtWlVB56mSfLzG9VxkGh7GCrPRrCo0y8vO7Q+nkrWPmm3LujUCi61IjzmC1KjVweWHzffx3MgVNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUaxzpFJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCF51F000E9;
	Thu,  9 Jul 2026 02:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783565136;
	bh=jSlk9Z/FGzf1qqoSCxsV+iIQUjW/+mexmFdaAGfOUTc=;
	h=From:To:Cc:Subject:Date;
	b=FUaxzpFJdPh4gbaS+L+AaLHlCVKSiuVk3QeLkYeYXaHqXJutrCZWPFYj1HdKQi0cR
	 MT4HrZRPLluA4G9RcVeMFuI26fo7j3V61J1z6U6sg6ulTXjJPSwxl8I6kBwcNbWPbu
	 iGFcAE8lTBh/VCxXwFvAkLTw79pr2z0zvO3pWda1xfDxfE7WlVNwtAUrQesZmWdHBx
	 w1Kdiimz9u261mxfn87wJlPvIQwFXeHSYTAX6DNQ3VHnGDwfbPZeSpRvLZtlA1o2mY
	 P9NFSDfub1eOfuTi6isHmwOaHQEwf9XgrCQuzKDx7MZTSj80SrOkNj9a06YItzWpkH
	 CwKG0+Cm8u1bg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Jouni Malinen <jouni.malinen@oss.qualcomm.com>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mac80211: Fix cryptographic MAC comparison to be constant-time
Date: Wed,  8 Jul 2026 22:44:43 -0400
Message-ID: <20260709024443.58132-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:johannes@sipsolutions.net,m:jouni.malinen@oss.qualcomm.com,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ebiggers@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38807-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 965FE72C24D

To prevent timing attacks, the comparison of cryptographic message
authentication codes (MACs) needs to have data-independent timing.
Replace the memcmp() with the correct function, crypto_memneq().

Fixes: 39404feee691 ("mac80211: FILS AEAD protection for station mode association frames")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 net/mac80211/fils_aead.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/fils_aead.c b/net/mac80211/fils_aead.c
index d2f4a17eab99..00b91e6ed994 100644
--- a/net/mac80211/fils_aead.c
+++ b/net/mac80211/fils_aead.c
@@ -195,7 +195,7 @@ static int aes_siv_decrypt(const u8 *key, size_t key_len,
 	res = aes_s2v(key /* K1 */, key_len, num_elem, addr, len, check);
 	if (res)
 		return res;
-	if (memcmp(check, frame_iv, AES_BLOCK_SIZE) != 0)
+	if (crypto_memneq(check, frame_iv, AES_BLOCK_SIZE))
 		return -EINVAL;
 	return 0;
 }

base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
-- 
2.55.0


