Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01A0528370
	for <lists+linux-wireless@lfdr.de>; Mon, 16 May 2022 13:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbiEPLol (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 May 2022 07:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235303AbiEPLoh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 May 2022 07:44:37 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89028E0B7
        for <linux-wireless@vger.kernel.org>; Mon, 16 May 2022 04:44:36 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id a11so13806134pff.1
        for <linux-wireless@vger.kernel.org>; Mon, 16 May 2022 04:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=w97FCN2M4uEzx9WBQGj+Mylv6fqD2SJAkNQi+Noub7o=;
        b=fuOkW3iIuEvNeM8d+TFf25RZ+jh8lk2KvYhn/Kz9W7kHCtMQOojKxCrzfC8s07TMi1
         LUSRMUfejCmta1HTUhMXTRBtyTHSBWJAuJ/DvlRJMCXB/ZTBGUvCwYOlDdHf/ZitlsIW
         Cq/wn4zDII8sU4i2pYptLX+Nbb1kxKURUxVdZcgn5dxI7rtBnIKTVPV0p0DAnJQY9Lx7
         ilKzf04PUrEwcchd8lBoXdojIR9q5rKAo197hsx2niXL13etiq3GZhpEipN4XJ5Gw5S/
         vdeXA4Nq9xPBTdOsQ4DZWgT5pomVjM4wjqO07RlQRgx8ZBqr2kuR+7HOhchv9qkU+KR3
         XZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=w97FCN2M4uEzx9WBQGj+Mylv6fqD2SJAkNQi+Noub7o=;
        b=dHM6FgbbbtBQcfjI7DsVGZtss1k1IinfoNHXazLx80cL2UbUK+vOueWX1iv+2OTWsw
         BIdJHxI/LiX56QbMkpaxNGTPM3PlldG3zKEy/63Ud2eP92SwPBx+Svy2TGRW1jUMMUjH
         vCFvP9c4QmcYeTzX1YePNpI0yQ543bwhgnAiZPIi6QxPw/2yDJEkQERwcuHaKyp8c1VN
         HIMco1sBgIUQ8FRLlq2hr2gYH3YBxxo2S6MfNGrVaEoNU0WoqGqqMAmvPpCNZeQJ8fbd
         CfAEf+CSMKCT5++BAEWVINwEj65RcS/J9mE76Nx0Bbo7eiBly2kraDR9YijYka678tQE
         m4UA==
X-Gm-Message-State: AOAM530GBRqGU56qeoyEtM9rfUw2vFuEWpQze8oQSlYJOoA3C1+YQDR/
        KZpmUwqzoh2A//W1RT/ypbytItTjwIKZAht8pSc=
X-Google-Smtp-Source: ABdhPJygcjJ5SlRqBr/nTOMxdYarPxB1sMaHyLexi/gVh9xoJozLNJ3iUzaIrQD3hP3Bx3xVKI9J5ovppUNAxGquXKo=
X-Received: by 2002:a65:6e0d:0:b0:3c6:12af:15b4 with SMTP id
 bd13-20020a656e0d000000b003c612af15b4mr14814255pgb.338.1652701475971; Mon, 16
 May 2022 04:44:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac4:a0d1:0:b0:4b8:cb66:93b4 with HTTP; Mon, 16 May 2022
 04:44:35 -0700 (PDT)
Reply-To: attorneyjoel4ever2021@gmail.com
From:   Felix Joel <daterdet200@gmail.com>
Date:   Mon, 16 May 2022 11:44:35 +0000
Message-ID: <CAEg8PkakqOdF5aDWtc-RXYUfQAKURQ=3xZbEpjOKJBzvo0mE7A@mail.gmail.com>
Subject: =?UTF-8?B?dmVudGVyIHDDpSDDpSBow7hyZSBmcmEgZGVn?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:42e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4974]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [daterdet200[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [attorneyjoel4ever2021[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [daterdet200[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.4 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--=20

Hallo,
Vennligst godta mine unnskyldninger. Jeg =C3=B8nsker ikke =C3=A5 invadere
privatlivet ditt, jeg er Felix Joel, en advokat av yrke. Jeg har
skrevet en tidligere e-post til deg, men uten svar, og i min f=C3=B8rste
e-post nevnte jeg til deg om min avd=C3=B8de klient , som b=C3=A6rer samme
etternavn som deg. Siden hans d=C3=B8d har jeg mottatt flere brev fra
banken hans hvor han har gjort innskudd f=C3=B8r sin d=C3=B8d, har banken b=
edt
meg om =C3=A5 gi hans n=C3=A6rmeste eller noen av hans slektninger som kan =
gj=C3=B8re
krav p=C3=A5 hans midler eller det vil bli konfiskert, og siden jeg ikke
kunne finne noen av hans slektninger, bestemte jeg meg for =C3=A5 kontakte
deg for dette kravet, og du har derfor samme etternavn som ham.
Kontakt meg snarest for mer informasjon.
Vennlig hilsen,
Barrister Felix Joel
