Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE6D6EB408
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Apr 2023 23:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbjDUV72 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Apr 2023 17:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbjDUV70 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Apr 2023 17:59:26 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5683CE7
        for <linux-wireless@vger.kernel.org>; Fri, 21 Apr 2023 14:59:25 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-2f4c431f69cso1377077f8f.0
        for <linux-wireless@vger.kernel.org>; Fri, 21 Apr 2023 14:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682114364; x=1684706364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BoKWYMR87LB14LU7FBVeEb7LIUWCOjPxH0KX+5TVraI=;
        b=jEXObke1ZWdJAJSDoP0USreul3cCM580kuRTR3SNBQlWVgWZoblGzUJ8dlBJFrdY9H
         ivTmEgljHSzvqZta115+b8mex0TyYglCJ2/RdEu899hdWlZt7XeGgz91HY7EAXJ4wyXZ
         LLcNmxvTP18fSh9R9mkJ5dtZUxSGYTPaz5NcYQpXodhyQDrkZ55QR0OkfarmkdcqeSVv
         D/Yyy91bqAmNBSrnZ4lCuCG9jxuCEDoraNEVm5XgK6MPYu8zO5BkTivvCJ5hZXGTCGBV
         aRRpU3yeatji3Ru7g9JmOXs2P2tB6+DV/kk+5FXKI2oxUdIWeH1jqgywwIVEK5FlGJT4
         F+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682114364; x=1684706364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BoKWYMR87LB14LU7FBVeEb7LIUWCOjPxH0KX+5TVraI=;
        b=H/jaW60uEiSvjaerD/UY8zSPFQYdWURYNyaZlH7wRrtx6C67azIRF2e5dUVxmjw5/y
         SM4C61SIfUAFntUljtnJs9zaHzSWecunxya8jL99/ZuAgGzp105yseWP3GHRuTcP/KUX
         ZRiUqe5ceG4LNTAwV0opV5XeoobIg5nPsQWrcBq9k+JTfqr2vyJx3/o8NLLxRYxQfA4H
         EkvD7x60C7YK4jaxdJY8ebi7qYnDTCUxk9pvv5pv9g/ULkiaDrSgwD8WQDjz/CVFYaGd
         mBbvbm73Cn6mbDFLXTuH3elnZ39Gxm6NBG27Om8UqFDiBA/8gpaDQSzaSy0Ht3YN1IsF
         QbSA==
X-Gm-Message-State: AAQBX9cDeOZAB2jBG4OxwQItjh5u/qnPW//NShJl87W5fTvPE3ieqZvp
        A2ZHPujrPnnPAT5cp32ntgRSFYqZInw8I5fAcDk=
X-Google-Smtp-Source: AKy350aBBAsf3C2Kswkc1v1ehgfJS66KOdcR6ZNcymGY1CuS6nqAvBCKqCpacQ0D7g7Pt6CUl6nhqhpjjEcvKLs4E/w=
X-Received: by 2002:adf:ec41:0:b0:2fb:599b:181e with SMTP id
 w1-20020adfec41000000b002fb599b181emr3964246wrn.63.1682114363533; Fri, 21 Apr
 2023 14:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <CALbLcfAXrHp4vsVGqU0nBdB_gFmKTKx0GcdrFJA7R_kodAy0Ew@mail.gmail.com>
 <bfe732f4-60dd-4d78-1259-5f9f6c11adbc@gmail.com> <CALbLcfB7cMctHC-Fv93z1WVCZkQ76uW2F_=P6rCW7ZSPXvmapw@mail.gmail.com>
 <2857f998-1b1a-e3c2-20fe-d03dadcf8f23@gmail.com> <CALbLcfCsyGzhvrqjSz37+7cLvc3rc4Y_kgspZV=kiPNs4TBE4w@mail.gmail.com>
 <CALbLcfBnF6njFMSfQk2TuOiZ3C3kHwqs4-c-MQGb72azzQ5sJA@mail.gmail.com>
 <38172c8e-d107-d96e-7292-09d0e3b061dd@gmail.com> <CALbLcfCHLU+zoFdTnTrJs22UUYwr2rETp5hqbv=NL352Qz-XgA@mail.gmail.com>
 <CALbLcfDZJmOyn-Gf24+9X-eHh3-3PY4_nP5soG3gHf_Vn85=EA@mail.gmail.com>
 <CALbLcfAiVgGi9iocEG4OfgET2XLDRq0dthbxDMP0vP3R6BBp_A@mail.gmail.com>
 <3ceecfc1-ab04-7d54-51bd-457a4708c0ac@gmail.com> <CALbLcfCpb8xbN+w2VvCZ6Gdr+L_ECH0UQsWZrpO1Hcpoef66UQ@mail.gmail.com>
 <8eaeb64e-3f7f-6752-4476-c0f0c88a008b@gmail.com>
In-Reply-To: <8eaeb64e-3f7f-6752-4476-c0f0c88a008b@gmail.com>
From:   Artem Makhutov <artem.makhutov@gmail.com>
Date:   Fri, 21 Apr 2023 23:59:12 +0200
Message-ID: <CALbLcfD7AmMG72-Qxafc9533OQVBCL=RLDycjUCV2MJ0DRN6nw@mail.gmail.com>
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

Am Do., 20. Apr. 2023 um 20:26 Uhr schrieb Bitterblue Smith
<rtl8821cerfe2@gmail.com>:
> So it's probably not related to the encryption.
>
> The v5.2.2.4 driver uses USB RX aggregation, unless you disabled it.
> We can try to use it in rtl8xxxu too, with this patch and the
> module parameter dma_aggregation=1:

I have tried it out. No changes. I will check the v5.2.2.4 tomorrow
again. Maybe it does not use HT mode so often and that's the reason
why the problem is not occuring that often...

As a workaround: What about checking the IP length field. If the
received packet is smaller by 4 bytes than what it should be then just
add extra 4 bytes at the end? Or does the MIC at the end have any
influence on anything?
