Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BD9325E0A
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Feb 2021 08:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhBZHKO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Feb 2021 02:10:14 -0500
Received: from z11.mailgun.us ([104.130.96.11]:46648 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229621AbhBZHKL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Feb 2021 02:10:11 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614323393; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=YzqhMx4zNqj4B0lO2yiVuJRYNlDzuW2clUbuLBWtfjg=; b=GtQ+AznhHOgRQ932lTZhMtiDMHd7UbmHaTWRSG9z2K7psMqSAyB+Zb0w7v/+xUvPBy7DdqlE
 f8IcxTu+6nIq4KsvtOWEIv9cwygKOodGYMxTxEF8FkumKponIL4F3ljHEbAv7uWAU98TXzR5
 +0duiRL97w6UxiyVjATOYRLlE/M=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60389ebbcc1f7d7e953cef3d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Feb 2021 07:09:47
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B2E35C433ED; Fri, 26 Feb 2021 07:09:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 620A3C433C6;
        Fri, 26 Feb 2021 07:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 620A3C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <Ajay.Kathat@microchip.com>
Cc:     <davidm@egauge.net>, <julian.calaby@gmail.com>,
        <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 4/4] wilc1000: Add support for enabling CRC
References: <20210224055135.1509200-1-davidm@egauge.net>
        <20210224055135.1509200-4-davidm@egauge.net>
        <CAGRGNgUR7wHgprWcqz5orJNuhcxeLMSE1C3WCi1_UH_MCwJ6Cg@mail.gmail.com>
        <70567db1d625086e051b305320c9d4be7deb1b82.camel@egauge.net>
        <74fcdef6-124e-3fc2-6467-f71badc01d0c@microchip.com>
        <87mtvseev3.fsf@tynnyri.adurom.net>
        <22b6e634-d881-7e94-c96f-f92b1588cf05@microchip.com>
Date:   Fri, 26 Feb 2021 09:09:43 +0200
In-Reply-To: <22b6e634-d881-7e94-c96f-f92b1588cf05@microchip.com> (Ajay
        Kathat's message of "Thu, 25 Feb 2021 11:03:51 +0000")
Message-ID: <87sg5je24o.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Ajay.Kathat@microchip.com> writes:

> On 25/02/21 1:52 pm, Kalle Valo wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>> 
>> <Ajay.Kathat@microchip.com> writes:
>> 
>>> On 25/02/21 5:06 am, David Mosberger-Tang wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>>
>>>> Julian,
>>>>
>>>> On Thu, 2021-02-25 at 08:19 +1100, Julian Calaby wrote:
>>>>> Hi David,
>>>>>
>>>>> On Wed, Feb 24, 2021 at 6:56 PM David Mosberger-Tang <
>>>>> davidm@egauge.net> wrote:
>>>>>>
>>>>>> +#define ENABLE_CRC7    0       /* set to 1 to protect SPI commands
>>>>>> with CRC7 */
>>>>>> +#define ENABLE_CRC16   0       /* set to 1 to protect SPI data
>>>>>> with CRC16 */
>>>>>
>>>>> Should these be Kconfig variables instead?
>>>>
>>>> I'd certainly like that.  Ajay, would you be OK with that?
>>>>
>>>
>>> Yes, I am fine with the changes to move as Kconfig variable.
>> 
>> Kconfig is not ideal for configuring functionality, something like a
>> module parameter is usually better. But why not just enable CRC always?
>> Why would the user need to disable this?
>
> As I know, the CRC check can be an time taking operation for each data
> packets and in turn, can have impact on throughput performance.
> Generally, it is recommended to keep this CRC configuration disabled.
> But someone is cautious can enable it on a need basis by knowing the
> possible reduction on throughput number.

Then I think a module parameter would be the best approach, I don't see
the need to recompile anything for this. And remember to document the
impact for the performance in the commit log and/or in the module
parameter documentation.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
