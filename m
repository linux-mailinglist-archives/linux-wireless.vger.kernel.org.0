Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788A73B3472
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jun 2021 19:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhFXRL7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Jun 2021 13:11:59 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:32310 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhFXRL7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Jun 2021 13:11:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624554580; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=WQuY0nYS7UfBiq+zMay9vlSzWY4jQbcvNpyaCd2+B2k=; b=hq13d6IXVpZlb0Zw1oYSH2A64AAUaQfx170rqhKES/VMhcz4OkPi9g4ut+VcIy0s2p2JwJ1V
 LTVR6rMvDoVmXUO2xEFTwQKa2GY531V3hDQT4hMqq5FEReSB1P8CpJkkNSyIn0Oiaos/sKpT
 xt0nA+/HkaujrTYHzW78X08UoXI=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60d4bc1a7b2963a282931489 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 24 Jun 2021 17:08:42
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 717D0C433F1; Thu, 24 Jun 2021 17:08:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E3BDDC433F1;
        Thu, 24 Jun 2021 17:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E3BDDC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc:     luciano.coelho@intel.com, linux-wireless@vger.kernel.org,
        Ayala Beker <ayala.beker@intel.com>
Subject: Re: [PATCH v3 4/4] iwlwifi: mvm: add vendor commands needed for iwlmei
References: <20210623141033.27475-1-emmanuel.grumbach@intel.com>
        <20210623141033.27475-4-emmanuel.grumbach@intel.com>
Date:   Thu, 24 Jun 2021 20:08:37 +0300
In-Reply-To: <20210623141033.27475-4-emmanuel.grumbach@intel.com> (Emmanuel
        Grumbach's message of "Wed, 23 Jun 2021 17:10:33 +0300")
Message-ID: <87fsx7i416.fsf@codeaurora.org>
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
> ---
>  drivers/net/wireless/intel/iwlwifi/Kconfig    |  11 ++
>  .../net/wireless/intel/iwlwifi/mvm/Makefile   |   1 +
>  .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   2 +
>  drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   9 +-
>  .../wireless/intel/iwlwifi/mvm/vendor-cmd.c   | 186 ++++++++++++++++++
>  5 files changed, 203 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/vendor-cmd.c
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/Kconfig b/drivers/net/wireless/intel/iwlwifi/Kconfig
> index 629aaa26a230..f91516d08b28 100644
> --- a/drivers/net/wireless/intel/iwlwifi/Kconfig
> +++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
> @@ -92,11 +92,22 @@ config IWLWIFI_BCAST_FILTERING
>  	  If unsure, don't enable this option, as some programs might
>  	  expect incoming broadcasts for their normal operations.
>  
> +config IWLMVM_VENDOR_CMDS
> +	bool "Enable vendor commands"
> +	depends on IWLMVM
> +	help
> +	  This option enables support for vendor commands, including some
> +	  that don't have their own Kconfig option. Other Kconfig options
> +	  depend on this one as well.
> +
> +	  This is not enabled by default, if unsure, say N.

Why do we need a new Kconfig option? Why not always include it in the
compilation?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
