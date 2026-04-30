Return-Path: <linux-wireless+bounces-35719-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGDyI3x682mt4AEAu9opvQ
	(envelope-from <linux-wireless+bounces-35719-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 17:51:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 353774A523D
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 17:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 20A4B300133D
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 15:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53F844CAEA;
	Thu, 30 Apr 2026 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Y1/klBNo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0827F44BC93;
	Thu, 30 Apr 2026 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564281; cv=none; b=FcTG7890dRWdV1/x4f0lXOxjgklA/wccb8ufEtOGY/u+e7zmTODm3kLqrll0hMT+laYehGDd90Dq2HZAUaVUtHRspDBw6M9oH/FONd/pV2FTcdOLp5bDMgInEaBC8MGSViqxBs+grE2AaRYoCbkb+DEvyiil+99WzClnYMX8yjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564281; c=relaxed/simple;
	bh=Z4QaB5zoZbMfWKiPjof9bKBHvnmTLTNxpgUmaJ49tFQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PA8mt2ZzTkcbLXEDnN9B3FNv04kOmvX7rr5EkiazeRkXDlIpnqnIZ20wD1CK9bwfE2VDim9sd9eQzyidZr7Xk+4l63BE2vxW49I0Cje/8tCyFfEf2EMdDsKdeM6A3wO0uf+aoANZiQZuXHI0Y5ApjcxPtgdHraQmQjtbGj892MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Y1/klBNo; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nmPqSIyOsYk7X61mHEchbXrVS9D6WK3wP2smAwfltuk=;
	t=1777564280; x=1778773880; b=Y1/klBNoEYrWeVpGEhPXDGVdSZFRkWU6ssIti030AZjMRMK
	u8OTTx1ndjAVg7Zkv/gGQR7ClD3AqCYPf279Z3xvQBN7v35frYaIWBcbZWoi1tuPJPv/WzQ2UxWIn
	zRxwQDajtN/gNsV2meWkhbodRNHTPcwwXbfbjVkv0WdMwzZlc/FRGoJiXyOKjJLv01obZ3b2r2kTu
	klmYe0pZidSxaKDp27EjOi8Q8c2DDpfdqZHPfPuq0n7ds8ro8zI5M2pbf7hpGmOE/Ic/Ho9LVIWor
	2BMPFlHiez4A0gyyqPObRpldqaEIxYIhClyohbGmN6c2VwWMAj/iPep1TJtAE+WQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wITfY-00000005Yof-3e2k;
	Thu, 30 Apr 2026 17:51:17 +0200
Message-ID: <027691e6472079e06f816462a8049308a1bea908.camel@sipsolutions.net>
Subject: Re: [GIT PULL] wireless-2026-04-30
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Date: Thu, 30 Apr 2026 17:51:15 +0200
In-Reply-To: <20260430071239.36b0e5f0@kernel.org>
References: <20260430111831.219242-6-johannes@sipsolutions.net>
	 <20260430071239.36b0e5f0@kernel.org>
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
X-Rspamd-Queue-Id: 353774A523D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35719-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]

On Thu, 2026-04-30 at 07:12 -0700, Jakub Kicinski wrote:
> On Thu, 30 Apr 2026 13:17:52 +0200 Johannes Berg wrote:
> > So the LLM floodgates are starting to open ;-) But I'm somewhat
> > happy that so far we haven't gotten any really critical reports.
> > Here's a couple of first fixes though.
> >=20
> > Please pull and let us know if there's any problem.
>=20
> Looks like this breaks kunit:
>=20
> ok 70 mac80211-tpe
>     KTAP version 1
>     # Subtest: mac80211-mlme-chan-mode
>     # module: mac80211_tests
>     1..1
>         KTAP version 1
>         # Subtest: test_determine_chan_mode
>         ok 1 Normal case, EHT is working
>         ok 2 Requiring EHT support is fine
>         ok 3 Lowering the mode limits us
> kunit: required basic rate or BSS membership selectors not supported or d=
isabled, rejecting connection
>         ok 4 Requesting a basic rate/selector that we do not support
>         ok 5 As before, but userspace says it is taking care of it
>     # test_determine_chan_mode: ASSERTION FAILED at net/mac80211/tests/ch=
an-mode.c:258
>     Expected conn.mode =3D=3D params->expected_mode, but
>         conn.mode =3D=3D 5 (0x5)
>         params->expected_mode =3D=3D 1 (0x1)
>         not ok 6 Masking out a supported rate in HT capabilities
>=20

D'oh. Yeah, that's the AP workaround, we'll need to adjust the test. I'm
on my way out right now, so I guess that'll have to wait for next week.

johannes

