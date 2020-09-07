Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F303225FDB5
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 17:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbgIGP40 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 11:56:26 -0400
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:44514
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730158AbgIGPzw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 11:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599494150;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=QTFjDKmp+YLEAN4/5pw0F1O83VzAybdj5K6uBv0oUF4=;
        b=l0gtu6dpqU2t7wVVoNKm2QvhoC1eR4JCmkwpnS2rFa1rCHqvMxl7v+WeuNH3MnMD
        EPN+fs4k2oaRwBXZ/PQanOX9OEb4dQ7OeYxO8lpHVwVuqF5u/iWp3my/Js0bsJ4eqd9
        eEogQaOGBUVM8RX05FacFaoXgombqOEHKUB2s2cY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599494150;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=QTFjDKmp+YLEAN4/5pw0F1O83VzAybdj5K6uBv0oUF4=;
        b=lIMe1O3PAvZ/UgNffTk8oKYv5xq6m+WBZ7RUU1k+cznO37psdlb1irZ0AUnJL0Br
        0RwRk0XPSwZZRRuaIapryFmCRo+9vVluFv+vT44LQQkw7GwNbH71GzFnph2qALkbzzz
        umdTU6/004k5mNz97x9IDJYat4edmaIV5dB19BLw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5FC0FC55689
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH v4 1/2] ath10k: add refcount for ath10k_core_restart
References: <20200108031957.22308-1-wgong@codeaurora.org>
        <20200108031957.22308-2-wgong@codeaurora.org>
        <87imdlkuw8.fsf@codeaurora.org>
        <725b4377f63c76627e1e68604323cb74@codeaurora.org>
Date:   Mon, 7 Sep 2020 15:55:50 +0000
In-Reply-To: <725b4377f63c76627e1e68604323cb74@codeaurora.org> (Wen Gong's
        message of "Thu, 20 Aug 2020 17:18:26 +0800")
Message-ID: <010101746947d9a2-1e7623e9-d659-49a2-8001-48779b091dff-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2020.09.07-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> On 2020-08-15 01:19, Kalle Valo wrote:
> ...
>>
>> I have been thinking a different approach for this. I think another
>> option is to have a function like this:
>>
>> ath10k_core_firmware_crashed()
>> {
>>         queue_work(ar->workqueue, &ar->restart_work);
>> }
>>
>> In patch 1 we would convert all existing callers to call that
>> function instead of queue_work() directly.
>>
>> In patch 2 we would add a new flag to enum ath10k_dev_flags, or maybe
>> should actually use existing ATH10K_FLAG_CRASH_FLUSH? Don't know yet
>> which one is better. Now the function would do:
>
> I thinks we can use test_and_set_bit for atomic operation athough it
> is same with restart_count.

I didn't quite understand what you mean here, but using
test_and_set_bit() is the correct methdo.

> and add a new flag, ATH10K_FLAG_CRASH_FLUSH is used for flush, if
> still use ATH10K_FLAG_CRASH_FLUSH, it should change clear_bit of it
> from ath10k_core_start to ath10k_reconfig_complete,because
> ieee80211_reconfig(called by ieee80211_restart_work) of mac80211 do
> many things and drv_start is 1st thing and drv_reconfig_complete is
> last thing, drv_reconfig_complete done means the restart finished.

Ok, let's discuss about that in v5. I hope you added the analysis to the
commit log.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
