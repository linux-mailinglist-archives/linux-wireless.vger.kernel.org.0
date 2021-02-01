Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6343530B248
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Feb 2021 22:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhBAVsX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Feb 2021 16:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhBAVsR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Feb 2021 16:48:17 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CC0C061756
        for <linux-wireless@vger.kernel.org>; Mon,  1 Feb 2021 13:47:31 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id o16so13020096pgg.5
        for <linux-wireless@vger.kernel.org>; Mon, 01 Feb 2021 13:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=3jrybrZXt/b8n85ODtKeUfuhoYR0zahuJQZ5wiSQlzo=;
        b=IJxDv9cnOzJcP7D1qRq5hv6GEqCDerCAexj1WliDB9nKLO59T8Ad56+k8H9wlKGayV
         FV+4OuDVN4hgvAhH2HiJUFapyQ/RyuKUqPf9dCJIOrpAxIT15LTHl3HDSq2F1HwAaLD/
         PS4c966O/2fDKeeCNd4rntZ0HTOBPzkBAaoqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3jrybrZXt/b8n85ODtKeUfuhoYR0zahuJQZ5wiSQlzo=;
        b=p5xvXg27C+M+uFxSj2NvI3CHN6wa5wUFB13aCyiNiNvLOibgY1Fz+bcBja01Z301Bi
         ZGjUy8qEacaLbPzNEM/SG6NRIXD05Fh4m1GvwJXlUP0ogN67PJvkIY+io0qKGSUYCjnD
         722plRI2H5ZiqScA9cfiRCCjSxTAF4uSVAwZW3vG3ZduHg8WOC+XezE5ZFcz/ZnQjWn3
         IckxiBJaNg+Mei9rc0HMnzJw7a8ewbTzorbMofoYAsjbHK2noLDGuHf/4SS1Dpcfxb+3
         HU/qR083GpW/eBWRAKyOVVDp2fUT0THGKulB2YTMcXCgQLf/yLD3l7ekA1sTcT6BDCcK
         sKDA==
X-Gm-Message-State: AOAM533SyPbpzU6KSQW8gW8z1ZDidb4l8PMgFRSg0Y4mvtwI03JwtMwM
        qkCgx7WU/owi4fwKD3x57aRERA==
X-Google-Smtp-Source: ABdhPJw5C96PqE/ogjf1MYJgWK71uL6BpMTHYebb4lLz+gUEhPWju06nZGjvHP7oUy2X9mMgF+w/mg==
X-Received: by 2002:a63:9811:: with SMTP id q17mr19079307pgd.238.1612216050662;
        Mon, 01 Feb 2021 13:47:30 -0800 (PST)
Received: from [192.168.4.200] (107-196-182-50.lightspeed.sntcca.sbcglobal.net. [107.196.182.50])
        by smtp.gmail.com with ESMTPSA id 6sm18558803pfd.212.2021.02.01.13.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 13:47:30 -0800 (PST)
Subject: Re: [PATCH] ath11k: fix a locking bug in ath11k_mac_op_start()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Carl Huang <cjhuang@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <YBfy+zc3XkiyIe6t@mwanda>
From:   Peter Oh <peter.oh@eero.com>
Message-ID: <896a68dd-02ec-4fe3-3fbf-ec1bd2decefe@eero.com>
Date:   Mon, 1 Feb 2021 13:47:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YBfy+zc3XkiyIe6t@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2/1/21 4:24 AM, Dan Carpenter wrote:
> This error path leads to a Smatch warning:
>
>      drivers/net/wireless/ath/ath11k/mac.c:4269 ath11k_mac_op_start()
>      error: double unlocked '&ar->conf_mutex' (orig line 4251)
>
> We're not holding the lock when we do the "goto err;" so it leads to a
> double unlock.  We should hold the lock because the error path sets
> "ar->state" so the right fix is to take the lock before doing the goto.
>
> Fixes: c83c500b55b6 ("ath11k: enable idle power save mode")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>   drivers/net/wireless/ath/ath11k/mac.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> index c1608f64ea95..12e981e9e3d7 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -4259,6 +4259,7 @@ static int ath11k_mac_op_start(struct ieee80211_hw *hw)
>   						1, pdev->pdev_id);
>   		if (ret) {
>   			ath11k_err(ab, "failed to enable idle ps: %d\n", ret);
> +			mutex_lock(&ar->conf_mutex);
>   			goto err;
>   		}
>   	}
It seems moving idle_ps condition in between ath11k_wmi_pdev_lro_cfg() 
and mutex_unlock()
  is a better way in this case.

Thanks,
Peter
