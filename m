Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E156ECC7E
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Apr 2023 15:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjDXNDJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Apr 2023 09:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjDXNDI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Apr 2023 09:03:08 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD26D3A93
        for <linux-wireless@vger.kernel.org>; Mon, 24 Apr 2023 06:03:07 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f19c473b9eso44518445e9.0
        for <linux-wireless@vger.kernel.org>; Mon, 24 Apr 2023 06:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682341386; x=1684933386;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O0qu4IrE+l7+si2rWrqXyY3tqUUUcRa39pe0HYa886Q=;
        b=loqgWo1kqI8QHBiZmFY1GcUA0dFk3sX4BsMYx+Tzq9CfqQgi+fRyil8dRcEGqvBT71
         S6E7cm9JVyb7wZqavqmAoB49UHj8ISSd20+XwuBWYNvK1HtTwcL62N+4oB3wu18t+gsa
         jlFNiZ44iuYkGtUCF4SPnwW4sxudqC634gqbOoPU6ENWxrjhV5gGxeVtsuGb/kQ3mels
         ww4o7cBeQSbJ4QmM6kBJh529BPaP2ULrp0zJh9MS+pJuKJ7e5os9NYAIcfV0SCrk8JcE
         2i+fRB/oAlWaEtBLLPHti38LjE5TKDZoYEwVr/ae/zwfegUUzUcM28Luc1JEWREZQ8AD
         Poxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682341386; x=1684933386;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O0qu4IrE+l7+si2rWrqXyY3tqUUUcRa39pe0HYa886Q=;
        b=R7Vs7WpASs9I9/4Ip9/knt1RYRtgVJ39eIKRdOlCeKTP+0xWpiVlc/61Gv4X4kPtUS
         HUKVcM1/p+FNG9efVeJqVdSbQADydZ6Z+GwYNC/HyaCBQmWq31A1S8QPL1F0s0Uv13R3
         EhcIhdinYMrGwcOHlQjP2xEFNGDSJbSlxEmbAQjhifZnkfRh9yd5PoTsXuGdFgZSHF4l
         NheaIQEZpROfoNFE7imhMScneOfjznF3lLwYj37j+QTDBRfHOy616TK4ILwF5hlkDlEN
         ZalcEgpYYm3o4VWASoSNhUt6ClI4tMARcHHDi8H41OaC5NzPWOYVZWL3cZaBUJzBm0bk
         3B5g==
X-Gm-Message-State: AAQBX9cjdlywAV7K/GNqT0yPJAckzeQ95Go8+uFEHWVl1FkPx5QMz3El
        A3voSMGhGUspM1mxoVSHMDCLKSINP9t6JKihjCkKszoqhao=
X-Google-Smtp-Source: AKy350awnhN6+skN8u0DjoTc1DI6RbhLscaJNKFSQFrIvchBEFdreGc30YNn+lUoWtLsjazxXu6j42kd/NtkuIUi2mc=
X-Received: by 2002:a5d:4b01:0:b0:2fd:c315:bb2c with SMTP id
 v1-20020a5d4b01000000b002fdc315bb2cmr9839099wrq.22.1682341386105; Mon, 24 Apr
 2023 06:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <CALbLcfAXrHp4vsVGqU0nBdB_gFmKTKx0GcdrFJA7R_kodAy0Ew@mail.gmail.com>
 <bfe732f4-60dd-4d78-1259-5f9f6c11adbc@gmail.com> <CALbLcfB7cMctHC-Fv93z1WVCZkQ76uW2F_=P6rCW7ZSPXvmapw@mail.gmail.com>
 <2857f998-1b1a-e3c2-20fe-d03dadcf8f23@gmail.com> <CALbLcfCsyGzhvrqjSz37+7cLvc3rc4Y_kgspZV=kiPNs4TBE4w@mail.gmail.com>
 <CALbLcfBnF6njFMSfQk2TuOiZ3C3kHwqs4-c-MQGb72azzQ5sJA@mail.gmail.com>
 <38172c8e-d107-d96e-7292-09d0e3b061dd@gmail.com> <CALbLcfCHLU+zoFdTnTrJs22UUYwr2rETp5hqbv=NL352Qz-XgA@mail.gmail.com>
 <CALbLcfDZJmOyn-Gf24+9X-eHh3-3PY4_nP5soG3gHf_Vn85=EA@mail.gmail.com>
 <CALbLcfAiVgGi9iocEG4OfgET2XLDRq0dthbxDMP0vP3R6BBp_A@mail.gmail.com>
 <3ceecfc1-ab04-7d54-51bd-457a4708c0ac@gmail.com> <CALbLcfCpb8xbN+w2VvCZ6Gdr+L_ECH0UQsWZrpO1Hcpoef66UQ@mail.gmail.com>
 <8eaeb64e-3f7f-6752-4476-c0f0c88a008b@gmail.com> <CALbLcfD7AmMG72-Qxafc9533OQVBCL=RLDycjUCV2MJ0DRN6nw@mail.gmail.com>
In-Reply-To: <CALbLcfD7AmMG72-Qxafc9533OQVBCL=RLDycjUCV2MJ0DRN6nw@mail.gmail.com>
From:   Artem Makhutov <artem.makhutov@gmail.com>
Date:   Mon, 24 Apr 2023 15:02:55 +0200
Message-ID: <CALbLcfCPKhp0WX853XHgoGV+zaxwv=ThR-i-wR6s7gk_yqqHtA@mail.gmail.com>
Subject: Re: RTL8188EU (LogiLink WL0151A) - Malformed packets
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I have purchased an Asus RT-AX53U (running Asus 3.0.0.4.382_45213
firmware). And I can reproduce the problem in my own network now.
Now I have tested a TP-Link TL-WN722N wifi module. The problem is the
same here too.

In my setup the rxht mode works with rxmcs 19 and rxmcs 17... all
other values seem not to work...

urb_len 1564  pkt_cnt 136 pkt_len 1508 drvinfo_sz 32 desc_shift 0
rxmcs 19 rxht 1 paggr 1 faggr 1
urb_len 1560  pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 18 rxht 1 paggr 1 faggr 1
urb_len 1560  pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 18 rxht 1 paggr 1 faggr 1
urb_len 1560  pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 18 rxht 1 paggr 1 faggr 1
urb_len 1564  pkt_cnt 136 pkt_len 1508 drvinfo_sz 32 desc_shift 0
rxmcs 17 rxht 1 paggr 1 faggr 1
urb_len 1564  pkt_cnt 136 pkt_len 1508 drvinfo_sz 32 desc_shift 0
rxmcs 17 rxht 1 paggr 1 faggr 1
urb_len 1560  pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 16 rxht 1 paggr 1 faggr 1
urb_len 1560  pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 16 rxht 1 paggr 1 faggr 1
urb_len 1560  pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 16 rxht 1 paggr 1 faggr 1
