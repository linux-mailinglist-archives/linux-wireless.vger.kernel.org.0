Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7210464982
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 09:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241951AbhLAIYx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 03:24:53 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:40512 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhLAIYw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 03:24:52 -0500
Received: by mail-wr1-f44.google.com with SMTP id t9so33343300wrx.7
        for <linux-wireless@vger.kernel.org>; Wed, 01 Dec 2021 00:21:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oHdlszQVZ99/3g/OmIoBt1OQpuvpVb42iXCN2y5Wl0Y=;
        b=NOnOPo+26QBsSbSZjrusC7Tu+V+Jjf+nefias9H0Sd8Ft4KgfURMB1z0xu2xH4DFj3
         7zeGiex2vYZUo13DLr4TseUhoqcL3K/nQE89NwkAiVJndoNkl3Jxhq2AgWEQ4pRNOty7
         0r9jTe1Lpu2W2O58VGDX70QO1WSMQ66XbJXoxu3rqzzdwIOIGobazeqnna+Bti/5qEw0
         o7XMUBS4mPtfhc2J7NpUK3Le7/7Guvz61BEUxneUQ7fwuK0EJK0vrE2w8H1TL1qGI3+3
         9H8E3fhQi/akyK0tc0pgJjJQ9LucxE9LMZ7ESM49DOVL8yLYxOe0unhoQukXIV+CsHP/
         Emkg==
X-Gm-Message-State: AOAM53210vo49CFPCvgoxKma0/QckKmXQ6QSsMcq5+yVKPwRX0uSxLFv
        wLORFMDDyLJPfxQNpA7TQPk=
X-Google-Smtp-Source: ABdhPJyuAcyqaVEK3K3KU0INxrQMnNyYtaQ4sLlA0SCaDfuTOZjFXzHBn8lwd6cSiRfndfCLAHj88A==
X-Received: by 2002:a5d:584c:: with SMTP id i12mr4865495wrf.95.1638346891184;
        Wed, 01 Dec 2021 00:21:31 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id az15sm294103wmb.0.2021.12.01.00.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 00:21:30 -0800 (PST)
Message-ID: <0c26baa6-6e43-338e-5814-fac957c7b116@kernel.org>
Date:   Wed, 1 Dec 2021 09:21:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v8 2/6] iwlwifi: mei: add the driver to allow cooperation
 with CSME
Content-Language: en-US
To:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
References: <20211112062814.7502-1-emmanuel.grumbach@intel.com>
 <20211112062814.7502-2-emmanuel.grumbach@intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20211112062814.7502-2-emmanuel.grumbach@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12. 11. 21, 7:28, Emmanuel Grumbach wrote:
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

Hi,

this patch causes link failures:
 > MODPOST modules-only.symvers
 > ERROR: modpost: "__SCT__tp_func_iwlmei_sap_data" 
[drivers/net/wireless/intel/iwlwifi/mei/iwlmei.ko] undefined!
 > ERROR: modpost: "__SCT__tp_func_iwlmei_me_msg" 
[drivers/net/wireless/intel/iwlwifi/mei/iwlmei.ko] undefined!
 > ERROR: modpost: "__tracepoint_iwlmei_sap_cmd" 
[drivers/net/wireless/intel/iwlwifi/mei/iwlmei.ko] undefined!
 > ERROR: modpost: "__tracepoint_iwlmei_me_msg" 
[drivers/net/wireless/intel/iwlwifi/mei/iwlmei.ko] undefined!
 > ERROR: modpost: "__SCK__tp_func_iwlmei_me_msg" 
[drivers/net/wireless/intel/iwlwifi/mei/iwlmei.ko] undefined!
 > ERROR: modpost: "__SCK__tp_func_iwlmei_sap_data" 
[drivers/net/wireless/intel/iwlwifi/mei/iwlmei.ko] undefined!
 > ERROR: modpost: "__tracepoint_iwlmei_sap_data" 
[drivers/net/wireless/intel/iwlwifi/mei/iwlmei.ko] undefined!
 > ERROR: modpost: "__SCT__tp_func_iwlmei_sap_cmd" 
[drivers/net/wireless/intel/iwlwifi/mei/iwlmei.ko] undefined!
 > ERROR: modpost: "__SCK__tp_func_iwlmei_sap_cmd" 
[drivers/net/wireless/intel/iwlwifi/mei/iwlmei.ko] undefined!
 > make[1]: *** [../scripts/Makefile.modpost:134: modules-only.symvers] 
Error 1
 > make: *** [../Makefile:1904: modules] Error 2

with this config:
https://raw.githubusercontent.com/openSUSE/kernel-source/linux-next/config/x86_64/vanilla

regards,
-- 
js
suse labs
