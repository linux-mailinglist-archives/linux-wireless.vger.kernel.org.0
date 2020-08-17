Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9E1246436
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Aug 2020 12:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgHQKPw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Aug 2020 06:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbgHQKPs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Aug 2020 06:15:48 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5ECC061342
        for <linux-wireless@vger.kernel.org>; Mon, 17 Aug 2020 03:15:46 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id p25so14476496qkp.2
        for <linux-wireless@vger.kernel.org>; Mon, 17 Aug 2020 03:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xFMCooV+srfeUmENnqHRgCmMMf+HreBw4sTYYL9L8Po=;
        b=S/hC8jiE66W4lYiSJD+JBpmqCQ1NfvjXLtgAW2YghalM2AGd/ropK2OJ5QJdgEzxiH
         0VfSgSO/lBId1OsA+uu31pNhCaZrO04XKj3BVoYxMGceI8XB18gQx328saMF4eRJuhpi
         wqLu1eOZmjesm4ayKqK7XFDelEm81dqVyV/68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xFMCooV+srfeUmENnqHRgCmMMf+HreBw4sTYYL9L8Po=;
        b=L/FKVhHo34vs/CeFYSdrflfrdtGPkX9HujDizk8Mes81T4kzyKvVhsBtbPmmvtSnTR
         2PCfEQYhQtqT8jGTne2VFmFKK3+TT6VOyM9wiXX1kjfsPnPAJSRQY81g+olI6V7QqJeO
         l1qGBqDP2FI20vNrFQPFdyES+MPFg0flF7y+ojOoX0Sqrz27T3eyPiDFFHnZWnqUNtBV
         jvyMXwxRj2M2Saz6nt/oagvJvcEF8oqg+GlfvPMkOB/clNxbrEey0nuiA9pborqeo8UH
         I76R4+q+3lrTWlF6GQmuc3bDL0DZarf510mXkGUsLX6rO8WXPYroENh3+Pwfzup2uDdp
         z5EA==
X-Gm-Message-State: AOAM533Oj21erlp2VEAGgyPNp826wCASRZN7V/NDznR3tDR5ZLetQZVH
        nlleWR6c81mbOTK1arVA8/xWHQ==
X-Google-Smtp-Source: ABdhPJyPDevAynADokoTMbQeVLyLhvINF5Maw120EPlX6HsYIVPaRj7K4bCyVzLV+ICE4a16V6aJTw==
X-Received: by 2002:a05:620a:15b0:: with SMTP id f16mr12024373qkk.191.1597659344690;
        Mon, 17 Aug 2020 03:15:44 -0700 (PDT)
Received: from [10.230.34.187] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id k5sm17317588qke.18.2020.08.17.03.15.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 03:15:44 -0700 (PDT)
Subject: Re: [PATCH 07/16] wireless: brcm80211: convert tasklets to use new
 tasklet_setup() API
To:     Allen Pais <allen.cryptic@gmail.com>, kvalo@codeaurora.org,
        kuba@kernel.org, jirislaby@kernel.org, mickflemm@gmail.com,
        mcgrof@kernel.org, chunkeey@googlemail.com,
        Larry.Finger@lwfinger.net, stas.yakovlev@gmail.com,
        helmut.schaa@googlemail.com, pkshih@realtek.com,
        yhchuang@realtek.com, dsd@gentoo.org, kune@deine-taler.de
Cc:     keescook@chromium.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, b43-dev@lists.infradead.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
References: <20200817090637.26887-1-allen.cryptic@gmail.com>
 <20200817090637.26887-8-allen.cryptic@gmail.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5080db28-3112-7d0a-ec7c-f437f670cfa3@broadcom.com>
Date:   Mon, 17 Aug 2020 12:15:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817090637.26887-8-allen.cryptic@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/17/2020 11:06 AM, Allen Pais wrote:
> From: Allen Pais <allen.lkml@gmail.com>
> 
> In preparation for unconditionally passing the
> struct tasklet_struct pointer to all tasklet
> callbacks, switch to using the new tasklet_setup()
> and from_tasklet() to pass the tasklet pointer explicitly.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> ---
>   .../net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c  | 6 +++---
>   .../net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.h  | 2 +-
>   2 files changed, 4 insertions(+), 4 deletions(-)
