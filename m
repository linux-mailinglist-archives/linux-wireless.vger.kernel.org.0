Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BD8618744
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Nov 2022 19:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiKCSQW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Nov 2022 14:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiKCSQV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Nov 2022 14:16:21 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694BF6264
        for <linux-wireless@vger.kernel.org>; Thu,  3 Nov 2022 11:16:20 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r14so4323687edc.7
        for <linux-wireless@vger.kernel.org>; Thu, 03 Nov 2022 11:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mKRyVq3jWaP14YWZcClYu6XYBWVcn2RISKb36PLazJM=;
        b=HwkQMNyfLTSKnbmJ2WvZ2QkkoHKXggVQCBl1/o4E5NTBl5TNEK0pjuch5JyYSKViTG
         AjuWBM4oezasgJXTGDWljjSF3iLnokZNhE0ymfD7Gx27vZnOXQN3yl03/ziWMj9sufFL
         mYm78RZyf2Ma9OLIKZXQvTrgfaVXgPFwS+ITVZynWVC+0am5+zy7YRK0TmF5CbayT11N
         OcNf9tBFkYCePCwGxVXrtLMpHc2tsFKiinXEFKwlfbLwIViqWs6Kj+b1n3ZLnc7P0T4f
         hWLtOsN4awGAeEBHrjOt3tdWMmPJn0PFcSjwqL3ZXGDz7Npr0UJQLSgenI/Jy3staur6
         AeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mKRyVq3jWaP14YWZcClYu6XYBWVcn2RISKb36PLazJM=;
        b=eWMzBUNfSC1NHg5IRcJ+MGH6T2H9Gddy13u7qsQTcOoxOV6c0/xodCXoYm0BCYv5MW
         khAVXAYhdwL9AYuzOnrjtNI4zMQPq5HMPoUBpHKDe8h33RuzXnp21TZ7B+o+V4YGtOpe
         Zgh+PcJgNWMsM+8Tf5yYDBzzlEOPFLUEY3RaMlBrCTpygmJIq/LsGDEODr2k7t3VXNnz
         mt2c03yQzNh4Au70vS9IJ11oRUUXCbAyBYbvfZwBobdnThpfgtA1kZHKtUuPkoP7YU4H
         7Ricl3ekspFF84CeSW+LUeh2koTj44q2IA7iLZqPvP+vNOPaMW3jqppcmly2HA4xL7S6
         0keA==
X-Gm-Message-State: ACrzQf1EpJOedvIidBGyhZ7Pvoguca0/PKSYIMNTToJNLLLoclbyUtDe
        nxiLaIMwyu+Ppdh7hImvBIkcCz/TZeDG9oe8Gh0=
X-Google-Smtp-Source: AMsMyM7MVRraqIofa9sE+5TJfjI1IJ2dix6PPdGay11B+badviqgBLd26Bx4w6Cf+6qsqflByXZGsN8ojRf8EDRD8Yg=
X-Received: by 2002:a05:6402:5107:b0:462:3014:3d73 with SMTP id
 m7-20020a056402510700b0046230143d73mr31668546edd.177.1667499378523; Thu, 03
 Nov 2022 11:16:18 -0700 (PDT)
MIME-Version: 1.0
Sender: alimahazem0@gmail.com
Received: by 2002:a05:6f02:4b6:b0:27:365d:6f27 with HTTP; Thu, 3 Nov 2022
 11:16:17 -0700 (PDT)
From:   Doris David <mrs.doris.david02@gmail.com>
Date:   Thu, 3 Nov 2022 11:16:17 -0700
X-Google-Sender-Auth: OgDwtqNE8EsGIRsUfrPqw9Sdxvs
Message-ID: <CAMPJMTdFXtyLxyy9pxDXYdpkeoQe-Vu_Bzro0gb3iwshABQ3kw@mail.gmail.com>
Subject: Re: Greetings My Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.1 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:535 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5002]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [alimahazem0[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [alimahazem0[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Greetings,

I sent this mail praying it will find you in a good condition, since I
myself am in a very critical health condition in which I sleep every
night  without knowing if I may be alive to see the next day. I am
mrs.doris david,a widow suffering from a long time illness. I have
some funds I  inherited from my late husband, the sum of
($11,000,000,00) my Doctor told me recently that I have serious
sickness which is a cancer problem. What disturbs me most is my stroke
sickness. Having known my condition, I decided to donate this fund to
a good person that will utilize it the way I am going to instruct
herein. I need a very Honest God.

fearing a person who can claim this money and use it for Charity
works, for orphanages, widows and also build schools for less
privileges that will be named after my late husband if possible and to
promote the word of God and the effort that the house of God is
maintained.I do not want a situation where this money will be used in
an ungodly manner. That's why I'making this decision.I'm not afraid of
death so I know where I'm going. I accept this decision because I do
not have any child who will inherit this money after I die. Please I
want your sincere and urgent answer to know if you will be able to
execute this project, and I will give you more information on how
thunder will be transferred to your bank account.I am waiting for your
reply.

may God Bless you,
mrs.doris david,
