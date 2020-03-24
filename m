Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2627B190702
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2020 09:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgCXIHK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Mar 2020 04:07:10 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:27910 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726081AbgCXIHK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Mar 2020 04:07:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585037229; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=OexxCsDxMktm3qYhK0o2fjls+ZpSajpQ4OCMAhLYhHk=; b=Nulezsxmr3eepNJsSCWkiJp219yFIlhsZe541L110YYL8Age6fWLMHi8N+KuD1D2F/YqyPpR
 To1da0k9+DaOOhT3JeKq19WR2ThZOeTst5BOnl/b8/Q+tFJ8+YkgeEyeWT+DkUBGEkwnzl2e
 4HDnHn9bVYvSkP7S3XAl95aklnM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e79bfac.7f3b07aa85e0-smtp-out-n03;
 Tue, 24 Mar 2020 08:07:08 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AFCC2C432C2; Tue, 24 Mar 2020 08:07:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4E6E2C433CB;
        Tue, 24 Mar 2020 08:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4E6E2C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Wireless <linux-wireless@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the wireless-drivers-next tree with the wireless-drivers tree
References: <20200324111653.35c368e4@canb.auug.org.au>
        <87wo7a8cex.fsf@kamboji.qca.qualcomm.com>
        <122b75308eea43076367d06879552270e11dfbb4.camel@coelho.fi>
Date:   Tue, 24 Mar 2020 10:07:03 +0200
In-Reply-To: <122b75308eea43076367d06879552270e11dfbb4.camel@coelho.fi> (Luca
        Coelho's message of "Tue, 24 Mar 2020 09:29:08 +0200")
Message-ID: <87sghy89co.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> On Tue, 2020-03-24 at 09:00 +0200, Kalle Valo wrote:
>> Stephen Rothwell <sfr@canb.auug.org.au> writes:
>> 
>> > Today's linux-next merge of the wireless-drivers-next tree got a
>> > conflict in:
>> > 
>> >   drivers/net/wireless/intel/iwlwifi/pcie/drv.c
>> > 
>> > between commit:
>> > 
>> >   cf52c8a776d1 ("iwlwifi: pcie: add 0x2526/0x401* devices back to cfg detection")
>> > 
>> > from the wireless-drivers tree and commits:
>> > 
>> >   67eb556da609 ("iwlwifi: combine 9260 cfgs that only change names")
>> >   d6f2134a3831 ("iwlwifi: add mac/rf types and 160MHz to the device tables")
>> > 
>> > from the wireless-drivers-next tree.
>> > 
>> > I fixed it up (I am not sure wat to do with this, so I just dropped
>> > the former changes for now) and can carry the fix as necessary. This
>> > is now fixed as far as linux-next is concerned, but any non trivial
>> > conflicts should be mentioned to your upstream maintainer when your tree
>> > is submitted for merging.  You may also want to consider cooperating
>> > with the maintainer of the conflicting tree to minimise any particularly
>> > complex conflicts.
>> 
>> Thanks Stephen. Luca, how do you propose to fix this conflict?
>
> The resolution is correct.  Just drop the cf52c8a776d1 changes, since
> the list of specific subsytem device IDs are not necessary after
> d6f2134a3831 anymore.  The detection is based on other characteristics
> of the devices.

Thanks, I'll mention this in my pull request to Dave.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
