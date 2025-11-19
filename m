Return-Path: <linux-wireless+bounces-29131-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F052AC6D9C0
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 10:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id C28562DC11
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 09:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A9D3358C7;
	Wed, 19 Nov 2025 09:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sWHm0rQx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB7C33555B;
	Wed, 19 Nov 2025 09:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763543360; cv=none; b=fKpzbHldCRz+mwtWr8/9VU63EATt5enKZzvSeH8xvourVR5Sq92/pzPnutWw8xJPX2Enq1OiLA0sNZwXj/4Qs7QL3hUc7XZWRU6wpkKwVBQUnrVgkl+DGIyht9h5IF56Mok2GVZlGTpxZ14eOB7gOjEcClfqliXD8mlHmb1C7ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763543360; c=relaxed/simple;
	bh=uHabEyWW+WKLlro/d3+TzfKsxvx2me57AwG0fNMEins=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oFA1+vbWp9BKvRVZCIXq++rfKO+GnVw837G0N5pOpKQmGFUfA3UmPtJ2Qkk5Gb1PwzMTTgwd9axDJ9A26ipWM8qLpj+OI/N3qhSt+A+eFJCeH/nsUXC5RhuZbfNmku61AdYCrPcvb5hF+n/K1Kdm3GiZLYcWKZ15eF1ZCypoPfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sWHm0rQx; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=YkOxUrsW/uCCw8ASWwSEtT1xBVmwvB12S33Ep1tvsZg=;
	t=1763543358; x=1764752958; b=sWHm0rQxRsvYoX4bRk2r0WSR8jv6U4wEGwEX6ftuKeUWCME
	QNALJYxUy+g+rGLMIzlPxGJFR5Sh/kX/qcxV17UCU85FyuU83j65bYaucXcEisvoYtiEjDc+6eJin
	VhnXyNHHN7Fyq0M+/dUjOk3yOCE/EaDp3t/G2ZvopNs+Ovtkmz2le+tpH3b1SkJ+vka+ZWcGKU0Mn
	2i9r4ePCdP3zIJg95X0JSSP7fwsBMI3NGy9cdq+HXMybRXuS0nDVYCoVYECaz2RUb0VjUdlz5+wnw
	fLsZ9BR0OLXZ4n0dkjec8mhc1u0wLiK/ClOo2mOboQH7C6Kl9kOHhTNwD9aduPUg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vLeBe-00000001rQk-2sg7;
	Wed, 19 Nov 2025 10:09:14 +0100
Message-ID: <fb7ef6bcbfed2e98cd8266325e681f30873a3784.camel@sipsolutions.net>
Subject: Re: [PATCH v3] wifi: cfg80211: Fix uninitialized header access in
 cfg80211_classify8021d
From: Johannes Berg <johannes@sipsolutions.net>
To: Ranganath V N <vnranganath.20@gmail.com>, dave.taht@bufferbloat.net, 
	linville@tuxdriver.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org,
 	syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com
Date: Wed, 19 Nov 2025 10:09:13 +0100
In-Reply-To: <20251118150524.7973-1-vnranganath.20@gmail.com> (sfid-20251118_160541_358917_4D21AEC7)
References: <20251118150524.7973-1-vnranganath.20@gmail.com>
	 (sfid-20251118_160541_358917_4D21AEC7)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-11-18 at 20:35 +0530, Ranganath V N wrote:
>=20
>  	switch (skb->protocol) {
>  	case htons(ETH_P_IP):
> +		struct iphdr iph, *ip;
> +
> +		ip =3D skb_header_pointer(skb, sizeof(struct ethhdr),
> +					sizeof(*ip), &iph);
> +		if (!ip)
> +			return 0;
> +
>  		dscp =3D ipv4_get_dsfield(ip_hdr(skb)) & 0xfc;

If you pull it out that way, seems you should also _use_ it?

johannes

