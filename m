Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8978C582640
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Jul 2022 14:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbiG0MTF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jul 2022 08:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbiG0MTD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jul 2022 08:19:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B54654B0E0
        for <linux-wireless@vger.kernel.org>; Wed, 27 Jul 2022 05:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658924338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WmCiTMtuhWI7oCif0/8Z84LPgcREuckswJDytFqvLLY=;
        b=R/zD2k/ExCCmb6OC/OwUpIWWQpJwTcYms/cbpUfZ5e0qKVhevp5y/eoKCdpwcuaChMgQya
        hP/x99UaD61R6Oyqyd0HCNvR4ESTLfqMFREFvsjlGNivFn6ozAexRQxTJQM/qpVayNtIcp
        lZ7T1ggzUgBPkUB62uBfPD8XXqtO7LY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-259-vzJ7q8vQOLaKxcRGKuMC4A-1; Wed, 27 Jul 2022 08:18:57 -0400
X-MC-Unique: vzJ7q8vQOLaKxcRGKuMC4A-1
Received: by mail-ej1-f69.google.com with SMTP id gb37-20020a170907962500b0072b820af09dso5147699ejc.20
        for <linux-wireless@vger.kernel.org>; Wed, 27 Jul 2022 05:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WmCiTMtuhWI7oCif0/8Z84LPgcREuckswJDytFqvLLY=;
        b=7dbjBFWz+cCBS3JYmf/T3O5M0adDsmTQKN0odVfGelnQ0wygvj7HBZuR+EDxykKwUq
         gp3nSUNvKjmBBP9zGUhIGX54Au9hIv5mjh3C65QUzh/UK9hYwk0J+51QgnzZabVcBES0
         aypC9VwE+4G1Ef34oYLzTbo2LSw//ZGWOhJz+VYZ0q+HoAtdBCUOQ9krw1HDTc5oeqfU
         rKq/8hSq3NHXsPZ55bcn+7iznfiVkm0X18KIuCCE4MLm0+L7D7En58eLQXCLWXmu4eYL
         5szasyjIUSu5GobvuNjokmJCQLhJzczjMowCuraImQAr+Pv7K547cxYrbU5YzhgikNQR
         zzQA==
X-Gm-Message-State: AJIora/HxmwqE+Yd3RWrdiW0ES5dpr8eWn3hnfmhXY9mQh/3KON2TUks
        CpVj7MsngcD34IGNekpaTNBKdAbDVxBmZ4jDqO3CnDkc10UylQvecwin4CXjsGfHIerGWihNFW9
        3vsDkDzXn+GFYOmweGbJPeoxjUZQ=
X-Received: by 2002:a17:907:7245:b0:72f:39e7:1207 with SMTP id ds5-20020a170907724500b0072f39e71207mr17507008ejc.201.1658924336254;
        Wed, 27 Jul 2022 05:18:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tq77tz3LjPQkemKAdpM2HQ6LQo5dMeyMGCTEGREBkr8scpvEfFdsmnmo1I0sOl4/nEv/Ym3Q==
X-Received: by 2002:a17:907:7245:b0:72f:39e7:1207 with SMTP id ds5-20020a170907724500b0072f39e71207mr17506990ejc.201.1658924335983;
        Wed, 27 Jul 2022 05:18:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id 11-20020a170906310b00b00722fc0779e3sm7443534ejx.85.2022.07.27.05.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 05:18:55 -0700 (PDT)
Message-ID: <08c744e6-385b-8fcf-ecdf-1292b5869f94@redhat.com>
Date:   Wed, 27 Jul 2022 14:18:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [BISECTED] igb initialization failure on Bay Trail
Content-Language: en-US
To:     "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc:     andriy.shevchenko@linux.intel.com, carlo@endlessm.com,
        davem@davemloft.net, hkallweit1@gmail.com, js@sig21.net,
        linux-clk@vger.kernel.org, linux-wireless@vger.kernel.org,
        mturquette@baylibre.com, netdev@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, sboyd@kernel.org
References: <20180912093456.23400-4-hdegoede@redhat.com>
 <20220724210037.3906-1-matwey.kornilov@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220724210037.3906-1-matwey.kornilov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Paul,

On 7/24/22 23:00, Matwey V. Kornilov wrote:
> Hello,
> 
> I've just found that the following commit
> 
>     648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
> 
> breaks the ethernet on my Lex 3I380CW (Atom E3845) motherboard. The board is
> equipped with dual Intel I211 based 1Gbps copper ethernet.
> 
> Before the commit I see the following:
> 
>      igb 0000:01:00.0: added PHC on eth0
>      igb 0000:01:00.0: Intel(R) Gigabit Ethernet Network Connection
>      igb 0000:01:00.0: eth0: (PCIe:2.5Gb/s:Width x1) 4c:02:89:10:02:e4
>      igb 0000:01:00.0: eth0: PBA No: FFFFFF-0FF
>      igb 0000:01:00.0: Using MSI-X interrupts. 2 rx queue(s), 2 tx queue(s)
>      igb 0000:02:00.0: added PHC on eth1
>      igb 0000:02:00.0: Intel(R) Gigabit Ethernet Network Connection
>      igb 0000:02:00.0: eth1: (PCIe:2.5Gb/s:Width x1) 4c:02:89:10:02:e5
>      igb 0000:02:00.0: eth1: PBA No: FFFFFF-0FF
>      igb 0000:02:00.0: Using MSI-X interrupts. 2 rx queue(s), 2 tx queue(s)
> 
> while when the commit is applied I see the following:
> 
>      igb 0000:01:00.0: added PHC on eth0
>      igb 0000:01:00.0: Intel(R) Gigabit Ethernet Network Connection
>      igb 0000:01:00.0: eth0: (PCIe:2.5Gb/s:Width x1) 4c:02:89:10:02:e4
>      igb 0000:01:00.0: eth0: PBA No: FFFFFF-0FF
>      igb 0000:01:00.0: Using MSI-X interrupts. 2 rx queue(s), 2 tx queue(s)
>      igb: probe of 0000:02:00.0 failed with error -2
> 
> Please note, that the second ethernet initialization is failed.
> 
> 
> See also: http://www.lex.com.tw/products/pdf/3I380A&3I380CW.pdf

Yes some boards use more then 1 clk for the ethernet and do not take
care of enabling/disabling the clk in their ACPI.

As Pierre-Louis mentioned already the disabling of the clocks is necessary
to make 100-s of different (tablet) models suspend properly.

Unfortunately this is known to break ethernet on some boards. As a workaround
we use DMI quirks on those few boards to keep the clocks enabled there, see:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/platform/x86/pmc_atom.c#n381

If you can submit a patch adding your board to this DMI table, then I will
merge it and get it on its way to Linus Torvalds asap.

If you instead want me to write the patch for you, please run:

sudo dmidecode > dmidecode.txt

And attach the generated dmidecode.txt file to your next email.

Regards,

Hans

