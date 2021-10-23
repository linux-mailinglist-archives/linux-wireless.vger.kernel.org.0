Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A70143822D
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Oct 2021 09:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhJWHTC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Oct 2021 03:19:02 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:14899 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhJWHTB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Oct 2021 03:19:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634973403; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=TaGm+y+n24uIjdUAF4O0wqcwloAq0TO1hoEyBg+xM84=; b=k9fCJgFwNt9tuLa0t06JxaYgM6+RtoBEfsu5NWc/b4KXBLD3zTzLdKdLvQ8mzwpkv6IIWpc0
 N/TIRzM+pqbBP8766wKScOKVmGsFa/LDNlNStO/W9Pi1Ug+5un2PPCexmNnjSJ4qXFBJekVE
 cRcV/ez/UVvFnltlYZLKwxCzyyA=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 6173b6c4c75c436a30e33ef4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 23 Oct 2021 07:16:20
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B83A6C43617; Sat, 23 Oct 2021 07:16:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 81236C4338F;
        Sat, 23 Oct 2021 07:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 81236C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wang Haojun <jiangliuer01@gmail.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-wireless@vger.kernel.org,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Wang Haojun <wanghaojun@loongson.cn>
Subject: Re: [PATCH] drivers:net:wireless:mediatek: fix build warning
References: <20211022013843.3643856-1-wanghaojun@loongson.cn>
Date:   Sat, 23 Oct 2021 10:16:14 +0300
In-Reply-To: <20211022013843.3643856-1-wanghaojun@loongson.cn> (Wang Haojun's
        message of "Fri, 22 Oct 2021 09:38:43 +0800")
Message-ID: <87o87gyzwh.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wang Haojun <jiangliuer01@gmail.com> writes:

> drivers/net/wireless/mediatek/mt76/mt7921/main.c: In function 'mt7921_get_et_stats':
> drivers/net/wireless/mediatek/mt76/mt7921/main.c:1024:26: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'unsigned int' [-Wformat=]
>    dev_err(dev->mt76.dev, "ei: %d  SSTATS_LEN: %lu",
>
> Signed-off-by: Wang Haojun <wanghaojun@loongson.cn>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> index 35a490c049e9..0b456431cb59 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -1021,7 +1021,7 @@ void mt7921_get_et_stats(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>  
>  	ei += wi.worker_stat_count;
>  	if (ei != ARRAY_SIZE(mt7921_gstrings_stats))
> -		dev_err(dev->mt76.dev, "ei: %d  SSTATS_LEN: %lu",
> +		dev_err(dev->mt76.dev, "ei: %d  SSTATS_LEN: %u",
>  			ei, ARRAY_SIZE(mt7921_gstrings_stats));
>  }

Randy used %zu, I'll take that version:

https://patchwork.kernel.org/project/linux-wireless/patch/20211022233251.29987-1-rdunlap@infradead.org/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
