Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344A06ED5B6
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Apr 2023 21:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjDXT5o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Apr 2023 15:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbjDXT5d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Apr 2023 15:57:33 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13A97A92
        for <linux-wireless@vger.kernel.org>; Mon, 24 Apr 2023 12:57:09 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f1958d3a53so34567075e9.0
        for <linux-wireless@vger.kernel.org>; Mon, 24 Apr 2023 12:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682366216; x=1684958216;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VJHZDcWYR1IAdiqMKhTJtEUyqYgMG6b+W3Qb/8fTQJE=;
        b=k40k4GtQJZfFAa0AdZ5r+9BfMIp6lpOKWD+bEXbe8TfMB7egfAPncW1zAoq1h7a9t/
         /E5XOvubuXJRqsHe2TtWLv/WtEgcSv7Fw3EKIRg/Eh5/E7CDKlLrSQzMqJdwjp6HrTq/
         y6v+SZo7r8SUHPfLs+kVQiOZhz+qpEmaUA3kJjSz3l3Xg1JQnqO/WyJgtudrUSZGldoK
         uwJ8tMVqF/I1Zn+VQkUYplvv3Le/QuPJx7bQn7hHeKoqHDx4TQ+muIyvE2Gb39swv/fi
         6ECrnvxek7b79Jo9JD8ODzKgJEG0Ifb5cK+8gOUJZLyKT5modNTWxS6Gy5+7xKnn4/jh
         mrzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682366216; x=1684958216;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VJHZDcWYR1IAdiqMKhTJtEUyqYgMG6b+W3Qb/8fTQJE=;
        b=JF01uuCvU3+kL7hmPzGOhEUShEAk1PoZfbSETIC71q1dKjlRGJqSrul6L1OvLy/v6R
         9mUTp+En7RDfWG9qP4QlZLOLIQaxHG5bBbOXEJNZrpWTMkxRuTosvNjerNvhbEoPH5PI
         Akh/8X7f1H8orHG9ClOWETIyHSyzWz4l0id68kQbXlJtvhhpupcpBpiGTtII+a3vQdn4
         mglIVWORIbbFAn3lsAqYR2TGguafYcQ2bmKGsog3/Eh5pNn74qAkJEyn4iicAq2IwgIW
         EsDa/r7PSZE9kDl4wdedPnmwqywhSjKC7gDk2j9YpmnHyyalF9bt/LTIdatsviRyVHsg
         1xvg==
X-Gm-Message-State: AAQBX9f6F5GNSA973mlufPaRayTGCSXRd6eYUm9tfNMM35uRwr7FdWDD
        EWBli9BUcDb+zvyT5FdkJcSriILEUVc=
X-Google-Smtp-Source: AKy350Z/Qmtth+DKy698dODCBTTPZ9tS0D8pfTWZ9UmB/1AV79yQ9QoSAMUS1xyl/DQES4vKkUV8LQ==
X-Received: by 2002:adf:f710:0:b0:2dc:cb11:bed3 with SMTP id r16-20020adff710000000b002dccb11bed3mr9898629wrp.68.1682366216349;
        Mon, 24 Apr 2023 12:56:56 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id g18-20020adff3d2000000b002fb2782219esm11521769wrp.3.2023.04.24.12.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 12:56:55 -0700 (PDT)
Message-ID: <2a679614-c964-dc3f-c987-6c7ee03923a0@gmail.com>
Date:   Mon, 24 Apr 2023 22:56:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: RTL8188EU (LogiLink WL0151A) - Malformed packets
Content-Language: en-US
To:     Artem Makhutov <artem.makhutov@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <CALbLcfAXrHp4vsVGqU0nBdB_gFmKTKx0GcdrFJA7R_kodAy0Ew@mail.gmail.com>
 <bfe732f4-60dd-4d78-1259-5f9f6c11adbc@gmail.com>
 <CALbLcfB7cMctHC-Fv93z1WVCZkQ76uW2F_=P6rCW7ZSPXvmapw@mail.gmail.com>
 <2857f998-1b1a-e3c2-20fe-d03dadcf8f23@gmail.com>
 <CALbLcfCsyGzhvrqjSz37+7cLvc3rc4Y_kgspZV=kiPNs4TBE4w@mail.gmail.com>
 <CALbLcfBnF6njFMSfQk2TuOiZ3C3kHwqs4-c-MQGb72azzQ5sJA@mail.gmail.com>
 <38172c8e-d107-d96e-7292-09d0e3b061dd@gmail.com>
 <CALbLcfCHLU+zoFdTnTrJs22UUYwr2rETp5hqbv=NL352Qz-XgA@mail.gmail.com>
 <CALbLcfDZJmOyn-Gf24+9X-eHh3-3PY4_nP5soG3gHf_Vn85=EA@mail.gmail.com>
 <CALbLcfAiVgGi9iocEG4OfgET2XLDRq0dthbxDMP0vP3R6BBp_A@mail.gmail.com>
 <3ceecfc1-ab04-7d54-51bd-457a4708c0ac@gmail.com>
 <CALbLcfCpb8xbN+w2VvCZ6Gdr+L_ECH0UQsWZrpO1Hcpoef66UQ@mail.gmail.com>
 <8eaeb64e-3f7f-6752-4476-c0f0c88a008b@gmail.com>
 <CALbLcfD7AmMG72-Qxafc9533OQVBCL=RLDycjUCV2MJ0DRN6nw@mail.gmail.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <CALbLcfD7AmMG72-Qxafc9533OQVBCL=RLDycjUCV2MJ0DRN6nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 22/04/2023 00:59, Artem Makhutov wrote:
> Hi,
> 
> Am Do., 20. Apr. 2023 um 20:26 Uhr schrieb Bitterblue Smith
> <rtl8821cerfe2@gmail.com>:
>> So it's probably not related to the encryption.
>>
>> The v5.2.2.4 driver uses USB RX aggregation, unless you disabled it.
>> We can try to use it in rtl8xxxu too, with this patch and the
>> module parameter dma_aggregation=1:
> 
> I have tried it out. No changes. I will check the v5.2.2.4 tomorrow
> again. Maybe it does not use HT mode so often and that's the reason
> why the problem is not occuring that often...
> 

That's fortunate because RX aggregation makes the download speed
a lot worse for some reason.

> As a workaround: What about checking the IP length field. If the
> received packet is smaller by 4 bytes than what it should be then just
> add extra 4 bytes at the end? Or does the MIC at the end have any
> influence on anything?

That should work, but it's ugly.

If the router lets you change the MTU, does it help to make it smaller?

Do you have the problem with the v5.13.3 driver? If it works (other
than completely dying after a while) we should see what it does
differently compared to the v5.2.2.4 driver.

I don't have other ideas.
