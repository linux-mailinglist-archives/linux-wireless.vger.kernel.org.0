Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1048A41A14
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 03:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436472AbfFLBwp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jun 2019 21:52:45 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43606 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406607AbfFLBwp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jun 2019 21:52:45 -0400
Received: by mail-oi1-f193.google.com with SMTP id w79so10479764oif.10;
        Tue, 11 Jun 2019 18:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dZNefY29tKM9ryZRIGvVbjsKJ2b4TgUTWY8UBz9yJko=;
        b=FyH/B21AKA+b64BgH5EUU4Egx3zWgkj7opUJGSUvScZPqFBjEoRrGyzBpdsyRTe7fk
         SvCO7rsajEs/NnuDuKwOBV1aclkSLFhTEzq0uQLy4R+UClpRP7V21jkk7yYOX/S2ICe/
         SWF7Rj4oKPI1IxytVmeCir81VYDsWoGtwxM1eIp3UQDXVEhf7zCrXt/r78EYX+26jLd+
         LXEeoO0Zn65n/1deD15/PIgWVPXExqu0GjMDCKCW4pee2QvkmLqawYWPAVTaUOMKAZeI
         U6zy7dK4khDFWM2EqCW1NIrEh89X7759fwcBVjV1hzbrzXhLbuhXdFEkM7+6BJsz2ygk
         hhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dZNefY29tKM9ryZRIGvVbjsKJ2b4TgUTWY8UBz9yJko=;
        b=pNbKG4hQqh9fhf0l3TvDptZ2Xj0Hmkl93/DQnNiE/jd+bb2GuaiEo63SMoHOxi6zEG
         tq0N2Id553El9BDxC+0r0RaDsxIHCqohoWyfdCujLK5ifgo1x4RfVvNdHSFNlLiHpHOR
         kH6KYviUCvXi4xcP3BqJbQCiziiHBHv5a8MoxNA0DnkEiKvUpmruQ1GsqyCpVV0bu7OR
         LmQcwdnm2Y3oM2ooplCP7J8Fm78HwQjvXZ4DdP0mJOR2JM/prmezqrvmEfOfOUnu+zp0
         M0/tqrMe6rh/srBLVtxclhF6Vi8raLV50pAbp4loIOaOk6HTpMU420aSguYoEjHGnu+O
         a7kg==
X-Gm-Message-State: APjAAAWuAk0dGAqI9v7ExX3waiJ8tqqIdwRsjm3o+ASBUWZcLE+DcMqL
        me8xoSnK1e8ENuBvFoBspV80Ej6S
X-Google-Smtp-Source: APXvYqyt6I4dEKDJQaN7+xYncZIh+w6qVHdohQ3Aq8eNLhV8fo7OpKWR9D7GGsQBR6gEGLr1wrIgzw==
X-Received: by 2002:aca:fdc3:: with SMTP id b186mr16827205oii.114.1560304364920;
        Tue, 11 Jun 2019 18:52:44 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id x128sm1695129oig.54.2019.06.11.18.52.43
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 18:52:43 -0700 (PDT)
Subject: Re: [BISECTED REGRESSION] b43legacy broken on G4 PowerBook
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        linuxppc-dev@lists.ozlabs.org
References: <20190605225059.GA9953@darkstar.musicnaut.iki.fi>
 <73da300c-871c-77ac-8a3a-deac226743ef@lwfinger.net>
 <20190607172902.GA8183@lst.de>
 <30000803-3772-3edf-f4a9-55122d504f3f@lwfinger.net>
 <20190610081825.GA16534@lst.de>
 <153c13f5-a829-1eab-a3c5-fecfb84127ff@lwfinger.net>
 <20190611060521.GA19512@lst.de>
 <5aaa600b-5b59-1f68-454f-20403c318f1a@lwfinger.net>
 <0b257651bb7ac4a6f0a8dce5470120b7701720b9.camel@kernel.crashing.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <7dcf54a9-a7aa-3a4c-8e2d-556be633d6e0@lwfinger.net>
Date:   Tue, 11 Jun 2019 20:52:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <0b257651bb7ac4a6f0a8dce5470120b7701720b9.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/11/19 5:46 PM, Benjamin Herrenschmidt wrote:
> On Tue, 2019-06-11 at 17:20 -0500, Larry Finger wrote:
>> b43-pci-bridge 0001:11:00.0: dma_direct_supported: failed (mask =
>> 0x3fffffff,
>> min_mask = 0x5ffff000/0x5ffff000, dma bits = 0x1f
> 
> Ugh ? A mask with holes in it ? That's very wrong... That min_mask is
> bogus.

I agree, but that is not likely serious as most systems will have enough memory 
that the max_pfn term will be much larger than the initial min_mask, and 
min_mask will be unchanged by the min function. In addition, min_mask is not 
used beyond this routine, and then only to decide if direct dma is supported. 
The following patch generates masks with no holes, but I cannot see that it is 
needed.

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 2c2772e9702a..e3edd4f29e80 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -384,7 +384,8 @@ int dma_direct_supported(struct device *dev, u64 mask)
         else
                 min_mask = DMA_BIT_MASK(32);

-       min_mask = min_t(u64, min_mask, (max_pfn - 1) << PAGE_SHIFT);
+       min_mask = min_t(u64, min_mask, ((max_pfn - 1) << PAGE_SHIFT) |
+                                        DMA_BIT_MASK(PAGE_SHIFT));

         /*
          * This check needs to be against the actual bit mask value, so


Larry
