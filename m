Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E19D315CD3
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 03:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbhBJCDt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Feb 2021 21:03:49 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:61321 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235332AbhBJCD2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Feb 2021 21:03:28 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612922587; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=0dBmtYl/6yYwIgz/exWY39dmedgS/t1WhlIOfdVWVKk=;
 b=VslQXgrnXRTUgHaDpKw3MMF9L9rCecU14gg3ZAmxkfq7wyHcDN8r2qApwmhSoCuoO3iQ+yRH
 x9GEwIJrtyUSnrhs3fb0qXhOVAUt4dJj5V/RzQ+7DxaQWM+IxkCxdFLt+9bCAGLoINkHXuZC
 MQ4AVcZJewsNoBWEAI1vykPwLAU=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60233e97f112b7872c8d5034 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Feb 2021 02:01:59
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 32B60C43462; Wed, 10 Feb 2021 02:01:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B9A67C433ED;
        Wed, 10 Feb 2021 02:01:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 10 Feb 2021 10:01:57 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] ath10k: change len of trace_ath10k_log_dbg_dump for large
 buffer size
In-Reply-To: <20210209163431.11133472@gandalf.local.home>
References: <1612839593-2308-1-git-send-email-wgong@codeaurora.org>
 <CA+ASDXN1V2HYA7C6s-q5bQNSxE7L5GCJiqfiJ_67R_hpUn4b_g@mail.gmail.com>
 <20210209145531.5977b16d@gandalf.local.home>
 <20210209163431.11133472@gandalf.local.home>
Message-ID: <9b479a88331dbf969f07708eabe53d14@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-02-10 05:34, Steven Rostedt wrote:
> On Tue, 9 Feb 2021 14:55:31 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> > [for-next][PATCH 2/2] tracing: Use temp buffer when filtering events
>> > https://lore.kernel.org/lkml/f16b14066317f6a926b6636df6974966@codeaurora.org/
>> 
>> Note, that is only used when filtering happens, which doesn't appear 
>> to be
>> the case here.
> 
> I was basing this off of the original commands, but the stack dump says
> otherwise. But it should still work.
> 
>> 
>> >
>> > It seems like we should still try to get that fixed somehow, even if
>> > the below change is fine on its own (it probably doesn't make sense to
>> > such a large amount of data via tracepoints). It would be unfortunate
>> > for next poor soul to hit the same issues, just because they wanted to
>> > dump a few KB.
>> 
>> Yeah, it was a design decision to cap the max size of events to just 
>> under
>> PAGE_SIZE. The ring buffer is broken up into pages (for zero copy
>> transfers to file systems and the network). Thus, no event is allowed 
>> to be
>> bigger than a page (and actually a bit smaller)
>> 
>> That said, it shouldn't have crashed, it should have just failed to 
>> record.
>> 
>> I'll test it out and see why it crashed.
> 
> Looking at the original report, I see:
> 
>  CPU: 1 PID: 141 Comm: kworker/u16:1 Not tainted 4.19.139 #162
> 
> Does this still crash on the latest kernel?
> 
> -- Steve
Not tested with latest kernel.
The reason is below which I said in 
https://lore.kernel.org/lkml/b504b3d7e989cae108669a0cd3072454@codeaurora.org/

the per cpu buffer seems it is initilized in 
trace_buffered_event_enable,
it is only 1 page size as below:
void trace_buffered_event_enable(void)
{
...
	for_each_tracing_cpu(cpu) {
		page = alloc_pages_node(cpu_to_node(cpu),
					GFP_KERNEL | __GFP_NORETRY, 0);
If the size of buffer to trace is more than 1 page, such as 46680, then
it trigger kernel crash/panic in my case while run trace-cmd.
After debugging, the trace_file->flags in
trace_event_buffer_lock_reserve is 0x40b while run trace-cmd, and it is
0x403 while collecting ftrace log.
