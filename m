Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C201CEC75
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2020 07:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbgELFbM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 May 2020 01:31:12 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:33766 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbgELFbM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 May 2020 01:31:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589261471; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=W373dMi02N5ax/ku01lfJpSbK9rBHrEsf8WrQm2QZ0k=;
 b=g20dKJexFOERiop/5gf4JQfKckeOgQduNFtXDQk3em3DbQlM4dqvuXDCJ7ent26ZOkmj8erc
 Pft/tm/IjvxyBAHyyKDOd45a4730smWdVQrQVJTMMUgPmy6hioRzHV8LE5EIN6kdKQZHkK6O
 vzdEgvwRrt4tJ7hYYQdW0wcRpPM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eba349f.7f0f2a34fed8-smtp-out-n01;
 Tue, 12 May 2020 05:31:11 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5942DC432C2; Tue, 12 May 2020 05:31:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: govinds)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E09E9C433F2;
        Tue, 12 May 2020 05:31:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 12 May 2020 11:01:09 +0530
From:   govinds@codeaurora.org
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH 1/4] ath11k: Add PCI client driver for QCA6390 chipset
In-Reply-To: <87h7wm4akt.fsf@kamboji.qca.qualcomm.com>
References: <20200508085850.23363-1-govinds@codeaurora.org>
 <20200508085850.23363-2-govinds@codeaurora.org>
 <87h7wm4akt.fsf@kamboji.qca.qualcomm.com>
Message-ID: <2028987516458b3145d3cd9758eafe8f@codeaurora.org>
X-Sender: govinds@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

On 2020-05-11 23:29, Kalle Valo wrote:
> Govind Singh <govinds@codeaurora.org> writes:
> 
>> QCA6390 is PCI based 11ax chipset, add
>> pci client driver for QCA6390 target.
>> 
>> Signed-off-by: Govind Singh <govinds@codeaurora.org>
> 
> This patch had multiple problems, most important ones were:
> 
> * a break missing in ath11k_pci_probe()
> 

My bad. Thanks for fixing same.

> * it's not possible to have static variables in .h files, I fixed by
>   moving the ring variables to core.c in a separate patch:
> 
>   https://patchwork.kernel.org/patch/11541355/
> 
> * this patch didn't link (at least when compiling as modules), I fixed
>   those by adding missing EXPORT_SYMBOL() macros
> 

Looks, this is required after moving the ring mask from ahb to core.

> Please double check my changes:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=44a28b572070f578914367dc2469cef48ece13f4

Looks good to me.

BR,
Govind
