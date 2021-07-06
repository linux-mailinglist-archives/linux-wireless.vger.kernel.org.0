Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E19B3BDB4A
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jul 2021 18:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhGFQZS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jul 2021 12:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhGFQZR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jul 2021 12:25:17 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A15C061574
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jul 2021 09:22:38 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 10so10420326oiq.9
        for <linux-wireless@vger.kernel.org>; Tue, 06 Jul 2021 09:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VtZ9Q3yFF0GFwWBdUVaxxR1vNbne6fIYDP1TfWNhy8U=;
        b=urY28lS1r+pHasdn7ATpljfMFtxCB2t38bDZOL3HF95LNXh5TsejnBaWhi+mO2lgAn
         IKj7E/XslM5nybGSOmDux2dMvDgB2NC6JlRxRsE/Ns4c7Bg5q+dgfzGiOOLLeSddkZwf
         sTmbceEuY35HIynD+Ot9oJT7NAV7DTQZ0H2F4N4mm4w1UXEB/rE/pMtAvah0PIfFCl12
         1Yo/BWBwEORbs2TdJe9fjKvJZ/dJX98xLNUJDgdQdWC4AmfEvmpNf8WhGwxi23TH433i
         EHoMrq3R1ignBgyyirr0muUZNwnNvJTMLdURHJVYvjCauJuQJa4JGXOA5zkLVIn4MVOy
         ysZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VtZ9Q3yFF0GFwWBdUVaxxR1vNbne6fIYDP1TfWNhy8U=;
        b=JXMdkXh4laHo6GkEavotXKh3jWGiq+B23MjFeXhHTbCVo4DJyDJfjb2LpC+WHOgY/J
         p1hIAYW5MbJXffEoxenE4uXYQ2JlVTdLY+V4kKaFOrtnfX2TgjAGa7qkjJy/suyShAk4
         yb+ukcMFEU7U3Y80WCIfTH4TUyvWLGptLI8twoqB3zBA02/tNLLqvWTw0X/77s/3ei7f
         7po4wgWdoPrAVZw5aa/YqzJmc1GMowZKYyamhK6fyoFPd/eRX/2lLSzj7te4Vsqq0TqN
         loOviacDewKobnKm0GqOxTq0olYxnPDaBehD/8M0wu1VjAdBbsS75rf7F7IQUYU9FKST
         N+5w==
X-Gm-Message-State: AOAM533qXWEuHsww9XXOvjN1E6gP9ZCV0iiCPptjIvw96qeSHFSL1Gau
        L6plG7TYV3GrjTvz+go9sMWGiTls454=
X-Google-Smtp-Source: ABdhPJxi69OSWIzWH9BCHdv7Nj79BwQOwkulXZnUqgUPn/qK7pIfJf93rkEXGC7w51RuJfZMY8C5Dg==
X-Received: by 2002:aca:ea42:: with SMTP id i63mr14882839oih.152.1625588557578;
        Tue, 06 Jul 2021 09:22:37 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-246-181.kc.res.rr.com. [24.31.246.181])
        by smtp.gmail.com with ESMTPSA id r204sm3412514oih.11.2021.07.06.09.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 09:22:37 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: rtw89: product id 0xa85a support on Linux?
To:     Pkshih <pkshih@realtek.com>,
        "brewer.doug@gmail.com" <brewer.doug@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20210704143510.GA5787@www.com>
 <8e844938463c470d9669247227db9c30@realtek.com>
 <CAG0V13RrjFP=+X32G+3ogo2LJbwcrZyoDeZ7LLBbVfR1JEWUyg@mail.gmail.com>
 <6b0788a110ef6382c803ccf18b27116f4634f3ba.camel@realtek.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <6cc6b22e-4b99-841b-3ef6-5d698a2fedea@lwfinger.net>
Date:   Tue, 6 Jul 2021 11:22:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <6b0788a110ef6382c803ccf18b27116f4634f3ba.camel@realtek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/5/21 10:10 PM, Pkshih wrote:
> 
> Before trying new patch, please upgrade your firmware to v0.13.24.0
> that you can download it via my github:
> 
> https://github.com/pkshih/linux-firmware/blob/a5b79c4790da3eb3690e23554225ef8db464f2c6/rtw89/rtw8852a_fw.bin
> 
> Then, check kernel log to confirm the version like dmesg you mentioned.
> 
> 
> The path of the attachment patch isn't full path, so please apply
> it with specified path drivers/net/wireless/realtek/rtw89/

I have applied the patch and new firmware to https://github.com/lwfinger/rtw89.git.

Larry
