Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607FF43E8A1
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Oct 2021 20:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhJ1Swo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Oct 2021 14:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbhJ1Swo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Oct 2021 14:52:44 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DF3C061570
        for <linux-wireless@vger.kernel.org>; Thu, 28 Oct 2021 11:50:16 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m42so6674041wms.2
        for <linux-wireless@vger.kernel.org>; Thu, 28 Oct 2021 11:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=r6DzYL06+c7rlETep7KeTkbRa0OqD6hohbE6YOoJ33U=;
        b=ECziJepm37iXy00W7IOLUXMPeMYSWxmUnAUS5+VVMNesBi3R74sP8SOFPZJKnsdJBA
         tHpICxn4a0GfjnjWFxGXS+EEdZxlkEbF/gqlHYTCwz3dEi02KKauGYDEeCq8TQ2gKjD3
         GpOMCa1POOVwRQnfXPJr/+H59RWZ/1iyoLt2ui6jsyKnbNVh5PRQw7W5ly5XTOG3Pdm4
         v74b3zx1KbXTLIDfWAos2mTibbz+IY31TOGNtAI5EX2zAwAJhlQR6zrDPbBlN4KmI7s2
         Ob11h35aM/W05r+lYM3aKgdmyy+/bOe++5nFhNHVvECN2rL9jj+K4+UP9ocFc9ypCdFc
         FVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r6DzYL06+c7rlETep7KeTkbRa0OqD6hohbE6YOoJ33U=;
        b=1ZrXw6sjTx1dZNFeq1G0k4Mu+MKUkLxA09SHC+67Dgdtl3a/9Uv+dcCjV/VjGmBOPw
         Ta4vv3TKQifaxfE7c4/sc3l2E/R6LTFALGdVNtWaKrQOjR6oQsaNvEDq8eNBWVzsEti/
         vurXSul/ogBDyc1YaRxZRJkwVqHCA2k7MMS0X9cB8bixEKCHKQ8U+1yqoVkInEIHPQet
         gQqJolAgKTgjaEMwsgUXrAwtVi3uYDo/LFevQrqlH1kZMMHoa0WRVRmctdK1Tw/lr6b5
         0KCEIHvgCPpni/Rtixfm5ngHz6x/zOul5TEkmn6rqp56jEjsQ7A70A2f7pJw+7bpObNg
         MooA==
X-Gm-Message-State: AOAM5327c9om/JClo5NsvDMViQAwEuwf8wO6Retk30q9p0M9k5VboAYX
        nLw2gQLPB9NvtSToMTH4YiOROYmdLZg=
X-Google-Smtp-Source: ABdhPJxkGNHkV76AX3Kld0dxp1OA31WDo8PiiXoLkeqRyC1CpY/nEHlbcbS/OtYavgReiUi+9ntofw==
X-Received: by 2002:a05:600c:35d0:: with SMTP id r16mr14356355wmq.97.1635447015112;
        Thu, 28 Oct 2021 11:50:15 -0700 (PDT)
Received: from debian64.daheim (p5b0d7857.dip0.t-ipconnect.de. [91.13.120.87])
        by smtp.gmail.com with ESMTPSA id t6sm2596002wmq.31.2021.10.28.11.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 11:50:14 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1])
        by debian64.daheim with esmtp (Exim 4.95)
        (envelope-from <chunkeey@gmail.com>)
        id 1mg8al-000BEt-1J;
        Thu, 28 Oct 2021 20:50:14 +0200
Message-ID: <3aebb711-dc45-3cbf-43cb-12f59909baf0@gmail.com>
Date:   Thu, 28 Oct 2021 20:50:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2] ath10k: fetch (pre-)calibration data via nvmem
 subsystem
Content-Language: en-US
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Ansuel Smith <ansuelsmth@gmail.com>
References: <20211016234609.1568317-1-chunkeey@gmail.com>
 <87ee855xwa.fsf@codeaurora.org>
 <3a8840ea-1499-950b-fb44-7546a32c586f@gmail.com>
 <875yth5pt3.fsf@codeaurora.org>
From:   Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <875yth5pt3.fsf@codeaurora.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 28/10/2021 13:52, Kalle Valo wrote:

>>>>
>>>> v1 -> v2:
>>>> 	- use %zu and %u in the format string for size_t
>>>>             and u32 types (catched by the "kernel test robot").
>>>> 	- reworded commit message + successfully tested on QCA9880v2
>>>>
>>>> I placed the nvmem code in front of the current "file" method
>>>> (firmware_request). Reason is that this makes it easier for me
>>>> to test it. If needed it can be moved to a different place.
>>>
>>> Looks good to me. Before I apply this, I want to mention to that I have
>>> had a long in my deferred queue related two patchsets:
>>
>>
>>> https://patchwork.kernel.org/project/linux-wireless/patch/20200927192515.86-1-ansuelsmth@gmail.com/
>>> https://patchwork.kernel.org/project/linux-wireless/patch/20200927192515.86-2-ansuelsmth@gmail.com/
>>
>> Oh ok, serves me right for not looking thoroughly googling this first.
>> Alban Bedel and Ansuel's work made this nvmem all possible. And indeed,
>> the second patch here looks eerie similar.
>>
>> Do you want to go with his two patches instead?
> 
> I would prefer to take your patch.

Ok.

>> I'll change mine, so it just consists of the cal_mode for the older
>> QCA9880v2,QCA9887 and add the -EPROBE_DEFER handling. This
>> -EPROBE_DEFER only ever comes up with the Meraki gear. This is because
>> Meraki likes putting the MACs-Values into SoC-connected AT24
>> eeproms-chips. Everyone else just have them in a proper FLASH
>> partition. Though, this's usually nothing more than adding the
>> following line:
>>
>> if (ret == -EPROBER_DEFER)
>> 	return ret;
> 
> So I'll drop this version and wait for v3?

I guess that "waiting for v3" won't be necessary in this case.
If @Ansuel doesn't voice any concerns, you might as well just
apply v2.

The "[1/2] ath10k: Try to get mac-address from dts" patch
will need a respin, so it can apply cleanly.

Is Anyone interested? If not, I can take a shot at it on Saturday.

(There's the tiny question of that device_get_mac_address() which
ath10k currently uses. It looks a lot like of_get_mac_address() too!
but with extra ACPI (through FWNODE-which also includes OF), but
without NVMEM.)

Cheers,
Christian
