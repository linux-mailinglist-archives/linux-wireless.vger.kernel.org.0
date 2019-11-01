Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDCF5EBF3F
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2019 09:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfKAIf6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Nov 2019 04:35:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58634 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfKAIf6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Nov 2019 04:35:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CABC6601C4; Fri,  1 Nov 2019 08:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572597357;
        bh=upIu9a/mPVwbxBiLOKNTleJfHH9HHGM9/Cj5AE/4yxQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=eoaQa8o7ciDUgfpbc7eD6f/JeKt7owpigT4sRgiihjYg9CPRx4Xmk/ovjxROk/cVY
         BF+hWoZS+W4E/9nOwcS1CXFV0WGmOGL/+oaAZJYi5imrgYRsw5XOXXZqySXxs2IhO9
         TLw/u18iZqrKCeUSntVy3PM/IFlPogDbIpJwkQiU=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (176-93-46-192.bb.dnainternet.fi [176.93.46.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F3E6D60A19;
        Fri,  1 Nov 2019 08:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572597357;
        bh=upIu9a/mPVwbxBiLOKNTleJfHH9HHGM9/Cj5AE/4yxQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=eoaQa8o7ciDUgfpbc7eD6f/JeKt7owpigT4sRgiihjYg9CPRx4Xmk/ovjxROk/cVY
         BF+hWoZS+W4E/9nOwcS1CXFV0WGmOGL/+oaAZJYi5imrgYRsw5XOXXZqySXxs2IhO9
         TLw/u18iZqrKCeUSntVy3PM/IFlPogDbIpJwkQiU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F3E6D60A19
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Brian Norris <briannorris@chromium.org>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "g.schlmm\@googlemail.com" <g.schlmm@googlemail.com>
Subject: Re: [PATCH 3/6] rtw88: use a module parameter to control LPS enter
References: <20191025093345.22643-4-yhchuang@realtek.com>
        <20191031075911.3CCB86079C@smtp.codeaurora.org>
        <F7CD281DE3E379468C6D07993EA72F84D1914F4C@RTITMBSVM04.realtek.com.tw>
        <CA+ASDXPzLJ0OkuN0-BHqxGSBuVqQg6=eyg+PizLTCj+5bJ_5kw@mail.gmail.com>
        <F7CD281DE3E379468C6D07993EA72F84D19159DA@RTITMBSVM04.realtek.com.tw>
Date:   Fri, 01 Nov 2019 10:35:53 +0200
In-Reply-To: <F7CD281DE3E379468C6D07993EA72F84D19159DA@RTITMBSVM04.realtek.com.tw>
        (Tony Chuang's message of "Fri, 1 Nov 2019 03:13:41 +0000")
Message-ID: <87a79g0z9y.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tony Chuang <yhchuang@realtek.com> writes:

>> On Thu, Oct 31, 2019 at 1:17 AM Tony Chuang <yhchuang@realtek.com>
>> wrote:
>> > Or I should just change the
>> > value to a better one. By our experience, set this to 50 is a more reasonable
>> > value, such that some web surfing or background traffic wouldn't make the
>> > driver to leave PS mode.
>> 
>> FWIW, I think choosing a more reasonable default is definitely a good
>> start, as long as this choice doesn't have huge downsides.
>> 
>> @Kalle: FYI, this (set to 50) is exactly the change that Tony is
>> recommending to me for my distro, and I have the same qualms about
>> supporting a growing number of module parameter tweaks like this. So,
>> thanks for pushing back :)
>> 
>> Brian
>> 
>
> I was afraid of you thinking that setting this to 50 is a strange thing.
> But it seems like you'd prefer to change the default value instead of adding a
> module parameter to control it. I think we can drop this one and I will send
> a patch to change the default value to 50.

Yeah, as the first step changing to 50 sounds good to me. Later, if
needed, we can extend it to make it configurable from user space, either
via the QoS framework or something else.

-- 
Kalle Valo
