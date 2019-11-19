Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1BA10210C
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2019 10:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfKSJlp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Nov 2019 04:41:45 -0500
Received: from a27-11.smtp-out.us-west-2.amazonses.com ([54.240.27.11]:58486
        "EHLO a27-11.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727450AbfKSJlh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Nov 2019 04:41:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574156496;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=CNLROcjX07GylV2Uwv0PmQ/A/ZgMtjrePxjyX+jgVCU=;
        b=GbxxjNXFcXJeRZpoy/raSVMqJa4+W/emhFKVw0BVn9QvHeO+ClZZB6iCbaxE326d
        dyqxJnZXO+hgiISrQWZiqXI35Fr1FQS64ely+TSQVcT5xl568hFbNZjNiiERRX5nlVJ
        /GPYac7+79NJN6hKsQfYvdoU1p0j6tQnF2lra5Ls=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574156496;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=CNLROcjX07GylV2Uwv0PmQ/A/ZgMtjrePxjyX+jgVCU=;
        b=CADi6CG6RpN+c/6KcCJm2rCFVV4R1vi9PaxrS/jAfp+fgvjMzwpeCx7YWhIbezZS
        V6shTMEyETX485CIwH5bAp+AmQUM4M5NXydLppXy6tT6qkiyJEc+rslTR7hOh0WpXLh
        EmGiOeIeu7feogQgMbZLZGvjmbQ35zw8wZLJzNmM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A1886C2BB5B
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ming Chen <Ming.Chen@watchguard.com>
Cc:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Ming Chen <ming032217@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v4] mac80211: Drop the packets whose source or destination mac address is empty
References: <20191116060833.45752-1-ming.chen@watchguard.com>
        <87blt9ctd4.fsf@toke.dk>
        <DM6PR10MB2873E994ABFB1798B36CE49B9A4C0@DM6PR10MB2873.namprd10.prod.outlook.com>
Date:   Tue, 19 Nov 2019 09:41:36 +0000
In-Reply-To: <DM6PR10MB2873E994ABFB1798B36CE49B9A4C0@DM6PR10MB2873.namprd10.prod.outlook.com>
        (Ming Chen's message of "Tue, 19 Nov 2019 08:03:24 +0000")
Message-ID: <0101016e8309ed71-c2031187-906f-4d32-8ba0-e8420c76fe1e-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2019.11.19-54.240.27.11
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ming Chen <Ming.Chen@watchguard.com> writes:

>> > Dropping this kind of error packet before it goes into the driver,
>> > should be the right direction.
>> 
>> So I still wonder why this happens from higher up in the stack. If there's a
>> legitimate reason, maybe dropping the packet is not the right thing? And if
>> there is *no* legitimate reason, maybe the packet should be dropped higher
>> up in the stack instead?
>> 
>> What kind of packets does this happen with?
>
> [Ming Chen] It should an ARP packet. I can see this kind of packet
> before ARP table is complete. If so, how about dropping it in the
> function of ieee80211_subif_start_xmit?

The question here is why are you seeing this but nobody else? Are you
using some special protocol, do you have some changes in the kernel
which cause this or what could explain this behaviour?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
