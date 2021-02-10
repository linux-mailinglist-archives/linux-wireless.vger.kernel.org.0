Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4944D315D3B
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 03:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbhBJC1R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Feb 2021 21:27:17 -0500
Received: from so15.mailgun.net ([198.61.254.15]:25394 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235291AbhBJCZI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Feb 2021 21:25:08 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612923890; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=MMitM/P4fuEQUAofCsu/bu93d22qS0ZPd+4W8m85C1g=;
 b=Jy2KNC2iCUpfuHwSM3SDExnsIlv0OHxcfmu4ojySe0vV2h3yQpLRinRj+KQ622ezv33lN1Q1
 6Z2yLJTxCGFF9+Lbsj0Jd3OtP+cwNEJ8LT6xt5FTPGkX+0sGhooFpbaLv+CtKfnjLU7ayEEq
 qYXC2EyWNt03xBgek/DTYA/7+cU=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 602343cf81f6c45dce60efc6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Feb 2021 02:24:15
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0FD39C43468; Wed, 10 Feb 2021 02:24:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 60A15C43464;
        Wed, 10 Feb 2021 02:24:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 10 Feb 2021 10:24:14 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] ath10k: change len of trace_ath10k_log_dbg_dump for large
 buffer size
In-Reply-To: <CA+ASDXNYO+w254D2Uh3OSfTGjJEkbOCX=hq+XaWe9DtjbuOy3g@mail.gmail.com>
References: <1612839593-2308-1-git-send-email-wgong@codeaurora.org>
 <CA+ASDXN1V2HYA7C6s-q5bQNSxE7L5GCJiqfiJ_67R_hpUn4b_g@mail.gmail.com>
 <19b6ad684a01718c3823f882581fca36@codeaurora.org>
 <CA+ASDXNYO+w254D2Uh3OSfTGjJEkbOCX=hq+XaWe9DtjbuOy3g@mail.gmail.com>
Message-ID: <79f57b7531b862648afdfc5531b2effd@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-02-10 10:14, Brian Norris wrote:
> On Tue, Feb 9, 2021 at 6:12 PM Wen Gong <wgong@codeaurora.org> wrote:
>> On 2021-02-10 03:35, Brian Norris wrote:
>> so this patch is to dump the top 1024 bytes only,
>> its 1st goal is make log smaller.
> 
> Agreed. I wasn't objecting to this patch. I just wanted to highlight
> the second part should probably also be considered as not exclusively
> an ath10k bug:
> 
>> its 2nd effect is fix the crash issue,
> 
> but I guess if you're not testing the latest upstream, it's a little
> hard to tell for sure whether the crash still exist at all anyway...
> 
Yes.
It is hard for me to test with the latest upstream, because the kernel 
is v4.19 for my SDIO chip.
I do not have the environment with latest kernel.:).
If someone use the other environment(not V4.19+SDIO) which is the latest 
kernel,
and if it not crash, it can not conclude it also will not crash on my 
v4.19 for SDIO chip without this patch.:)
It will not crash with this patch on my v4.19 for SDIO, this have been 
verified my me.
If someone want to check the same crash with latest kernel, he/she can 
generate a simulate test and analyze with latest kernel.:)
> Brian
