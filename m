Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8571AD868
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 10:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbgDQITu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 04:19:50 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:33974 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729176AbgDQITt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 04:19:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587111589; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=/7yKs6ysaSQ6o8f2hhWqkR0wQfyQw4kSJ38wV5CP0RY=; b=nupEI979668wpebWrSQutsiL4nzDK//yJN5YjfeQUchUQqnsLmXvLo3pXtTMIOSOGVs8Y2Ml
 RNKi82AkYzX28qy1W+DRn6HCkDAzxLRj3rUFY0+s10Jf9SqI897TxSTia1dr6yH18275bQ5d
 t1UOV238476zxXhbthDpC3lzX8A=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e996692.7fd03ae9d650-smtp-out-n03;
 Fri, 17 Apr 2020 08:19:30 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A0BC2C432C2; Fri, 17 Apr 2020 08:19:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C6CC7C433CB;
        Fri, 17 Apr 2020 08:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C6CC7C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <yhchuang@realtek.com>
Cc:     <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>,
        <briannorris@chromium.org>, <kevin_yang@realtek.com>
Subject: Re: [PATCH 00/40] rtw88: add support for 802.11n RTL8723DE devices
References: <20200417074653.15591-1-yhchuang@realtek.com>
Date:   Fri, 17 Apr 2020 11:19:25 +0300
In-Reply-To: <20200417074653.15591-1-yhchuang@realtek.com>
        (yhchuang@realtek.com's message of "Fri, 17 Apr 2020 15:46:13 +0800")
Message-ID: <87lfmuplrm.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> writes:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>
> Although RTL8723DE devices are 802.11n devices, while rtw88
> aimed to support for 802.11ac devices, the 8723DE devices's
> architecture is relatively close to the 802.11ac devices.
> So, add support for them on rtw88, with some minor modifications.

There's no way I'm going to review 40 patches in one go :) So I'll just
to look at around 10 first patches and drop the rest.

If you want your patches reviewed smoothly submit only around 7-12
patches per patchset. If the patches are bigger don't send more than 7
patches. But if they smaller, or trivial patches, 12 patches is ok. But
anything more than 12 patches and I'm sure you will get reviewers
grumpy.

But you can submit multiple patchsets, just try to throttle it down to
avoid bufferbloat in patchwork, ie. send a new patchset every other day
and document the dependencies in the cover letter ("this patchset
depends on patchset B").

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
