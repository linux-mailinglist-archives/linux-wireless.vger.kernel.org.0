Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BD34B0A54
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 11:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239455AbiBJKMF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 05:12:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237343AbiBJKMF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 05:12:05 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383EEFD5
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 02:12:06 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id i14so8545272wrc.10
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 02:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:cc;
        bh=OwBatjmwFCUa5noa+GRU5Nqf9iv/ckA7ZR+G7okpn7Y=;
        b=RWRAaG5Mo25qLuQYy0I80CNDZAHXjq1k27B4YiovORp/6aSGagvlsMLz/f1opZPazH
         UhEhimZAJor06nQSv6BiITjTLEHPi2EqaFCspy4aCm9qb9t5Mvco3DZIhmrsWt0agzBZ
         V+EpO+5AwcEugT5n0JSYnBNJQi37UHv8idlH1KDKvtrxvqTY4nE02Cp+Yilko0wkUQmt
         WGMbTJEdPB8iJadomQS6nvjSzTMPVwtkniCpw6H7r+uF05/9FEKDWHQlWYdwrFN4ItRd
         76SY2qaQR7aiuAqtp8cKKS3tbkn4H0sMpzTU7BlMzMm7sAUSWei46ECWmj24xNT8G+/X
         hmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:cc;
        bh=OwBatjmwFCUa5noa+GRU5Nqf9iv/ckA7ZR+G7okpn7Y=;
        b=NENvNbsd5dEbKzub8jecKjXgryn2vugazb0VMN4AdKUa+igucGaq1qk/VcsPUI9WhJ
         VMeFtS64Immr+R33U4k1iYbkKX0Qw4Jvqgzq93g2XaGLlHIBBsdSBUVE/syVyjgleluI
         AFmB8QeOfzySrJ1qIM7Go4+e3q4KSt2VdCJ/gQNtC/nbKLV5vtAjKxfFQMP4FYrXWr6h
         qJqWcOqD/aualhcoyPInK5mWZbfWGZzsAhEUlW0bJS8zgQoi2pynI1UPg51L2BideM2A
         +efgbNhmIcxRScM8yqTFdNK9xC2eyj2p0f1SLa933ZQwCPxrWjAtHa5n7OhYNPyQwAZj
         1ZiA==
X-Gm-Message-State: AOAM533s1BLUsSznz5cHFZ2rdzn/93RfoanUAb9us1Cb5p0VghupzpGl
        NI71mKxs9fMsw96GKLvU43y1IjlVZhg+Tj5ynsc=
X-Received: by 2002:a05:6000:150:: with SMTP id r16mt3642093wrx.59.1644487924796;
 Thu, 10 Feb 2022 02:12:04 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a5d:480e:0:0:0:0:0 with HTTP; Thu, 10 Feb 2022 02:12:04
 -0800 (PST)
Reply-To: lisamuna2001@gmail.com
In-Reply-To: <CAO8vqiuGP_+J_hb1EwB9LeNwu5Hc0JQc14up21WKggEaBu83Qg@mail.gmail.com>
References: <CAO8vqiuVNJFe5v-CnZVoc=Sw1b4RHuD8_nFFitde3cuJu9Fy+w@mail.gmail.com>
 <CAO8vqiuGP_+J_hb1EwB9LeNwu5Hc0JQc14up21WKggEaBu83Qg@mail.gmail.com>
From:   lisa muna <lmuna521@gmail.com>
Date:   Thu, 10 Feb 2022 11:12:04 +0100
Message-ID: <CAO8vqisLMANtJ6bHGTted398b+_+aknk2Qk_rMEVrmY1PMJBmQ@mail.gmail.com>
Subject: hello
Cc:     lisamuna2001@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MISSING_HEADERS,
        MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:42a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [lmuna521[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  1.0 MISSING_HEADERS Missing To: header
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [lmuna521[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lisamuna2001[at]gmail.com]
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dear Friend,

I'm happy to inform you that i finally succeeded in getting the funds
transferred under the cooperation of a new partner from India,
Presently I'm in India, for investment projects with my own share of
the money and also on charity work to the less privileges and the
orphanages. Meanwhile i didn't forget your past efforts to assist me.

After your inability to cooperate I found a new partner who helped in
getting those funds transferred for charity work , please use this
share of the money for your self and also invest some on charity work
in your country.

So i left a Visa Card of $850,000.00 US Dollars for you as
compensation for your past effort. Contact my office manager and give
her your complete address so she can send you the Visa Card through
Courier Delivery Logistics

Her Name is Miss . Lisa Muna

Email: lisamuna2001@gmail.com

NOTE; The Visa Card is an international Visa Card and you can cash it
in any ATM machine in your Country.

Regards
