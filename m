Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C473A572D
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Jun 2021 11:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhFMJEI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Jun 2021 05:04:08 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:54155 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhFMJEI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Jun 2021 05:04:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623574927; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=dQoeZwVu2n9jRfR6UQm6hwPctLkAmGru9+XJJja6Lvo=; b=bM7i2EE403jSuvCXhhcDrE6jkhikvPUG2QRTEqa5nN0EWXXChwDLDCpRGJUixGaa+fHNh4f5
 Zh+UwBdKnDXX87+OKAGCkHWunhDXsyZq+k4Xiy5XaWlgcq0RU1fYhduICwkPiVsM6PzaS/Y3
 8fM9/6nA2Bww/f/sQ81qPLKYQgo=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 60c5c98c8491191eb36e29ba (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 13 Jun 2021 09:02:04
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7794AC433D3; Sun, 13 Jun 2021 09:02:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3D256C433D3;
        Sun, 13 Jun 2021 09:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3D256C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Caleb Connolly <caleb@connolly.tech>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ath10k: demote chan info without scan request warning
References: <20210522171609.299611-1-caleb@connolly.tech>
        <20210612103640.2FD93C433F1@smtp.codeaurora.org>
        <f39034ea-f4da-1564-e22f-398e4a1ae077@connolly.tech>
Date:   Sun, 13 Jun 2021 12:01:56 +0300
In-Reply-To: <f39034ea-f4da-1564-e22f-398e4a1ae077@connolly.tech> (Caleb
        Connolly's message of "Sat, 12 Jun 2021 13:00:57 +0000")
Message-ID: <871r96yw6z.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Caleb Connolly <caleb@connolly.tech> writes:

> Hi Kalle,
>
> On 12/06/2021 11:36 am, Kalle Valo wrote:
>> Caleb Connolly <caleb@connolly.tech> wrote:
>>
>>> Some devices/firmwares cause this to be printed every 5-15 seconds,
>>> though it has no impact on functionality. Demote this to a debug
>>> message.
>>>
>>> Signed-off-by: Caleb Connolly <caleb@connolly.tech>
>>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>
> Is this meant to be an Ack?

No, my patchwork script has few quirks and it actually takes the quoted
text from my pending branch, not from your actual email. That's why you
see my s-o-b there. I haven't bothered to fix that yet, but hopefully
one day.

>> On what hardware and firmware version do you see this?
>
> I see this on SDM845 and MSM8998 platforms, specifically the OnePlus 6
> devices, PocoPhone F1 and OnePlus 5.
> On the OnePlus 6 (SDM845) we are stuck with the following signed vendor fw:
>
> [    9.339873] ath10k_snoc 18800000.wifi: qmi chip_id 0x30214
> chip_family 0x4001 board_id 0xff soc_id 0x40030001
> [    9.339897] ath10k_snoc 18800000.wifi: qmi fw_version 0x20060029
> fw_build_timestamp 2019-07-12 02:14 fw_build_id
> QC_IMAGE_VERSION_STRING=WLAN.HL.2.0.c8-00041-QCAHLSWMTPLZ-1
>
> The OnePlus 5 (MSM8998) is using firmware:
>
> [ 6096.956799] ath10k_snoc 18800000.wifi: qmi chip_id 0x30214
> chip_family 0x4001 board_id 0xff soc_id 0x40010002
> [ 6096.956824] ath10k_snoc 18800000.wifi: qmi fw_version 0x1007007e
> fw_build_timestamp 2020-04-14 22:45 fw_build_id
> QC_IMAGE_VERSION_STRING=WLAN.HL.1.0.c6-00126-QCAHLSWMTPLZ-1.211883.1.278648.

Thanks, I'll include this information to the commit log and then apply
the patch. And I'll assume you have also tested this patch on those
platforms so that I can add a Tested-on tag?

BTW, ath10k should strip that ugly "QC_IMAGE_VERSION_STRING=" string in
the firmware version. Patches very welcome :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
