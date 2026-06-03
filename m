Return-Path: <linux-wireless+bounces-37365-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K4dnD3eBIGrU4QAAu9opvQ
	(envelope-from <linux-wireless+bounces-37365-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 21:33:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B59963AE0A
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 21:33:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=justthetip.ca header.s=key1 header.b=xGDSb7IA;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37365-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37365-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=justthetip.ca;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78DDD30160F0
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2026 19:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF633176E0;
	Wed,  3 Jun 2026 19:29:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195D12BD00C
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jun 2026 19:29:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780514954; cv=none; b=gM3poRceqKjLFVCt2P5CVGWdRZeyYD8Wz5qNUfUc44MpCi2zl7A3Wgos43DBAmRSVVg+rWL0ShOxI/mxjVbNT82UEgvpJGOD3cFS4saWceYBBQS2k6vOfI+7CIxfJDTNKmXTR9pEqU6HjYZlv9/K4vTHzKta2Fl36eZxy5qRj5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780514954; c=relaxed/simple;
	bh=b8s9MyaKyI5INLezHk1dcLXoNWO2SNHVAIksnvEGv/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eZZk7eSPKUvTvmXJQCFZSQUAk5vRE9I+Qhyh61bpQ1dgRbEGEuNV2jRgMK4pHiJH//ATGWJz7gyhCDbTUC0mAM3VM9end8y30y95lN9MFWYI6RU5lue93Zcd1S/WGxnGu2Flzp4Y7uW6HScOevQIVsFvPAe8AwHFGUjrc9F+l0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=xGDSb7IA; arc=none smtp.client-ip=91.218.175.177
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1780514950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nCFhc3WlhCwhpl8dws8Ce7awF49P1ZMA2kRsFwUbIGY=;
	b=xGDSb7IAxVdsiMyjxK4e1pZc9dHod6ApsA4llroP3m2qA0W5+vPBdzxhRlffuGIel2Et2d
	TRykfQYzwmWE4vpfmxdtVIVKUKWBl5NZEMXJ/+Am7403siaCSEKqb2v5QZI39JDjmVnxcL
	T3vzNTBqV1NllsDvxQduB+gWJ2vniY7TjUC8qB/mekFRCXHV0UULZJNrqMk9TGsTZgBU1P
	5JsERu6r1lvS4TN4VUZoS5sWC2mvcPtm8jbXX7hnUdvoKgcEm5Cis9IiRJyBRDnVXV6NF/
	q3zcU8gE1Ac/vkBh/bdmv4pgVyw2bJoGyOzBxozbpGnH6S0vCgC9eyva2B4JOg==
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-kernel@vger.kernel.org,
	Oscar Alfonso Diaz <oscar.alfonso.diaz@gmail.com>,
	fjhhz1997@gmail.com,
	Brite <brite.airgeddon@gmail.com>
Subject: [PATCH v5 0/1] wifi: mac80211: fix monitor mode frame capture for real chanctx drivers
Date: Wed,  3 Jun 2026 12:28:53 -0700
Message-ID: <cover.1780513445.git.lucid_duck@justthetip.ca>
In-Reply-To: <20260519235713.49109-1-lucid_duck@justthetip.ca>
References: <20260519235713.49109-1-lucid_duck@justthetip.ca>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[justthetip.ca,quarantine];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,nbd.name,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-37365-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:johannes@sipsolutions.net,m:nbd@nbd.name,m:lorenzo@kernel.org,m:linux-kernel@vger.kernel.org,m:oscar.alfonso.diaz@gmail.com,m:fjhhz1997@gmail.com,m:brite.airgeddon@gmail.com,m:oscaralfonsodiaz@gmail.com,m:briteairgeddon@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,list.next:url,justthetip.ca:mid,justthetip.ca:from_mime,justthetip.ca:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B59963AE0A

v4 [1] used list_first_or_null_rcu() plus an rcu_access_pointer() check
on the sole entry's list.next to confirm it was the only chanctx. As
Johannes pointed out [2], list.next is not an __rcu pointer, so that
check trips a sparse warning, and his original loop is cleaner. v5 walks
chanctx_list with list_for_each_entry_rcu() and takes the sole entry
instead, which builds clean.

v5 also switches the stable tag to the noautosel opt-out, since the fix
can crash older drivers and should not be auto-backported.

No functional change from v4, so the v3 Tested-by carries. I rebuilt v5
and reran the monitor injection test on mt7921e here, no crash.

[1] https://lore.kernel.org/linux-wireless/20260519235713.49109-1-lucid_duck@justthetip.ca/
[2] https://lore.kernel.org/linux-wireless/978c9a11cf836680b1fd9365f3b90f028ddf5372.camel@sipsolutions.net/

傅继晗 (1):
  wifi: mac80211: fix monitor mode frame capture for real chanctx
    drivers

 net/mac80211/tx.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

-- 
2.54.0


