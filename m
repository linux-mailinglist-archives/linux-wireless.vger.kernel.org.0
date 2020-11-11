Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF382AEC96
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 10:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgKKJEb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Nov 2020 04:04:31 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:47480 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbgKKJEZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Nov 2020 04:04:25 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605085464; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=uvpjxQeagsAM0VS4xPDmbit/1jf+GkG6CAKjLKXQE5E=; b=LBqGq78qG4dcAMGHA4nJ9VV0vorsG2Tn/Hs4tVWwMOVVm8rr+njwrhgR0+OXy+jgrgZOvoTh
 RO5Kn9ChV+wvOpPqRr1+2d1v7hUbD/vVRJ4ZNKIE5Nwt2MghSpi//sU1yxAw0ZIlF5Zno5gF
 QNN9+mLHLupH4htbMa2RqRWNckg=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5faba917b8c6a84a5cfce5e7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 11 Nov 2020 09:04:23
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 060CAC433C6; Wed, 11 Nov 2020 09:04:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 514D2C433C6;
        Wed, 11 Nov 2020 09:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 514D2C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>
Subject: Re: [PATCH 2/2] qtnfmac: add support for the new revision of QSR10g chip
References: <20191121135324.21715-1-sergey.matyukevich.os@quantenna.com>
        <20191121135324.21715-3-sergey.matyukevich.os@quantenna.com>
        <0101016e8f9afb9b-7e5241a3-3145-45dd-a178-8f4c9d5ff83e-000000@us-west-2.amazonses.com>
        <20191126075150.e2rrz3jqx627l3g2@bars>
        <20200127083404.jr6k2clfxgv7vxz7@bars>
        <20200424101707.nbkojo74vaucq55z@bars>
Date:   Wed, 11 Nov 2020 11:04:19 +0200
In-Reply-To: <20200424101707.nbkojo74vaucq55z@bars> (Sergey Matyukevich's
        message of "Fri, 24 Apr 2020 13:17:08 +0300")
Message-ID: <874klwb6y4.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sergey Matyukevich <sergey.matyukevich.os@quantenna.com> writes:

>> > > > Add support for the new minor revision of QSR10g chip. Major changes from
>> > > > the driver perspective include PCIe data path modifications. Setup is now
>> > > > more complicated, but finally more things have been offloaded to hardware.
>> > > > As a result, less driver boilerplate operations are needed after Tx/Rx
>> > > > descriptors queues have been configured. Besides, restrictions on
>> > > > descriptors queue lengths have been relaxed.
>> > > >
>> > > > Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
>> > > 
>> > > What about the firmware, is that available for this new revision?
>> > 
>> > Hello Kalle,
>> > 
>> > There are two drivers: pearl_qtnfmac for QSR10G and topaz_qtnfmac for
>> > QSR1000. Firmware for QSR1000 chips has a higher priority since those
>> > devices have been in production for quite a while now and there are
>> > multiple products available. From the engineering perspective we are
>> > ready to release firmware and SDK for QSR1000/QSR2000 devices. Now we
>> > are waiting for the ACK from legal team. This was delayed by the
>> > acquisition of Quantenna by On Semiconductor.  
>> > 
>> > As for the latest QSR10G chips, we are not yet ready to release SDK.
>> > The main reason is that platform is under active development.
>> 
>> Hello Kalle,
>> 
>> I noticed that you marked these two patches as deferred in patchwork.
>> Is there anything else I have to do here ?
>> 
>> Regards,
>> Sergey
>
> Hello Kalle,
>
> Could you please clarify your expectations regarding this functionality.
> Am I correct assuming that you implicitly tie acceptance of these patches
> with the promised release of firmware and SDK for QSR1000/2000 family ?

Sorry for the delay, I wanted to check the qtnfmac firmware status
before responding. And it didn't look good. The wiki page[1] mentions
nothing about the firmware, neither does Kconfig and even a quick google
search didn't make me any wiser. So I have no clue what's the current
situation with the firmware.

I don't like this at all. All upstream drivers are supposed to be used
by _anyone_ and the firmware should be publically available, with a very
strong preference having the firmware in linux-firmware repo. I made an
exception with qtnfmac and didn't require it to be in linux-firmware,
IIRC the reason being there were some problems with the firmware license
(something related to GPL?).

Upstream drivers need to have the firmware available. If Quantenna does
not want to release the firmware I'm not willing to accept patches to
new hardware either. I will accept patches for hardware already in
upstream, but any patches adding new hardware support will be
automatically rejected until the firmware issue is resolved.

[1] https://wireless.wiki.kernel.org/en/users/drivers/qtnfmac

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
