Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0E418AE4D
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2020 09:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbgCSI2L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Mar 2020 04:28:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33028 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgCSI2L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Mar 2020 04:28:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id a25so1602641wrd.0
        for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2020 01:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BfODBdhJNRdEMXGL905qRE8sbBR5iK6Bp9OR3WIPZjo=;
        b=fanlmFpc+PKu0Yg3XY6h4osltTXyrkNluL28H+X4HCGZ217A2s9reVFpaR6vd9e/Wi
         onE1qcwq150K36KD+sbO1LjHxqHuB1c5soLGZSCw3bB4+v46R7bqcEzo0kYBeZwxKctT
         DE+T/EEA3GKi7U0EgZnInjZSoXIDMxsOOTg0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BfODBdhJNRdEMXGL905qRE8sbBR5iK6Bp9OR3WIPZjo=;
        b=jc6IAikDL9ymA0wEOnnC7zAIwNtvAUTzPekIuaK3YD5frQbIKzybBmhV68KgTs2jxO
         8hQTBxKSyG+A2OaJbuiA0FVXQt73fDn/BIzwKFRb4oOOedM10rK7y08UITv/s2E3ZYe5
         ApqFVV1agPZ37/6kH8FUuBywt68AsJKDBToP3prhZlF62h4/sQUMkqPmsq8lPRfJ1FKw
         14454njksl+F3x66U9xJtBp+8mfgEqc2uJxEZcugRjv/0EteqdSlU+2NUrgz5Ib3VzlB
         2RXqXoqmShLt/GOHVvR6pjfTCPMK6gnFxl91eVfE2TNGIszybkVljGIJ0UjaUnJZ18bS
         vH8g==
X-Gm-Message-State: ANhLgQ1Ercos/NRrFI9a7pxrb5k3zNun4+avc1U8GmEoxsb4e3KTa5I5
        Lb7D4gT/qbx8zY0mg/D1KAXxFg==
X-Google-Smtp-Source: ADFU+vu7lhCdvfmXUtY+8+iKadpcjrYS3ZtJUy7Cn1dinzbOBZMnwMigZL1FNR4tjeW2ulTbClwB4A==
X-Received: by 2002:adf:f3c8:: with SMTP id g8mr230179wrp.351.1584606489389;
        Thu, 19 Mar 2020 01:28:09 -0700 (PDT)
Received: from [10.230.41.113] ([192.19.215.251])
        by smtp.gmail.com with ESMTPSA id w81sm2107146wmg.19.2020.03.19.01.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 01:28:08 -0700 (PDT)
Subject: Re: [PATCH 2/3] brcmfmac: make firmware eap_restrict a module
 parameter
To:     Wright Feng <wright.feng@cypress.com>, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, kvalo@codeaurora.org,
        chi-hsien.lin@cypress.com
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
References: <1584604406-15452-1-git-send-email-wright.feng@cypress.com>
 <1584604406-15452-3-git-send-email-wright.feng@cypress.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <aa29c77c-cfe4-3d71-1860-f9bcb9e0282b@broadcom.com>
Date:   Thu, 19 Mar 2020 09:28:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1584604406-15452-3-git-send-email-wright.feng@cypress.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/19/2020 8:53 AM, Wright Feng wrote:
> When eap_restrict is enabled, firmware will toss non-802.1x frames from
> tx/rx data path if station not yet authorized.
> Internal firmware eap_restrict is disabled by default. This patch makes
> it possible to enable firmware eap_restrict by specifying
> eap_restrict=1 as module parameter.

What is the reason for not having this toss behavior as default? Don't 
see much reason for having the module parameter.

> Signed-off-by: Wright Feng <wright.feng@cypress.com>
> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 9 +++++++++
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c   | 5 +++++
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h   | 2 ++
>   3 files changed, 16 insertions(+)
