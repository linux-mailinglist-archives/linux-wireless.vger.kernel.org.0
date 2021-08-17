Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26EF3EE650
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Aug 2021 07:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237458AbhHQFmt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Aug 2021 01:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbhHQFms (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Aug 2021 01:42:48 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E01C061764
        for <linux-wireless@vger.kernel.org>; Mon, 16 Aug 2021 22:42:15 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g21so16079692edw.4
        for <linux-wireless@vger.kernel.org>; Mon, 16 Aug 2021 22:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=X2F6zB2gjSZJNfvr4P11MJij3kt8szXaPROrSZkqLns=;
        b=bQTM3qyJyPea68pVTl53+sQne6oIc7beGtCexmVXjZ21yjkET3+Dwp0WU5jls5b36K
         dEqp/hu5H66K0cWWxlmAV1T6w9nR2dbUDfwQN9jNLBR1YJ7aQ/GCmjvhNSazBv7kNtKV
         rYR86KGjJO5VezffPblEVo6G5qn1QuAFOjXOFIS5AqmLmx27xV06LInrfds3rNp/GUYl
         UW+kLNjs9V/xtKp7uqKKsQzCDYEuryDkfjMUghuzeAWYwC8q6oJF++pyVBOzDkVCtrHw
         pl5qHnrk9sxPcgfyJb8vNtEBzCXwG3LgDpAjlplCQEj7fLi7rPjBgoZRTONt9n8zmCId
         amTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=X2F6zB2gjSZJNfvr4P11MJij3kt8szXaPROrSZkqLns=;
        b=cDzsPV8VWUIgVhVeakNWD3nDNzxH9uBqH+SMgNiGf0Krwks2fL/4CzUddzkruP9xbl
         rLe8jduJkPmxsOTaFfSYzBMYl9gNQ5y/Q8VfvMztyOMINRIXa/0NXuQVyAngq0tS5Xtu
         Lap006q8YfUetoJ6mioJ7Xz+w1fG868GjZ2UKwnU7gL0Q439HyAHwpp5jJCoEB4Nlir7
         Qos8LdZEaGXQZk8YSUZXogUqir4l7Bw5OZs0g0vpfLiJEL35z0F9I6wfMTSVeeQgub5B
         WFhFF5vamU8eWp0SI0tD0+SKVHm9kxEUpabNToR5sNBaNrtjklHeBawCe/jPUJMMH+vq
         VyLQ==
X-Gm-Message-State: AOAM530HFMBxm+l/ddedL7ShQPU7/ScHa+S8xek63NjFJZRt8+84RhbY
        ENK/MdkW8inuhtsMn+Gd9RDmk7HJxmaeZrUu
X-Google-Smtp-Source: ABdhPJxTtmLgTovqoY3PI5jQhHR+Z293ywPRXbnQNEvc6irAS/Jm6PPhe2rr/vVgKQ31cjUFkLVLAg==
X-Received: by 2002:a05:6402:2709:: with SMTP id y9mr2138590edd.231.1629178934090;
        Mon, 16 Aug 2021 22:42:14 -0700 (PDT)
Received: from [192.168.178.38] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id c17sm487286edu.11.2021.08.16.22.42.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Aug 2021 22:42:13 -0700 (PDT)
From:   Arend van Spriel <aspriel@gmail.com>
To:     Ryutaroh Matsumoto <ryutaroh@ict.e.titech.ac.jp>,
        <arend.vanspriel@broadcom.com>
CC:     <linux-rpi-kernel@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list.pdl@broadcom.com>,
        <SHA-cyfmac-dev-list@infineon.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <chi-hsien.lin@infineon.com>,
        <wright.feng@infineon.com>, <chung-hsien.hsu@infineon.com>
Date:   Tue, 17 Aug 2021 07:42:12 +0200
Message-ID: <17b52a1ab20.279b.9696ff82abe5fb6502268bdc3b0467d4@gmail.com>
In-Reply-To: <20210817.093658.33467107987117119.ryutaroh@ict.e.titech.ac.jp>
References: <20210816.084210.1700916388797835755.ryutaroh@ict.e.titech.ac.jp>
 <85b31c5a-eb4a-48a0-ad94-e46db00af016@broadcom.com>
 <20210817.093658.33467107987117119.ryutaroh@ict.e.titech.ac.jp>
User-Agent: AquaMail/1.30.1-1828 (build: 103001000)
Subject: Re: 5.10.58 UBSAN from brcmf_sdio_dpc+0xa50/0x128c [brcmfmac]
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Using different email to avoid disclaimers...


On August 17, 2021 2:39:56 AM Ryutaroh Matsumoto 
<ryutaroh@ict.e.titech.ac.jp> wrote:

> Hi Arend, thank you for paying attention to this.
>
>> Line 2016 in skbuff.h is inline function __skb_queue_before() and as
>> far as I can tell brcmfmac is not using that direct or indirect. Maybe
>> I am reading the line info incorrectly?
>
> I am unsure of it. On the other hand, I have also seen somewhat similar
> UBSAN from a header file "include/net/flow.h" as reported at
> https://lore.kernel.org/netdev/20210813.081908.1574714532738245424.ryutaroh@ict.e.titech.ac.jp/
>
> All UBSANs that I have seen come from *.h compiled with clang...
>
>> Would you be able to provide information as to what line
>> brcmf_sdio_dpc+0xa50 refers to.
>
> I'd like to do, but I do not know how to let kernel UBSAN include a line 
> number,
> though I know it with user-space applications...

If you enable CONFIG_DEBUG_INFO in your kernel .config and recompile 
brcmfmac you can load the module in gdb:

gdb> add-symbol-file brcmfmac.ko [address]
gdb> l *brcmf_sdio_dpc+0xa50

The [address] is not very important so just fill in a nice value. The 'l' 
command should provide the line number.

Regards,
Arend


