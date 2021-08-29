Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215113FAB1A
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Aug 2021 13:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbhH2L3L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Aug 2021 07:29:11 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:38510 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235182AbhH2L3L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Aug 2021 07:29:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630236499; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=P4lJHb7pDN9FrtCuoO6tBktofb7QVZJHQjPDPRgiOTc=; b=ZDV3XjQibYEzbIopbQvC7VNrUVINpoNFmc0ey1aCcmvTI+RLQGYjySfmuW7TxwbxxpSC1KfX
 GYVTa07/ov4nevdidQkB63wN2BA3padq+vPf9FiJzTq1sDQZivl3iciK8X/DQTZT7SoNyx2J
 WBSNvD7IsBC0xibjqgVuDwZ6Yoo=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 612b6f44c603a0154f7bec3d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 29 Aug 2021 11:28:04
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9DDD5C4360D; Sun, 29 Aug 2021 11:28:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5FAA3C4338F;
        Sun, 29 Aug 2021 11:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 5FAA3C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 10/12] iwlwifi: Add support for getting rf id with blank otp
References: <20210820110318.260751-1-luca@coelho.fi>
        <iwlwifi.20210820140104.8f8ce6f25ecd.Iec9b2e2615ce65e6aff5ce896589227a7030f4cf@changeid>
        <87tujisxfq.fsf@codeaurora.org>
        <ce687133d7edf29abb421a9f1a105bb9eedd9761.camel@coelho.fi>
        <e9265c03dee77861f5aeb8d94569b51d28bca148.camel@coelho.fi>
Date:   Sun, 29 Aug 2021 14:27:56 +0300
In-Reply-To: <e9265c03dee77861f5aeb8d94569b51d28bca148.camel@coelho.fi> (Luca
        Coelho's message of "Thu, 26 Aug 2021 14:45:55 +0300")
Message-ID: <87sfys4hj7.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> On Thu, 2021-08-26 at 14:30 +0300, Luca Coelho wrote:
>> On Sat, 2021-08-21 at 17:07 +0300, Kalle Valo wrote:
>> > Luca Coelho <luca@coelho.fi> writes:
>> > 
>> > > From: Matti Gottlieb <matti.gottlieb@intel.com>
>> > > 
>> > > When having a blank OTP the only way to get the rf id
>> > > and the cdb info is from prph registers.
>> > > 
>> > > Currently there is some implementation for this, but it
>> > > is located in the wrong place in the code (should be before
>> > > trying to understand what HW is connected and not after),
>> > > and it has a partial implementation.
>> > > 
>> > > Signed-off-by: Matti Gottlieb <matti.gottlieb@intel.com>
>> > > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
>> > 
>> > [...]
>> > 
>> > > +/*
>> > > + * struct iwl_crf_chip_id_reg
>> > > + *
>> > > + * type: bits 0-11
>> > > + * reserved: bits 12-18
>> > > + * slave_exist: bit 19
>> > > + * dash: bits 20-23
>> > > + * step: bits 24-26
>> > > + * flavor: bits 27-31
>> > > + */
>> > > +struct iwl_crf_chip_id_reg {
>> > > +	u32 type : 12;
>> > > +	u32 reserved : 7;
>> > > +	u32 slave_exist : 1;
>> > > +	u32 dash : 4;
>> > > +	u32 step : 4;
>> > > +	u32 flavor : 4;
>> > > +};
>> > 
>> > This doesn't look endian safe.
>> 
>> It's not exactly that this is not endian safe, but we had two issues:
>> 
>> 1. AFAIK these bitfields are not guaranteed to be kept in order, so we
>> shouldn't use them.  I'll change it to decode this in some other way.
>> 
>> 2. We are actually reading the register without caring for endianess. 
>> I will fix it.
>
> Oops, as Johannes pointed out offline, this is not an issue, actually.
> I got confused with some places where we do cpu_to_le32() after
> reading, which is the opposite and essentially proves that the read is
> in cpu-endianess.  So I won't "fix" it. ;)

Good that endian is handled properly, thanks for checking.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
