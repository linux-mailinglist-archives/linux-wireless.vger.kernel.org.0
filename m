Return-Path: <linux-wireless+bounces-35565-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OO3rOW2l8WnxjAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35565-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 08:30:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E8B48FC61
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 08:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE0543010904
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 06:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ED53822BE;
	Wed, 29 Apr 2026 06:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XkPLOOm3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC08637BE60
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 06:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777444184; cv=none; b=eiyRR+YSADeIpX/1O/a6nf2tf2+m6I4ELP7jSAeaGnyhVIz7/CRnLuSyiwxJol/0JKfPjL1Dk2e5vM5AtvdMHq6ThMB32qwqI9Z9J9mzW9w4bKjnLzDA3yafqK+DN3sMkj8E5yxd3i1OglJx49Syi5qBmD5e6Hhfn0w9zBjOVKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777444184; c=relaxed/simple;
	bh=+c6e+STxcG6LEc4lxAh0IccqAbBfd/cZ9YcB4Fur+Lg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qxx5wiW3r9weucM6Mj87Bk562IrgOuGt4UTGvQ/5aieT/xa6grBEegXZzQrrlGDDghnr/vUdn0ovEkyL53rvJc4LozEE1IW4iGq7UxtqqRvxBwyAmXvy+2oxWmOnJJiXi95y2zVhmOpeA62/LlYahakwUHQ7QowyrlTt/Z9pejo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=XkPLOOm3; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+c6e+STxcG6LEc4lxAh0IccqAbBfd/cZ9YcB4Fur+Lg=;
	t=1777444182; x=1778653782; b=XkPLOOm3AaGKLk2rXCtFzvmSrR4mkKlnSs3e4F2cq/4JAjE
	zTZQUcqjdYC/mHX9oFHz8fdOqCLFV3+ijSadnCO8HxIjh/tGjzZk3lDqDmoPOS5wuKpSygIGMCG7S
	DZooRNj5ypkPmDwTY8OE7bQ86obiwptY4Rc56EsypdrlEmLtC05zLmnnOXrfa1DG4LsINHAGpYubw
	RxVg8CmG3V4huIFq+ohvuJzO2YkJv3FnrPGkUMIs20spRWQJBP4CqBIorEs5IzN1FT7Eo7mMEX0ZY
	d9pA99coNy4snhOWnb495Dl2jOizpk8d6YLhQd2bbBIP+TfkMBV1+ufjY8N1jCcw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wHyQV-00000001sD1-27U6;
	Wed, 29 Apr 2026 08:29:39 +0200
Message-ID: <a894a1e0b556ba910e7fad040210f9d531dcf99a.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 2/2] wifi: cfg80211/mac80211: extend
 cfg80211_rx_assoc_resp_data() for assoc encryption
From: Johannes Berg <johannes@sipsolutions.net>
To: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 29 Apr 2026 08:29:38 +0200
In-Reply-To: <d5932baa-7770-4de9-aee0-c51c59294d83@oss.qualcomm.com>
References: <20260427150735.2391680-1-kavita.kavita@oss.qualcomm.com>
	 <20260427150735.2391680-3-kavita.kavita@oss.qualcomm.com>
	 <e3fa97dc1d0bc69477d3a2d2b2bfec6ff0ddff4e.camel@sipsolutions.net>
	 <d5932baa-7770-4de9-aee0-c51c59294d83@oss.qualcomm.com>
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
X-Rspamd-Queue-Id: 18E8B48FC61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	TAGGED_FROM(0.00)[bounces-35565-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,sipsolutions.net:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Hi,

Sorry I didn't get back to this yesterday. I see you now just sent
another patch.

> The attribute is intended to indicate that the entire exchange was encryp=
ted,
> not just the Response. For the Response frame, checking ieee80211_has_pro=
tected()
> is possible since the full frame is available in data->buf, but for the R=
equest
> frame only IEs are stored in ifmgd->assoc_req_ies, the MAC header is not =
preserved,
> so I cannot check the Protected bit for the Request.

I guess that makes sense, fair enough.

> While an unencrypted Request paired with an encrypted Response is unlikel=
y in practice,
> we did not want to leave that gap, so I used the epp_peer flag. That said=
, if you think
> checking the Protected bit on the Response frame alone is sufficient, we =
are fine with
> that approach too.

It's actually also something wpa_s could check, but I suppose it's
plausible that non-wpa_s observers of these events might be interested.

> In the wireless-next tip, there are already commits that combine both cfg=
80211
> and mac80211 changes together,=C2=A0

True, but that's usually if the whole thing is small enough I guess?

> so since the assoc_encrypted field addition in
> cfg80211 and the mac80211 epp_peer lookup that sets it are tightly depend=
ent on
> each other, I kept them in the same commit. If you prefer them split into=
 two
> separate commits, I can do that. Will update the commit as well.

I think in this case I might have just preferred to have the first
commit add *all* the infrastructure, and indicate that it's done for
assoc for the reasons above, and then have the second just be mac80211
to fill it?

Not super important though I guess.

johannes

