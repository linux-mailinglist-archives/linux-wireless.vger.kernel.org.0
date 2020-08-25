Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0626925100C
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Aug 2020 05:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgHYDlK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Aug 2020 23:41:10 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:25539 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727011AbgHYDlJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Aug 2020 23:41:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598326868; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Uvcu1ht5kV9VgGpjCT/tlLrb1xXWHrIjP9OCITouXRM=;
 b=ZfnC/e+6GOoK6L6lb/hlsDWEArDspMyQdpkSzeHPv2wQ1rxNDyd6OOLC5QJEssYbOSjj0LD4
 lO6xMg71zw/9YKkX0gaXZaj7+Wdst/XbrjK+8xRgF48jbDv/2+VJz30h07OZKbSE9To1H+2V
 QpoQ18Wxt7vMyF/q7W782MCsDhI=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f448850fb5eb2479c4af92b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 25 Aug 2020 03:41:04
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6904CC433CB; Tue, 25 Aug 2020 03:41:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C7983C433CA;
        Tue, 25 Aug 2020 03:41:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 25 Aug 2020 11:41:03 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Krishna Chaitanya <chaitanya.mgit@gmail.com>
Cc:     ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] ath10k: add flag to protect napi operation to avoid
 dead loop hang for SDIO
In-Reply-To: <CABPxzY+Fc22ke1ygRnDs0Uds0a7n=792QN8ALXciDrnx9SQuqQ@mail.gmail.com>
References: <1598243612-4627-1-git-send-email-wgong@codeaurora.org>
 <CABPxzYLjys+cXXRM5J680ZOs+6VrYt=_3rWv-gqkCod=-A1VrA@mail.gmail.com>
 <fd98989a87f2a50655dc95bdcd535c0d@codeaurora.org>
 <CABPxzYKvPwtQwxMfRcv9jT+d92ErhYGR91SKBH86T3Rd2QH9Qg@mail.gmail.com>
 <2d6362ce85956d0f7df2e596b89a7028@codeaurora.org>
 <CABPxzY+Fc22ke1ygRnDs0Uds0a7n=792QN8ALXciDrnx9SQuqQ@mail.gmail.com>
Message-ID: <663fbb682fd8df555b2964d7d86b8eca@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-08-24 19:15, Krishna Chaitanya wrote:
> On Mon, Aug 24, 2020 at 4:15 PM Wen Gong <wgong@codeaurora.org> wrote:
>> 
>> On 2020-08-24 18:03, Krishna Chaitanya wrote:
>> > On Mon, Aug 24, 2020 at 3:10 PM Wen Gong <wgong@codeaurora.org> wrote:
>> >>
>> >> On 2020-08-24 16:35, Krishna Chaitanya wrote:
>> >> > On Mon, Aug 24, 2020 at 10:03 AM Wen Gong <wgong@codeaurora.org> wrote:
>> >> >>
>> >> >> It happened "Kernel panic - not syncing: hung_task: blocked tasks"
>> >> >> when
>> >> >> test simulate crash and ifconfig down/rmmod meanwhile.
>> >> >>
>> >> ...
>> >> >>
>> >> >>  #ifdef CONFIG_PM
>> >> > Even though your DUT is SDIO based we should be doing this in general
>> >> > for all, no?
>> >> > core_restart + hif_stop is common to all.
>> >> this patch does not have core_restart.
>> > I was referring to the combination which is causing the issue.
>> >
>> >> I dit not hit the issue for others bus(PCIe,SNOC...), so I can not
>> >> change them with a
>> >> assumption they also have this issue.
>> > But that doesn't make sense, the combination is being hit for others
>> > also.
>> > (they should also endup calling napi_disable twice?) or they are using
>> > some other check to avoid this (doesn't appear so from a quick look at
>> > the
>> > code).
>> Because I only use SDIO, I did not use others BUS, so I did not hit 
>> the
>> issue
>> on other BUS.
> I understand, my point was based on the description the issue looks 
> independent
> of the BUS type, so, the fix should also be generic. I understand that
> your testing
> is only focused on SDIO, but we should have a generic fix and probably 
> use
> communities help to get it tested rather than fixing SDIO only.
I checked the ath10k, only sdio.c, snoc.c, pci.c have used napi.
I think it can change to move the 
napi_synchronize/napi_disable/napi_enable from
sido.c/snoc.c/pci.c to ath10k_core.ko as below:
void ath10k_core_napi_enable(struct ath10k *ar)
{
        if (!ar->napi_enabled) {
                napi_enable(&ar->napi);
                ar->napi_enabled = true;
        }
}
EXPORT_SYMBOL(ath10k_core_napi_enable);

void ath10k_core_napi_disable_sync(struct ath10k *ar)
{
        if (ar->napi_enabled) {
                napi_synchronize(&ar->napi);
                napi_disable(&ar->napi);
                ar->napi_enabled = false;
        }
}
EXPORT_SYMBOL(ath10k_core_napi_disable_sync);

is it appropriate?
...
