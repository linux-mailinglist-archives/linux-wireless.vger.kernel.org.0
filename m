Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8731A4450
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2020 11:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgDJJMG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Apr 2020 05:12:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55894 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgDJJMC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Apr 2020 05:12:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id e26so1842678wmk.5
        for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2020 02:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=b2CpFz454BDdwSqjxr1G6oZhbHKRvHfmuEllgNAzRl4=;
        b=aMd2+d5pjt/YhcQB6BbQ7FOikvw1vYCKys3R3QEmkI6Kuar1sQNy7O47jG/TbMq9YQ
         QRWMyNFicIA8c1/4MRT5ymxHSswxEpO6OOeO1NL0pc3mw2knsEWtRIBLtPPiwVoDr7Nb
         4LC4R/r9PlKF8ikSwBZ/dqHPfMJQIwYpT9wfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b2CpFz454BDdwSqjxr1G6oZhbHKRvHfmuEllgNAzRl4=;
        b=Z4w9DCmoEQy5B7zgJx5YFlbfeX5EQCZ+9M5MOVXK54lMAf16RWyuCqXWUXSLWY/NV7
         r0aoKHP+1hEFs68YGx4AMc3mSkCL2CYs9EW/LeLmzlilnyaNKAQj8+hfYpojoXrFK/Nr
         udmcVutQBMT7HHKelXZQgx7iLGdPbitjHtjT1uVIVZtt8h0nsFBy4zrez8NLDlbm9g/h
         +QS3mu51eTmA60WLHK6sd5Vv+AmNffEs5QW1tirdYwwdmB7NSY7DbWfw5bfO3zk+bPUW
         NcBrBhGGatU9RYY9RUiQAv4n+0urEfn+baAkrDjpmPwJ5RQ7zHVNaKK7hfrFkZx1I7dZ
         ZCYg==
X-Gm-Message-State: AGi0PuabN3xrJ4EURwHSbhRO0nfeIjbUzX9/B/N8HFlgn59YBTGkhcYC
        WmZU+x+fdd4QgdPt34vOlzvlzA==
X-Google-Smtp-Source: APiQypLhWw+WB9Ta+aCTQgGcKmryDdYoaFIy26iFQ5zeat19uu9UDC16papfiNcRsQWb200xnLPn+g==
X-Received: by 2002:a7b:cb45:: with SMTP id v5mr4107314wmj.17.1586509921001;
        Fri, 10 Apr 2020 02:12:01 -0700 (PDT)
Received: from [192.168.178.129] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id j11sm2063686wrt.14.2020.04.10.02.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 02:12:00 -0700 (PDT)
Subject: Re: [PATCH] brcmsmac: make brcms_c_set_mac() void
To:     Jason Yan <yanaijie@huawei.com>, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, chi-hsien.lin@cypress.com,
        wright.feng@cypress.com, kvalo@codeaurora.org, davem@davemloft.net,
        eduardoabinader@gmail.com, christophe.jaillet@wanadoo.fr,
        austindh.kim@gmail.com, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200410090817.26883-1-yanaijie@huawei.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <29f323a4-4749-0016-e5e5-6c17166876fc@broadcom.com>
Date:   Fri, 10 Apr 2020 11:11:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200410090817.26883-1-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/10/2020 11:08 AM, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c:3773:5-8:
> Unneeded variable: "err". Return "0" on line 3781

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
