Return-Path: <linux-wireless+bounces-33076-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCsGGqyJsml4NQAAu9opvQ
	(envelope-from <linux-wireless+bounces-33076-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 10:38:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 051AA26FB34
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 10:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C1A3F3030A1D
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 09:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68EB3B8D5C;
	Thu, 12 Mar 2026 09:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="K/FA5zxM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AB93BA232;
	Thu, 12 Mar 2026 09:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773308276; cv=none; b=r3Ko9DixdZDqC2/PlxEtx8biK4GtokTEHSZlP4Hns31Pmsw9poUwOKMSWbKBpe1D4auGfL70YtZN6+Bzg7urrB+egy1PbYAEmXl+BE1/3JyehWAkVns8H65uk0Dz4wrms1azwwqcFs3hKkLLDXpbhBgYO2DrvMOE8dJjl7yaETA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773308276; c=relaxed/simple;
	bh=7St0SgkpoCqegFRGPaU8gPTTG4NNTsHqAMxFMontZ3U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AYDufNZkC4E9rGymzkDN2lINFkY4YoitzRNcF73Dsi4DLz1rM/LiQy4X0NfehYF24dHAKLjxdEltayh9P4ClnSFFmD9PohPUntBc+3Fbuir3kdzAu4ADS2f9jTKoYDWyap9DvzP0ITEEcuaYUFmFKyCyzIyg/Tzd8viwzchvY8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=K/FA5zxM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=GWyIkvOFf1wPgGGSCnpAqsN4f/t5t8iIVdsRu5KdwmU=;
	t=1773308270; x=1774517870; b=K/FA5zxMKreNO7Sutp9DFwfX5Sl8uX2B1ytk+3FqeDZv75y
	4DgtneOqaELl8NaQ5oBOs87SxuWT/UjXZ5glQkfDKItkgFz0fXcnk0gqZRXa/BAN8W46TqnHu/yEV
	sObmeg7VWDK9cB8MZ/toSKelaG26nGADPBI1cKbv/PTIdUjsUGdkYrDdBX16zvg3fZ/LQA4uPybWa
	81CBfykNNzdvOokpQJ6Zebpjc1lEfELk7c35Qo3n9w5S99p4K2ksY8xGYVBFW41EGThTlNLB/RFAz
	JxRCF9XbDvQeJXupiKzw4R5LYC4ETfz/7uQUQh6+ahBOrBsXutvBKjGnbbEMYB4g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w0cUE-0000000FlgF-32tr;
	Thu, 12 Mar 2026 10:37:46 +0100
Message-ID: <b7f4c8f1a251ea9cccb32f021828896371953143.camel@sipsolutions.net>
Subject: Re: ath12k: handling of HE and EHT capabilities
From: Johannes Berg <johannes@sipsolutions.net>
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>, Jeff Johnson
	 <jjohnson@kernel.org>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 12 Mar 2026 10:37:46 +0100
In-Reply-To: <abKBOp8Jc7f7U0T8@FUE-ALEWI-WINX>
References: <abKBOp8Jc7f7U0T8@FUE-ALEWI-WINX>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33076-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: 051AA26FB34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,
> For example, I use the `iw` tool to display the capabilities and their
> descriptions. The code for that has the following function prototypes:
>=20
>     * void print_ht_capability(__u16 cap);
>     * void print_vht_info(__u32 capa, const __u8 *mcs);
>     * static void __print_he_capa(const __u16 *mac_cap,
>                                   const __u16 *phy_cap,
>                                   const __u16 *mcs_set, size_t mcs_len,
>                                   const __u8 *ppet, int ppet_len,
>                                   bool indent);
>     * static void __print_eht_capa(int band,
>                                    const __u8 *mac_cap,
>                                    const __u32 *phy_cap,
>                                    const __u8 *mcs_set, size_t mcs_len,
>                                    const __u8 *ppet, size_t ppet_len,
>                                    const __u16 *he_phy_cap,
>                                    bool indent);

This is perhaps a bit unfortunate, but note that the HE and EHT __u16
and __u32 here are really little endian pointers, and the functions do
byte-order conversion.

>     struct ieee80211_sta_ht_cap {
>         u16 cap; /* use IEEE80211_HT_CAP_ */
>         bool ht_supported;
>         u8 ampdu_factor;
>         u8 ampdu_density;
>         struct ieee80211_mcs_info mcs;
>     };
>=20
>     struct ieee80211_sta_vht_cap {
>         bool vht_supported;
>         u32 cap; /* use IEEE80211_VHT_CAP_ */
>         struct ieee80211_vht_mcs_info vht_mcs;
>     };
>=20
> The structs for HT and VHT use `u16` and `u32` data types for the `cap`
> variable, matching what `iw` does. That part is consistent.

Careful. There are different structs used in different places, notably
HT/VHT and HE/EHT differ.

For HT and VHT, look at the start of nl80211_send_band_rateinfo(), which
sends themas individual attributes, defined in enum nl80211_band_attr,
and the values that are u16 (NL80211_BAND_ATTR_HT_CAPA) or u32
(NL80211_BAND_ATTR_VHT_CAPA) are in host byte order, though both are
actually documented misleadingly ("as in [V]HT information IE" is just
all around wrong.)

For HE/EHT, you have it in nl80211_send_iftype_data() since it's per
interface type, and all the individual values are just as they appear in
the spec, regardless of their size.

Note that spec is generally in little endian, but sometimes has strange
field lengths like MAC capabilities being 6 bytes in HE:

>     struct ieee80211_he_cap_elem {
>         u8 mac_cap_info[6];
>         u8 phy_cap_info[11];
>     } __packed;
>=20
>     struct ieee80211_he_6ghz_capa {
>         /* uses IEEE80211_HE_6GHZ_CAP_* below */
>         __le16 capa; }
>     __packed;
>=20
> However, for HE the types differ from the `iw` implementation. Here, `u8`
> arrays are used instead of `u16` for MAC and PHY capabilities. The 6 GHz
> capabilities use `u16`, which is also different.

That doesn't really matter, they're just a set of 6 or 11 bytes, and
e.g. the HE MAC capabilities are treated by the kernel as a set of 6
bytes, but by iw as a set of 3 __le16, which results in the same
interpretation, or at least should.

>     struct ieee80211_eht_cap_elem_fixed {
>         u8 mac_cap_info[2];
>         u8 phy_cap_info[9];
>     } __packed;
>=20
> For EHT, `u8` arrays are also used for both MAC and PHY caps, instead of
> `u32` for the PHY caps as in the `iw` implementation.

Same thing here.

> The current `ath12k` implementation always uses `u32` values, which does
> not work on big=E2=80=91endian platforms:

Yeah, that seems problematic and not really fitting for something that's
6, 11, 2 or 9 bytes long?

> I want to address and fix this issue. However, I cannot apply the =E2=80=
=9Cnever
> break the userspace=E2=80=9D rule here, as it seems, it is already broken=
.

I don't think it's broken, why do you say so?

What's (clearly) broken is how ath12k puts the data into the HE/EHT
structs that the kernel expects, but per your dmesg:

>     ath12k_pci 0001:01:00.0: ieee80211 registration failed: -22
>     ath12k_pci 0001:01:00.0: failed register the radio with mac80211: -22

it seems that even mac80211 doesn't like the capabilities, so the byte
order issue already exists there.

It seems to me the issue is that ath12k_band_cap is in u32, converted,
but then memcpy()d.

johannes

