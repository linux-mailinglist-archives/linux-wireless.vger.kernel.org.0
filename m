Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D8F52C710
	for <lists+linux-wireless@lfdr.de>; Thu, 19 May 2022 01:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiERW6X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 May 2022 18:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbiERW6I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 May 2022 18:58:08 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB4317DDDE
        for <linux-wireless@vger.kernel.org>; Wed, 18 May 2022 15:57:12 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2ff53d86abbso20964657b3.8
        for <linux-wireless@vger.kernel.org>; Wed, 18 May 2022 15:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=mZ3wqB4NmL7z6lpFr/h15h1rYqsZKafJnUpMVahbEPg=;
        b=czYkjWVoP4p/ZkNBJUSmJBfxUUt+Y13DbrrHvBfDUk39swnu2r1R2LMB3wAsUSY8FJ
         6ZHix6GZx2AHI61Xybet6sdcQlFElibcif9NAvmWTzz0l58WRUD1Pr+/0udl5Tub4w6J
         meMNyRnYfYgN6d8AQA50exC5S8Br4+BjGl3igVF9bo6vnyZ0caprRk+RWxvnLby0Adqm
         hPjkVM8mttTA162cBcx8kN6mr4q9cNJsYcLYU7yQFFkOaGBf3QJSI1TLD1TTjQK6bKO2
         /uQaa7XB0ntetoq2a8c8ZgimsW4075bFpPpigSla9RqML/vkCGJpD6xavnQrqxd781aK
         ZwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=mZ3wqB4NmL7z6lpFr/h15h1rYqsZKafJnUpMVahbEPg=;
        b=6BfivXm28YG0zFBVJgwnu8bmk3LwFbJn7yiTiGZaSuaGMbhy+c1rmQs4nhzgDAKPpv
         uj9X3AVeNCiVKrcb0NGXqkC1F6S62WZZtB9Lh4SuLz6gmiXRHNwtA9Xnrb4+ghuueHz8
         N+zfvc+keO7mcZJZoJUqVT2Vyy9oh6oZsfoogbtn1Di2N89wD7fVyzXDQhIsMY/q4RBt
         cvCRcNSrCoKEU7VYhwZxjwgYPUP+yYuMEd00M8mV/y76miLCqcLeN64S5FhxInZ+aSCT
         U5n5WKCkAg8BtIAYI6Xzh3s3GqlsF/Ijzc51o0SUxl+UKmhPuwFlje8NjhCO1X7tuGk4
         Af1Q==
X-Gm-Message-State: AOAM533sIFFdzKa0oYhCtvILu06stVQvwNvZBif+qtBpcEZFM7GieFMR
        GIrEbQw8qcrf63NFo4jxzgBfSaW9kODZX9V0m2Y=
X-Google-Smtp-Source: ABdhPJwfS30wbsCjPY8UVYlWs7ui3rJia0tAtpKvKb7UJ9kvW7xj8JsSqbuzt2V828J/37SMn7X7nS55vBF2Wrce63I=
X-Received: by 2002:a0d:ccc3:0:b0:2ff:4e0:2be5 with SMTP id
 o186-20020a0dccc3000000b002ff04e02be5mr1833971ywd.225.1652914631436; Wed, 18
 May 2022 15:57:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:7143:0:0:0:0 with HTTP; Wed, 18 May 2022 15:57:11
 -0700 (PDT)
Reply-To: tonywenn@asia.com
From:   Tony Wen <weboutloock4@gmail.com>
Date:   Thu, 19 May 2022 06:57:11 +0800
Message-ID: <CAE2_YrAOSJNMn2masB_R9LowQvWJNrct3SYBUk3PivGhjD0fCA@mail.gmail.com>
Subject: engage
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:112a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4589]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [weboutloock4[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [weboutloock4[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.4 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Can I engage your services?
