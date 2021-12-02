Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0848465D3A
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Dec 2021 05:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344771AbhLBEJ3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 23:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344656AbhLBEJZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 23:09:25 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE27C061574
        for <linux-wireless@vger.kernel.org>; Wed,  1 Dec 2021 20:06:04 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso38222353otj.11
        for <linux-wireless@vger.kernel.org>; Wed, 01 Dec 2021 20:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RNUqlzGvfeYA89h7dDpE09niEj0xO7Pvi5hWvNQhgzo=;
        b=QT46guK8Eu/5bG39KSBJG18WnDNmk/FUttDV3YqJHfA1s4NskIVmrAKOFDYF6dfK3/
         /TcoPXDVu0tRQWH+BjfMNSy9hsUeJDX+dCYSPzwqlpKRZdFocpyI6gW8JH4sNPKmVIlc
         Y7PEfI9qlw6+07hiun3Gx603UPyIINJ1vgQ0t1qIsvGnlUN3PgeZ5sP6FopMO/l+Uwi/
         Eq7AdD4TpfVGVNMWf2U2jsljoDSyHrdrQjU4nXfk2BjfjOn2gS8fJ4pUsz2JOK1TUpnS
         lQnUm85jzc/Mmgrpe250fOpBMsk7/2NNCs+ZRP7lYDpj+vF+9exfaA88dRJQUw1PObbF
         Z0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RNUqlzGvfeYA89h7dDpE09niEj0xO7Pvi5hWvNQhgzo=;
        b=29p8xpZJiwIasrf782LhA2fWRT8XCL+lTUZt/jGwLItjmbfuBrmVfWOsjl7wn1fYZT
         HcBaPOlf3WHqQLiIIS45cPpN8gZuJDatDkMbZ2vk7lGbE8k80ETRcUfAaV2GgU/bmfyz
         MphG1ABm0peib3tHRL2hZrk464IrJRSrXccK/BuQT0b3QQ6kKxTD4mGy5dTkXDgMbI4H
         NZDDgp1w48CvPJmi3k6v8vlpHszx4QzJ93kt8R8TdX2dVt3cE0dem9NrrwZZKtDRVetW
         VeiHXV0T8tmSyrg6ItZFtfeeeDmoHk2d0f25wrkP9WpFGjzcz7Q6KalLveePxz4aitv9
         JSfQ==
X-Gm-Message-State: AOAM533kSzGTls2t+e5a0Whz3EA8D3utGVZFcoHqUMqg2f5yizba8bZA
        B9U3RS8s7sRfTu0I+q9lhJxSLYdFBpT2B5rW
X-Google-Smtp-Source: ABdhPJy9I3Yx+tMUuu6ikMJZ4+BjCfdBwXVKsMEivTB52PMOkTl8MsqDwxGUWjTZjZvdAOQ+uw2pkw==
X-Received: by 2002:a9d:2ae1:: with SMTP id e88mr5370934otb.157.1638417963325;
        Wed, 01 Dec 2021 20:06:03 -0800 (PST)
Received: from [10.62.118.101] (cpe-24-31-246-181.kc.res.rr.com. [24.31.246.181])
        by smtp.gmail.com with ESMTPSA id k4sm788436oij.54.2021.12.01.20.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 20:06:02 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <d3dd87b1-e989-f82a-566b-de61e2bb41d0@lwfinger.net>
Date:   Wed, 1 Dec 2021 22:06:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: Realtek naming
Content-Language: en-US
To:     James <bjlockie@lockie.ca>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <789b4af2-9853-031b-72e2-962174620116@lockie.ca>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <789b4af2-9853-031b-72e2-962174620116@lockie.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/1/21 21:05, James wrote:
> https://wikidevi.wi-cat.ru/Realtek
> 
> Besides the RTL8832AU (USB) being USB, what is the difference from the RTL8852AE 
> (PCI)?
> 
> How is the RTL8852AU (USB) different than the 8832AU?
> 
> Do the 8852BE and 8852BU fix bugs in the 8852Ax?

James,

The "RTL" is the Realtek part. The 4 numbers denote the chip family, and the 
first letter indicates the member of the family. The last letter indicates the 
bus - E for PCIe, U for USB, and S for SDIO.

Thus the RTL8852AE and the RTL8852AU have the same chip model - only the bus is 
different; however, the programming for setup might be different. Only the chip 
designer knows. Compare the differences in the drivers for RTL8192CE and RTL8192CU.

I have no idea what an RTL8832AU is. Similarly, I have no knowledge of the 
RTL8852Bx.

Larry
