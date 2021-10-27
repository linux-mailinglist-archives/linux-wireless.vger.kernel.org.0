Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1447E43C410
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Oct 2021 09:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238692AbhJ0Hjx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Oct 2021 03:39:53 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:55375 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238693AbhJ0Hjw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Oct 2021 03:39:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635320247; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=z6IQuzopc3OVYw9ggWC3VpZb1xFK8Eb3iFzXALZjgj0=;
 b=f48DYlyFA+jhw8LyfM82ONKePnqnuwI/kwH9ixdPf+BftDT/JkJahfCNuoKupTizL1jG6e10
 Zb4706HrNH2YgJ9ydUM2TP4soe9dZmL7pIETkZEAXWmI5gZTLWl3l+mn3+edn3qtgqESrpG2
 kHw0GLA/HY9pdwaDKaoQbGeptbk=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 617901b15ca800b6c1c8be0a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 Oct 2021 07:37:21
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E7C37C43617; Wed, 27 Oct 2021 07:37:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8F196C4338F;
        Wed, 27 Oct 2021 07:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 8F196C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless-drivers-next] rtw89: fix return value in
 hfc_pub_cfg_chk
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <YXEJey8lKksAZif4@ns.kevlo.org>
References: <YXEJey8lKksAZif4@ns.kevlo.org>
To:     Kevin Lo <kevlo@kevlo.org>
Cc:     linux-wireless@vger.kernel.org, Pkshih <pkshih@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163532023368.30745.12468473810176045324.kvalo@codeaurora.org>
Date:   Wed, 27 Oct 2021 07:37:20 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kevin Lo <kevlo@kevlo.org> wrote:

> It seems to me when pub_cfg->grp0 + pub_cfg->grp1 != pub_cfg->pub_max is true,
> it should return -EFAULT rather than 0.  Otherwise, the function doesn't need 
> to exist.
> 
> Signed-off-by: Kevin Lo <kevlo@kevlo.org>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
> index 69384c43c046..afcd07ab1de7 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac.c
> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
> @@ -560,7 +560,7 @@ static int hfc_pub_cfg_chk(struct rtw89_dev *rtwdev)
>  	const struct rtw89_hfc_pub_cfg *pub_cfg = &param->pub_cfg;
>  
>  	if (pub_cfg->grp0 + pub_cfg->grp1 != pub_cfg->pub_max)
> -		return 0;
> +		return -EFAULT;
>  
>  	return 0;
>  }

Patch applied to wireless-drivers-next.git, thanks.

c6477cb23704 rtw89: fix return value in hfc_pub_cfg_chk

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/YXEJey8lKksAZif4@ns.kevlo.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

