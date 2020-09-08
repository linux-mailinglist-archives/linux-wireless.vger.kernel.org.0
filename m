Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AAA260914
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 05:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgIHDrX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 23:47:23 -0400
Received: from a27-11.smtp-out.us-west-2.amazonses.com ([54.240.27.11]:58960
        "EHLO a27-11.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728327AbgIHDrX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 23:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599536842;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
        bh=ioze2Vk8sGSLsn6DlH10Ck4TTmsD3z4CDGZIfIUO+so=;
        b=fJHASqG6+27lzVVg0aiiUaOM/hoBwWhQf/Vv4L2plz9ynm1RZQLU6pDz1b8GB+iu
        6xJHkjrFeGfV7zPOrB8omviIjafWWtIx5r1HVEX8w2zMFhXxxu2ggWYFRaTWO1pjZzM
        wA6bvn/trDNeQZ2OyhdpF8e3I0kUpTWWj8Se/9Fg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599536842;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
        bh=ioze2Vk8sGSLsn6DlH10Ck4TTmsD3z4CDGZIfIUO+so=;
        b=WZ0ToPfxkGdbsXyizG1SEJwewDfCpaOZk/iTvmm/7A77DxJIozYGPcUOj/LsDQB3
        Rg3TUkNAp8XdjDDbefptef390GSLEE+VjMKyjvbNkaKdEzKUWKuIIfDy6Mf71bVT45c
        8aaLteZhftXNs3dyojnpRqvzIByHxJ/CbX+yo/Kg=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 8 Sep 2020 03:47:22 +0000
From:   Wen Gong <wgong@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH v4 1/2] ath10k: add refcount for ath10k_core_restart
In-Reply-To: <871rjd37kz.fsf@codeaurora.org>
References: <20200108031957.22308-1-wgong@codeaurora.org>
 <20200108031957.22308-2-wgong@codeaurora.org>
 <87imdlkuw8.fsf@codeaurora.org>
 <725b4377f63c76627e1e68604323cb74@codeaurora.org>
 <871rjd37kz.fsf@codeaurora.org>
Message-ID: <010101746bd345d6-71507113-2e9e-42f5-985c-4d0a9e93f01e-000000@us-west-2.amazonses.com>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2020.09.08-54.240.27.11
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-07 23:55, Kalle Valo wrote:
> Wen Gong <wgong@codeaurora.org> writes:
> 
>> On 2020-08-15 01:19, Kalle Valo wrote:
>> ...
>>> 
>>> I have been thinking a different approach for this. I think another
>>> option is to have a function like this:
>>> 
>>> ath10k_core_firmware_crashed()
>>> {
>>>         queue_work(ar->workqueue, &ar->restart_work);
>>> }
>>> 
>>> In patch 1 we would convert all existing callers to call that
>>> function instead of queue_work() directly.
>>> 
>>> In patch 2 we would add a new flag to enum ath10k_dev_flags, or maybe
>>> should actually use existing ATH10K_FLAG_CRASH_FLUSH? Don't know yet
>>> which one is better. Now the function would do:
>> 
>> I thinks we can use test_and_set_bit for atomic operation athough it
>> is same with restart_count.
> 
> I didn't quite understand what you mean here, but using
> test_and_set_bit() is the correct methdo.
> 
>> and add a new flag, ATH10K_FLAG_CRASH_FLUSH is used for flush, if
>> still use ATH10K_FLAG_CRASH_FLUSH, it should change clear_bit of it
>> from ath10k_core_start to ath10k_reconfig_complete,because
>> ieee80211_reconfig(called by ieee80211_restart_work) of mac80211 do
>> many things and drv_start is 1st thing and drv_reconfig_complete is
>> last thing, drv_reconfig_complete done means the restart finished.
> 
> Ok, let's discuss about that in v5. I hope you added the analysis to 
> the
> commit log.
yes, v5 have alread sent in https://patchwork.kernel.org/patch/11728101/
[v5] ath10k: add atomic protection for device recovery
