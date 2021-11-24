Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1410B45B5C7
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Nov 2021 08:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbhKXHtf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Nov 2021 02:49:35 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:27188 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhKXHte (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Nov 2021 02:49:34 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637739985; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=tJQORLqe0Yurb6+bG9qvYorNXDfQLQsIDeVyDCBW9ho=; b=BGu/HGcFaiTvb3s1PApJx6NNVSYttkV7OnG+pIkxdVTC+oD3mUE5aqBWzUcqYn8QydjC8dyJ
 QQ1uBTuRaybczHHc9u8UTu201bylf5BfWEQtL9vsYMD4xXJknOQss4EfCcfTpGKRmcRCPzWG
 /ELhcJrEMfmOxdM2ZL9aBvmDGvY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 619dedd05daaeec797519559 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 24 Nov 2021 07:46:24
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6F1F6C43617; Wed, 24 Nov 2021 07:46:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8FACAC4338F;
        Wed, 24 Nov 2021 07:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 8FACAC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Fabio Estevam <festevam@denx.de>,
        Wen Gong <quic_wgong@quicinc.com>, ath10k@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        erik.stromdahl@gmail.com, alagusankar@silex-india.com
Subject: Re: [PATCH] ath10k: Clean the HI_ACS_FLAGS_ALT_DATA_CREDIT_SIZE flag
References: <20210915160422.2839595-1-festevam@denx.de>
        <CAOMZO5AYUxJg4bWudT3L1P=qNR2UBcNR1zmjCf5O9_ExyPw4ww@mail.gmail.com>
        <CAOMZO5AJ8q06YTHP=p84nJnKOYU+=MKVqJ3qz3XnUGcAg0xo=g@mail.gmail.com>
Date:   Wed, 24 Nov 2021 09:46:19 +0200
In-Reply-To: <CAOMZO5AJ8q06YTHP=p84nJnKOYU+=MKVqJ3qz3XnUGcAg0xo=g@mail.gmail.com>
        (Fabio Estevam's message of "Wed, 24 Nov 2021 00:26:32 -0300")
Message-ID: <87ilwi6lo4.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fabio Estevam <festevam@gmail.com> writes:

> Hi Kalle,
>
> On Mon, Nov 15, 2021 at 3:06 PM Fabio Estevam <festevam@gmail.com> wrote:
>>
>> Hi Kalle,
>>
>> On Wed, Sep 15, 2021 at 1:05 PM Fabio Estevam <festevam@denx.de> wrote:
>> >
>> > On an imx6dl-pico-pi board with a QCA9377 SDIO chip, the following
>> > errors are observed when the board works in STA mode:
>> >
>> > Simply running "ssh user@192.168.0.1" causes:
>> >
>> > [   55.824159] ath10k_sdio mmc1:0001:1: failed to transmit packet, dropping: -12
>> > [   55.832169] ath10k_sdio mmc1:0001:1: failed to submit frame: -12
>> > [   55.838529] ath10k_sdio mmc1:0001:1: failed to push frame: -12
>> > [   55.905863] ath10k_sdio mmc1:0001:1: failed to transmit packet, dropping: -12
>> > [   55.913650] ath10k_sdio mmc1:0001:1: failed to submit frame: -12
>> > [   55.919887] ath10k_sdio mmc1:0001:1: failed to push frame: -12
>> >
>> > and it is not possible to connect via ssh to the other machine.
>> >
>> > One user inspected the size of frames on Wireshark and reported
>> > the followig:
>> >
>> > "I was able to narrow the issue down to the mtu. If I set the mtu for
>> > the wlan0 device to 1486 instead of 1500, the issue does not happen.
>> >
>> > The size of frames that I see on Wireshark is exactly 1500 after
>> > setting it to 1486."
>> >
>> > Clearing the HI_ACS_FLAGS_ALT_DATA_CREDIT_SIZE avoids the problem and
>> > the ssh command works successfully after that.
>> >
>> > Tested with QCA9377 SDIO with firmware WLAN.TF.1.1.1-00061-QCATFSWPZ-1.
>> >
>> > Fixes: 2f918ea98606 ("ath10k: enable alt data of TX path for sdio")
>> > Signed-off-by: Fabio Estevam <festevam@denx.de>
>>
>> A gentle ping on this one.
>
> Any comments, please? Without this fix, we can not log via ssh to other machine.

I don't have much time for ath10k nowadays, so expect long delays in
reviews.

I'm worried that this breaks QCA6174 SDIO support. Wen, what do you
think of this? Is this because of differences between firmware versions
or what?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
