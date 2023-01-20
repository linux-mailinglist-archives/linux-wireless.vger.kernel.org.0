Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1711675E70
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jan 2023 20:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjATTyU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Jan 2023 14:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjATTyT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Jan 2023 14:54:19 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A306197
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jan 2023 11:54:18 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id c124so8022617ybb.13
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jan 2023 11:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFAf4GX2Z4+wfrgttwzV5+c5HT2KzF2KId7AyXASwfg=;
        b=E7erTvXsACKvD2AVsShIx3GEgrOjed9kLpZ23jFFlxxbtmOGJIEIak2Lm66mLZWJzb
         Oc6SxnHM56IBoXSwXFy6jVzWMZKx9drfF5zoXBef7IYDIn5rzmixFIYN8wjsqrqtPZhn
         GW2gO8HSFfZtwkExCjxvuhpkIADM6fTemxvSaByscdEgzZCbMlFM84urBjfIP7KtKWeb
         3sKDRM5li/hu+Pl5Z6lSgGMrDDthNCs64EaOThGqCnK74bC1rXn71fS1Tj3p+axiERlq
         KKalyeisK5bIhHWo+HxLId4FGEz8oX+F7GkJelritaYrzq368yTni8KYoWNG2vlWyRWm
         V2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jFAf4GX2Z4+wfrgttwzV5+c5HT2KzF2KId7AyXASwfg=;
        b=yOa5zVqiXIXQXlcMqfCbJmiHT054SUGo3RoZ+XvbTtmQnTW5LfAmZOWVWRGMxpZb7j
         Cg4u9XARrcCGLJkiYa+AxPHZVa6qNX/I6xzzH3dtP8nah15f628xS/wNoSxzjLF7URe3
         9mzrzuTmtrlZT63rZINf5zXkggdD7kd/yAa+4PG7VjYXRlYlEqTU1JF62qPkUHcfFqGm
         +ni/amRLcjtZaUUFxlVGCIec47NVBquy7iusuwTuzXAHxobHjY124mCJj6oop5ZwlHig
         fEpxxN8wav/Hxs2Q3Lq298JwQQ2hdBrbDFpNSbmB8ctPFL4aWiw30EnckFkMtDG18a7b
         R7kw==
X-Gm-Message-State: AFqh2kq1C/x5pzbE1ITxTewPTHkjJABSP74Lw4DSSPD9E7hEOAKBN+Af
        5pQvkf4wa2Qoacla2GA/2ACHAitriUAM/yQLWKA=
X-Google-Smtp-Source: AMrXdXvy5kM+AXec0l8X98n0yxI+NTDzQr9EUXMXvryN+hv5q5dIWJIxIDC3qkFeUqWuYMXALP9qBPo5ao3Dxo/mE3s=
X-Received: by 2002:a25:24c:0:b0:7d1:1e07:2637 with SMTP id
 73-20020a25024c000000b007d11e072637mr1812969ybc.236.1674244457802; Fri, 20
 Jan 2023 11:54:17 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:6729:b0:320:59d4:66a1 with HTTP; Fri, 20 Jan 2023
 11:54:17 -0800 (PST)
Reply-To: orabank.atmcard.tg@gmail.com
From:   Leo Aiden <leoaiden7847@gmail.com>
Date:   Fri, 20 Jan 2023 11:54:17 -0800
Message-ID: <CADgGqCvJJa3uL1L4bnAe17LiU2fUoXAgz7H948amx9T6oXz8EQ@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello dear, did you get the message i sent to you less time
