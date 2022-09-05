Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7018D5AD739
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Sep 2022 18:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiIEQPK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Sep 2022 12:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiIEQPJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Sep 2022 12:15:09 -0400
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com [IPv6:2001:4860:4864:20::41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB9A1EC61
        for <linux-wireless@vger.kernel.org>; Mon,  5 Sep 2022 09:15:06 -0700 (PDT)
Received: by mail-oa1-x41.google.com with SMTP id 586e51a60fabf-127a3a39131so1571959fac.13
        for <linux-wireless@vger.kernel.org>; Mon, 05 Sep 2022 09:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=HURqEsL5vGgNP8D+eKx3/PEV2fgz8GnYsI58XUSSZjhkoAzxXFiCNmuWDtjgKW6vRG
         UAK5DjkAn3KbvdJNR7qWpNuQ7n0QyLkIMqlP8zdNtmDlD56QPPgJUjV9HgSZN8HyrRmH
         fQxTXKq2embzpDyspbFn+6tqaLcGJAA2Li7n8cKWPJK4DwgiGS8n9r26lQIHy5r/NtH1
         PIKzNsVgPLeuremlX1Po64CLCJnues9nN14xm1N0EGSIhhNrnrCjNDZAa+H44eh5cnsp
         Cymof3GezGIB4HCiMV/rXVK+fOfsJvIP01BvKPZCieQKFf/C2cFSPfNqZkXBzxvA3D19
         egjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=1pUDsMErnr+4fG3whE1X2JzDpd86NR6GlX0pgCWraDqhzkSPt5gvrEzk2KLKaXw0iK
         CtRl+y5DFVFmSsdrGgQoTNgz+hx8xl13kpuGPIXDGY602rrgZ9cL85FxyB3e2desiYh/
         6AiB0U0UjuSqFru0SM25DHH0uFuEVCJ5sKofiTf/bO2cGpd7UjsFoQZY7KhmbGnDdb9m
         4+9BcYIJxLW2PTk+ZMqTh03huDdaSXxc8PlHY97uWQ4juClJJdnTj0bLh66Mx694Zxcv
         mVtkHrsPRi/S25L6J2jzMjrQ14Ip2glXIqYfLjrZ9W1ShJR0LwaR7cR070Dc0qDEOuU9
         smBw==
X-Gm-Message-State: ACgBeo1zAIgsP0FAMnm8RYcWjfNfO3sfcxdkAyp6ZZUiqliy4P8sGssf
        AubkhAkKl96dk1CPvKI+b4Gega6mnnQbFpNnvFQ=
X-Google-Smtp-Source: AA6agR6HeoXbMcqHi1LQUPxgwv/dzKytzYJpqTGDBo8qOzhkCQ+AxQgPPSjwpL5vgqajYE0tSDFKsdSZqA6c9gE+jHk=
X-Received: by 2002:a05:6870:5804:b0:11c:b6d0:b844 with SMTP id
 r4-20020a056870580400b0011cb6d0b844mr9514609oap.184.1662394504801; Mon, 05
 Sep 2022 09:15:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:8403:b0:b3:9407:5fcf with HTTP; Mon, 5 Sep 2022
 09:15:04 -0700 (PDT)
Reply-To: maryalbert00045@gmail.com
From:   Mary Albert <bariyoussif@gmail.com>
Date:   Mon, 5 Sep 2022 17:15:04 +0100
Message-ID: <CAA67+kCAQL=xr8BfLDZO0Zyo2k7ERB2YbAkMUhR4h2MgapGOHQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:41 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7520]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [maryalbert00045[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [bariyoussif[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

-- 
Hello,
how are you?
