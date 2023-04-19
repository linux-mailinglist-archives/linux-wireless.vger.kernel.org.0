Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379B66E80A8
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 19:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjDSRwd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 13:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjDSRwc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 13:52:32 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F173E4EE2
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 10:52:30 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o29-20020a05600c511d00b003f1739de43cso1846174wms.4
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 10:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681926749; x=1684518749;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uAlZzhaLhMERDpi+40W1+UdcU78haGw2hpIt6K/uu64=;
        b=CXLjdHGhpkaYMEDesToTzOSTn92W/UqJc8nyX78EiE8kHikmyow4Aqi8gW7XygvxlH
         MbCkgiV3T2IOYB4FYFNpehLrb+cM7KK3GoMFW9aY8+ZAA0Q4tRb+8VhQNI/ZkZPruiIE
         yQvyfJO+9D+zBAdTbTiwNSblfNYDcOFFYHLf04BsL/XXBwa0UXSC4hncQ9evlXspWVs4
         1ubW2DRMT6GTpB+Y5wnBtYBFpVO8Xxh5eJSLw55tmczAKf8RFYjOowxu7I/53LQp/9Ag
         DSkUCsjIKdJQ52gDKzNcSsiYMJDczYDj+DOEsuufls7RZyOIKnjUr+qpn7dl0pC5C3xK
         jnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681926749; x=1684518749;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uAlZzhaLhMERDpi+40W1+UdcU78haGw2hpIt6K/uu64=;
        b=BX71oKJ+Gc8ZpABX6voP8m/Y1jpRaDdxosYQmq9zcDf8eT0Scb7nu0Wb3Mz/xwUNKn
         9UqkbGBLdkk8wIid+HlHZLEEvyzXUI1Aan3ngOZfU82v24yVVJs30c4BklKTABgEs1Ud
         ux7qsVOrjk53wnKg2Q4kqwL/UFCOQ1yxTlCqrL7qEObFfqjAkP3uVCHVxEkWUA1PUGR8
         WzE8gXkr3f1NFTZZidiZUy8Md4inwL6hbXONI1dLftgp9V46MDuj2jw737zwEj9jxBdL
         DLewZuhGkgp3gF0Jl1Tgmc4f1YWdHeREr85Jv8ilGfzH7+C1/0EOvzwpDnqrtW+uT3iG
         6lnA==
X-Gm-Message-State: AAQBX9epjXMQGhqlXk91Vdi4IAFEK+8XHJ8/N4+exhyD+BFETg1WatTa
        3WX0gXL8ihav0c80Vp68Z0DHa3iVQf6621T78LA=
X-Google-Smtp-Source: AKy350YhtM3XBos9BqPCGSR5+LJqaPOFqGe7vmmG4uT93XQohG7XEh3UA33Li0zHB4+9oKHgtX7ZsuhO5XfQN685nOA=
X-Received: by 2002:a05:600c:378b:b0:3ed:c84c:7efe with SMTP id
 o11-20020a05600c378b00b003edc84c7efemr2867146wmr.7.1681926749305; Wed, 19 Apr
 2023 10:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <CALbLcfAXrHp4vsVGqU0nBdB_gFmKTKx0GcdrFJA7R_kodAy0Ew@mail.gmail.com>
 <bfe732f4-60dd-4d78-1259-5f9f6c11adbc@gmail.com> <CALbLcfB7cMctHC-Fv93z1WVCZkQ76uW2F_=P6rCW7ZSPXvmapw@mail.gmail.com>
 <2857f998-1b1a-e3c2-20fe-d03dadcf8f23@gmail.com> <CALbLcfCsyGzhvrqjSz37+7cLvc3rc4Y_kgspZV=kiPNs4TBE4w@mail.gmail.com>
In-Reply-To: <CALbLcfCsyGzhvrqjSz37+7cLvc3rc4Y_kgspZV=kiPNs4TBE4w@mail.gmail.com>
From:   Artem Makhutov <artem.makhutov@gmail.com>
Date:   Wed, 19 Apr 2023 19:52:17 +0200
Message-ID: <CALbLcfBnF6njFMSfQk2TuOiZ3C3kHwqs4-c-MQGb72azzQ5sJA@mail.gmail.com>
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

Hi

> I have also tested the driver from https://github.com/aircrack-ng/rtl8188eus
>
> The problem occurs here too, but much less frequently than in the
> rtl8xxxu driver. The strange thing is that sometimes I have 99% of
> broken packets with the rtl8xxxu driver, but sometimes only 1%...
> With the aircrack-ng driver I had maybe about 2% of failures.

Now I was just able to get the issue using the v5.2.2.4 driver too,
but not so frequent:

tcpdump -ni wlan0
19:39:26.407253 IP 10.10.0.111 > 10.10.0.1: ICMP echo request, id
34080, seq 1, length 1438
19:39:26.410520 IP truncated-ip - 4 bytes missing! 10.10.0.1 >
10.10.0.111: ICMP echo reply, id 34080, seq 1, length 1438
19:39:27.442835 IP 10.10.0.111 > 10.10.0.1: ICMP echo request, id
34080, seq 2, length 1438
19:39:27.445703 IP truncated-ip - 4 bytes missing! 10.10.0.1 >
10.10.0.111: ICMP echo reply, id 34080, seq 2, length 1438
19:39:28.482846 IP 10.10.0.111 > 10.10.0.1: ICMP echo request, id
34080, seq 3, length 1438
19:39:28.490406 IP truncated-ip - 4 bytes missing! 10.10.0.1 >
10.10.0.111: ICMP echo reply, id 34080, seq 3, length 1438
19:39:29.522723 IP 10.10.0.111 > 10.10.0.1: ICMP echo request, id
34080, seq 4, length 1438
19:39:29.525468 IP 10.10.0.1 > 10.10.0.111: ICMP echo reply, id 34080,
seq 4, length 1438
19:39:30.524193 IP 10.10.0.111 > 10.10.0.1: ICMP echo request, id
34080, seq 5, length 1438
19:39:30.527100 IP 10.10.0.1 > 10.10.0.111: ICMP echo reply, id 34080,
seq 5, length 1438
19:39:31.525775 IP 10.10.0.111 > 10.10.0.1: ICMP echo request, id
34080, seq 6, length 1438
19:39:31.528707 IP 10.10.0.1 > 10.10.0.111: ICMP echo reply, id 34080,
seq 6, length 1438
19:39:32.527400 IP 10.10.0.111 > 10.10.0.1: ICMP echo request, id
34080, seq 7, length 1438
19:39:32.531262 IP 10.10.0.1 > 10.10.0.111: ICMP echo reply, id 34080,
seq 7, length 1438

Apr 19 19:39:26 kern.warn kernel: [ 3228.967023]
rtl8188e_query_rx_desc_status: pkt_len: 1504
Apr 19 19:39:27 kern.warn kernel: [ 3230.002515]
rtl8188e_query_rx_desc_status: pkt_len: 1504
Apr 19 19:39:28 kern.warn kernel: [ 3231.047199]
rtl8188e_query_rx_desc_status: pkt_len: 1504
Apr 19 19:39:29 kern.warn kernel: [ 3232.082274]
rtl8188e_query_rx_desc_status: pkt_len: 1508
Apr 19 19:39:30 kern.warn kernel: [ 3233.083901]
rtl8188e_query_rx_desc_status: pkt_len: 1508

Thanks, Artem
