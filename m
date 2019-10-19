Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5D24DD867
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Oct 2019 13:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbfJSLOq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Oct 2019 07:14:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50342 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfJSLOp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Oct 2019 07:14:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 150D160D4C; Sat, 19 Oct 2019 11:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571483685;
        bh=WPjGoPsWvB8sgjViJJX+0PY6Iln7rDmcCavy1L53H/Q=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=HW/hEV4S6IWm6nXzx2/QhZ0h1yNJFlfXSgmMfhJQcniBuKMrYFYpIhSx+VDXrmnmB
         Mp8hZGiqmzqUhEwDmbvGoUx3mpbINNn92Se4v2AiCzhfMWoEl/G2uVE6tCFsxGiJ/U
         oASff5nqLj0jTPHqCWcTUWzoLcffLQQQt/TJ7AXo=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 982C66092D;
        Sat, 19 Oct 2019 11:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571483684;
        bh=WPjGoPsWvB8sgjViJJX+0PY6Iln7rDmcCavy1L53H/Q=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Qn5q4uEI3ErPZGJHuC7R9MGf5Q4djatOh0jpLrWnBHawVPY5EOm61Hqk3NVWvPnZQ
         H8sy/zeGtbr/dy2lNkCt77JGvluiVQgCANP8Hnl5HWbfpwZ9EYptsKevA4K4nbE0CX
         C+XqxJ/aMXdEfPjgbcv65M2iEgeZ7e8qSBAAXK6k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 982C66092D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Tony Chuang <yhchuang@realtek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] rtw88: update regulatory settings implementaion
References: <20191016123301.2649-1-yhchuang@realtek.com>
        <20191016123301.2649-5-yhchuang@realtek.com>
        <CA+ASDXMj_f9q1aKgkcqd+2NPmxQfcQsJK8zQLUQSu8DSUW7Fsw@mail.gmail.com>
        <F7CD281DE3E379468C6D07993EA72F84D1900CF3@RTITMBSVM04.realtek.com.tw>
        <CA+ASDXPkU8+8haHbyiQ5gf2e6rZ-2ks=D6zfV0CDnAzaWPZXFA@mail.gmail.com>
Date:   Sat, 19 Oct 2019 14:14:41 +0300
In-Reply-To: <CA+ASDXPkU8+8haHbyiQ5gf2e6rZ-2ks=D6zfV0CDnAzaWPZXFA@mail.gmail.com>
        (Brian Norris's message of "Wed, 16 Oct 2019 20:17:32 -0700")
Message-ID: <87lfthvvfi.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> writes:

> On Wed, Oct 16, 2019 at 7:55 PM Tony Chuang <yhchuang@realtek.com> wrote:
>>
>> From: Brian Norris
>> >
>> > On Wed, Oct 16, 2019 at 5:33 AM <yhchuang@realtek.com> wrote:
>> > > This also supports user regulatory hints, and it should only be
>> > > enabled for specific distributions that need this to correct
>> > > the cards reglutory.
> ...
>> > There should be a pretty high bar for introducing either new CONFIG_*
>> > options or module parameters, in my opinion, and I'm not sure you
>> > really satisfied it. Why "should only be enabled" by certain
>> > distributions? Your opinion? If it's the technical limitation you
>> > refer to ("efuse settings"), then just detect the efuse and prevent
>> > user hints only on those modules.
>> >
>>
>> Because the efuse/module does not contain the information if the
>> user's hint is allowed. But sometimes distributions require to set the
>> regulatory via "NL80211_CMD_SET_REG".
>> So we are leaving the CONFIG_* here for some reason that needs it.
>
> Is there ever a case where user hint is not allowed? For what reason?
> If not efuse, then what?
>
> Or alternatively: if someone sets CONFIG_RTW88_REGD_USER_REG_HINTS=y,
> then what problems will they have? Technical problems (e.g., firmware
> will crash on certain modules) or <other> problems?

I'm not convinced either that a Kconfig option is the correct thing to
do here. We need to understand more about the background first.

This patch needs a lot more discussion, please move it out from this
patchset and handle it separately. That way it won't block other
patches.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
