Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0497265BBA
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 10:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbgIKIfj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Sep 2020 04:35:39 -0400
Received: from a27-21.smtp-out.us-west-2.amazonses.com ([54.240.27.21]:41004
        "EHLO a27-21.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725766AbgIKIfg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Sep 2020 04:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599813335;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=xiW9+cCWE9me7Zc3FisQVRQMgzbSxsWOHcsDu+W+kiY=;
        b=cIu6Q577NQemacxNZyNCMCQA/KbqzQRWfv9t0xKHNw4KW8Gl1lF5J5MQoxhkUL83
        DziGwY4/VUgFG6gQUT8zc7y2hn4/mAm1MQV9Sy2Ucx8+b4fZ7e7d1d67XXfe++WS7Mz
        kwhaRw1mWjgV1w0/IvXbGbXGJDMSbGMw23WFYUZo=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599813335;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=xiW9+cCWE9me7Zc3FisQVRQMgzbSxsWOHcsDu+W+kiY=;
        b=ZwLa/n+OQeZj76o5306xGVjg2cM+QZCyXS0PvBmfe9bLHoEHEN6NZL+BlUQjRLgZ
        2++yCt7/Q0hdWVWN9trpjQ1RTw9IG/ea6fkiCpaAKjFExKqKoJWzVk1Om4xPhZTflXV
        GFA5vofg/TIyhYhzRy5bqeV7je05ePWm4gmFrVb8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9984AC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ben Greear <greearb@candelatech.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Wen Gong <wgong@codeaurora.org>, ath10k@lists.infradead.org
Subject: Re: lockdep splat in kvallo ath tree
References: <0ef69472-9613-c265-0635-ff2ef0cf274f@candelatech.com>
Date:   Fri, 11 Sep 2020 08:35:35 +0000
In-Reply-To: <0ef69472-9613-c265-0635-ff2ef0cf274f@candelatech.com> (Ben
        Greear's message of "Wed, 2 Sep 2020 15:54:31 -0700")
Message-ID: <010101747c4e398e-cdd20756-ad3b-42dd-8db3-341c9bf5880e-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2020.09.11-54.240.27.21
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ ath10k

Ben Greear <greearb@candelatech.com> writes:

> The patch below adds a call to ath10k_debug_fw_stats_request(ar),
> which expects ar->conf_mutex to be held, but it is *not* held in
> this code path.  This leads to warnings when lockdep is enabled.
>
>
> greearb@bendt7 ath10k]$ git show 4913e675630ec
> commit 4913e675630ec1a15c92651f426a63755c71b91b
> Author: Wen Gong <wgong@codeaurora.org>
> Date:   Thu Apr 23 10:27:58 2020 +0800
>
>     ath10k: enable rx duration report default for wmi tlv
>
>     When run command "iw dev wlan0 station dump", the rx duration is 0.
>     When firmware indicate WMI_UPDATE_STATS_EVENTID, extended flag of
>     statsis not set by default, so firmware do not report rx duration.

Wen, please investigate this.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
