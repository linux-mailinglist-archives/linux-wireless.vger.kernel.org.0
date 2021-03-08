Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8324A3308C5
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Mar 2021 08:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhCHHWo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Mar 2021 02:22:44 -0500
Received: from z11.mailgun.us ([104.130.96.11]:33938 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229704AbhCHHWd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Mar 2021 02:22:33 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615188153; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=2zzNrDlFyq67/9T0xdtnfJBgqMfTjf8EjAqAeAeSK2s=;
 b=rqWS4hL74JNaNGgJr1qqCF0Ktcufv9S2arl3Ip9ZVG2v2xNOpJtW+fBFL1+hqznB0P2yWm2h
 eWZ3KGgyESgxKoGdMTOGfwOFvHZ3bFJOP0xxGMf0jxjUzb0WWUF0iSzKPjipITsqen//tbwH
 +bBtjS7rHje+/VdEucVRqeLD1Pg=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 6045d0b0c862e1b9fd27e887 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 08 Mar 2021 07:22:24
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6C079C433C6; Mon,  8 Mar 2021 07:22:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B8447C433CA;
        Mon,  8 Mar 2021 07:22:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 08 Mar 2021 15:22:23 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] ath10k: change len of trace_ath10k_log_dbg_dump for large
 buffer size
In-Reply-To: <20210210115322.0b65a856@gandalf.local.home>
References: <1612839593-2308-1-git-send-email-wgong@codeaurora.org>
 <CA+ASDXN1V2HYA7C6s-q5bQNSxE7L5GCJiqfiJ_67R_hpUn4b_g@mail.gmail.com>
 <20210209145531.5977b16d@gandalf.local.home>
 <20210209163431.11133472@gandalf.local.home>
 <9b479a88331dbf969f07708eabe53d14@codeaurora.org>
 <20210210113026.5f5ebe8a@gandalf.local.home>
 <20210210114823.1408dd64@gandalf.local.home>
 <20210210115322.0b65a856@gandalf.local.home>
Message-ID: <137aaa6a6aa0ad0c0cf6e358705369c5@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-02-11 00:53, Steven Rostedt wrote:
> On Wed, 10 Feb 2021 11:48:23 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> On Wed, 10 Feb 2021 11:30:26 -0500
>> Steven Rostedt <rostedt@goodmis.org> wrote:
>> 
>> > Can you test this patch?
>> 
>> v2:
> 
> Bah!
> 
> v3:
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index b79bcacdd6f9..90d7ade03499 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -2739,7 +2739,7 @@ trace_event_buffer_lock_reserve(struct
> trace_buffer **current_rb,
>  	    (entry = this_cpu_read(trace_buffered_event))) {
>  		/* Try to use the per cpu buffer first */
>  		val = this_cpu_inc_return(trace_buffered_event_cnt);
> -		if (val == 1) {
> +		if ((len < (PAGE_SIZE - sizeof(*entry))) && val == 1) {
>  			trace_event_setup(entry, type, trace_ctx);
>  			entry->array[0] = len;
>  			return entry;
After apply this 
patch(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/kernel/trace/trace.c?id=b220c049d5196dd94d992dd2dc8cba1a5e6123bf).
It not crash again on my v4.19 kernel.
