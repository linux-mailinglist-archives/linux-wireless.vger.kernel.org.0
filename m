Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0A5315A47
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 00:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbhBIXu4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Feb 2021 18:50:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:55568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234146AbhBIWO6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Feb 2021 17:14:58 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2F7364DDF;
        Tue,  9 Feb 2021 21:34:32 +0000 (UTC)
Date:   Tue, 9 Feb 2021 16:34:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Wen Gong <wgong@codeaurora.org>,
        ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] ath10k: change len of trace_ath10k_log_dbg_dump for
 large buffer size
Message-ID: <20210209163431.11133472@gandalf.local.home>
In-Reply-To: <20210209145531.5977b16d@gandalf.local.home>
References: <1612839593-2308-1-git-send-email-wgong@codeaurora.org>
        <CA+ASDXN1V2HYA7C6s-q5bQNSxE7L5GCJiqfiJ_67R_hpUn4b_g@mail.gmail.com>
        <20210209145531.5977b16d@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 9 Feb 2021 14:55:31 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > [for-next][PATCH 2/2] tracing: Use temp buffer when filtering events
> > https://lore.kernel.org/lkml/f16b14066317f6a926b6636df6974966@codeaurora.org/  
> 
> Note, that is only used when filtering happens, which doesn't appear to be
> the case here.

I was basing this off of the original commands, but the stack dump says
otherwise. But it should still work.

> 
> > 
> > It seems like we should still try to get that fixed somehow, even if
> > the below change is fine on its own (it probably doesn't make sense to
> > such a large amount of data via tracepoints). It would be unfortunate
> > for next poor soul to hit the same issues, just because they wanted to
> > dump a few KB.  
> 
> Yeah, it was a design decision to cap the max size of events to just under
> PAGE_SIZE. The ring buffer is broken up into pages (for zero copy
> transfers to file systems and the network). Thus, no event is allowed to be
> bigger than a page (and actually a bit smaller)
> 
> That said, it shouldn't have crashed, it should have just failed to record.
> 
> I'll test it out and see why it crashed.

Looking at the original report, I see:

 CPU: 1 PID: 141 Comm: kworker/u16:1 Not tainted 4.19.139 #162

Does this still crash on the latest kernel?

-- Steve
