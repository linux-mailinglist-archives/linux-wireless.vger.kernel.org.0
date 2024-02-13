Return-Path: <linux-wireless+bounces-3539-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130A5853228
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 14:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3770C1C22652
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 13:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1701A5645D;
	Tue, 13 Feb 2024 13:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="croVanCo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB5156444
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 13:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707831803; cv=none; b=praGgIgAlqEPCTOpQ5YhrwThsA5Gy63Ut2tRS3RuQfnmcac+zMA9BcN4xZgfRNrr1+kdjl8ztjVP28n8oG+DVMSrE+YqOt+197mtXiSrKHxtYexYWRkcYdysizBapoozYY8rUYRTJEt7i/7YHq+11refmnnm+BdV4w7GIw75+so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707831803; c=relaxed/simple;
	bh=lr+aqRKl33J/rN8yAkI4kIRi4H5thxV7kqsUVmOjQwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h03q1//fAXYps2iVrl1xfFoH82Pp8q6U45aeQ9UW3rIguIHSQwWexiiQypkNNVBF8Z6dS2ZmN6Oths7ASMlePK95QT/ogQ+abz3aeB8/ivICvjVjxXC5PcHbevTD9eooB1EOiwnYTmOJxA91j+aCH/A2qEyYJt2x7CwYaf7c27g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=croVanCo; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55a90a0a1a1so6065927a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 05:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707831799; x=1708436599; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lr+aqRKl33J/rN8yAkI4kIRi4H5thxV7kqsUVmOjQwQ=;
        b=croVanCoRpHRB8REZZqGVJ6R1RCjS7AisEL+0TDmkfWp4sdRhkAEExWVy/CPNuFUx0
         QTlHOWHk0i4qhTYF/FOQAIglUwi5JkV/2sggu7crLaVMSm9kZ9DxGTgE4j03/cj2VDwh
         eU9y6I6Xj78z9i0yBqEsgaDBYpZnT2rnzTWHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707831799; x=1708436599;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lr+aqRKl33J/rN8yAkI4kIRi4H5thxV7kqsUVmOjQwQ=;
        b=Xf9800O5r/87c6Y7EmVbWRso/hKSuItEc6OMxPZ+HU50FyXE6U7te6OiGmxSPVmR1Q
         jZYIf8TeVEpYPXxVVZIJWI+PvHh3/goy+7Q5fHCxfjRw8wTqrNaDr3aUTo/BgcDHFcLH
         GzCgCCqEcN/aUgF7UT1znSSVJkP9Uys4BcKDkjtjVg/ifrG8JoNLx5zxthgsMaHTuJRP
         ANAMdVz0s/fKPldPg4CKcKnpMunwIR4lL/PVSImzvU8+pR2tgPNNv9JY59EF08lG1XhA
         8g2vwOUypkSRufiIg0RRDkevInESXiXnSSAtlelotH3llFF0cBs1G/lTlK1VMtlJT2mb
         iZ3w==
X-Gm-Message-State: AOJu0YzDgjpftwuCNE3T5SN9lhNc+Flr/GLBshhVJqUoQzwclBi9Gpmr
	JuJcHOEwNTjAiYBL90WC3VYJsvEEEw1FBDJZjQ4BNfUVLOQqafQPN5U42XnPUc0nbb0KcCSfkMp
	Kn/SakeRpKDfh38mmAcy5odMsX3lW5zGyjPIX
X-Google-Smtp-Source: AGHT+IGJqdxtPWbiGnbGbwaVFW3r22vEJpQbY/iIp3/h1EKqA6p7dNtQ/6brRWbzcwQ+DP0GBF8NYxqRmYhD5LDEXYg=
X-Received: by 2002:a50:fb02:0:b0:562:1375:b2d2 with SMTP id
 d2-20020a50fb02000000b005621375b2d2mr171491edq.37.1707831799337; Tue, 13 Feb
 2024 05:43:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <309965e8ef4d220053ca7e6bd34393f892ea1bb8.1707486287.git.vinayak.yadawad@broadcom.com>
 <87mss6f8jh.fsf@kernel.org> <2c38eaed47808a076b6986412f92bb955b0599c3.camel@sipsolutions.net>
 <b4d44fb5-78e5-4408-a108-2c3d340b090e@broadcom.com> <b00c3b53cd740e998163f84511ee05dc3051ce8b.camel@sipsolutions.net>
 <df8f02b1-25b0-4dae-a935-cee9ba7f3dc4@broadcom.com> <0cb1d7ef63ad1ea1ff4109d85a6bcdcaca16f1c8.camel@sipsolutions.net>
 <6eaab8fa-f62e-4f78-9cbe-9b13e3d77ca7@broadcom.com> <ca517fb19f78e3c507fd315e2f30e5efa4723eb8.camel@sipsolutions.net>
 <87y1boedex.fsf@kernel.org>
In-Reply-To: <87y1boedex.fsf@kernel.org>
From: Jithu Jance <jithu.jance@broadcom.com>
Date: Tue, 13 Feb 2024 19:13:05 +0530
Message-ID: <CA+gyVQ0DWj1GLzf5z0qA=HV4e8swuTmW+c_1kw6LmpsaAhRXdg@mail.gmail.com>
Subject: Re: [PATCH 1/1] wifi: nl80211: Add support for plumbing SAE groups to driver
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, 
	Vinayak Yadawad <vinayak.yadawad@broadcom.com>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c18d36061143937b"

--000000000000c18d36061143937b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johannes, Kalle,

>I'm sure it's for an out-of-tree driver.
Yes, it's for an out of tree driver.

> I've said this before: I can't maintain something well that I cannot see =
(and possibly change) the user(s) of.
>I recall the rule was that nl80211 API changes should also have at least o=
ne driver implementing it.
Got your point. The recent efforts for patch submission was to align
more with the nl80211/cfg80211 interface and remove vendor
patches/interfaces.
I wasn=E2=80=99t aware of this upstream requirement, but I do get your poin=
t
that the requirement is to have at least one driver that exercises
these interfaces for code maintainability/understanding the why
interface changes are needed.

>A practical tip I can give to Broadcom is to remind that you have a great =
engineer with upstream knowledge: Arend
>And thenever you add a new feature to the stack, add support to brcm80211 =
driver at the same time. This help Broadcom to get the feature you need to =
upstream and the upstream community would have a better Broadcom driver.
Thanks for the inputs. Let me sync up internally and get back.

Thanks,


On Tue, Feb 13, 2024 at 6:20=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrote=
:
>
> Johannes Berg <johannes@sipsolutions.net> writes:
>
> > On Tue, 2024-02-13 at 13:19 +0100, Arend van Spriel wrote:
> >
> >> On 2/13/2024 12:45 PM, Johannes Berg wrote:
> >> > On Tue, 2024-02-13 at 12:13 +0100, Arend van Spriel wrote:
> >> > >
> >> > > I recall the rule was that nl80211 API changes
> >> > > should also have at least one driver implementing it. Guess we let=
 that
> >> > > slip a couple of times. I fully agree enforcing this.
> >> >
> >> > Well, enforcing it strictly never really worked all that well in
> >> > practice, since you don't necessarily want to have a complex driver
> >> > implementation while hashing out the API, and the API fundamentally =
has
> >> > to come first.
> >> >
> >> > So in a sense it comes down to trust, and that people will actually
> >> > follow up with implementations. And yeah, plans can change and you e=
nd
> >> > up not really supporting everything that was defined ... that's life=
, I
> >> > guess.
> >> >
> >> > But the mode here seems to be that there's not even any _intent_ to =
do
> >> > that?
> >> >
> >> > I guess we could hash out the API, review the patches, and then _not=
_
> >> > apply them until a driver is ready? So the first round of reviews wo=
uld
> >> > still come with API only, but once that settles we don't actually me=
rge
> >> > it immediately, unlike normally where we merge a patch we've reviewe=
d?
> >> > And then if whoever did it lost interest, we already have a reviewed
> >> > version for anyone else who might need it?
> >>
> >> Sounds like a plan. Maybe they can get a separate state in patchwork a=
nd
> >> let them sit there for grabs.
> >
> > I guess I can leave them open as 'under review' or something? Not sure
> > we can add other states.
>
> I belong to the church of 'Clean Inbox' so I use 'Deferred' state for
> stuff I can't work on right now. Though I know a lot of people don't
> like it because deferred patches are not shown in the default patchwok
> view.
>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

--000000000000c18d36061143937b
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
YIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIM1wv73giWlxe2mIXomdqEWR4OYMFH4QUDAr
cOE/htssMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIxMzEz
NDMxOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATAN
BgkqhkiG9w0BAQEFAASCAQDLC+vaytKXgz0Yhy8bHgbcx91hO1F66B78PP/8drOYK+W7xdQ4QV89
cM63rogLEqNnpwECyotGTgfZ71rYjdGfE2IruU1HFOk/U6GmiUj5mW/h+GaeCku0wA7D2vhetSCu
aPUokPGKT5ZCV8OCHZAv9YchVR2AWsXqMY2H0KlGW3MyCDvFCQXML5ebxYyS6yyVo1hpFX+5gRG4
w8EEzTXckzKeZzgzXICFELLAyCfJu1fSG1eo7xLXFthslnuxlOaV9V4Ro7umdlNakAgzdqdy2/0I
b++ufThK69LG1TRBBcT8w/VZGFxwOz2bpQvb+0EquT3PVdGCyBbt4IC07RmB
--000000000000c18d36061143937b--

