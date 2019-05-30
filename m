Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B65382F70A
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2019 07:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfE3FLK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 May 2019 01:11:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56442 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfE3FLK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 May 2019 01:11:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CF35D60A00; Thu, 30 May 2019 05:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559193069;
        bh=xSLAPJ1yoBXCNPWykbB6kyJ/4LbEIz3CoSAS705Hq4U=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=XtscegUZrx7yo4EpjgvFA1Lpsw12CclN4crmj8PcYy8I7Tv09enbOzdvvXVupFzw2
         +94pdBo2sbL6JZhXHq3aeqi+dN23LV+qQTXU7dmff8MR1toOAKMQA47SO8jAYF7mNB
         AxuwOOIvoPoIN/22t5DsobPlN2Yo3qR7yN7yK+Lg=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3A37C60252;
        Thu, 30 May 2019 05:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559193069;
        bh=xSLAPJ1yoBXCNPWykbB6kyJ/4LbEIz3CoSAS705Hq4U=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=XtscegUZrx7yo4EpjgvFA1Lpsw12CclN4crmj8PcYy8I7Tv09enbOzdvvXVupFzw2
         +94pdBo2sbL6JZhXHq3aeqi+dN23LV+qQTXU7dmff8MR1toOAKMQA47SO8jAYF7mNB
         AxuwOOIvoPoIN/22t5DsobPlN2Yo3qR7yN7yK+Lg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3A37C60252
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 01/11] rtw88: resolve order of tx power setting routines
References: <1559116487-5244-1-git-send-email-yhchuang@realtek.com>
        <1559116487-5244-2-git-send-email-yhchuang@realtek.com>
        <f5bd9ab0-c32c-dcc6-9451-09e6b7f50a96@lwfinger.net>
        <F7CD281DE3E379468C6D07993EA72F84D17FABBF@RTITMBSVM04.realtek.com.tw>
        <87v9xspmfd.fsf@codeaurora.org>
        <F7CD281DE3E379468C6D07993EA72F84D17FAD0F@RTITMBSVM04.realtek.com.tw>
Date:   Thu, 30 May 2019 08:11:06 +0300
In-Reply-To: <F7CD281DE3E379468C6D07993EA72F84D17FAD0F@RTITMBSVM04.realtek.com.tw>
        (Tony Chuang's message of "Thu, 30 May 2019 05:05:50 +0000")
Message-ID: <87r28gplw5.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tony Chuang <yhchuang@realtek.com> writes:

>> > These patches are based on
>> >
>> >
>> https://kernel.googlesource.com/pub/scm/linux/kernel/git/kvalo/wireless-dr
>> ivers
>> > branch master
>> >
>> > commit 6aca09771db4277a78853d6ac680d8d5f0d915e3
>> > Author: YueHaibing <yuehaibing@huawei.com>
>> > Date:   Sat May 4 18:32:24 2019 +0800
>> >
>> >     rtw88: Make some symbols static
>> >
>> >
>> > It should apply, did I miss something?
>> 
>> I keep the bar high and take to wireless-drivers only patches which fix
>> important, user visible problems. Everything else goes to
>> wireless-drivers-next. So you should use wireless-drivers-next as the
>> baseline for all regular patches.
>
> But this series has dependency with " rtw88: Make some symbols static"

This is exactly why I keep the bar high for patches going to
wireless-drivers :) These depencies and conflicts are just too time
consuming otherwise.

> Or you can handle it

Unfortunately not, as I made a mistake when fast-forwarding
wireless-drivers and I cannot merge wireless-drivers into
wireles-drivers-next right now. So you just need to wait for the
depencies to trickle down to w-d-next, that will take few weeks.

-- 
Kalle Valo
