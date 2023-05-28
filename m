Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BD17138EF
	for <lists+linux-wireless@lfdr.de>; Sun, 28 May 2023 12:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjE1KAI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 28 May 2023 06:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjE1KAG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 28 May 2023 06:00:06 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA45D8
        for <linux-wireless@vger.kernel.org>; Sun, 28 May 2023 03:00:05 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a640c23a62f3a-969f90d71d4so329688666b.3
        for <linux-wireless@vger.kernel.org>; Sun, 28 May 2023 03:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685268004; x=1687860004;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDVdWICwavrWQ8UAVYhe8ynFXsBBW1vVQ7W08zgiq24=;
        b=Fp6papBPorRne6YLmVM5uixrxKGdcFQkNzEvmYGk5TBkI0vBbgk7uTZCdxG+qClOwJ
         Kvxf84+xvF8VcPuxnBt9/Rja7PRMVwaCuA5ca8aK5+hYx6AEoQKJ+7bvRuEKbwhsZZuw
         g7mp/JWcHU8f4bKhUyl8S1ZbWGYHcHtWNUUPh0CLvMTM2+lVAd1b8NeEj9dNupSYVHdB
         miZtUHW/pxyTw78Hu1wiXKZseCjY1jKMWtE8Mrxb4AOSGSj3TY+4FXMptLaDRdtOIlTK
         RB8HHRAkCbfytv6yyPtajbBDSRXU1gRAAdo1ToMw3+6lSRyvKcySjo2joHK9TM/kic8y
         8mTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685268004; x=1687860004;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oDVdWICwavrWQ8UAVYhe8ynFXsBBW1vVQ7W08zgiq24=;
        b=WoaIb8bqVwo37gVsF7sWQZBkiq1nV9WIwi5Xss3MZbyzHVobaMeX68eKlfdb/43py5
         hclXKK1HE+YlzOiUs0LrfaavNPzA5dhJ+wn2Ic3SiFWLUKhvCOkwZkCQ/AsMN4j3PQTL
         dQA/vQSw+GTKqMxgpvMfdZG5q968fGiMlzzMvfsh9U1wP1AFU3ewr0eTl5jAcY3s1TTr
         Ek563ROqFXQGjrT8yDDhTrKTq+eH8MExRa8EinqNNjE/XPgzIXo5YROO7mgGD53tlYCj
         b98rysh+7Eg2WLJo4fdYn0ae3PYlEnq3C3pINdFQwDpIscMCnNKpFAKkpQUombGQokpg
         /kuQ==
X-Gm-Message-State: AC+VfDxARquX9KTiHRCPKs6xjidsZUh6oFbPkFf88pgU3E74kWx7LM66
        xA4UV0a2F45g7hF9LbWHAjyEu8DBvTI3PKStbTM=
X-Google-Smtp-Source: ACHHUZ7DUP9/P0qaJ972m0bc4tExXgVs/FXyyGMm+kpT1QdFkVRseDvWlTnVPNFVSrWhIabkc7wq3Ys96sRzdN3mErg=
X-Received: by 2002:a17:907:7f88:b0:966:5a6c:7549 with SMTP id
 qk8-20020a1709077f8800b009665a6c7549mr8461036ejc.14.1685268003413; Sun, 28
 May 2023 03:00:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:3282:0:b0:219:d045:cc6b with HTTP; Sun, 28 May 2023
 03:00:02 -0700 (PDT)
Reply-To: ninacoulibaly03@hotmail.com
From:   nina coulibaly <ninacoulibaly330@gmail.com>
Date:   Sun, 28 May 2023 03:00:02 -0700
Message-ID: <CAJiCSoC6_HRd+j6wxY7ztnuSci3fPm37xDzmA=Ky6eWWEoo3sA@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:644 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ninacoulibaly330[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ninacoulibaly330[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [ninacoulibaly03[at]hotmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dear,

I am interested to invest with you in your country with total trust
and i hope you will give me total support, sincerity and commitment.
Please get back to me as soon as possible so that i can give you my
proposed details of funding and others.

Best Regards.

Mrs Nina Coulibaly
