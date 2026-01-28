Return-Path: <linux-wireless+bounces-31265-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LqhBJHPeWnezgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31265-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 09:57:53 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A729E851
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 09:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8110A300916A
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 08:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E342033A9C9;
	Wed, 28 Jan 2026 08:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cP01htQL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0294433A9F0
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 08:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769590429; cv=none; b=MI6/VSmVmeKk9W9mLPKOBgcKVtPnYnCKibCeGMRbRNJH0E1T8Y9oTAHOkbcw5SLIjEjzN5RRyVf7bQSPvXgGl4rICE8Hd6oZiH2pCmS1TsRi2JSBrVoHe3JIcCElZ1TezUPnnrqzl99bo+pE4/KhWqagxvGTaHpSeuFZ9EgXsMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769590429; c=relaxed/simple;
	bh=5m7J5rDw9WY2h4fLSz7rRDf6IUclfItjW+xf93dPY6c=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=F0QQXbNWd0bEM+bWmZECrOg/R/GIVlpFu7zEv53dA1R+84vsUCJs82CEiKXuGJ+y156DWBroy4lvwTDhnFKqHJpInbpDZUbwDDtnvpGZ3evq9cd2WFrg5CUhwSFTC0suSgZ0D3c6Y22OMAS7a8e82x7k975Xyqc9P7qrSaZegsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cP01htQL; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769590422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5m7J5rDw9WY2h4fLSz7rRDf6IUclfItjW+xf93dPY6c=;
	b=cP01htQLonr9ql3iusuwyORkcSoYe16/u7G2bg2tQdukMeqmMcW0McRBB02DCgEblGZcPi
	hYuNpRZ9bvFYVUVYW5zdvr8KDLCUNF08AkJ68795fqNul4Vq4VRAM72wfIstRZU0pbbxdF
	XkdzeRzUvIrmqrDQq/0YVNv+By/xrKQ=
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Clarification on the usage of NL80211_SCAN_FLAG_FLUSH
Date: Wed, 28 Jan 2026 00:53:28 -0800
Message-Id: <BC4134D5-2915-488F-B785-EA5EAEAD71CF@linux.dev>
References: <a4afd8690916a518e3919c52770fb423339b321d.camel@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <a4afd8690916a518e3919c52770fb423339b321d.camel@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-31265-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.schwartz@linux.dev,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 04A729E851
X-Rspamd-Action: no action



> On Jan 28, 2026, at 12:39=E2=80=AFAM, Johannes Berg <johannes@sipsolutions=
.net> wrote:
>=20
> =EF=BB=BFHi,
>=20
>> Is this intended behavior of NL80211_SCAN_FLAG_FLUSH where it clears all B=
SS entries regardless of which channels were scanned, or should NL80211_SCAN=
_FLAG_FLUSH be limited to channels that were scanned in the request which tr=
iggered them? The uAPI definition for it is simply "flush cache before scann=
ing", but this seems open to interpretation as to whether it means the entir=
e cache or just the cache on scanned channels.
>=20
> Well, AFAICT it has always done that, and so I think regardless of what
> might have been the original intent, it simply is that behaviour now.
> Changing it in the kernel would just end up having to fix two places,
> unless you somehow don't care about running on older kernels without
> fixes.
>=20
> I also tend to think it makes sense since the scan could, at least in
> theory, do e.g. colocated scanning, so networks on channels other than
> the ones explicitly listed could be discovered. Trying to do anything
> other than "flush all" would be far more complex.

Okay, thanks for the clarification. I=E2=80=99ll try and take a look at how i=
wd is using the flush then because it seems like it=E2=80=99s overusing it, o=
r maybe needs some other logic to prevent the connection issues.

Thanks,
Matt

>=20
> johannes

