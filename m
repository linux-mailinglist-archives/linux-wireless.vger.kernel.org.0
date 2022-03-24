Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52434E6002
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Mar 2022 09:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347984AbiCXIMf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Mar 2022 04:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239836AbiCXIMd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Mar 2022 04:12:33 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD0655BDB
        for <linux-wireless@vger.kernel.org>; Thu, 24 Mar 2022 01:11:02 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id a11so3211314qtb.12
        for <linux-wireless@vger.kernel.org>; Thu, 24 Mar 2022 01:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=13+rXwGRPr4a9k2vxA2bU+fJEZZ58Un4R7s1pCG1lS8=;
        b=ibzioJyO4Y8DtLxhczwe0HzQQHNbWpKzwjuxGYhCZlmipm9S+S9aGj0T+WOtMlM6kT
         BFxKcElp9fP9Wv7OS8pzUpFhyqFHvvrRJgtJIjS3bKHTZa2CYfVh4oLnsOvQ3uhFwnHl
         q/VapbvV3RU0bnAwmVFmEJajxW49pIN2Hf9HV+btXY9uIGfEWlS1QJ8JSz6UGBdtMk1U
         +8wJeHAxgUEkCu8h61t9jiXIzaVGjPOua7jd/JYzeXytT5gxTHBsyQfMjs3Jj/YZ04iq
         pM+sVbxpCZY5MnUxH5mmPzcbtpBPvMmr+7dFBxveHPWjWGK4u34rUrdy9hV781dtwlWY
         Eq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=13+rXwGRPr4a9k2vxA2bU+fJEZZ58Un4R7s1pCG1lS8=;
        b=zCNClna6Txs2qpjzvLa92EN6YnMBx7kImPh0a0R7ALbeV3Vq/qTl/UmHRHfmm8TLZG
         pGB55zVJfXmsRCO7b4pdKbjNj7Rt91Iy1+4lzmYt5mgyDiYut0toS+r25MxtOBvtMyfs
         3BwHGSDmVj4gf7bWZfKVryLjG7FZKkRflsDfr4rCLHY/i83yFAkLA1HK4P9Zupg1RXrM
         W7vQx2KE+qbAnuXc8nkxV+eWrF9c/vDcMPm0rNf2XwLpAXBrDNU4LINRUbvoaRuqt3Uc
         7KKGe4nJAeNnSpho9ZKMCwBPJy5A+wvZwNuzj0B1wttxJKK6DJOMr0urrZIErIUiJz2Y
         4hCg==
X-Gm-Message-State: AOAM531gdKASKkYNT2gQsmCHfapakB+L3vyJ/ZOdtn8L/jRsWI/SZfXL
        5cXjw9ymGnx8DL8FjASlVDjSE8LCoSNDHsp0OmQ=
X-Google-Smtp-Source: ABdhPJxhuzpEjYM0SYWzQ5erGRHbOPbVZgaxqBypdrOqsvDIiwqUOHlsi3WBKRQ2FG/BqhMmL56nVLomfkfSMTFYfBY=
X-Received: by 2002:a05:622a:3c7:b0:2e1:d537:a15a with SMTP id
 k7-20020a05622a03c700b002e1d537a15amr3402271qtx.522.1648109461581; Thu, 24
 Mar 2022 01:11:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ad4:5bc1:0:0:0:0:0 with HTTP; Thu, 24 Mar 2022 01:11:01
 -0700 (PDT)
Reply-To: ozkansahin.gbbva@gmail.com
From:   OZKAN SAHIN <henryhart212@gmail.com>
Date:   Thu, 24 Mar 2022 11:11:01 +0300
Message-ID: <CAFM2HgxEaVy9K+zQBhe-K2PtxuZpypdpwXxXmr2a-vEYrUMyog@mail.gmail.com>
Subject: Hello Friend
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:82b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [henryhart212[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [henryhart212[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Greetings,
I'm  Ozkan Sahin, and I work as a Financial Management Consultant. I'm
thrilled to approach you and present you with a lucrative offer I've
prepared. If you're interested in learning more, Please reply as soon
as possible.

Please contact me at (ozkansahin.gbbva@gmail.com).
Respectfully,
Ozkan Sahin
Financial Management Consultant
