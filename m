Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E72CD19F6B9
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2020 15:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgDFNS1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Apr 2020 09:18:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33490 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbgDFNS1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Apr 2020 09:18:27 -0400
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jLRdx-0000wK-4Y
        for linux-wireless@vger.kernel.org; Mon, 06 Apr 2020 13:18:25 +0000
Received: by mail-pl1-f199.google.com with SMTP id m9so10993377plt.8
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2020 06:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yfh8auMdoRigiRys04NLUbX84A9moSV9U1pPae/atro=;
        b=lj9peBmYW4wnmkPS/3ZTZTlAQ22JZDThyUGxDx9bzXasxzEceT4hYXUI8eI3l6IzzM
         e80TVzeYuWkbzdMZa4nkGyIA0xQhFl+0ccty7J2PB8a0Ejtq3UBk+B2lhs4+zzYm4fwn
         Gl0E6snDkgJMg7+fd7o5xy/fK1c0TYQjJ7u22d45Ecq+aeKQ8Qldust9NRzIyZk6yi7x
         SbjAOTaCv7pveB/4ZLivPiSfL9tU5zVFkE3aG+u77dziLjwP4pIZ58uBE01Jl+eRsQh2
         BewsVxz0L9lfKC94Kf/syS2xsPkBhoZ5nZ2GDUx5P9ciLyymmH3Tfy/z00/e5rpVkSV6
         hH6g==
X-Gm-Message-State: AGi0PuZp5zE0vp1YIdyP6ZLCGdme4bvLe9NFS4FST7NkV5kZ/RZBHKNJ
        aWc7EHxe4C5Ire4Wyr/GO32KY1kv2l/CUe/u9xtcMi5QUm1BNs261MQdMcyrJL/mWFp4Uq7Qi5r
        QlqMOf/iY4szVpybNJiK4UQgTYfLNVg3oN3CxWY/5DIwF
X-Received: by 2002:a63:e558:: with SMTP id z24mr20646323pgj.368.1586179103759;
        Mon, 06 Apr 2020 06:18:23 -0700 (PDT)
X-Google-Smtp-Source: APiQypIRNNfP69Byee6DnP3oE8819ZQmmW1WafsLeF6MlX6NhlFtF3wCeXFKCIqmcsiELvOx6719nA==
X-Received: by 2002:a63:e558:: with SMTP id z24mr20646297pgj.368.1586179103368;
        Mon, 06 Apr 2020 06:18:23 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id 135sm11948080pfu.207.2020.04.06.06.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2020 06:18:22 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] rtw88: Add delay on polling h2c command status bit
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <87v9mczu4h.fsf@kamboji.qca.qualcomm.com>
Date:   Mon, 6 Apr 2020 21:18:20 +0800
Cc:     Tony Chuang <yhchuang@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:REALTEK WIRELESS DRIVER (rtw88)" 
        <linux-wireless@vger.kernel.org>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <94EAAF7E-66C5-40E2-B6A9-0787CB13A3A9@canonical.com>
References: <20200406093623.3980-1-kai.heng.feng@canonical.com>
 <87v9mczu4h.fsf@kamboji.qca.qualcomm.com>
To:     Kalle Valo <kvalo@codeaurora.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> On Apr 6, 2020, at 20:17, Kalle Valo <kvalo@codeaurora.org> wrote:
> 
> Kai-Heng Feng <kai.heng.feng@canonical.com> writes:
> 
>> On some systems we can constanly see rtw88 complains:
>> [39584.721375] rtw_pci 0000:03:00.0: failed to send h2c command
>> 
>> Increase interval of each check to wait the status bit really changes.
>> 
>> While at it, add some helpers so we can use standarized
>> readx_poll_timeout() macro.
> 
> One logical change per patch, please.

Will split it into two separate patches.

> 
>> --- a/drivers/net/wireless/realtek/rtw88/hci.h
>> +++ b/drivers/net/wireless/realtek/rtw88/hci.h
>> @@ -253,6 +253,10 @@ rtw_write8_mask(struct rtw_dev *rtwdev, u32 addr, u32 mask, u8 data)
>> 	rtw_write8(rtwdev, addr, set);
>> }
>> 
>> +#define rr8(addr)      rtw_read8(rtwdev, addr)
>> +#define rr16(addr)     rtw_read16(rtwdev, addr)
>> +#define rr32(addr)     rtw_read32(rtwdev, addr)
> 
> For me these macros reduce code readability, not improve anything. They
> hide the use of rtwdev variable, which is evil, and a name like rr8() is
> just way too vague. Please keep the original function names as is.

The inspiration is from another driver.
readx_poll_timeout macro only takes one argument for the op.
Some other drivers have their own poll_timeout implementation,
and I guess it makes sense to make one specific for rtw88.

Kai-Heng

> 
> -- 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

