Return-Path: <linux-wireless+bounces-36610-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNxeJnxHC2o7FQUAu9opvQ
	(envelope-from <linux-wireless+bounces-36610-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 19:08:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 261325716E8
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 19:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08CF43054516
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 17:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7235637D107;
	Mon, 18 May 2026 17:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="ISsuNxnk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAB737BE83
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123735; cv=none; b=ly9zNBma00UDrseQ+OyAz4Dll/6yacdKdyUcKZRI0ysMqMC6g6oWSfynSAV4gZbcF+HdNjj99gvagPlw3SvJJs1E4WXBtknlZy4k0Uq0EM7YHBLRWwOdfFzHs/C+gSO9mJptuVLIKe0hDvAsTqOeWPVN0mKkqE1NFG48oQI4ep4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123735; c=relaxed/simple;
	bh=zfRWNKJw/Y0qg1loJVvUjMgTwYSxj8FCErKYtehASys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TWnRt8iDdZUeIQohQtX8dJ6q/KS8qLPRAQvwnYqPJQJCMn1KK2/by3slgyOS4WNoTAJp2eNXve/RlUnnTVpFOBp+LRFxAtch0RRlldDJCKNGSnuVtmdPs3UnAmWh2pkazDpGeSELqDqs0HZbPK2/krfnROmB9Z9hN9N8nDIpneA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=ISsuNxnk; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1779123729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jx+/uFpfX1YYemeTrEW7LOAvWeEpWKhwrZRtiB04gYs=;
	b=ISsuNxnkYEQOJ9DdT2f+ZQiinBjlF5rDLlbK/RmKJ55kgo3yw73aalXfhEqKw8riL6t00Z
	WQG+wdkAQ+M47dfdSNXXlPK1y/Ypes+/2n2ndSEPVovDDFaF5JNkymgs09b3T6R8qMDX2X
	sdcM0k35/skf2DCtIsiTrw0EnDUBdIosGQFbjQJQvGnml+0EUKPcCjaC1/ICOe2a7wDgie
	FSKkap0X8Fthm2vuW2EoUrC5lZcjBbAjZuN7ZdP8Xa4hjxZRy8OHp423RgbhEa0i/tLbFc
	N3P96X2nbblH5JnhXsDA7ozEDRmyyjxOYY8Ei3HQqyV487bLVelxu6JcBe2wWQ==
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Oscar Alfonso Diaz <oscar.alfonso.diaz@gmail.com>,
	fjhhz1997@gmail.com,
	Devin Wittmayer <lucid_duck@justthetip.ca>
Subject: [PATCH v3 0/1] wifi: mac80211: fix monitor mode frame capture for real chanctx drivers
Date: Mon, 18 May 2026 10:01:46 -0700
Message-ID: <20260518170147.13885-1-lucid_duck@justthetip.ca>
In-Reply-To: <20260308164510.5927-1-fjhhz1997@gmail.com>
References: <20260308164510.5927-1-fjhhz1997@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[justthetip.ca,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,nbd.name,kernel.org,vger.kernel.org,gmail.com,justthetip.ca];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36610-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,justthetip.ca:mid,justthetip.ca:dkim]
X-Rspamd-Queue-Id: 261325716E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v2 [1] used list_is_singular() + list_first_entry() to find the
fallback chanctx. Johannes pointed out [2] that the pair is the
rculist.h anti-pattern: the two reads of head->next race
list_del_rcu() of the sole entry between the singularity check
and the entry fetch. v3 uses list_first_or_null_rcu() with an
rcu_access_pointer() check that the entry is the only one in
the list, as rculist.h suggests.

The v2 user-visible TX path is unchanged in v3, so my Tested-by
from v2 carries forward: the airgeddon evil-twin flow on mt7921e
PCIe + mt7921u USB + Kali VM with MT7921U passthrough still
applies.

[1] https://lore.kernel.org/linux-wireless/20260518064025.96792-1-lucid_duck@justthetip.ca/
[2] https://lore.kernel.org/linux-wireless/70c49e598ffba2864c8168c7185c0abec76b59dd.camel@sipsolutions.net/

傅继晗 (1):
  wifi: mac80211: fix monitor mode frame capture for real chanctx drivers

 net/mac80211/tx.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

