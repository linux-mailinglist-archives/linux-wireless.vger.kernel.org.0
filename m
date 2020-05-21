Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7111DD9A7
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2020 23:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbgEUVro (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 May 2020 17:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729370AbgEUVrn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 May 2020 17:47:43 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75F7C061A0E
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 14:47:43 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id u190so1747633ooa.10
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 14:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T2yhvBq7ofDzMuFj4VZNUtemkK2Wi4xQKWpsyTkcffw=;
        b=aeiYUNKp+K5GF3K4VLIeedQwGFSAZY1D3xFoUPO2L/V8cKmpT1hDHZ1BqxljP12y41
         1BTIYioeSqGPp12K8ZVaIPaoiIeHLYyY7Q/FZdi804D644ajjPdOivXF4u8/PHbh/ulw
         69gUfJQb2sN0UN7rANBdbKVOt3sFBi49xBV4ZuCHjMXoqYiIdbWbka/kvrEdOKoJZx0J
         klMTRXLcbO9gW1Qo/lzoH3JvRQzkesw/BwZsfrKCeRBmdSTsiLfyi32KiOKTst/KYMQm
         rwL4UogudY5gnTE+jEiSFqx1XytCalvUNSzkZF03EaEUaoW4U9iOXkGaU8j++/BjGul9
         BpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T2yhvBq7ofDzMuFj4VZNUtemkK2Wi4xQKWpsyTkcffw=;
        b=quqfBQAycZy48O/4CzfoGvziXh55iAvVlWWV09xAMQwds00IjSHsQhsbL0Q11oR1ZJ
         5wv5bIAqMMbqt2dU1rpXIrHZ0UPM+nmowCvCdtDgj4kcnQzTf2J2hC9zlUZ/9TQPWBJ2
         qUWrveUj6ELK0n/hnUrUHu0SMnskH49AwZNclsYBfrmFT+WP1KJvO6U4t2D0kAQd/prw
         hXWbPCy1IDJrF5kljauhBk7rMSChMlHGBOxYFaPQ5M6t7WtVjnWNpMsywDpIOqX7+V1l
         HVqx4H5JVjZuqr7e3lRYUJTV5a6lF87V+M8k1dVDtzGDLAxVroJ8qeT665Fnp59q9+gz
         6Xpg==
X-Gm-Message-State: AOAM5314P1b9aUhMLxrNrrnshnze7QTBVT0wwpK1ZqX8InuZLV50IVfg
        E27DHSkdAT21ThzI/h7eQeN85cu7
X-Google-Smtp-Source: ABdhPJzE4+TxhzZKb4iZghU3Zn6HG2LufYbOUjFKtmBWsJDYGMFzCm0Fl0Su312vljqMb5EkuVWXlA==
X-Received: by 2002:a4a:9c55:: with SMTP id c21mr602529ook.25.1590097662956;
        Thu, 21 May 2020 14:47:42 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id v9sm2004405oop.8.2020.05.21.14.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 14:47:42 -0700 (PDT)
Subject: Re: [BUG?] b43: can't connect to WPA3 network (nohwcrypt=1)
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
        =?UTF-8?Q?Michael_B=c3=bcsch?= <m@bues.ch>
References: <CALjTZvbLOr5zAYyp75Cs6Zo8mWNUVq3ZRJu56G1iHdiihFejWQ@mail.gmail.com>
 <CALjTZvaroTrgK9=W8uTwq9YcYayfuEU31BUc0qNYJr+08hevfg@mail.gmail.com>
 <CALjTZvaPi2FL-epk-Vd2wOLye2O0J8G5aZPsqzHXt2b7u=HyuQ@mail.gmail.com>
 <263e247c-3bf9-6d42-996b-bc513efe4b71@lwfinger.net>
 <CALjTZvauK0Hh+aoabcDX9kkQZ4zN2ZjPnB+aq7YrJ9+-4ihiAg@mail.gmail.com>
 <87fffd5d-242a-7195-c4cc-80260dbd53c5@lwfinger.net>
 <CALjTZvYCFNSQ6HMN4owkiGTVrYaiU8R-P1KXgvkwGqcOo8uMuw@mail.gmail.com>
 <CALjTZvYMF_ERBfzkhaHvsTu6kt7MW+L_979sOVs8hcH7zF_Nyg@mail.gmail.com>
 <20200521124608.4b5c78f2@wiggum>
 <CALjTZvan46UTwcUxOSN=RiE6XHm-29Ln8B6wiv40V_RVxWewtA@mail.gmail.com>
 <20200521134011.656381ad@wiggum>
 <CALjTZvZcfT-aURMa=j-1ksWyVdu42bLEsGOaq+Hw39ioiPFKAA@mail.gmail.com>
 <CALjTZvY3_wjAx9DOEgYxpc4_fG-HWh_=O7veFxeEoygPzTJptw@mail.gmail.com>
 <2b22b778-2f89-9c42-93a0-5c165de26f35@lwfinger.net>
 <CALjTZva70Ni-s5VjRZL5BPswEtz5VZsX+dvE6rq2ztLJQ9v3kA@mail.gmail.com>
 <CALjTZvbvE_cDg9mfszscSBowznp1UpxqiN1LQfbgeCOYatKMNg@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <f6152cd7-1043-dde2-7fc1-634d8b07a231@lwfinger.net>
Date:   Thu, 21 May 2020 16:47:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CALjTZvbvE_cDg9mfszscSBowznp1UpxqiN1LQfbgeCOYatKMNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/21/20 3:23 PM, Rui Salvaterra wrote:
> On Thu, 21 May 2020 at 20:19, Rui Salvaterra <rsalvaterra@gmail.com> wrote:
>>
>> Sure, I'll give it a spin. I'm now compiling the kernel for the laptop
>> with the other b43 card (BCM4311).
> 
> Nope, kmsg is clean. I'm pretty sure the condition is evaluating to
> false because we do have the firmware, it's just that the crypto
> engine doesn't support the required algo.
> Is hardware encryption an all-or-nothing thing in mac80211? Wouldn't
> it be possible use the hardware as much as possible and fall back to
> software only for the unsupported features? (I guess the answer is
> "no, because the firmware gets in the way", but I had to ask.)
> 

My first failure indicates the mac80211 needs to know from the start that 
software encryption is to be used. The only places that the driver makes note of 
the nohwcrypt is in b43_op_set_key() where it returns -ENOSPC, and our new one 
where MFP_CAPABLE is set. Otherwise, the packet flags indicate that encryption 
is not needed.

Larry

