Return-Path: <linux-wireless+bounces-220-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 413737FD745
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 13:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3963B20FCC
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 12:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3331DFC9;
	Wed, 29 Nov 2023 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZsUjp5RX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4855BA
	for <linux-wireless@vger.kernel.org>; Wed, 29 Nov 2023 04:57:53 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5d2d0661a8dso1390737b3.2
        for <linux-wireless@vger.kernel.org>; Wed, 29 Nov 2023 04:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701262673; x=1701867473; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wEslNNtdBmS1QHFRQbk3gJLGhWtArQc5W/0t56HnWdU=;
        b=ZsUjp5RXgp/GnAjDdg74Whwz8b5KLjQgoNg//nTdTrN/03d/K9eS/fCA3+CClaREkI
         SpnL6TH6BUnPLv/JP9IywV4TEmdTDA5k8Pgm2rFST11HCAwqZ0L5EqnX9Z7OpDaxbw0D
         wQC0xESFIWs4oL/iWhVnV40RuBTnSeThLKkuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701262673; x=1701867473;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wEslNNtdBmS1QHFRQbk3gJLGhWtArQc5W/0t56HnWdU=;
        b=hdTFT03zXVllVXK1Ezfksn2Bx46cI4gdPS+sgkNYxrsRbBwpddUL590TrmmQWTFh4H
         w1ux9Z1m+fU7ot+A3xhqyeWGFq+weBN55tJaflhxFvFBPlsGRtTEBCB3AljjxWzQY5cK
         i5vQ2Lztm5uJf6wevLnUKP8P5BVtOEsQh/CvCNwmJaFaB8wYP5Aqe91/ZOgXif3dEFIY
         xmd6BS5SJ17c/c/pPxcdsF9WZjfJr681o7E+ldwF222N8RMmaoeBz5uNkFOBy/2pwAm7
         +gvipueJRxMcBG9mtGDXIngO1day2D1GU0YRbKFqT9xBW+FoPLi5cWrhiREquiCdZj1l
         9QBw==
X-Gm-Message-State: AOJu0YzILK5mtSPhr5fcJok8oZR4+wwwDSnygyCyRXk6nt5UNIkgCCSX
	D0vl53CrFS1gBX/7wkHA+Tldihtx/jkccykgNQK+Jvv/VFtTrGf1
X-Google-Smtp-Source: AGHT+IGApyF2bwqBXbzQd/ThF72Xv7iV903+aC7axkwJLK9Im9i/CfmrylW6+M0GUnczjgBz/hrF0jPQyi1dZp1bl/w=
X-Received: by 2002:a25:248f:0:b0:db3:64ee:94b6 with SMTP id
 k137-20020a25248f000000b00db364ee94b6mr17872321ybk.64.1701262672759; Wed, 29
 Nov 2023 04:57:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ff0778a86574b552769027496f12596e2e627931.1699530774.git.vinayak.yadawad@broadcom.com>
 <da6f058b85f91af5d4abd10bc56034f8d7811e86.camel@sipsolutions.net>
In-Reply-To: <da6f058b85f91af5d4abd10bc56034f8d7811e86.camel@sipsolutions.net>
From: Vinayak Yadawad <vinayak.yadawad@broadcom.com>
Date: Wed, 29 Nov 2023 18:27:40 +0530
Message-ID: <CAMLe8U_zqptHJ4vaHwhu_bY1ifJjvcwqg6yVdy8UB=HizRgY1w@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] wifi: nl80211: Extend del pmksa support for SAE
 and OWE security
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, jithu.jance@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000004d4822060b4a15ee"

--0000000000004d4822060b4a15ee
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johannes,

Thanks for the review comments.

>Maybe it'd be better to split set/del now? The code kind of looks
>awkward now, don't you think?
>Or split this part of the parsing depending on set or del?
As suggested, set and del pmksa handling is split.

>The indentation here is also really awful ... I'd rather go over 80
>columns than break like that. But you could just have local variables
>for all the feature checks too.
>And if you don't split set/del, I'd recommend a variable for that too,
>set at the beginning, perhaps moving the "rdev_ops" thing up? But I'm
>thinking it's probably nicer to split it. See how that looks like?
Addressed comments by splitting set and del pmksa and using local
variables for feature checks.

>Then again, that isn't even relevant for DEL, is it? Should we even
>parse it? Does anyone want to "delete only if it's exactly this PMK"?
Removed this handling for DEL pmksa.

>Also seems like this should come with some nl80211.h updates though?
Added additional description for the DEL pmksa documentation.

Regards,
Vinayak


On Sat, Nov 25, 2023 at 12:28=E2=80=AFAM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> On Thu, 2023-11-09 at 18:00 +0530, Vinayak Yadawad wrote:
> >
> > +++ b/net/wireless/nl80211.c
> > @@ -12183,24 +12183,37 @@ static int nl80211_setdel_pmksa(struct sk_buf=
f *skb, struct genl_info *info)
> >
> >       memset(&pmksa, 0, sizeof(struct cfg80211_pmksa));
> >
> > -     if (!info->attrs[NL80211_ATTR_PMKID])
> > +     if ((info->genlhdr->cmd =3D=3D NL80211_CMD_SET_PMKSA) &&
> > +         (!info->attrs[NL80211_ATTR_PMKID]))
> >               return -EINVAL;
>
> Maybe it'd be better to split set/del now? The code kind of looks
> awkward now, don't you think?
>
> Or split this part of the parsing depending on set or del?
>
> > -     pmksa.pmkid =3D nla_data(info->attrs[NL80211_ATTR_PMKID]);
> > +     if (info->attrs[NL80211_ATTR_PMKID])
> > +             pmksa.pmkid =3D nla_data(info->attrs[NL80211_ATTR_PMKID])=
;
> >
> >       if (info->attrs[NL80211_ATTR_MAC]) {
> >               pmksa.bssid =3D nla_data(info->attrs[NL80211_ATTR_MAC]);
> > -     } else if (info->attrs[NL80211_ATTR_SSID] &&
> > -                info->attrs[NL80211_ATTR_FILS_CACHE_ID] &&
> > -                (info->genlhdr->cmd =3D=3D NL80211_CMD_DEL_PMKSA ||
> > +     } else if (info->attrs[NL80211_ATTR_SSID]) {
> > +             /* SSID based pmksa flush suppported only for FILS,
> > +              * OWE/SAE OFFLOAD cases
> > +              */
> > +             if (info->attrs[NL80211_ATTR_FILS_CACHE_ID] &&
> > +                 (info->genlhdr->cmd =3D=3D NL80211_CMD_DEL_PMKSA ||
> >                   info->attrs[NL80211_ATTR_PMK])) {
> > +                     pmksa.cache_id =3D
> > +                             nla_data(info->attrs[NL80211_ATTR_FILS_CA=
CHE_ID]);
> > +             } else if ((info->genlhdr->cmd =3D=3D NL80211_CMD_DEL_PMK=
SA) &&
> > +                 (!wiphy_ext_feature_isset(
> > +                 &rdev->wiphy, NL80211_EXT_FEATURE_SAE_OFFLOAD) &&
> > +                 (!wiphy_ext_feature_isset(
> > +                 &rdev->wiphy,NL80211_EXT_FEATURE_OWE_OFFLOAD)))){
>
>
> The indentation here is also really awful ... I'd rather go over 80
> columns than break like that. But you could just have local variables
> for all the feature checks too.
>
> And if you don't split set/del, I'd recommend a variable for that too,
> set at the beginning, perhaps moving the "rdev_ops" thing up? But I'm
> thinking it's probably nicer to split it. See how that looks like?
>
> > +                     return -EINVAL;
> > +             }
> >               pmksa.ssid =3D nla_data(info->attrs[NL80211_ATTR_SSID]);
> >               pmksa.ssid_len =3D nla_len(info->attrs[NL80211_ATTR_SSID]=
);
> > -             pmksa.cache_id =3D
> > -                     nla_data(info->attrs[NL80211_ATTR_FILS_CACHE_ID])=
;
> >       } else {
> >               return -EINVAL;
> >       }
> > +
> >       if (info->attrs[NL80211_ATTR_PMK]) {
>
> Then again, that isn't even relevant for DEL, is it? Should we even
> parse it? Does anyone want to "delete only if it's exactly this PMK"?
>
>
> Also seems like this should come with some nl80211.h updates though?
>
> johannes

--0000000000004d4822060b4a15ee
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQdgYJKoZIhvcNAQcCoIIQZzCCEGMCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3NMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVUwggQ9oAMCAQICDEjF3ute0cvPjxoy1DANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxNDAxMTZaFw0yNTA5MTAxNDAxMTZaMIGU
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGDAWBgNVBAMTD1ZpbmF5YWsgWWFkYXdhZDErMCkGCSqGSIb3
DQEJARYcdmluYXlhay55YWRhd2FkQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBALGluSWGaYhsVi4bVabRPDQnYm//51u0IMWWKXgroawPGc8DFXsY5rRTKSEe2t57
Hcu6+9qBRZbf5cEsMo7DsnKxIforzj/CyPiHEGEVZeYlY77I+PsanMKbsn/DPEm8SSUHQTolLSDs
CLNrmVICkId5Y89k1xD0LqFL8po1wGwL+UK16vjVcp3V8IUpjtysuMxSc94V6stvWZav4sEyQ1bz
RY30ttFfLGgUxOvRzd7UPGXmjiRyV20Vv+kGag5aTueKGHUv49TWypHgJc4PX8L9y3VouEhbWmGb
bwuQjKELfovabHM5PWUVRda3t72kGFVMkIZ65u6DCdyjPFCUGnMCAwEAAaOCAd0wggHZMA4GA1Ud
DwEB/wQEAwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUu
Z2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggr
BgEFBQcwAYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAwTQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3
Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4
aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmww
JwYDVR0RBCAwHoEcdmluYXlhay55YWRhd2FkQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEF
BQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUS9fHYxc9qAJz
gfBKun+P2LFASWAwDQYJKoZIhvcNAQELBQADggEBABiMQNJRdQCxXwqwqb49w0ZXCxsSrs3gS4NA
G3H9oJuvzJ8ml5Z9l9p9PGPHcrmc/BdFjIIu/wQftGETAf1+W6AvxXqYmA2flaogebRueqCMQJiy
xbJlOSry64AGOzHYULvI70tt9woEYgSx3I703b7c8o7eWCiU267y/WNzH+MpZ12h9q0Jwhw8uH9S
BTl38q8FNdCLAiM1OD+blhu7LqMLVaAEEeoUGhRxdNkvMGss1Z7/ZefenAfm9IpiaGR0PQhBwI7c
spqD/wIJUULcXiaj0eatDUjsrx3QN9OZOh3iubCt0uBoxCQUGuvxqd3Qz4FVKMSzEIzs8v/hwR+T
nTkxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
MTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxIxd7r
XtHLz48aMtQwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOlPzeI9pKRecZXSzieS
uCuOIrlnt0egRRhTbQB6wMOWMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTIzMTEyOTEyNTc1M1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA9Ukg3uv308UgncNeZRuqOrR943/kS1S2DCqHe
94p8We9d2hbeCYNwsTXmkdMeX51QhR8p3PETASAfADIs4NXfWh6oa/Wp4tGz0MYmAc+vdnwzbtbU
fRXhdPjaPgIdW9w8UL71EWEoM/5nhXcRRBJNHQ/k70/yJ8mtDtwgUEVlksu8FC4UcERASk4Kv5V7
AIGQJrqh85SGZCIaAzbFQnZwPuO9qjrMaF4Ou0F491vh7+JiimV77MonpbQs6r/LUeUowTpyrbEf
6KSFIULQm6wnglR71zZQqT3uzNK7/JbmF1TEMS7InFJVj42UapCJGxE+W6zZXaQHhqvSRaQXgr1S
--0000000000004d4822060b4a15ee--

