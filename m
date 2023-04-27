Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D456F0DC0
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Apr 2023 23:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344179AbjD0V2e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Apr 2023 17:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244592AbjD0V2d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Apr 2023 17:28:33 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5D2212D
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 14:28:32 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f19a7f9424so66427045e9.2
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 14:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682630911; x=1685222911;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iyJ6bE2YwZpaI/zL0FvjNvwOuhXvsUVswjrT+hrUq5U=;
        b=OmshAKCJnDLqKty444TdDEddNYfqvL2bRx0ZS6fd+po3oHWMkMCmCaWa34QR1n5si9
         /plVfbSdhq0tH7PZb26+QQO3B8Az9pg3iXzHvqPt/6A8x8roU124z21eGhZHtz225ou3
         xYxrdABJczZda+BKt8RmqPwxhXe0AfI8LPpbidcpPXPC82jJ18GIDZCvqPom/rOOu16J
         cNz8c36douCOjciYKlvNhSKg+7lq9jHBvL9bh6XrTh9k9bHHUTTmDANxf7cb23xp9FMC
         HibhlcIT+LkM73JvcJQh21XHKIu2e9KN/HR1nGAE+a8jL+YuJw1dIC3ouERn5KV3Lrpv
         m3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682630911; x=1685222911;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iyJ6bE2YwZpaI/zL0FvjNvwOuhXvsUVswjrT+hrUq5U=;
        b=A7/h5TJYyectN53WbR+vrWYDF3jMZcDI2HJG2DeDNOapPLH888QPmI8TDJ+E0pryFH
         weOwVzsJl3T5HB+s7wzyBTZTCirZlaoRjIamGxCG2SpKFMepeLChE1bDrLvU8YLy7K4K
         YxoJeDQiFkp5P9YyGFZsxQyV/SAxOs+0/hxNtB5/33B+r6I8nVJo9q37ULWUjudjJ3fa
         ACXFE9+ZgtKdJps6SM4whdk9VLH1/wjaL0szhnF78Fi+vvFC29mcR28RBo7iLR4kVYdG
         xrHk6ZYDMAapLB4GcWpNDxqZeSZKf4ktNKheXAmmBnjOUqt1qsKmWkiIFCb8ZNok0706
         49lg==
X-Gm-Message-State: AC+VfDw+LwF3TT2IUI1UopAn+SaM6IiP2ufEffgGteE5HuMPUvifEp1v
        eklTMiFvVYGU81oRLtjxDAKxVdCTNcdEtog0J+w4fI6if/o=
X-Google-Smtp-Source: ACHHUZ4x/FpxTY386Wq+OFnaPKVJqxQReEcIEFEu7WPbavmF+y/RONNpuNJnbQt0VMdUR6eldCHW0+yUADznDK8nepA=
X-Received: by 2002:a7b:ce8b:0:b0:3f1:806a:83d5 with SMTP id
 q11-20020a7bce8b000000b003f1806a83d5mr2468032wmj.20.1682630911086; Thu, 27
 Apr 2023 14:28:31 -0700 (PDT)
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
 <2a679614-c964-dc3f-c987-6c7ee03923a0@gmail.com> <CALbLcfBGg8FTBZx-_8v6u5iLsAssr+=QgQYc+Q2bUbmEwJPRYQ@mail.gmail.com>
 <0ce23546-7bf6-ef96-9417-c62adaa77cb6@gmail.com>
In-Reply-To: <0ce23546-7bf6-ef96-9417-c62adaa77cb6@gmail.com>
From:   Artem Makhutov <artem.makhutov@gmail.com>
Date:   Thu, 27 Apr 2023 23:28:20 +0200
Message-ID: <CALbLcfCYO2Uk91Mq6FW1UCx4j8RiK1Hpy-1VU6wb9tipBi74Fw@mail.gmail.com>
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

> I had another idea. Does this help?

No, unfortunately not. The packet size is now different and the
difference is now 12 bytes instead of 4 like before:
[   95.519092] urb_len 1544  pkt_cnt 136 pkt_len 1488 drvinfo_sz 32
desc_shift 0 rxmcs 13 rxht 1 paggr 1 faggr 1
[   96.565095] urb_len 1544  pkt_cnt 136 pkt_len 1488 drvinfo_sz 32
desc_shift 0 rxmcs 12 rxht 1 paggr 1 faggr 1
[   96.567223] urb_len 1556  pkt_cnt 136 pkt_len 1500 drvinfo_sz 32
desc_shift 0 rxmcs 4 rxht 0 paggr 0 faggr 0
[   97.600101] urb_len 1556  pkt_cnt 136 pkt_len 1500 drvinfo_sz 32
desc_shift 0 rxmcs 4 rxht 0 paggr 0 faggr 0
[...]
[  129.872096] urb_len 1556  pkt_cnt 136 pkt_len 1500 drvinfo_sz 32
desc_shift 0 rxmcs 4 rxht 0 paggr 0 faggr 0
[  129.879972] urb_len 1556  pkt_cnt 136 pkt_len 1500 drvinfo_sz 32
desc_shift 0 rxmcs 4 rxht 0 paggr 0 faggr 0
[  130.870341] urb_len 1544  pkt_cnt 136 pkt_len 1488 drvinfo_sz 32
desc_shift 0 rxmcs 12 rxht 1 paggr 1 faggr 1
[  131.919967] urb_len 1544  pkt_cnt 136 pkt_len 1488 drvinfo_sz 32
desc_shift 0 rxmcs 12 rxht 1 paggr 1 faggr 1

This time I have much less packet loss as I can only see rxmcs 13 as
max in my logs. Mostly ht mode is not in use for some reasons:
256 packets transmitted, 235 received, 8.20312% packet loss, time 256218ms

Without the patch I was getting 88% packet loss...

And the curious is why were rxmcs 17 and rxmcs 19 working and the rest
not (in my previous tests)?
