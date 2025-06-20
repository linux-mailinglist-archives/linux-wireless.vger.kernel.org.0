Return-Path: <linux-wireless+bounces-24308-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BACABAE22AB
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 21:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71850188287C
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 19:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179A426E708;
	Fri, 20 Jun 2025 19:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="YjwkFDOm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26C81CBEB9;
	Fri, 20 Jun 2025 19:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750446528; cv=none; b=WZqqZyCg1fw/5RjCjUC4xlIi8Wb+Z20n5gbKGHksySvsDCfAhnBkj0Nv8Tr4UEPqtooXdl4iMpqRM2BdY8J4MMTd9Jn4+O/O49qoPzgXZF8hkZOL0q/PrTzxJsQ+le4r8k5cXF/OEYs5+6mTlIBReAxmj5qnMuI+lewSwBUfPsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750446528; c=relaxed/simple;
	bh=9azbfIzZ7/EKsBWKcE/cnLRSJbQoY+gshqreNhgUYaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y9b4ux4TW2hpftoB3+7pkXwxW0JvXYSzLHWe0gNUasFq3BIhCruWTDPVEJjiSJe9gkxF+Y4AlLE3ob7mQiAmVIym0LcU5yqIDHahJujrnWo0mthAByPuJ4CParttpPXvftlRUVfY+/dB0e53FotKPm/ituyTGAS3F0wJs+x5cEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=YjwkFDOm; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1750446473;
	bh=LRZJ7p9GBR+eglIFOpIjE8zfeTHorXM0dp0qxQVI7mM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=YjwkFDOmNbWgUt3wSTYVKm8e43BHLVndpqDW9dONda+2GFtUeBSpe7vXis2J13UL/
	 jWa3NRCthoIKuX3ynG1EWpk4rsYxzhcnjg1kjoPi7NDqhablho89cJ6mvayszOHf+d
	 FgcZTi7KGu1vTdj7AcnYLr/pjoIrdbitFa9UPjQI=
X-QQ-mid: zesmtpip2t1750446470t24027d68
X-QQ-Originating-IP: a+whxtcwC4OXseSRCHfi95NVw4yEwf/C+BSGBP353NI=
Received: from avengerlaptop.localnet ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 21 Jun 2025 03:07:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16696090710593307805
EX-QQ-RecipientCnt: 9
From: WangYuli <wangyuli@uniontech.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: sashal@kernel.org, stable@vger.kernel.org, johannes@sipsolutions.net,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 Edward Adam Davis <eadavis@qq.com>,
 syzbot+aaf0488c83d1d5f4f029@syzkaller.appspotmail.com,
 Johannes Berg <johannes.berg@intel.com>
Subject:
 Re: [PATCH 6.1/6.6] wifi: cfg80211: init wiphy_work before allocating rfkill
 fails
Date: Sat, 21 Jun 2025 03:07:48 +0800
Message-ID: <61F8C4764645EB4E+1926393.tdWV9SEqCh@avengerlaptop>
Disposition-Notification-To: WangYuli <wangyuli@uniontech.com>
In-Reply-To: <2025062021-omen-charger-a00b@gregkh>
References:
 <A203ED8C00632F28+20250620031949.227937-1-wangyuli@uniontech.com>
 <2025062021-omen-charger-a00b@gregkh>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2229138.irdbgypaU6";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MxVgLWGBAB+0/Tm8qpJMamYvtlL+rnaQqDbttLuVghbKKOP65oUBAMaB
	che0o2BXXSXE9FBpAO5pxurTiZUSL4jWy2BjwZFCBOeaXm67ZqorRIkBZ8GI/naMge+kpF7
	jr7T2WNoXVmHK+QuI78ygjYaoJlH7gSzyBveqOXRTj/OKDp5EvH91UqqZyoOC9I8+6VHYnI
	38HIh+FKw+LdPv5JEa96b9Q/OiILgGo3Z6OKu8rA6hEALKCjQMJIj18wxLnBdcnNONJ5WDR
	D+df7HOZCUrqmOZDTlF/S2LVQhclRoTzE3SgdABitQ2EEr+wusm+Y1RDI1AEohdedtaxBjU
	ahkTAtKLJ6aD1RAYpAVnnQOJuHypj9p2kYcWA5h2uBsRj3Y/HKCVA2yhsgRFWVO74nXXAVu
	3kJxkEy3iYWhIgBhEeFME8JjB29EHfX5+sk7AUJk3XctS1u0KDTo5SA8Pi6xrwWV60A1u32
	YQSzB/36OGi0YZ7fatb+N6cXZvLHHI2gwjQpLeXwnERm0Fimi6FnOIAFvAzzbsnmsJSPw5+
	T9LH3frfLUE5Z9oFAABrYkx8wvK1TjSUVdlAg7MKZBhCkgXTymfBwGozXVb7wfnW8sA12gf
	1+V0WvJCOtDZiBCxHeFD9gF6I9cOLRNcsBA5RslAi3WUHKbEquOxSWgGyRA4p+rHi52VkNi
	5PwLx2UHmHfjRP97lqJp0FeK4DIyQpXGO1njYLZwS8WrcTgHJULCjcvfFI4QfM1YEVXEqdF
	peOr84vEYlGn4Q6NoFaDFTfZD7YeFXzk429teEffsGl7kecP+5rwC8k6JPJIJ+opHJ2Fpi2
	FPxh4uHxgGyGmZ/LSgXtQalDvcMtY8+chGihDpW/IaxEaKr8/OmhdwukdzF5BQFnlvuXNqD
	1tR4OiGyyeIviqZoIS146qJbkPlDJoIpH8G4E+snipm1Ph6yXhd4UZuh3CuAwFZuFls+P5G
	B/uZzDlONdjNRZc35TDQrYqTwrfdIbd4gWGG9KvYdRSyCVRVlwvlSGll/txyivEsl9IQc2V
	yvjOvYq9U3UX2oy0Cy
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

--nextPart2229138.irdbgypaU6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: WangYuli <wangyuli@uniontech.com>
To: Greg KH <gregkh@linuxfoundation.org>
Date: Sat, 21 Jun 2025 03:07:48 +0800
Message-ID: <1926393.tdWV9SEqCh@avengerlaptop>
Disposition-Notification-To: WangYuli <wangyuli@uniontech.com>
In-Reply-To: <2025062021-omen-charger-a00b@gregkh>
MIME-Version: 1.0

Hi greg k-h,

On 2025=E5=B9=B46=E6=9C=8821=E6=97=A5=E6=98=9F=E6=9C=9F=E5=85=AD =E4=B8=AD=
=E5=9B=BD=E6=A0=87=E5=87=86=E6=97=B6=E9=97=B4 00:03:34=EF=BC=8CGreg KH wrot=
e=EF=BC=9A
> On Fri, Jun 20, 2025 at 11:19:49AM +0800, WangYuli wrote:
> > From: Edward Adam Davis <eadavis@qq.com>
> >=20
> > [ Upstream commit fc88dee89d7b63eeb17699393eb659aadf9d9b7c ]
>=20
> What about 6.12.y?  Why forget that kernel?
>=20
> confused,
>=20
> greg k-h

My apologies.

I inadvertently overlooked linux-6.12.y and  it does need this patch.

Thank you for the reminder; I'll be sure to check more carefully before=20
sending anything out next time!

Sorry,
=2D-
WangYuli
--nextPart2229138.irdbgypaU6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCaFWxhAAKCRDF2h8wRvQL
7tgZAP46SbHflW0DrcdgpJpdanXvnCdVErJN4RBhctcXCEomLAD/YyvUkVA/L/Fg
azhfyeR5ZfdfGVfmP+aNASfsurAJKQ4=
=Wmdz
-----END PGP SIGNATURE-----

--nextPart2229138.irdbgypaU6--




