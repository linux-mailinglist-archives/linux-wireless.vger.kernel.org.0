Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C24459024
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 15:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239555AbhKVO1B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 09:27:01 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:43758 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239182AbhKVO1A (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 09:27:00 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637591034; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=ebyEI9ZM2xRXJqG4E4OHEXY6FYgpI9jg7Lqd4i2MVlc=; b=I1dv3u1Hiq+fHzambZ9SgPjsSdV1DwL3rd0HM4QrTGCcyVQQaSK8CAOAITAX6Q8bGE2dqwX4
 cLzvGLKZ+HtyNmHFr7OUjAmXIatBkLbhn8lY36AUw5VDtX0zvEEhebYTal7kfsNMRVHk+CTh
 gvlE4uPI2cYGjL6ehzNFHFgsZRQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 619ba7f986d0e4d88868fc4c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Nov 2021 14:23:53
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 579C9C43616; Mon, 22 Nov 2021 14:23:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7CC3FC4338F;
        Mon, 22 Nov 2021 14:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 7CC3FC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     aspriel@gmail.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, chi-hsien.lin@infineon.com,
        wright.feng@infineon.com, chung-hsien.hsu@infineon.com,
        linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH] brcmfmac: Configure keep-alive packet on suspend
References: <1637571856-1191-1-git-send-email-loic.poulain@linaro.org>
        <8735nobgje.fsf@codeaurora.org>
        <CAMZdPi9xWdJU_-k9mJxTkeyctsEmNCuzvBpdR-FMg=onEim+9w@mail.gmail.com>
Date:   Mon, 22 Nov 2021 16:23:45 +0200
In-Reply-To: <CAMZdPi9xWdJU_-k9mJxTkeyctsEmNCuzvBpdR-FMg=onEim+9w@mail.gmail.com>
        (Loic Poulain's message of "Mon, 22 Nov 2021 13:05:30 +0100")
Message-ID: <87sfvo8e1a.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Loic Poulain <loic.poulain@linaro.org> writes:

> Hi Kalle,
>
> On Mon, 22 Nov 2021 at 12:01, Kalle Valo <kvalo@codeaurora.org> wrote:
>>
>> Loic Poulain <loic.poulain@linaro.org> writes:
>>
>> > When system enter suspend, there is no more wireless traffic, and
>> > if there is no incoming data, most of the AP kick-out the client
>> > station after few minutes because of inactivity.
>> >
>> > The usual way to prevent this is to submit a Null function frame
>> > periodically as a keep-alive. This is supported by brcm controllers
>> > and can be configured via the mkeep_alive IOVAR.
>>
>> This is with brcmfmac in client mode, right?
>
> Right, it's in client mode.
>
>> Wouldn't it make more sense to disconnect entirely during suspend?
>> Nobody is processing the data packets anyway during suspend.
>
> Disconnect is performed automatically when wowlan is not enabled,
> otherwise we may want to wake-up on events (disconnect,
> 4-way-handshake) or data packets (magic, unicast, etc...). Some
> devices use suspend aggressively such as Android in which the network
> link is expected to be maintained.

Sure, for wowlan it makes sense but you didn't mention that in the
commit log so I assumed that was disabled.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
