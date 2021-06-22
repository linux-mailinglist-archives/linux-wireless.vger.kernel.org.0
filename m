Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20CAD3B0360
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jun 2021 13:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhFVL45 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Jun 2021 07:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhFVL44 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Jun 2021 07:56:56 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E47FC061574
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jun 2021 04:54:40 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id hc16so5736440ejc.12
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jun 2021 04:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citymesh-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=1mdmR9EFUhebYwn1SKATLexxSloL6TRa5BqLbQ7s0xM=;
        b=BTxtwdf4Rdto8tc/wskCvLVLV+QAxq+4W69NZqnCHzIhfeYXltmR7/NQP3rFSpuosi
         QJ/D+ZM/YjH8DrrwFxskLiu1sANl4MVv9jtQDycDaVQBlCBK6+ieIt/waP97o8NboLsP
         3oR7stVGGp3foKIB9+wC0ceNN9nTCESuu9RLqtiIXn3gSETyth1IHLi9QqPdWSkhzLDT
         aPRJjlR/u1hBzLapwJI2H2r6O2hKmgV3c4f793HxMdrZ/eJ409XnDJEn3sqG2FUZDgDc
         eXy1bH+HALXnFVvqrLegsQs+m/k+c3PvZYk+D0wQw4FAxt/mL7T3UBHlrEPLsB/9fWzE
         cKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1mdmR9EFUhebYwn1SKATLexxSloL6TRa5BqLbQ7s0xM=;
        b=H5w12D9KcrdCmzOHbQ124wqWQO/4FVc51DKZEoRICGJS8Kh271Y05M95m38HrBaPo6
         2aazZLG/yvs9e74IHkHgll2TeY8c3CvcZCjkbzN4AVPrwzmQUvzNRHsl/JCRuQz0uGxT
         IciGy6tdgF+aRx4TSbDTZc+igrxegMxGrh5ayqPphtWSaOzy38mIgXd81uG7OcyoBksD
         eV7sRKktMI+D2SSeEkx0YG6InTPe7zK7Bv+06WXELUUujSl7/LLwxy4Yv6eKARc1jDr6
         YEDRI9BPwN5PZGZoLnZW272DVt7lQDv0+hGScHX5mlquwPXvoFJxQ9MxiLu/Qs0f7yZ0
         LrqQ==
X-Gm-Message-State: AOAM533Wq6MxK9bJa7jJIQObDX7Bk6g2SOqk1rYnMzmIY9Uua4tqt+g7
        0DLTo7hDX523vZ3DBfUBS69yB1JHyzFDEroQ
X-Google-Smtp-Source: ABdhPJxqXOsHFWsZhzFGFyn3z17OUHEPdI4S+mgd4MiToo8hruPolWQ7HWXUK1ZMZfFHUTBD7hZKKQ==
X-Received: by 2002:a17:906:744:: with SMTP id z4mr3636146ejb.347.1624362878876;
        Tue, 22 Jun 2021 04:54:38 -0700 (PDT)
Received: from [192.168.5.225] (178-116-168-169.access.telenet.be. [178.116.168.169])
        by smtp.gmail.com with ESMTPSA id o20sm11924281eds.20.2021.06.22.04.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 04:54:38 -0700 (PDT)
Subject: Re: [Bugreport] ath9k dynack not working/low performance on 5 & 10MHz
 Bandwidth
To:     Sebastian Gottschall <s.gottschall@dd-wrt.com>,
        Petrosilius <petrosilius@posteo.de>,
        linux-wireless@vger.kernel.org
References: <dd49d9f7-db40-4ab7-f24d-6ab4bbd0bb54@posteo.de>
 <fd620847-9786-07d2-23be-dba4cedc9089@citymesh.com>
 <2ffcf571-7068-c06f-3879-d02eacdc4895@posteo.de>
 <b98ffbe2-7995-9783-c74f-af1b5f32f575@dd-wrt.com>
From:   Koen Vandeputte <koen.vandeputte@citymesh.com>
Message-ID: <9c8ee40d-6a2b-8604-6a75-164f8b9028c7@citymesh.com>
Date:   Tue, 22 Jun 2021 13:54:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <b98ffbe2-7995-9783-c74f-af1b5f32f575@dd-wrt.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 22.06.21 12:40, Sebastian Gottschall wrote:
> just some cents from me. i modified the algorithm a long time ago 
> since the dynack way ath9k was going was not correct.
> i will look if it can make a patch out of my experiences, but dont 
> expect it within the next 2 days.
>
Can you elaborate (next to the patch) on *why* dynack was going the 
wrong way?
New insights are always welcome :)

Thanks,

Koen


