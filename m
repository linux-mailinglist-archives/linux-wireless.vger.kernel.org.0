Return-Path: <linux-wireless+bounces-32433-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6N1AEurXp2kRkQAAu9opvQ
	(envelope-from <linux-wireless+bounces-32433-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 07:57:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A70641FB561
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 07:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C4793067FD6
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 06:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7764D37FF79;
	Wed,  4 Mar 2026 06:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mYiBJZGy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B43A37F00A;
	Wed,  4 Mar 2026 06:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772607433; cv=none; b=oZAUFYIicn/W19dKiLNwgtuBKCt1URsd7k51GbYisyjQdDCDUcwlsWzbVyTLJlCJd1ntXl21F764Az3C3aqXCmpax97UNTZWwFu6DrqkMlOl4azc1B1M4xkUUM2nREea3qyNm/t4+o5khaFtXBtDLZpvfQSCsfFPFNt+5Ke4Mnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772607433; c=relaxed/simple;
	bh=/IAZNGb8U+o1n4QhnJ3f6gmcEZ4hlQTiBODEJe2qmk4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SXfjqz92boM8LadakHRBxeowylrCxb6nR4ofe2ktARQc7AFEcIITeCJXgtUR7yyn4GFmUYnT+do6xXQEYsUbbCIltRMwDs3pGBO5wwwqcvUIZ8uueSw+rTvWCPvhTzQ+F5qcDat+2lNrg4ONa5KueyoOGB/NtHPJB8AqJHNMzfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mYiBJZGy; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3+EnodLK0qo4vNFhzJGniE+KK/MTe7ewq/aS9nxSw7w=;
	t=1772607432; x=1773817032; b=mYiBJZGy6We6Y7TT3xrUPF4FHGDUGS0behWIivtngLya6XA
	QV/J9AColVaAfuGHR4cPI7u/EzBjk7PJucm98HguMc0K8g2hT2j+lJyWMJ7Pjk6zJqws9VEy4yEoh
	+vLUcoiUj+GZaxrwDD+Kw13PIW0ftjtUwGnT9t+SDFHEM/vuTEgmQ/AqylKXjHCngwa/4ikTXKCgg
	84uuaAQRDzrhiaDoxCT6S9cJwnaMfjQvN/UZtqBZxKvQBiIiHmmIwaHpPYyQUVN+EOykYlJWcnTpS
	7QFwWtC4UaVBZpkCkqBpxYZC+HiV12OrAy9oE1saduXT+SwNaOg057p4u2p3cUlQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vxgAI-00000007vRb-0A7m;
	Wed, 04 Mar 2026 07:57:02 +0100
Message-ID: <4b5584f3277d667bead0b851c5bdc5cc07e80183.camel@sipsolutions.net>
Subject: Re: 6.18.13 iwlwifi deadlock allocating cma while work-item is
 active.
From: Johannes Berg <johannes@sipsolutions.net>
To: Hillf Danton <hdanton@sina.com>
Cc: Ben Greear <greearb@candelatech.com>, linux-wireless	
 <linux-wireless@vger.kernel.org>, "Korenblit, Miriam Rachel"	
 <miriam.rachel.korenblit@intel.com>, linux-mm@kvack.org, Tejun Heo
 <tj@kernel.org>, 	linux-kernel@vger.kernel.org
Date: Wed, 04 Mar 2026 07:57:01 +0100
In-Reply-To: <20260304030835.610-1-hdanton@sina.com>
References: <fa4e82ee-eb14-3930-c76c-f3bd59c5f258@candelatech.com>
	 <18c4bfed-caca-bef3-a139-63d7fa48940a@candelatech.com>
	 <e7d92fab-9d0e-4a58-aa0b-2c6545772e68@candelatech.com>
	 <3456b2c89f057900b39ce79ea8ca1154c5014e43.camel@sipsolutions.net>
	 <0de6c8d1-d2fa-44ac-8025-cfcfecd87b02@candelatech.com>
	 <bed9cc03d3c214b2601093f91e4b00f3715762b2.camel@sipsolutions.net>
	 <c616fc41-3bc7-4ddc-b65c-a622111d8548@candelatech.com>
	 <20260304030835.610-1-hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Queue-Id: A70641FB561
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32433-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[sina.com];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, 2026-03-04 at 11:08 +0800, Hillf Danton wrote:
> >=20
> > Fair. I don't know, I don't think there's anything that even shows that
> > there's a dependency between the two workqueues and the
> > "((wq_completion)events_unbound)" and "((wq_completion)events)", and
> > there would have to be for it to deadlock this way because of that?
> >=20
> Given the locks held [1],
>=20
> 	kworker/1:0/39480	kworker/u32:11/34989
> 	rtnl_mutex
> 				&rdev->wiphy.mtx
> 				__lru_add_drain_all
> 				  flush_work(&per_cpu(lru_add_drain_work, cpu))
> 	&rdev->wiphy.mtx
>=20
> __if__ there is one work item queued __before__ one of the flush targets =
on
> workqueue and it acquires the rtnl mutex, then no deadlock can rise,
> because worker-xyz gets off CPU due to failing to take the rtnl lock then
> worker-xyz+1 dequeus the flush target and completes it due to nothing
> with rtnl. Same applies to the wiphy lock.

Right.

> BTW any chance for queuing work that acquires rtnl lock on mm_percpu_wq?

There really is only the work I was describing and vmstat_work (calling
vmstat_update) on that workqueue, afaict.

johannes

