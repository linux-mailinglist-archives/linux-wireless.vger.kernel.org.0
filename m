Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF8D14FA74
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Jun 2019 08:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfFWGGY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 23 Jun 2019 02:06:24 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:45256 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFWGGY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 23 Jun 2019 02:06:24 -0400
Received: by mail-ed1-f48.google.com with SMTP id a14so16288476edv.12
        for <linux-wireless@vger.kernel.org>; Sat, 22 Jun 2019 23:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:date:message-id:in-reply-to:references:user-agent:subject
         :mime-version:content-transfer-encoding;
        bh=w2gDVFBGrgmBqsaaTHfqg7nIc+WBEvSxTrcY3KXuY04=;
        b=UG0IORW7vDmKaK9IJDjb8ySv9+yqd5Hug+yxapcSaEe3njLSs5aWKLxf7GAwqsUDI+
         gFgQkgBpwHAFlUiBuM8KL9spC/t7cdkvhqLbiUee777G3Yr7P6bB1+DFIGY/srtRBY+m
         WMo66/fAihxPqTuWgynSh9UJ+AvPlYOEvyO9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:date:message-id:in-reply-to:references
         :user-agent:subject:mime-version:content-transfer-encoding;
        bh=w2gDVFBGrgmBqsaaTHfqg7nIc+WBEvSxTrcY3KXuY04=;
        b=HnzZGBrvPnAOPcWOhR1ltpHf2ofvt7IHJuQ2br+uvBduaz1fu/HkU0XFH/bwcGjAoJ
         k+ZTUUJswIMO0cXKVmlk4SDxcY3owwjmTKYKmg5fyGRyVu5Wrz4ayXj+9zozMCrLFnR6
         /OK4bROxWvAwwzWiUiY8Nh+0C53v6i7ZFpIddJclvwToTVliPBwBb/2z3ZKziRshBAxn
         bBxoxUa+pA5binNspTP+3+54K6oqBTqj5emUst2wD4J+QiZ60X4363GA9ZDwJDyPqOPB
         TuRaCoIEGwfgVcYUxVB00t+2cH0bJzUssX8+quJwDd7FFwvKIta8E+fp0EIQIW/hrgiX
         bKyA==
X-Gm-Message-State: APjAAAV83BQO2bjl2A55ZfjfEItJQtK/U0ngFscT5tham7PuUTBF2hgn
        mnOGAn+sIpEZkMpq+qW/LazknlrLlDaV1Q==
X-Google-Smtp-Source: APXvYqzscPwAljN19J0abqxiQqCbHEQgjEJXwPgSu5Oo7klSlrSJUXYXL6jZisdsGkpg1aIifYMucw==
X-Received: by 2002:a50:ad01:: with SMTP id y1mr132828745edc.180.1561269982163;
        Sat, 22 Jun 2019 23:06:22 -0700 (PDT)
Received: from [192.168.178.38] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id a8sm2423084edt.56.2019.06.22.23.06.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Jun 2019 23:06:21 -0700 (PDT)
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     Denis Kenzior <denkenz@gmail.com>,
        <linux-wireless@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Date:   Sun, 23 Jun 2019 08:06:19 +0200
Message-ID: <16b82f14778.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <07c7b5fc-bc1c-d49f-1c1e-d0b67899e755@gmail.com>
References: <45805272aaf8b872a90cf0c364164b5fc1b20272.camel@linux.intel.com>
 <07c7b5fc-bc1c-d49f-1c1e-d0b67899e755@gmail.com>
User-Agent: AquaMail/1.20.0-1462 (build: 102100002)
Subject: Re: iwlwifi/brcmfmac public action frames crash (RESENDING)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On June 21, 2019 10:09:10 PM Denis Kenzior <denkenz@gmail.com> wrote:

> Ping, is anyone looking into these crashes?

Did not see this message before.

>
> On 06/13/2019 11:45 AM, James Prestwood wrote:
>> Sorry if this comes in twice, I sent it ~12 hours ago but never saw it
>> hit the list, nor in the archives so I am resending it.
>>
>>
>> Hi,

[snip]

>>
>>
>>
>>
>> Here is the brcmfmac crash:
>>
>>
>> [19735.643941] BUG: unable to handle kernel NULL pointer dereference at
>> 0000000000000000
>> [19735.643965] PGD 80000001874aa067 P4D 80000001874aa067 PUD 2735fe067
>> PMD 0
>> [19735.643984] Oops: 0000 [#1] SMP PTI
>> [19735.643993] CPU: 7 PID: 5051 Comm: iwd Tainted: G        W
>> I       4.19.0-rc2-custom #27
>> [19735.644002] Hardware name: System manufacturer System Product
>> Name/SABERTOOTH X58, BIOS 1402    08/09/2012
>> [19735.644027] RIP: 0010:brcmf_p2p_send_action_frame+0x23a/0x850
>> [brcmfmac]

As the name suggest this was implemented for P2P support. Will look into this.

Regards,
Arend


