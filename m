Return-Path: <linux-wireless+bounces-37758-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4cUYGI6kLGr0UAQAu9opvQ
	(envelope-from <linux-wireless+bounces-37758-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jun 2026 02:30:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE1867D4D8
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jun 2026 02:30:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=justthetip.ca header.s=key1 header.b=lWvGRAxj;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37758-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37758-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=justthetip.ca;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C5CA30071C4
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jun 2026 00:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC1C1A2C0B;
	Sat, 13 Jun 2026 00:26:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865BF1C860C
	for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 00:26:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781310362; cv=none; b=VeDE6X5DXkqg41YDFu+CUiOtSkZRSlOS9vbmz2BedJg59VF0zT/Dnf79g5ZExeYFnwbsMiok9p70NA9kBkC6A1KyGMfd4/sk34sWpDVY2Xd4q4QHmntUHHllb04rMoyDSoScVsM0nwwf1cU/W2/177v62eq7wvvr1CuDMJlL/9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781310362; c=relaxed/simple;
	bh=btGZf0zaEtFcs/VlS0deqYjgdc78yzlXvgTvq5mmoI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iPqPGb5VQxZD52ktXBHIPxLeX8hVuXlRTQ8BItjsxoVKoFqGakjRGjzfne35DwCABBkQWVoeEbU4jY7bozxHTTLWqWkvBXW+v5gSAdbgztmRxK8n/dafMeEJew7N9MdqUW7Ky+u3jv5L11DLN5vK+Pokk2+gRUeaKdqSm8bSXjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=lWvGRAxj; arc=none smtp.client-ip=95.215.58.183
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1781310358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F+40+W/SToROBFqH2IoKRWBn15xftg9kvs9vbYQreMI=;
	b=lWvGRAxjrbmf63WX1cPP4YclnLLLqU2y6UOqv++pURZnMGD8+MYFB0Ib2FLExYsh8f1lzb
	bDmM8L3cP+OMpEEASPIgJ/Cik8yqU3d/ZzZacl+mxduvcXz5+RFAvC+dJCrFFVJ3OP2K/k
	kSKoLzRk9fP8L0KC7bzN79P40kba8m0OZ0QMooRNU5xZ9/27VyBr7QnOXU0ZOrkiBU3iI6
	m9TYqTK/OCMrJwxAXQmPZrM5LYgiNDHQJcbwwNz39/HL+q56I6F6tTySxpFsFkkrG86Yak
	u7sq8htGUWFoZAFQ13BCZhv+u8xne+uEymM+05bdUyjQIQTzh8XzKeafjD3hlw==
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Devin Wittmayer <lucid_duck@justthetip.ca>
Subject: [PATCH 0/2] wifi: mt76: mt76x02: rx fixes for fcsfail monitor mode
Date: Fri, 12 Jun 2026 17:25:42 -0700
Message-ID: <20260613002544.27750-1-lucid_duck@justthetip.ca>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[justthetip.ca,quarantine];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37758-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lucid_duck@justthetip.ca,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[justthetip.ca:dkim,justthetip.ca:mid,justthetip.ca:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AAE1867D4D8

Two small mt76x02_mac_process_rx() fixes for monitor mode. Patch 2 adds
the bad-FCS reporting requested in morrownr/mt76 #38; patch 1 drops a
WARN that fires on corrupted frames under the fcsfail filter, which I hit
while reproducing that issue on an MT7612U.

Tested on MT7612U and MT7610U (mt76x2 and mt76x0): in fcsfail monitor
captures on a busy channel, corrupted frames get the radiotap bad-FCS
flag, clean frames are unaffected, and the WARN no longer fires.

Devin Wittmayer (2):
  wifi: mt76: mt76x02: do not WARN on invalid rx descriptor length
  wifi: mt76: mt76x02: report rx FCS errors to mac80211

 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)


base-commit: 972c4dd19cb92e03d75b66c426cfade07582a1ba
-- 
2.54.0


