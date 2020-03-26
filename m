Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 736D3193F9C
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 14:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgCZNTj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 09:19:39 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:45549 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725994AbgCZNTj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 09:19:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585228778; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=bKl+Ocs3pZwi2SL3TPaz71mJwbt8jJ41lnMSSs30fu0=;
 b=deA4b2WLoguImfOOnDRb5phCVXa1wqS45kth+m5mmu+ZUcmFE3XcxLMIImQ+deifdIX+Q40e
 touQFrhBWHC0vNqfomhMDgfLI2zLQ6i6IgC1lLKSPjxUns4KziUhDugGlSnLynIcmxLUBaCp
 GPr/3p48C0WJMjP7WNVXpc7wCn4=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7cabe2.7f4e24117500-smtp-out-n05;
 Thu, 26 Mar 2020 13:19:30 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7C643C433BA; Thu, 26 Mar 2020 13:19:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ssreeela)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2C320C433F2;
        Thu, 26 Mar 2020 13:19:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 26 Mar 2020 18:49:29 +0530
From:   ssreeela@codeaurora.org
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Lei Wang <leiwa@codeaurora.org>, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org
Subject: Re: [PATCH] ath10k: enable radar detection in secondary segment
In-Reply-To: <87o8sj2zz7.fsf@kamboji.qca.qualcomm.com>
References: <1585158041-11740-1-git-send-email-ssreeela@codeaurora.org>
 <20200326100139.5BC86C433BA@smtp.codeaurora.org>
 <87o8sj2zz7.fsf@kamboji.qca.qualcomm.com>
Message-ID: <1b4c3f1ecaa1acb7684c35010a4e3316@codeaurora.org>
X-Sender: ssreeela@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-03-26 15:35, Kalle Valo wrote:
> Kalle Valo <kvalo@codeaurora.org> writes:
> 
>> Sowmiya Sree Elavalagan <ssreeela@codeaurora.org> wrote:
>> 
>>> From: Lei Wang <leiwa@codeaurora.org>
>>> 
>>> Enable radar detection in secondary segment for VHT160 and VHT80+80 
>>> mode
>>> on DFS channels. Otherwise, when injecting radar pulse in the 
>>> secondary
>>> segment, the DUT can't detect radar pulse.
>>> 
>>> Tested: qca9984 with firmware ver 10.4-3.10-00047
>>> 
>>> Signed-off-by: Lei Wang <leiwa@codeaurora.org>
>>> Signed-off-by: Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
>> 
>> Failed to apply:
>> 
>> error: patch failed: drivers/net/wireless/ath/ath10k/wmi.c:1717
>> error: drivers/net/wireless/ath/ath10k/wmi.c: patch does not apply
>> stg import: Diff does not apply cleanly
>> 
>> Patch set to Changes Requested.
> 
> I guess this depends on "ath10k: enable VHT160 and VHT80+80 modes"? If
> that's the case then you should submit them in the same patchset to 
> make
> the dependency clear.

Yes, this patch is dependent on ath10k: enable VHT160 and VHT80+80 
modes.
Sure will update and send.

Thanks,
Sowmiya Sree
