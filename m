Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A020998B4
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2019 18:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388241AbfHVQED (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Aug 2019 12:04:03 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42599 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387983AbfHVQED (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Aug 2019 12:04:03 -0400
Received: by mail-oi1-f196.google.com with SMTP id o6so4741850oic.9;
        Thu, 22 Aug 2019 09:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GBqP/ktuDGSBujCj4ySFUE1r43iYNWnAgUqr6yfzCLc=;
        b=sacpK1DFhY2NjeHiJrvhMHp2c3nBJWDxgdfRxO+/3pTtFNjBooj1Cp+CNQEO5D5Qwf
         UPUXQdqiMZpDr6VAKf67EHPSXsq4o5kEoZup57cblAyhWKTDlNKz3Fxv5MjQ9/lqVpE8
         /8z81Xnz7Th7T7QwHFnU3SrCopb6zFce1a6pIS6rdKmkQZHO7qUJatgmJdRf7dISqqXt
         x5x3u0ZR6V7aL3eXcz0sPKvS+vIlMR56TEvh9kq/cFlvoNPDxG4rWtEs/egrHmpqzBV2
         gixW7lP4ogsAmTAbPsziolXE60TFzVfyLycaUYa1GyyrpXcUtX1b1eziQRVky5Rv4xtM
         nhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GBqP/ktuDGSBujCj4ySFUE1r43iYNWnAgUqr6yfzCLc=;
        b=kPf7BGzaku04mn/PCrhnAOrDE2gevws+NGoWVoafhCN5Zt1+5e5TMa9mdA2RDSKrf4
         j+Rp36fkOBt9UUD/G1h5cXafb3mDxw/JWss9lUZ9PgiuuNaOT73adCBU79Ux2DTsJZ9c
         NwdI4Ir5k7KI7vCXB4ZdvQPfdx9L/Ars7mgZHzRz7zKJwJtXffa0N2WjjbFhUvSnNPKN
         pbxv70Apf+j1Pwj9XHE1hJ6NIlUHpLAHzKl18U8bqv8x3zcBV9Jswo3GvkMoe4pgjRLk
         IJGlrZtKRTY8MnEgNj65OlQ9ZPJFJKU++HTb7tt4fRvqpoOHwygnF3wXVlInoyzGZI7g
         jjdQ==
X-Gm-Message-State: APjAAAW6yGmB0oVdRAZGxNsWvUtsqhFmLzYPYLJrH5W2vrjFY7xz3ia/
        Q3GLUjIryIGdFZkrn42j4YNnwsgz
X-Google-Smtp-Source: APXvYqzeiAa5TM9spsllNTRTadA9Xnvo0WU25z8M5m3fs1is6Hlwh4aX1n81TZzI9Dr9XbTL0NxQrw==
X-Received: by 2002:aca:dd8a:: with SMTP id u132mr3992794oig.150.1566489841764;
        Thu, 22 Aug 2019 09:04:01 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id k10sm8904656otl.21.2019.08.22.09.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2019 09:04:00 -0700 (PDT)
Subject: Re: [PATCH] bcma: fix incorrect update of BCMA_CORE_PCI_MDIO_DATA
To:     Colin King <colin.king@canonical.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190822133524.6274-1-colin.king@canonical.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <d3c16158-ef89-f5ee-2f67-4357c70e8fe9@lwfinger.net>
Date:   Thu, 22 Aug 2019 11:03:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822133524.6274-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/22/19 8:35 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> An earlier commit re-worked the setting of the bitmask and is now
> assigning v with some bit flags rather than bitwise or-ing them
> into v, consequently the earlier bit-settings of v are being lost.
> Fix this by replacing an assignment with the bitwise or instead.
> 
> Addresses-Coverity: ("Unused value")
> Fixes: 2be25cac8402 ("bcma: add constants for PCI and use them")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/bcma/driver_pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bcma/driver_pci.c b/drivers/bcma/driver_pci.c
> index f499a469e66d..d219ee947c07 100644
> --- a/drivers/bcma/driver_pci.c
> +++ b/drivers/bcma/driver_pci.c
> @@ -78,7 +78,7 @@ static u16 bcma_pcie_mdio_read(struct bcma_drv_pci *pc, u16 device, u8 address)
>   		v |= (address << BCMA_CORE_PCI_MDIODATA_REGADDR_SHF_OLD);
>   	}
>   
> -	v = BCMA_CORE_PCI_MDIODATA_START;
> +	v |= BCMA_CORE_PCI_MDIODATA_START;
>   	v |= BCMA_CORE_PCI_MDIODATA_READ;
>   	v |= BCMA_CORE_PCI_MDIODATA_TA;

I'm not sure the "Fixes" attribute is correct.

The changes for this section in commit 2be25cac8402 are

-       v = (1 << 30); /* Start of Transaction */
-       v |= (1 << 28); /* Write Transaction */
-       v |= (1 << 17); /* Turnaround */
-       v |= (0x1F << 18);
+       v = BCMA_CORE_PCI_MDIODATA_START;
+       v |= BCMA_CORE_PCI_MDIODATA_WRITE;
+       v |= (BCMA_CORE_PCI_MDIODATA_DEV_ADDR <<
+             BCMA_CORE_PCI_MDIODATA_DEVADDR_SHF);
+       v |= (BCMA_CORE_PCI_MDIODATA_BLK_ADDR <<
+             BCMA_CORE_PCI_MDIODATA_REGADDR_SHF);
+       v |= BCMA_CORE_PCI_MDIODATA_TA;

Because the code has done quite a bit of work on v just above this section, I 
agree that this is likely an error, but that error happened in an earlier 
commit. Thus 2be25cac8402 did not introduce the error, merely copied it.

Has this change been tested?

Larry
