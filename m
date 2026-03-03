Return-Path: <linux-wireless+bounces-32395-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOipEjvtpmlKaQAAu9opvQ
	(envelope-from <linux-wireless+bounces-32395-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 15:16:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AC01F13FD
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 15:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A42A3004DF9
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 14:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF8033F368;
	Tue,  3 Mar 2026 14:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Qa+wwsdf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DC12253EE
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 14:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772547383; cv=none; b=EYk3Q5XEY14t8qEpJYIHFBvtKYj3s89OHF1/Van+4MltJpVVhhzPYU/nOCx9Lnu/euumDqWhPAaRiVOflaIb/8VAsyZXeZ8f9fE4gP2l3xOrnnIGjBynve13a4FMzFzstB/qi3j9fiQfSg5XT2itXDXIhXesbnKnw+JiuNqzDTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772547383; c=relaxed/simple;
	bh=pujh/b5Uwvigi/9w2Sb7AVkbM9CPiWm6qIJVjh9EVE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MuiZjDmDunXEkfE8NbTBuiegB3VXR2AAOLwTpK2YyJPGGK1CvDOGWwDEg4kk7uVyg4xjHdXLKJHQGMxW3A6DF29oa4G1gV2giBDhr/gZM0BOmegrkvFXlhcCfvu0wH85FhB9oIFboKvEA5doZRf1LnV/dwOF1qm2uLiUzziOqkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Qa+wwsdf; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=15TZ6P2bqJdSrf0fR6d4cwbMtnP/RFt/HkTDXKkDL+c=; t=1772547382; x=1773756982; 
	b=Qa+wwsdfJyO1r1NTEaxktqkS+n/oEq+fuG2lKQV2s5gLYe3nwBFLGVO4Wn5v5HZYCnFgdSYkWC3
	+x6uGO4V348VF67ry/z3pNQIWSGVZmAN8Oc9bAXsa28wOBbuoyoOnfKhLu/8ks/RwyP8rBsh+iCWq
	M40gaGWQ4x/p1PRAasryv5X+a7ayoFPdqSlhRRl+/raNCEhTFsY0YUivqG/ehbtXDT/7GYN4PxDv0
	2BLbsbhD9kMop+F4TUDAXs3KGJMCo++ztbfjKsNqb62bmVZaESOLdpV6559tRrG/FezcbeM1SgeDr
	2o74B65NTgtxTYi28Aft280NXTr3JZwbDnBw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vxQXp-000000079O7-1T3k;
	Tue, 03 Mar 2026 15:16:17 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	stable+noautosel@kernel.org
Subject: [PATCH wireless-next] wifi: nl80211: fix UHR capability validation
Date: Tue,  3 Mar 2026 15:16:15 +0100
Message-ID: <20260303151614.e87ea9995be5.Ie164040a51855a3e548f05f0d0291d7d7993c7ee@changeid>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B6AC01F13FD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32395-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,noautosel];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

The ieee80211_uhr_capa_size_ok() function returns a boolean,
but we need an error code here. Fix that.

Fixes: 072e6f7f416f ("wifi: cfg80211: add initial UHR support")
Cc: <stable+noautosel@kernel.org> # no drivers with UHR yet
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2225f5d0b124..699687a0caa9 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -339,7 +339,9 @@ static int validate_uhr_capa(const struct nlattr *attr,
 	const u8 *data = nla_data(attr);
 	unsigned int len = nla_len(attr);
 
-	return ieee80211_uhr_capa_size_ok(data, len, false);
+	if (!ieee80211_uhr_capa_size_ok(data, len, false))
+		return -EINVAL;
+	return 0;
 }
 
 /* policy for the attributes */
-- 
2.53.0


