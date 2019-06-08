Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 655823A241
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jun 2019 00:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfFHWTj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 8 Jun 2019 18:19:39 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41545 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbfFHWTi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 8 Jun 2019 18:19:38 -0400
Received: by mail-ot1-f65.google.com with SMTP id 107so5095027otj.8;
        Sat, 08 Jun 2019 15:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DP0Ajt421DWmwrwPNPAX2Snzk01exwZi53pmjm8wyCc=;
        b=tzvISmEOqHqBLXuy40FjHOzFqJ26diODbTZR6+DZIDlO4cEPiRGFRwVsaPPccWWb22
         Dt+krxD8IbMjPpv3jL/u3t8j+Dcz2FJgHolsWR3RfVDBaeJ4Dd+khyn4YnBPbiV3JdQe
         F5L9RodSkDYunEDFhRlGXD/9A3AfKLbtfGu7JuHE96q+hfY9t155d6Bs8r9iCgbgRvpW
         mHQyL60NAtW+cecdreCwYb87VHDMKZtOjEUUSPH92V7yhWG3c74nzSUzNVq2mhU8Di0S
         N71xiKfzyWnDhAcOhvIKqi5vVooZcBQgjgOooEIDBGJMLqkXUE3u0PhUyqzVfgVflP+J
         +tXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DP0Ajt421DWmwrwPNPAX2Snzk01exwZi53pmjm8wyCc=;
        b=hrxJUC5vLmUe/UcnenBWfIEWvgOmsq1vuKUidw/P/mSI4X3ucjnzaH4BT43mTAImYF
         QzNkzvQGPx9ErxbfOXCp2JPW7xgXHKLduCHdFxdKCJ5JtztA8JW5Qlz/kliHYLkx9b5M
         5A48Bo+TNjdSRGHIkv5Yl28BQYWbu6GT2n6MtMMhkvw4DYVg4qI1lDuAIkIXSOSZGvRQ
         ktPz2foCK6IISSjNEZmuHjXaZ5fCrDGEAfXhO3ZYAUOjrC7F32zO2cF4tf5s7F6ze1n5
         xh4x0RJWr5eC6JsYb1Y28Qk0S7YQ3aIyyokLpTHnAYGv26YvcT7AO70+KPSUJzKY8Ulo
         2kgw==
X-Gm-Message-State: APjAAAVFLvuZtnIh/lJPFidvZxGxt0uOxrBvR0+/+CT+BpUf0rnP2nDN
        cJ4BrUTTmVzJTeHtfl3x3iI=
X-Google-Smtp-Source: APXvYqylrHE1LwideVdmvtrEqXgf6WG98D9rmgXo7hve9bgy8IQFtIcM/FU4/1dkGLypNJ6zscThgQ==
X-Received: by 2002:a05:6830:1558:: with SMTP id l24mr18682545otp.352.1560030746626;
        Sat, 08 Jun 2019 14:52:26 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id c204sm2472908oih.19.2019.06.08.14.52.25
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 14:52:25 -0700 (PDT)
Subject: Re: [BISECTED REGRESSION] b43legacy broken on G4 PowerBook
To:     Christoph Hellwig <hch@lst.de>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20190605225059.GA9953@darkstar.musicnaut.iki.fi>
 <73da300c-871c-77ac-8a3a-deac226743ef@lwfinger.net>
 <20190607172902.GA8183@lst.de>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <30000803-3772-3edf-f4a9-55122d504f3f@lwfinger.net>
Date:   Sat, 8 Jun 2019 16:52:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190607172902.GA8183@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/7/19 12:29 PM, Christoph Hellwig wrote:
> I don't think we should work around this in the driver, we need to fix
> it in the core.  I'm curious why my previous patch didn't work.  Can
> you throw in a few printks what failed?  I.e. did dma_direct_supported
> return false?  Did the actual allocation fail?

Routine dma_direct_supported() returns true.

The failure is in routine dma_set_mask() in the following if test:

         if (!dev->dma_mask || !dma_supported(dev, mask))
                 return -EIO;

For b43legacy, dev->dma_mask is 0xc265684800000000.
     dma_supported(dev, mask) is 0xc08b000000000000, mask is 0x3fffffff, and the 
routine returns -EIO.

For b43,       dev->dma_mask is 0xc265684800000001,
     dma_supported(dev, mask) is 0xc08b000000000000, mask is 0x77777777, and the 
routine returns 0.

Thus far I have not found what sets the low-order bit of dev->dma_mask. 
Suggestions are welcome.

These tests have all been with your patch that sets ARCH_ZONE_DMA_BITS to 30.

Larry
