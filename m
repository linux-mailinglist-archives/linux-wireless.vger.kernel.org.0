Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B0B261093
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 13:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbgIHLUo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 07:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729988AbgIHLSe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 07:18:34 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9BEC061573
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 04:18:32 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g29so9821601pgl.2
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 04:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DPhVHm5Yrxe2FB2XOtylUDcuz6wqU+n6Rek/Gj8QDMc=;
        b=DnvdxO7DNfMgF2822srzxO46S7+iUknrOl82Tmyyt7VtUswfPN06weMAagErbpa4LC
         pRlt+sFlA9u3HiYkl1OEgTbFRoLjATIThTuxJjAjdyMLUYLQ8GBr5zpsKEOYexT62HQt
         zcrv6Uq3HUlM91lUn+k7tbTW86pprdhqOtPGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DPhVHm5Yrxe2FB2XOtylUDcuz6wqU+n6Rek/Gj8QDMc=;
        b=Mv6nXxoMvd9I1WqVbx7J/fOmbAuwWqZT+qyWZhJdMEj/bvIPMNOJzPMmpqarm+0t4N
         XkrgNtXjfdFEHjX7mV0U4SIzCUmeEmmAwR4ObeO0/YhaGgLYetzdZkpeiLx05GLnVhYD
         +q2vWe5RWqM5iQst560NtbBdM9dCMPV8xFy0OhF8R10wqam1PqSabzhU0t8C90ehhtu8
         ohiFHCjPipU+KgjVuigisMfi2SVyGAX8u3eMvLyyzSK2c1N5ypK3khVlaD+ewyn0CkA7
         PpjGbA/AgkIEA0oo5TamTqhI/44lvv3tKHI6D75SkEb34zyz+vOfAwhNT2X03Lu8QPS3
         j0GA==
X-Gm-Message-State: AOAM533ud+WWeTHCh4Oby+hYDsz5kuWwheZ6YAuBa2QkQl0baKr0vZ9b
        AY4bBbmumKpsaxgsIIbeekC9+zmAP/Y2ut5O
X-Google-Smtp-Source: ABdhPJw2aKs+cbUI2Gr5JM9a3FiERmT6ihTxueHJ3DXph1yki85dd64nvsBzqMCXIcfeyHvIt9GCZQ==
X-Received: by 2002:aa7:9592:0:b029:13e:d13d:a054 with SMTP id z18-20020aa795920000b029013ed13da054mr657563pfj.26.1599563912366;
        Tue, 08 Sep 2020 04:18:32 -0700 (PDT)
Received: from [10.230.32.194] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id a15sm10046542pfi.119.2020.09.08.04.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 04:18:31 -0700 (PDT)
Subject: Re: [PATCH] brcmsmac: fix memory leak in wlc_phy_attach_lcnphy
To:     Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Cc:     takafumi@sslab.ics.keio.ac.jp,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <linux-wireless@vger.kernel.org>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <brcm80211-dev-list@cypress.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <bad4e33a-af2f-b44f-63e5-56386c312a91@broadcom.com>
 <20200908001324.8215-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <c13ee142-d69d-6d21-6373-acb56507c9ec@broadcom.com>
Date:   Tue, 8 Sep 2020 13:18:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908001324.8215-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/8/2020 2:13 AM, Keita Suzuki wrote:
> When wlc_phy_txpwr_srom_read_lcnphy fails in wlc_phy_attach_lcnphy,
> the allocated pi->u.pi_lcnphy is leaked, since struct brcms_phy will be
> freed in the caller function.
> 
> Fix this by calling wlc_phy_detach_lcnphy in the error handler of
> wlc_phy_txpwr_srom_read_lcnphy before returning.

Thanks for resubmitting the patch addressing my comment. For clarity it 
is recommended to mark the subject with '[PATCH V2]' and add a ...

> Signed-off-by: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
> ---
... changelog here describing difference between previous patch and this 
version.

Regards,
Arend
---
>   .../net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c    | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
