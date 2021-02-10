Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22DA316B49
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 17:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbhBJQbe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 11:31:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:58576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232557AbhBJQbJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 11:31:09 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DBC464E76;
        Wed, 10 Feb 2021 16:30:28 +0000 (UTC)
Date:   Wed, 10 Feb 2021 11:30:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] ath10k: change len of trace_ath10k_log_dbg_dump for
 large buffer size
Message-ID: <20210210113026.5f5ebe8a@gandalf.local.home>
In-Reply-To: <9b479a88331dbf969f07708eabe53d14@codeaurora.org>
References: <1612839593-2308-1-git-send-email-wgong@codeaurora.org>
        <CA+ASDXN1V2HYA7C6s-q5bQNSxE7L5GCJiqfiJ_67R_hpUn4b_g@mail.gmail.com>
        <20210209145531.5977b16d@gandalf.local.home>
        <20210209163431.11133472@gandalf.local.home>
        <9b479a88331dbf969f07708eabe53d14@codeaurora.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 10 Feb 2021 10:01:57 +0800
Wen Gong <wgong@codeaurora.org> wrote:

> Not tested with latest kernel.
> The reason is below which I said in 
> https://lore.kernel.org/lkml/b504b3d7e989cae108669a0cd3072454@codeaurora.org/
> 
> the per cpu buffer seems it is initilized in 
> trace_buffered_event_enable,
> it is only 1 page size as below:
> void trace_buffered_event_enable(void)
> {
> ...
> 	for_each_tracing_cpu(cpu) {
> 		page = alloc_pages_node(cpu_to_node(cpu),
> 					GFP_KERNEL | __GFP_NORETRY, 0);
> If the size of buffer to trace is more than 1 page, such as 46680, then
> it trigger kernel crash/panic in my case while run trace-cmd.
> After debugging, the trace_file->flags in
> trace_event_buffer_lock_reserve is 0x40b while run trace-cmd, and it is
> 0x403 while collecting ftrace log.

Yeah, looking at this, I do see that this is a bug upstream.

Can you test this patch?

-- Steve


diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b79bcacdd6f9..a0b352aa23fe 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2739,7 +2739,7 @@ trace_event_buffer_lock_reserve(struct trace_buffer **current_rb,
 	    (entry = this_cpu_read(trace_buffered_event))) {
 		/* Try to use the per cpu buffer first */
 		val = this_cpu_inc_return(trace_buffered_event_cnt);
-		if (val == 1) {
+		if (len < PAGE_SIZE && val == 1) {
 			trace_event_setup(entry, type, trace_ctx);
 			entry->array[0] = len;
 			return entry;
