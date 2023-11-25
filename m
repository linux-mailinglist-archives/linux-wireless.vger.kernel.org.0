Return-Path: <linux-wireless+bounces-69-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FE37F87E0
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Nov 2023 03:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C82CB2129A
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Nov 2023 02:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E1F138A;
	Sat, 25 Nov 2023 02:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eUJq3iGj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02905E1
	for <linux-wireless@vger.kernel.org>; Fri, 24 Nov 2023 18:40:33 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a03a900956dso474395166b.1
        for <linux-wireless@vger.kernel.org>; Fri, 24 Nov 2023 18:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1700880031; x=1701484831; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HQaKyi0B71ei0sjRzHS90hU6RIYmUyqbs52s4MkWRLE=;
        b=eUJq3iGj3kc/snsUqM88rIhweP0+Dxk7HBpB++YsCigjIrSEK0bwp2GpGU1vG0yhcL
         35uPMV+pYeD1M+L9OXs/sX4EIx+BiBGLk+/uU8IBvMdGFtCjiJ5+5uL8vGg8idrkCjKz
         I8IZEwiHCf9rDEC49HNoN9ZZC8eqFWVq4/7oQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700880031; x=1701484831;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HQaKyi0B71ei0sjRzHS90hU6RIYmUyqbs52s4MkWRLE=;
        b=lbvd9pnW5+uKzKj1mY9eHxd0np6SMd8sRAFhAHR4eBw2e55q5jFsl5kuLih3ujzMOu
         xVsL74Sskwo6UUKeAWmRpiSCiXV1jcsJtEPc/9FP0JaWTfZbcyY0GxK3WjtW87FcCOyz
         bModL/kR+JQX1Ls6q6O3BPERqZeDku7zRwSRj0tXCXQ3w6Nxe3OyjvZe6czBULGqTMT5
         v9HJFrl8lUNpYHoheTlPad/DJIDVTZsJeTn8Gmny7bpk/247gmn+Hx1A2/bxyzOyTFwe
         /Kfvt/UNT/JCJHfM8UxIOjYpnxi5Z60TK0Cktdv2qmYrny9BGAJJD6+kcIxpw4puyMAw
         T00g==
X-Gm-Message-State: AOJu0YwQNJUBQmUqnLW7EXSvL15d0gUkzT4DCjhqQOPbMxvZXTIjR4XM
	1eW6QEkKSNmxtLYwjVcYktMcLCZt6fuzUcdi9YQhZQ==
X-Google-Smtp-Source: AGHT+IGocfx4u4d3KYdM7ZqQ6QDFTpGxenpzFqGlZFVxE3okaA3WDv3sfJ6yLWxyB2F4Xc2ZMg0re6syeK7MtckXAkw=
X-Received: by 2002:a17:906:20d8:b0:9fa:5594:4e94 with SMTP id
 c24-20020a17090620d800b009fa55944e94mr4150844ejc.27.1700880031354; Fri, 24
 Nov 2023 18:40:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231113124742.13588-1-jithu.jance@broadcom.com> <1a2ada781ce53e8f1d9c85de44780ee895443c3f.camel@sipsolutions.net>
In-Reply-To: <1a2ada781ce53e8f1d9c85de44780ee895443c3f.camel@sipsolutions.net>
From: Jithu Jance <jithu.jance@broadcom.com>
Date: Sat, 25 Nov 2023 08:10:18 +0530
Message-ID: <CA+gyVQ1UsLTSpSaZxkOyuVsgvOs_uFOBiqw+3MGY8X4fVgh76w@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] wifi: nl80211: Add PTK/GTK rekey interval
 attributes for APs supporting PSK offload
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, vinayak.yadawad@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000190652060af0fe34"

--000000000000190652060af0fe34
Content-Type: multipart/alternative; boundary="000000000000136688060af0fe06"

--000000000000136688060af0fe06
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>That doesn't work, _all_ current drivers will obviously completely
ignore this setting.
Got your point - without this user space will not be sure whether GTK/PTK
will work with the driver even though values are passed down. Will add it.


>Why can you not set both at the same time?!
Yes, agree. will fix it.

*Jithu Jance *


On Sat, Nov 25, 2023 at 12:33=E2=80=AFAM Johannes Berg <johannes@sipsolutio=
ns.net>
wrote:

> On Mon, 2023-11-13 at 18:17 +0530, Jithu Jance wrote:
> > This patch adds attributes to NL80211_CMD_START_AP that the user
> application
> > can use to pass down PTK/GTK rekey interval times to the driver. If
> driver can't
> > support the configuration, it is expected to return failure to
> NL8011_CMD_START_AP.
>
> That doesn't work, _all_ current drivers will obviously completely
> ignore this setting. If you need that behaviour, you need to add new
> feature flags for it.
>
> > +             if (info->attrs[NL80211_ATTR_PTK_REKEY_INTERVAL])
> > +                     settings->ptk_rekey_interval =3D
> nla_get_u32(info->attrs[NL80211_ATTR_PTK_REKEY_INTERVAL]);
> > +             else
> > +                     settings->gtk_rekey_interval =3D
> nla_get_u32(info->attrs[NL80211_ATTR_GTK_REKEY_INTERVAL]);
> >
>
> Why can you not set both at the same time?! That should be documented,
> if it's really desired, but that seems really counter-intuitive?
>
> johannes
>

--000000000000136688060af0fe06
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><font face=3D"verdana, sans-serif">&gt;</font><span style=3D"=
font-family:Arial,Helvetica,sans-serif">That doesn&#39;t work, _all_ curren=
t drivers will obviously completely</span></div>ignore this setting.</div><=
div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:verdana,s=
ans-serif;font-size:small">Got your point - without this user space will no=
t be sure whether GTK/PTK will work with the driver even though values are =
passed down. Will add it.</div><br><div class=3D"gmail_default" style=3D"fo=
nt-family:verdana,sans-serif;font-size:small"><br></div><div><div dir=3D"lt=
r" class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><d=
iv dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D=
"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div style=3D"font-size:12.8px"><fo=
nt size=3D"2">&gt;</font><span style=3D"font-size:small">Why can you not se=
t both at the same time?!</span></div><div style=3D"font-size:12.8px"><font=
 size=3D"2">Y<span class=3D"gmail_default" style=3D"font-family:verdana,san=
s-serif;font-size:small">es, agree. will fix it.</span></font></div><div st=
yle=3D"font-size:12.8px"><font size=3D"2"><font face=3D"verdana, sans-serif=
"><br></font><font style=3D"background-color:rgb(255,255,255)" color=3D"#99=
9999" face=3D"verdana, sans-serif"><b>Jithu Jance=C2=A0</b></font></font></=
div></div></div></div></div></div></div></div></div></div></div></div></div=
></div></div></div><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr=
" class=3D"gmail_attr">On Sat, Nov 25, 2023 at 12:33=E2=80=AFAM Johannes Be=
rg &lt;<a href=3D"mailto:johannes@sipsolutions.net">johannes@sipsolutions.n=
et</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">On Mon, 2023-11-13 at 18:17 +0530, Jithu Jance wrote:<br>
&gt; This patch adds attributes to NL80211_CMD_START_AP that the user appli=
cation<br>
&gt; can use to pass down PTK/GTK rekey interval times to the driver. If dr=
iver can&#39;t<br>
&gt; support the configuration, it is expected to return failure to NL8011_=
CMD_START_AP.<br>
<br>
That doesn&#39;t work, _all_ current drivers will obviously completely<br>
ignore this setting. If you need that behaviour, you need to add new<br>
feature flags for it.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (info-&gt;attrs[NL=
80211_ATTR_PTK_REKEY_INTERVAL])<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0settings-&gt;ptk_rekey_interval =3D nla_get_u32(info-&gt;attrs[NL802=
11_ATTR_PTK_REKEY_INTERVAL]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0settings-&gt;gtk_rekey_interval =3D nla_get_u32(info-&gt;attrs[NL802=
11_ATTR_GTK_REKEY_INTERVAL]);<br>
&gt; <br>
<br>
Why can you not set both at the same time?! That should be documented,<br>
if it&#39;s really desired, but that seems really counter-intuitive?<br>
<br>
johannes<br>
</blockquote></div></div>

--000000000000136688060af0fe06--

--000000000000190652060af0fe34
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mpwrn0/6Sf3DEFfysFSvrnhOv7DRZ1OuvLvE6won+W2My2cUk/GwsJigcfVOIeW+6k8HqYoeS5Gv
DqYgzE2mJ/xRXZNMUqRea8CP9NUSkK5n5JKnGBMFAgMBAAGjggHZMIIB1TAOBgNVHQ8BAf8EBAMC
BaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJlLmdsb2JhbHNp
Z24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYIKwYBBQUHMAGG
NWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwME0G
A1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxz
aWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0dHA6Ly9j
cmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3JsMCMGA1UdEQQc
MBqBGGppdGh1LmphbmNlQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSME
GDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUUOaotQ254RGCyTOE3GmUYiOr6xQw
DQYJKoZIhvcNAQELBQADggEBAJQEmVAg5gHetC6cEpTOOkvxmlpVDUvrqLSJdclgVyEj1rM+Qc4q
VrkDMnRI9JpQ0XgPi+/oebdZ7NcqPnvkNyz1hU9T4i5KwG93YEvqKND02+TrR9TvNCqNhDV3v6qU
8aXoDtJuqSlkH8em+nzdVbHwp/4M9XNfKY2IaItl3wPDs1Ti4D6OewXG+hSmcsvbclgSvZTJnIJI
It9h7f+sXIxBghRNL631e4HsXTIi2U7EM1cnNupsDm6wZzg9O4bVtYexIi1fSy3xbOn+bxJOI4dM
pgEAAsnH2RekyBDHAWHW7qp7P+AXkLoNrQlGqs3r8W2eNgrwcxLphpakQ29LvhMxggJtMIICaQIB
ATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhH
bG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwYVVavV2kh654UE6cwDQYJ
YIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBTGpTlKZluIjnP5v+qHDR9o1QjwpmvFNI+l
HY93xQrSMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTEyNTAy
NDAzMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATAN
BgkqhkiG9w0BAQEFAASCAQCqOuz2PhXy7rqn5OsD9udbJJi4LmDt/oeyJRa4izOdYNOiNCLhqZcH
0Nl8eEBc9VGs5bxwb41qFHkad42KT6TRavE1Nd8+SWxsWKv/GYmHkf9CO3HCYvOfRM6zqa+SneKP
CFgJRMQoHzrYbWxNQhKQTAEijpM4j3edVMnlp8qOEc1ft9vARb5ZmNuIwCJSjoWPk+3NEF1fnRmh
0Ia5BstDi3BLilU+bqSA8oAhiXx6U5D3y0EW4/JZENkn2r5SRzGJ5czT2RAehjtAJaTdv0MGzL7r
fut02ZoX3KkJGbEFWkT/ubBLeSpdl0fAUFwg/VRr5LE0CZfKo6uGNaV4innO
--000000000000190652060af0fe34--

