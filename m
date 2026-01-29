Return-Path: <linux-wireless+bounces-31309-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMpgFk4ce2msBQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31309-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 09:37:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAC1AD95A
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 09:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E938301EC95
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 08:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D8437C0F8;
	Thu, 29 Jan 2026 08:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="OjpjgBg1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B3C3793A8
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 08:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769675584; cv=none; b=HrwCZ2Ay1NgtOOy3jI4fk+VXbTcwWBl1dswqbaNNDtXEmejLJ5tO2FORC9y7zhQ2joim0eoD5gi7XHbChEksbRq7P9tkvYMvXQel0xP9ryi12TJu2BmYDbmYklCE0j8rx0VYt5Q7bcU32hcRvNADs6q6HaSviMAuxegqGXAgU2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769675584; c=relaxed/simple;
	bh=lvitsj6P+rA26ZRaQb+chdhh+vuhIbrz1IyM6qMxVhA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m8sRrHx5pI4/1utGrINWH8lrGUdBDpiKJ8dUjCfvVwk8uTHJgHBX7tlnSa9ihhuNlX1tv3g7JFgGwuysxvWr84du1s1aj/ZXKY2QsC3DOpnKBnvA9Lu7g5J2Ktm+oGOWnp6X2G/WsHP92qn2cTS2c/Bsq0ugC2o+mTKPc6jvgeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=OjpjgBg1; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=lvitsj6P+rA26ZRaQb+chdhh+vuhIbrz1IyM6qMxVhA=;
	t=1769675582; x=1770885182; b=OjpjgBg1r8fjNFxKW8/t3WhY/qqCCn+MnduEuFJLxGom2Gm
	gdsfQl4mXPAvIuKNmUS1vSXrB+0nWY1PhmCHgSAeRYSB4L5+hA9jtjzgMQaitK17iBNxRFUf+P8Jl
	7NXZKIyKNGRN8FBj07lvmcg3ji1ej3ez5cFnfK0oxTXDY1DVQE3Q57SVXV2s3Ua6RGLkdQsvh64BM
	kPkNgF+YRF41rsTV+Lw9qVBKx8W/YHDiNELh92vwFJoi8X6RkM8aJfk6t0ve8+sqS6EZeloSdSzW3
	GpK6Uw55eUDEpS7QskERkrz6xTZfHWJeVYe4IPpvkZRPwXvjKsWLHKw69HDVD/Dw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vlNST-00000006jJp-23Xm;
	Thu, 29 Jan 2026 09:32:57 +0100
Message-ID: <048f0d8d0686cea35267bff16f824105cfa81936.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: mac80211: use wiphy_hrtimer_work
 for CAC timeout
From: Johannes Berg <johannes@sipsolutions.net>
To: Amith A <amith.a@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 29 Jan 2026 09:32:56 +0100
In-Reply-To: <20260128064856.3667270-1-amith.a@oss.qualcomm.com> (sfid-20260128_074909_881241_C9EE6856)
References: <20260128064856.3667270-1-amith.a@oss.qualcomm.com>
	 (sfid-20260128_074909_881241_C9EE6856)
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31309-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 8CAC1AD95A
X-Rspamd-Action: no action

On Wed, 2026-01-28 at 12:18 +0530, Amith A wrote:
> Prior initiating communication in a DFS channel, there should be a
> monitoring of RADAR in that channel for a minimum of 600 seconds if it
> is a Weather RADAR channel and 60 seconds for other DFS channels. This
> Channel Availability Check(CAC) is currently implemented by scheduling
> a work item for execution with a delay equal to an appropriate timeout.
> But this work item is observed to take more delay than specified
> (4-5 seconds in regular DFS channels and 25-30 seconds in Weather RADAR
> channels). Even though this delay is expected in case of delayed work
> queue as there is no guarantee that the work will be scheduled exactly
> after the specified delay, a delay of more than 20 seconds is too much
> for the AP to be in non-operational state.
>=20
> Recently commit 7ceba45a6658 ("wifi: cfg80211: add an hrtimer based
> delayed work item") added an infrastructure to overcome this issue by
> supporting high resolution timers for mac80211 delayed work, which do not
> have this timeout latency. The other patches in that series converted som=
e
> mac80211 work items to use the new infrastructure.
>=20
> Unfortunately the CAC timeout work was not addressed as part of that seri=
es,
> so address it now.

This is ... a pretty grossly wrong characterisation. The previous work
fixed a bunch of *correctness* issues. This fixes a performance thing at
best, and you seem to be complaining those are the same and therefore it
should've been fixed before. The other patches also went to wireless for
being fixes, this really wouldn't, I'd argue, those two things really
aren't the same.

Please rewrite this commit message.

johannes

