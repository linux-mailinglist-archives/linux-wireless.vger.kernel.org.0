Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76666E803A
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 19:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjDSRVY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 13:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjDSRVY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 13:21:24 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164B0659B
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 10:21:23 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-2f939bea9ebso2799299f8f.0
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 10:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681924881; x=1684516881;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xaOn0TXhXegojKZpPV/cmAeDvo18RHuYhAFTJssgNls=;
        b=P3WUw73ex5PKzB8jbXvMNuvMHuAt5Id0liOADW+boedguGQ4sotQeHkN0r3TCYfvv+
         ayMQd4gB05HF3HILS0kqGm+iqVPEAt9Zz4osTzox0/nsaUqvp3poKcgbU+3YDxxgHe9k
         QKMdYM85KrfIqgh7SaqtIAt6BK+yB8nw1l1x00HAhNFzm4slF5yHtH0oWKI3ckeDidke
         MWxuKxwrDnos6+Zq9MAGr4nc53CN9llNoJLRmRcXRIahvR/rARx5g4cvMEFcem2HjHtl
         NXQ9+pHjBNjg0W6IW/mGmM8wxWWzF8tvdeJDzVKZcraqqlLvUZs3sfVJiIq045eOdeiP
         vG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681924881; x=1684516881;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xaOn0TXhXegojKZpPV/cmAeDvo18RHuYhAFTJssgNls=;
        b=kYvO9fWsi4aFWhvucfPnicZx/30HnER2IFCw8CMmH6Cxd1ZOpDXw6Sb31MFaXvRDad
         UBHOqUpiZ4Dilb1YWxCrC6pnDe/fhg7mPQCxmSYwtZ5xBjzbhsThI3uvHBj2K44yqHOh
         zXQehUVp8snZMO1djjZFT/KrsjwIDQDXeNldOIyERAI+FTYBj7nsEX22Gxdm9lULiocQ
         dThQoWADJ/RqF7JVuGVgY7FI7Xt2RIltfMD1N1w3XLos8NpVfLS+mndLcgNeo2Ibk7N5
         8hz8wqPgSaGb4CmvNf8vAJBb6056sokixdyulATgbWQHzntYcAySLSD7N4FILGAvum37
         8N/g==
X-Gm-Message-State: AAQBX9dH9AxrTcu5R6O5Akgz0MUgZgpV87hjlcbMe/5cPtylJvYnLlhM
        6JXHBF6tS0PEmybF6VbLw1VJVMDdJkKW4lu0SMjKjQ6sLqI=
X-Google-Smtp-Source: AKy350YhGlJ3BdphpqGDVx421DIljVE2ThgKiaZZNnHR6ZzlGeZpez2lW4z8q0p0G5/lZ5ng/L9pwLR2An6hrHKKCPc=
X-Received: by 2002:a5d:4acb:0:b0:2ef:b3e6:8293 with SMTP id
 y11-20020a5d4acb000000b002efb3e68293mr5706558wrs.9.1681924881409; Wed, 19 Apr
 2023 10:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <CALbLcfAXrHp4vsVGqU0nBdB_gFmKTKx0GcdrFJA7R_kodAy0Ew@mail.gmail.com>
 <bfe732f4-60dd-4d78-1259-5f9f6c11adbc@gmail.com> <CALbLcfB7cMctHC-Fv93z1WVCZkQ76uW2F_=P6rCW7ZSPXvmapw@mail.gmail.com>
 <2857f998-1b1a-e3c2-20fe-d03dadcf8f23@gmail.com>
In-Reply-To: <2857f998-1b1a-e3c2-20fe-d03dadcf8f23@gmail.com>
From:   Artem Makhutov <artem.makhutov@gmail.com>
Date:   Wed, 19 Apr 2023 19:21:10 +0200
Message-ID: <CALbLcfCsyGzhvrqjSz37+7cLvc3rc4Y_kgspZV=kiPNs4TBE4w@mail.gmail.com>
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

Hello,

Am Di., 18. Apr. 2023 um 17:49 Uhr schrieb Bitterblue Smith
<rtl8821cerfe2@gmail.com>:
> Can you also capture the wifi traffic using some device which is not
> handled by rtl8xxxu? With airodump-ng, wireshark, etc. Then you can
> compare the pkt_len with what the capture device sees.

This is not possible right now as I only have remote access to the device.

> It could also be useful to see what the v5.2.2.4 driver receives,
> both with 1428 and with 1430:

From the v5.2.2.4 I am getting:

ping -I wlan0 -s 1430 10.10.0.1
[ 1249.671282] rtl8188e_query_rx_desc_status: pkt_len: 1508
[ 1249.697409] rtl8188e_query_rx_desc_status: pkt_len: 456
[...]
[ 1250.210397] rtl8188e_query_rx_desc_status: pkt_len: 119
[ 1250.306412] rtl8188e_query_rx_desc_status: pkt_len: 456
[...]
[ 1250.660650] rtl8188e_query_rx_desc_status: pkt_len: 1508
[...]
[ 1251.438777] rtl8188e_query_rx_desc_status: pkt_len: 264
[ 1251.533917] rtl8188e_query_rx_desc_status: pkt_len: 456
[ 1251.636303] rtl8188e_query_rx_desc_status: pkt_len: 456
[ 1251.677177] rtl8188e_query_rx_desc_status: pkt_len: 1508

ping -I wlan0 -s 1428 10.10.0.1
[ 1335.845038] rtl8188e_query_rx_desc_status: pkt_len: 1506

> Also, can you show the hex dump from a good ping?

Yes, I will try to capture that, but it's not so easy. The logs file
is overwritten verry fast and it's hard to catch.

I have also tested the driver from https://github.com/aircrack-ng/rtl8188eus

The problem occurs here too, but much less frequently than in the
rtl8xxxu driver. The strange thing is that sometimes I have 99% of
broken packets with the rtl8xxxu driver, but sometimes only 1%...
With the aircrack-ng driver I had maybe about 2% of failures.

Thanks, Artem
