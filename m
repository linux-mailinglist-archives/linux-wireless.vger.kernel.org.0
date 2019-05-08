Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBD511751D
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2019 11:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfEHJ1h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 May 2019 05:27:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47888 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfEHJ1h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 May 2019 05:27:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A0A97607DF; Wed,  8 May 2019 09:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557307656;
        bh=FTGoGgY2UosS8irr6YS8M4Uo0dsu6b2XOLQC2LT84Bo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=e300bixBaoS3BIeBwQV0t5KxwtIi3ncyjk6IMcE2sEHhm5HKlBose4qHa49KptsH1
         PbUBrshxqaraYotRhcTEjWZsr07TU3+rfdxyisBzn/l4WlT+0oPGOblBD9cQTuSUW5
         oxfdLOgTNgutEJPFFB1xBVChBZBbsbFvBckuhnGI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from [10.201.26.44] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mpubbise@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 02241608BA;
        Wed,  8 May 2019 09:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557307656;
        bh=FTGoGgY2UosS8irr6YS8M4Uo0dsu6b2XOLQC2LT84Bo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=e300bixBaoS3BIeBwQV0t5KxwtIi3ncyjk6IMcE2sEHhm5HKlBose4qHa49KptsH1
         PbUBrshxqaraYotRhcTEjWZsr07TU3+rfdxyisBzn/l4WlT+0oPGOblBD9cQTuSUW5
         oxfdLOgTNgutEJPFFB1xBVChBZBbsbFvBckuhnGI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 02241608BA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mpubbise@codeaurora.org
Subject: Re: [PATCH v2] {nl,mac}80211: allow 4addr AP operation on crypto
 controlled devices
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
References: <1556881402-28078-1-git-send-email-mpubbise@codeaurora.org>
 <87bm0jwze8.fsf@purkki.adurom.net>
From:   Manikanta Pubbisetty <mpubbise@codeaurora.org>
Message-ID: <3becacd2-4cf1-2f2c-0125-5ce89ca916e6@codeaurora.org>
Date:   Wed, 8 May 2019 14:57:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87bm0jwze8.fsf@purkki.adurom.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/3/2019 4:58 PM, Kalle Valo wrote:

> Manikanta Pubbisetty <mpubbise@codeaurora.org> writes:
>
>> As per the current design, in the case of sw crypto controlled devices,
>> it is the device which advertises the support for AP/VLAN iftype based
>> on it's ability to tranmsit packets encrypted in software
>> (In VLAN functionality, group traffic generated for a specific
>> VLAN group is always encrypted in software). Commit db3bdcb9c3ff
>> ("mac80211: allow AP_VLAN operation on crypto controlled devices")
>> has introduced this change.
>>
>> Since 4addr AP operation also uses AP/VLAN iftype, this conditional
>> way of advertising AP/VLAN support has broken 4addr AP mode operation on
>> crypto controlled devices which do not support VLAN functionality.
>>
>> In the case of ath10k driver, not all firmwares have support for VLAN
>> functionality but all can support 4addr AP operation. Because AP/VLAN
>> support is not advertised for these devices, 4addr AP operations are
>> also blocked.
>>
>> Fix this by allowing 4addr operation on devices which do not support
>> AP/VLAN iftype but can support 4addr AP operation (decision is based on
>> the wiphy flag WIPHY_FLAG_4ADDR_AP).
>>
>> Fixes: Commit db3bdcb9c3ff ("mac80211: allow AP_VLAN operation on crypto controlled devices")
> The correct format for the Fixes line is:
>
> Fixes: db3bdcb9c3ff ("mac80211: allow AP_VLAN operation on crypto controlled devices")

Corrected it in v3.


Thanks,

Manikanta

