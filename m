Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A587873F8A6
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jun 2023 11:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjF0JYD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Jun 2023 05:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjF0JYC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Jun 2023 05:24:02 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214C1F5
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jun 2023 02:23:59 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-262e04a6f66so1093356a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jun 2023 02:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687857838; x=1690449838;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IFMvz1t0LofvCOctKtNJaEAeOmR5IX5Zh09WscdkoRY=;
        b=RmndcAni0gwwUzv0HWRoLzE+ir0/mtLykGH9m39VtnaTsxtVOjmCus5R02I2Hhxz0C
         kNI1gQKZ4tZ8X3OVulbmPLG7zcWQzgeKTLEJz9TlEgThKn9fsN9r07z+U5ylvz96odBl
         Ts+hwPqdQ0dsUbVC1AXCAWo+Pg6cnHRPA9QnzSAmFUhJLlTciPI6QzZEZ+N3I86vRe0u
         0ljmFhnXHTKZ1DOGU2MadlFdtwWgsCUNVg5RgQH6c+3acUWdnWTOZxA2S7NOSk8lSDfc
         9z0cA27dHdAI9wu2+GKDOgfwVS7HcL52ZVDt38aigkyocn8s6j2Jq40GIzKCehmovbAs
         2Ctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687857838; x=1690449838;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IFMvz1t0LofvCOctKtNJaEAeOmR5IX5Zh09WscdkoRY=;
        b=NnXNCIgHl2Omv3aZWK8bHwy8Gg3EWjK87S5mXUZ1wyoq2lc+EWH2B4XTcws5aqBqWY
         BnQ7gAv8jwnIL1RMGs8J3BeaabZ1x7hnyG/tAJx2WWv4WweJqvqe424wtrjQy42e8ahc
         nRO2FuIPLSe/D3NCZGVUgWX1ieMWteCKgLQTirWToFg4oOcQ8/8Oyfwftq4SVybmfoHK
         4n+r98uxpKc3cdkzlUAFuNm5x1FKMpKoP5HvxV+DOLnumCM4KXA1ZqW8bvHRYZhLxfET
         LhSSXWNjtTiSHGaDxF0siWJQq5SOFHzePkOnbsUVzmcxx9IpH+mkksV8Tk3KaOH07k+E
         WoIg==
X-Gm-Message-State: AC+VfDwwOnjYl30G8Q4cqq4TSmeOo9Z2VOCthkF98pJ86UfnsvHw8VeT
        guCVzMc2XKpaY2WjLSM3sG2kpOUqUgfDv1E88Z4=
X-Google-Smtp-Source: ACHHUZ7DkLhWyAhW19xsZ8KwyN+kv5lH8Rk9oZIdrltv8JvkyNnHjUZC8YcL/skSJxxRvk1B37j0ipp3THEWIKptKeU=
X-Received: by 2002:a17:90b:1801:b0:262:f09c:e73d with SMTP id
 lw1-20020a17090b180100b00262f09ce73dmr4041666pjb.34.1687857838504; Tue, 27
 Jun 2023 02:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <bc4cb44d-4c8a-f672-b82d-0ae601bb04ff@yandex.ru>
In-Reply-To: <bc4cb44d-4c8a-f672-b82d-0ae601bb04ff@yandex.ru>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Tue, 27 Jun 2023 11:23:47 +0200
Message-ID: <CAOiHx=m8NUL_UwK2Gzv3hLeG_zqLw=f7+OZ=oQnkC8nAMz6Q+w@mail.gmail.com>
Subject: Re: On CORDIC arithmetic in b43
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 27 Jun 2023 at 10:40, Dmitry Antipov <dmantipov@yandex.ru> wrote:
>
> To everyone still interested in b43 driver:
>
> In 'lpphy_start_tx_tone()', how 'CORDIC_FLOAT((sample.i * max) & 0xFF)' may
> be non-zero? Basically it is (<32-bit> & 0xff) shifted right by 15 bits.

Looking at other users like e.g.
https://elixir.bootlin.com/linux/latest/source/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c#L3377
the the result should be masked, and not the argument to
CORDIC_FLOAT().

So that very much looks like a bug and likely should be
'CORDIC_FLOAT(sample.i * max) & 0xFF' or so. Good catch!

Can you send a patch?

Best regards,
Jonas
