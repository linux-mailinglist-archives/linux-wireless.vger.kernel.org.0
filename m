Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95EB736491C
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Apr 2021 19:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239478AbhDSRgz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Apr 2021 13:36:55 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:62755 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233228AbhDSRgx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Apr 2021 13:36:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618853783; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=KLekV0lBsS5OL+sq91tRrjErtiBFo8EvmBiEgRjWfDY=;
 b=YsinDKit17uWkEL5CRF3khXtF0mg9CSQ4Q36tvTDzfJ85ttyyy+0wvBSucLoT8yCCAaFmjZo
 hZXYNvpZ41HW3Tip86TuTQEn9tAey3boZDvaHvpsTqIhl8YVKqKW1CFaa2/d1xJgsA1W/bS+
 pmtdWYc94CbtpY13xJ2xTPJMgzQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 607dbf9387ce1fbb5656a82b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 19 Apr 2021 17:36:19
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A015CC4338A; Mon, 19 Apr 2021 17:36:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 508CBC433F1;
        Mon, 19 Apr 2021 17:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 508CBC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] iwlwifi: Fix softirq/hardirq disabling in
 iwl_pcie_gen2_enqueue_hcmd()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <nycvar.YFH.7.76.2104171112390.18270@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2104171112390.18270@cbobk.fhfr.pm>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210419173618.A015CC4338A@smtp.codeaurora.org>
Date:   Mon, 19 Apr 2021 17:36:18 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jiri Kosina <jikos@kernel.org> wrote:

> From: Jiri Kosina <jkosina@suse.cz>
> 
> Analogically to what we did in 2800aadc18a6 ("iwlwifi: Fix softirq/hardirq 
> disabling in iwl_pcie_enqueue_hcmd()"), we must apply the same fix to 
> iwl_pcie_gen2_enqueue_hcmd(), as it's being called from exactly the same 
> contexts.
> 
> Reported-by: Heiner Kallweit <hkallweit1@gmail.com
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
> index 4456abb9a074..34bde8c87324 100644
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
> @@ -40,6 +40,7 @@ int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
>  	const u8 *cmddata[IWL_MAX_CMD_TBS_PER_TFD];
>  	u16 cmdlen[IWL_MAX_CMD_TBS_PER_TFD];
>  	struct iwl_tfh_tfd *tfd;
> +	unsigned long flags;
>  
>  	copy_size = sizeof(struct iwl_cmd_header_wide);
>  	cmd_size = sizeof(struct iwl_cmd_header_wide);
> @@ -108,14 +109,14 @@ int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
>  		goto free_dup_buf;
>  	}
>  
> -	spin_lock_bh(&txq->lock);
> +	spin_lock_irqsave(&txq->lock, flags);
>  
>  	idx = iwl_txq_get_cmd_index(txq, txq->write_ptr);
>  	tfd = iwl_txq_get_tfd(trans, txq, txq->write_ptr);
>  	memset(tfd, 0, sizeof(*tfd));
>  
>  	if (iwl_txq_space(trans, txq) < ((cmd->flags & CMD_ASYNC) ? 2 : 1)) {
> -		spin_unlock_bh(&txq->lock);
> +		spin_unlock_irqrestore(&txq->lock, flags);
>  
>  		IWL_ERR(trans, "No space in command queue\n");
>  		iwl_op_mode_cmd_queue_full(trans->op_mode);
> @@ -250,7 +251,7 @@ int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
>  	spin_unlock(&trans_pcie->reg_lock);
>  
>  out:
> -	spin_unlock_bh(&txq->lock);
> +	spin_unlock_irqrestore(&txq->lock, flags);
>  free_dup_buf:
>  	if (idx < 0)
>  		kfree(dup_buf);

Patch applied to wireless-drivers.git, thanks.

e7020bb068d8 iwlwifi: Fix softirq/hardirq disabling in iwl_pcie_gen2_enqueue_hcmd()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/nycvar.YFH.7.76.2104171112390.18270@cbobk.fhfr.pm/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

