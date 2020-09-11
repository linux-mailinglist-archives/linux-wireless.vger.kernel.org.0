Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344AF265D92
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 12:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgIKKPi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Sep 2020 06:15:38 -0400
Received: from a27-10.smtp-out.us-west-2.amazonses.com ([54.240.27.10]:57860
        "EHLO a27-10.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725930AbgIKKPc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Sep 2020 06:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599819332;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
        bh=b4NVQ5krglxj3ZL6TUhhpef5Nz9C4+SgBpsAy475dgU=;
        b=dQBoWYoOiqoVSlMkwP6FitmZ1Pr7/Bmh4pfqlqaTYT4FHIh4ov8mr9lDyh3D+OEq
        nXxkSh0eqbLDREHvfTL3b6gFJat1uLJPcYY66eGN7vt00P1fyH7gpQxqTucyvUtBFzJ
        h8cIWNiMWMK9aXWpprq7YmhYSi16ZieIBDmZK2P4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599819332;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
        bh=b4NVQ5krglxj3ZL6TUhhpef5Nz9C4+SgBpsAy475dgU=;
        b=J3QJQPAecR83HURfhBUClTYYp1jdRINbbh7CFnz4iSi9UiO/7Itl0ImjslDC56fN
        4eyU7IaZDcByZoJ7xWOTkiiINwsWvWdMKaHOG9FOQFQGLJTIQ99FE7yXdeY6pm/aGCi
        IvO5aM6KI0dyZh5I5XW6ka0i3bY7PYJAq0jbR8rA=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 11 Sep 2020 10:15:32 +0000
From:   Wen Gong <wgong@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Ben Greear <greearb@candelatech.com>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: lockdep splat in kvallo ath tree
In-Reply-To: <87v9gk4soh.fsf@tynnyri.adurom.net>
References: <0ef69472-9613-c265-0635-ff2ef0cf274f@candelatech.com>
 <87v9gk4soh.fsf@tynnyri.adurom.net>
Message-ID: <010101747ca9b9d5-847d1307-081b-4f1d-a78e-5f23833006ea-000000@us-west-2.amazonses.com>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2020.09.11-54.240.27.10
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-11 16:35, Kalle Valo wrote:
> + ath10k
> 
> Ben Greear <greearb@candelatech.com> writes:
> 
>> The patch below adds a call to ath10k_debug_fw_stats_request(ar),
>> which expects ar->conf_mutex to be held, but it is *not* held in
>> this code path.  This leads to warnings when lockdep is enabled.
>> 
>> 
>> greearb@bendt7 ath10k]$ git show 4913e675630ec
>> commit 4913e675630ec1a15c92651f426a63755c71b91b
>> Author: Wen Gong <wgong@codeaurora.org>
>> Date:   Thu Apr 23 10:27:58 2020 +0800
>> 
>>     ath10k: enable rx duration report default for wmi tlv
>> 
>>     When run command "iw dev wlan0 station dump", the rx duration is 
>> 0.
>>     When firmware indicate WMI_UPDATE_STATS_EVENTID, extended flag of
>>     statsis not set by default, so firmware do not report rx duration.
> 
> Wen, please investigate this.
Yes, Kalle, I will do that.
