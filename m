Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB4A53D6F0
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Jun 2022 15:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240688AbiFDNH0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Jun 2022 09:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236189AbiFDNHY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Jun 2022 09:07:24 -0400
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com [IPv6:2001:4860:4864:20::41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EB42252B
        for <linux-wireless@vger.kernel.org>; Sat,  4 Jun 2022 06:07:20 -0700 (PDT)
Received: by mail-oa1-x41.google.com with SMTP id 586e51a60fabf-e93bbb54f9so13826809fac.12
        for <linux-wireless@vger.kernel.org>; Sat, 04 Jun 2022 06:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=XXEhaw3EyxGH5Hb/RtU9Bqf726dwWbeMmBNixXdVBho=;
        b=YdJZXgHJ/I8hXG0ekFy7RZTPgSnurEQ+JBj3OlEknwK3IPrbMfOv9xF6IwY0dZchQ3
         ozjpz2yAsuLZA1sa/EKqO1Pe92RCZq4QL9pGjYjU1YgDftj4Ktl7M17pm/EVz5nWxC/f
         0TNoADnsN3Ntn/XEhjBiNWOUAFgccHr8KOsNi6BubALk5KFuDi8XBRTOg+dGuJhrZJLn
         CuU2e2d/WJRiKwFZaOoqwTC3Y56IZznDSEWmerQVbs6siCTFLQd6WtPPdEtg5dqaFzRP
         mN6EdlNFKlBhQjoGODMJoUHYNH+BEi8fJ5L+PjAnk4yiA7wgZ5OnCJDOYqHXXEpVsa97
         NxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=XXEhaw3EyxGH5Hb/RtU9Bqf726dwWbeMmBNixXdVBho=;
        b=YF962SlZS0ZkN2jEfLS0RkzxTcszK43mfAXaL1duyaBxGJQeQaGJe6kEmr47WJwhgV
         jwjKdogX9cRtuAm2waUGp/zNBZXwIstmTGKZqSAfghSM2ZVd8JAnn1kQJknX18a0qOYI
         EqbJalAaVuFOA/3l/TfHnWlS6s1h+6fyz2y9IyZRnSvJGbf/jT+2o0MBVIiVe25FopLS
         0tL4aB+bv/EJuq3WZNvz8Hpkk6qZlJSmZ0T0pgQMUrPQ1ubfkFNIYgln8PX9/8B0r3Ef
         i9wkdF332XXRKGojO0p6WU+bEWgK9ri0fVes//V3wNQpuwTmktpNR/pAPFAukX+Ohqfy
         a7QA==
X-Gm-Message-State: AOAM531qUQIay4QsaAFP22K54CHR4t9DkevnrcH4B4vZdiYx0JjfDe0Q
        d9ACUNq+nI19oemlM4yeuBIx8VqiUY7y3+uNCvk=
X-Google-Smtp-Source: ABdhPJzfhEU24yqqtfLVVAX5G6kqQdY6jloYffDGXzPZeH87AtJpWn//ve+/ShIFv/HX+AauefON+f3EI5cUYjyGfk0=
X-Received: by 2002:a05:6870:c348:b0:ed:f231:2b41 with SMTP id
 e8-20020a056870c34800b000edf2312b41mr25784453oak.23.1654348039822; Sat, 04
 Jun 2022 06:07:19 -0700 (PDT)
MIME-Version: 1.0
Sender: hamp56690@gmail.com
Received: by 2002:ac9:7fd2:0:0:0:0:0 with HTTP; Sat, 4 Jun 2022 06:07:19 -0700 (PDT)
From:   Pavillion Tchi <pavilliontch27@gmail.com>
Date:   Sat, 4 Jun 2022 13:07:19 +0000
X-Google-Sender-Auth: 4k7otY6yv2gZkxy-Z391gcQ25Ng
Message-ID: <CAGPqaA5zkXz_6cretVpjAdi-mbsrQgpdK65g5cXQwnHTURASmw@mail.gmail.com>
Subject: =?UTF-8?B?2YXZitix2KfYqw==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

LS0gDQrZitmI2YUg2KzZhdmK2YTYjA0K2YTZgtivINmD2KrYqNiqINmE2YMg2YXZhiDZgtio2YQg
2YjZhNmD2YbZgyDZhNmFINiq2LHYryDYudmE2Ykg2KjYsdmK2K/ZiiDYp9mE2KXZhNmD2KrYsdmI
2YbZii4NCtmD2YrZgSDYrdin2YTZgyDZiNi52KfYptmE2KrZgyDYp9mE2YrZiNmF2J8g2KLZhdmE
INij2YbZgyDYrNmK2K8hINmF2Lkg2K7Yp9mE2LUg2KfZhNiq2YLYr9mK2LEg2Iwg2KPZhtinINin
2YTZhdit2KfZhdmKDQrYqNin2YHZitmE2YrZiNmGINiq2LTZiiDYjCDYo9ix2LPZhNiqINmE2YMg
2K7Yt9in2KjZi9inINin2YTYtNmH2LEg2KfZhNmF2KfYttmKINiMINmE2YPZhtmDINmE2YUg2KrY
sdivINi52YTZiiDYjCDZiNmE2K/Zig0K2YXYudmE2YjZhdin2Kog2YXZh9mF2Kkg2K3ZiNmEINmF
2YrYsdin2KvZgyDYp9mE2LDZiiDYqtio2YTYuiDZgtmK2YXYqtmHIDUuNSDZhdmE2YrZiNmGINiv
2YjZhNin2LEuINin2KjZhiDYudmF2YoNCtin2YTZhdiq2YjZgdmJINmF2YYg2KjZhNiv2YMuINij
2LfZhNioINmF2YjYp9mB2YLYqtmDINi52YTZiSDYqtmC2K/ZitmF2YMg2KjYtdmB2KrZgyDYo9mC
2LHYqCDYo9mC2LHYqNin2KbZgyDZhNi32YTYqCDZh9iw2KcNCtin2YTYtdmG2K/ZiNmCINiMINit
2YrYqyDZg9mE2YHZhtmKINin2YTYqNmG2YMg2KjYqtmC2K/ZitmFINij2YLYsdioINin2YTYo9mC
2KfYsdioINmE2YfZhSDZhNiq2YXZg9mK2YbZh9mFINmF2YYg2KjYr9ihDQrYp9mE2KXYrNix2KfY
odin2Kog2KfZhNmC2KfZhtmI2YbZitipINmE2KrYrdmI2YrZhCDZh9iw2Kcg2KfZhNi12YbYr9mI
2YIg2KXZhNmJINit2LPYp9io2YMg2KfZhNmF2LXYsdmB2YouIC4NCg0K2LPZitmD2YjZhiDZhdmI
2LbYuSDYqtmC2K/ZitixINin2LPYqtis2KfYqNiq2YMg2KfZhNiz2LHZiti52Kkg2YTZhdiy2YrY
ryDZhdmGINin2YTYqtmB2KfYtdmK2YQuDQrYqNil2K7ZhNin2LXYjA0K2KzZhtin2K0g2KrYtNmK
DQo=
