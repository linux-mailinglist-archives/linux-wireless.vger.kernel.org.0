Return-Path: <linux-wireless+bounces-34222-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCf3I2H7y2mcNAYAu9opvQ
	(envelope-from <linux-wireless+bounces-34222-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 18:50:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CF136D3CD
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 18:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 81D0F30532C2
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 16:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB51426694;
	Tue, 31 Mar 2026 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="nBx3QgdF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1374C426686
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975291; cv=none; b=riy+l8y10PDJVBZD0o8n10cyW+SzC7qzYkXgl8WDdZ3UNfq1pODre+2p4R8nwDpBfKKzodt4xin3pApmGBDT1Tqj0t2JibhcFVVrfdqgGrArUWnWVokxiU+48YFDHucJyHLjZqwY2iCW34tbm2tQ+K++RfHdGvzIRVB4WVE2ha0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975291; c=relaxed/simple;
	bh=95J9+dCH3cWEBjsztolgGJJchHofbcIg6SN92OQYi2U=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=TOrqu4egRoja5LMM2UtgRQhHFbF8qg4pwQrIue7Jn4SWn1UyMMY3lfH61uAXajJac9Fbe5lZPmdt92791su0Th6KsgJhbDYiG8kY6yqpLtNnOGr9ILvpJznV6sWe9tsBYGz+MiojWhteu/IonkHs8x9dB+srIOA5U2hZqKoonDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=nBx3QgdF; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1774975286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=95J9+dCH3cWEBjsztolgGJJchHofbcIg6SN92OQYi2U=;
	b=nBx3QgdFYM5Lz/4mGKLt76lC7U2D5MBD4ndIGR9jqfDzEDeuKGYfxISmZrbVYGzh0VmCwk
	aul2gOtKyCsyrLU25+Kft8/cciHCDGWchB4+Zwq4LcIV2QaG+rteE7FTYa6W2VPex3gYoI
	zov3L24fhXDozqGCNPwUJDPgJ/buoaIyYOqb7E6hOp144lwgJ/nv1NE5PoqPMy4Oy9ojtT
	54hVbAy+gfYYvQgAXfXE/pqIbOY8rg4P4bwmSpS99pEARGb6RDPBThHbZrg9jNljnFWRQ4
	DgmHGTGWg0ndJbDr2OwvN826OqQo1iUyTu1CyzJGFgdCeQh71sxDIOgz7ZIPLg==
Date: Tue, 31 Mar 2026 16:41:24 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: lucid_duck@justthetip.ca
Message-ID: <630ad945be38b7a97ffbb2a02524b7728c9efcb7@justthetip.ca>
TLS-Required: No
Subject: Re: [PATCH 1/3] wifi: mt76: connac: use a helper to cache 
 txpower_cur
To: "Felix Baumann" <felix.baumann@freifunk-aachen.de>
Cc: linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org,
 lorenzo.bianconi@redhat.com, morrownr@gmail.com, nbd@nbd.name,
 satadru@gmail.com, sean.wang@kernel.org, jonas.gorski@gmail.com
In-Reply-To: <3f4103d9-4871-4ae8-93a7-d286fce37443@freifunk-aachen.de>
References: <20260327021534.448552-1-lucid_duck@justthetip.ca>
 <3f4103d9-4871-4ae8-93a7-d286fce37443@freifunk-aachen.de>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[justthetip.ca,quarantine];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34222-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,redhat.com,gmail.com,nbd.name,kernel.org];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 08CF136D3CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Felix,

Thank you, and thanks for reaching out.
Yes, absolutely -- my real name is Devin Wittmayer.
Sean is welcome to use it for the Co-developed-by tag.

Cheers,

Devin



March 31, 2026 at 12:59 AM, "Felix Baumann" <felix.baumann@freifunk-aache=
n.de> wrote:


>=20
>=20Hi Lucid Duck,
>=20
>=20thanks a lot for your contribution. Very much appreciated :)
> The kernel has a strict policy for contributions: real names only.
> https://www.kernel.org/doc/html/v4.11/process/submitting-patches.html#s=
ign-your-work-the-developer-s-certificate-of-origin
>=20
>=20May I kindly ask whether it would be okay for Sean to use your real n=
ame?
> https://github.com/Lucid-Duck
>=20
>=20--=20
> Regards
> Felix Baumann
>

