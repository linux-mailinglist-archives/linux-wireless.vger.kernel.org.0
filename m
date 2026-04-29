Return-Path: <linux-wireless+bounces-35563-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEyxOmSi8WmwjAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35563-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 08:17:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AB848FB11
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 08:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E579E3005308
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 06:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5339033BBC5;
	Wed, 29 Apr 2026 06:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xm1C2nvH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C4C322C6D
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 06:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777443420; cv=none; b=YL7R1UUwiQ2ka9c9jEbubwBTQ9I+mJPh+owJ8vvnkiFtktmRlVYyJ9LbQ+Vt4ZMJsRiSJUmx+7ZgPle703N9QSkoo49bUSPh8UU61CJ37yepwQPAk1c4LXPO5LrgihcuCaHRz2YqHQbnhwAFNeO1MAIhG09QEhhPFAX44II+Slk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777443420; c=relaxed/simple;
	bh=EFbP5otMHBpKw0toplDYc/Jc81MG1VUMV6/X/Gy29mM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KPfQQoSzyT36ZyFo3/f0yJ4gJKMmyKIz7TEY/CoMJ86Zej4OmuveDTFCrCFRkEPoxASDJ1+cRLfueIpwj7o7A/OsHmfgZ2Gq2237eCsSTe2pA2BxYcOYNFB0i/fIcu6gdBumnua2ASBWoKp/UNcRXsonlOm+wUQD1xvhTYf20ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xm1C2nvH; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=EFbP5otMHBpKw0toplDYc/Jc81MG1VUMV6/X/Gy29mM=;
	t=1777443418; x=1778653018; b=xm1C2nvHIBYfLTrbHgJSbtPOavS+pzZd2j19TqMlsedRlQQ
	L8MxojVY1hCSP/BhGIcI9KOOYJOKUBtsf8GAqCbXSxSP1ijmxsryXvXfZTAPMIn1cE8N53+9n7T5E
	HQZeY3x18/2+o29C/RxeKmQSF0LBHXmXRPWVOT5gep58hTfm2+d6Vg/DSOgd4oXn549NRC2dOWpUC
	ZadTjIuvUw/Cz3qtL4MtdY9BT7ZFHAh679iJC4/ttewk4ulnkMgGHx5gvklsWQ9KzQk9IMX+85Dc+
	EJSG6zw2scEoEBRl0oUqHRvLs3tjf1YucIhDoTJePZ2NUfNEvuli3w7yVoWJ2dIg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wHyEA-00000001pVb-3T8g;
	Wed, 29 Apr 2026 08:16:55 +0200
Message-ID: <eb8474cd25dd12541557afecf3434e58a69a322b.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 1/2] wifi: cfg80211/mac80211: change
 memory allocation for link_sinfo structure
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <sarika.sharma@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 29 Apr 2026 08:16:53 +0200
In-Reply-To: <3945df66-0f90-4371-a85d-26cd220dfc56@oss.qualcomm.com>
References: <20260428090919.1798601-1-sarika.sharma@oss.qualcomm.com>
	 <20260428090919.1798601-2-sarika.sharma@oss.qualcomm.com>
	 <59fa69de18211d2f17d346d22f2d07bbe72c157c.camel@sipsolutions.net>
	 <3945df66-0f90-4371-a85d-26cd220dfc56@oss.qualcomm.com>
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
X-Rspamd-Queue-Id: 36AB848FB11
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
	TAGGED_FROM(0.00)[bounces-35563-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]

On Wed, 2026-04-29 at 11:38 +0530, Sarika Sharma wrote:
>=20
> On 28-04-2026 15:01, Johannes Berg wrote:
> > On Tue, 2026-04-28 at 14:39 +0530, Sarika Sharma wrote:
> > >=20
> > > +int cfg80211_alloc_link_sinfo_stats(struct link_station_info **link_=
sinfo,
> >=20
> > really?
> >=20
> > johannes
>=20
> So, this helper API I introduced in cfg80211 since struct=20
> link_station_info is defined and primarily used
> there. Keeping allocation and lifetime management in cfg80211 ensures
> consistent ownership and cleanup once the link_station_info is consumed.
>=20
> Please let me know if I understood your concern correctly, or if you=20
> were referring to something else in this patch.

Hah, right. I was merely thinking of returning an error and using a
double-pointer for assignment. There are better ways of doing that.

johannes

