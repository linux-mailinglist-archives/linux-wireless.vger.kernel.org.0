Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580BB1CEEF9
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2020 10:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgELITM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 May 2020 04:19:12 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:26019 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725823AbgELITL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 May 2020 04:19:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589271551; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=JkH5Lpb6vcb0r+1iNMeKZsrfDvZIUMWw0ao4pTLgv0A=; b=pttPqlPYJen3LGv47Jb7vXpCbbgG9zTr8pr3Rljmwq3TVXuvdoXX6Fgn1vUkAQ5wD8YWFKbJ
 GYeEadeGFsXytWXiqIWuB7T7ZBigiKiLXdhq2EOLRM/UmOgpffDpL/Q0EdlO1jQcjrggrDny
 +lLFFU+lDCA8Zm05bPK9vBjdeiM=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eba5bfc.7fdbb30db2d0-smtp-out-n03;
 Tue, 12 May 2020 08:19:08 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C3B64C43636; Tue, 12 May 2020 08:19:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B60A0C433CB;
        Tue, 12 May 2020 08:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B60A0C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Govind Singh <govinds@codeaurora.org>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH 4/4] ath11k: Register mhi controller device for qca6390
References: <20200508085850.23363-1-govinds@codeaurora.org>
        <20200508085850.23363-5-govinds@codeaurora.org>
        <87d07a4acz.fsf@kamboji.qca.qualcomm.com>
        <20200512071323.GI4928@Mani-XPS-13-9360>
Date:   Tue, 12 May 2020 11:19:04 +0300
In-Reply-To: <20200512071323.GI4928@Mani-XPS-13-9360> (Manivannan Sadhasivam's
        message of "Tue, 12 May 2020 12:43:23 +0530")
Message-ID: <871rnp4lc7.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:

> Hi Kalle,
>
> On Mon, May 11, 2020 at 09:03:56PM +0300, Kalle Valo wrote:
>> 
>> Govind Singh <govinds@codeaurora.org> writes:
>> 
>> >  config ATH11K_PCI
>> >  	tristate "Qualcomm Technologies 802.11ax chipset PCI support"
>> > -	depends on ATH11K && PCI
>> > +	depends on ATH11K && PCI && MHI_BUS
>> >  	---help---
>> >  	  This module adds support for PCIE bus
>> 
>> Currently ATH11K_PCI is not visible if MHI_BUS is disabled, which I'm
>> worried will confuse the users. I wonder if we should use 'select
>> MHI_BUS' instead? That way ATH11K_PCI would be visible even if MHI_BUS
>> is disabled.
>> 
>
> Right, this sounds good to me.

Good, I added that in the pending branch.

>> And what about QRTR_MHI? Mani, any suggestions?
>> 
>
> Are you asking for Kconfig dependency? If yes, then you need to select it here
> also as you can't do much without it.

Ok, I added QRTR_MHI to Kconfig as well I also had to add "select MHI"
as othwerwise I would get this warning:

WARNING: unmet direct dependencies detected for QRTR_MHI
  Depends on [n]: NET [=y] && QRTR [=n] && MHI_BUS [=m]
  Selected by [m]:
  - ATH11K_PCI [=m] && NETDEVICES [=y] && WLAN [=y] && WLAN_VENDOR_ATH [=y] && ATH11K [=m] && PCI [=y]

So now Kconfig looks like:

config ATH11K_PCI
	tristate "Qualcomm Technologies 802.11ax chipset PCI support (work in-progress)"
	depends on ATH11K && PCI
	select MHI_BUS
	select QRTR
	select QRTR_MHI
	---help---
	  This module adds support for PCIE bus

Govind&Mani, please check my changes in the pending branch:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=5ebf69d1db8b027671b642e3ba0bec3d7c73acb7

> Btw, I'm not CCed for the patch so I haven't looked at it.

This patchset is in my pending branch, link above.

> But we have made few changes to the MHI stack which will impact the
> controller drivers.

Oh, that will create problems. What kind of changes are needed in
ath11k?

> So I'd suggest you to rebase MHI controller patch on top of mhi-next
> [1]. The proposed changes in MHI will hopefully land in 5.8.

I cannot rebase on top mhi-next as my patches go through net-next. One
option I can think of is that I'll pull (not rebase!) mhi-next to my
tree, but I would need to check with David Miller first and I'm not sure
if it's worth the trouble. I think easiest is that we find minimal
possible changes needed to accommodate the new MHI interface and then
inform Linus and Stephen when do the merges.

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git/log/?h=mhi-next

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
