Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4AC24B5EA
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Aug 2020 12:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbgHTK3P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Aug 2020 06:29:15 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:12894 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731528AbgHTKVN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Aug 2020 06:21:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597918872; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=HolENV0PLucsJBynD12KbFB6wnbHdvgd5cuDF31fGn8=;
 b=COGVljXjFAaP8aU7W7xnHPwPtZdeYOqOy0ztYMFBwvM6B8s8eYfDj90qrdzwsGf4KuPUWuvW
 Cd+BV6Qz/mrLJWJO7m7OFh/v7yzpYuWFuikTLj4pk18mwvswlSg6BO+PD97+ftGBU21WtXzJ
 MsZCuMb+1GnVA7BWytYXNVDw1j0=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f3e4e7eb3f338a090b50298 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 20 Aug 2020 10:20:46
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A2186C433CB; Thu, 20 Aug 2020 10:20:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2C8A9C43387;
        Thu, 20 Aug 2020 10:20:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 Aug 2020 18:20:46 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Krishna Chaitanya <chaitanya.mgit@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>
Subject: Re: [RFC] ath10k: change to do napi_enable and napi_disable when
 insmod and rmmod for sdio
In-Reply-To: <CABPxzYJLvrZKFeun0PmvE5NbXfke3orJnaXEY3e17xeBYkSqnw@mail.gmail.com>
References: <20200214035555.24762-1-wgong@codeaurora.org>
 <878se9iup3.fsf@codeaurora.org>
 <CABPxzYK4kYvBAvYxk6rs-PHM==vBaHQTm3dCCh_+Z+KOB+c6qA@mail.gmail.com>
 <CABPxzYJLvrZKFeun0PmvE5NbXfke3orJnaXEY3e17xeBYkSqnw@mail.gmail.com>
Message-ID: <17857699628b4627ac3c781d9a20c0d8@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-08-20 17:26, Krishna Chaitanya wrote:
> On Thu, Aug 20, 2020 at 2:49 PM Krishna Chaitanya
> <chaitanya.mgit@gmail.com> wrote:
>> 
>> On Thu, Aug 20, 2020 at 2:03 PM Kalle Valo <kvalo@codeaurora.org> 
>> wrote:
>> >
>> > Wen Gong <wgong@codeaurora.org> writes:
>> >
...
>> > I'm not really convinced that this is the right fix, but I'm no NAPI
>> > expert. Can anyone else help?
>> Calling napi_disable() twice can lead to hangs, but moving NAPI from
>> start/stop to
>> the probe isn't the right approach as the datapath is tied to 
>> start/stop.
>> 
>> Maybe check the state of NAPI before disable?
>> 
>>  if (test_bit(NAPI_STATE_SCHED, &ar->napi.napi.state))
>>   napi_disable(&ar->napi)
>> 
>> or maintain napi_state like this 
>> https://patchwork.kernel.org/patch/10249365/
>> 
>> Also, the most common cause for such issues (1st
>> napi_synchronize/napi_disable hang)
>> is that napi_poll is being scheduled, so, you might want to check that
>> napi_schedule isn't
>> called after stop.
>> 
>> cd ath10k; git log --grep=napi shows plenty of such issues. the one
>> that matches closest is
>> c2cac2f74ab4bcf0db0dcf3a612f1e5b52d145c8, so, it could just be a 
>> regression.
> Also, I see that napi_schedule() is being called from work_queue 
> async_work_rx
> so we should cancel that work in hif_stop before calling 
> napi_synchronize.
Yes, I will do that in a new patch.
