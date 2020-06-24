Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A39206F6B
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2020 10:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389322AbgFXIuZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jun 2020 04:50:25 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:39680 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389521AbgFXIuT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jun 2020 04:50:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592988619; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=VUDZ7CIdCQG2R0dxVIRY2kHAUR5DLpmrneQaOynhiIw=; b=Cvp3M5EvQFv8yErUD5tn0XoWSnpvsSot48pvgGDTWn3aibusiOFW1KzuOIMJbtm1X7PkvHWi
 JmC1K9a8SF5xEIyT3LsTb1nKj8r+apr9XoZeNaYEvHJRZ9B924h3BU+OgeGK89MBQUssnhWx
 g4CNdQ0hYr8d96IBMviuZoEwZeg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5ef313c76f2ee827da5852b8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 24 Jun 2020 08:50:15
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C156CC433CB; Wed, 24 Jun 2020 08:50:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 50C06C43395;
        Wed, 24 Jun 2020 08:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 50C06C43395
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <Ajay.Kathat@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Nicolas.Ferre@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <Sripad.Balwadgi@microchip.com>, <Venkateswara.Kaja@microchip.com>
Subject: Re: [PATCH v7 00/17] wilc1000: move out of staging
References: <20200623110000.31559-1-ajay.kathat@microchip.com>
Date:   Wed, 24 Jun 2020 11:50:07 +0300
In-Reply-To: <20200623110000.31559-1-ajay.kathat@microchip.com> (Ajay Kathat's
        message of "Tue, 23 Jun 2020 11:00:04 +0000")
Message-ID: <87ftaketkw.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Ajay.Kathat@microchip.com> writes:

> From: Ajay Singh <ajay.kathat@microchip.com>
>
> This patch series is to review and move wilc1000 driver out of staging.
> Most of the review comments received in [1] & [2] are addressed in the
> latest code.
> Please review and provide your inputs.
>
> [1]. https://lore.kernel.org/linux-wireless/1537957525-11467-1-git-send-email-ajay.kathat@microchip.com/
> [2]. https://lore.kernel.org/linux-wireless/1562896697-8002-1-git-send-email-ajay.kathat@microchip.com/
>
> Changes since v6:
>  - added Reviewed-by tag received for DT binding document patch earlier.
>    * https://lore.kernel.org/linux-wireless/20200405013235.GA24105@bogus
>  - merged latest driver and included --base commit as suggested.

Greg, in preparation for moving the driver to drivers/net/wireless can I
ask you to not to take wilc1000 patches for the time being? I think that
way it would be easier to move the driver between trees if there are no
changes after v5.8-rc1. Or is there a better way handle the move?

I have not reviewed the latest version yet but I'm hoping it's ready
now. I would also appreciate comments from other people about the
readiness of this driver.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
