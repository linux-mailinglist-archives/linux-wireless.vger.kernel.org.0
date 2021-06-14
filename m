Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74383A67AF
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jun 2021 15:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbhFNNYT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Jun 2021 09:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbhFNNYR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Jun 2021 09:24:17 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF10C061574
        for <linux-wireless@vger.kernel.org>; Mon, 14 Jun 2021 06:22:01 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b11so46486058edy.4
        for <linux-wireless@vger.kernel.org>; Mon, 14 Jun 2021 06:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gzLXJsinZ/30/PhvJs3+ZVCBQVyiZKoc4Rf7ipm66V0=;
        b=PfMP1QLQAAzpvD/ZGLn1B9ODHNs0umz5LkxBb3A4HIMzqwikQ2eRYC7y2tpMUjPato
         G/W7jo//wUguYftaC3ZHcni31+Rzi6pQbmherJt/cw+R8iK6fhtxXhtvwKqzGTUYLXsX
         482n5X8+qlU5kJqx6rgm2LVaHafuXcJLQo0cU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gzLXJsinZ/30/PhvJs3+ZVCBQVyiZKoc4Rf7ipm66V0=;
        b=phhMkx+hwLCaac7VGA9CqNxuadJlzT88YQ7zQwdTE1mwqoUI8OmgYtPiolswdahM5D
         Lpv4JTxwJ7GsKvLDuSpQmV9+Kl47B4cbcXbv1Oo2vaz8ZP1kKVDUhTJm+9fAk7Plusg8
         1xWP8Ruk4cjlZFfDHsDk3VI1uJR0XNgE/Rj004W1CPwzwLmPJD9RHG/uSBePrMiJ6D68
         4efEG7ERL8AtW9L6CuB/u0c3VTDV316OPI+mcEYsvJz45ZeV70pC6l5RafsDmY4qVuef
         TgyShN6yLc3Ty1Ok4L11Ix+Xsl4yKZqtE4ag0vZvqtr48n/gLvlF1H2cIIzFqJHqawQw
         Qz6g==
X-Gm-Message-State: AOAM532hQ82piyMs4wxuX1VIBSLLyk27kkbGWyUatVm+ay0pffm61Tt2
        sD+/GIOn/zzLaNdDT5Fhi+eIMA==
X-Google-Smtp-Source: ABdhPJxz5ZzHEUl2V6/3xa9U2t9clB99MhMcYtaCm4DNXMMHE9yypsvTo1FVxr4+n5a5iYfstdhHzA==
X-Received: by 2002:aa7:c799:: with SMTP id n25mr16503045eds.16.1623676919676;
        Mon, 14 Jun 2021 06:21:59 -0700 (PDT)
Received: from [172.20.2.21] ([80.71.142.18])
        by smtp.gmail.com with ESMTPSA id i6sm7270780ejr.68.2021.06.14.06.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 06:21:59 -0700 (PDT)
Subject: Re: [PATCH 1/2] brcmfmac: fix setting of station info chains bitmask
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "SHA-cyfmac-dev-list@infineon.com" <SHA-cyfmac-dev-list@infineon.com>
References: <20210506132010.3964484-1-alsi@bang-olufsen.dk>
From:   =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alvin@pqrs.dk>
Message-ID: <ea5a0ce5-1bc9-774c-06be-6ecc284531c5@pqrs.dk>
Date:   Mon, 14 Jun 2021 15:21:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210506132010.3964484-1-alsi@bang-olufsen.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

On 5/6/21 3:20 PM, Alvin Šipraga wrote:
> The sinfo->chains field is a bitmask for filled values in chain_signal
> and chain_signal_avg, not a count. Treat it as such so that the driver
> can properly report per-chain RSSI information.
> 

<snip>

This is a gentle ping to see if these two patches got lost. I was told 
on another mailing list recently that mail sent from my work address is 
finding its way into peoples' junk folders.

I will resend the patches in the near future if I don't see any response 
here.

Thanks,
Alvin
