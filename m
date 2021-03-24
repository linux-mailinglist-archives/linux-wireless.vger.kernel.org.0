Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B16347872
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Mar 2021 13:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbhCXMZS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Mar 2021 08:25:18 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:60646 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbhCXMYu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Mar 2021 08:24:50 -0400
Received: from [192.168.254.6] (unknown [50.34.172.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id D899F13C2B0;
        Wed, 24 Mar 2021 05:24:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com D899F13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1616588690;
        bh=9uZ9ygerWRh4M0fClXS+9WlqNiV5BGpkAxTA42DiP7E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RzYVKhAsMRmMKpSiMC2CmSobL5ImjITZxPVUARJVKsMp2hy0H1w59ESMU2PLxA+L0
         fECm064E+zrMa1t6W4Y5NSo6K7MW5P3L66Y37wTbe6x8rEwxypa7PC69DwISrg+Rk0
         +ELiYsO/GQ9PZ5PMGGOUboFgDeOJdO5Ar6ZK49a4=
Subject: Re: Intel AX210 does not work on 5.11
To:     Paulius Zaleckas <paulius.zaleckas@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     luciano.coelho@intel.com
References: <CAPiS6wC4BBANaY62sV8hxreDBsHXTHr=NKFLrOLc6SOYEiztmg@mail.gmail.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <05fc5ab7-58b4-ac63-be21-bff9d5fc0ad0@candelatech.com>
Date:   Wed, 24 Mar 2021 05:24:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAPiS6wC4BBANaY62sV8hxreDBsHXTHr=NKFLrOLc6SOYEiztmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/24/21 5:21 AM, Paulius Zaleckas wrote:
> It was working on 5.10.16:
> [    4.274856] iwlwifi 0000:3c:00.0: enabling device (0000 -> 0002)
> [    4.279014] iwlwifi 0000:3c:00.0: api flags index 2 larger than
> supported by driver
> [    4.279031] iwlwifi 0000:3c:00.0: TLV_FW_FSEQ_VERSION: FSEQ
> Version: 93.8.63.28
> [    4.279401] iwlwifi 0000:3c:00.0: loaded firmware version
> 59.601f3a66.0 ty-a0-gf-a0-59.ucode op_mode iwlmvm
> [    4.456228] iwlwifi 0000:3c:00.0: Detected Intel(R) Wi-Fi 6 AX210
> 160MHz, REV=0x420
> [    4.607524] iwlwifi 0000:3c:00.0: invalid TLV len: 8/12
> [    4.673134] iwlwifi 0000:3c:00.0: base HW address: d8:f8:83:d9:35:87
> [    6.055731] iwlwifi 0000:3c:00.0: invalid TLV len: 8/12
> [    6.288461] iwlwifi 0000:3c:00.0: invalid TLV len: 8/12
> [   72.546602] iwlwifi 0000:3c:00.0 wlan0: disabling HT/VHT/HE as
> WMM/QoS is not supported by the AP
> 
> And fails to start on 5.11.8:
> [    3.882744] iwlwifi 0000:3c:00.0: enabling device (0000 -> 0002)
> [    3.937708] iwlwifi 0000:3c:00.0: api flags index 2 larger than
> supported by driver
> [    3.937720] iwlwifi 0000:3c:00.0: TLV_FW_FSEQ_VERSION: FSEQ
> Version: 93.8.63.28
> [    3.937891] iwlwifi 0000:3c:00.0: loaded firmware version
> 59.601f3a66.0 ty-a0-gf-a0-59.ucode op_mode iwlmvm
> [    4.341262] iwlwifi 0000:3c:00.0: Detected Intel(R) Wi-Fi 6 AX210
> 160MHz, REV=0x420
> [    4.486405] iwlwifi 0000:3c:00.0: loaded PNVM version 0x324cd670
> [    4.588212] iwlwifi 0000:3c:00.0: Timeout waiting for PNVM load!
> [    4.588213] iwlwifi 0000:3c:00.0: Failed to start RT ucode: -110
> [    4.588215] iwlwifi 0000:3c:00.0: iwl_trans_send_cmd bad state = 1
> [    4.796206] iwlwifi 0000:3c:00.0: firmware didn't ACK the reset -
> continue anyway
> [    4.808321] iwlwifi 0000:3c:00.0: Failed to run INIT ucode: -110
> 
> Please add me to Cc as I am not on the list.
> 

You probably need to get latest firmware from https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git
and splat the intel related firmware into /lib/firmware/

This is the pnvm that is on my system:

-rw-r--r--   1 root root  1455104 Mar  9 16:42 iwlwifi-ty-a0-gf-a0-62.ucode
-rw-r--r--   1 root root  1292672 Mar 10 08:40 iwlwifi-cc-a0-62.ucode
-rw-r--r--   1 root root    27456 Mar 19 10:25 iwlwifi-ty-a0-gf-a0.pnvm

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
