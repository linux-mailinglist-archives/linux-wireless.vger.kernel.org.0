Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EDB61E251
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Nov 2022 14:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiKFNVd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Nov 2022 08:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiKFNVb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Nov 2022 08:21:31 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEF3D11F
        for <linux-wireless@vger.kernel.org>; Sun,  6 Nov 2022 05:21:31 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id d123so6972467iof.7
        for <linux-wireless@vger.kernel.org>; Sun, 06 Nov 2022 05:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eA5x8OA/NyZ4Bvir82PAP/TKpLMkeMVqjsccytz5ccg=;
        b=lnMP41Ixc1abgsErAw7xG79HGNcrqAnAXmnmREWzjQmfpQ99HZbwkuQJRL0OU0wwka
         4wR0QMeamB034o2VGwGxRfFRtWoQSpQ4QY1BhcWdByC8Wak4m7FaAclBPLBUSWw2fV6H
         8gsMhgZdXnjj14ED8Y4pdsJIEkjKtd0KC9dxWX2MMkoWquUAvHkiZbbq2KxwmQcrZ2TV
         c/QFPb5hLPwyYSWFroJhLOhcrKz92TkcUmi48UzY3xnMHspBhoY3GI0Ke/f9kgdHJmGP
         Or4pQnFXX2f1KC93W/ncL8ccddga4ekSC85SwUUskaNw3sUn8v5t0YyzZOPxOfpbKkSC
         QBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eA5x8OA/NyZ4Bvir82PAP/TKpLMkeMVqjsccytz5ccg=;
        b=q1mjODUyd/wqcXvneCF5c+rxD1+y7bxe9DTmaW8+rxlp08tqLwkWBcEfLheRM9B6cn
         QnFYhw1PYXI3Fa/o2s2NAxlrjo2k9gPbP4sfsRWSYrwgLvVXb8rLUdMlA0y01jhmmNFo
         9O9E4O+aH7l6RjxYRtvMy2oizODplW1WXG+Br7iXrXF65uvaFjfc+mwXOBJZqhRS68wt
         FvejSX+HCFNdFsZs3VE/ITSpE6gCTYxh1HNGW8FCngttjjWUw3ZF7JaCv/DicM5o6ko0
         UF24u5YsYlc0q8aBfGY+SmpDn+gTMZP2wyaSAHG20lewAoqdj71d1ZxoXwfTKz0Eorv9
         9/ow==
X-Gm-Message-State: ACrzQf0xSMGHX8pcRGGaVlzvh4+Cr7HiF+mSSLXmHG3Pv03kFXXaevZ8
        aqJTMzxz3H6pFfiMdHled+hauTeL/m6qCCpzrs0=
X-Google-Smtp-Source: AMsMyM4Chv+gF2sEDUVxC4fJQH/JcoeL/ewUW6wmzEJwSwAFg40IRRKYA0Y7zdfQI+bUuwVlQOuwXlDral/ieanvcY0=
X-Received: by 2002:a02:8804:0:b0:35b:7425:82af with SMTP id
 r4-20020a028804000000b0035b742582afmr26453150jai.21.1667740890792; Sun, 06
 Nov 2022 05:21:30 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a4f:b501:0:0:0:0:0 with HTTP; Sun, 6 Nov 2022 05:21:30 -0800 (PST)
From:   =?UTF-8?B?w7pyIMO6cg==?= <urri8344@gmail.com>
Date:   Sun, 6 Nov 2022 14:21:30 +0100
Message-ID: <CAKzm1Z4hvUCWQjyTcaH8SCZyazE0HU07=7Uo+n_jmetHWbNn8Q@mail.gmail.com>
Subject: GOOD MORNING
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        UNDISC_MONEY,URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d30 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [urri8344[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [urri8344[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.6 URG_BIZ Contains urgent matter
        *  3.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

-- 
I CONTACT YOU REGARDING A DONATION OF FUNDS, YOUR URGENT RESPONSE IS
VERY NEEDED TO DECLARE A NEXT STEP VIA  aud2015@pobox.com
THANKS
AUDU BELLO
