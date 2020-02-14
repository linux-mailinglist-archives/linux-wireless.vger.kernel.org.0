Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB08A15D794
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2020 13:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgBNMoW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Feb 2020 07:44:22 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:40876 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727822AbgBNMoW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Feb 2020 07:44:22 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581684261; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=+Y5h6QDo8Oc94LScKBPp12Fcw839PLjczUL5n8w+4qE=;
 b=qGsIRKlyW4o1keczD2kzD91R4effCNjf85ForAnBbzy2bNr55DqRW7xgi3jE3h81cfd/MWgP
 5YjlKu2eAMJD6pCxtcvz0aLf6ucO8cuDKQgyrSH91q15aQFn0znuHW73w3sixN15cgrhEVVd
 aLM/M7awrw1Lo+Pqv75n0xC+ZqA=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e469624.7f63eced7ca8-smtp-out-n01;
 Fri, 14 Feb 2020 12:44:20 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D3ABEC4479D; Fri, 14 Feb 2020 12:44:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6686AC43383;
        Fri, 14 Feb 2020 12:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6686AC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: remove unneeded variable
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200213052000.GA15671@ns.kevlo.org>
References: <20200213052000.GA15671@ns.kevlo.org>
To:     Kevin Lo <kevlo@kevlo.org>
Cc:     Yan-Hsuan Chuang <yhchuang@realtek.com>,
        linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200214124420.D3ABEC4479D@smtp.codeaurora.org>
Date:   Fri, 14 Feb 2020 12:44:20 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kevin Lo <kevlo@kevlo.org> wrote:

> Remove unneeded fab_version variable in rtw_chip_parameter_setup().
> Some of the checks being made were nonsense.
> 
> Signed-off-by: Kevin Lo <kevlo@kevlo.org>
> 
> diff d49f2c5063fdd00f896e408a1c1fa63e6d94a767 /home/kevlo/wireless-drivers-next
> blob - 2f73820cd9ba542ebb632267a9460ea87ddcc2a5
> file + drivers/net/wireless/realtek/rtw88/main.c
> --- drivers/net/wireless/realtek/rtw88/main.c
> +++ drivers/net/wireless/realtek/rtw88/main.c
> @@ -1118,7 +1118,6 @@ static int rtw_chip_parameter_setup(struct rtw_dev *rt
>  	}
>  
>  	hal->chip_version = rtw_read32(rtwdev, REG_SYS_CFG1);
> -	hal->fab_version = BIT_GET_VENDOR_ID(hal->chip_version) >> 2;
>  	hal->cut_version = BIT_GET_CHIP_VER(hal->chip_version);
>  	hal->mp_chip = (hal->chip_version & BIT_RTL_ID) ? 0 : 1;
>  	if (hal->chip_version & BIT_RF_TYPE_ID) {
> @@ -1132,11 +1131,6 @@ static int rtw_chip_parameter_setup(struct rtw_dev *rt
>  		hal->antenna_tx = BB_PATH_A;
>  		hal->antenna_rx = BB_PATH_A;
>  	}
> -
> -	if (hal->fab_version == 2)
> -		hal->fab_version = 1;
> -	else if (hal->fab_version == 1)
> -		hal->fab_version = 2;
>  
>  	efuse->physical_size = chip->phy_efuse_size;
>  	efuse->logical_size = chip->log_efuse_size;
> blob - c074cef22120a222948cfab03ca0bd25baa80844
> file + drivers/net/wireless/realtek/rtw88/main.h
> --- drivers/net/wireless/realtek/rtw88/main.h
> +++ drivers/net/wireless/realtek/rtw88/main.h
> @@ -1527,7 +1527,6 @@ struct rtw_hal {
>  	u32 rcr;
>  
>  	u32 chip_version;
> -	u8 fab_version;
>  	u8 cut_version;
>  	u8 mp_chip;
>  	u8 oem_id;

Failed to apply, please rebase on top of wireless-drivers-next.

fatal: sha1 information is lacking or useless (net/wireless/realtek/rtw88/main.c).
error: could not build fake ancestor
Applying: rtw88: remove unneeded variable
Patch failed at 0001 rtw88: remove unneeded variable
The copy of the patch that failed is found in: .git/rebase-apply/patch

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/11379873/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
