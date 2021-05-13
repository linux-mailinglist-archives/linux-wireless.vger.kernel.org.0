Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300FB37F2D4
	for <lists+linux-wireless@lfdr.de>; Thu, 13 May 2021 08:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhEMGKk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 May 2021 02:10:40 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:42632 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhEMGKj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 May 2021 02:10:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620886170; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=DFG9qqEL80a90T6eOVH9GPe7NTWmMeB96ru+p2yxzCI=; b=HV4SCDnfH7bWwz0PXB/2JIPU0b3cvwdXb7spbOZvhi2CXTmW10fNGKj+isvF4cOn2MP6aVYd
 oPFtEtcJsvJyHU3arYBi2OGXDkj9sHp4ICZxXYQIU9/eljirt6JTIkYXgEV7Tzd/7uhCBtsj
 gXjFAVrr5pO7pWvFk9LtizDbFPk=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 609cc281a4c86a394a491cc0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 13 May 2021 06:09:05
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C7DF7C4338A; Thu, 13 May 2021 06:09:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AC824C433D3;
        Thu, 13 May 2021 06:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AC824C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Pkshih <pkshih@realtek.com>,
        "linux-firmware\@kernel.org" <linux-firmware@kernel.org>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: Request to update 8852a firmware of rtw89 to v0.13.8.0
References: <57e9f582340545c79a9ab3433e2a4a7d@realtek.com>
        <87cztx87tr.fsf@tynnyri.adurom.net>
        <CA+ASDXM9YmhMWmttkrCxB0_tf6Kf6Sz=7Yc26CmjZmMUxyxAfw@mail.gmail.com>
Date:   Thu, 13 May 2021 09:09:00 +0300
In-Reply-To: <CA+ASDXM9YmhMWmttkrCxB0_tf6Kf6Sz=7Yc26CmjZmMUxyxAfw@mail.gmail.com>
        (Brian Norris's message of "Tue, 11 May 2021 12:10:55 -0700")
Message-ID: <87tun7i2rn.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> writes:

> On Tue, May 11, 2021 at 11:05 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>>
>> Pkshih <pkshih@realtek.com> writes:
>>
>> > Please help to update 8852a firmware.
>> > This is first time I send a pull request. If anything is wrong,
>> > please let me know.
>>
>> rtw89 driver is not in upstream yet, and it has not been reviewed
>> either. I recommend holding off pulling the firmware until the driver is
>> reviewed.
>
> FWIW, preliminary rtw89 firmware was already merged. This is just an update.
>
> I also wonder, what's the harm? People like me are actively testing
> the early versions, and I've done a very barebones amount of review (I
> hope to do more). It really helps me to have up-to-date firmware
> published somewhere central -- I guess I can take GitHub instead, but
> again, why not kernel.org? If anyone else is looking at testing, they
> know where to get the pieces too, and we can compare results.

It can create confusion to the users if during review we make changes
how firmware files are handled. Some drivers have windows style .ini
files which are not ok in an upstream driver, there could be changes in
the file format etc.

But I have no strong opinion here, my main motivation is just to try to
keep things simple for maintaining the "interface" between
linux-firmware and kernel wireless drivers. My preference is that the
firmware files are ready for submission when a new driver is submitted
for review, but the firmware files are submitted only after the driver
is accepted.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
