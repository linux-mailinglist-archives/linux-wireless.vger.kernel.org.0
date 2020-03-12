Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED913183134
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 14:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgCLNYR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 09:24:17 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:40782 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727411AbgCLNYP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 09:24:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584019455; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=y2Nrd4GyBfOP/8FCc56U5mNrqRcV/gnnD6px0fRpIBE=; b=EFUeJklXpu3r/fGcB5kXdH5LraFNj8s3JUwCROEkCxsIJMDT5LOSNEd+X62YFCsWhJWglx8i
 0oXG8jkL5fcg2ba2q0guo1k2u5ko+WApDJUldTP8iNQD1+Q6RExfk+1TwgokvT4y9Mx2ZC8I
 tf/Nj29RwuAK4FjhuuQINCd9W6A=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6a37f8.7fba80408c38-smtp-out-n01;
 Thu, 12 Mar 2020 13:24:08 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7BAA8C433CB; Thu, 12 Mar 2020 13:24:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DA1EDC433CB;
        Thu, 12 Mar 2020 13:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DA1EDC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Chris Chiu <chiu@endlessm.com>
Cc:     Tony Chuang <yhchuang@realtek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2 1/2] rtw88: add a debugfs entry to dump coex's info
References: <20200309075852.11454-1-yhchuang@realtek.com>
        <20200309075852.11454-2-yhchuang@realtek.com>
        <CAB4CAwe5kmOOPiw-WBzLMKsXteNgnGzVPsH3pyakg6NfB57Emw@mail.gmail.com>
Date:   Thu, 12 Mar 2020 15:23:59 +0200
In-Reply-To: <CAB4CAwe5kmOOPiw-WBzLMKsXteNgnGzVPsH3pyakg6NfB57Emw@mail.gmail.com>
        (Chris Chiu's message of "Wed, 11 Mar 2020 17:31:48 +0800")
Message-ID: <87blp1u2og.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Chris Chiu <chiu@endlessm.com> writes:

> On Mon, Mar 9, 2020 at 3:59 PM <yhchuang@realtek.com> wrote:
>>
>> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>>
>> Add a new entry "coex_info" in debugfs to dump coex's states for
>> us to debug on coex's issues.
>>
>> The basic concept for co-existence (coex, usually for WiFi + BT)
>> is to decide a strategy based on the current status of WiFi and
>> BT. So, it means the WiFi driver requires to gather information
>> from BT side and choose a strategy (TDMA/table/HW settings).
>>
>> Althrough we can easily check the current status of WiFi, e.g.,
>> from kernel log or just dump the hardware registers, it is still
>> very difficult for us to gather so many different types of WiFi
>> states (such as RFE config, antenna, channel/band, TRX, Power
>> save). Also we will need BT's information that is stored in
>> "struct rtw_coex". So it is necessary for us to have a debugfs
>> that can dump all of the WiFi/BT information required.
>>
>> Note that to debug on coex related issues, we usually need a
>> longer period of time of coex_info dump every 2 seconds (for
>> example, 30 secs, so we should have 15 times of coex_info's
>> dump).
>>
>> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

[...]

> Looks good to me. But I strongly suggest using scnprintf instead of
> snprintf to prevent potential buffer overflow.

Yup, please fix that.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
