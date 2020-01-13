Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A497138C3B
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2020 08:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgAMHRl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jan 2020 02:17:41 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:48756 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728665AbgAMHRl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jan 2020 02:17:41 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578899861; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=PHpcWydMf81SX9BI3zK7atci8ZDAip52kbaK4/vTAKM=; b=QmZW/qV5NfimtI5ij1K4pQSrSdDmVImTvXzC6vCwnGs0kxtg1jJdv8ETFxYJVOloQeZWvN1z
 GeBy+odk178Ua9G+oTzg5Rt2+AUNxGHfN8P8itT3kgEB+sgB+gKDn7jBEXq9khOIySwR0R9p
 KfuwZBvGHqxrO6G16kLCBlSJ5eQ=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e1c1991.7f8189d6d6c0-smtp-out-n02;
 Mon, 13 Jan 2020 07:17:37 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 77C56C4479C; Mon, 13 Jan 2020 07:17:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (dsl-hkibng32-54f84f-238.dhcp.inet.fi [84.248.79.238])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A0D18C433CB;
        Mon, 13 Jan 2020 07:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A0D18C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     ath9k-devel@qca.qualcomm.com, davem@davemloft.net,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ath9k: Fix possible data races in ath_set_channel()
References: <20200111171528.7053-1-baijiaju1990@gmail.com>
Date:   Mon, 13 Jan 2020 09:17:28 +0200
In-Reply-To: <20200111171528.7053-1-baijiaju1990@gmail.com> (Jia-Ju Bai's
        message of "Sun, 12 Jan 2020 01:15:28 +0800")
Message-ID: <87a76rsu47.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jia-Ju Bai <baijiaju1990@gmail.com> writes:

> The functions ath9k_config() and ath_ani_calibrate() may be concurrently
> executed.
>
> A variable survey->filled is accessed with holding a spinlock
> common->cc_lock, through:
> ath_ani_calibrate()
>     spin_lock_irqsave(&common->cc_lock, flags);
>     ath_update_survey_stats()
>         ath_update_survey_nf()
>             survey->filled |= SURVEY_INFO_NOISE_DBM;
>
> The identical variables sc->cur_survey->filled and 
> sc->survey[pos].filled is accessed without holding this lock, through:
> ath9k_config()
>     ath_chanctx_set_channel()
>         ath_set_channel()
>             sc->cur_survey->filled &= ~SURVEY_INFO_IN_USE;
>             sc->cur_survey->filled |= SURVEY_INFO_IN_USE;
>             else if (!(sc->survey[pos].filled & SURVEY_INFO_IN_USE))
>             ath_update_survey_nf
>                 survey->filled |= SURVEY_INFO_NOISE_DBM;
>
> Thus, possible data races may occur.
>
> To fix these data races, in ath_set_channel(), these variables are
> accessed with holding the spinlock common->cc_lock.
>
> These data races are found by the runtime testing of our tool DILP-2.
>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

I need a detailed review from somone familiar with ath9k before I can
consider applying this.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
