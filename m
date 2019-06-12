Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5494D41A25
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 03:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405666AbfFLB5h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jun 2019 21:57:37 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:36383 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404557AbfFLB5g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jun 2019 21:57:36 -0400
Received: by mail-oi1-f173.google.com with SMTP id w7so10504633oic.3;
        Tue, 11 Jun 2019 18:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6Z9WC8IIuQYglwsQB0e3uL6ecR5E4muSXX477jTQGh8=;
        b=iB1LNB5EGSLpo7WgSDBrPmeEMZ93Mel9h5ylZ9HqRqs1gJhLWN86/njzn4XJevfmCu
         db3MlOx94hwD3ngUE2V7wPLLQ8HFc5X/4aaCDN2LInVyw/NM0aIpWl22dzBLXUiOfS1g
         sVBPhMzZAMjbsfr+JpAirucC7TFI0YeoWXBetnhPW2Iba/wwmBQNQFrKomZOQz9KMmUA
         RKAhyYOHYT8QhUI5dl/veYPT/Bz+7gJcQA3o40NzSL+6wPjw+zGQf2xoYcrnbBo0NVsb
         lWLvihSbKerJyuzT8gFbYbezGSA3mRft0Jf/NdHGVzmRuEQ3sp5xFAAvgi9i+i2vZFVM
         u+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6Z9WC8IIuQYglwsQB0e3uL6ecR5E4muSXX477jTQGh8=;
        b=c1d0vxRzda9q+4IDfvTdgivClg4hYulQhCU0nwhfU/QRvsQ4qxtCG854L5Z26IHzhW
         N1FUEdxZf43Yg4K5jAgOhb1bYtO/8HLGrO2E9mvENuMP/NWgQ7g5Gu/VSq7qo1NdIEwp
         EJ+sCbss+u3/ZpS+lmwyxmhbourpf5gkBksqVs1I3OkiT7D1tugSQjDu37QcxJNRS5/L
         eBY2RGP6bVhvk6PkqILWGZe7NIasz9KzUOp+M9CrzxNpHR9NeE8f8B+xuRZkmMPQH5GL
         p4Z4uyHHWOR/HSd6vL4dLHxBmHBQenWzCu6YRemgOo87amkKiGT9RI2gu33iNUe6Z6SV
         oK5g==
X-Gm-Message-State: APjAAAUM+bZoWWT+sm71K+/S8LkfLB1FYkbPiS4mKk6/cx/r2k1dKoRo
        rXCPwWPv9XAePkfOIpX4QYKDR7Jf
X-Google-Smtp-Source: APXvYqziy+hwOJ/rBxaZYDd+TNhUBY53RQKM+KiMF+7YIA5VTYBc9yXxbDk19EaodEyzL0xN3GIxfA==
X-Received: by 2002:aca:6208:: with SMTP id w8mr17923394oib.128.1560304656060;
        Tue, 11 Jun 2019 18:57:36 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id 41sm5775218otm.6.2019.06.11.18.57.35
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 18:57:35 -0700 (PDT)
Subject: Re: [BISECTED REGRESSION] b43legacy broken on G4 PowerBook
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Christoph Hellwig <hch@lst.de>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20190605225059.GA9953@darkstar.musicnaut.iki.fi>
 <73da300c-871c-77ac-8a3a-deac226743ef@lwfinger.net>
 <20190607172902.GA8183@lst.de>
 <30000803-3772-3edf-f4a9-55122d504f3f@lwfinger.net>
 <20190610081825.GA16534@lst.de>
 <153c13f5-a829-1eab-a3c5-fecfb84127ff@lwfinger.net>
 <20190611060521.GA19512@lst.de>
 <5aaa600b-5b59-1f68-454f-20403c318f1a@lwfinger.net>
 <20190611224623.GC26504@darkstar.musicnaut.iki.fi>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <74c8af35-6006-5ca8-0fe4-b5938b1139ff@lwfinger.net>
Date:   Tue, 11 Jun 2019 20:57:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190611224623.GC26504@darkstar.musicnaut.iki.fi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/11/19 5:46 PM, Aaro Koskinen wrote:
> Hi,
> 
> On Tue, Jun 11, 2019 at 05:20:12PM -0500, Larry Finger wrote:
>> It is obvious that the case of a mask smaller than min_mask should be
>> handled by the IOMMU. In my system, CONFIG_IOMMU_SUPPORT is selected. All
>> other CONFIG variables containing IOMMU are not selected. When
>> dma_direct_supported() fails, should the system not try for an IOMMU
>> solution? Is the driver asking for the wrong type of memory? It is doing a
>> dma_and_set_mask_coherent() call.
> 
> I don't think we have IOMMU on G4. On G5 it should work (I remember fixing
> b43 issue on G5, see 4c374af5fdee, unfortunately all my G5 Macs with b43
> are dead and waiting for re-capping).

You are right. My configuration has CONFIG_IOMMU_SUPPORT=y, but there is no 
mention of an IOMMU in the log.

Larry

