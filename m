Return-Path: <linux-wireless+bounces-25357-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC520B03AD0
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 11:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52DC13AF5CF
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 09:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF6624113C;
	Mon, 14 Jul 2025 09:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="eipcf64J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B7623FC41
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 09:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752485398; cv=none; b=msaE6zUnXLgpeurzXiNDr6qCeEuwgOr65khdE+WFsEr9wJhP88E37efYe4OiucQhbVcYVJdELeMpHI0xROdL20WH5DHynOsHs4W7f+hxzrMY1R1gCsKXgR9bhDsIluHxDp9+a///kjrWFCnT8fBTe8hOXEoWL5lKt6+QoySK3tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752485398; c=relaxed/simple;
	bh=FtQIU+VFG7bRJJdcdUqUK/k/4fLw43OhL7hyQe8+08M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IAmVr/nW4aPSV6SFuCWrxEi998CetSBdtXotnH8dMpgC3cc06NUOoRXAqjeRLKZ2/h8vV2woFGQAIp8qPnRKcLjMBZJZrGOi8POWD5kBb9SkQnD/mWdSahGLuOvh/SyPkJEVfLQhPmWR9JXZtEmVho6mjfXQHOCDN7mwbei6Ytk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=eipcf64J; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=lMjEK4d7v+gk6yWiyDAsotXvxB7NZwRLRRQqiWCHB14=;
	t=1752485395; x=1753694995; b=eipcf64Jzno3KJxAj/aunT57xKjOdeDXfcfTML+jVeYBGX8
	kJLWMZmqKDlqGYFBjpmI1ErcsDbEM1BNIzH87GRIrmJZw0EDKXm8u/VFzVcXzVn5EY+tPCg4Sp3iR
	8HeNea4MzRL3tG8vZ/k3KPnGKpb71v4TGwx1zarRKCDs6IEm0gU0eL+few3gRj7kXBMTrxbb25L+2
	MB5zumgmXXWPzSDdtrPXyB75kMdjHzR2k9CKLhhwS3krsFpE3ee6AJ/L7/rai8+TJTMhJPLUWfbRS
	refxoOfMTtTANPqA3/CvkIAx5acVCh7k11vfxSMShiUQWnVETLT0on/EhQZGYeTg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ubFVF-00000003puW-3wIk;
	Mon, 14 Jul 2025 11:29:42 +0200
Message-ID: <e713c376c01a81dd21d928e5d84bd3a1ae9e6613.camel@sipsolutions.net>
Subject: Re: Disconnection triggered by Puncture advertisement
From: Johannes Berg <johannes@sipsolutions.net>
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
Date: Mon, 14 Jul 2025 11:29:40 +0200
In-Reply-To: <e80d5786-b1c1-46f5-b723-e6197e2d06e9@oss.qualcomm.com> (sfid-20250714_101848_204157_3240680C)
References: <e80d5786-b1c1-46f5-b723-e6197e2d06e9@oss.qualcomm.com>
	 (sfid-20250714_101848_204157_3240680C)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-07-14 at 16:16 +0800, Baochen Qiang wrote:
> Hi,
>=20
> Recently I hit an IoT issue while connecting to an TP-LINK AP. As a stati=
on, the
> connection with the AP initially succeeded, as indicated by the authentic=
ation and
> association logs:
>=20
> [  528.655093] wlan0: authenticate with 16:d8:64:56:ab:5b (local address=
=3D66:81:93:de:79:d8)
> [  528.655112] wlan0: send auth to 16:d8:64:56:ab:5b (try 1/3)
> [  528.720573] wlan0: authenticate with 16:d8:64:56:ab:5b (local address=
=3D66:81:93:de:79:d8)
> [  528.720584] wlan0: send auth to 16:d8:64:56:ab:5b (try 1/3)
> [  528.790413] wlan0: authenticated
> [  528.794115] wlan0: associate with 16:d8:64:56:ab:5b (try 1/3)
> [  528.831371] wlan0: RX AssocResp from 16:d8:64:56:ab:5b (capab=3D0x1911=
 status=3D0 aid=3D1024)
> [  528.858116] wlan0: [link 0] local address 9e:c1:c3:67:13:db, AP link a=
ddress
> 14:d8:64:4c:ab:5b
> [  528.858201] wlan0: [link 1] local address 66:81:93:de:79:d8, AP link a=
ddress
> 14:d8:64:4c:ab:5c (assoc)
> [  528.911598] wlan0: associated
> [  528.978910] wlan0: Limiting TX power to 35 (35 - 0) dBm as advertised =
by 14:d8:64:4c:ab:5c

Clearly that was with EHT, otherwise you couldn't have two links.

> However, the connection was later disrupted:
>=20
> [  533.845338] wlan0: AP EHT information doesn't match HT/VHT/HE, disabli=
ng EHT
> [  533.845344] wlan0: [link 1] AP 14:d8:64:4c:ab:5c appears to change mod=
e (expected EHT,
> found HE) in beacon, disconnect
>=20
> with some logs added:
>=20
> ---
> +static void cfg80211_dump_chan_def(const struct cfg80211_chan_def *def)
> +{
> +       struct ieee80211_channel *chan =3D def->chan;
> +       pr_info("chan: [band %u center_freq %u freq_offset %u hw_value %u=
 flags %u
> max_antenna_gain %u max_power %u max_reg_power %u beacon_found %u orig_fl=
ags %u] width %u
> center_freq1 %u center_freq2 %u freq1_offset %u punctured %u\n",
> +               chan->band, chan->center_freq, chan->freq_offset, chan->h=
w_value,
> chan->flags, chan->max_antenna_gain, chan->max_power, chan->max_reg_power=
,
> chan->beacon_found, chan->orig_flags,
> +               def->width, def->center_freq1, def->center_freq2, def->fr=
eq1_offset,
> def->punctured);
> +}
> +
>  static const struct cfg80211_chan_def *
>  _cfg80211_chandef_compatible(const struct cfg80211_chan_def *c1,
>                              const struct cfg80211_chan_def *c2)
>  {
>         const struct cfg80211_chan_def *ret;
>=20
> +       cfg80211_dump_chan_def(c1);
> +       cfg80211_dump_chan_def(c2);
> +
>         /* If they are identical, return */
> ---
>=20
> The disconnection is caused by different 'punctured':
>=20
> [  533.845311] chan: [band 1 center_freq 5180 freq_offset 0 hw_value 36 f=
lags 524320
> max_antenna_gain 6 max_power 24 max_reg_power 24 beacon_found 1 orig_flag=
s 0] width 3
> center_freq1 5210 center_freq2 0 freq1_offset 0 punctured 0
> [  533.845322] chan: [band 1 center_freq 5180 freq_offset 0 hw_value 36 f=
lags 524320
> max_antenna_gain 6 max_power 24 max_reg_power 24 beacon_found 1 orig_flag=
s 0] width 3
> center_freq1 5210 center_freq2 0 freq1_offset 0 punctured 8

That message is a bit misleading then - we decided that the EHT wasn't
valid and so that code fell back to reporting HE, and then that means it
changed in a strange way.

> This 'punctured' is suddenly (I mean even 'EHT Operation' was not seen in=
 previous
> beacons)

Pretty sure there must've been EHT operation before, otherwise we
couldn't connect with EHT, and you had multi-link.

Of course the puncturing bitmap could've been elided before.

>  advertised in EHT Operation element contained in AP's beacon:
>=20
> Ext Tag: EHT Operation (802.11be D3.0)
>     Ext Tag length: 10 (Tag len: 11)
>     Ext Tag Number: EHT Operation (802.11be D3.0) (106)
>     EHT Operation Parameters: 0x03, EHT Operation Information Present, Di=
sabled Subchannel
> Bitmap Present
>         .... ...1 =3D EHT Operation Information Present: True
>         .... ..1. =3D Disabled Subchannel Bitmap Present: True
>         .... .0.. =3D EHT Default PE Duration: False
>         .... 0... =3D Group Addressed BU Indication Limit: False
>         ..00 .... =3D Group Addressed BU Indication Exponent: 0
>         00.. .... =3D Reserved: 0x0
>     Basic EHT-MCS And Nss Set: 0x00000011
>     Control: 0x02, Channel Width: 80 MHz EHT BSS bandwidth
>         .... .010 =3D Channel Width: 80 MHz EHT BSS bandwidth (2)
>         0000 0... =3D Reserved: 0x00
>     CCFS0: 0x0000002a
>     CCFS1: 0x00000000
>     Disabled Subchannel Bitmap: 0x0008
>=20
> Which fails the check in _cfg80211_chandef_compatible(), because the chan=
def's are not
> identical but have the same width.

Question is _which_ chandefs it's comparing.

Can you show the rest of the operation fields? HT/VHT/HE.

> Is this AP misbehaving? or is cfg80211/mac80211 not doing correctly?
>=20
> I am not very familiar with Puncturing, want to hear professional opinion=
s from your guys.

I don't know. I have a feeling that perhaps the AP is misbehaving and
setting HE operation to 80 MHz as well (which is invalid if EHT
punctures it), which would explain the 'compatible' check failing (HE
and EHT need to be compatible, of course.)

johannes

