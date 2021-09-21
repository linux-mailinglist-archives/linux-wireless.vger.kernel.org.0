Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D9E41344A
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Sep 2021 15:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbhIUNfs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Sep 2021 09:35:48 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:63359 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232953AbhIUNfq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Sep 2021 09:35:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632231258; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=hAvfZ9ESfkozWP0fbCDPlt3WOMpwq47orE00kCxxB98=;
 b=AqYgMzYQXp742ouOZQypLF6b+mkFEZ2cjiPFVmY23S9UHbDJqRWct8cSIU2jkLMcFF23r4Pa
 DLtlUZ55i/3viyN1OzqJoAlsmWVbhCHtdwb16h0oUUC5dZAuhFnZanJxr0ISesH7Gx0PnDsh
 fSeqb/ftyM74ij2yVqdVr/f8sfA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 6149df426c4c0e0dc3fb9d94 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 21 Sep 2021 13:33:54
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DB7ABC43460; Tue, 21 Sep 2021 13:33:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5F461C4338F;
        Tue, 21 Sep 2021 13:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 5F461C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/2] wcn36xx: Fix Antenna Diversity Switching
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210909144428.2564650-2-bryan.odonoghue@linaro.org>
References: <20210909144428.2564650-2-bryan.odonoghue@linaro.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-wireless@vger.kernel.org, wcn36xx@lists.infradead.org,
        loic.poulain@linaro.org, benl@squareup.com,
        bryan.odonoghue@linaro.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210921133353.DB7ABC43460@smtp.codeaurora.org>
Date:   Tue, 21 Sep 2021 13:33:53 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:

> We have been tracking a strange bug with Antenna Diversity Switching (ADS)
> on wcn3680b for a while.
> 
> ADS is configured like this:
>    A. Via a firmware configuration table baked into the NV area.
>        1. Defines if ADS is enabled.
>        2. Defines which GPIOs are connected to which antenna enable pin.
>        3. Defines which antenna/GPIO is primary and which is secondary.
> 
>    B. WCN36XX_CFG_VAL(ANTENNA_DIVERSITY, N)
>       N is a bitmask of available antenna.
> 
>       Setting N to 3 indicates a bitmask of enabled antenna (1 | 2).
> 
>       Obviously then we can set N to 1 or N to 2 to fix to a particular
>       antenna and disable antenna diversity.
> 
>    C. WCN36XX_CFG_VAL(ASD_PROBE_INTERVAL, XX)
>       XX is the number of beacons between each antenna RSSI check.
>       Setting this value to 50 means, every 50 received beacons, run the
>       ADS algorithm.
> 
>    D. WCN36XX_CFG_VAL(ASD_TRIGGER_THRESHOLD, YY)
>       YY is a two's complement integer which specifies the RSSI decibel
>       threshold below which ADS will run.
>       We default to -60db here, meaning a measured RSSI <= -60db will
>       trigger an ADS probe.
> 
>    E. WCN36XX_CFG_VAL(ASD_RTT_RSSI_HYST_THRESHOLD, Z)
>       Z is a hysteresis value, indicating a delta which the RSSI must
>       exceed for the antenna switch to be valid.
> 
>       For example if HYST_THRESHOLD == 3 AntennaId1-RSSI == -60db and
>       AntennaId-2-RSSI == -58db then firmware will not switch antenna.
>       The threshold needs to be -57db or better to satisfy the criteria.
> 
>    F. A firmware feature bit also exists ANTENNA_DIVERSITY_SELECTION.
>       This feature bit is used by the firmware to report if
>       ANTENNA_DIVERSITY_SELECTION is supported. The host is not required to
>       toggle this bit to enable or disable ADS.
> 
> ADS works like this:
> 
>     A. Every XX beacons the firmware switches to or remains on the primary
>        antenna.
> 
>     B. The firmware then sends a Request-To-Send (RTS) packet to the AP.
> 
>     C. The firmware waits for a Clear-To-Send (CTS) response from the AP.
> 
>     D. The firmware then notes the received RSSI on the CTS packet.
> 
>     E. The firmware then repeats steps A-D on the secondary antenna.
> 
>     F. Subsequently if the RSSI on the measured antenna is better than
>        ASD_TRIGGER_THRESHOLD + the active antenna's RSSI then the
>        measured antenna becomes the active antenna.
> 
>     G. If RSSI rises past ASD_TRIGGER_THRESHOLD then ADS doesn't run at
>        all even if there is a substantially better RSSI on the alternative
>        antenna.
> 
> What we have been observing is that the RTS packet is being sent but the
> MAC address is a byte-swapped version of the target MAC. The ADS/RTS MAC is
> corrupted only when the link is encrypted, if the AP is open the RTS MAC is
> correct. Similarly if we configure the firmware to an RTS/CTS sequence for
> regular data - the transmitted RTS MAC is correctly formatted.
> 
> Internally the wcn36xx firmware uses the indexes in the SMD commands to
> populate and extract data from specific entries in an STA lookup table. The
> AP's MAC appears a number of times in different indexes within this lookup
> table, so the MAC address extracted for the data-transmit RTS and the MAC
> address extracted for the ADS/RTS packet are not the same STA table index.
> 
> Our analysis indicates the relevant firmware STA table index is
> "bssSelfStaIdx".
> 
> There is an STA populate function responsible for formatting the MAC
> address of the bssSelfStaIdx including byte-swapping the MAC address.
> 
> Its clear then that the required STA populate command did not run for
> bssSelfStaIdx.
> 
> So taking a look at the sequence of SMD commands sent to the firmware we
> see the following downstream when moving from an unencrypted to encrypted
> BSS setup.
> 
> - WLAN_HAL_CONFIG_BSS_REQ
> - WLAN_HAL_CONFIG_STA_REQ
> - WLAN_HAL_SET_STAKEY_REQ
> 
> Upstream in wcn36xx we have
> 
> - WLAN_HAL_CONFIG_BSS_REQ
> - WLAN_HAL_SET_STAKEY_REQ
> 
> The solution then is to add the missing WLAN_HAL_CONFIG_STA_REQ between
> WLAN_HAL_CONFIG_BSS_REQ and WLAN_HAL_SET_STAKEY_REQ.
> 
> No surprise WLAN_HAL_CONFIG_STA_REQ is the routine responsible for
> populating the STA lookup table in the firmware and once done the MAC sent
> by the ADS routine is in the correct byte-order.
> 
> This bug is apparent with ADS but it is also the case that any other
> firmware routine that depends on the "bssSelfStaIdx" would retrieve
> malformed data on an encrypted link.
> 
> Fixes: 3e977c5c523d ("wcn36xx: Define wcn3680 specific firmware parameters")
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Tested-by: Benjamin Li <benl@squareup.com>
> Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

2 patches applied to ath-next branch of ath.git, thanks.

701668d3bfa0 wcn36xx: Fix Antenna Diversity Switching
c0c2eb20c79e wcn36xx: Add ability for wcn36xx_smd_dump_cmd_req to pass two's complement

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210909144428.2564650-2-bryan.odonoghue@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

