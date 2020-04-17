Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBB31AD87D
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 10:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbgDQI01 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 04:26:27 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:43692 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729166AbgDQI01 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 04:26:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587111986; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=nzlrfB7RBux3vH9Qm4lSl2YHM09GcAkucRQM7C7w1DI=; b=StOOP48BzIfCJDbefhPzchLAcM1i2kQHaWMHVTk6TalYlrlWx2A4rNfCFrUJdJdDtkjf4ptS
 X045FxVA3cFKXEL8HbdUVmpqVEDThb1sYxzpAG216HnB/hBoJmf1J7Z5vgDZD6hpvA6aUNDp
 7n8sGKoMzT6b8MvuvIeeOMxGhFQ=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e99682c.7ff830694730-smtp-out-n03;
 Fri, 17 Apr 2020 08:26:20 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B5EFDC433F2; Fri, 17 Apr 2020 08:26:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D0989C433CB;
        Fri, 17 Apr 2020 08:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D0989C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     <yhchuang@realtek.com>, <pkshih@realtek.com>,
        <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <kevin_yang@realtek.com>
Subject: Re: [PATCH 00/40] rtw88: add support for 802.11n RTL8723DE devices
References: <20200417074653.15591-1-yhchuang@realtek.com>
        <87lfmuplrm.fsf@kamboji.qca.qualcomm.com>
Date:   Fri, 17 Apr 2020 11:26:16 +0300
In-Reply-To: <87lfmuplrm.fsf@kamboji.qca.qualcomm.com> (Kalle Valo's message
        of "Fri, 17 Apr 2020 11:19:25 +0300")
Message-ID: <87zhbajz6f.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> <yhchuang@realtek.com> writes:
>
>> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>>
>> Although RTL8723DE devices are 802.11n devices, while rtw88
>> aimed to support for 802.11ac devices, the 8723DE devices's
>> architecture is relatively close to the 802.11ac devices.
>> So, add support for them on rtw88, with some minor modifications.
>
> There's no way I'm going to review 40 patches in one go :) So I'll just
> to look at around 10 first patches and drop the rest.
>
> If you want your patches reviewed smoothly submit only around 7-12
> patches per patchset. If the patches are bigger don't send more than 7
> patches. But if they smaller, or trivial patches, 12 patches is ok. But
> anything more than 12 patches and I'm sure you will get reviewers
> grumpy.
>
> But you can submit multiple patchsets, just try to throttle it down to
> avoid bufferbloat in patchwork, ie. send a new patchset every other day
> and document the dependencies in the cover letter ("this patchset
> depends on patchset B").

I added this also to the wiki:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#maximum_of_7-12_patches_per_patchset

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
