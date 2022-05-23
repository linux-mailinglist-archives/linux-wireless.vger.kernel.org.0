Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C20D5313F9
	for <lists+linux-wireless@lfdr.de>; Mon, 23 May 2022 18:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237404AbiEWOur (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 May 2022 10:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237385AbiEWOup (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 May 2022 10:50:45 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8A35A5AF
        for <linux-wireless@vger.kernel.org>; Mon, 23 May 2022 07:50:44 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id s14so13309936plk.8
        for <linux-wireless@vger.kernel.org>; Mon, 23 May 2022 07:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=GxyBsIEl95H/eEhTmGG6uJoxmDHlvYVn1lk90Snrq84=;
        b=OggFQKfXAVU1R59kNShDA7gjLJ/R6ZXqPCIi0KY810ToLiXR8H3bOVfKcJWuN0Me2S
         sxYAJ0bXUykzxjDhodZpRwKHEBtWVT+y1nq58ehsEP1zqX530gUgUPf72A0YAZHr+E0L
         W0TR9+OE6L6p0iF9q38rkDB8bH/HwuCxwlLZUWMfqhA2cgz+XBEY8oe/kRBKVECE3G5h
         iWAWJiH7LAJMiimadGVPrnpDTLy82skiHk9o7hu9wRVk/3+vZTHpaas5fwNAs31Fv2kA
         +qJyuVw9786L0PI4mgqOFnKzkE8Oi2vRaNaUdTHg3sX/Pg9z0JOQTcvOEAo9FP+J2clb
         x5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=GxyBsIEl95H/eEhTmGG6uJoxmDHlvYVn1lk90Snrq84=;
        b=sy4JS9lMwzjO5X9tTF5B272z77rVFNcIueBH9iTm2QFZh2Y6UaHaR/o+utuF9Ju1dF
         kcvPwUkL3Jp/4CZB8ubsaiSnbkkEz6BxAFnLLVWsNigYw9q5bY6+V2yLXtzpKAOQZCDi
         ITirzIzvoCZolQctC6pPTSfLLLXR8Eo87jnm+lLDIU9papcXm4ojhDIgpG74QW5BYoVd
         kCq/ExT0E7epJRH5ppXioW9eJoVLPU7RJ0YBe+AaRDUwgb3JlFd8gkE8QTR58hSd0YFL
         kLhdkvIcOf70iCFl/EC9lCvjHLk2o4w/5QdlcJbRHXR44Ui406H4wINDfFwD2Oevy55D
         8sjw==
X-Gm-Message-State: AOAM532thTf+YNYwwl1XfMEdbofzISLSi63JxqEmskWAg9LKpXAF2qBF
        ZuwHO5sCyVKOHyJadTFHGJ2h+Gzv1c7PSiM9O8I=
X-Google-Smtp-Source: ABdhPJxtVfK3dTvj8YuJgaI35tusm4q3KlcPyavNrgNPZwRWUqvZeLUBAHzANbNODTXT8mQA0Oo9wT7AwkG9RSwXqFw=
X-Received: by 2002:a17:90a:6e08:b0:1df:8df2:5f09 with SMTP id
 b8-20020a17090a6e0800b001df8df25f09mr27361643pjk.216.1653317444318; Mon, 23
 May 2022 07:50:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:3b6:0:0:0:0 with HTTP; Mon, 23 May 2022 07:50:43
 -0700 (PDT)
Reply-To: abrahammorrison443@gmail.com
From:   Abraham Morrison <scowil283@gmail.com>
Date:   Mon, 23 May 2022 07:50:43 -0700
Message-ID: <CABYci47uT8aKLajN2zs13AARFMuRfnbWEiG5s5ZpTTqXP2e8Xg@mail.gmail.com>
Subject: Good day!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:634 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [abrahammorrison443[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [scowil283[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [scowil283[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aufmerksamkeit bitte,

Ich bin Mr. Abraham Morrison, wie geht es Ihnen, ich hoffe, Sie sind
wohlauf und gesund? Hiermit m=C3=B6chte ich Sie dar=C3=BCber informieren, d=
ass
ich die Transaktion mit Hilfe eines neuen Partners aus Indien
erfolgreich abgeschlossen habe und nun der Fonds nach Indien auf das
Bankkonto des neuen Partners =C3=BCberwiesen wurde.

Inzwischen habe ich mich entschieden, Sie mit der Summe von 500.000,00
=E2=82=AC (nur f=C3=BCnfhunderttausend Euro) f=C3=BCr Ihre bisherigen Bem=
=C3=BChungen zu
entsch=C3=A4digen, obwohl Sie mich auf der ganzen Linie entt=C3=A4uscht hab=
en.
Aber trotzdem freue ich mich sehr =C3=BCber den reibungslosen und
erfolgreichen Abschluss der Transaktion und habe mich daher
entschieden, Sie mit der Summe von 500.000,00 =E2=82=AC zu entsch=C3=A4dige=
n, damit
Sie die Freude mit mir teilen.

Ich rate Ihnen, sich an meine Sekret=C3=A4rin zu wenden, um eine
Bankomatkarte =C3=BCber 500.000,00 =E2=82=AC zu erhalten, die ich f=C3=BCr =
Sie
aufbewahrt habe. Kontaktieren Sie sie jetzt ohne Verz=C3=B6gerung.

Name: Linda Kofi
E-Mail: koffilinda785@gmail.com


Bitte best=C3=A4tigen Sie ihr die folgenden Informationen:

Ihren vollst=C3=A4ndigen Namen:........
Deine Adresse:..........
Dein Land:..........
Ihr Alter: .........
Ihr Beruf:..........
Ihre Handynummer: ...........
Ihr Reisepass oder F=C3=BChrerschein:.........

Beachten Sie, dass, wenn Sie ihr die oben genannten Informationen
nicht vollst=C3=A4ndig gesendet haben, sie die Bankomatkarte nicht an Sie
herausgeben wird, da sie sicher sein muss, dass Sie es sind. Bitten
Sie sie, Ihnen den Gesamtbetrag von (=E2=82=AC 500.000,00) Bankomatkarte zu
schicken, die ich f=C3=BCr Sie aufbewahrt habe.

Mit freundlichen Gr=C3=BC=C3=9Fen,

Herr Abraham Morrison
