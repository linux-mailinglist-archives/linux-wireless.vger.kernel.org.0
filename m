Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE677031A0
	for <lists+linux-wireless@lfdr.de>; Mon, 15 May 2023 17:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241380AbjEOPd5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 May 2023 11:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238199AbjEOPdz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 May 2023 11:33:55 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C51E76
        for <linux-wireless@vger.kernel.org>; Mon, 15 May 2023 08:33:54 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 2adb3069b0e04-4f1411e8111so14913505e87.1
        for <linux-wireless@vger.kernel.org>; Mon, 15 May 2023 08:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684164832; x=1686756832;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ds/+e8MbsIwR8zyWJQL9G2z1Z+fUDkq/gu9HouZE2bY=;
        b=eMVhHtN268v/VJvI6SbPVUUIaJyB5hRKmPZKErssPQzV8oW+rn4o4PYcCd+dTRDSXU
         KftygwmT/Gq9ccDK9Vu1wmFq7fo4/z52soKbw1UO4mlvwZdC7Obl93mGpGUOkGaj3bpo
         B5NAVz7SfwAb/DjDRbpbVDUwFwODcp6zUDWOLUtMt/HTxGPER1APNIILgsBTYlXCM5HD
         BFKnu6FYna65UsL8OPR5Im4eU+qnRgAPr5NfCwMNFAAj8KubsFVy9lWYtYq59NMJb/k+
         DtLwFbxrFfx4l1Jq2FSEipw00vs19GRlYkVObgn2am3ZtQmVubbywhAU1yZegUdmMB52
         Emhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684164832; x=1686756832;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ds/+e8MbsIwR8zyWJQL9G2z1Z+fUDkq/gu9HouZE2bY=;
        b=R9nXVnsNnliMgYSNISNxnYUzbgMQQddkU6Q79zKnG1yFcaE9EU78ubNfDuRIsCSFb5
         3JXnj5/rHkL/cscSmKrJwIY97lJRHvUs4Fpg4GRZXbAhLYf0+MsmvSAS3EeX8SgnKXyx
         4IPLZrmzoTxNWc0uVgfttPzWiOemaTC6fb6hg86g0RZeqVsip9h6KzIZFyA4DeH2vUX9
         wY1ICYlqwyupS6SOC0sW/Jga+3cHuwXHKuEG8rFySE9q7hixYV3YISCRiTA5h4KuoghH
         cTqE4Qx3WtBVzMeez0QTOZKXK1wKDa0bW2tt0t9SK93Kl+oJihOdzFMSmjgOcsW62QrC
         YvtQ==
X-Gm-Message-State: AC+VfDzs6R8CcdrSuX2ZKzckKnGMJVIFkM8+ARx0wk4Q2u839QpbSU/0
        sEavR8rUoHN9nCW3VTFiZxUk0cRP2ZAotkqCfqo=
X-Google-Smtp-Source: ACHHUZ6R3L6pwkm1RRYiZ4JuQOvGcBQsvdOd2qkrgDjXf1Hki6YO3QeM2AqUYhDOwme3mkde5qCSp3HoKPXF5LBquBY=
X-Received: by 2002:ac2:4894:0:b0:4ef:eda6:c14 with SMTP id
 x20-20020ac24894000000b004efeda60c14mr6773813lfc.35.1684164831962; Mon, 15
 May 2023 08:33:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6022:9028:b0:3f:1229:2da2 with HTTP; Mon, 15 May 2023
 08:33:51 -0700 (PDT)
Reply-To: lschantal86@gmail.com
From:   "L.S Chantal" <ms5532077@gmail.com>
Date:   Mon, 15 May 2023 15:33:51 +0000
Message-ID: <CAMdNc1Zb97JEZBZUfVQn_zvNXpaCnbaEyzLTW1qQ6EqtpbMPyw@mail.gmail.com>
Subject: hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:141 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5024]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ms5532077[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lschantal86[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ms5532077[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Good day to you , I have a lucrative business proposal, which I

believe we could mutually benefit from. Kindly notify me for more

details, if interested.

Thanks
