Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51D726C6FF
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Sep 2020 20:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgIPSOZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Sep 2020 14:14:25 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:45156 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727498AbgIPSON (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Sep 2020 14:14:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600280052; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=Pd5uhe/W8UlMjCmlPzB8XUm+VW1r6wiAg/jjHPWXtV0=; b=riEG5XElP9BxuxnId9YUFfr3b+IZfAw/NYToW2UPJtUqOa6QwN6WoFoFBRMPSvspvHRD4EQC
 k5avjRsIyXLUeX3IDuVoDvGAioM4HN3VJNFtBX6Qgo8Tb4JjU0iTCsMVQn+gzOHeTyl15uwW
 /IPCaf4iPK8Zql2QGOvRn3P2awI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f621f8a24954b1631bfea5f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 16 Sep 2020 14:22:02
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D76F4C433CA; Wed, 16 Sep 2020 14:22:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4839EC433C8;
        Wed, 16 Sep 2020 14:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4839EC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     greearb@candelatech.com
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath11k:  Support loading ELF board files.
References: <20200826232044.6799-1-greearb@candelatech.com>
Date:   Wed, 16 Sep 2020 17:21:57 +0300
In-Reply-To: <20200826232044.6799-1-greearb@candelatech.com>
        (greearb@candelatech.com's message of "Wed, 26 Aug 2020 16:20:44
        -0700")
Message-ID: <874knxkdiy.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

greearb@candelatech.com writes:

> From: Ben Greear <greearb@candelatech.com>
>
> The QCA6390 board I have, model 8291M-PR comes with an ELF board
> file.  To get this to at least somewhat work, I renamed bdwlan.e04
> to 'board.bin' and then added this patch to check for .ELF as
> starting bytes of the board file.  If that is found, use type
> ELF.  After this the driver loads.
>
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>
> This is on top of recent kvallo ath tree.
>
>  drivers/net/wireless/ath/ath11k/qmi.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
> index 91134510364c..f87f1d1564f4 100644
> --- a/drivers/net/wireless/ath/ath11k/qmi.c
> +++ b/drivers/net/wireless/ath/ath11k/qmi.c
> @@ -1992,6 +1992,7 @@ static int ath11k_qmi_load_bdf_qmi(struct ath11k_base *ab)
>  	struct qmi_txn txn = {};
>  	int ret;
>  	const u8 *temp;
> +	int bdf_type = ATH11K_QMI_BDF_TYPE_BIN;
>  
>  	req = kzalloc(sizeof(*req), GFP_KERNEL);
>  	if (!req)
> @@ -2008,6 +2009,15 @@ static int ath11k_qmi_load_bdf_qmi(struct ath11k_base *ab)
>  	temp = bd.data;
>  	remaining = bd.len;
>  
> +	if (bd.len >= 4) {
> +		char* edata = (char*)(temp);
> +		if (edata[1] == 'E' &&
> +		    edata[2] == 'L' &&
> +		    edata[3] == 'F') {
> +			bdf_type = ATH11K_QMI_BDF_TYPE_ELF;
> +		}
> +	}

Thanks, looks good. Expect that the ELF magic check can be simplified to:

strncmp(edata, ELFMAG, SELFMAG)

But I can send v2, I'll soon send some more QCA6390 patches and I'll
include this to the set.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
