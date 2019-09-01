Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 220EAA48CF
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Sep 2019 13:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfIALBC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Sep 2019 07:01:02 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45196 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfIALBB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Sep 2019 07:01:01 -0400
Received: by mail-lj1-f194.google.com with SMTP id l1so10253022lji.12
        for <linux-wireless@vger.kernel.org>; Sun, 01 Sep 2019 04:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/QhSv+jzJLHtURkZkRMhlI/uVa4GZ2eRcwicvdRVVUM=;
        b=MMY0jtZIWfIu8Twz/YJ2DlsDMAwTLEBik7kuWp67xPIaDXt+vWhvBUMgF+uIXLooxp
         1YcUkmdSIECjgWvcqrvM7KxhY+LNyed40YO70yl87oQGUHU4seXwNA9nPX96nHSVWG8E
         tgpwnVyob6axaqATjF4ijNYvRjOuxh1SlY7xAA+ZGZhsFZ2h5HO0w1xBSYZqAxD3KXSe
         brypk8H6Fzd2yhDWS3CzUr20lbFcWj212fXto9CwaToKnpfFa+n7ZHdr6mpvOTON+R5C
         bbEYkMgY+rX5QFsUvh75Wh4Vdk3BtajIASeYRPXCLO1fvBKHi0zZSLO2CZ7cu6MbKJVR
         L4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/QhSv+jzJLHtURkZkRMhlI/uVa4GZ2eRcwicvdRVVUM=;
        b=Z07vnXBWIAeS4NQb7rNWr+hB5D0kDuYaJAzwL+69W0ZXgxFCoLhCHeWhuDnij3bUOt
         JWc2KwP8rWYqBIY7oW22h4oGpKUgjjLMv0TLEyzK+wKRNjt7/HqPJNbFFbWkPSXee2Nh
         yN6ql/xbxO2Rn6bLUDmXiSGJRxbtwmOnceujgo5u2rmbD2HFe+pZp7xZf8JqMs565zKU
         zw1vDw/MRcPwaymHfTLmpTyt4H2005jlSL8huV5e3muhzeicPUyBp5GT50yqz/ADfCW4
         9+kVYcmMCqPlZwu+za7ZU7wJUAWABaM/MbHQpHr4hmGo7P9V0olUWYpvywbd2rtooTe7
         rg9Q==
X-Gm-Message-State: APjAAAXcV7r+NwbQDVr8K3W5wtRMNHuYlmT2/bKRjdhdU6MbtyDUpUKm
        3Xdr7piAZm6bpTIX6mbFExA=
X-Google-Smtp-Source: APXvYqz0XRmuerdeiiv1XORwnUGL0RLsIaq6oQOWK/iKvQYlesksH/lEVCqnC81zhkkoZfRuYDIJHQ==
X-Received: by 2002:a2e:7013:: with SMTP id l19mr13512782ljc.141.1567335659582;
        Sun, 01 Sep 2019 04:00:59 -0700 (PDT)
Received: from elitebook.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id o17sm2092528ljd.9.2019.09.01.04.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Sep 2019 04:00:58 -0700 (PDT)
Subject: Re: [PATCH] brcmfmac: add "reset" debugfs entry for testing reset
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Winnie Chang <winnie.chang@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20190828154733.3910-1-zajec5@gmail.com>
Message-ID: <a72c64fc-9a14-7da2-3c88-905705714c89@gmail.com>
Date:   Sun, 1 Sep 2019 13:00:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190828154733.3910-1-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 28.08.2019 17:47, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This is a trivial debugfs entry for triggering reset just like in case
> of firmware crash. It works by writing 1 to it:
> echo 1 > reset
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Please drop this patch

drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c: In function 'brcmf_bus_started':
drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c:1187:37: error: implicit declaration of function 'brcmf_debugfs_get_devdir'; did you mean 'brcmf_debugfs_add_entry'? [-Werror=implicit-function-declaration]
   debugfs_create_file("reset", 0600, brcmf_debugfs_get_devdir(drvr), drvr,
                                      ^~~~~~~~~~~~~~~~~~~~~~~~
                                      brcmf_debugfs_add_entry
