Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF5FA730E
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 21:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfICTDl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 15:03:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54668 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfICTDl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 15:03:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id k2so632046wmj.4
        for <linux-wireless@vger.kernel.org>; Tue, 03 Sep 2019 12:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3pKB/s7QIRjzR74E3kb2LPD38Qsso7bn4uv9aOUYFW0=;
        b=Djjic5/qjFPywC0E5JslCge+wapy7Mva/hu5YL1n9HjKtPJNQ6hu78fIWeOmIbblbT
         5gp56GpDlDDBb81thNZngnnrYJEh0eUMX5pbk/zWdPcLwUTCNoEyQ/HBr8cvgXiadXQ5
         flMN/82gCjOhtQDS4xBsnU+4ZP43WvbzDZWsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3pKB/s7QIRjzR74E3kb2LPD38Qsso7bn4uv9aOUYFW0=;
        b=Gu41L29kdA4utlCaL309AGRThDgj3zxP0vkrO3q5Jzf1TKeIsnuuEHfSlW57SlUrOQ
         EVlnGO3jZnisHpnbueBEI2PGFhJOHT93a52mMxngVm6BbIXghrrOK2uciXiK0IYy8z9I
         7p03PaXq1HghpdUp3Tj5GiITXqOyDILVyDyskvLWiL+GNsxrUk/hFxhO/oUZ2ULn3fRv
         vjQMYxucbPgT7VIn5ELcZ/EUXmuYrzWs5IEAqZNetV8fQ7winDWs0lK9eTNUmKWj4tbX
         feZDQc1l7RfUY/d3WU+qz2u1r1d7zJeTc/MHnoPor43LlRPDvnDgaRmsSxWm1rEAafsA
         VbNg==
X-Gm-Message-State: APjAAAVJGq2yQec71qvvlZFPvKJi7qOrFxc/nNhutxiziU1hiCWx/C36
        wcq9u/RPDB1nK3XEnKVuLIEeIGsdcnKTJA==
X-Google-Smtp-Source: APXvYqxth98K0tShDu7b/q4uM/GyUqobljOmGn4ySzL3043chwPTK0pHCE5qUfrdNvB1O9P9GME7Bg==
X-Received: by 2002:a1c:6c0c:: with SMTP id h12mr1019962wmc.162.1567537418937;
        Tue, 03 Sep 2019 12:03:38 -0700 (PDT)
Received: from [10.230.33.15] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id 207sm826024wme.17.2019.09.03.12.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 12:03:38 -0700 (PDT)
Subject: Re: [PATCH 2/3] brcmfmac: split brcmf_attach() and brcmf_detach()
 functions
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Winnie Chang <winnie.chang@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20190903042928.18621-1-zajec5@gmail.com>
 <20190903042928.18621-3-zajec5@gmail.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <12d6c6d0-4f7d-dc6a-5a5c-ade8585033fd@broadcom.com>
Date:   Tue, 3 Sep 2019 21:03:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903042928.18621-3-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 9/3/2019 6:29 AM, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Move code allocating/freeing wiphy out of above functions. This will
> allow reinitializing the driver (e.g. on some error) without allocating
> a new wiphy.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>   .../broadcom/brcm80211/brcmfmac/bus.h         |  4 ++-
>   .../broadcom/brcm80211/brcmfmac/core.c        | 33 ++++++++++++++----
>   .../broadcom/brcm80211/brcmfmac/pcie.c        | 13 +++++--
>   .../broadcom/brcm80211/brcmfmac/sdio.c        | 15 ++++++--
>   .../broadcom/brcm80211/brcmfmac/usb.c         | 34 +++++++++++++++----
>   5 files changed, 80 insertions(+), 19 deletions(-)
