Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F63C43170D
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 13:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhJRLWL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 07:22:11 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:11980 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhJRLWL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 07:22:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634556000; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=XHDOLCoEw29pzzYLlcxkV+SBXa2u1OY0D+AAJy2cDYw=; b=kfPBbP+zRNpZ4CiaWOyOgH0FdRmH5z5ODBHF0YfVUyg+BWNO9UvubAuReKb+tEe3f+upO78c
 yLv//qQDdgqZMCDelLqtlP/pitOVlZHybCeWFjRvms8Zd4VcdPNF9lIFutkX5aCXOHsyNuYv
 N1oEX4e4bfuiPZuf+oYN5j6dV28=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 616d584c835b7947c106f0a8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 18 Oct 2021 11:19:40
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9256EC43460; Mon, 18 Oct 2021 11:19:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4FC3DC4338F;
        Mon, 18 Oct 2021 11:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 4FC3DC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6 6/7] iwlwifi: mvm: add vendor commands needed for iwlmei
References: <20210811105541.43426-1-emmanuel.grumbach@intel.com>
        <20210811105541.43426-6-emmanuel.grumbach@intel.com>
Date:   Mon, 18 Oct 2021 14:19:36 +0300
In-Reply-To: <20210811105541.43426-6-emmanuel.grumbach@intel.com> (Emmanuel
        Grumbach's message of "Wed, 11 Aug 2021 13:55:40 +0300")
Message-ID: <87czo2vauv.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Emmanuel Grumbach <emmanuel.grumbach@intel.com> writes:

> Add the vendor commands that must be used by the network manager
> to allow proper operation of iwlmei.
>
> * Send information on the AP CSME is connected to
> * Notify the userspace when roaming is forbidden
> * Allow the userspace to require ownership
>
> Co-Developed-by: Ayala Beker <ayala.beker@intel.com>
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[...]

> --- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
> @@ -1952,16 +1952,16 @@ void iwl_mvm_enter_ctkill(struct iwl_mvm *mvm);
>  int iwl_mvm_send_temp_report_ths_cmd(struct iwl_mvm *mvm);
>  int iwl_mvm_ctdp_command(struct iwl_mvm *mvm, u32 op, u32 budget);
>  
> -#ifdef CONFIG_IWLMVM_VENDOR_CMDS
> +#if IS_ENABLED(CONFIG_IWLMEI)
>  
>  /* vendor commands */
>  void iwl_mvm_vendor_cmds_register(struct iwl_mvm *mvm);
>  
> -#else // IWLMVM_VENDOR_CMDS
> +#else // CONFIG_IWLMEI
>  
>  static inline void iwl_mvm_vendor_cmds_register(struct iwl_mvm *mvm) {}
>  
> -#endif // IWLMVM_VENDOR_CMDS
> +#endif // CONFIG_IWLMEI

No C++ style comments, please.

> --- /dev/null
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/vendor-cmd.c
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
> + * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
> + * Copyright (C) 2016-2017 Intel Deutschland GmbH
> + */
> +#include "mvm.h"
> +#include <linux/nl80211-vnd-intel.h>
> +
> +static const struct nla_policy
> +iwl_mvm_vendor_attr_policy[NUM_IWL_MVM_VENDOR_ATTR] = {
> +	[IWL_MVM_VENDOR_ATTR_ROAMING_FORBIDDEN] = { .type = NLA_U8 },
> +	[IWL_MVM_VENDOR_ATTR_AUTH_MODE] = { .type = NLA_U32 },
> +	[IWL_MVM_VENDOR_ATTR_CHANNEL_NUM] = { .type = NLA_U8 },
> +	[IWL_MVM_VENDOR_ATTR_SSID] = { .type = NLA_BINARY,
> +				       .len = IEEE80211_MAX_SSID_LEN },
> +	[IWL_MVM_VENDOR_ATTR_BAND] = { .type = NLA_U8 },
> +	[IWL_MVM_VENDOR_ATTR_COLLOC_CHANNEL] = { .type = NLA_U8 },
> +	[IWL_MVM_VENDOR_ATTR_COLLOC_ADDR] = { .type = NLA_BINARY, .len = ETH_ALEN },
> +};
> +
> +__maybe_unused static struct nlattr **
> +iwl_mvm_parse_vendor_data(const void *data, int data_len)
> +{
> +	struct nlattr **tb;
> +	int err;
> +
> +	if (!data)
> +		return ERR_PTR(-EINVAL);
> +
> +	tb = kcalloc(MAX_IWL_MVM_VENDOR_ATTR + 1, sizeof(*tb), GFP_KERNEL);
> +	if (!tb)
> +		return ERR_PTR(-ENOMEM);
> +
> +	err = nla_parse(tb, MAX_IWL_MVM_VENDOR_ATTR, data, data_len,
> +			iwl_mvm_vendor_attr_policy, NULL);
> +	if (err) {
> +		kfree(tb);
> +		return ERR_PTR(err);
> +	}
> +
> +	return tb;
> +}

I was wondering why you had __maybe_unused but when noticed you are not
really using this function anywhere. So why not just remove it?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
