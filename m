Return-Path: <linux-wireless+bounces-32306-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JtQJlqJomkd3wQAu9opvQ
	(envelope-from <linux-wireless+bounces-32306-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Feb 2026 07:21:14 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1630A1C08C9
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Feb 2026 07:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 20914304EA61
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Feb 2026 06:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0941329361;
	Sat, 28 Feb 2026 06:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="Sb8umgNJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D144E3451B3;
	Sat, 28 Feb 2026 06:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772259647; cv=none; b=PXUGaM9z6w9JSTimc/MR3uxQtQi8z/3VDiOOzYfDJ2Vw2ZrAsDNXpAPZTBwgidTb2E8lBs2wn1UWZBPkE2yBQdZPWhc3eii7z8HCuHM0V032LDqBn1UQfOownIlDzUBobCUlvMeDGrUce5cufIWJc7y1kPZdDHxkfsShrFdlnHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772259647; c=relaxed/simple;
	bh=7Wk9qb2ySwAe2khby04kCSv1Lvb5ruTY1+SMwY+Xzak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RxOvCjXYXKEz2hfCVP6bThGZkpljmTK9i3o8+79hOgmF9bOpmsPaMt3Gq/83slzDlGJk0572wBznucIShmpndXCLhVBvvpSpvXKPn2+vczBp0B+9A4j73pZ8WC74d91M/opyv05tml73ejB/mIwhvFvdXUJEpeBz3kaIowmYKeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=Sb8umgNJ; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1772259597;
	bh=iAJCcEjNXOfr3RUGBP7yCArSccqA7SMtauWurX5wuVA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Sb8umgNJLBQg+nWL0xAwbdKzZeDcBT1PYEwANkueubcAkwtC/E+6YVnsUDNamlzQc
	 vPZuHfDmDHbQ6PHvlTHnTjKPCH1EB7GSA1nrUplm8uYGRhupZgROpxE0le+7+gsTLP
	 tMTO99iky8bQKa58xE7Hz/L1RQ0BW38hyZGuvd6s=
X-QQ-mid: esmtpgz13t1772259590tcafb1a38
X-QQ-Originating-IP: O3S9CqHPs84TYy9qZx81p/6Zq4g9X3YPhu0NjBpOjkg=
Received: from localhost.localdomain ( [116.172.93.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 28 Feb 2026 14:19:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6789830308910173924
EX-QQ-RecipientCnt: 9
From: Kexin Sun <kexinsun@smail.nju.edu.cn>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lachlan.hodges@morsemicro.com,
	julia.lawall@inria.fr,
	xutong.ma@inria.fr,
	yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg,
	Kexin Sun <kexinsun@smail.nju.edu.cn>
Subject: [PATCH v2] wifi: mac80211: update outdated comment
Date: Sat, 28 Feb 2026 14:19:44 +0800
Message-Id: <20260228061944.887-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260224021548.1394-1-kexinsun@smail.nju.edu.cn>
References: <20260224021548.1394-1-kexinsun@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: N5JerYjHf2ib/2qrGwagsX4/bAwMV+aVyv6GpZcFyFgLHnENfdHLLaOR
	TaxdkBNhOe+xBp1k6tXKaALs7EfS9t8ma9YkFpQUyiusOBOVou5rB6HnJ3z5er7Cq69O8Ol
	kl26qHHCXOCZzSV1dGfbMl/koaS7CtCeP9k2Uvz7wAzHKaWWB9aRJRCIb966hOC9W6dRBpf
	3tTS2YKaeknCDS1h/qN7xwntmwi/PkW8gJcMNVTs0rkoUlHIRb7SNprdNJ0EIAdXJxmf1Vf
	6O7aC5ryeCIP8MngJm05RAXWBcP8eFyLWukv5VoPrlvjWSjeN61zGc/hK+tWC+7Gg3M3xjS
	6MgK8hEWgdMbgXO1yaVPSr5f1lpFRjnCtPcDvvHfOsPp6lmVrNtsYI67CFtacmscF4ufl05
	ujx9W3nLj+aqvpeW6urM5KpMvUEgfkOLk513C3X3A8SX9AwXjCTwapNgtQEKZRw0d3zRg+z
	geyfjaLW1TMQ9U/WCtd8sW/7aki9KYhavdbE4F36n66x+Dp004DmrKYPq+Q2/5iC8Ycd91k
	gpi04sgl5mQ6GiKhLsmtcS4zMeUR8ZKFMKbg59PZzIs5+Vd9Omh18oeAxMqsPzMaRjMHvwx
	gu4IYww5qGQ4oOnIJdLX8jEOTI+GmqRHhw4qlQbJNW7Y5wNFVF2WyFONaG81j/v4m9b3MJD
	v9oiYIVV1a3VzNXRHFbXCH9go6FrnNCpcAtGQVucB7Ys1bkDTg0HUz60cPJ/RXrr80b+nz9
	F7hhv79Ieqf2wJxPt40M4uJyyOM0Ab23ZINe7bI0/9tuLjvD2dHDkiiquP+NpD3VtaaPo3t
	KMvrogsR3/pJz38Iy0aqNARgSOptO6EfJQrK2+hgspxD83do0guDVrYDQerkxH3zoRxFMBS
	k+y7UmO7UDDMLg7yyEu6+WcJK9qPlfndJO8CbcTAvansf4QK7jgS+/Ic5UOw7Zsun8kU1Mr
	AokzQdzYy1iI7dX2QjcxklXJ9d4DYye1RASA/LRZ8HH4nuREvOxMp63jLpR3Cmx5hx0TIps
	GPJGJSH6bIzCttf6IjBQNJy8/HS5g1N5Ef1cEVTPiU3KfU8E+8rHYzWBCrHB3ts3afm18GW
	VgFDfIFV01+bwWULHoIVmsDMsfC+b+ZybTXSvdJSDtt5eAXXD9nY5r6niYhmwLSRA==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[smail.nju.edu.cn,reject];
	R_DKIM_ALLOW(-0.20)[smail.nju.edu.cn:s=iohv2404];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32306-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kexinsun@smail.nju.edu.cn,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[smail.nju.edu.cn:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1630A1C08C9
X-Rspamd-Action: no action

The function ieee80211_start_scan() was refactored and replaced by
__ieee80211_start_scan() in commit f3b85252f081 ("mac80211: fix scan
races and rework scanning"). Update the comment in
ieee80211_tx_h_check_assoc() accordingly.

Additionally, remove the broken gmane.org link in the comment.

Suggested-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Suggested-by: Johannes Berg <johannes@sipsolutions.net>
Assisted-by: unnamed:deepseek-v3.2 coccinelle
Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
---
v2:
 - Removed the dead gmane.org link from the comment as suggested by
   Lachlan Hodges <lachlan.hodges@morsemicro.com> 
   and Johannes Berg <johannes@sipsolutions.net>.
   
 net/mac80211/tx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 8cdbd417d7be..6dbe17f7aa74 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -287,10 +287,7 @@ ieee80211_tx_h_check_assoc(struct ieee80211_tx_data *tx)
 		 * active scan) are allowed, all other frames should not be
 		 * sent and we should not get here, but if we do
 		 * nonetheless, drop them to avoid sending them
-		 * off-channel. See the link below and
-		 * ieee80211_start_scan() for more.
-		 *
-		 * http://article.gmane.org/gmane.linux.kernel.wireless.general/30089
+		 * off-channel. See __ieee80211_start_scan() for more.
 		 */
 		return TX_DROP;
 
-- 
2.25.1


