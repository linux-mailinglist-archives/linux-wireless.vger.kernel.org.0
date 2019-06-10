Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2F13BBF3
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2019 20:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387809AbfFJSov (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Jun 2019 14:44:51 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46953 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387643AbfFJSov (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Jun 2019 14:44:51 -0400
Received: by mail-ot1-f67.google.com with SMTP id z23so9283937ote.13;
        Mon, 10 Jun 2019 11:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D3rnPxkKkOcWLjb9M3zXKMP8YGdus9mVV7OMcZq7pcE=;
        b=DVW5iXzx64p4Z3JZnxlxs0vIKwgxfFCNmYLEcmQukipOh4AkADT4du6f0HN/erCPT0
         yuTL9qyCL6VAMwebjQD3hB1vTUCR3FJEraylBTE1PQ/6HfA7xk47lLm92/JbD/8kquWs
         8whChl5q7Bd4PZZRchNe33DfU/HStFantcBM+eLHLsstePld5xV84aCqf4L03cmJiFu8
         KH8bTM434yHlZjNa0ohDkL0oJz6qFfjNGcr8fw2SL9GgZvo5VgeYu5O5KL93bK2DNED2
         5j3uNh1vklJhT2VMvsjlKcZjt2c/z7HiKLaKetkwy0kQXJCMJHv0GtezcsQrC1x6hZSa
         T+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D3rnPxkKkOcWLjb9M3zXKMP8YGdus9mVV7OMcZq7pcE=;
        b=lJ2DqAaD7/l+Bf5Sc4XmmllarcolpNILShmZmodr4nevzv2/ytlxkbJVq7iHZavmvP
         FSULL2lgaODGd9poX0TGmfYUl0ZiQTNz4oKWMbfhc0i1DAdgiNGcEeY45clkej0l+kJ5
         2T+JkCeOxLlHC6FmG2B2dEM6WLEIrZKVPdjD86IFqb5PkLJlNCDOy8/ELMSWqXtYKK2+
         vULE542Hxi0bsrxm0F2gnxfUVxsmFzxDcaFD3QT+/SxIm8YNpQWUfbY9Y9Bj4lW3EUPo
         XveYpJfpTn0NrVhZMsyqJGXFpEDhtP06KuON+FdX3Ra+FYUBNJ3eAeogiq/4bkmGzVz9
         B41g==
X-Gm-Message-State: APjAAAUCnwGAOM1jfquPrL5Zb0o5LZXQUSjvYBbBSDUVJo5aIBtl2Uc5
        7fHT6uWDTxO5WJx1bTcUEHd5mh/M
X-Google-Smtp-Source: APXvYqzFkDPZUfQTRZ+iIhDbbjsNqAeRD5O0Bl+f2oVgQX41yDJYVUD2AZA7z+ewtprdGgM6/MXViQ==
X-Received: by 2002:a9d:6c46:: with SMTP id g6mr25448205otq.162.1560192290284;
        Mon, 10 Jun 2019 11:44:50 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id f5sm4018251otl.51.2019.06.10.11.44.48
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 11:44:49 -0700 (PDT)
Subject: Re: [BISECTED REGRESSION] b43legacy broken on G4 PowerBook
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Christoph Hellwig <hch@lst.de>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190605225059.GA9953@darkstar.musicnaut.iki.fi>
 <73da300c-871c-77ac-8a3a-deac226743ef@lwfinger.net>
 <7697a9d10777b28ae79fdffdde6d0985555f6310.camel@kernel.crashing.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <3ed1ccfe-d7ca-11b9-17b3-303d1ae1bb0f@lwfinger.net>
Date:   Mon, 10 Jun 2019 13:44:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <7697a9d10777b28ae79fdffdde6d0985555f6310.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/7/19 11:21 PM, Benjamin Herrenschmidt wrote:
> 
>> Please try the attached patch. I'm not really pleased with it and I will
>> continue to determine why the fallback to a 30-bit mask fails, but at least this
>> one works for me.
> 
> Your patch only makes sense if the device is indeed capable of
> addressing 31-bits.
> 
> So either the driver is buggy and asks for a too small mask in which
> case your patch is ok, or it's not and you're just going to cause all
> sort of interesting random problems including possible memory
> corruption.

Of course the driver may be buggy, but it asks for the correct mask.

This particular device is not capable of handling 32-bit DMA. The driver detects 
the 32-bit failure and falls back to 30 bits. It works on x86, and did on PPC32 
until 5.1. As Christoph said, it should always be possible to use fewer bits 
than the maximum.

Similar devices that are new enough to use b43 rather than b43legacy work with 
new kernels; however, they have and use 32-bit DMA.

Larry
