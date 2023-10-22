Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAAF67D2286
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Oct 2023 12:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjJVKQL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Oct 2023 06:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjJVKQK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Oct 2023 06:16:10 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4722CEE
        for <linux-wireless@vger.kernel.org>; Sun, 22 Oct 2023 03:16:08 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53e08e439c7so3588513a12.0
        for <linux-wireless@vger.kernel.org>; Sun, 22 Oct 2023 03:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697969766; x=1698574566; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FDLenGM6rRvmszfH7Fb1IvY1icqMZoQlR9FBjkW2Nkg=;
        b=lVt0lJ4pDgXO0aPLKvYBiKhNKHL+/2Dq5uPd38n84swSc5utLs7bUhchOS6d4ds2Sz
         5c31NN2QFORbzJy6NsoU5psvQa69aSsEsnflc0IxH58Ns0m5jRgL0onB//0+qP/BE7bq
         kuruQYMO8ED9IL3YMow+OG3aaKf2UDADEp+hpQqoLuWdr4fveIflRtUIdPFvmTQwFQBS
         epXGUvRs58ZiM8snOkIquUgG2621V807R6g1xTUtZ/f/Pk+EH5XFvuS7jLr59CiidX9D
         mz1qV8iG+vmaVvrLRnjSWg8cCpMUC2Zdx0Mb35bMbfT4IZJtdKjjfuOhq93Y3c90HEjo
         KeqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697969766; x=1698574566;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDLenGM6rRvmszfH7Fb1IvY1icqMZoQlR9FBjkW2Nkg=;
        b=vFAPwwScwUXdWRP6fxisI2lUOls8jcPbpiN8mfOWBnDWkT4SdMHwwaM+eK0AJNN4+R
         8bmN2qEFj+2BjuJWFmkf6+egHI5wm4WM9EvyhzJ3nA1T81ctmMveS13kwyCUHbIHL7ke
         F1Co7qlnWqsiBRwQD8wQWlJPYomxcft7rOT758q1qUCqmBdy/ehC4+rr6MHenCVsqJOq
         bDz2TxYm0eZyZsgapHsX5GP0LEy2eBjSGqJdfth2dG6x/JUHaY+jRwG3xv0MqcHQEy4w
         dMIhQaZzL6QJCaPgnVvvbK6SHpeVB4AnjwXG5TXu5ExW71XRzmGesKvig5R2O/cbR2fe
         M3Ew==
X-Gm-Message-State: AOJu0YzkQUGjv+ZnQDHuSuf/PLdSQ3fmdLw0dA5rZWRsn2nVb+wqIaO5
        m5H7xAI7cBL8x5MIHQ9aP0aiuEzuxelisg==
X-Google-Smtp-Source: AGHT+IE7SHOVtApQlH+irMzrJaexoaxYn5+OTZY36DHxmgQXUfzBSLcJtDKcimTjzQ6nbTZe/mKjGQ==
X-Received: by 2002:a50:ccc1:0:b0:540:16d0:3332 with SMTP id b1-20020a50ccc1000000b0054016d03332mr1872252edj.20.1697969765994;
        Sun, 22 Oct 2023 03:16:05 -0700 (PDT)
Received: from [192.168.0.14] (ip-213-220-240-165.bb.vodafone.cz. [213.220.240.165])
        by smtp.gmail.com with ESMTPSA id cf15-20020a0564020b8f00b0053deb97e8e6sm4545156edb.28.2023.10.22.03.16.05
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 03:16:05 -0700 (PDT)
Message-ID: <ca929e1d8197ace414a06b20151b84de3dd160f4.camel@gmail.com>
Subject: Old WiFi modules -- for testing?
From:   Rostislav Lisovy <lisovy@gmail.com>
To:     linux-wireless@vger.kernel.org
Date:   Sun, 22 Oct 2023 12:16:04 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,
I am interested in donating the following WiFi modules to the "Linux
wireless project". I guess they can be used for some automated testing
or training or something like that?

https://photos.app.goo.gl/sfootr3X8KVUBYf48

I am located in Prague, Czech Republic.
I can for sure ship worldwide if someone pays the shipping cost.

Not sure if there is better site/mailing-list for such offer.

Best regards,
Rostislav

