Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBE56E9661
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2019 07:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfJ3G2p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Oct 2019 02:28:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56158 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfJ3G2p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Oct 2019 02:28:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CB0AA60E75; Wed, 30 Oct 2019 06:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572416924;
        bh=3EtR8jh7t7c6zO5KJFSNoxdrq9KxP2FUsVIMb+Yz9uc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Pqe9OmYj9dfyln7Jp8Z9c/SlgYDgDZGo/mBLESPRJ/LB1qCUw86SYHrt+GGckzNiB
         i9VX7s9QZKqhlJOVbUXChb9C60z4RtcUydytRoiIBRWb8ESbOrLD6pAXOcRz087M3V
         OiChyuCNL9OBnMwwrRSqvOBPCrXo4tx8p01puPOw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id AF3DE60610;
        Wed, 30 Oct 2019 06:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572416921;
        bh=3EtR8jh7t7c6zO5KJFSNoxdrq9KxP2FUsVIMb+Yz9uc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aAV3QxGbeXqzA+vpyBpDIszwnFDyFYb56JNgs1eiAaU8TLy9lj1f3LIhMBSpcKHbh
         TZ2JEeURLzv6rhRtI63zjY2RNWaytxqDZI1ehwN/6RV2/Bz2VxmZifhyDmW7S5c0E4
         9GNYx1bmiKjrbWiYYp8aflw4wUppuACnTkd84T3U=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 30 Oct 2019 14:28:41 +0800
From:   zhichen@codeaurora.org
To:     Adrian Chadd <adrian@freebsd.org>
Cc:     Peter Oh <peter.oh@eero.com>, ath10k <ath10k@lists.infradead.org>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH RFC] Revert "ath10k: fix DMA related firmware crashes on
 multiple devices"
In-Reply-To: <CAJ-VmonXbUQ=Gv9fBbpN+ez25c3Pz+xxLoL67etMdC0Q+bwyXg@mail.gmail.com>
References: <1571734629-18028-1-git-send-email-zhichen@codeaurora.org>
 <d6cfd945-7bab-a01d-0157-e0e1802f66e3@eero.com>
 <CAJ-VmonXbUQ=Gv9fBbpN+ez25c3Pz+xxLoL67etMdC0Q+bwyXg@mail.gmail.com>
Message-ID: <fb2b3b1fc5b3fd00a23e97413777a21e@codeaurora.org>
X-Sender: zhichen@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-10-23 02:24, Adrian Chadd wrote:
> On Tue, 22 Oct 2019 at 10:17, Peter Oh <peter.oh@eero.com> wrote:
>> 
>> 
>> On 10/22/19 1:57 AM, Zhi Chen wrote:
>> > This reverts commit 76d164f582150fd0259ec0fcbc485470bcd8033e.
>> > PCIe hung issue was observed on multiple platforms. The issue was reproduced
>> > when DUT was configured as AP and associated with 50+ STAs.
>> >
>> > With PCIe protocol analyzer, we can see DMA Read crossing 4KB boundary when
>> > issue happened. It broke PCIe spec and caused PCIe stuck.
>> 
>> How can you say value 0 (I believe it's 64 bytes) DMA burst size 
>> causes
>> the symptom and 1 fixes it?
> 
> 
> +1 to this question.
> 
> Also, shouldn't the DMA engine be doing what the firmware says? Is the
> firmware/copy engine actually somehow bursting / prefetching across a
> 4K page boundary?
> 
> Surely this is something that can be fixed in software/firmware by
> correctly configuring up buffer size/offsets?
> 
> 
> 
> -Adrian

DMA engine is working as expected as the configuration. It's copy engine 
which actually
splits the RD/WR requests and accesses host memory.
And yes it's platform related configuration. We have never hit this 
issue on x86 platform.


Zhi
