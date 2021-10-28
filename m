Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672D743E98A
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Oct 2021 22:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhJ1UcC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Oct 2021 16:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhJ1UcB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Oct 2021 16:32:01 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CCAC061745
        for <linux-wireless@vger.kernel.org>; Thu, 28 Oct 2021 13:29:34 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id z11-20020a1c7e0b000000b0030db7b70b6bso10554968wmc.1
        for <linux-wireless@vger.kernel.org>; Thu, 28 Oct 2021 13:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UNdKYXhS7qV0l6wjFDAccaOC7L4yMliNcw90vERiz8Q=;
        b=maxwUy6iRwTx4f2NDKdA3IJIrec8wTUIllsMDdNTPs6/SA8sJ+Fdoo5Y363JbyUzoH
         RYHbMOaxAWzycLypTYL9pNdNo9G7qY3EzILR8mb+67aHcu9qFbldb7LEZsFyxrDUHFO9
         D9I+0WUG194gfIPhyjmfRgoXEvU3bdbxEH7x5elx99La2MCPTVwPpmHzL0NCzxW0Gef1
         DzwSf+d+ejquOursnI06rCrFG889ghsqK3ywx9BR3/VMXHH2yqwpvAkp/4G4+sNppu/1
         uMJXUN/5HfJMnbzvjm7P812Z5q6Q0dzZ5yCwjr/Mfv1BMuyj9R564Z8l1kLIq0rOcvmS
         aBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UNdKYXhS7qV0l6wjFDAccaOC7L4yMliNcw90vERiz8Q=;
        b=axaUJgFCHfk0shj/GzbsKWqkzC4oMg8qVNr5QEOOLeNeffqdX52/DgZ/1b3N24II2T
         WE8aNqVHJELPtD2GXykIIFY7EeyfFE7mdZFRr0mK9/+zXsc9rvsXnIt4ndUoF8rQcBsi
         +M6oAECC4Qg3nFyShUY4HZGeT1LSRBabT7J2j6mWQvlYKypuZZIaxsb2qtdjSNrGRJQz
         0UWRSO9YP8pnJ2jKLD4eQrBXPrpxeWm/P323Mz9kwKe0bAnHoePcwMghE+sdD8WuMy3+
         OWqK+3K9BSnTs7NtPhgr1Bq3T+JPpAwy2+rClI4MoULv7WlIYFUYWNcyRHYj3xWINykr
         EcBw==
X-Gm-Message-State: AOAM530CBdcZpK9YweJEBOF98GM4nVNM8WhOGxl9X93PFGqZGjIZEVF2
        d9x00rHTgSLfdwldYG8mfUoKeXxwchU=
X-Google-Smtp-Source: ABdhPJwEzpK17orfuCeujJO9/8hy/wGOYVfWtt+rhkncma8YjBkMWhivmgTzWzhjPjN+OL5XnxhJvQ==
X-Received: by 2002:a1c:a405:: with SMTP id n5mr6636097wme.49.1635452972946;
        Thu, 28 Oct 2021 13:29:32 -0700 (PDT)
Received: from debian64.daheim (p5b0d7857.dip0.t-ipconnect.de. [91.13.120.87])
        by smtp.gmail.com with ESMTPSA id l20sm8476656wmq.42.2021.10.28.13.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 13:29:32 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1])
        by debian64.daheim with esmtp (Exim 4.95)
        (envelope-from <chunkeey@gmail.com>)
        id 1mgA8q-000CCq-U7;
        Thu, 28 Oct 2021 22:29:31 +0200
Message-ID: <e6936f55-6ca7-209c-8c3f-5eeae879c9dc@gmail.com>
Date:   Thu, 28 Oct 2021 22:29:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: new "[1/2] ath10k: Try to get mac-address from dts"
Content-Language: en-US
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org
References: <20211016234609.1568317-1-chunkeey@gmail.com>
 <87ee855xwa.fsf@codeaurora.org>
 <3a8840ea-1499-950b-fb44-7546a32c586f@gmail.com>
 <875yth5pt3.fsf@codeaurora.org>
 <3aebb711-dc45-3cbf-43cb-12f59909baf0@gmail.com>
 <CA+_ehUxFDUE6BU3TbngKOA-VKCBkTnpOv7ibTjtpur37KrQ4Jw@mail.gmail.com>
From:   Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <CA+_ehUxFDUE6BU3TbngKOA-VKCBkTnpOv7ibTjtpur37KrQ4Jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 28/10/2021 20:57, Ansuel Smith wrote:
>>
>> The "[1/2] ath10k: Try to get mac-address from dts" patch
>> will need a respin, so it can apply cleanly.
>>
>> Is Anyone interested? If not, I can take a shot at it on Saturday.
>>
> 
> A refreshed patch is applied to atk10k-ct repo so it would be good to
> have the same patch on normal ath10k. Many router would benefit
> from that.

Found it!

https://github.com/greearb/ath10k-ct/commit/e6a7d5b5b834737cd12e357b5efdc2e42d923bf6.patch

Hmm, Author is now "Ben" and the whole commit message is gone.
Now, adding the commit message back from your original patch
is not a problem, but the missing "Signed-off-by" from him and
you might be.
...

But then, do we need it? Because there might be the option to extend
device_get_mac_address() instead?! ...

>> (There's the tiny question of that device_get_mac_address() which
>> ath10k currently uses. It looks a lot like of_get_mac_address() too!
>> but with extra ACPI (through FWNODE-which also includes OF), but
>> without NVMEM.)
>>
>> Cheers,
>> Christian
> 
> About this I never manage to understand the priority... Should ACPI
> variant have priority and fallback to the OF api or the OF api should
> overwrite any mac if a nvmem cell is found?

Hmm, from what I know the device_/fwnode_*() functions are just wrappers
for either ACPI (on systems with ACPI - x86 and ARM) or OF (on systems with
Device-tree) functions... (There is also "software nodes", I think these are
the lookupd stuff that came up recently with APU2 + MX100)

This confused me too. But I might be able to show this in the context of
ath10k-ct's current ath10k_core_probe_fw() and this threads new subject:

<https://github.com/greearb/ath10k-ct/blob/e6a7d5b5b834737cd12e357b5efdc2e42d923bf6/ath10k-5.15/core.c#L4044>
copied in here for a better reading experience:
|
|device_get_mac_address(ar->dev, ar->mac_addr, sizeof(ar->mac_addr));
|
|/* Try to get mac address from device node (from nvmem cell) */
|of_get_mac_address(ar->dev->of_node, ar->mac_addr);
|

The device_get_mac_address() will on OF platforms essentially check and
process the same "mac-address", "local-mac-address" and "address" OF
properties of the same device-tree node as the following of_get_mac_address()
will do. There's no priority.

I think now, that instead of adding of_get_mac_address() into ath10k,
the time might be better spent asking what's the goal for device_get_mac_address() is.
Is device_get_mac_address() poised to usurp of_get_mac_address()? And if it
is: Should it be extended to get that "mac-address in nvmem-cell" as well?
Because then we don't really need to touch ath10k at all (well, maybe except
for -EPROBE_DEFER handling).

Cheers,
Christian
