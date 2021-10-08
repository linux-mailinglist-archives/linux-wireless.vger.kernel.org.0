Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639B8426822
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Oct 2021 12:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239816AbhJHKsp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Oct 2021 06:48:45 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:45574
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230075AbhJHKs2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Oct 2021 06:48:28 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2F1EC3FFD9
        for <linux-wireless@vger.kernel.org>; Fri,  8 Oct 2021 10:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633689993;
        bh=3cr8zX2dAw0svXJgbkiM05M80BJoKzttTWvDR09S5uE=;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=FKKCggq0k/F8FSv/8g+6vc3kYAI6ttzEBhmtZc5svjFKZRZHHNn2qqYB7SlrSJgqg
         /CQfg9sxQZKOj5IeDWdd851KE7sehE4BHy7G40GMadO6CBHYTJKV+2FUlBQ/MZLY4t
         wMoPVOyQgw0/mUGfTvkek5MYSe04y0XgnFPIM4aO0RefI3v1hyvZlV+K/r7+glhfZP
         Qs3cEjoU/dxBw4nM7cJiBHmMSiaBt6AgvqTSmAU8sG9xugmgwbF4dBrBVMYKIPBGAI
         uRifEvQHiTTCTFtJVnyaxvcznLPqExZOMW2WBCUDqwEjU4wHs2uwFiw8GuKNVj0ru0
         sVpU9TqYD/WeA==
Received: by mail-ed1-f69.google.com with SMTP id c7-20020a05640227c700b003d27f41f1d4so8764906ede.16
        for <linux-wireless@vger.kernel.org>; Fri, 08 Oct 2021 03:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3cr8zX2dAw0svXJgbkiM05M80BJoKzttTWvDR09S5uE=;
        b=IyLI0jioPtxBKYzhefQYU3H/RJKfHNHC5WczGNhlZQIE4IW7n9fzxMp7ZJQdvXBjmc
         2lXv9LyA60zsR30G78hbiU2X4Ou3X8dLhGLjkxJWxdkl3kGuTX65VGoytaTiZCSjHKqU
         5xLm4k+0DfAtEK8pa+n9C7vmOpRk0yU2OsM8p3VueoRYqvS0lYZRw5T4h7MSsBEx6YqT
         Nad1GM4z3+FLwROX2Lt2mpPSUedvqCZ4+5ajtd0m2wnA3BAZ0jfOmm5BtAxJOl1m2BaY
         YDDYqWi/UU2RSTwVjvnf/EzbVMHJAYEHoO3cdBCARzsezdF97vg+m+MBH9Ser2p0u7kc
         0cFQ==
X-Gm-Message-State: AOAM530+VK41hVD/ADkFxaLOqKKeJHN34O9ope4jADMFT7RRhWLj+Isg
        3aNgggF1ln9FAxmDbTEgp6LhtLEvrr1ek0t1wEjcviPq7Dg7ayFvbRcxc/uxhdBi3EoOInHx1Jl
        BIsTIRc+zr03QI8/urdjvFb8kZ2+SRNvClqe7J/U9mR49
X-Received: by 2002:aa7:cd90:: with SMTP id x16mr14673685edv.148.1633689992417;
        Fri, 08 Oct 2021 03:46:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCnuwvEp45zrynOfgAiJNTLTmF14F6ci1bs8PUwWz6ORr06pt51TTTkRL3uoEToyDmY4LVUw==
X-Received: by 2002:aa7:cd90:: with SMTP id x16mr14673660edv.148.1633689992271;
        Fri, 08 Oct 2021 03:46:32 -0700 (PDT)
Received: from [192.168.1.24] (xdsl-188-155-186-13.adslplus.ch. [188.155.186.13])
        by smtp.gmail.com with ESMTPSA id y4sm324097ejw.3.2021.10.08.03.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 03:46:31 -0700 (PDT)
Subject: Re: [RESEND PATCH v2 2/7] nfc: nci: replace GPLv2 boilerplate with
 SPDX
To:     Joe Perches <joe@perches.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
References: <20211007133021.32704-1-krzysztof.kozlowski@canonical.com>
 <20211007133021.32704-3-krzysztof.kozlowski@canonical.com>
 <34cc3eda06fa2e793c46b48ee734fd879e6f8ab1.camel@perches.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <9669a6cd-77de-ca0c-153c-75b531bd2490@canonical.com>
Date:   Fri, 8 Oct 2021 12:46:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <34cc3eda06fa2e793c46b48ee734fd879e6f8ab1.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 08/10/2021 12:33, Joe Perches wrote:
> On Thu, 2021-10-07 at 15:30 +0200, Krzysztof Kozlowski wrote:
>> Replace standard GPLv2 only license text with SPDX tag.
> 
> Nak
> 
> This is actually licenced with GPL-2.0-or-later
> 
>> diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
> []
>> @@ -1,20 +1,8 @@
>> +// SPDX-License-Identifier: GPL-2.0
> []
> You may use, redistribute and/or modify this File in
>> - * accordance with the terms and conditions of the License, a copy of which
>> - * is available on the worldwide web at
>> - * http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.
> 
> See the actual text at the old link which includes:
> 
>     This program is free software; you can redistribute it and/or modify
>     it under the terms of the GNU General Public License as published by
>     the Free Software Foundation; either version 2 of the License, or
>     (at your option) any later version.


Thanks Joe for checking this. Isn't this conflicting with first
paragraph in the source file:

  This software file (the "File") is distributed by Marvell
InternationalLtd. under the terms of the GNU General Public License
Version 2, June 1991(the "License").

This part does not specify "or later".

Best regards,
Krzysztof
