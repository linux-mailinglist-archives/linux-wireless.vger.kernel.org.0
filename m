Return-Path: <linux-wireless+bounces-31332-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UD6/EbyHe2mlFQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31332-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 17:15:56 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B85B201B
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 17:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34A03300EABB
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 16:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB3731D39F;
	Thu, 29 Jan 2026 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XvbtECjV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E036285CA3
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703057; cv=none; b=XIl4jScuN8EPhd2I+TbEfoeJ/LflWwOj1+stO/P90xX+2Ra/GajVeWSqvaekYZLG0z+TfnnN6oZ0EaKSfvB19sBAAph9CTL547m36Sra1hQwhEKnWreg9Yzvpf6AKGMfPSTAg5FYsxIufe9o5fcaBz3lxjq2C1orXqh7H3o5UcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703057; c=relaxed/simple;
	bh=dAhCIlORyVc17XXSomYiI26F0bQHZPIEjshkUCdCeYA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i6XMuvdqwe/33SuBjqd97LlPChF74nYIdwfV11GlDp5HlE46RjDEk/1vP8kgCOdLp3hXND0VHCcg89LIw8k8VNdFCdcIis5rBGpV/O/SHvcpImvwVa6ep1qtRRUgrJJHJ1OScBpB6Hx7D1J/QcEuVUbyWcU6LsZrAdrV8MZrtSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=XvbtECjV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hia/cXnz7m569Ox/FntVf2ETEnXmYjgylgC30iiLrPk=;
	t=1769703056; x=1770912656; b=XvbtECjVTCjiD+wXEk2+oJR8oljuB8EiQLo5RXpc1ec8LuN
	eSNe6pJQkpuSPYEj9sh6VExCmjSPSG7cuaLIWtO955BvhCZUS0vH8o7LN/o0fLvQ+LvuMD7PqhI0Q
	S3oyoT8ewtYfZp7KzZm/uPtMDE7MdS2H7xvOLYRUbMiSodJln0YfDhCu/6wzk6fEg6bYLC8YPfNKM
	SK6ZHBBiFNRrz4Cj+mPE0Empnl3WXI+SALiO+EAMn/MEorGTbwJpf9TWQto9SWAch9jPpBlRlF7vL
	p5Yi0t1vu1dd8/YJE6QVLJn2aOZFW/QmnvQEiq/j2pb97npIQOsPxN037wGafOEQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vlUbd-00000006x1D-44NH;
	Thu, 29 Jan 2026 17:10:54 +0100
Message-ID: <587d823b0a900d02f78a552d9cb350ef4fc0766c.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v6 1/3] wifi: ieee80211: add some initial
 UHR definitions
From: Johannes Berg <johannes@sipsolutions.net>
To: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>, 
	linux-wireless@vger.kernel.org
Date: Thu, 29 Jan 2026 17:10:53 +0100
In-Reply-To: <2144630f-6abd-4a97-821a-51cada015867@freebox.fr> (sfid-20260129_170325_763720_4F6260EC)
References: 
	<20260129134944.a84420ec58d6.I5b11fb0345a933bf497fd802aecc72932d58dd68@changeid>
	 <2144630f-6abd-4a97-821a-51cada015867@freebox.fr>
	 (sfid-20260129_170325_763720_4F6260EC)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31332-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: B0B85B201B
X-Rspamd-Action: no action

On Thu, 2026-01-29 at 17:03 +0100, Pablo MARTIN-GOMEZ wrote:
> > +struct ieee80211_uhr_oper {
> > +	__le16 params;
> > +	u8 basic_mcs_nss_set[4];
> > +	u8 variable[];
> > +} __packed;
> > +
>=20
> I've just noticed that all the other PHYs have a type name=20
> `ieee80211_*PHY*_operation`, it would make sense to keep the same=20
> template for UHR.

Meh. "_operation" makes those names get really long, and everyone
probably already has a bunch of code depending on this, so I don't think
I want to change it now.

As for the _cap vs. _capa, maybe that's a better argument, but it's also
not _quite_ the same between all the others (e.g. "...vht_cap" but
"...he_cap_elem"), so... I don't think changing it now is worth the
cost.

Qualcomm folks, what do you think?

johannes

