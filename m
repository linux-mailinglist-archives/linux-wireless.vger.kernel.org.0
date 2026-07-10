Return-Path: <linux-wireless+bounces-38847-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6u9DEB3NUGoG5QIAu9opvQ
	(envelope-from <linux-wireless+bounces-38847-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 12:44:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBA5739CFB
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 12:44:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=GxLHJ983;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38847-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38847-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48669301B170
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 10:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CBB40C5CF;
	Fri, 10 Jul 2026 10:44:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC093408001
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jul 2026 10:44:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783680280; cv=none; b=QFAnU2JbCHkCBlb2wJoIxPjouMjL8oemiZghdkkdhOS9yZeU6Cq9PBwPAmk35lNQIcfL0Yex4UluHY7t+VXgeKvzsJRcJJt8jZmojr4cly1wsYPpQAAwJVIujXOD2Q/7xU4etyYabACEkyS0bkTtGiLpKcE/A53BmML+FNMsU2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783680280; c=relaxed/simple;
	bh=yXlFq89Ny8qj90p1Uvqrah41kJAxuXF8ZeG/cqe/ZqA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=FgywmLvSxtUVGsdp6muuhIz3ePh1kY3+xnYJQ7ZEUK154byk8DoQGIIHUt2xluxB5KX/265sqC7Wd1gZJj2Yn3G+LFjg3FbxbEOAOQx5q1HTK8uY5onnrFGHGZ3GMKnkKyeZ6OdYsQSo7eoxzJeTyPqXuvwEvu1rpAx/eLiBRuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxLHJ983; arc=none smtp.client-ip=209.85.216.54
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso823297a91.3
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jul 2026 03:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783680278; x=1784285078; darn=vger.kernel.org;
        h=content-type:mime-version:subject:references:in-reply-to:message-id
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yXlFq89Ny8qj90p1Uvqrah41kJAxuXF8ZeG/cqe/ZqA=;
        b=GxLHJ983BEy57FH2ZtuQrGWNJEW4CJalwNAub9nFhP9fOC66tPdoS/CFYiBuw68/KX
         68Y6GZ7IIO9w225vGa+ReZGrQL5/7WDobml0IvOQQQdEr7Io+SJdtHUiJL0QNk3Lg1LO
         bfzXNwfRN8MpHcHOe36qpUoJOAa0kOtdY+ovd1MBV1G0xfsn8lzG2CbPQI7ihS425daQ
         LJZGs7uecTFwEDiHBzrWXK4aI7rfhPEj/JWsc+KSER7qHj1fHiHtREC/+68Rf64V+Ldx
         f8A6xbd3OIvVreHMRO7I8q5ZHyIZFMr8Wl+pWss6gCbJFzU/yRbtpWgFjS43EDT3grIM
         xmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783680278; x=1784285078;
        h=content-type:mime-version:subject:references:in-reply-to:message-id
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yXlFq89Ny8qj90p1Uvqrah41kJAxuXF8ZeG/cqe/ZqA=;
        b=OT93sNWxpieWA74OXOjUibWhsqpoQsW4BD2Y175PowR0Q+p6zoiK/zmPyAJoV5MlEb
         WShsxZY+43unbUFfwaB91Mk7NXJCLuZ0yCxXEZnn6K42Ite8R+su4ZIyHeJDCbsG+0Hh
         Tgn0Ae0NL+tVzZNeHESh39LdG9a5IUZwX+qwDoVCIvCBjjEFDk3SWu3dXb3E6y9V7mbz
         X/i7Vz/eck0FESJyzgOcc54PB8cuBH+2BBv9Z8yymI8L9BB/MXHOndpHaJPYKZrc9XB6
         PNb6jnsSQcsaAcRSvTXfcTGkMbMNwWDx2I+3awr/1Rqj1f0bilUZ23oJHDKewmijXssj
         pJWw==
X-Forwarded-Encrypted: i=1; AHgh+RqCPxHId6uvxQJpmCjK11xnQ2jfYJPNO5UdYwJQLdeZWfIK7cSWi+Z+j5nGS2fAseElFnRXUKxmjcEp2l2BcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyC9s82W4amCYpgNBIrFfx01f5+18W3hMIvlN8ezWKDgDROV0Xz
	dhysR7sqMTrAxkVl6op6fEMX7t8dB+M6rQAxubgEBrJhv7flgRajyMc1
X-Gm-Gg: AfdE7cn0Rv1uTrYHCmZj4amrVdEzZd19340OPl0pZY6rZipPBr0f6USwuRPdysdIODa
	5MpRbjtShpdWjIMsNoYsUCFaX0HQGVnvvy3VlOmV9ijLJm+cA7tZiZ2XxAWSEQGsgWW4Q9zJMHD
	eo93Q4BZhlh9++tflTkfeBVbvlO/Xn6N33rjF5taYkA3Imr4dTJ95wIwjZyPFHoIAh5eA9DorzX
	D59K4irdsPgwQM3LXWy4CVaWGStK/j8oM5s2X58BMgDGMOxqe8Ib15IroXJKGaUqw2A3BHP13/g
	6RF+ZODh7wi1Z73cn6ncsjm26QrT/ISU7I4kW0rrVgGJw6QgV/neuL+/dqctR3TudkRgZ/UWE//
	7l08Zovc08m3Ev5sh/EhARuo16G9HogqcTogQAvPGA/QSZ4yjs7l+aLl2DjIYyPPVxXqXMF79kJ
	MwlW32Aab/uG46F8zGfdWqbIMS4A==
X-Received: by 2002:a17:90b:3fc8:b0:384:a641:3fe with SMTP id 98e67ed59e1d1-38941cc4cffmr10480170a91.21.1783680277870;
        Fri, 10 Jul 2026 03:44:37 -0700 (PDT)
Received: from [fd54:4::10:0] ([2602:fb95:18:520e::7790:520e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311b00048a3sm10156850eec.5.2026.07.10.03.44.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jul 2026 03:44:37 -0700 (PDT)
Date: Fri, 10 Jul 2026 19:44:27 +0900
From: skyexpoc <skyexpoc@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>, Brian Norris
 <briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, Kalle
 Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>
Message-ID: <8b98582b-1120-46ff-8fa6-fd30a6b13016@Canary>
In-Reply-To: <1462bcdb0944bfd3ae7ac9618cc59ab6cf75dfc6.camel@sipsolutions.net>
References: <20260629120333.94222-1-skyexpoc@gmail.com>
 <20260710072140.GA17790@francesco-nb>
 <1462bcdb0944bfd3ae7ac9618cc59ab6cf75dfc6.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mwifiex: bound uAP association event IEs to
 the event buffer
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="6a50cd0b_66334873_12d9"; 
 protocol="application/pgp-signature"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,multipart/alternative,text/plain];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38847-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:~];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:briannorris@chromium.org,m:francesco@dolcini.it,m:kees@kernel.org,m:linux-kernel@vger.kernel.org,m:kvalo@kernel.org,m:linux-wireless@vger.kernel.org,m:miriam.rachel.korenblit@intel.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[skyexpoc@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skyexpoc@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CBBA5739CFB

--6a50cd0b_66334873_12d9
Content-Type: multipart/alternative; boundary="6a50cd0b_643c9869_12d9"

--6a50cd0b_643c9869_12d9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> Should we consider the firmware trust-worthy or should we validate
> everything we receive from it=3F Is there some agreement on this topic
> in general=3F

=46or mwifiex there's a concrete reason not to trust it: besides the
SDIO/PCIe parts, mwifiex also drives USB dongles (8797/8801/8997), so the=

=22firmware=22 can sit on a hot-pluggable, potentially attacker-supplied
device. A malformed event from such a device is the same threat model as
any other malicious USB peripheral, not just a hypothetical firmware bug.=


There is also precedent inside mwifiex itself: commit 119585281617
(=22wifi: mwifiex: =46ix OOB and integer underflow when rx packets=22) al=
ready
added exactly these bounds checks to the receive-data path. This patch is=

the same class of fix for the uAP event path, which that commit did not
cover.

So I'd say it's consistent with how the driver already treats
firmware-reported lengths and agreed, worth fixing.

Thanks,
HE WEI=EF=BC=88=E3=82=AE=E3=82=AB=E3=82=AF=EF=BC=89

> On =46riday, Jul 10, 2026 at 4:41 PM, Johannes Berg <johannes=40sipsolu=
tions.net (mailto:johannes=40sipsolutions.net)> wrote:
> On =46ri, 2026-07-10 at 09:21 +0200, =46rancesco Dolcini wrote:
> > I think we received a few patches that are validating the data receiv=
ed
> > from the firmware (including this one).
> >
> > I did not review any of them yet, what is your opinion on those=3F
> >
> > Should we consider the firmware trust-worth or should we validate
> > everything we receive from it=3F Is there some agreement on this topi=
c in
> > general=3F
>
> I don't really know fully =22in general=22, but I/we generally treat th=
ese
> as issues. I'm not going to worry too much about them, but I think we
> should fix them.
>
> johannes

--6a50cd0b_643c9869_12d9
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html xmlns=3D=22http://www.w3.org/1999/xhtml=22><head> <title></title> <=
meta name=3D=22viewport=22 content=3D=22width=3Ddevice-width, initial-sca=
le=3D1.0, user-scalable=3Dno=22> </head> <body style=3D=22font-family:Hel=
vetica;color:=23000000;font-size:14px;=22><img id=3D=22664DE36D10922C4B00=
D8953032=46BA488=22 alt=3D=22=22 width=3D=220px=22 src=3D=22https://recei=
pts.canarymail.io/track/954209=46B9=463EB=462E9B6BDA7EA95317=46A=5F664DE3=
6D10922C4B00D8953032=46BA488.png=22 height=3D=220px=22><div id=3D=22Canar=
yBody=22 dir=3D=22auto=22> <div> <div>&gt; Should we consider the firmwar=
e trust-worthy or should we validate</div><div>&gt; everything we receive=
 from it=3F Is there some agreement on this topic</div><div>&gt; in gener=
al=3F</div><div><br></div><div>=46or mwifiex there's a concrete reason no=
t to trust it: besides the</div><div>SDIO/PCIe parts, mwifiex also drives=
 USB dongles (8797/8801/8997), so the</div><div>=22firmware=22 can sit on=
 a hot-pluggable, potentially attacker-supplied</div><div>device. A malfo=
rmed event from such a device is the same threat model as</div><div>any o=
ther malicious USB peripheral, not just a hypothetical firmware bug.</div=
><div><br></div><div>There is also precedent inside mwifiex itself: commi=
t 119585281617</div><div>(=22wifi: mwifiex: =46ix OOB and integer underfl=
ow when rx packets=22) already</div><div>added exactly these bounds check=
s to the receive-data path. This patch is</div><div>the same class of fix=
 for the uAP event path, which that commit did not</div><div>cover.</div>=
<div><br></div><div>So I'd say it's consistent with how the driver alread=
y treats</div><div>firmware-reported lengths and agreed, worth fixing.</d=
iv><div><br></div><div>Thanks,</div><div>HE WEI=EF=BC=88=E3=82=AE=E3=82=AB=
=E3=82=AF=EF=BC=89</div> </div> <div><br></div> </div> <div id=3D=22Canar=
ySig=22> <div> <div><br></div> <div><br></div> </div> </div> <div id=3D=22=
CanaryDropbox=22> </div> <blockquote id=3D=22CanaryBlockquote=22> <div> <=
div>On =46riday, Jul 10, 2026 at 4:41 PM, Johannes Berg &lt;<a href=3D=22=
mailto:johannes=40sipsolutions.net=22>johannes=40sipsolutions.net</a>&gt;=
 wrote:<br></div> <div>On =46ri, 2026-07-10 at 09:21 +0200, =46rancesco D=
olcini wrote: <br><blockquote type=3D=22cite=22>I think we received a few=
 patches that are validating the data received <br>from the firmware (inc=
luding this one). <br> <br>I did not review any of them yet, what is your=
 opinion on those=3F <br> <br>Should we consider the firmware trust-worth=
 or should we validate <br>everything we receive from it=3F Is there some=
 agreement on this topic in <br>general=3F <br></blockquote> <br>I don't =
really know fully =22in general=22, but I/we generally treat these <br>as=
 issues. I'm not going to worry too much about them, but I think we <br>s=
hould fix them. <br> <br>johannes <br></div> </div> </blockquote> </body>=
</html>
--6a50cd0b_643c9869_12d9--

--6a50cd0b_66334873_12d9
Content-Type: application/pgp-signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: Canary PGP V3

iQJIBAADCgAyKxxIRSBXRUnvvIjjgq7jgqvjgq/vvIkgPHNreWV4cG9jQGdtYWls
LmNvbT4FAmpQzQsACgkQ5NEvu1xWDZSFtBAA35DlSI0/f671BTHolH1N/yk57ao4
noO6uvbcuPBSzjrO+lqERQfNRF+Z2kcRAxQ9V8sYKnQGPg++jZezgOmvDnSbOgfj
0/9vgmhmNjkl8xSjISJ7jwBe1F6vztZdfWZSj1tpAA7Ibg10KRVqn7cRuVJSOn9T
0jdnPD9tJv0cXzUErPvph5/JOGoU+zz+4bNPFYuqsxNkKDrK6O5DBkRZDL8LQCgE
ZLTqwuO2ERfSi7+19tHkAaLoajUdVXdtdlEUGkYGcLSUUMNCqOdZoP6Vwhrarqyj
XFtAq4HCqaxtjbLJ/RmiBAQm9gzFK3so5sRTuPzaY3yL7SR8tOeWiFtptRjrrs37
2JVutQGKqzSri0xMnv3TvMMz2g4xBDOnnqCrEtZ+zrdoGHJCyrDrIAtXlU7KeLjj
dKXJk80uCS43p/Aa5TzqywDP1/+KR9agb1J+34rLV9WUQA15spDdV2RR7VeYwfBs
ZGz287k5EKYDZXUZ7aME7k/dCcPnsL6UJ2kHglPRwdmUzjzkosdPEL8rv17sjO/Q
qopgh/65hKOvPYVmz8Dh/g21pk6xYQXqrh7bUOjL3W9E02DB+EfGUq3PAu9q2OJp
/sdTG7Q6gXiy7ctZJazFjGGpKJXZ5qOqqdmILgefeYQ10Mi85sBXYikiitesY31U
iK7d9uzjd84lflQ=
=7EF6
-----END PGP SIGNATURE-----

--6a50cd0b_66334873_12d9--


