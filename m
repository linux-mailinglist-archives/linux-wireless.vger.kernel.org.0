Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18863E2DDC
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2019 11:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731944AbfJXJrI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Oct 2019 05:47:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50358 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730343AbfJXJrI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Oct 2019 05:47:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3265C60B67; Thu, 24 Oct 2019 09:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571910427;
        bh=FgebyyM68KyCZTp8a5RynFQnhebEfIplee6uQIgAQqU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KBV53puNNObhltDnZ/11NInDZ5MHzlcguSGItDS6u5/x7v8Kb3e4l80f/ghQ6PqgZ
         PVAU1r8DmleRyrIzKCUN2MzeTMvjMcxT/Cxp0XjsNu5TQpiCPxO6Hkid99BTwDey/L
         TxBDi3eo0WUVpq/5rHLkiryFyGG1vrF70X17gI6E=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 063A060FEF;
        Thu, 24 Oct 2019 09:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571910426;
        bh=FgebyyM68KyCZTp8a5RynFQnhebEfIplee6uQIgAQqU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LafDKB1y/2/61nQFjgpvN6qi8a3ZprsPjfuzsazfWp41f70tYiWXVJp962CFe+2M8
         AyYVXTFUUfuRARtLhlBVjFUMG7kOyilWzBAV5fS7QsWFog42E5K5xctgtsodWgwVkm
         qie7thlh0PcWDcvslo/lQDWrOGH4zYdhWefCERKo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 24 Oct 2019 17:47:05 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6 2/3] ath10k: change max RX bundle size from 8 to 32 for
 sdio
In-Reply-To: <87mudqsd6d.fsf@kamboji.qca.qualcomm.com>
References: <1569402639-31720-1-git-send-email-wgong@codeaurora.org>
 <1569402639-31720-3-git-send-email-wgong@codeaurora.org>
 <87mudqsd6d.fsf@kamboji.qca.qualcomm.com>
Message-ID: <200eef83925da532e49565bcf4f9ffc1@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-10-24 17:30, Kalle Valo wrote:
> Wen Gong <wgong@codeaurora.org> writes:
> 
>> The max bundle size support by firmware is 32, change it from 8 to 32
>> will help performance. This results in significant performance
>> improvement on RX path.
>> 
>> Tested with QCA6174 SDIO with firmware
>> WLAN.RMH.4.4.1-00017-QCARMSWPZ-1
>> 
>> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> 
> [...]
> 
>> --- a/drivers/net/wireless/ath/ath10k/sdio.c
>> +++ b/drivers/net/wireless/ath/ath10k/sdio.c
>> @@ -24,7 +24,7 @@
>>  #include "trace.h"
>>  #include "sdio.h"
>> 
>> -#define ATH10K_SDIO_VSG_BUF_SIZE	(32 * 1024)
>> +#define ATH10K_SDIO_VSG_BUF_SIZE	(64 * 1024)
> 
> Is allocating 64 kb with kmalloc() reliable, especially on smaller
> systems? I hope it is, but checking if someone else knows better. We
> only do this only once in probe(), though.
rx packet is more than 1500 bytes for performance test, so for 32 
packets, 32*1024 is not enough.
yes, it is allocated only one time for probe.
