Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986C25A505B
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Aug 2022 17:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiH2Pk4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 11:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiH2Pky (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 11:40:54 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F022C844E4
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 08:40:53 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-333a4a5d495so205061677b3.10
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 08:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=j1IB7j4OLRcSZ3g4J8PWmoYtAO/kHfADj7RgXZEk7hqFtG3q70Lteze87nvzQDS+R9
         CL8iucEX5+pUR6GFNM9YhGtkQ/K3YSilHFtT6rgltDxGIvOl9WNWofz15dSno2pvUCu1
         1Bhescdr0s6ryDzQi+7/8n16+XcM1cHIhWF/zqW4grSQ4jgaNHAQGVva5E5CPm2a9nSv
         SACaO/HrWt5OCxmWYkpTIDTp7wOora+01Wom3zQ/aQLMJRMxDkExUHndf/LECmRtuQrW
         XvQR9OR4h0bTOOFoK/XuaduqdLSBZdKhGL15qV2OWEaWokw3wRFRvIVWgLQDBU1NqLPb
         rpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=sZsJayIjeVoJrj90QRwc1ZDeJdkytpm/CcEm7bjsLYARCGz8Ha0gG9QElDh0Hp++6x
         Zue8ccYJOqVtX7P1uGlWz2wpL3/P6nHNzl4rS4GdOqqcZ1MEahUfBIDM/7xf+MStVD84
         EIOQu7jf9uHGbjXRWGiS4uUZbY323qKU91mb2RLugVsGdzGlbORMoN2+weNPnXRJRTT/
         LYoC9B4NV/965oSFoijs+vFCxQe5c2F4v469zbXrdhxEth2vWqW11sVwKeEAnIBckedl
         xeM2Ldavoeyj0bn4kqBro/V1+ZZFSIsiSaMyV/+pHBhYw+YZ7/qshQg0sdiUPkRUBZoq
         ncdg==
X-Gm-Message-State: ACgBeo1mwDqDjZoo4o5O/QSrSDfB4EFNbiwvkE3tY2Sd1LAlouSurVAq
        n6E4XHPkRvomFYQ98/EtVAAu5nLu7SWX1+dnjCw=
X-Google-Smtp-Source: AA6agR4NTWVWHdEWupBK3yUp5civ1v9UDwj6Vijbz90HGEQyeGFiqExsePn6LGFrPnhq5fQhvylUEZGvwX6EMEDEgyQ=
X-Received: by 2002:a05:6902:1501:b0:697:c614:2079 with SMTP id
 q1-20020a056902150100b00697c6142079mr8689374ybu.389.1661787653000; Mon, 29
 Aug 2022 08:40:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:8a85:0:0:0:0:0 with HTTP; Mon, 29 Aug 2022 08:40:52
 -0700 (PDT)
Reply-To: izzatibrahim724@gmail.com
From:   "Ibrahim I . Hassan" <issad6927@gmail.com>
Date:   Mon, 29 Aug 2022 15:40:52 +0000
Message-ID: <CAKT4aHUraYFxy1fDiAH2JDxUv==nUdCvk56p+w91c2YJe5MOmA@mail.gmail.com>
Subject: Thanks
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1133 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4915]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [issad6927[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [issad6927[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [izzatibrahim724[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 TVD_SPACE_RATIO No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


