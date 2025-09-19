Return-Path: <linux-wireless+bounces-27519-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9D2B894A6
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 13:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80E4916DABC
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 11:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834C2309DA0;
	Fri, 19 Sep 2025 11:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="gSf0mLeV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9D13093C9
	for <linux-wireless@vger.kernel.org>; Fri, 19 Sep 2025 11:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758281791; cv=none; b=o2wBNBOLgW5gNwBqbED/Z03Ov2WTgTaIyJYsv+PceMoS/fKTpFQRuxURLcPkhSFOCBGhjGKZch2ezS+cMrd8QjmQ50zKwhwLC4NICup/jwEKU9/fiF9FqOBlAwfprJYtfJszlbdGnSwfgzZXStLpcNWqtg/qOvKvY3V3DcucFEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758281791; c=relaxed/simple;
	bh=OIOZoEItddxDsQxBxQE+2ZaADpeGatzyQcDM3n6z2+8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hKEmZwolVgDO33KIceLnMDnrgHra/vEEZkSFOHxa9PTnr5ZrwB3JdBQ5GkEz3s2wj77S0rR3KV6B0Q/Vn8O/d5y2GkkjxJ472AqCJe8TM0mkOiLVbXqowbyD3PYZ4vJ5XjTb9t9meSHrzqSQBMrjQYbO3Ppbo4G6E4YMjJ1fr2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=gSf0mLeV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=o7lsdethWFQgFKzXnF7pRxSImIvSC1CDek9u0QfpYco=;
	t=1758281789; x=1759491389; b=gSf0mLeVxG1qjU3hcq/oT5xWdwnjvej7QP4cc8/Y7CLgKfC
	YD5r1iXVZJNb9H3qOWtKwG+w0uNNRBcL0300funI6pwytao1SepIrDfYCJWrkzwFGuMT+BKCteGji
	4Sqvd5dqFVOYYgu7gnH3jr2EH9UL0cpqw6oREpXMWJTt3Jz2RmhKJ8/0uaBG14UgLRWCrZyWsdAFS
	67FRcsWfz90JCuJQN048mM807Q4SBHP7aFBaq4snyU5qwIeyTn18jZKh5Qh/nhnCrF8cZxlsGymhP
	IoCdzYJE5iWBsYAxj1fsVulMTXp1XUeJa/I0MQGNhZzjA3K5QLlCtV8LGTeYxwMg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uzZPf-0000000Fmz9-1mg1;
	Fri, 19 Sep 2025 13:36:27 +0200
Message-ID: <313c9867e94e55c8b3237387aa9959607c604d2b.camel@sipsolutions.net>
Subject: Re: [RFC v3 wireless-next 2/2] wifi: mac80211: add support for
 VLAN-tagged EAPOL frames
From: Johannes Berg <johannes@sipsolutions.net>
To: Janusz Dziedzic <janusz.dziedzic@gmail.com>, 
	linux-wireless@vger.kernel.org
Cc: j@w1.fi
Date: Fri, 19 Sep 2025 13:36:26 +0200
In-Reply-To: <20250913202801.448853-2-janusz.dziedzic@gmail.com> (sfid-20250913_222817_421621_2EB60D00)
References: <20250913202801.448853-1-janusz.dziedzic@gmail.com>
	 <20250913202801.448853-2-janusz.dziedzic@gmail.com>
	 (sfid-20250913_222817_421621_2EB60D00)
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

On Sat, 2025-09-13 at 22:28 +0200, Janusz Dziedzic wrote:
>=20
> +static bool ieee80211_vlan_control_allowed(struct ieee80211_rx_data *rx,
> +					   struct ethhdr *ehdr, u32 len)
> +{
> +	struct vlan_ethhdr *vhdr =3D (void *)ehdr;
> +	struct ieee80211_sub_if_data *sdata =3D rx->sdata;
> +	u16 vlan_id;
> +
> +	if (!sdata->control_port_over_nl80211)
> +		return false;
> +
> +	if (!sdata->control_port_vlan_id)
> +		return false;
> +
> +	if (!ieee80211_is_vlan_control(sdata, ehdr, len))
> +		return false;
> +
> +	vlan_id =3D be16_to_cpu(vhdr->h_vlan_TCI) & VLAN_VID_MASK;

be16_get_bits() might be nicer, then nobody has to wonder whether or not
a shift is missing :)

> +	if (vlan_id !=3D sdata->control_port_vlan_id)
> +		return false;
> +
> +	return true;

return sdata->control_port_vlan_id =3D=3D vlan_id;

perhaps? but doesn't really matter.

> @@ -2561,7 +2602,8 @@ __ieee80211_data_to_8023(struct ieee80211_rx_data *=
rx, bool *port_control)
>  		return RX_DROP_U_INVALID_8023;
> =20
>  	ehdr =3D (struct ethhdr *) rx->skb->data;
> -	if (ehdr->h_proto =3D=3D rx->sdata->control_port_protocol)
> +	if (ehdr->h_proto =3D=3D rx->sdata->control_port_protocol ||
> +	    ieee80211_vlan_control_allowed(rx, ehdr, rx->skb->len))
>  		*port_control =3D true;
>  	else if (check_port_control)
>  		return RX_DROP_U_NOT_PORT_CONTROL;
> @@ -2612,7 +2654,8 @@ static bool ieee80211_frame_allowed(struct ieee8021=
1_rx_data *rx, __le16 fc)
>  	 * whether the frame was encrypted or not, and always disallow
>  	 * all other destination addresses for them.
>  	 */
> -	if (unlikely(ehdr->h_proto =3D=3D rx->sdata->control_port_protocol))
> +	if (unlikely(ehdr->h_proto =3D=3D rx->sdata->control_port_protocol ||
> +		     ieee80211_vlan_control_allowed(rx, ehdr, rx->skb->len)))
>  		return ieee80211_is_our_addr(rx->sdata, ehdr->h_dest, NULL) ||
>  		       ether_addr_equal(ehdr->h_dest, pae_group_addr);
> =20
> @@ -2636,6 +2679,17 @@ static void ieee80211_deliver_skb_to_local_stack(s=
truct sk_buff *skb,
>  		struct ieee80211_rx_status *status =3D IEEE80211_SKB_RXCB(skb);
>  		bool noencrypt =3D !(status->flag & RX_FLAG_DECRYPTED);
> =20
> +		cfg80211_rx_control_port(dev, skb, noencrypt, rx->link_id);
> +		dev_kfree_skb(skb);
> +	} else if (ieee80211_vlan_control_allowed(rx, (void *)skb_mac_header(sk=
b),
> +						  skb_tail_pointer(skb) - skb_mac_header(skb))) {
> +		struct ieee80211_rx_status *status =3D IEEE80211_SKB_RXCB(skb);
> +		bool noencrypt =3D !(status->flag & RX_FLAG_DECRYPTED);
> +
> +		/* strip VLAN */
> +		skb_pull(skb, VLAN_HLEN);
> +		skb->protocol =3D sdata->control_port_protocol;
> +
>  		cfg80211_rx_control_port(dev, skb, noencrypt, rx->link_id);
>  		dev_kfree_skb(skb);


Are these changes really correct? It seems to me that it's not so much
"should EAPOL over VLAN be _allowed_" as rather "should EAPOL be over
VLAN", which changes the treatment of when it's _not_ but is expected to
be?

> +	if (vlan_id) {
> +		vhdr =3D skb_push(skb, VLAN_HLEN);
> +		vhdr->h_vlan_encapsulated_proto =3D
> +			sdata->control_port_protocol;
> +		vhdr->h_vlan_TCI =3D cpu_to_be16(vlan_id & VLAN_VID_MASK);

That masking seems rather pointless for a value that's already limited
to the (hopefully) correct range, but perhaps then be16_encode_bits() is
a good idea anyway.

johannes

