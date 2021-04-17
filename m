Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC65362EA3
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Apr 2021 10:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbhDQIuu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Apr 2021 04:50:50 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:52256 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229631AbhDQIut (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Apr 2021 04:50:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618649423; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=GeNOZycx5R7vHLrcn6385Og1TB92F7srY1W9lG3DKt4=;
 b=DOonoOiMTCec/+4jUI73/OG3GJH0VpGz5WPoCX4c/vWWqo6CBHXjPVkWTeybT1bNNnHVb5JK
 aFZSk3aWh2lDoNQ2KTHl7yiRPHqkhegMmlBR49wPubxY29CuF4bbnXx3snTE4zLRkGOHFL2R
 O/ct4FruBIPEN+epznbIeBFHf7o=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 607aa144c39407c32788ad44 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 17 Apr 2021 08:50:12
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 70190C433CA; Sat, 17 Apr 2021 08:50:11 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EE5A1C43462;
        Sat, 17 Apr 2021 08:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EE5A1C43462
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] iwlwifi: Fix softirq/hardirq disabling in
 iwl_pcie_gen2_enqueue_hcmd()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <nycvar.YFH.7.76.2104070918090.12405@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2104070918090.12405@cbobk.fhfr.pm>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210417085011.70190C433CA@smtp.codeaurora.org>
Date:   Sat, 17 Apr 2021 08:50:11 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jiri Kosina <jikos@kernel.org> wrote:

> On Wed, 7 Apr 2021, Heiner Kallweit wrote:
> 
> > Same fix as in 2800aadc18a6 ("iwlwifi: Fix softirq/hardirq disabling in
> > iwl_pcie_enqueue_hcmd()") is needed for iwl_pcie_gen2_enqueue_hcmd.
> > I get the same lockdep warning on AX210.
> 
> Makes sense, it's being called from exactly the same contexts.
> 
> 
> 
> From: Jiri Kosina <jkosina@suse.cz>
> Subject: [PATCH] iwlwifi: Fix softirq/hardirq disabling in iwl_pcie_gen2_enqueue_hcmd()
> 
> Analogically to what we did in 2800aadc18a6 ("iwlwifi: Fix 
> softirq/hardirq disabling in iwl_pcie_enqueue_hcmd()"), we must apply the 
> same fix to iwl_pcie_gen2_enqueue_hcmd(), as it's being called from 
> exactly the same contexts.
> 
> Reported-by: Heiner Kallweit <hkallweit1@gmail.com
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
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

This is malformed in patchwork, check the link below. Please resend, and
I strongly recommend to use git send-email to avoid any format issues.

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/nycvar.YFH.7.76.2104070918090.12405@cbobk.fhfr.pm/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

