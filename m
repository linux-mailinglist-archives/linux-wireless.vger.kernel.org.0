Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DAD3B348A
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jun 2021 19:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhFXRTR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Jun 2021 13:19:17 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:53519 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhFXRTR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Jun 2021 13:19:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624555018; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=TDMlMwVHpT4wL9YpN23QlpPNP1sICyqS7tChfbxI3Kw=; b=SDRZ9P0B22toq14I+YFLI1HykzUelLwWJMnOiKUC8XHKDnMYD2TrgTidRu4/YeTI4IiVG0q0
 KmOdUxTbIVLuZOBjFV9iODX/FrsABDyyNxYDATaUT+TlZlbDumioMKyy3FqCNT8wsncgEXgf
 NC9UnRgSPc5huS/4F1B+/75zrFY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60d4bdf42a2a9a9761f2c01f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 24 Jun 2021 17:16:36
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DDD98C433F1; Thu, 24 Jun 2021 17:16:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EC1F8C433D3;
        Thu, 24 Jun 2021 17:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EC1F8C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc:     luciano.coelho@intel.com, linux-wireless@vger.kernel.org,
        Ayala Beker <ayala.beker@intel.com>
Subject: Re: [PATCH v3 1/4] iwlwifi: mei: add the driver to allow cooperation with CSME
References: <20210623141033.27475-1-emmanuel.grumbach@intel.com>
Date:   Thu, 24 Jun 2021 20:16:30 +0300
In-Reply-To: <20210623141033.27475-1-emmanuel.grumbach@intel.com> (Emmanuel
        Grumbach's message of "Wed, 23 Jun 2021 17:10:30 +0300")
Message-ID: <87bl7vi3o1.fsf@codeaurora.org>
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
>
> Networking in CSME
> ------------------
> For those uses cases, CSME's firmware has an embedded network
> stack and is able to use the network devices of the system: LAN
> and WLAN. This is thanks to the CSME's firmware WLAN driver.
>
> One can add a profile (SSID / key / certificate) to the CSME's OS
> and CSME will connect to that profile. Then, one can use the WLAN
> link to access the applications that run on CSME (AMT is one of
> them). Note that CSME is active during power state and power state
> transitions. For example, it is possible to have a KVM session
> open to the system while the system is rebooting and actually
> configure the BIOS remotely over WLAN thanks to AMT.
>
> How all this is related to Linux
> --------------------------------
> In Linux, there is a driver that allows the OS to talk to the
> CSME firmware, this driver is drivers/misc/mei. This driver
> advertises a bus that allows other kernel drivers or even user
> space) to talk to components inside the CSME firmware.
> In practice, the system advertises a PCI device that allows
> to send / receive data to / from the CSME firmware. The mei
> bus drivers in drivers/misc/mei is an abstration on top of
> this PCI device.
> The driver being added here is called iwlmei and talks to the
> WLAN driver inside the CSME firmware through the mei bus driver.
> Note that the mei bus driver only gives bus services, it doesn't
> define the content of the communication.
>
> Why do we need this driver?
> --------------------------
> CSME uses the same WLAN device that the OS is expecting to see
> hence we need an arbitration mechanism. This is what iwlmei is
> in charge of. iwlmei maintains the communication with the CSME
> firmware's WLAN driver. The language / protocol that is used
> between the CSME's firmware WLAN driver and iwlmei is OS agnostic
> and is called SAP which stands for Software Abritration Protocol.
> With SAP, iwlmei will be able to tell the CSME firmware's WLAN
> driver:
> 1) Please give me the device.
> 2) Please note that the SW/HW rfkill state change.
> 3) Please note that I am now associated to X.
> 4) Please note that I received this packet.
> etc...
>
> There are messages that go the opposite direction as well:
> 1) Please note that AMT is en/disable.
> 2) Please note that I believe the OS is broken and hence I'll take
>    the device *now*, whether you like it or not, to make sure that
>    connectivity is preserved.
> 3) Please note that I am willing to give the device if the OS
>    needs it.
> 4) Please give me any packet that is sent on UDP / TCP on IP address
>    XX.XX.XX.XX and an port ZZ.
> 5) Please send this packet.
> etc...
>
> Please check drivers/net/wireless/intel/iwlwifi/mei/sap.h for the
> full protocol specification.
>
> Arbitration is not the only purpose of iwlmei and SAP. SAP also
> allows to maintain the AMT's functionality even when the OS owns
> the device. To connect to AMT, one needs to initiate an HTTP
> connection to port 16992. iwlmei will listen to the Rx path and
> forward (through SAP) to the CSME firmware the data it got. Then,
> the embedded HTTP server in the chipset will reply to the request
> and send a SAP notification to ask iwlmei to send the reply.
> This way, AMT running on the CSME can still work.
>
> In practice this means that all the use cases quoted above (KVM,
> remote IDE device, etc...) will work even when the OS uses the
> WLAN device.
>
> How to disable all this?
> ---------------------------
> iwlmei won't be able to do anything if the CSME's networking stack
> is not enabled. By default, CSME's networking stack is disabled (this
> is a BIOS setting).
> In case the CSME's networking stack is disabled, iwlwifi will just
> get access to the device because there is no contention with any other
> actor and, hence, no arbitration is needed.
>
> In this patch, I only add the iwlmei driver. Integration with
> iwlwifi will be implemented in the next one.
>
> Co-Developed-by: Ayala Beker <ayala.beker@intel.com>
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
> v2: fix a few warnings raised by the different bots
> v3: rewrite the commit message

Thank you for the great commit log, now I understand what this is about.
I'm not able to do thorough review but my first quick comments.


[...]

> +	BUILD_BUG_ON((u32)IWL_MEI_AKM_AUTH_OPEN !=
> +		     (u32)SAP_WIFI_AUTH_TYPE_OPEN);
> +	BUILD_BUG_ON((u32)IWL_MEI_AKM_AUTH_RSNA !=
> +		     (u32)SAP_WIFI_AUTH_TYPE_RSNA);
> +	BUILD_BUG_ON((u32)IWL_MEI_AKM_AUTH_RSNA_PSK !=
> +		     (u32)SAP_WIFI_AUTH_TYPE_RSNA_PSK);
> +	BUILD_BUG_ON((u32)IWL_MEI_AKM_AUTH_SAE !=
> +		     (u32)SAP_WIFI_AUTH_TYPE_SAE);
> +
> +	BUILD_BUG_ON((u32)IWL_MEI_CIPHER_NONE !=
> +		     (u32)SAP_WIFI_CIPHER_ALG_NONE);
> +	BUILD_BUG_ON((u32)IWL_MEI_CIPHER_CCMP !=
> +		     (u32)SAP_WIFI_CIPHER_ALG_CCMP);
> +	BUILD_BUG_ON((u32)IWL_MEI_CIPHER_GCMP !=
> +		     (u32)SAP_WIFI_CIPHER_ALG_GCMP);
> +	BUILD_BUG_ON((u32)IWL_MEI_CIPHER_GCMP_256 !=
> +		     (u32)SAP_WIFI_CIPHER_ALG_GCMP_256);

These look just weird, and suspicious. You are using two different enums
but they have to be same values, or what?

> +static void iwl_mei_dbgfs_register(struct iwl_mei *mei)
> +{
> +	mei->dbgfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
> +
> +	if (!mei->dbgfs_dir)
> +		return;
> +
> +	init_waitqueue_head(&mei->debugfs_wq);
> +
> +	debugfs_create_ulong("status", S_IRUSR,
> +			     mei->dbgfs_dir, &iwl_mei_status);
> +	debugfs_create_file("send_start_message", S_IWUSR, mei->dbgfs_dir,
> +			    mei, &iwl_mei_dbgfs_send_start_message_ops);
> +	debugfs_create_file("req_ownserhip", S_IWUSR, mei->dbgfs_dir,
> +			    mei, &iwl_mei_dbgfs_req_ownership_ops);
> +}

The commit log mentions nothing about debugfs interface. I recommend
moving them to a separate patch for easier review and explaining what
these do.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
