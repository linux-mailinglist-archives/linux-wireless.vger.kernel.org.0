Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8AB7207062
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2020 11:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390078AbgFXJtd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jun 2020 05:49:33 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:45734 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389848AbgFXJtc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jun 2020 05:49:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592992172; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=V1XwvcOUVZ2jA1BI4jck52plbBIzsBRUg7wJIhA94nE=; b=rrNRtmd1K3ZyoQWCXa5HNFItK5H7Sa+Q+NpdThzeQ2B+L9PGFJLSL1DKDkPk6KsuAwF27Dfk
 W/KBc8CO1JClxCmei+L/Cb/JX/gEjN8qWzxBpNi04zjIlSGib/AydJqKTmsd0A/cDCvJzq9e
 IXrpDEWr8WUG720uSV4Xa6gQeeU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5ef321ab356bcc26abeed523 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 24 Jun 2020 09:49:31
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ED6D2C433CB; Wed, 24 Jun 2020 09:49:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 05663C4339C;
        Wed, 24 Jun 2020 09:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 05663C4339C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Ajay.Kathat@microchip.com, devel@driverdev.osuosl.org,
        Venkateswara.Kaja@microchip.com, Sripad.Balwadgi@microchip.com,
        linux-wireless@vger.kernel.org, Nicolas.Ferre@microchip.com,
        johannes@sipsolutions.net
Subject: Re: [PATCH v7 00/17] wilc1000: move out of staging
References: <20200623110000.31559-1-ajay.kathat@microchip.com>
        <87ftaketkw.fsf@tynnyri.adurom.net>
        <20200624091000.GD1731290@kroah.com>
Date:   Wed, 24 Jun 2020 12:49:24 +0300
In-Reply-To: <20200624091000.GD1731290@kroah.com> (Greg KH's message of "Wed,
        24 Jun 2020 11:10:00 +0200")
Message-ID: <87366kztcr.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> writes:

> On Wed, Jun 24, 2020 at 11:50:07AM +0300, Kalle Valo wrote:
>> <Ajay.Kathat@microchip.com> writes:
>> 
>> > From: Ajay Singh <ajay.kathat@microchip.com>
>> >
>> > This patch series is to review and move wilc1000 driver out of staging.
>> > Most of the review comments received in [1] & [2] are addressed in the
>> > latest code.
>> > Please review and provide your inputs.
>> >
>> > [1]. https://lore.kernel.org/linux-wireless/1537957525-11467-1-git-send-email-ajay.kathat@microchip.com/
>> > [2]. https://lore.kernel.org/linux-wireless/1562896697-8002-1-git-send-email-ajay.kathat@microchip.com/
>> >
>> > Changes since v6:
>> >  - added Reviewed-by tag received for DT binding document patch earlier.
>> >    * https://lore.kernel.org/linux-wireless/20200405013235.GA24105@bogus
>> >  - merged latest driver and included --base commit as suggested.
>> 
>> Greg, in preparation for moving the driver to drivers/net/wireless can I
>> ask you to not to take wilc1000 patches for the time being? I think that
>> way it would be easier to move the driver between trees if there are no
>> changes after v5.8-rc1. Or is there a better way handle the move?
>
> The best way is for there to be a series of patches that just adds the
> driver to the "real" part of the tree, and when that is merged, let me
> know and I will just delete the driver version in the staging tree.
>
> Does that work for you?

It would be fine for me but won't that approach break the build (eg.
allyesconfig) due to two duplicate versions of the same driver in
wireless-drivers-next?

What I was thinking that Ajay would create a patch moving the driver
from drivers/staging/wilc1000 to
drivers/net/wireless/microchip/wilc1000. Using 'git mv' and 'git
format-patch --find-renames' the patch should be really small, mostly
just renames and small changes to Kconfig, Makefile and MAINTAINERS
files. But this of course would require that there are no wilc1000
patches in your tree until you get the driver move commit during the
next merge window, otherwise we would see conflicts between staging-next
and wireless-drivers-next.

But I don't have any strong opinions, whatever is easiest for everyone :)

For reference wireless-drivers-next is merged like this:

wireless-drivers-next -> net-next -> linus

And naturally I would be aiming this for the v5.9 merge window.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
