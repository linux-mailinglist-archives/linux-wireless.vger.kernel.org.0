Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2D64316C1
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 13:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhJRLGK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 07:06:10 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:39896 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbhJRLGJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 07:06:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634555038; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=loFM59LIVPdcJ4HC9TxTbh7SG2phM+p9tC0wxzXQgRg=; b=lkgrm5h1IKwCIvodanPIXQ/opYWJNXvTZgOS/Rm+m4C9qLLWCrz6StyZsb7GfYvWrHb0khtD
 hrc7CRoyP6N8WubQkeW+w7cM9tk713yHNn+FzM3ItyEvqPT9myYk3BFgb40ZlO4mm3Kujd2X
 oQ0RQXQWCsaei8WMtdfn44nGYew=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 616d5498ea41a97c24370bac (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 18 Oct 2021 11:03:52
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F1BEBC4360C; Mon, 18 Oct 2021 11:03:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E0B4EC4360D;
        Mon, 18 Oct 2021 11:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org E0B4EC4360D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6 4/7] iwlwifi: integrate with iwlmei
References: <20210811105541.43426-1-emmanuel.grumbach@intel.com>
        <20210811105541.43426-4-emmanuel.grumbach@intel.com>
Date:   Mon, 18 Oct 2021 14:03:46 +0300
In-Reply-To: <20210811105541.43426-4-emmanuel.grumbach@intel.com> (Emmanuel
        Grumbach's message of "Wed, 11 Aug 2021 13:55:38 +0300")
Message-ID: <87pms2vbl9.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Emmanuel Grumbach <emmanuel.grumbach@intel.com> writes:

> iwlmei needs to know about the follwing events:
>
> * Association
> * De-association
> * Country Code change
> * SW Rfkill change
> * SAR table changes
>
> iwlmei can take the device away from us, so report the new
> rfkill type when this happens.
> Advertise the required data from the CSME firmware to the
> usersapce: mostly, the AP that the CSME firmware is currently
> associated to in case there is an active link protection
> session.
> Generate the HOST_ASSOC / HOST_DISSASSOC messages.
>
> Don't support WPA1 (non-RSNA) for now.
> Don't support shared wep either.
> We can then determine the AUTH parameter by checking the AKM.
> Feed the cipher from the key installation.
>
> SW Rfkill will be implemented later when cfg80211 will
> allow us to read the SW Rfkill state.
>
> Co-Developed-by: Ayala Beker <ayala.beker@intel.com>
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[...]

> @@ -1932,6 +1952,17 @@ void iwl_mvm_enter_ctkill(struct iwl_mvm *mvm);
>  int iwl_mvm_send_temp_report_ths_cmd(struct iwl_mvm *mvm);
>  int iwl_mvm_ctdp_command(struct iwl_mvm *mvm, u32 op, u32 budget);
>  
> +#ifdef CONFIG_IWLMVM_VENDOR_CMDS
> +
> +/* vendor commands */
> +void iwl_mvm_vendor_cmds_register(struct iwl_mvm *mvm);
> +
> +#else // IWLMVM_VENDOR_CMDS
> +
> +static inline void iwl_mvm_vendor_cmds_register(struct iwl_mvm *mvm) {}
> +
> +#endif // IWLMVM_VENDOR_CMDS

Shouldn't this be in patch 6?

And no C++ style comments, please.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
