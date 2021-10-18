Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAE24316D7
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 13:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhJRLJZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 07:09:25 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:54910 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbhJRLJY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 07:09:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634555233; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=zItCPIgZagRD58HmhiL9Pr610x9SuZMe7FKQZkPGLY4=; b=dFVxXFXxwew/skYNozC4FP8ezwTK0aNiFUhATegY/dgx+AMFj3iQe3eih70mkLXVSYQsFY76
 eBKftQuuvDKvqaeguqJW7pbpl81fhT6YH1Byp7g2ez5Q/+oJJnQDr+Q8gwTa/tVxBNDukWKo
 MF5UQh6AX2cqEyblY2jP2jCDCqA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 616d5554f3e5b80f1fc34a79 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 18 Oct 2021 11:07:00
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BE22CC4338F; Mon, 18 Oct 2021 11:06:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5D138C4338F;
        Mon, 18 Oct 2021 11:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 5D138C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6 2/7] iwlwifi: mei: add the driver to allow cooperation with CSME
References: <20210811105541.43426-1-emmanuel.grumbach@intel.com>
        <20210811105541.43426-2-emmanuel.grumbach@intel.com>
Date:   Mon, 18 Oct 2021 14:06:53 +0300
In-Reply-To: <20210811105541.43426-2-emmanuel.grumbach@intel.com> (Emmanuel
        Grumbach's message of "Wed, 11 Aug 2021 13:55:36 +0300")
Message-ID: <87lf2qvbg2.fsf@codeaurora.org>
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

s-o-b missing from Ayala, same problem also in other patches in this
patchset.

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
