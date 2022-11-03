Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C5A61872C
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Nov 2022 19:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiKCSOP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Nov 2022 14:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiKCSOO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Nov 2022 14:14:14 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B19617E
        for <linux-wireless@vger.kernel.org>; Thu,  3 Nov 2022 11:14:13 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id 13so7562746ejn.3
        for <linux-wireless@vger.kernel.org>; Thu, 03 Nov 2022 11:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mKRyVq3jWaP14YWZcClYu6XYBWVcn2RISKb36PLazJM=;
        b=G6NWYo1fteBiqY205dFbJ0Osu4vi9zwNPjaySeQbTI7gaTxWgJrM/F+l4w091mB4cX
         iXFP6yVOdx9KtAwC5V8i5/l6CpP7MhIA/AIJ1mWACoO3LhsCmxatKp97Z+ELAlU3Tu1T
         iatv8Np4uKD1Yf2FafwKmWF3WcT5RQaS+JF9T4PYJYq7SxO2Rgto2T18AG2IyLOHSSLH
         t1iruLHozanhDu3zN2m7EN3rrwHg/PRPDhKe1FkO/B58OjKxslbHWVaqPolwSLd12RSQ
         X4CDM722RG7PtVVyteSKKBfBKDMg286t++5ZmtYYYrEAznfJXx4xXTk+5aQ1zPVzYZlT
         eRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mKRyVq3jWaP14YWZcClYu6XYBWVcn2RISKb36PLazJM=;
        b=aS2W+OgXPYj82MOOF1LhXGRy12WzBKzz/4vYpCq+kjLS4wwLzmAyS7b9tiFrUX4I+0
         4DztIcr19LN21f3dBwl/6cdM0LsINJ6r72kDjtuDRasw8Q7zolQGrtwsJIjtiaVoCOSA
         f+amhRMJNSRdEC6jpB1iYIJ6Ojzwkj9u/h9C/50HuuREf0aehW1UqGUc/gZ7JWu7yvgf
         X4z4Kf3sky2WzHRRwlzTDHNqjmcnqJL0yAY5IJoJ7uYynkL8+gdyeqTDZJcRJ/B9xsqL
         3ABmqCqKQzKOBpdINmBjYLcAF6WnzFHdUbqH/DaCkbuIZt+azBplU8mnukK94Dw3rDE6
         CEDg==
X-Gm-Message-State: ACrzQf3o9GToJYChPf/RB192twDoGQIlhgOTgkunna4s5LBFi8emCwsL
        7bjXMm9i6LD+8F9NrzNJDa5y+1IZqzj397e/Si8=
X-Google-Smtp-Source: AMsMyM7TSh2A587HHuKSQhGpZsHKDAy5i2A/1YbpLF2VWSmHKQthJbW/a/m5TlDSlaBP3jfGgilcvfTr8Syd0jKTxd4=
X-Received: by 2002:a17:906:7304:b0:6ff:a76:5b09 with SMTP id
 di4-20020a170906730400b006ff0a765b09mr29899342ejc.193.1667499251469; Thu, 03
 Nov 2022 11:14:11 -0700 (PDT)
MIME-Version: 1.0
Sender: ndersontheresa.24@gmail.com
Received: by 2002:a05:7208:56a9:b0:5c:ee1f:14be with HTTP; Thu, 3 Nov 2022
 11:14:10 -0700 (PDT)
From:   "Doris.David" <mrs.doris.david02@gmail.com>
Date:   Thu, 3 Nov 2022 11:14:10 -0700
X-Google-Sender-Auth: XhhfB7EXbySMFoTDL3zceYAqWvU
Message-ID: <CAEJT=xD+1NBiNtWUW+8QnMX+bu4kpZULgV_p+xjujxo+KE6rEA@mail.gmail.com>
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
        *      [2a00:1450:4864:20:0:0:0:631 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5001]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrs.doris.david02[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ndersontheresa.24[at]gmail.com]
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
