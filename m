Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5687791EC4
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 10:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfHSIUv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 04:20:51 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46036 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfHSIUu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 04:20:50 -0400
Received: by mail-ed1-f65.google.com with SMTP id x19so845986eda.12
        for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2019 01:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wIyeIH+lXz1wr5/FlAgVKmefeqsuDUoj2vAiUqLGQUQ=;
        b=Z+pubiVvcp/+SlQZBWNCFAdOz1x0zm39pSXpFij39QRhyP14p05YdIjl7kpJo8O1Sc
         escZhmwqAuQ1f5k4CgSY4wIqVf7otJbNpS/c3I4K9buOOBDnce4EcGAL+ytQueHQBoAi
         CbUQKmS5ajpdvVmuEewyW/MeC2VjtiGR5VNb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wIyeIH+lXz1wr5/FlAgVKmefeqsuDUoj2vAiUqLGQUQ=;
        b=WwpulK5HwittLxyXineL3zkAUFYH6BWsyqNLc7TNT+xC5N5IiV7QTngjelHW25Y+ri
         jpqRHE+7l3lXaExr1nxqBXT622OcrpLXA/AveiOQVjXLPxj5jESnHyob4LLdLrqVvwXn
         Gmq8/U9lQnDy1UhyyMENOaIg4dd+eLmbZUcW7UqA8HfZ6VxjtNRGrEvkN4/ZjWy2dMsF
         iyzi9jYvV3QOba7ecUt3guidDs1MsUahkTJo8C2VJy7qywNlUIbM/CwZ7hxjVD0uTLKj
         ZHJLqz+9NztfbNnmDENMPX7+X5pv44gEBZaDqeo6sE3hIUIuzB2wQaa7o16SPpSR+91X
         yENg==
X-Gm-Message-State: APjAAAX7LaFV6PXqzG0zIA6DChs9K8zJtz1n91+mHXcfb2s7eZaITsZU
        GC2uOpBAejv6E78EqFrcd5MHSA==
X-Google-Smtp-Source: APXvYqwqkzFJ27MI14UatOR4Wbtu6WTlyoFURGlK4ZVH2l6ui88kiNp/CNcLzT0r3K7u3o+LJHP79A==
X-Received: by 2002:a50:9fc5:: with SMTP id c63mr23878448edf.252.1566202849178;
        Mon, 19 Aug 2019 01:20:49 -0700 (PDT)
Received: from [192.168.178.129] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id z9sm2649272edd.18.2019.08.19.01.20.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 01:20:48 -0700 (PDT)
Subject: Re: [PATCH v7 2/2] nl support for dmtool
To:     Alexei Avshalom Lazar <ailizaro@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
References: <1566137719-3544-1-git-send-email-ailizaro@codeaurora.org>
 <1566137719-3544-3-git-send-email-ailizaro@codeaurora.org>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <a1edb82d-6bdb-a44d-4781-c05358fffad9@broadcom.com>
Date:   Mon, 19 Aug 2019 10:20:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566137719-3544-3-git-send-email-ailizaro@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/18/2019 4:15 PM, Alexei Avshalom Lazar wrote:
> Signed-off-by: Alexei Avshalom Lazar <ailizaro@codeaurora.org>
> ---
>   drivers/net/wireless/ath/wil6210/Kconfig   |  11 ++
>   drivers/net/wireless/ath/wil6210/Makefile  |   1 +
>   drivers/net/wireless/ath/wil6210/ioctl.c   | 245 +++++++++++++++++++++++++++++
>   drivers/net/wireless/ath/wil6210/netdev.c  |   8 +
>   drivers/net/wireless/ath/wil6210/wil6210.h |   1 +
>   include/uapi/linux/wil6210_uapi.h          |  77 +++++++++
>   6 files changed, 343 insertions(+)
>   create mode 100644 drivers/net/wireless/ath/wil6210/ioctl.c
>   create mode 100644 include/uapi/linux/wil6210_uapi.h
> 
> diff --git a/drivers/net/wireless/ath/wil6210/Kconfig b/drivers/net/wireless/ath/wil6210/Kconfig
> index 0d1a8da..48b14de 100644
> --- a/drivers/net/wireless/ath/wil6210/Kconfig
> +++ b/drivers/net/wireless/ath/wil6210/Kconfig
> @@ -53,3 +53,14 @@ config WIL6210_DEBUGFS
>   	  option if you are interested in debugging the driver.
>   
>   	  If unsure, say Y to make it easier to debug problems.
> +
> +config WIL6210_WRITE_IOCTL
> +	bool "wil6210 write ioctl to the device"
> +	depends on WIL6210
> +	default y
> +	help
> +	  Say Y here to allow write-access from user-space to
> +	  the device memory through ioctl. This is useful for
> +	  debugging purposes only.
> +
> +	  If unsure, say N.

I was about to scream in horror seeing this patch, but noticed you 
rectified it in v8. *Phew*

Regards,
Arend
