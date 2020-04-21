Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382FC1B2562
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2020 13:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgDUL4U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Apr 2020 07:56:20 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:37081 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726018AbgDUL4T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Apr 2020 07:56:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587470178; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=G3+PSoj9T05goG+BYiZAcgsl5pUCYlPfZcVZroyVYLk=; b=cS73qIRhegD5tMi1m64WxPIKot75eauCiuPufoOncIkTBYFlsVOUOHTaXQ2hLW2MwnO9QxYE
 OORxaTHuZ55QAhod3G9bViEth+vd8qqkBxsvbbhAa14CQJrdtz7phI1bbouxsU7enZWAGLhl
 72ob6DoByohiJ1lze6g6dRVSEJc=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9edf62.7f8abe8bba40-smtp-out-n03;
 Tue, 21 Apr 2020 11:56:18 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 14694C433BA; Tue, 21 Apr 2020 11:56:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 962ACC433D2;
        Tue, 21 Apr 2020 11:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 962ACC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH v9 3/4] ath10k: add htt TX bundle for sdio
References: <20200212080415.31265-1-wgong@codeaurora.org>
        <20200212080415.31265-4-wgong@codeaurora.org>
        <87tv1su2vq.fsf@kamboji.qca.qualcomm.com>
        <185d31c2e6f8792beb240f2c74d26463@codeaurora.org>
        <87h7xmtrmv.fsf@kamboji.qca.qualcomm.com>
        <87o8rrr4y5.fsf@kamboji.qca.qualcomm.com>
        <27ca9f2bf63807d501cfb29d8f55f904@codeaurora.org>
Date:   Tue, 21 Apr 2020 14:56:13 +0300
In-Reply-To: <27ca9f2bf63807d501cfb29d8f55f904@codeaurora.org> (Wen Gong's
        message of "Sat, 18 Apr 2020 22:02:24 +0800")
Message-ID: <871rohoxwi.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> On 2020-04-16 20:27, Kalle Valo wrote:
>> Kalle Valo <kvalo@codeaurora.org> writes:
>>
>
>>> How much does it drop? Please add the justification (with numbers) for
>>> the new thread to the commit log, so that the reason is properly
>>> documented.
>>
>> I see that you already submitted v10. If you can give the numbers I can
>> add them to the commit log.
>
> I tested for VHT80 mode for 3 thread config:
> result:
>                                      TCP-RX    TCP-TX    UDP-RX
> UDP-TX
> use workqueue_tx_complete(Mbps)        423       357       448       412
> change it to ar->workqueue(Mbps)       410       360       449       414
> change it to ar->workqueue_aux(Mbps)   405       339       446       401

Thanks, I added the table to the commit log.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
