Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8F243169F
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 12:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhJRK66 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 06:58:58 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:40734 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229603AbhJRK65 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 06:58:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634554606; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=aeurzMVDmnR4B0SiFrZ5o4IWsU/znRnV2jsBe13mP8Q=; b=eu44tw4om4gD3SqSlLgNbFBn6a3pR8kIceJ0zTgaS5DvoNm/i34nz5mxnh4B90P+m63m6psJ
 aXciSCqsI5DPgkoqAci2q/5NDcQuI3f9s86On/EYp2QFt4RvmkRgH+wOpetCxheogfTNj4Pe
 z7w8m71c2yxRl3XqDKQQ5rqkDSc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 616d52edf3e5b80f1fba5cae (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 18 Oct 2021 10:56:45
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6FC71C43616; Mon, 18 Oct 2021 10:56:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4A19EC4338F;
        Mon, 18 Oct 2021 10:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 4A19EC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6 2/7] iwlwifi: mei: add the driver to allow cooperation with CSME
References: <20210811105541.43426-1-emmanuel.grumbach@intel.com>
        <20210811105541.43426-2-emmanuel.grumbach@intel.com>
Date:   Mon, 18 Oct 2021 13:56:41 +0300
In-Reply-To: <20210811105541.43426-2-emmanuel.grumbach@intel.com> (Emmanuel
        Grumbach's message of "Wed, 11 Aug 2021 13:55:36 +0300")
Message-ID: <87tuhevbx2.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Emmanuel Grumbach <emmanuel.grumbach@intel.com> writes:

> CSME in two words
> -----------------
> CSME stands for Converged Security and Management Engine. It is
> a CPU on the chipset and runs a dedicated firmware.
> AMT (Active Management Technology) is one of the applications
> that run on that CPU. AMT allows to control the platform remotely.
> Here is a partial list of the use cases:
> * View the screen of the plaform, with keyboard and mouse (KVM)
> * Attach a remote IDE device
> * Have a serial console to the device
> * Query the state of the platform
> * Reset / shut down / boot the platform

[...]

> --- a/drivers/net/wireless/intel/iwlwifi/Kconfig
> +++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
> @@ -92,6 +92,23 @@ config IWLWIFI_BCAST_FILTERING
>  	  If unsure, don't enable this option, as some programs might
>  	  expect incoming broadcasts for their normal operations.
>  
> +config IWLMEI
> +	tristate "Intel Management Engine communication over WLAN"
> +	depends on INTEL_MEI
> +	depends on PM
> +	depends on IWLMVM
> +	help
> +	  Enables the iwlmei kernel module. This allows to communicate with
> +	  the Intel Management Engine over Wifi. This is supported starting
> +	  from Tiger Lake platforms and has been tested on 9260 devices only.
> +	  Enabling this option on a platform that has a different device and
> +	  has Wireless enabled on AMT can prevent WiFi from working correctly.

I don't understand the last sentence, please elaborate. Are you saying
that enabling CONFIG_IWLMEI will break wi-fi in some cases?

> +	  For more information see
> +	  <https://software.intel.com/en-us/manageability/>
> +
> +	  If unsure, say N.

IMHO the help text still contains too much Intel jargon to be really
understandable by everyone. I think the commit log pretty well
summarises what this is all about:

  "CSME stands for Converged Security and Management Engine. It is a CPU
   on the chipset and runs a dedicated firmware. AMT (Active Management
   Technology) is one of the applications that run on that CPU. AMT
   allows to control the platform remotely."

Somehow including that information to the Kconfig help text would be
very helpful to everyone.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
