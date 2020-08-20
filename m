Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B4524C0BA
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Aug 2020 16:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgHTOiB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Aug 2020 10:38:01 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:33626 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727107AbgHTOiA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Aug 2020 10:38:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597934280; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=6nZH+MOtU7JM7B/Js9Nzq8u18EdhiJWbmrNEHfbOCro=;
 b=J6E3jemsgRF1EXDxChqxYcABVd7cw1IWOnJy8YHkHoV44VgDH2BGOdHusIZffcIqYae6B/RN
 QeDIvZAypNROC0I3hsT0JT0oBAyCWc37HJ8RgZEaU6m/aSxyP8hwKIZXdXwpyqTBZx1/JXi7
 VbS+6CUZSO5TYtAr9qEwmw78Dzc=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f3e8ac07eb4541d93df86ae (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 20 Aug 2020 14:37:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0A2B6C43387; Thu, 20 Aug 2020 14:37:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 87D55C433CA;
        Thu, 20 Aug 2020 14:37:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 Aug 2020 22:37:50 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Krishna Chaitanya <chaitanya.mgit@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>
Subject: Re: [RFC] ath10k: change to do napi_enable and napi_disable when
 insmod and rmmod for sdio
In-Reply-To: <CABPxzYK6wd8FGaM9tb_PYroARJ8RCjJ0Y-nVxY3AoubrfSbZ4w@mail.gmail.com>
References: <20200214035555.24762-1-wgong@codeaurora.org>
 <878se9iup3.fsf@codeaurora.org>
 <CABPxzYK4kYvBAvYxk6rs-PHM==vBaHQTm3dCCh_+Z+KOB+c6qA@mail.gmail.com>
 <b7e0e8dfe9a4ee0cb92c6c0f153c7bc2@codeaurora.org>
 <CABPxzYK6wd8FGaM9tb_PYroARJ8RCjJ0Y-nVxY3AoubrfSbZ4w@mail.gmail.com>
Message-ID: <dcc45384935dca14ac6ab31ec1123414@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-08-20 18:52, Krishna Chaitanya wrote:
> On Thu, Aug 20, 2020 at 3:45 PM Wen Gong <wgong@codeaurora.org> wrote:
>> 
>> On 2020-08-20 17:19, Krishna Chaitanya wrote:
...
>> >> I'm not really convinced that this is the right fix, but I'm no NAPI
>> >> expert. Can anyone else help?
>> > Calling napi_disable() twice can lead to hangs, but moving NAPI from
>> > start/stop to
>> > the probe isn't the right approach as the datapath is tied to
>> > start/stop.
>> >
>> > Maybe check the state of NAPI before disable?
>> >
>> >  if (test_bit(NAPI_STATE_SCHED, &ar->napi.napi.state))
>> >   napi_disable(&ar->napi)
>> > or maintain napi_state like this
>> > https://patchwork.kernel.org/patch/10249365/
>> it is better to use above link's patch.
>> napi.state is controlled by napi API, it is better ath10k not know it.
> Sure, but IMHO just canceling the async rx work should solve the issue.
Oh no, canceling the async rx work will not solve this issue, rx worker
ath10k_rx_indication_async_work call napi_schedule, after napi_complete,
the NAPI_STATE_SCHED will clear.
The issue of this patch is because 2 thread called to hif_stop and
NAPI_STATE_SCHED not clear.
...
