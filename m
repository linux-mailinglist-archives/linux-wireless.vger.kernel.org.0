Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CE453170B
	for <lists+linux-wireless@lfdr.de>; Mon, 23 May 2022 22:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239733AbiEWRNq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 May 2022 13:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240834AbiEWRMl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 May 2022 13:12:41 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163FA6BFD7
        for <linux-wireless@vger.kernel.org>; Mon, 23 May 2022 10:12:08 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id t13so3380771ilm.9
        for <linux-wireless@vger.kernel.org>; Mon, 23 May 2022 10:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=vsoZkcYm3jCCjpX9R4JNfB/t4Y2EE574Kr+1kQkq8IE=;
        b=KYxjcNiybC108JsuQ9VvDdOY+A62ix0fZKBDUhsF0gCJMhMGaPdboME8o4kk7EOlHL
         Y+oe+NleGaX9TNOmVUi7RA9OOiBNwp5HxD7FlR74fXw8ZAehK3wy/FMiXpklCTggtEbY
         PTi8GSlmIXLLc6xO0z25LLLD4QJ4pnKip6n/c3KaHkkSLad/rxSSmGdvyCaIuTy97pRS
         FlN3PGMf5RFylBRKdw3Zp1eTDa1eHZN1eqHFTFQgO5rwrxaFJ2qX1fAn6dRc0gOkgDXH
         sSgwxjVLfnsZkwQ5R8yBV/KIN53WVhyTMrgJBexUMowcjYnV47y9tnDjjob7yE3Su83a
         0zZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=vsoZkcYm3jCCjpX9R4JNfB/t4Y2EE574Kr+1kQkq8IE=;
        b=vdPS/x+7S3pm6rrtQTPnNoWV3dPef7phLoU4zuJQyrGB/Ywst1VKpp8aXvAUMVVhmt
         r86BATvAcIjwzp2jfDxjA10A1yDyFgGNhBViUv4NwoPpAfvRDqI8Q1PWj208xyFKo5JK
         UR7POWDW3wPudVDX30uYO3OhbbkQkdILhw1scrxqE7N+dUhGC/PnjbaQ9Wl85wcwcQKw
         e5KixSQDfzf/hCf6WsJM0xaowWXTmiA+azYf+sQLw/XxrFr+zdVyxrcBaPZ372t1YlfF
         q7zlcaqgsWoAVpU0z4l7B21ud4qbBAscu8QUDonbHj+vyW8jDgw4/hG5Qt/peJUoLuJx
         1ZeA==
X-Gm-Message-State: AOAM532z80evVN+ozp9vLmmR/GkuA/M2Lvz9QSeDOqw5wbpgLMXxdJ+l
        mVOlqPrq0CD8YLiYS1sI60EiF2U4NF/WL09K0g0=
X-Google-Smtp-Source: ABdhPJwWcueot0Mxo+0p0VKjmL4BUkwkHwyADIikhd9AXDKz+Zo1WtVgIBIH7ZvwU8P0COIOJ9pUtus2BVmYGCKlT5Q=
X-Received: by 2002:a05:6e02:2142:b0:2d1:4344:2431 with SMTP id
 d2-20020a056e02214200b002d143442431mr12120442ilv.188.1653325893824; Mon, 23
 May 2022 10:11:33 -0700 (PDT)
MIME-Version: 1.0
Sender: nicolemarois222@gmail.com
Received: by 2002:a05:6638:339f:0:0:0:0 with HTTP; Mon, 23 May 2022 10:11:33
 -0700 (PDT)
From:   Miss Qing Yu <qing9560yu@gmail.com>
Date:   Mon, 23 May 2022 17:11:33 +0000
X-Google-Sender-Auth: A93i-LO44QCWuQPq7-XYmhtkgSE
Message-ID: <CAH7nGPuWhmtcL+V08v1D+Avvjz+==-vK2+41A9bc6st7z2yAew@mail.gmail.com>
Subject: Hello!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_SCAM,LOTS_OF_MONEY,MILLION_USD,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

       I am Mrs Yu. Ging Yunnan, and i have Covid-19 and the doctor
said I will not survive it with the critical condition am in because
all vaccines has been given to me but to no avian, am a China woman
but I base here in France because am married here and I have no child
for my late husband and now am a widow. My reason of communicating you
is that i have $9.2million USD which was deposited in BNP Paribas Bank
here in France by my late husband which am the next of kin to and I
want you to stand as the replacement beneficiary beneficiary. Can you
handle the process?
                                Mrs Yu. Ging Yunnan.
