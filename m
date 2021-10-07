Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067C9425396
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Oct 2021 15:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240816AbhJGND1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Oct 2021 09:03:27 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35306
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233128AbhJGNDW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Oct 2021 09:03:22 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 01E0A3FFEC
        for <linux-wireless@vger.kernel.org>; Thu,  7 Oct 2021 13:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633611688;
        bh=CWLF3Mwbuv27wfSQ2ZR3naLE1cJ0EA/H/ZCKfT8DDNk=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=BsodDtVQGV8K4eEwMYWFRcJL1ZvK1SGo4DhS1Sp1is4HpYjLtKKXgFHj2lkWkq6ZE
         9nQK9ayArUkftG39EUfyvd+oc3DX/sGcAdylAiXpWXydfapb/c6Eq5BHaJzy5uNPhi
         bdNvNgDg0ILK4WunmsWX+VZG8fYley5w8419gIPjjmggbj/jckB7z0wa7Aw6SgqbEj
         XmeOKsKUuv/DldtP9UzBPeN3ZWPJzTduCT7dLuuf6O1yluxtoxJbUpASyl5Q0U8gN2
         0J1PRuGBQ/97ylDOR2OpdsteohUS2K1nwkiaddylkuRH202+Txku9NpzFWDIwJqWmR
         NSEzBZ9wCB17g==
Received: by mail-ed1-f72.google.com with SMTP id c8-20020a50d648000000b003daa53c7518so5762178edj.21
        for <linux-wireless@vger.kernel.org>; Thu, 07 Oct 2021 06:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CWLF3Mwbuv27wfSQ2ZR3naLE1cJ0EA/H/ZCKfT8DDNk=;
        b=MeCDTTW22mhDWarrERR5G8t0eAaAmGwzg1Aram3B12A4YQGpYL4Aihx265o9FWN82Z
         2IBaXTJFRaowv8N6LJm31tM70AKexgJ5hvV9wZJI06uK3G9qJ01Bfb1HKwLDpc97u6GP
         L+vuO1DWp6Ls18WMPB/cqatSbS6GpdB/rd2XklLE5aWJL7m4hAlN//jGh2sPxkeaY95r
         xQrI+Q818J5J2zJJ3PleFq6zdHxYMKeBi29hSA1IJ9k/0ONUlAcJgyrekDLf4Cj121Nm
         EuIlC0MEGp1Amgzw10zCm3B8R+yJw3HeQCOpUPjRfjXbX1rv/xQL/6kFtYOBDX6gpZHk
         gWVA==
X-Gm-Message-State: AOAM530rZwopEYh5OlDSyTpgGZNRYxt5yiruGyRV/9U+CSi+25T/S0be
        H/aq2Vqdd1Z5pjbcvn94pe1wHc9vzGdi9qe8jOx1mz6jK9RqqFFOyST0dW7VmiLVVdTDrCSYXiS
        cng9v9J1MlMKXIRtX+2kWqRH5QOn/by5IMWNyMXOn14uE
X-Received: by 2002:a50:d98d:: with SMTP id w13mr6249815edj.51.1633611687330;
        Thu, 07 Oct 2021 06:01:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsGkLjq/HVHDfN4bAucyZ/pV1jwbbBY9M9ehNU17nvM5neTPUW/YNaP9/xGkH5n1G9eNdJaw==
X-Received: by 2002:a50:d98d:: with SMTP id w13mr6249781edj.51.1633611687059;
        Thu, 07 Oct 2021 06:01:27 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-186-13.adslplus.ch. [188.155.186.13])
        by smtp.gmail.com with ESMTPSA id m23sm2258674eja.6.2021.10.07.06.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 06:01:26 -0700 (PDT)
Subject: Re: [PATCH v2 12/15] nfc: trf7970a: drop unneeded debug prints
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Krzysztof Opasiak <k.opasiak@samsung.com>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Greer <mgreer@animalcreek.com>,
        linux-wireless@vger.kernel.org
References: <20210913132035.242870-1-krzysztof.kozlowski@canonical.com>
 <20210913132035.242870-13-krzysztof.kozlowski@canonical.com>
 <20210913165757.GA1309751@animalcreek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <47eae95d-d34c-1fa7-fea9-6e77a130aa97@canonical.com>
Date:   Thu, 7 Oct 2021 15:01:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210913165757.GA1309751@animalcreek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 13/09/2021 18:57, Mark Greer wrote:
> On Mon, Sep 13, 2021 at 03:20:32PM +0200, Krzysztof Kozlowski wrote:
>> ftrace is a preferred and standard way to debug entering and exiting
>> functions so drop useless debug prints.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  drivers/nfc/trf7970a.c | 8 --------
>>  1 file changed, 8 deletions(-)
>>

Hi Jakub and David,

Some patches from this set were applied, but rest was not. All of them
are however marked as accepted:
https://patchwork.kernel.org/project/netdevbpf/list/?series=545829&state=*

I think something got lost. Could you apply missing ones or maybe I
should rebase and resend?


Best regards,
Krzysztof
