Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9455A5F06
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Aug 2022 11:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiH3JQt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Aug 2022 05:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiH3JQs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Aug 2022 05:16:48 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CD7D2E90
        for <linux-wireless@vger.kernel.org>; Tue, 30 Aug 2022 02:16:47 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-11f11d932a8so6896475fac.3
        for <linux-wireless@vger.kernel.org>; Tue, 30 Aug 2022 02:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=KLX/byTs1+qb1TCkOjrdnyIvec2/YaTobs7YMitI8sk=;
        b=BYfuOaXwGWEFy+MNHsywm2MMokjKec2MmGdenCzRl9Yd6yrWMGeAdk/Wics78FnZpy
         jVCxNVpReKM7I/H3BaWSE5CPN4t4QAbj/bXI9Zb1JhX30xKretrlesySmFIcGfxteQYD
         cJXtBL0cF8MUU0Av4VNuxj9jp37oglqd0D8s8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=KLX/byTs1+qb1TCkOjrdnyIvec2/YaTobs7YMitI8sk=;
        b=BWYImMnoTmjp3udJxbwPLg4lQVc8nm74b/zp8NN37n8GHY2QgW4DXiWrRp6vb/+Rfj
         yZvmz9hdblwnpCbE7HKXBT9a9ymoW8pAWBAYGuEiEjsaO4ioG5sx+ZvWSEB4lnrMLm5v
         uruHEv/DGaehILs4zR345Z33pxycr4AOLcOKzExmFssRYplP3Vh06+aZNaMEtZ4QQL8J
         ZMDRRP3ji1XfxoVh57lGFDrPyxcEYZWcISVzPJ06iVqHAJNQCC8ddWBwkwKufTRkEMIv
         tdw52A+jiCwlI1epNZjrrM9fhwB8bLumTPxkGmY0HqiVn4jXlpa0LzCKjLRMzqE2eZqd
         XSyw==
X-Gm-Message-State: ACgBeo3xn9q5/10oOTi42p5t84HnThJgCENIrFdhoM+xEYhPAt+jTrGg
        Wn8svNtdTkmM0hhDjbP+ozubKMGHrSyTYgJ1jUOdFg==
X-Google-Smtp-Source: AA6agR48cQTkRMCHUjtKxIJ+g8racSXqNTj4RJMgFv/JEJGsW8F+jNQ69T3UDRqoGOuSyhfP4uqd78LreKhOi54JgRM=
X-Received: by 2002:a05:6870:338e:b0:f3:1a36:9485 with SMTP id
 w14-20020a056870338e00b000f31a369485mr9875636oae.277.1661851007227; Tue, 30
 Aug 2022 02:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <e8fb69386675e5d128db141dabb9e6dad75eb841.1661516424.git.vinayak.yadawad@broadcom.com>
 <c177e3cc-ae69-b8c8-bb72-be85b2262149@quicinc.com> <ce01865907335ee597d204eb3cc8caea6b6326c2.camel@sipsolutions.net>
In-Reply-To: <ce01865907335ee597d204eb3cc8caea6b6326c2.camel@sipsolutions.net>
From:   Vinayak Yadawad <vinayak.yadawad@broadcom.com>
Date:   Tue, 30 Aug 2022 14:46:36 +0530
Message-ID: <CAMLe8U9Stc7YewmobnC0m9-+dWn7YUFY5OrqmM-CkMcOtHADkw@mail.gmail.com>
Subject: Re: [PATCH 1/1] cfg80211: Update Transition Disable policy during
 port authorization
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        linux-wireless@vger.kernel.org,
        Jithu Jance <jithu.jance@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f9bd1305e771d686"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000f9bd1305e771d686
Content-Type: text/plain; charset="UTF-8"

Hi Jeff, Johannes,

From your points we understand, we need a length variable and the
td_bitmap value.

As per the spec
https://www.wi-fi.org/download.php?file=/sites/default/files/private/WPA3_Specification_v3.0.pdf(
Table 4. Transition Disable KDE format),
we do have variable length of the bitmap. So we could
1. Add 2 arguments
2. One would be for the length of td_bitmap.
3. The second argument would be an u8 bitmap array depending on length
of bitmap.
Accordingly checks can be added to indicate/ignore the indication of
bitmap to upper layer.
Also the driver can update these fields as length 0 and array NULL in
case no value to be updated by the driver.

On Mon, Aug 29, 2022 at 3:22 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Fri, 2022-08-26 at 08:48 -0700, Jeff Johnson wrote:
> >
> > > @@ -3268,6 +3270,7 @@ enum nl80211_attrs {
> > >
> > >     NL80211_ATTR_TX_HW_TIMESTAMP,
> > >     NL80211_ATTR_RX_HW_TIMESTAMP,
> > > +   NL80211_ATTR_TD_BITMAP,
> > >
> > >     /* add attributes here, update the policy in nl80211.c */
> >
> > Johannes, do you want the policy updated even thought this is
> > driver->userspace and hence the policy is never applied to it?
>
> Yeah in a sense, it doesn't really matter... I think not updating is
> fine, then it will likely even be rejected, at least in any new
> commands.
>
> > >             struct {
> > >                     u8 bssid[ETH_ALEN];
> > > +                   s16 td_bitmap;
> >
> > I know you are using -1 as an indication that the bitmap is not used,
> > but using signed with a bitmap seems strange since bitops can be
> > affected by sign extension. Just something that set off my Spider-Sense.
>
> Yeah true ... maybe a separate validity bool would've been better?
> dunno.
>
> johannes
>

--000000000000f9bd1305e771d686
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
NYTp1srcTEZOxWsxza+lig+uL28TLZLykhkiMEYxptiQ8hcAMNGh/nsULs+5FQ+Otron6+vmdguo
y+ZZQrVvKv9cKahWzqi1nsWhCRT+DkjpyBdQNNUtfL1bIfD9S4MCAwEAAaOCAd0wggHZMA4GA1Ud
DwEB/wQEAwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUu
Z2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggr
BgEFBQcwAYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAwTQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3
Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4
aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmww
JwYDVR0RBCAwHoEcdmluYXlhay55YWRhd2FkQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEF
BQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUdfdZDjQllkJZ
11q+72FdCdXw5QAwDQYJKoZIhvcNAQELBQADggEBAAWPTOWAHASL5k6QbnUh956OTvL/EJy1afBX
7cFzOVe/k0+gDNOEfNh7UVEBiK7l4IlIKQw9+rSNtJNCsST4iMSDmXHp6Tbfh4IsgLYRaxLNhLtM
kfWf6Bx/Mx2nP5hCEp4xJp+FhiUokqZLI2xB40I9RxtxF6kv64xQIV9QVuiSZe52q5QNEb5HV55Y
Bmc2McPH8Wf/GmIIVG2+JAgS69jN2B4xUSIYV9yYAt2leZITSTj5uWdCTJi9GxXgkpWwJASE1OsM
N2/IoUmHQLEEXlMbWj67Vp0K7P8CZnTeTh6rfLnTgJ+EoOJf+lyKb/TwfnJ3xPD7KF+TRoJTfPwS
BcMxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
MTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxanRIQ
bv4guv944aIwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEINxInJwbpZNGZdzz90Pe
8qoT2V2BK2H3FqcMGyEX7KuqMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTIyMDgzMDA5MTY0N1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBInthJcrNpRHPsryfDhNffWinZ7O3ZoOlZWvBJ
UJRzO1SMWh+NNnO5e0avz4dq80/dspEfRO6N9O3fFGpcIS6QJATpsgqpGIITuI4LM3G6OR/pfI9m
P6dyBSbeJigxrw5HvWK1WORGrB/xShGtKr9oTyhHOKqWvlz9rc4NmjUC32/9kXvbpo6DGRwti7cj
kVUk1sziMCbf+9eXIUD3tcNmAM+HozPNiRWiDfE8fEsMIad/tADXt9hX0QkMXAM1S9fNtMpb8iIu
zfc4SOMKLYodwaZtYlGIp/b2Anqnppn0V+LsR5U1k87Ltub8Mg4f/qNZzlcKFShyrlYcnAjzt3zM
--000000000000f9bd1305e771d686--
