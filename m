Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72616C70D2
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Mar 2023 20:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjCWTMl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Mar 2023 15:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCWTMk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Mar 2023 15:12:40 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7683C9
        for <linux-wireless@vger.kernel.org>; Thu, 23 Mar 2023 12:12:39 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id e12-20020a4ada0c000000b0052cdbbdc803so3706996oou.2
        for <linux-wireless@vger.kernel.org>; Thu, 23 Mar 2023 12:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679598759;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n/aRv5DDyEdwK1T7Yg5lz74OdtmIecGRUxlzh8mnlOg=;
        b=RTVLbzoZWie5OZ4rTDFLDSfi87o6zsX+uEWGzJ7/C2GD4XGRH6LbO6rpwlemdkLJaq
         ZrqJHpAWxKARC+gYIU6EZA1bO3llChYeMkNBGGzOx8feLd9PO+doGmbEtK2a5R13AIFw
         3RDqnaUdeJpjdNCaCrBPOFBG/Ppv9Jtx+EdCcRs9RV+paF22P45kV2GgXKBFCc5Kncm3
         6qYi0uG/PaCGRjJ2kB2HnJjo9LI6OwFC/zuIK1yk1kjCdnpHIAjSDfHB4TUZv3ii25iI
         fU7uJlPaKlDJzpXPEzIQXwGjkIiQtmSDmO3nzZ9J5NPL6mMoOqoLEX8lAp25YoydNWd+
         RSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679598759;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/aRv5DDyEdwK1T7Yg5lz74OdtmIecGRUxlzh8mnlOg=;
        b=itmKlQtjusR+VU878X7Pi+Fx+9nGBfsnORo2iJcp+2qHU/rpaDTt3LlWN8J1MHbqR7
         BxJXEv8UXbTM78UO2slJxMfjqW8NvEmrma70jgFpkbji+IOoexp0xYeZKjM5Fb4fzfOM
         xL1z03KWhsPLqxgpaSrwVW2SnU0IbVh4THDaRTcIStTt8b3K7+ywXx/loNqak71H7FfY
         EK/lLEC8ylk1Bz2I/beZDn48OA84OL5BOFYtwgHZFgsfXyI5Xpbb6GVx996go0XtXbnr
         KFL89BuC3PwaixPRgzP++JxMlME0mYyFe4ICZVfgnUenY0cYUnKruzmg23kEOqPmDeMJ
         zrUw==
X-Gm-Message-State: AO0yUKWQpvNQUM5rcWwe6pvv0U+SsJKruPhTz2OWLtFSERtlDWItDggc
        e2hb9YZvYq64oqgt2DLzZrPWcDUh5F4zMMDHJmc=
X-Google-Smtp-Source: AK7set9K2lpr2oYjJo+dgR1De9ha+kNEkp5XegG7w79P2GYs2dk50yzld2jWcjQWwy4FJKfNZFMqYP6UrF4pmfBflOg=
X-Received: by 2002:a4a:e243:0:b0:525:5f43:215a with SMTP id
 c3-20020a4ae243000000b005255f43215amr2313523oot.1.1679598759050; Thu, 23 Mar
 2023 12:12:39 -0700 (PDT)
MIME-Version: 1.0
Sender: dhldeliveringcompany.bf@gmail.com
Received: by 2002:ac9:5e17:0:b0:4c8:8e08:fdd2 with HTTP; Thu, 23 Mar 2023
 12:12:38 -0700 (PDT)
From:   Dina Mckenna <dinamckenna9@gmail.com>
Date:   Thu, 23 Mar 2023 19:12:38 +0000
X-Google-Sender-Auth: VOOWU_v6mRUO6JOMXnnPyA7HCl8
Message-ID: <CAGPv-0Ek7MM=ewhpj8Pcwv5xQiXEDFALDCnvpWzmHZMRFyxv-g@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.8 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:c34 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [dhldeliveringcompany.bf[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello my dear,

 I sent this mail praying it will get to you in a good condition of
health, since I myself are in a very critical health condition in
which I sleep every night without knowing if I may be alive to see the
next day. I bring peace and love to you.. It is by the grace of God, I
had no choice than to do what is lawful and right in the sight of God
for eternal life and in the sight of man, for witness of God=E2=80=99s merc=
y
and glory upon my life. I am Mrs. Dina Howley Mckenna, a widow. I am
suffering from a long time brain tumor, It has defiled all forms of
medical treatment, and right now I have about a few months to leave,
according to medical experts. The situation has gotten complicated
recently with my inability to hear proper, am communicating with you
with the help of the chief nurse herein the hospital, from all
indication my conditions is really deteriorating and it is quite
obvious that, according to my doctors they have advised me that I may
not live too long, Because this illness has gotten to a very bad
stage. I plead that you will not expose or betray this trust and
confidence that I am about to repose on you for the mutual benefit of
the orphans and the less privilege. I have some funds I inherited from
my late husband, the sum of ( $11,000,000.00, Eleven Million Dollars
). Having known my condition, I decided to donate this fund to you
believing that you will utilize it the way i am going to instruct
herein. I need you to assist me and reclaim this money and use it for
Charity works therein your country  for orphanages and gives justice
and help to the poor, needy and widows says The Lord." Jeremiah
22:15-16.=E2=80=9C and also build schools for less privilege that will be
named after my late husband if possible and to promote the word of God
and the effort that the house of God is maintained. I do not want a
situation where this money will be used in an ungodly manner.. That's
why I'm taking this decision. I'm not afraid of death, so I know where
I'm going. I accept this decision because I do not have any child who
will inherit this money after I die. Please I want your sincerely and
urgent answer to know if you will be able to execute this project for
the glory of God, and I will give you more information on how the fund
will be transferred to your bank account. May the grace, peace, love
and the truth in the Word of God be with you and all those that you
love and care for.

I'm waiting for your immediate reply.
 .
May God Bless you,
Mrs. Dina Howley Mckenna.
