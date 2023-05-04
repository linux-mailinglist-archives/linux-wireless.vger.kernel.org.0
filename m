Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893396F76FE
	for <lists+linux-wireless@lfdr.de>; Thu,  4 May 2023 22:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjEDU3M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 16:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjEDU25 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 16:28:57 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08F113C18
        for <linux-wireless@vger.kernel.org>; Thu,  4 May 2023 13:15:45 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-50bcc565280so1433814a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 04 May 2023 13:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683231231; x=1685823231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pp4DKZ5YAHesHhUbviZuPUNlVLjAOKynr2fJjbSlD+Y=;
        b=S0ZppC27z5h47LvSYVUt5y4L+dSGVekzWAXdzmlRZ9a4c6kwHa4bDqzlT6qc8ilArO
         UjQCXnKIr7jNIY8A/dt7P1+VRvtoiIdgmMzQosugO8IJxvzaLVhunGp1RIAk4q8vf9Av
         cmT64G3IqFwt8YbGgPcCyXRBOIpc5nJeJWjD/uq9diHkUDkrVD1KU/zJRTk+F3HSVh2m
         QXGx3y+92NX0U+FdRMuhp3t9H74bBrM1MRoMkUj4E0NvLqs3H3cOT1p4JK/dGjtIfYAd
         jsHM4F45RedaH6uhPOJlJePVXEJrvekgHZwRNI7krp/4+vcp5XDo8TIXMFysMMZdfY6c
         6j+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683231231; x=1685823231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pp4DKZ5YAHesHhUbviZuPUNlVLjAOKynr2fJjbSlD+Y=;
        b=Tw0MVKx8XQp5PBzvbUHizS5dtHUlUqeTAYvAThHlLF9ZPoClrIwmx31rThKoYQAH5S
         oxTxyIgBhxZpnrbbmJwfbPz79Zc7yW5BhXjiJHMrOHA4/3gGL5QAAFHnCe3T+x9yRmEA
         0drIIYGTwpaWW8aR7Krm+cUIvWAKi7sSaeHY9Rzb1by5M8GR8Uh3uNxlCO5vPGcZMfGz
         CLmFkh0stG0mMIoeK6yMymku9pUtU65kuU8ZcEPzBUHeycn1p4JGgMmDbZdWTgPyDmnG
         h3kyboXak3631mXBDCTJJsJaraqyN1PMMAMlMsAGlZn01x16xKgz2fcTHhKqkUn2e7fu
         agJQ==
X-Gm-Message-State: AC+VfDyUtnQxySGnomNZ4+wlBOtxQvNPFLfv7WIpgZlRzvL+EPPefQVo
        j8pkmyg9keTvsZfV9MpLsmU=
X-Google-Smtp-Source: ACHHUZ4g7oXpcQsaKBaibLepspzWl07Ez4gjkoqyg3I1Y+u6Sg/W8y4K3c5i3jNaS7SI3CvgRiFO2A==
X-Received: by 2002:a17:907:d09:b0:95e:de82:3895 with SMTP id gn9-20020a1709070d0900b0095ede823895mr96055ejc.22.1683231231127;
        Thu, 04 May 2023 13:13:51 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id jx27-20020a170907761b00b0096347ef816dsm3873175ejc.64.2023.05.04.13.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 13:13:50 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: Driver for rtw8723ds
Date:   Thu, 04 May 2023 22:13:49 +0200
Message-ID: <2282070.ElGaqSPkdT@jernej-laptop>
In-Reply-To: <CAFBinCB3xnCrLvEvqsFMQuDxL+xC9tkxnwubfC+xEMP3-ZXqSg@mail.gmail.com>
References: <72a8eeb1-c91c-80a7-5a09-1b7963e0996b@lwfinger.net>
 <813d74b8-6d9f-c7b0-40b4-c661fca13002@lwfinger.net>
 <CAFBinCB3xnCrLvEvqsFMQuDxL+xC9tkxnwubfC+xEMP3-ZXqSg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dne =C4=8Detrtek, 04. maj 2023 ob 21:45:31 CEST je Martin Blumenstingl napi=
sal(a):
> Hi Larry,
>=20
> On Thu, May 4, 2023 at 9:25=E2=80=AFPM Larry Finger <Larry.Finger@lwfinge=
r.net>
> wrote: [...]
>=20
> > > Can you ask that user to test following commits?
> > > https://github.com/xdarklight/linux/commit/
> > > 3866a7a3702f7f24557f2c065b7d4088f7027466
> > > https://github.com/xdarklight/linux/commit/
> > > 66fd078556a6bf246337270b2e91d73c079fce2d
> > >=20
> > > Patches are trivial, but some testing needs to be done to confirm the
> > > driver actually works as intended.
> >=20
> > Jernej,
> >=20
> > The user needs the rtw8723ds driver - the SDIO equivalent of rtw8723du.c
> > that is used by the USB device. The riscv changes may be needed, but we
> > are not quite that far yet.
>=20
> Strange, can you please elaborate what you are seeing in terms of riscv?
> The two commits that Jernej shared are for an update to rtw8723d.c [0]
> and the addition of a rtw8723ds driver [1]. None of these mentions
> riscv (at least that's what my tired eyes are seeing today).
>=20
>=20
> Best regards,
> Martin
>=20
>=20
> [0]
> https://github.com/xdarklight/linux/commit/3866a7a3702f7f24557f2c065b7d40=
88
> f7027466 [1]
> https://github.com/xdarklight/linux/commit/66fd078556a6bf246337270b2e91d7=
3c
> 079fce2d

Problem is that my e-mail client split commit links in two parts. If you=20
combine hashes with rest it opens correct commits. Currently, it opens head=
 of=20
your master branch, which is by chance risc-v merge commit.

Best regards,
Jernej


