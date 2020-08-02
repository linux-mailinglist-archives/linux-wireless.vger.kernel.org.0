Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081042357E8
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Aug 2020 17:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgHBPGn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 11:06:43 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:22210 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgHBPGn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 11:06:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596380802; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=waeX7Yh3nSptYH/d182ZI3VUb2Mwgd5D+6lAVj7w2iU=;
 b=dCx7SY6tANuxN/ryYL5ocuXXpr/vLyvcwe9R2pM/gFhCdr8R/4GkoatRB2r8vm47Q6ZfaKdK
 s3NBvDXezNKv0oq+/fC+0viIhpvjOK2XK2eEzJ1aNqpkdV+tFWup2bWofVl60xMRjvskRVoD
 NUorIJYSMAfkOyZX5h+Um6Ur68A=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n16.prod.us-west-2.postgun.com with SMTP id
 5f26d6720825c301ea5c7d7b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 02 Aug 2020 15:06:26
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E78CDC43391; Sun,  2 Aug 2020 15:06:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B0C2DC433C9;
        Sun,  2 Aug 2020 15:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B0C2DC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH -next] rtw88: 8821c: make symbol
 'rtw8821c_rtw_pwr_track_tbl'
 static
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200721134901.33968-1-weiyongjun1@huawei.com>
References: <20200721134901.33968-1-weiyongjun1@huawei.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Hulk Robot <hulkci@huawei.com>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Tzu-En Huang" <tehuang@realtek.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200802150625.E78CDC43391@smtp.codeaurora.org>
Date:   Sun,  2 Aug 2020 15:06:25 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wei Yongjun <weiyongjun1@huawei.com> wrote:

> The sparse tool complains as follows:
> 
> drivers/net/wireless/realtek/rtw88/rtw8821c.c:1374:32: warning:
>  symbol 'rtw8821c_rtw_pwr_track_tbl' was not declared. Should it be static?
> 
> This variable is not used outside of rtw8821c.c, so this commit
> marks it static.
> 
> Fixes: 3a4312828ce1 ("rtw88: 8821c: add power tracking")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Patch applied to wireless-drivers-next.git, thanks.

9de6959f8584 rtw88: 8821c: make symbol 'rtw8821c_rtw_pwr_track_tbl' static

-- 
https://patchwork.kernel.org/patch/11675705/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

