Return-Path: <linux-wireless+bounces-35900-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONU+GPjZ+WnNEgMAu9opvQ
	(envelope-from <linux-wireless+bounces-35900-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 13:52:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D5D4CD08B
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 13:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E85AA3032675
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 11:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471C5381B02;
	Tue,  5 May 2026 11:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tDiit1ka"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0DD38B12B
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 11:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777981125; cv=none; b=L+9wjoQvGJMDMV30Ny08Q3nBQaqmWmZ5pXjlqebe0YjIVJJymwJcx/QACwuu9aXUqatAOg7mNsex/bmwDB6JJl4/+SR4nddbx8ALTaeAms8kQM/6ehPXDC7Km6LcMRcXTwChQm7waS2O0bTS+dO9GEr731ftRkhtFpZjokqG4Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777981125; c=relaxed/simple;
	bh=WSONmTWnXOatoqLSwJaaOwwg5goaewl8Un8DpBHjZuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a5P4gP5ySVyUpjtANaTsNc2D9umF+U/KbzYx5TaBcKYFqDX5KZ4U+A4tptgPVJ4jVIDptOuFDyA72h1PIBVTwvQ/ne9zVV9xg0/OvmaD2Myk34QGTCQcTelHM90SEFixi9UUQ+CxDjMbHjs9xDZ7lKyiiF9g5V3kTeDIZ+QxgwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tDiit1ka; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=AjOpKwY2LUPfK7eN1W20sGI0XspuMR94dLhg41nvJJg=; t=1777981123; x=1779190723; 
	b=tDiit1kax4r7WmkvVaNH/e0t8g539PTEomY6yy5D3utvq3XWJ14D+xfD0dRREDBkv4kFArZ4lVl
	Vn+AcCGGyvUVHHlZX3sK0XjPA5skpPzo8m2hm42gNq3n3Cyk7vntGEPiwRQ04IIX5nDynAi4c/seM
	5KQahgQASFYXWtozMa/3NauQT++pzDq3VAsSuvh1CgMQOGLKijmPqaVU/EwEtqgxHW+F3XN9FqiO2
	gw6R50FV9JDSPLY62LPa+XqPUrq7lEOwyvYV1+fnRBzt7/DU+DKtvyqx5V/bjHLv85wOv0aHQAEQu
	fsvi6afUygYGXwIzrGnT7ZZngUO7NjvN76eg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wKE6q-0000000G5vU-0bxO;
	Tue, 05 May 2026 13:38:40 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless] wifi: nl80211: fix NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST usage
Date: Tue,  5 May 2026 13:38:37 +0200
Message-ID: <20260505113837.260159-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E1D5D4CD08B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-35900-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,sipsolutions.net:dkim,sipsolutions.net:mid]

From: Johannes Berg <johannes.berg@intel.com>

This is documented as a u8 and has a policy of NLA_U8, but uses
nla_get_u32() which means it's completely broken on big-endian.
Fix it to use nla_get_u8().

Fixes: 9bb7e0f24e7e ("cfg80211: add peer measurement with FTM initiator API")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/pmsr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 951ba0b96da2..ca1229b93bb9 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -88,7 +88,7 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 	out->ftm.ftms_per_burst = 0;
 	if (tb[NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST])
 		out->ftm.ftms_per_burst =
-			nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST]);
+			nla_get_u8(tb[NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST]);
 
 	if (capa->ftm.max_ftms_per_burst &&
 	    out->ftm.ftms_per_burst > capa->ftm.max_ftms_per_burst) {
-- 
2.53.0


