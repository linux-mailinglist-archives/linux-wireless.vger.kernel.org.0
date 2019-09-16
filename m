Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01CCCB366C
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2019 10:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbfIPIcc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Sep 2019 04:32:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38038 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731049AbfIPIcc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Sep 2019 04:32:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id l11so37840426wrx.5
        for <linux-wireless@vger.kernel.org>; Mon, 16 Sep 2019 01:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RHbI26jBxHHVdC5MVSVSZ4FBgEGe0bhj06FcnSvvAak=;
        b=DiAf2dDQwonEc0dwP6bV3KOIvQwSWBgMxY+xlRd8eBvVwiAUqKOLEEQjyiKpg2ohac
         x37nvAHU1y5neDSKKO5JTG+KcqfqyPGr2o0TfE+fONNOoPhT7SM2V4+9wLNsFULgjcuf
         OrUtWcUSIXWbjGpe0zAIbzqvgymDA5Af6lQUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RHbI26jBxHHVdC5MVSVSZ4FBgEGe0bhj06FcnSvvAak=;
        b=UitD8Jxzm6j9lZR1o/vOqdEJc2H9ZcYLD7I+f1PuKomlqsglM3fhhSKws+ct7Xtk6z
         Lu1SRb1A3aYDJ5hPMtyOABTIGqt+4LIkZI7nmDSSb368N00EpnPc7hvCCxo1tx6jAroZ
         +MT1mAOvCG7ctErJ2YveZciePRwgtOKyOFZddpfG6iO9Tap6vDYtS8DT4Q7HjQ9lYU/A
         rFSWgM+UxEKju4aLqCvbFuKsijw+E6Vw6UgVLFsnYj1eg1582k1r3Hm93ZZeMl8KmSrc
         qiH4w4QWr5bkint8pH/K+2BdZU9pg6x5pIWLaiPHCNoe66R5d4NszVOmdXlUa4cerBJD
         3Drw==
X-Gm-Message-State: APjAAAVXlhyOzOfx6DycpRDpO7Tmhly8T44abGY7fLYCVxhfhyGTNK+P
        boESWKRw2sAHtrEgdmbWDQu3tw==
X-Google-Smtp-Source: APXvYqyOWlPI+iH9ldqpYF5ndSWi7LO+9MgPecatfMrBWupl0SNLuoK1KYn5zuPQVCDI7otOAL0m+w==
X-Received: by 2002:adf:ff8a:: with SMTP id j10mr51465080wrr.334.1568622750499;
        Mon, 16 Sep 2019 01:32:30 -0700 (PDT)
Received: from [10.176.68.244] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id a205sm23587277wmd.44.2019.09.16.01.32.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 01:32:29 -0700 (PDT)
Subject: Re: [PATCH] brcmsmac: remove a useless test
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        franky.lin@broadcom.com, hante.meuleman@broadcom.com,
        chi-hsien.lin@cypress.com, wright.feng@cypress.com,
        kvalo@codeaurora.org, davem@davemloft.net
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20190915193210.27357-1-christophe.jaillet@wanadoo.fr>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <fc7f0338-c1f6-0659-3767-57c09b45fbbb@broadcom.com>
Date:   Mon, 16 Sep 2019 10:32:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190915193210.27357-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/15/2019 9:32 PM, Christophe JAILLET wrote:
> 'pih' is known to be non-NULL at this point, so the test can be removed.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
