Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6CE7E5081
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Nov 2023 07:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjKHGwT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Nov 2023 01:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKHGwS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Nov 2023 01:52:18 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683798F
        for <linux-wireless@vger.kernel.org>; Tue,  7 Nov 2023 22:52:16 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a7fb84f6ceso72997927b3.1
        for <linux-wireless@vger.kernel.org>; Tue, 07 Nov 2023 22:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1699426335; x=1700031135; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9CX8X2jzrRGkYHSmp/MEq69D5ivUbDaN57eMIbkg2d0=;
        b=SXOL9Y+dj90irAsSa4qY+E7bPk5Cy0MMdrqHtN/aV7LEp0aS3luWBzxWfes5aaOQY6
         pN43k9/7dX6qSr8fjjmIobdinsKqnEt2XOZSS6XNmcj4LT2RPUJSYjibgbIcIRzCSRPn
         2GRevDTdh02R0TVs3o6aKjj2s44NjqiKpWbn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699426335; x=1700031135;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9CX8X2jzrRGkYHSmp/MEq69D5ivUbDaN57eMIbkg2d0=;
        b=qXH9mN0O8Nm4gSMdKC8V4ZDyCm4sEy7pgA9sye8iehQTQut2Vx8pG31/aGZyutrcFq
         si9SOYeJC4EM0XeskzJUkhmOrwRmCBDMEiu+3JnNqlWFQARHb+20hAOCAfO2W5MmJv8W
         KnI06PzrKQ92vLBndtHRFgrLvkhwb2Yjxm4gjxIB1KKJKNTz3II9whSf6kbR5lgVYQVJ
         kgq7sbLcrWaq2etN2MKYrTwBgQPrZmRFww5KL3huREaEM55wonhrf4/kbRulE+kCCljX
         7VLUPWa7TSJNJtynltZAfU72z+ottIvFKYfvEXnrP1lpSZ02cBJQudn1XX+C8RyuACcr
         r5hw==
X-Gm-Message-State: AOJu0YygW/vCyK3qBATsC0QSMYTxHylZuWmhxCZM9g4Wi9WGiH8RDfgz
        BEyCWHiJ262ePLqoaVmu532FTZ0m7DfxlUN3gZxD0A==
X-Google-Smtp-Source: AGHT+IHwmT1smD9HKz4z/XMR7bKpwI+C6qnX+Jpy/eK07FDOm2TP8wYv54XGvGUfgD3r9kcP+W5S8Hh6tW4jSIZcaNQ=
X-Received: by 2002:a25:ce88:0:b0:da0:88a1:1e8a with SMTP id
 x130-20020a25ce88000000b00da088a11e8amr932428ybe.44.1699426335444; Tue, 07
 Nov 2023 22:52:15 -0800 (PST)
MIME-Version: 1.0
References: <a4e53b3538b04ce9c3f53b216d106c6914f4ad0b.1699339021.git.vinayak.yadawad@broadcom.com>
 <877cmtbqfk.fsf@kernel.org>
In-Reply-To: <877cmtbqfk.fsf@kernel.org>
From:   Vinayak Yadawad <vinayak.yadawad@broadcom.com>
Date:   Wed, 8 Nov 2023 12:22:03 +0530
Message-ID: <CAMLe8U8RTMcKuDj5YH6yR1N05eCym3mT0=Tb-sTa7NBA9QMfjA@mail.gmail.com>
Subject: Re: [PATCH 1/1] wifi:nl80211: Extend del pmksa support for SAE and
 OWE security
To:     Kalle Valo <kvalo@kernel.org>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        jithu.jance@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000012506306099e877d"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--00000000000012506306099e877d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

Thanks for the review comment.
I have addressed the comment in version 2 of the patch "[PATCH v2 1/1]
wifi: nl80211: Extend del pmksa support for SAE and OWE security"

Regards,
Vinayak


On Tue, Nov 7, 2023 at 7:45=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrote:
>
> Vinayak Yadawad <vinayak.yadawad@broadcom.com> writes:
>
> > Current handling of del pmksa with SSID is limited to FILS
> > security. In the current change the del pmksa support is extended
> > to SAE/OWE security offloads as well. For OWE/SAE offloads, the
> > PMK is generated and cached at driver/FW, so user app needs the
> > capability to request cache deletion based on SSID for drivers
> > supporting SAE/OWE offload.
> >
> > Signed-off-by: Vinayak Yadawad <vinayak.yadawad@broadcom.com>
>
> There should be a space after "wifi:" in the title. Not sure if Johannes
> can fix that or if he prefers to submit a new version.
>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

--00000000000012506306099e877d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
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
XtHLz48aMtQwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIAcJpOoUku6g3emo/aef
ZIxvW7hOgfutxnkdP/jvN81zMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTIzMTEwODA2NTIxNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB1O4COuFxtRHUInMaqV1T72K3igSPWi8oyvIfE
Rr0ZlusY2D0b3kTsr4R6GYqhEkseX6CAe52v8NEqg/LCGDvtC4yiJ+bOVlHHbMB1Pszy2GgCg4tB
tA9C8mTUJL/EaW9d7LnCwD4G2DCgX904EsE2RNgfCBfGAsk4TzrkRa+Br89ooizYGJq1MyGL076H
S9yYl9c0q5w/tl8TtoHnKnuJGxacao8Q5FpikFFOjvs1V870fxXvvSGG6um2OXE8foscTEVxRIQs
LLaL+M99VgwoABOvyLMDUKJAmoI8y5H84WUUFfYBwk+REcdtYmd8hUtCNeWc3Wj1SUgeAkysbdEo
--00000000000012506306099e877d--
