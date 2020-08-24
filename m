Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F7724FBD3
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Aug 2020 12:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgHXKpS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Aug 2020 06:45:18 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:37381 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727042AbgHXKoz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Aug 2020 06:44:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598265894; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=57L/Zg3bLcwkGTaIY8dQYEeaVA5e5JRYpxQx6rKkgaY=;
 b=potWdMV09K0h0oWDYwcAmnaBab0nT0P751AyTba6DMv0m2v6vohajrxuL5CV/2hbyL+meDTt
 yasTS4HAdQwBHBrE2nAJ9WYptgvcjNbK7+AazPOn5iGL3XBMUaaNlg6u2bZV5VaB1PgxoVy0
 GG6xwbDYXfRJCgdZLrFh9mF2ZxY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f439a1a54c370a51f7b24f5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 24 Aug 2020 10:44:42
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CAB34C43391; Mon, 24 Aug 2020 10:44:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED autolearn=ham
        autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 71E77C433CA;
        Mon, 24 Aug 2020 10:44:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 24 Aug 2020 18:44:41 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Krishna Chaitanya <chaitanya.mgit@gmail.com>
Cc:     ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] ath10k: add flag to protect napi operation to avoid
 dead loop hang for SDIO
In-Reply-To: <CABPxzYKvPwtQwxMfRcv9jT+d92ErhYGR91SKBH86T3Rd2QH9Qg@mail.gmail.com>
References: <1598243612-4627-1-git-send-email-wgong@codeaurora.org>
 <CABPxzYLjys+cXXRM5J680ZOs+6VrYt=_3rWv-gqkCod=-A1VrA@mail.gmail.com>
 <fd98989a87f2a50655dc95bdcd535c0d@codeaurora.org>
 <CABPxzYKvPwtQwxMfRcv9jT+d92ErhYGR91SKBH86T3Rd2QH9Qg@mail.gmail.com>
Message-ID: <2d6362ce85956d0f7df2e596b89a7028@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-08-24 18:03, Krishna Chaitanya wrote:
> On Mon, Aug 24, 2020 at 3:10 PM Wen Gong <wgong@codeaurora.org> wrote:
>> 
>> On 2020-08-24 16:35, Krishna Chaitanya wrote:
>> > On Mon, Aug 24, 2020 at 10:03 AM Wen Gong <wgong@codeaurora.org> wrote:
>> >>
>> >> It happened "Kernel panic - not syncing: hung_task: blocked tasks"
>> >> when
>> >> test simulate crash and ifconfig down/rmmod meanwhile.
>> >>
>> ...
>> >>
>> >>  #ifdef CONFIG_PM
>> > Even though your DUT is SDIO based we should be doing this in general
>> > for all, no?
>> > core_restart + hif_stop is common to all.
>> this patch does not have core_restart.
> I was referring to the combination which is causing the issue.
> 
>> I dit not hit the issue for others bus(PCIe,SNOC...), so I can not
>> change them with a
>> assumption they also have this issue.
> But that doesn't make sense, the combination is being hit for others 
> also.
> (they should also endup calling napi_disable twice?) or they are using
> some other check to avoid this (doesn't appear so from a quick look at 
> the
> code).
Because I only use SDIO, I did not use others BUS, so I did not hit the 
issue
on other BUS.
> 
> So, I am back to my initial guess that the SDIO specific async_rx_work 
> is
> causing/aggravating this issue.
the commit log of this patch has explain the reason, it is not caused by 
the
async_rx_work and I have started the "ath10k: cancel rx worker in 
hif_stop for SDIO"
for async_rx_work.
