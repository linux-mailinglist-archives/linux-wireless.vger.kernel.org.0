Return-Path: <linux-wireless+bounces-33100-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKG2JvqdsmndOAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33100-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 12:05:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A261270954
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 12:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBBFB3013488
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 11:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D60739891E;
	Thu, 12 Mar 2026 11:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KIE+2Er8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D835F2D3225;
	Thu, 12 Mar 2026 11:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773313528; cv=none; b=SOkFTgZK5qBcD7Pt/h1dFoL0kUZI+jcWybG9mnFs8mwLB3vOmkRljY10TNCJYnfb6+sZYC/DF6IVfil0dG+WDk+cLVTqA1LEH2WtO5FnlAD4vB1YNgkVwJgxIH0dpqboBiOjOk1m6XiGBRrqL9+hxpqusuHfV9tkqlpa1SPtJXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773313528; c=relaxed/simple;
	bh=fF2Qg5ghSNkW6URZ+3iLv3+m8cPkqV3EgxuJC62vNRI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qh9Xg7uc9AKUjRuQVGoxOA0vpWMq2dXzG76M/ONn/5ktZoh2aKsFPl1QaBqgc5ZHeTcs3hDPEkgQWPp3dhnRmX6AO04w99f6UPPFjkGoHS4ea4gpECHy9FLox08SlgDeooUIp5boyf0v4Ncs6t5YJIXbPhxmdyKgf6FTLIXd51w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KIE+2Er8; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ZMGToIvcX5txTRmJV0EqdHQwkIhD6yRYOwJqrPBV2SA=;
	t=1773313526; x=1774523126; b=KIE+2Er8JgVCVjnkPKkaLRmN3Bn+Xuz/attDHen5X6NBIyq
	5sZ0cRUVslnAoo4WjH53TK5bHmWeGjB38ujWEKbOwAG5QZyQMTJAu76fdTzqGczdRqgu8tCO4rfhe
	O51OJu1oXctMf813RQDdIiEpzYXyDU13rWmdAdx36QctFnfUI6ax7swwUw/YtbYrU2e/rgnC/gPCb
	YYyDMc1gEhmIcdwYD7Sg0XvuIziBqpC/nDR6WApw2VjUvoK4zPr4kHzLhnM0NmbLaR4sXGW7+5iJ8
	YwDN8wM7ILhzk/nwMSZ0vMIY8kh2xhamkuI29hEc1WrYeoN2F5VXB+grD57NGeiQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w0dr1-0000000FoB4-1Y3Y;
	Thu, 12 Mar 2026 12:05:23 +0100
Message-ID: <40b4b959b2ea5afd55381e6ae2d0c1908456734c.camel@sipsolutions.net>
Subject: Re: ath12k: handling of HE and EHT capabilities
From: Johannes Berg <johannes@sipsolutions.net>
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, ath12k@lists.infradead.org, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 12 Mar 2026 12:05:22 +0100
In-Reply-To: <abKbLNK0YrT6dr96@FUE-ALEWI-WINX>
References: <abKBOp8Jc7f7U0T8@FUE-ALEWI-WINX>
	 <b7f4c8f1a251ea9cccb32f021828896371953143.camel@sipsolutions.net>
	 <abKbLNK0YrT6dr96@FUE-ALEWI-WINX>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33100-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A261270954
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-03-12 at 11:53 +0100, Alexander Wilhelm wrote:
> On Thu, Mar 12, 2026 at 10:37:46AM +0100, Johannes Berg wrote:
> > Hi,
> > > For example, I use the `iw` tool to display the capabilities and thei=
r
> > > descriptions. The code for that has the following function prototypes=
:
> > >=20
> > >     * void print_ht_capability(__u16 cap);
> > >     * void print_vht_info(__u32 capa, const __u8 *mcs);
> > >     * static void __print_he_capa(const __u16 *mac_cap,
> > >                                   const __u16 *phy_cap,
> > >                                   const __u16 *mcs_set, size_t mcs_le=
n,
> > >                                   const __u8 *ppet, int ppet_len,
> > >                                   bool indent);
> > >     * static void __print_eht_capa(int band,
> > >                                    const __u8 *mac_cap,
> > >                                    const __u32 *phy_cap,
> > >                                    const __u8 *mcs_set, size_t mcs_le=
n,
> > >                                    const __u8 *ppet, size_t ppet_len,
> > >                                    const __u16 *he_phy_cap,
> > >                                    bool indent);
> >=20
> > This is perhaps a bit unfortunate, but note that the HE and EHT __u16
> > and __u32 here are really little endian pointers, and the functions do
> > byte-order conversion.
>=20
> I don=E2=80=99t see this in the function. For example, the MAC capabiliti=
es are a
> `u16 *` in CPU endianness, which is simply memcpy=E2=80=99d from the pars=
ed
> `NL80211_BAND_IFTYPE_ATTR_HE_CAP_MAC`. Later, they are treated as `u16 *`=
,
> as shown in the following code:
>=20
>     printf("%s\t\tHE MAC Capabilities (0x", pre);
>     for (i =3D 0; i < 3; i++)
>         printf("%04x", mac_cap[i]);
>     printf("):\n");
>=20
> Here is the result on little=E2=80=91 vs. big=E2=80=91endian platforms:
>=20
>     Little endian:
>     HE MAC Capabilities (0x081a010d030f):
>=20
>     Big endian:
>     HE MAC Capabilities (0x0b00189a4010):

Oh, OK, so _that_ print is definitely wrong in iw. But the individual
prints are converted:

        #define PRINT_HE_CAP(_var, _idx, _bit, _str) \
        do { \
                if (le16toh(_var[_idx]) & BIT(_bit)) \
                        printf("%s\t\t\t" _str "\n", pre); \
        } while (0)

> For the PHY capabilities, they are also a `u16 *`, but they are treated a=
s
> a `u8 *`. However, later in the description printing, `PRINT_HE_CAP` does
> not take endianness into account.

PRINT_HE_CAP *does* convert, there's le16toh() there. Same in
PRINT_HE_CAP_MASK.

It should convert, because it's from a u8[6] kernel API that just
carries the values as they are in the spec.

> > > I want to address and fix this issue. However, I cannot apply the =E2=
=80=9Cnever
> > > break the userspace=E2=80=9D rule here, as it seems, it is already br=
oken.
> >=20
> > I don't think it's broken, why do you say so?

Well, I see now that I missed the

        printf("%s\t\tHE MAC Capabilities (0x", pre);
        for (i =3D 0; i < 3; i++)
                printf("%04x", le16toh(mac_cap[i]));

and

        printf("%s\t\tEHT MAC Capabilities (0x", pre);
        for (i =3D 0; i < 2; i++)
                printf("%02x", mac_cap[i]);

parts, those are definitely broken in iw on big endian platforms. We
should fix those in iw. The actual individual prints seem fine though.

> Well, if `ath12k` uses `u32` in CPU=E2=80=91native order, that=E2=80=99s =
a bug, and I can=E2=80=99t
> get `ieee80211_hw` registered. If I use `__le32` in little-endian order
> instead, I end up with incorrect capabilities and mismatched descriptions
> shown by the `iw` tool (but I can get the driver running). So neither
> approach seems to be a 100% solution at first glance. Did I misinterpret
> the rule?

The *descriptions* should be fine I think? Just the first line with the
hex would be messed up.

> > What's (clearly) broken is how ath12k puts the data into the HE/EHT
> > structs that the kernel expects, but per your dmesg:
> >=20
> > >     ath12k_pci 0001:01:00.0: ieee80211 registration failed: -22
> > >     ath12k_pci 0001:01:00.0: failed register the radio with mac80211:=
 -22
> >=20
> > it seems that even mac80211 doesn't like the capabilities, so the byte
> > order issue already exists there.
> >=20
> > It seems to me the issue is that ath12k_band_cap is in u32, converted,
> > but then memcpy()d.
>=20
> The `ath12k` driver uses `u32` arrays in CPU=E2=80=91native order for thi=
s, so the
> swap is effectively happening.

Yeah but the swap is wrong, since HE/EHT capabilities are just byte
arrays in spec byte order in cfg80211/nl80211.

>  Later, in `ieee80211_register_hw`, the
> values are compared at the bit level, and that=E2=80=99s where it fails. =
I
> understand that technically `__le32` could be used in `ath12k`, meaning n=
o
> swap, but since `u8` arrays are used in `cfg80211`, that might actually b=
e
> the better approach.

Sure, could use u8 in ath12k too, dunno, up to the maintainer. At least
if it was __le32 you could still memcpy() from it since no swap
happened, and wouldn't change the code structure that much.

johannes

