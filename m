Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CF75B7D05
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Sep 2022 00:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiIMWUs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Sep 2022 18:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiIMWUp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Sep 2022 18:20:45 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B622612E
        for <linux-wireless@vger.kernel.org>; Tue, 13 Sep 2022 15:20:45 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id l10so13230176plb.10
        for <linux-wireless@vger.kernel.org>; Tue, 13 Sep 2022 15:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date;
        bh=3rHWukX/982VVQshnDvvj6GQbQddSOFHJAD6q40l/44=;
        b=o+JJizUy8pfn1jqraehPkUEgD13ovk9c1W5gLZ55nf967c7E8016Mw3UActHWOAzNH
         fGaCzr3EqcU20N4XaBsrT7BgqLlkvRo3Upz6HGKSUHecP+AAiROD6Pl9TbktOtxFi+E2
         5RDcnrxaxizAYdwMH5ijjo4mMXIRFod+TZtMZ+J7E6xfoZxttxxJ3WTq9Nvv40NhE76Y
         iZReX3F0dnTqm2MSXDKNNBfh9J6eI0+fwrkBHJ4mi+7nykvrpoVk7gWd7dDtDAZbHV96
         OklDJocei34d/t9BWYns1Qr9hT9dg72es4ha8ro9jZtRyqaRtC+7TflbNwAlOgq4PIYX
         vo8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=3rHWukX/982VVQshnDvvj6GQbQddSOFHJAD6q40l/44=;
        b=JbRp8UcBaiEMnqj0hDV1vBEHUzxmiDQdARSYBGy2QIg9fvkDILczuQrEG6O9o5KqsD
         Cm1jPnSxmT3kHgdlHE+s4uKnh8CZ6Ru+PJ5lrFXn0W5mr16f1FLcRQTnuXhLj3/1UGNG
         IsVqGpYeKJ1dYunPGRDCMN9AN3+pA7i/nX5fv4se66TxsfRRj3AOY/oVT8c8VIJOSBIf
         fJ5AXGn1/iB8J1ZjPS4nTeoF86Daa8Tco1aqxTZB1GozSM0FI7bIXeqyxPw6hciDGD+1
         3dW73EeN/YqItJQfbXYNwlgGlZFFfRWte1hhtLt5a//hSv01d7X7XMcF12L21fRQLGoC
         TP+w==
X-Gm-Message-State: ACgBeo37ik8rH2ng/dk+mLW+btoHDhPfoNVaWBzCRU4xHcsmvPUpZxwE
        fjHTN0nPfdhzalAhe8AqBYypx/JXFMXfPp886h4=
X-Google-Smtp-Source: AMsMyM4W4ukWicFVnIvZg9iqnP9Yvgja388kOdDBgq7jN6b+6I0S4kYOLaz9P9B9vB/zQsdkypZURDQO7FVvX5eANrw=
X-Received: by 2002:a17:90b:3c6:b0:202:c01b:feb4 with SMTP id
 go6-20020a17090b03c600b00202c01bfeb4mr1489626pjb.28.1663107644762; Tue, 13
 Sep 2022 15:20:44 -0700 (PDT)
MIME-Version: 1.0
Sender: fariqtumuh010@gmail.com
Received: by 2002:a05:7300:6413:b0:78:c86a:1bfd with HTTP; Tue, 13 Sep 2022
 15:20:44 -0700 (PDT)
From:   Juliette Morgan <juliettemorgan21@gmail.com>
Date:   Wed, 14 Sep 2022 00:20:44 +0200
X-Google-Sender-Auth: 2EDAOC6nanYwB6L0JsjDduTTJl0
Message-ID: <CAEotuPTEWjubxurVrAZLuJrBcvTd7J4jaN02zE3iiJiTfun0Kw@mail.gmail.com>
Subject: READ AND REPLY URGENT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.3 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_99,BAYES_999,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:644 listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [fariqtumuh010[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [fariqtumuh010[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  0.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Dear God,s Select Good Day,

I apologized, If this mail find's you disturbing, It might not be the
best way to approach you as we have not met before, but due to the
urgency of my present situation i decided  to communicate this way, so
please pardon my manna, I am writing this mail to you with heavy tears
In my eyes and great sorrow in my heart, My Name is Mrs.Juliette
Morgan, and I am contacting you from my country Norway, I want to tell
you this because I don't have any other option than to tell you as I
was touched to open up to you,

I married to Mr.sami Morgan. Who worked with Norway embassy in Burkina
Faso for nine years before he died in the year 2020.We were married
for eleven years without a child He died after a brief illness that
lasted for only five days. Since his death I decided not to remarry,
When my late husband was alive he deposited the sum of =E2=82=AC 8.5 Millio=
n
Euro (Eight million, Five hundred thousand Euros) in a bank in
Ouagadougou the capital city of Burkina Faso in west Africa Presently
this money is still in bank. He made this money available for
exportation of Gold from Burkina Faso mining.

Recently, My Doctor told me that I would not last for the period of
seven months due to cancer problem. The one that disturbs me most is
my stroke sickness.Having known my condition I decided to hand you
over this money to take care of the less-privileged people, you will
utilize this money the way I am going to instruct herein.

I want you to take 30 Percent of the total money for your personal use
While 70% of the money will go to charity, people in the street and
helping the orphanage. I grew up as an Orphan and I don't have any
body as my family member, just to endeavour that the house of God is
maintained. Am doing this so that God will forgive my sins and accept
my soul because these sicknesses have suffered me so much.

As soon as I receive your reply I shall give you the contact of the
bank in Burkina Faso and I will also instruct the Bank Manager to
issue you an authority letter that will prove you the present
beneficiary of the money in the bank that is if you assure me that you
will act accordingly as I Stated herein.

Always reply to my alternative for security purposes

Hoping to receive your reply:
From Mrs.Juliette Morgan,
