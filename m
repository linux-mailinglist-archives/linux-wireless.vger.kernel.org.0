Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1AB8BC4E3
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2019 11:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393857AbfIXJc1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Sep 2019 05:32:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35436 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390668AbfIXJc1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Sep 2019 05:32:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1AD946083C; Tue, 24 Sep 2019 09:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569317546;
        bh=dX/ugPSN7GpC2cgkwy21GdHlwo09xtkP3Ul+IY1tFL0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZgCy1WNYrBnOd+22Y8zh93gvyD3YGWlPbkk9h57Xod5TKwiAFDaAmSC8xvdpk/hXL
         OQLCrGOOmB5NgT6cdq7Aqa82oPvvTe+t7h//jWyJCDly8VO86vvf5ZN86uH/cKAmBj
         ooEOlSC7mobDla4HCgkK5xTr6lVMf2AaiV9yJHck=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id AF4BE602F2;
        Tue, 24 Sep 2019 09:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569317545;
        bh=dX/ugPSN7GpC2cgkwy21GdHlwo09xtkP3Ul+IY1tFL0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eEDeUK/v+XeG7Rtf3FmL97hu5qtJPfnbf6u/M++KT4QSEQearGQLXkRNe7Q7fFcWF
         /G3odYOii0ze8i03zpG3pOCcgDJ8d0lcDRtoPqH2KEI/L7bSRr8e2zwX+zxsEkKGdV
         uWOFWnPf+0pDF/jiTnhTvFAzn7P2IUL6z81lJKu8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 24 Sep 2019 17:32:25 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5 3/8] ath10k: change max RX bundle size from 8 to 32 for
 sdio
In-Reply-To: <871rw79ycy.fsf@codeaurora.org>
References: <1567679893-14029-1-git-send-email-wgong@codeaurora.org>
 <1567679893-14029-4-git-send-email-wgong@codeaurora.org>
 <871rw79ycy.fsf@codeaurora.org>
Message-ID: <5f2387dc4c97a5edff78fa6ce7dcd401@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-09-23 17:05, Kalle Valo wrote:

>> 
>> +#define ATH10K_HTC_FLAG_BUNDLE_MASK 0xF0
>> +#define ATH10K_HTC_BUNDLE_EXTRA_MASK GENMASK(3, 2)
>> +
>> +#define ATH10K_HTC_GET_BUNDLE_COUNT(flags) \
>> +	    (FIELD_GET(ATH10K_HTC_FLAG_BUNDLE_MASK, (flags)) +  \
>> +	    (FIELD_GET(ATH10K_HTC_BUNDLE_EXTRA_MASK, (flags)) << 4))
> 
> When using FIELD_GET() there should be no need to use '<<', the main id
> of FIELD_GET() and BITMASK() is that there's no need do any manual
> shifting. So I suspect something is wrong here, but didn't have time to
> investigate.
the value is like this:
the u8 flags:
b7 b6 b5 b4 b3 b2 b1 b0
the count= 0Bb7b6b5b4 + 0Bb3b2 << 4
FIELD_GET is to >>, not <<
so it need to manual shift for the "0Bb3b2 << 4"
