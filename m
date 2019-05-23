Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 924A227F36
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2019 16:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbfEWONP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 May 2019 10:13:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46776 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730323AbfEWONP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 May 2019 10:13:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7D0EB607B9; Thu, 23 May 2019 14:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558620794;
        bh=ayMWMkPRyI8wzYkP92kKVKAf66CzIsiEBHUYaJZ6M4U=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=WqEZbaM6E0VO4P/GVh87aQ52q4ygK5A5y5hlTT2bFjxNdqMFt4pF82FEQ37+JnVkr
         w3Vgchz/nj2xcrqfAkgIO3LQ+OUYbD6mCoqgPVISzn6j6VQmy92ycZX3ng242sYx1y
         K9PO/w5xU2hILbiyk6hQlpzvsd2IgRO+7Wsd6RmA=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2812F60388;
        Thu, 23 May 2019 14:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558620794;
        bh=ayMWMkPRyI8wzYkP92kKVKAf66CzIsiEBHUYaJZ6M4U=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=WqEZbaM6E0VO4P/GVh87aQ52q4ygK5A5y5hlTT2bFjxNdqMFt4pF82FEQ37+JnVkr
         w3Vgchz/nj2xcrqfAkgIO3LQ+OUYbD6mCoqgPVISzn6j6VQmy92ycZX3ng242sYx1y
         K9PO/w5xU2hILbiyk6hQlpzvsd2IgRO+7Wsd6RmA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2812F60388
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <Ajay.Kathat@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>,
        <gregkh@linuxfoundation.org>, <Adham.Abozaeid@microchip.com>,
        <Venkateswara.Kaja@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 00/16] wilc1000: move out of staging
References: <1549696298-9795-1-git-send-email-ajay.kathat@microchip.com>
        <5ac9d9bb-08e4-c46f-ce0a-40630e1d958e@microchip.com>
        <871s30pevc.fsf@codeaurora.org>
        <2ba91fc2-af3a-b235-5cb0-2ba06444ea30@microchip.com>
Date:   Thu, 23 May 2019 17:13:09 +0300
In-Reply-To: <2ba91fc2-af3a-b235-5cb0-2ba06444ea30@microchip.com> (Ajay
        Kathat's message of "Thu, 23 May 2019 13:32:38 +0000")
Message-ID: <87sgt5cl8q.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Ajay.Kathat@microchip.com> writes:

> Hi Kalle,
>
> On 3/21/2019 6:24 PM, Kalle Valo wrote:
>> 
>> <Ajay.Kathat@microchip.com> writes:
>> 
>>> Hi Kalle/Johannes,
>>>
>>> On 2/9/2019 12:42 PM, Ajay Kathat - I15481 wrote:
>>>> From: Ajay Singh <ajay.kathat@microchip.com>
>>>>
>>>> This patch series is to review and move wilc1000 driver out of staging.
>>>> Implemented the initial received review comments[1] and submitting the
>>>> driver again. During this cleanup deleted around 3.3k lines of code.
>>>>
>>>> Below are the major items fixed in recent cleanup:
>>>>  - remove use of shadow buffer to keep scan result.
>>>>  - remove internal messaging flow to handle cfg80211_ops.
>>>>  - make use of cfg80211 provided API.
>>>>  - use structure for packing firmware commands.
>>>>  - make use of kernel provided API and macros.
>>>>  - remove unnecessary logs messages.
>>>>
>>>> Pending action item:
>>>>  - dynamically add/remove p2p interface.
>>>>
>>>>  This item will take some time, we are planning to take it up after
>>>>  mainline.
>>>>
>>>>  We hope it can be move out staging in v5.1.
>>>>  Please review and confirm if it is good to move out.
>>>
>>> Do you have any update for this series. Please provide your inputs for
>>> next step.
>> 
>> rtw88 is taking priority in the new drivers "queue" so I doubt I can
>> take a look at this in the next few weeks.
>> 
>
> Is there any update for wilc1000 driver review. Please let me know your
> inputs.

So is the driver in good shape now? I really do not want to use a lot of
time reviewing it just to find out that there's a lot of work to do. For
example, has someone else reviewed it?

-- 
Kalle Valo
