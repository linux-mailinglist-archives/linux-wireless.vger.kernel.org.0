Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55EB915BD85
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 12:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbgBMLPp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 06:15:45 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:17265 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729526AbgBMLPp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 06:15:45 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581592544; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=cnJ54l9tLPuroKJZpqlUO46FcTPOrlCyPvCcupmKG8Y=; b=dz0+sMqVoXLfQ9H0TmXXBxKWesFeUyhPg6EegGy79O0qLPrjVN7CIKZakDWGIDVVZvZQLwNL
 vPisTEO9Dpr/b3r/e7fCYD+XkecE2W6LUZgVAjLotnrtPanfe+H7JM3CN1IE2C9MiOgxJbAT
 hRElTBFHAJsPkWqhJKrguScBXew=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e452fd8.7f6d3fbfa1f0-smtp-out-n03;
 Thu, 13 Feb 2020 11:15:36 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1947FC4479F; Thu, 13 Feb 2020 11:15:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7C7A0C43383;
        Thu, 13 Feb 2020 11:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7C7A0C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     =?utf-8?Q?Micha=C5=82?= Kazior <kazikcz@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k@lists.infradead.org, Wen Gong <wgong@codeaurora.org>
Subject: Re: [PATCH] ath10k: support PCIe enter L1 state
References: <1542163848-837-1-git-send-email-wgong@codeaurora.org>
        <20181115002836.GA71934@google.com>
        <c94346b26a6d4b11a045a176ca854051@aptaiexm02f.ap.qualcomm.com>
        <20181115184333.GA87504@google.com> <87va4x8q2c.fsf@codeaurora.org>
        <CABvG-CVAnwkiKVJik0PdsmRxF62kKv2N+aRKNq=nbopoExLvDA@mail.gmail.com>
        <87y36q75wr.fsf@kamboji.qca.qualcomm.com>
        <CA+ASDXO8NujrORVLZMPbDy916cnzOvx_Bp8Vr-VvkbBwJvB97A@mail.gmail.com>
        <87h8cd8zy2.fsf@kamboji.qca.qualcomm.com>
        <CA+ASDXM8gtn3=p5pQ=GOFdfTy-698ZPW91JEgAfapdLEcU+eMg@mail.gmail.com>
Date:   Thu, 13 Feb 2020 13:15:30 +0200
In-Reply-To: <CA+ASDXM8gtn3=p5pQ=GOFdfTy-698ZPW91JEgAfapdLEcU+eMg@mail.gmail.com>
        (Brian Norris's message of "Mon, 2 Dec 2019 10:48:44 -0800")
Message-ID: <87r1yywxf1.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> writes:

> On Fri, Mar 8, 2019 at 1:42 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>> Brian Norris <briannorris@chromium.org> writes:
>> > On Fri, Feb 8, 2019 at 5:42 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>> >> No replies from anyone (including Wen) for 3 months about testing this
>> >> patch on anything else than QCA6174. So I'll drop this now, please
>> >> resubmit once test coverage is better.
>> >
>> > I know this isn't exactly what you're asking for, but FWIW we've been
>> > using this since late November on all our QCA6174 products. No issues
>> > seen as far as I know, and we have seen some power savings.
>>
>> Thanks for the feedback, this is very good to know. I also would like to
>> apply this but not before we have some testing feedback from AP chipsets
>> like QCA988X or QCA9984. Wen, are you planning to test those and
>> resubmit?
>
> May I ping here? We (Chromium OS) are continuing to carry this patch,
> and would love to come up with something that can land upstream. If
> necessary, I can rework it to apply more specifically -- e.g., only to
> QCA6174 PCI IDs.

Yeah, enabling only for QCA6174 sounds best.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
