Return-Path: <linux-wireless+bounces-15241-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9439C6B7D
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 10:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6C3B281DAF
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 09:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A471F77B7;
	Wed, 13 Nov 2024 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VhWxj+SN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEC81BD9E9;
	Wed, 13 Nov 2024 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731490150; cv=none; b=EXttFlOAZCgvp0kxx2061m09GISfmzwsULUEn15tlBy6Pyks8vyJdSF0P0nU/vZWwmJgGpvXKZGwA+h0w3Wibrqf7kdhR6HZ8xmsGdvf1CpMTZw7Y8X7X2vYQv5JIR/SQhXEFjtpdAx4yeR5E0FF3V/u1e7OiB9FwN7qdyyRZIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731490150; c=relaxed/simple;
	bh=C+ixz2yiNKRDdv+Nbn9qihQwJvbChgUQNiGJyqOftFk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nORxyMFYEPbehtXPCYGvm1G2MU4kjGQUAdxo8M8yfBHj5VPrvqW1NsDdiEHkva60Qa+9Ui7uoXUVcrIZmCkYi3DTRSYFLK9KUzc8Ek9e25ezuTWmIrCgDOWmDbH4+RfRGdFEVYXxliH8klHjNsNRyDFjqVyF4kN4SzZToFXUvkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VhWxj+SN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=pvw10z/z7dfF411Io+Ehrj7z0M2IuFgcY2B840IRRco=;
	t=1731490149; x=1732699749; b=VhWxj+SNaeGUWRdzxRdla+qGQFDuLU5MmHj2EPLweRY3+PR
	OGUKt5NaYoORDdgILfC9blKR/O1nZepPUO+Jrl90YU4WknrJExu2Mq8GJePpMkfl11MQYBpc5eh67
	KSTl3PYnjoCSylSf0HoxS6HlJbprOJtj6tz7N363nqjmr4H8CN4mvYZ+L/FQ4qxv8mOUhk67PDwiP
	z3exxdE0Vy4ovsN9bnStwGYrpQgEY4CykHcrp2rJbNkE2XXxztJk0QNGrJoZR0Cwh0KHTIwpvGDPH
	CapbsIz+ktOoNl86QYrUzZuDnvkBiazbsjebslQvDVRTnrF96JQvsBr3GFJ6OT8g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tB9gP-00000003nyr-3MG8;
	Wed, 13 Nov 2024 10:29:06 +0100
Message-ID: <d0eb18d4a302e4be5251106fbfa8f5e10dd36477.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: fix WARN_ON during CAC cancelling
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 13 Nov 2024 10:29:04 +0100
In-Reply-To: <20241113-mlo_dfs_fix-v1-1-e4326736347b@quicinc.com>
References: <20241113-mlo_dfs_fix-v1-1-e4326736347b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

>=20
> diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
> index a5eb92d93074e6ce1e08fcc2790b80cf04ff08f8..2a932a036225a3e0587cf5c18=
a4e80e91552313b 100644
> --- a/net/wireless/mlme.c
> +++ b/net/wireless/mlme.c
> @@ -1112,10 +1112,6 @@ void cfg80211_cac_event(struct net_device *netdev,
>  	struct cfg80211_registered_device *rdev =3D wiphy_to_rdev(wiphy);
>  	unsigned long timeout;
> =20
> -	if (WARN_ON(wdev->valid_links &&
> -		    !(wdev->valid_links & BIT(link_id))))
> -		return;
> -
>  	trace_cfg80211_cac_event(netdev, event, link_id);
> =20
>  	if (WARN_ON(!wdev->links[link_id].cac_started &&
>=20

This really doesn't seem right.

Perhaps the order in teardown should be changed?

johannes

