Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1C6C36A56
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2019 05:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfFFDGV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Jun 2019 23:06:21 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41960 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfFFDGV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Jun 2019 23:06:21 -0400
Received: by mail-ot1-f66.google.com with SMTP id 107so597155otj.8;
        Wed, 05 Jun 2019 20:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NLcc8Hvj4GxnkbZqOSpti57+EMywR1QkzctaKlv9FJA=;
        b=EV/94w61cJndW/aF09hT2OcRE+FgL4ycdCqgiGCIlPUBHZaw4RCokWfccuZsBTni+H
         A8hpGC53VKVyXWlsr0ebnvShJizejBIdhp7LqCqlAG7ajtZOIRYcBm1+bt+6ghAjh7mK
         K9deV8X0D/Yzw2ukIVzanS+6Bnk5MW7PVgjKYJLitlYdSQIP/0bNvrSU8cREls2bq4Oi
         mTeKWqJbdA0D4u/mmWIuzkmjNyPTKqRjFYdGyjp8KYzcG+jbCAC8tgcVdyjWfVLxxAj+
         p+L0uioQLYpw4WZI6qD5aBVhGXtbgCDj7aQGGvAc50k2+2qvVLdxflrJgaGmrhdN7OO+
         SvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NLcc8Hvj4GxnkbZqOSpti57+EMywR1QkzctaKlv9FJA=;
        b=PVE0mdoBU+4dFpPAGzhfvjRgiqM9Jvl3D4DhZTrHeIc/64ar4u0WkLP29RkcSPHo1n
         TTYCYIU+tzzuUF4tUfs4Oe+3ehY1Ief1qQ6EebIN7mGDMkaoLXIWTum25bpx9sudBBIT
         t4GcM7lLXbN6Cf/yxiljvSVQb2jB6hECzzlGM6HaWcGoQXfSl3jYFI0uchei8y5invHz
         TtGerZlXZZhsprDgwYtvwzMjTi7xxTAvdxih+0uC28VvaE2CLvp7GGxEwexlgcz2bcqc
         JyQ66QPqKk9t03URPoPQAjOogAF8/BkfrCoLUcf408EAt5IeUMbZO99NF9NbXIqhesSl
         zPwA==
X-Gm-Message-State: APjAAAWmeoXhpXZCihlHRSI3FrbRzelcNX/14qk5hnXT8pn7CgPKi7Pg
        9M24hi4CF6Cxy7HbS+PAD6g=
X-Google-Smtp-Source: APXvYqxjGCBhEAui2RBiuztJJeXSwwWM/3JyYC5cgJCRJFtBekZKrRXELpA8QUdY9Iq6B9LmR5hhCg==
X-Received: by 2002:a9d:6042:: with SMTP id v2mr6290825otj.73.1559790380624;
        Wed, 05 Jun 2019 20:06:20 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id y4sm245567oiy.56.2019.06.05.20.06.19
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 20:06:19 -0700 (PDT)
Subject: Re: [BISECTED REGRESSION] b43legacy broken on G4 PowerBook
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Christoph Hellwig <hch@lst.de>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20190605225059.GA9953@darkstar.musicnaut.iki.fi>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <35b3f09b-b371-e2cc-4436-120c67e2f1fb@lwfinger.net>
Date:   Wed, 5 Jun 2019 22:06:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605225059.GA9953@darkstar.musicnaut.iki.fi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/5/19 5:50 PM, Aaro Koskinen wrote:
> Hi,
> 
> When upgrading from v5.0 -> v5.1 on G4 PowerBook, I noticed WLAN does
> not work anymore:
> 
> [   42.004303] b43legacy-phy0: Loading firmware version 0x127, patch level 14 (2005-04-18 02:36:27)
> [   42.184837] b43legacy-phy0 debug: Chip initialized
> [   42.184873] b43legacy-phy0 ERROR: The machine/kernel does not support the required 30-bit DMA mask
> 
> The same happens with the current mainline.
> 
> Bisected to:
> 
> 	commit 65a21b71f948406201e4f62e41f06513350ca390
> 	Author: Christoph Hellwig <hch@lst.de>
> 	Date:   Wed Feb 13 08:01:26 2019 +0100
> 
> 	    powerpc/dma: remove dma_nommu_dma_supported
> 
> 	    This function is largely identical to the generic version used
> 	    everywhere else.  Replace it with the generic version.
> 
> 	    Signed-off-by: Christoph Hellwig <hch@lst.de>
> 	    Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> 	    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Aaro,

First of all, you have my sympathy for the laborious bisection on a PowerBook 
G4. I have done several myself. Thank you.

I confirm your results.

The ppc code has a maximum DMA size of 31 bits, thus a 32-bit request will fail. 
Why the 30-bit fallback fails in b43legacy fails while it works in b43 is a mystery.

Although dma_nommu_dma_supported() may be "largely identical" to 
dma_direct_supported(), they obviously differ. Routine dma_nommu_dma_supported() 
returns 1 for 32-bit systems, but I do not know what dma_direct_supported() returns.

I am trying to find a patch.

Larry
