Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59D620329D
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 10:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgFVI6Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jun 2020 04:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgFVI6Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jun 2020 04:58:25 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048D2C061794
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2020 01:58:25 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id t194so14892963wmt.4
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2020 01:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QWGvzgHmQIgRwIqzv9/P9Cd3kznv/G2lvdtJFmcntTM=;
        b=YhiPWqajuGXTvI/PgliBY8NUUlTbD5E8BQCHD6SNYFVfYg4fnS0wwWh2S61lxxz4ez
         pQ2Lw2b4M/I/QhvLGNpOgXrK00wPYhe1V4z0YAF2qA0M4ZFPa5RvqOiwNfb7zCKmL9Fd
         ENcq1cv8voBuDrYZhTpdFHFsWo2cYaaVp4T4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QWGvzgHmQIgRwIqzv9/P9Cd3kznv/G2lvdtJFmcntTM=;
        b=LqI+xs3uZwD6QWbWShctlN/z9zyJ66PLIRKF/H3Sk/0qk1aLYOJAs1vsDWi3ggIQO+
         LEV292+Big2qN4rTODdeyoVegdZBPQJzmr94RfaiWv6lfqm0Z1wGpOym04ZxLbg2ML+s
         nF9vqrnmfPdDb+kNTulP6KUssYBvrGX6SgLyZy8SVtuuCJN+mIRAh7nxZxpLp+fvJC9c
         lKeGeqpPADPMTGxr21bbARh85xOYHV1PfZBhdvLHszSj5MJWMsOeouAhIFr5jbtf6MHy
         O7U8HATksu32tIWdWE2ius6XM0HFizf/w4Fh7Vi0+V0ZptfP/WLZKO0nJr80lNqNwzFf
         Fgnw==
X-Gm-Message-State: AOAM532cLhG7aDI8bM4/sUceiBKae9wIOQvtTBVepolt8hcG525hOyvP
        sgTu+FVSyj3T9eFugVCacKur1Q==
X-Google-Smtp-Source: ABdhPJxcEk2BldmRp4rXMyeSToYCtRwvN41LCNcPYebiiqbLo3cIkZM0jG7FDXGjz7fJ0DsCMsoJ0A==
X-Received: by 2002:a05:600c:21d7:: with SMTP id x23mr7363987wmj.1.1592816303673;
        Mon, 22 Jun 2020 01:58:23 -0700 (PDT)
Received: from [192.168.178.129] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id c65sm15743464wme.8.2020.06.22.01.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 01:58:23 -0700 (PDT)
Subject: Re: [PATCH 1/2] brcmfmac: set state of hanger slot to FREE when
 flushing PSQ
To:     Wright Feng <wright.feng@cypress.com>,
        linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com
References: <20200622020721.498-1-wright.feng@cypress.com>
 <20200622020721.498-2-wright.feng@cypress.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <8402643f-7b1f-f6dc-a6f7-c572b95836de@broadcom.com>
Date:   Mon, 22 Jun 2020 10:58:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200622020721.498-2-wright.feng@cypress.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/22/2020 4:07 AM, Wright Feng wrote:
> When USB or SDIO device got abnormal bus disconnection, host driver
> tried to clean up the skbs in PSQ and TXQ (The skb's pointer in hanger
> slot linked to PSQ and TSQ), so we should set the state of skb hanger slot
> to BRCMF_FWS_HANGER_ITEM_STATE_FREE before freeing skb.
> In brcmf_fws_bus_txq_cleanup it already sets
> BRCMF_FWS_HANGER_ITEM_STATE_FREE before freeing skb, therefore we add the
> same thing in brcmf_fws_psq_flush to avoid following warning message.

[...]

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Wright Feng <wright.feng@cypress.com>
> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c | 4 ++++
>   1 file changed, 4 insertions(+)
