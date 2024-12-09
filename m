Return-Path: <linux-wireless+bounces-16096-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 912599E9C5D
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 18:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E459918893AC
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 17:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DAC222D7F;
	Mon,  9 Dec 2024 16:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dipier.ro header.i=@dipier.ro header.b="eewYTkEk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from qs51p00im-qukt01072701.me.com (qs51p00im-qukt01072701.me.com [17.57.155.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35C54595B
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 16:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763480; cv=none; b=UFdLsnV9UYWSJQX+Tuj3U9ChO5flKH4H2ujVSJycBaMfJ/ClL6mh8/Dt294jM+udZZNr9vTAQloZoI9vYkA6/sFIVt7i1765swGAYBbs1mE2gNxYx8qUMvdsAvlkChyPuem12WsoqOsLG4oY8WYlDlKJiAozDdfysF++jVAaVvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763480; c=relaxed/simple;
	bh=J/vgKVnD4j1vYalxwLRQJdhdgHLGYdMP8l/5D3kcYWY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=a1HV/f77ONq4ganum/GlWvVtRaKCX9M+RwNgGYjrf8Bbi9InHpMfq7B7rFqhOXuJjgY/yjrPbWnFnerndTgFUJ9v/VjlHS5iaUDbP3r2OU95cXb80kwZ0Ul6HKrw2R2alDKfo5Q/cs8wrz2jcwfmiFU4yf7quWIvoVWnLCAvc38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dipier.ro; spf=pass smtp.mailfrom=dipier.ro; dkim=pass (2048-bit key) header.d=dipier.ro header.i=@dipier.ro header.b=eewYTkEk; arc=none smtp.client-ip=17.57.155.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dipier.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dipier.ro
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dipier.ro; s=sig1;
	t=1733763477; bh=MhpSVw6RvVcKy+r3Tw1mNQDofiWbW3UYoObtKGtzFkA=;
	h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:
	 x-icloud-hme;
	b=eewYTkEkWeY07zp0m0fd52SiVNapjR3+hKv+KNPdat+W4TK6lGhtIY5gqSUsJDbDw
	 dCtekYMlibdvZkV3vDxsfOENs2e8VoMrlT/3vYzJ+zSb/B6Z1SaIZ8qjTfw0VTqduI
	 NFXa9pODfs1rnfQzRKHuGbLVJ0+ioPFdlVshaCL2fV3rdnm5YRlo+iEqRDwD/dZMPT
	 agUN2KhHbMjPaOT1bI53C0gZc3gU+zjHlUfR6Mz+P7CXXtwJu6oeM3uL3pRkrwsxjq
	 SxD12Wr7QwlRT6sWBWzkAfSxAb5na+SdFrUoZp2ClLv6IQjirOXek9/Gx785oOmrJd
	 xHb2901gJYc+g==
Received: from smtpclient.apple (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01072701.me.com (Postfix) with ESMTPSA id 2F83A15C0619;
	Mon,  9 Dec 2024 16:57:55 +0000 (UTC)
Content-Type: multipart/signed;
	boundary="Apple-Mail=_75ED10CC-16C3-4411-9BFA-EC6073F8A0DF";
	protocol="application/pgp-signature";
	micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.2\))
Subject: Re: wireless-regdb: Update regulatory rules for Armenia (AM) on 2.4
 and 5 GHz
From: Avgustina DiPierro <tina@dipier.ro>
In-Reply-To: <CAGb2v651G_dtC4Nzh4f9rQQ4w8KajAR0xb-8DbcedXiYcnz7jA@mail.gmail.com>
Date: Mon, 9 Dec 2024 20:57:42 +0400
Cc: linux-wireless@vger.kernel.org,
 wireless-regdb@lists.infradead.org
Message-Id: <FCC80FC4-5A96-4BC5-A0A2-99986F7869F4@dipier.ro>
References: <274D81C2-56C7-4042-96F9-A04A92BEAEFD@dipier.ro>
 <CAGb2v651G_dtC4Nzh4f9rQQ4w8KajAR0xb-8DbcedXiYcnz7jA@mail.gmail.com>
To: wens@kernel.org
X-Mailer: Apple Mail (2.3826.300.87.4.2)
X-Proofpoint-GUID: uYbEJHw_p2txyajJGIvZYrauf3AS3Gvj
X-Proofpoint-ORIG-GUID: uYbEJHw_p2txyajJGIvZYrauf3AS3Gvj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_12,2024-12-09_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 bulkscore=0 clxscore=1030 mlxscore=0 suspectscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412090132


--Apple-Mail=_75ED10CC-16C3-4411-9BFA-EC6073F8A0DF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Chen-Yu,

I greatly appreciate your assistance, as it is my first time sending Git =
patches with e-mail.
I will re-create this thread with proper formatting and improved commit. =
Thank you.

=E2=80=94
Tina

> On 9 Dec 2024, at 20:16, Chen-Yu Tsai <wens@kernel.org> wrote:
>=20
> Hi,
>=20
> On Mon, Dec 9, 2024 at 11:49=E2=80=AFPM <tina@dipier.ro> wrote:
>>=20
>> Public Services Regulatory Commission of the Republic of Armenia has =
released two amendments to its 2011 Decision =E2=84=96169=D5=86 on =
Approval of the Procedure for Issuing Permits for the Use of Radio =
Frequencies.
>>=20
>> 1. Amendment =E2=84=96159=D5=86, on permit of usage of radio =
frequency ranges without permit, released on May 11, 2012, available at =
https://www.psrc.am/contents/document/4749 (choose language =E2=86=92 =
HY)
>>=20
>> <=E2=80=A6> Based on Article 5, Part 1, Point 1(d) and Point 2(b), =
Article 6, Part 1 and Part 2, Point 1, and Article 17, Part 5 of the Law =
of the Republic of Armenia "On Electronic Communication," as well as =
Article 70, Part 1 of the Law of the Republic of Armenia "On Legal =
Acts," the Public Services Regulatory Commission of the Republic of =
Armenia decides:
>> To amend Points 4 and 5 of the annex to the decision =E2=84=96169N of =
April 13, 2011, by the Public Services Regulatory Commission of the =
Republic of Armenia titled "Approval of the Procedure for Granting =
Permissions for the Use of Radio Frequencies," by restating them with a =
new wording. <=E2=80=A6>
>> "4. No permission is required for:
>> <=E2=80=A6>
>> 9) The use of broadband wireless access equipment operating in the =
2400=E2=80=932483.5 MHz radio frequency band with a power of up to 100 =
mW.
>> <=E2=80=A6>=E2=80=9D
>>=20
>>=20
>> 2. Amendment =E2=84=96295-=D5=86, on permit of usage of radio =
frequency ranges without permit, released on August 23, 2023, available =
at https://www.psrc.am/contents/document/11375 (choose language =E2=86=92 =
HY)
>=20
> Please try to change any non-ASCII characters down to ASCII.
> And please wrap commit messages to under 80 characters per line.
>=20
>> <=E2=80=A6> Based on Articles 33 and 34 of the Law "On Normative =
Legal Acts," the Public Services Regulatory Commission of the Republic =
of Armenia decides:
>> To amend Subpoint 10 of Point 4 of the annex to Decision =E2=84=96169-N=
 of April 13, 2011, of the Public Services Regulatory Commission of the =
Republic of Armenia, titled "Approval of the Procedure for Granting =
Permissions for the Use of Radio Frequencies," as follows:
>> "10) For the use of local network equipment operating in the =
5150-5350 MHz and 5470-5875 MHz radio frequency bands with an effective =
radiated power (e.r.p.) of up to 100 mW (only indoors, as well as in =
airplanes during all phases of flight), utilizing dynamic frequency =
selection (DFS) and transmitter power control (TPC).=E2=80=9D <=E2=80=A6>
>=20
> This mentions TPC, which we don't actually support. We adopted =
reducing
> the maximum EIRP by 3 dBm, on the basis of that is what the ETSI =
regulations
> do.
>=20
> You don't need to include the actual text, which makes the commit
> message really long.
>=20
> Just list the bits that are updated, and provide links to the =
justification.
> And pointers to the actual item would be nice. So something like the
> following:
>=20
> 1. For 2.4 GHz range, based on reworded subparagraph 9 from
>   https://www.psrc.am/contents/document/4749
>=20
>   * 2400 - 2483.5
>     - 100 mW EIRP
>     - indoor use only
>=20
> 2. For 5 GHz range, based on reworded subparagraph 10 from
>   https://www.psrc.am/contents/document/11375
>   which also supersedes the previous document
>=20
>   * 5150 - 5350
>     - 100 mW EIRP
>     - indoor use only
>     - DFS required
>     - TPC required, reduce limit by 3 dBm to 17 dBm
>=20
>    same for the other range.
>=20
>> Essentially, this two documents define this frequencies as permitted:
>> - 2400 - 2483.5 MHz @ 100 mW
>> - 5150 - 5350 MHz @ 100 mW with DFS, outdoor usage forbidden
>> - 5470 - 5875 MHz @ 100 mW) with DFS, outdoor usage forbidden
>>=20
>> However, I am not sure if AUTO-BW option here is required. As far as =
I know, there is currently no limitation on bandwidth usage in IEEE =
802.11 set of protocols in Armenia.
>=20
> Normally any additional notes should be written under the "---" so =
that
> when we apply the patch, it doesn't get included.
>=20
> AUTO-BW is just for stitching together adjacent bands that have =
different
> requirements. Since you aren't doing that here, it isn't needed.
>=20
>=20
> Also, we require a Signed-off-by line from you, like with all kernel =
patches.
>=20
>> ---
>> db.txt | 10 +++++++---
>> 1 file changed, 7 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/db.txt b/db.txt
>> index e282e3b..5d5ba22 100644
>> --- a/db.txt
>> +++ b/db.txt
>> @@ -81,10 +81,14 @@ country AL: DFS-ETSI
>>        # short range devices (ETSI EN 300 440-1)
>>        (5725 - 5875 @ 80), (25 mW)
>>=20
>> +# Source (in Armenian):
>> +# 2.4 GHz https://www.psrc.am/contents/document/4749
>> +# 5 GHz https://www.psrc.am/contents/document/11375
>> +
>> country AM: DFS-ETSI
>> -       (2402 - 2482 @ 40), (20)
>> -       (5170 - 5250 @ 20), (18)
>> -       (5250 - 5330 @ 20), (18), DFS
>> +       (2400 - 2483.5 @ 40), (100 mW)
>> +       (5150 - 5350 @ 160), (100 mW), NO-OUTDOOR, AUTO-BW, DFS
>> +       (5470 - 5875 @ 160), (100 mW), NO-OUTDOOR, AUTO-BW, DFS
>=20
> Drop the AUTO-BW, as mentioned.
>=20
> ChenYu
>=20
>=20
>> country AN: DFS-ETSI
>>        (2402 - 2482 @ 40), (20)
>> --
>> 2.45.2






--Apple-Mail=_75ED10CC-16C3-4411-9BFA-EC6073F8A0DF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvCu0pyMKUrP7kHuNENjZHNl7IMkFAmdXIYYACgkQENjZHNl7
IMkrOw/5AWXFlkrEsrI58ZnCv1ny3Dp5O7rW3s8riGQArft92pEiScpo7DxIqwgn
rMJw4VzN9HmXaRvJT8zbVKb9lAiE2zP8hH444sjG6V7tgIQbCWGcFa5tJZkDT9fr
HCsl3mt95wxLvjHegeX62FVAMU9zvPY11k/sjsiS86QVI5W9gU9RnQfYFnV+w9S+
bf7iuiIOjq38JDYYfIHkgcfCp2NH0WSwjSk8ky+CfLJdwyMRcxeNfkccjEeXmnL+
sjlYXZYHfOGiBEGpYC3jzdR2akUGHhynFvprj97vFrBvBpa3zVuCelOMo9A/CCW1
Fox1jK65bDpHbNMGjy4VPBBZ1IZQJ+9aFZYENLFdt6JL01ynhtA/iwGSWz/iiT3l
pMJQijnQXP+6YTaIkY3BFwvmJG876h9dh9nu7VAE8/Gst/Y85o5a2PdBmzgy708k
q4cgJZAywraw2PrynpJcxKz4/YANp8YRbMLkrcuQi/gD3Oc1ReQOE+0fpHliLYeI
Ry618+3Y+/Mrm7D3j8PXC3Tnr+kkAz7Q2kcYUUVts6dg+Np5MnZ1PNk/hFfrOJLe
/x77dOakGfE/GMTliGMWM3DT4UXG/bHBQsMHaaVd5pIYh2lsN/t+Cza8f46havYB
cUGno6IYS077yKjT888CSTSoD8Ex7YVUM6u0rWTND611bKRQzUw=
=w7k5
-----END PGP SIGNATURE-----

--Apple-Mail=_75ED10CC-16C3-4411-9BFA-EC6073F8A0DF--

