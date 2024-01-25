Return-Path: <linux-wireless+bounces-2464-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D37A83BA53
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 07:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FDEC1C233EC
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 06:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32592125D8;
	Thu, 25 Jan 2024 06:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R6lQUwFV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C420125CE
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jan 2024 06:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706165505; cv=none; b=PzDivcQB2DeBGri77Tx2am8uOEoqp2iv1efF4Cbb1W3REomc/b5g2fdIubpeu5xDTClrbcoN2Vw005hx0+XXFn/cbe8PZWfUT2GPYtjCZjRcdDjH8RNZUzZ4F13fQtVSd//4MgA6YUgJntuIHBkpvDqcsLwtkm0OhuuVYipvpo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706165505; c=relaxed/simple;
	bh=Bt+9eOUnwHlkAoHsd89cg/W/sjrW3s8hGDR2O74wOYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Um3zixtMvWYfaaZzt+oKIofV6qSg8oVHPXZKX98aXNJc+FuB4BuPZVKO/qh8IWEDzJwYfnTMuU6A7eUYjWHp5EGbiVs9iTKWlLsja4VpJ+OEb4MFjEO8bvREAueTlgeQ3gzaRqlRRGxyLZ7byBmJN8kSqjT00bS6wQnDC49CyuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R6lQUwFV; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55cc794291cso4971a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 24 Jan 2024 22:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706165501; x=1706770301; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bt+9eOUnwHlkAoHsd89cg/W/sjrW3s8hGDR2O74wOYA=;
        b=R6lQUwFVK/IxW1gf5CXZhleMnh8jHnMQf/fkjcOLk7cKelUoN5CCFw3lgu6/YF8NrI
         Iqa2kQMYeCnkDsMrjxKiYhNTOAiDaQb1MxYSH+fDkljZH/GtpEHYDBhb/MHOaUBSx3Ke
         TglPXgrgo7gx/2baI+AG2Ngyqjh33LLAB8eyPSE/aUK5oLHgUeep2ESmpJSSa7QvZFkS
         hvnVUqkGSxmbepfz382Qti2p2/Yjn6eTAfD9GMd4FP37vEUxW+SykQrlYAzdrXcqn8HI
         ss5XFvkmMHjATBIk3j5SAD8Q1zXVYA97LNR8Yw47RbQwf2E6UQIlUvm0s/nyhdaVLUna
         dw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706165501; x=1706770301;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bt+9eOUnwHlkAoHsd89cg/W/sjrW3s8hGDR2O74wOYA=;
        b=hxcQPKkCl6uDO4H8iRkVjYB1tHHEfyLYlQ9M6MdHgNe2V693xGwxzFu7tK/6DDB+9U
         kv74UWurNWMtno0Bs4fWBW3pqD3JtAytz2Be9hUTnOOMKyrd2Xm9FKqey0W86tqgh7KF
         wgW/jbelq74DM/oXSEGKwjh9o/0hQNkX91uHd6ZdDKmLLfD5fA16+Nn4mtZyUARkkoce
         EjuUgItoc6OGgJMKgTOrwtnRY/qixZ0SSek1gqBPTJJ6oBGTFcXw0ZMISkzT4qeShrFW
         TU+UU6yQjJazqOWFAt4LTc2THRs+WnhuJ6tJPaVRL9hRuadQ0WiSi9XiBwQN5hkFPgu1
         TCDw==
X-Gm-Message-State: AOJu0YwBOKXNAc12c2+NXWoHGedbOzHhvoCabO8Bhk4xLCyDtiF72/H0
	sp9INRPScw/594rOHQbcG8H4Laitmd2TGJdQjcdILlzMnMNKHVXWj4bxlo42m1q+Gu3AvaOPEwy
	ryUm7LzfI3dFKNWQZ2ShZO2omZl2JW9v7ci5L
X-Google-Smtp-Source: AGHT+IHRcgggjA4ZiOIk9+RJTltfsj+o92OBZllz4rYYaginl1aDz/oUGE6WlgiEya80dNo2ZV6KKUv0NPA0xTMRrPo=
X-Received: by 2002:aa7:df19:0:b0:55c:f684:424c with SMTP id
 c25-20020aa7df19000000b0055cf684424cmr80424edy.4.1706165501511; Wed, 24 Jan
 2024 22:51:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122153434.E0254C433C7@smtp.kernel.org> <20240123084504.1de9b8ac@kernel.org>
 <d4c1a7c715a1f47dc45c5d033822d8f47e304bd4.camel@sipsolutions.net> <9390c3aeb374e44810e0e93dd48561c1ef1a39d5.camel@sipsolutions.net>
In-Reply-To: <9390c3aeb374e44810e0e93dd48561c1ef1a39d5.camel@sipsolutions.net>
From: David Gow <davidgow@google.com>
Date: Thu, 25 Jan 2024 14:51:28 +0800
Message-ID: <CABVgOSmg5wrv-FyeLZzBRrzARBCuE7uaKakEHv4BikxMUNUACA@mail.gmail.com>
Subject: Re: pull-request: wireless-2024-01-22
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Brendan Higgins <brendanhiggins@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ab398b060fbf9c53"

--000000000000ab398b060fbf9c53
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 02:22, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Tue, 2024-01-23 at 19:19 +0100, Johannes Berg wrote:
> >
> > We're also adding unit tests to iwlwifi (slowly), any idea if we should
> > enable that here also? It _is_ now possible to build PCI stuff on kunit,
> > but it requires some additional config options (virt-pci etc.), not sure
> > that's desirable here? It doesn't need it at runtime for the tests, of
> > course.
> >
>
> Heh, in fact Miri just posted the first bits:
>
> https://lore.kernel.org/r/20240123200528.a4a8af7c091f.I0fb09083317b331168b99b8db39656a126a5cc4d@changeid
>
>
> Also, should enabling that in
> tools/testing/kunit/configs/all_tests.config go through our tree, or
> better through the kselftest tree?
>

I'd definitely like the iwlwifi tests to be enabled in all_tests.config.

The virt-pci options _should_ already be enabled for the UML configs
under kunit.py by default now (they're in
.../configs/arch_uml.config).

I don't mind which tree the changes to all_tests.config go through --
I suspect it's probably better for them to go in via your tree,
particularly if they end up depending on any new config options.

-- David

--000000000000ab398b060fbf9c53
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPqgYJKoZIhvcNAQcCoIIPmzCCD5cCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg0EMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
7xDrOPfX3COqq162RFg/MFcGA1UdIARQME4wCQYHZ4EMAQUBATBBBgkrBgEEAaAyASgwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgw
FoAUfMwKaNei6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEB
AK0lDd6/eSh3qHmXaw1YUfIFy07B25BEcTvWgOdla99gF1O7sOsdYaTz/DFkZI5ghjgaPJCovgla
mRMfNcxZCfoBtsB7mAS6iOYjuwFOZxi9cv6jhfiON6b89QWdMaPeDddg/F2Q0bxZ9Z2ZEBxyT34G
wlDp+1p6RAqlDpHifQJW16h5jWIIwYisvm5QyfxQEVc+XH1lt+taSzCfiBT0ZLgjB9Sg+zAo8ys6
5PHxFaT2a5Td/fj5yJ5hRSrqy/nj/hjT14w3/ZdX5uWg+cus6VjiiR/5qGSZRjHt8JoApD6t6/tg
ITv8ZEy6ByumbU23nkHTMOzzQSxczHkT+0q10/MxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIz
IFNNSU1FIENBIDIwMjACEAHS+TgZvH/tCq5FcDC0n9IwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZI
hvcNAQkEMSIEIP/8jJDtUIeYWYLmJTRHVOrqpUHM63BGYIlM0oCh6twXMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDEyNTA2NTE0MVowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCDRk+I
w8uL0x3Tnb2xzSs7am/M/yETWtkdKUC84bg6O9bwoG5+YR+pcTWxKzSZZULeC5vCrtaX0HMyAy2F
hZ0QTnUapXs4Q/EgSsSuPFOYcRqAaaEjqGCvIwkMMT8cIlUTp8TA7oKvsaurcOI4LCNqif1VEN8E
rzkQ8u2UyBHUBmtCJGKjTj9d9mPpu2nskJEejjugn/BqZ0+LeDfQZ/IdEJHqQVb04eFEpWldMftC
AUeyCqmyCr21Das9uoH/1L7b90GknH6JpUorgRUhaN2kM+8nETAfjHVDSHFg+2LfxwUiyBBmZ8PQ
gO6LTmCsUntNv5BM2tK6p+wEbUoK6rWb
--000000000000ab398b060fbf9c53--

