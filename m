Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEB8CC47FE
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 08:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfJBG6b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Oct 2019 02:58:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37127 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfJBG6a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Oct 2019 02:58:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id f22so5665072wmc.2
        for <linux-wireless@vger.kernel.org>; Tue, 01 Oct 2019 23:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaiwoo-ai.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yrbueD9zuMyc2rPIWt/0NgGvO9Zwu5vrfQy3krSRdbY=;
        b=MzGA/JLjKH54XaGc+x4yuiQXb6YQRT7GdEnpTmkxI46cY1x8JH7unDkgoUYrYHg9+Z
         ej2ulDeQDUQRcCakn9s28g3lpQTT4c8Y8e9Qu/u0s+weBAc2s4BFKaZgQDDSjgyGqXyr
         sd/jkdiKiHdp3nt7E2AbS7O0jCA6n7M3TUp/IUlGjGcgqJOLfUQZEWAXIs6O8WZhbqo6
         ES0o5uPkkHti3Tbys9PDNXI9+cbEw03XSlVOghlUSjTvz2C2OA1cQLiN5rgTdUpMiHl7
         0iR4Y6FTzNStBRRXQ4U5GWnEyNXjQgVDoPK6N9cXnfIFuqOszSqInvXQBjn4KgxfBft1
         0dYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yrbueD9zuMyc2rPIWt/0NgGvO9Zwu5vrfQy3krSRdbY=;
        b=l3HJ4fy38VxOAwzyfXUIA8qVTdSXRBSV5SC8Koi29JD3+OX1RNDXki6DNK5cldbCUH
         CxdRmXTb7F6z96U8PrQUN5vzTeRs4PEYa42DUP95goTepf6Cu7biPCm4V31kfjqyaaZY
         4vMOcQCQxmJcwkdei/Y5YM8nnZGZjTrVf4ixZUIlvsw1c/pHC05gxVVrbMQkYsXq5kgb
         RYXN1qwgkbfIC6tFq4Na/RKfhz9l2x/gqmnqbRyo2BVN1e1UylrWCen2j40h/sEOPffB
         2EdUoMXOfTPMk5Olj7ChjGWNdo7jykCWArEC30thdyewu3IMHepU7BJJz5GY3Rkttp2k
         wFUQ==
X-Gm-Message-State: APjAAAUEqajWeQtZ05Rsm8TbjVqe53octKjZmM8BNFTeDtvk363rOB4Q
        zUFaWkjv6U/EHglzdXUtoCq5driEu5Q=
X-Google-Smtp-Source: APXvYqwz5HV4OSsH/R9xHpNT8o5iAah9lVsNLL8a0O+nu+LzwSVbmI9ZpNLFe3ZTNswhf4jddjR0BQ==
X-Received: by 2002:a05:600c:28d:: with SMTP id 13mr1591252wmk.84.1569999507652;
        Tue, 01 Oct 2019 23:58:27 -0700 (PDT)
Received: from [10.93.0.228] (net-93-145-117-10.cust.vodafonedsl.it. [93.145.117.10])
        by smtp.gmail.com with ESMTPSA id r2sm23096666wrm.3.2019.10.01.23.58.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 23:58:27 -0700 (PDT)
Subject: Re: [PATCH] ath10k: Fix offchannel tx failure when no
 ath10k_mac_tx_frm_has_freq
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     greearb@candelatech.com, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org
References: <1508284992-3574-1-git-send-email-greearb@candelatech.com>
 <ba256006-b42b-0dee-4eb7-093da5885341@kaiwoo.ai>
 <87tv8r3cnm.fsf@kamboji.qca.qualcomm.com>
From:   Antonio Quartulli <antonio.quartulli@kaiwoo.ai>
Openpgp: preference=signencrypt
Autocrypt: addr=antonio.quartulli@kaiwoo.ai; keydata=
 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
 BT5NrmAI
Message-ID: <d1719c78-1c40-22e1-bb84-a5aee0b41750@kaiwoo.ai>
Date:   Wed, 2 Oct 2019 08:55:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87tv8r3cnm.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 02/10/2019 08:05, Kalle Valo wrote:
>> Tested-by: Antonio Quartulli <antonio.quartulli@kaiwoo.ai>
> 
> Thanks! What hardware did you test this? I'll add that to the commit
> log.
> 

It was tested on my AP equipped with and QCA4019 and QCA9888.

> The patch also had some conflicts which I fixed in the pending branch,
> please check:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=bdc657dd0c0cb7163fcf39b94e664e3d9409140e
> 

Looks good to me, thanks!

Regards,

-- 
Antonio Quartulli
Kaiwoo.ai
