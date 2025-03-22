Return-Path: <linux-wireless+bounces-20688-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5470EA6C879
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Mar 2025 10:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A59F172B8F
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Mar 2025 09:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F72C187550;
	Sat, 22 Mar 2025 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lNmyAtRV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE0818A6D3
	for <linux-wireless@vger.kernel.org>; Sat, 22 Mar 2025 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742634290; cv=none; b=Vrx7sOzgZt0pM9XA1gVm5a9uX99n0ruU2igufa/RAMWJ7UJ6oHKyT2CN43OLTjt8sH9xiqMep78amhcLu7D78EGUFOhrxQE1riVNqNuPheYdSM9byDbaWjGTSId/spn8tSDwr5jqiK3sjVZ9PQV+naNQxLAovRJ3k0H4F31Mkd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742634290; c=relaxed/simple;
	bh=3utL61yRV2MF9RzUDkny01L1JVxx4VEEIQ4iQ+XeTcA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KxmTF5xE3kiaCh2Q8ZZuFdjVpQ2AwsmsKpBwRl/B5DW2W2htJ6s+AoFGbTr++dHf/L4pW/7pVu1A5cVh0R11UW80zukBWKrNn3Vxbk0mSxZPkwwvllOprG+jBiOc/PewlCUuRHyUX9LzWRNWh5O9eyDFr9gIb3UC/NmNIJih0P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lNmyAtRV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Lp6wMmpdVwBU4pDmuRCX8vo8ezEjV9Zo8H7H6eeFiDk=;
	t=1742634288; x=1743843888; b=lNmyAtRVQe2ftaluDGAGWfdrKOIkYATZyUOOCY+J/SFGi+H
	ApM9ZnS5m1o678HsFCafwfKj+QS2XLMnALAnSPqwDiuD/KzAl5KHGFXlMmOuIdGOF1UN7vb4VUkcY
	JC3Jr3i9o0QOVoQaQ33Zeh16vBMsgnlYw4FrEQBz1PPFkcOvJdZFzx+7C6cajuAW4CXllcRTfmpcB
	vI80tPBOuWx2XZOK+eOYAOcrk107D/48h1yBZLzocWY4/YOe7uDcbX3s2pD806C3bj7jirRIbzv3y
	d1Mh6eV5whWN/zLbpUBjd8vIfQRhOYgygKIYgGlsiFuhxV3HeLdvFQ7MW4ZKK8fw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tvumV-00000001trl-1JPB;
	Sat, 22 Mar 2025 10:04:39 +0100
Message-ID: <b3efabfe73ad2c194e49a01342f90eda6c7903af.camel@sipsolutions.net>
Subject: Re: [PATCH v4 1/3] wifi: nl80211: add link id of transmitted
 profile for MLO MBSSID
From: Johannes Berg <johannes@sipsolutions.net>
To: Aloka Dixit <aloka.dixit@oss.qualcomm.com>, 
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, 
	ath11k@lists.infradead.org
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>, Muna
 Sinada	 <muna.sinada@oss.qualcomm.com>
Date: Sat, 22 Mar 2025 10:04:38 +0100
In-Reply-To: <4e4e4737-6040-4ec2-a3be-3fe1aba7b7cf@oss.qualcomm.com>
References: <20250310200237.652950-1-aloka.dixit@oss.qualcomm.com>
	 <20250310200237.652950-2-aloka.dixit@oss.qualcomm.com>
	 <52beaa2c05c91590797cc1f53b779fca085c8850.camel@sipsolutions.net>
	 <4e4e4737-6040-4ec2-a3be-3fe1aba7b7cf@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-03-13 at 15:59 -0700, Aloka Dixit wrote:
> On 3/12/2025 1:55 AM, Johannes Berg wrote:
> > Hi Aloka, all,
> >=20
> > > + * @NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID: Link ID of the transmitte=
d profile.
> > > + *	This parameter is mandatory if the transmitted profile is part of=
 an MLD
> > > + *	and the interface getting configured is a non-transmitted profile=
. For all
> > > + *	other cases it will be ignored.
> >=20
> > So I guess it's a question of what "the interface getting configured"
> > means, but I guess you could set up the transmitting interface?
> >=20
> Right, if the interface getting configured is the transmitted profile=20
> the link_id is ignored.

But I guess I don't understand yet why it's not needed? If you want to
configure MBSSID stuff for the transmitting profile it seems you'd need
the right link anyway?

But if it's not needed, should we at least validate it's correct or so?

> The 'else' case in the highlighted snippet above is the same scenario as=
=20
> the 'else' case you referred to, which is one layer out: "else if=20
> (!config->index) {".
>=20
> Both are executed when the interface getting configured is the=20
> transmitting interface. The difference between these two 'else's is that=
=20
> in one case userspace explicitly provides=20
> "NL80211_MBSSID_CONFIG_ATTR_TX_IFINDEX" and in other it hasn't.

Right.

> Similarly, for MLO, mac80211 does not need the link_id of the tx=20
> interface because it already has the link_conf for it as part of basic=
=20
> AP configuration parameters, hence link_id is ignored in both 'else's.

Oh so you're saying that you have an outer link_id already in
nl80211_start_ap() (or other callers). So then I guess we're back to
validating it, in line with how we say:

                if ((!config->index && tx_ifindex !=3D dev->ifindex) ||
                    (config->index && tx_ifindex =3D=3D dev->ifindex))
                        return -EINVAL;

now?

johannes

