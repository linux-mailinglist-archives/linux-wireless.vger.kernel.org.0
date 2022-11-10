Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CE1623BF6
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Nov 2022 07:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbiKJGij (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Nov 2022 01:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiKJGii (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Nov 2022 01:38:38 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406D2E099
        for <linux-wireless@vger.kernel.org>; Wed,  9 Nov 2022 22:38:37 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id g7so1391108lfv.5
        for <linux-wireless@vger.kernel.org>; Wed, 09 Nov 2022 22:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2A5Zw4wTof6wwwRVMT2EklD6tpS33zcb3kC2X1CkRqg=;
        b=B+mpBj/FSSkV1b2PIY07IlvbK3Wji4X7X8RTx2bt4XI19P2EYQtFofolQsUjDtnC13
         n6kTf2T0snKhPmPib7+LJyVS73mx4QHYdMnZoAfPF48F2yhgid66n/PP5A2kjAfpmn0l
         EsbxumV5Go7TPTba5vwEqyQDB9D00jGpQOpKjLpV7XW+BR1Fu0AgcqFH53GPKDb/nq3S
         dvnTAqNssDi2B5ppi95YT6WSWw2Suugly59Fhws0GvTJAMP3773LuyjPdM9kuwMr9CIi
         0HfzEn+dKlDtn9tYKShkoLoITxu1YqetuPLd6CE0g0ADUzM75vd4sp3sngi0fJOZgVty
         We6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2A5Zw4wTof6wwwRVMT2EklD6tpS33zcb3kC2X1CkRqg=;
        b=sPPgCtJP4Oaz5jIyUKvJr7f9z3Wa7kcqKUL9/0bOScrlmcMdNueO0hQteTPmGs04cb
         mNxs9KoSG4+1jU5P+Sfqy+WPQ8eu9JpvHoq4Xfo/NPJ13jUbSnxw9FsqTFgTRfp/lzsE
         hU/h/KfxybHnFxaKmWMJKlyMGqvDrg9fx7CtSDvpx70cwmh9RMXHEstdGX75ORLy+hXb
         z1wERUz0eU+McR/cUtTgJCxh9J/8NYm7xE3KCJL6u5Q08zbSlOxqjrFcB179XQJNFWpy
         PWJ31uHSw7x044fVnBSXb8cMVH14RoKTemSawno5bFubcn7srbEG+b0y2JUbaf40zCVK
         q22w==
X-Gm-Message-State: ACrzQf3DknpzUSnpQN/7UfgkdLSMEKiZgCwGGCz8N1OMzNfATakz7PH/
        VynwJPWsj1RwvKQg/PTnc7mQhHzD0ebgzEQ72us=
X-Google-Smtp-Source: AMsMyM53SHFEdsl743ue0/4BNdgKy6s4ibQvpGldbekjuU31Ikemfdktop748mX058fh6L53MLH+rslFBfHf3+DIPJY=
X-Received: by 2002:a05:6512:22d3:b0:4a2:3b96:e980 with SMTP id
 g19-20020a05651222d300b004a23b96e980mr24427337lfu.352.1668062314978; Wed, 09
 Nov 2022 22:38:34 -0800 (PST)
MIME-Version: 1.0
Sender: nadeemammar1@gmail.com
Received: by 2002:ab2:515c:0:b0:166:d4e2:ca0d with HTTP; Wed, 9 Nov 2022
 22:38:34 -0800 (PST)
From:   "Mrs.Yu  Ging" <yuging9567@gmail.com>
Date:   Thu, 10 Nov 2022 06:38:34 +0000
X-Google-Sender-Auth: rYCFp3fqTRlkBfKvMb645q0BJJ4
Message-ID: <CAMDb218_4tFMozSp9qSzADHSXKqKM9idJLW1qNRJ=3xL63oD8A@mail.gmail.com>
Subject: Hello Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_USD,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:143 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6113]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [nadeemammar1[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [yuging9567[at]gmail.com]
        *  1.2 MILLION_USD BODY: Talks about millions of dollars
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I am Mrs Yu. Ging Yunnan, and i have Covid-19 and the doctor said I
will not survive it because all vaccines has been given to me but to
no avian, am a China

woman but I base here in France because am married here and I have no
child for my late husband and now am a widow.

My reason of communicating you is that i have $9.2million USD which
was deposited in BNP Paribas Bank here in France by my late husband
which am the next of

kin to and I want you to stand as the beneficiary for the claim now
that am about to end my race according to my doctor.

I will want you to use the fund to build an orphanage home in my name
there in your country, please kindly reply to this message urgently if
willing to handle this project.

Mrs Yu. Ging Yunnan.
