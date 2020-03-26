Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9411939A9
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 08:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgCZHc6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 03:32:58 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:44976 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726279AbgCZHc5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 03:32:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585207977; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=YV5XKybcJAzc1uXbtZEt7MmmKQ0BO2bNb96ne3ec7CM=; b=Sd1CQ2GjNffwQ7OFRBfCSfd+ZFnQIFZTQqTzs7rbguFbWoznWzec4tDNk7IkjxTKYWuKLK3h
 Tk9QD+2SX2Kq42LEiDBa3+iIOPeLBy4jz4YzCSoy1VR5MyNRU8TshVlbkSOqc3mqX6jfcQOX
 HiDl7CN8N9qokwCUjbPvE7tUJUc=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7c5a94.7f695a3b3f80-smtp-out-n05;
 Thu, 26 Mar 2020 07:32:36 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 98125C433BA; Thu, 26 Mar 2020 07:32:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6ED89C433F2;
        Thu, 26 Mar 2020 07:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6ED89C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 01/14] iwlwifi: mvm: add soc latency support
References: <20200323131925.208376-1-luca@coelho.fi>
        <iwlwifi.20200323151304.a491f6c5ae4b.I6829a46b89e4e701f80a0e4033f4dd41ee44ed12@changeid>
        <877dz94wrg.fsf@kamboji.qca.qualcomm.com>
        <937db1c0c8a1352705f07d7866873efba0d1da44.camel@coelho.fi>
Date:   Thu, 26 Mar 2020 09:32:31 +0200
In-Reply-To: <937db1c0c8a1352705f07d7866873efba0d1da44.camel@coelho.fi> (Luca
        Coelho's message of "Thu, 26 Mar 2020 08:49:11 +0200")
Message-ID: <87ftdvk1v4.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> On Tue, 2020-03-24 at 17:07 +0200, Kalle Valo wrote:
>> Luca Coelho <luca@coelho.fi> writes:
>> 
>> > From: Shahar S Matityahu <shahar.s.matityahu@intel.com>
>> > 
>> > Some devices require longer time to stabilize the power and XTAL.
>> > This is especially true for devices integrated in the SoC.  Add
>> > support for a new firmware API that allows the driver to set the
>> > latency value accordingly.
>> > 
>> > Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
>> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
>> 
>> [...]
>> 
>> > +++ b/drivers/net/wireless/intel/iwlwifi/fw/api/soc.h
>> > @@ -0,0 +1,83 @@
>> > +/******************************************************************************
>> > + *
>> > + * This file is provided under a dual BSD/GPLv2 license.  When using or
>> > + * redistributing this file, you may do so under either license.
>> 
>> Any chance of getting SPDX tags to iwlwifi soon? They are awesome and
>> make life so much easier.
>
> Hmmm... Most of our files already have it.

Ah, I didn't notice that.

> I'll add the tags to the remaining ones and send it upstream as usual.

Great, thanks. It would be really nice to have consistency within a
driver.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
