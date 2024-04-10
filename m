Return-Path: <linux-wireless+bounces-6073-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7763D89ECDF
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 09:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1B61F21568
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 07:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEE813D292;
	Wed, 10 Apr 2024 07:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Oc9E48YY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DD713C901;
	Wed, 10 Apr 2024 07:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735949; cv=none; b=QSnl9UBKyqmZZesLgO3QWUzoeT+03FCOuYbeMQUYgtNlpcrm+XBHNhq7Hqh+N3gT71WVBS2O5fXUub9uqFko8VOtLaj+NVKFBu6u7pcJg0HNUXL6SGQrf23vXnzVgKDWBlyovVxgKyd+KlAIH7UHTxfvUnsItRRGnVLbcD5fswg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735949; c=relaxed/simple;
	bh=AqHcHzCtayvBZM24ONCW4wGNrQrcIpD/e+IDvuE88IU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aCAzE15nwOOcRNkn/IUaowxktHyDxx8rJ8pWLc5JtptP4hqK6vyxGLU4TDy3eyzPGxcvzfyBZ5fLyJAAJjw3Jy1tD0qEDPn0CS+lkQdH2Bzrr5XpDzGI4Tnk2LC/8H5xNPcaMWUXAvTmyK8CUwhOAbICzzo0o8JV3Uf8ckw35gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Oc9E48YY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8yJzNJsbUcZyMZ+JVyPnDvNkzO3Jhk9AuCTJ1rgbO+o=;
	t=1712735947; x=1713945547; b=Oc9E48YYT/XL6SyREC+jjB8NpUwrljBx1DO2JxiU0Cl8Oze
	BHBdsADSjhPy2aDixnLqNW86PAQgfw686M4tF3JjSiKx0M6+Kyu1/ckuRjKOlWLxl9G/TbaV+c0QU
	ExVsZJJKw6cQCmdT6nvE8DIqeTRceXHQFn6nMpp4tMQyGywloCvLF3TrDmMAmmNMCBbs5HGaDpqI6
	cyDNE8lQDaJBAAJdowtCda0/bnB9+CZzyzVCl1cAf85R4cfWJbh83YVt5DymayST8o2XbA3KlhkBQ
	uxWX1u0vfO9dpMVi5dLn5UPFvum/kjovRzcfyl3mtKYzNM14PjkWjVSLTHLBnsOQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ruSrH-00000001EoS-3zUt;
	Wed, 10 Apr 2024 09:59:04 +0200
Message-ID: <902dd36fa5ab0503377e558b92505fe499f666fa.camel@sipsolutions.net>
Subject: Re: [PATCH 02/13] wifi: nl80211: send underlying multi-hardware
 channel capabilities to user space
From: Johannes Berg <johannes@sipsolutions.net>
To: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>, Karthikeyan
	Periyasamy <quic_periyasa@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org, Jakub Kicinski
	 <kuba@kernel.org>
Date: Wed, 10 Apr 2024 09:59:02 +0200
In-Reply-To: <b455f267-9552-be3b-95b0-a036bfa8e14a@quicinc.com>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
	 <20240328072916.1164195-3-quic_periyasa@quicinc.com>
	 <6d92d0ba4a8764cd91cc20c4bd35613bcc41dfcd.camel@sipsolutions.net>
	 <9d5c2f9f-19b5-af4d-8018-1eb97fac10d6@quicinc.com>
	 <9d0f309da45ae657cd2ce0bc11a93d66e856ef64.camel@sipsolutions.net>
	 <b455f267-9552-be3b-95b0-a036bfa8e14a@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-03-29 at 19:51 +0530, Vasanthakumar Thiagarajan wrote:
>=20
> On 3/28/2024 5:31 PM, Johannes Berg wrote:
> > On Thu, 2024-03-28 at 15:48 +0530, Karthikeyan Periyasamy wrote:
> > > On 3/28/2024 1:19 PM, Johannes Berg wrote:
> > > > On Thu, 2024-03-28 at 12:59 +0530, Karthikeyan Periyasamy wrote:
> > > > > +/**
> > > > > + * nl80211_multi_hw_attrs - multi-hw attributes
> > > > > + *
> > > > > + * @NL80211_MULTI_HW_ATTR_INVALID: invalid
> > > > > + * @NL80211_MULTI_HW_ATTR_IDX: (u8) multi-HW index to refer the =
underlying HW
> > > > > + *	for which the supported channel list is advertised. Internall=
y refer
> > > > > + *	the index of the wiphy's @hw_chans array.
> > > > Is there a good reason to expose this? Seems pretty internal to me,=
 and
> > > > not sure what userspace would do with it?
> > >=20
> > > Hostapd use this hw index for the channel switch cmd.
> >=20
> > What, where? I don't see that in this patchset? And why??
> >=20
> > In any case, unless I just missed it and you're going to tell me to loo=
k
> > at patch N, we don't need it here, and then I'd prefer to keep it an
> > internal detail until it's needed.
> >=20
> > > The hw index used as a sanity check to identify whether the user
> > > requested channel fall under the different hw or not.
> >=20
> > You mean within hostapd itself? That doesn't make sense, it can derive
> > that information differently.
> >=20
> > > In split-phy hardware, 5GHz band supported by two physical hardware's=
.
> > > First supports 5GHz Low band and second supports 5GHz High band.
> >=20
> > In your hardware design anyway, but yeah, I get it.
> >=20
> > > In this case, user space cannot use band vise check here to identify
> > > given channel or freq supported in the given hardware.
> >=20
> > No, but it also doesn't need an index assigned by the kernel for that.
> >=20
>=20
> The only purpose of hw index is to link hw_chans to per-hardware=20
> interface combination capability so that each hardware can be
> identified during interface combination checks capability vs
> current state. Thinking if we can embed the channel list also
> into per-hardware interface combination signaling by giving the
> pointer?

Maybe? It might mean more allocations where the use is concerned since
it can't be "static const" that way.

I found the code that needs it later, just that Karthikeyan was using
the wrong explanation for it ... I'd hoped he'd understand your own code
better ;-)

johannes

