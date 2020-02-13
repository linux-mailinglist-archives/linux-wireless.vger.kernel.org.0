Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B01A815BBB5
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 10:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbgBMJaX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 04:30:23 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35659 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbgBMJaX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 04:30:23 -0500
Received: by mail-wm1-f68.google.com with SMTP id b17so5789905wmb.0
        for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2020 01:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N1dkLcTiW6c26OSQaXlNqZi6Jdkh8Bcwt5jwU2oWlZM=;
        b=BBsB6TmFei6y/N5FUmvPJV7jKMtuyg9NynA22eOFcYRL9WxbWALOcNjwscqUEvWF9S
         73LZWS1/4QXfInBm/ubbYndj+2eNUIQxh+S/t4ohYTXZEzAt4W3IFteXzbGGtyLmTONe
         BgxYhobNBNooLJbHFLzMFLsPcINeTWnVJRxJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N1dkLcTiW6c26OSQaXlNqZi6Jdkh8Bcwt5jwU2oWlZM=;
        b=hJHVz1wu4u0Sx3Nbzi043kuUv3U7H2W9lajJ6G3lON6vTXhHfKrxgi3t03w2CoGiu8
         n8yNpgrHqfJ7oZU0atNj1Z7oBGnNzE0Y7ueQN0z11pSFYJinzGA0nnqYl7Zv73tXPiGn
         SzpuIyQU6+C8L+SRgBzPEB0A/2zcvZoHH/DeIteHnsy0XnxDOmb42B4EaU/P6MFk+FFz
         xfely5AdhCfCD4f2tw1dVr/rSRJXOXg8iMrcTtnlWDQZOj0xMY2qZJtjBbRtiBfzwayk
         318DQ2O2cJpLyBTcMtPwneZRcVcCBSyG5IRpDJzHc+GnLw3qPwPos2x2CTVxrwMZZoAQ
         phtw==
X-Gm-Message-State: APjAAAUuXJFn/h5rMhk3IDP4YV7+4qQjO2t8sIGm8ngfyfCzwax4yLAy
        ZJ16dCfU8idG7LTdv9dqd8PYsA==
X-Google-Smtp-Source: APXvYqyTu5tBL2ApZZJ0BTkIY91sgot9ulZfmqU0ldsqv8KwJhNmaQsDSp9sBtK847gkvlu58dImEA==
X-Received: by 2002:a1c:7d8b:: with SMTP id y133mr4878084wmc.165.1581586220911;
        Thu, 13 Feb 2020 01:30:20 -0800 (PST)
Received: from [10.176.68.75] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id g21sm2139594wmh.17.2020.02.13.01.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 01:30:20 -0800 (PST)
Subject: Re: [PATCH 3/6] brcmfmac: fix the incorrect return value in
 brcmf_inform_single_bss().
To:     Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Raveendran Somu <raveendran.somu@cypress.com>
References: <1581583476-60155-1-git-send-email-chi-hsien.lin@cypress.com>
 <1581583476-60155-4-git-send-email-chi-hsien.lin@cypress.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <6c45797d-840b-5835-55fd-572c2b2abde7@broadcom.com>
Date:   Thu, 13 Feb 2020 10:30:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1581583476-60155-4-git-send-email-chi-hsien.lin@cypress.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/13/2020 9:44 AM, Chi-Hsien Lin wrote:
> From: Raveendran Somu <raveendran.somu@cypress.com>
> 
> The function brcmf_inform_single_bss returns the value as success,
> even when the length exceeds the maximum value.
> The fix is to send appropriate code on this error.
> This issue is observed when SVT reported random fmac crashes
> when running their tests and the path was identified from the
> crash logs. With this fix the random failure issue in SVT was
> resolved.

Although I know what SVT is it not clear in a public commit message. 
Just refer to "Broadcom test group" or something similar. It would be 
good to have the crash log in the commit message though. I suspect it 
occurs upon next_bss_le() call, but having the crash log is better than 
having me guess. Anyway, here is my...

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend
