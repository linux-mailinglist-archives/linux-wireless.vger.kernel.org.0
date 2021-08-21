Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261F53F3C58
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Aug 2021 22:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhHUUDk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Aug 2021 16:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhHUUDk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Aug 2021 16:03:40 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352ABC061575;
        Sat, 21 Aug 2021 13:03:00 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u16so19373923wrn.5;
        Sat, 21 Aug 2021 13:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PFf7oO4eQliVPCuqPr65nAGjdn4BIKZ/Y6b3PBt2/Ys=;
        b=NH4YJFOlOEiRG08rjfAZMP/z1aHgsSkBHVyx/5v7mrEdmTp0mov+Ms7tshH8Ytjhap
         obZaHfw8vHLobVFy2bPxWIF3119d+VVdP6UuPKAvYFB8Tyij1mCGPNBKnVOdRS21Ll5w
         8O0EsDir+c3Xb6CwsdzEl5Z9biK0pzoT7bA0EuxFqjcFhg/qyraXl+pRYbqSt+67K7Ie
         ddWToC6zSKiMgWRDI3Sv7RZoUNsi0KcfABI4H0sybkC3hRwtverRIwi+fYz7QZN4+Raq
         VYJaIUj4Sdm1hiXuZGbFIOvEHwSJIICIOsX3C45SIxoWHns9ZIEmKyGNuxxqY9p+OGF4
         IyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PFf7oO4eQliVPCuqPr65nAGjdn4BIKZ/Y6b3PBt2/Ys=;
        b=XrAgTUDE1FRtT5/U/8EAit2ag+5QaNda7GOcJ8PHpaeu7hWYJCupSKkaHM9AH3AE7I
         RkQwtUiCrnfI+6aZWU8l/NsotVfGU+26/ReL6szIQODPF7IwNh7NQSaWCKzL+Cs6H+F6
         hMJ6PkZtqKbPyIBw7wYvICQp+xSy/UZuEOGBj2mOpkJaffGaQm2bOrwm5Ay+ncMHGq7h
         AXwNvuv3b/uO1UzsmTnUdAg5i9WyKQrqLXM1+ab9dEgLdw3DS1wK+osfAOz8FqcoiUqV
         NhopaaPfZSBotYytacpXByLdzklUQho5L6FqqIx638dLHJd043EA2WN4HSaZEZEr07NF
         ouuA==
X-Gm-Message-State: AOAM532yn4S5Kx4QuxlXQFHn3QSrSYw6WFcpI9BIj+24it8X6YY4hcqv
        lQw0srhrNh0yxptkuJj6oAw=
X-Google-Smtp-Source: ABdhPJwts5NwWCTpLwyBMv2GOfSSV2aoEnUUL9FanMTfYGBeXv6zmDqD4ZFyAHl7hNemSONnUd25Ew==
X-Received: by 2002:a5d:4ac5:: with SMTP id y5mr5347164wrs.125.1629576178747;
        Sat, 21 Aug 2021 13:02:58 -0700 (PDT)
Received: from debian64.daheim (p4fd09b15.dip0.t-ipconnect.de. [79.208.155.21])
        by smtp.gmail.com with ESMTPSA id o17sm2704044wrm.8.2021.08.21.13.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 13:02:58 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1])
        by debian64.daheim with esmtp (Exim 4.94.2)
        (envelope-from <chunkeey@gmail.com>)
        id 1mHXCf-000Dne-4d; Sat, 21 Aug 2021 22:02:57 +0200
Subject: Re: [RFC PATCH v1 1/3] dt-bindings:net:wireless:qca,ath9k: add
 nvmem-cells for calibration data
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com, Rob Herring <robh+dt@kernel.org>
References: <91e68ca7f65bee7197ed5829ef91bc526df16e8a.1629508039.git.chunkeey@gmail.com>
 <87ilzz9wzf.fsf@tynnyri.adurom.net>
From:   Christian Lamparter <chunkeey@gmail.com>
Message-ID: <cf25eb4a-197d-161a-5902-64830c383746@gmail.com>
Date:   Sat, 21 Aug 2021 22:02:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87ilzz9wzf.fsf@tynnyri.adurom.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 21/08/2021 07:40, Kalle Valo wrote:
> Christian Lamparter <chunkeey@gmail.com> writes:
> 
>> On most embedded ath9k devices (like range extenders,
>> routers, accesspoints, ...) the calibration data for
>> the RF/PHY is simply stored in a MTD partition named
>> "ART", "caldata"/"calibration", etc.
>>
>> Any mtd partition is automatically registered in the
>> nvmem subsystem. This makes is possible to fetch the
>> necessary calibration directly from there at the low
>> cost of adding nvmem cell information via the
>> device-tree or via similar means.
>>
>> This speeds up the driver's initialization a lot,
>> because the driver doesn't have to wait for userspace
>> to provide the data via helpers.
>>
>> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> 
> The series looks good to me. But I'm curious, why you marked this as
> RFC? Is there something controversial I missed?

yeah. Last night (it was already really late) I was tunnel-visioning
at the thought that device-tree binding update was a must there.
... And ath9k's qca,ath9k.txt is still in that .txt and not .yaml
format. So, I'm not sure if that file has to be converted first.
(I couldn't get Rob's tools to work. And without them, I've no idea
what error messages a converted .yaml of it will pop up)

However... since then, I had the change to re-read:
<https://www.kernel.org/doc/Documentation/nvmem/nvmem.txt>

And found that nvmem cells and lookups can be specified in
the old platform data way as well... So that binding patch
1/3 is optional.

So, yeah. If nobody has an comment until next week, I'll post this
series with only patches 2/3 and 3/3.

Cheers,
Christian
