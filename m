Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A637D211C54
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2020 09:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgGBHBZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Jul 2020 03:01:25 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:27275 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbgGBHBY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Jul 2020 03:01:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593673284; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=vV+WEa9lR4z9vQ/BiZfiSTXTYWp+rAsHXFb2XHfCL/c=; b=o3hGUGO2bNSunkT0u+LVnAXBGUKwEL2flahgIs0FQrkyhztH6t0frgnzggs59Ubuud9xhqDU
 asmY++UcN4AUanswAhQAMqQnbV/Hhr4BCbiKAAKWyks4vytPxPS6T0pbd3KUIApljLvO1986
 +PYJ1eFgPjK5so0/gxn5HFhWy3A=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n20.prod.us-west-2.postgun.com with SMTP id
 5efd861e4c9690533a4052ab (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 02 Jul 2020 07:00:46
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D0D1BC43395; Thu,  2 Jul 2020 07:00:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6DB04C433C6;
        Thu,  2 Jul 2020 07:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6DB04C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <Ajay.Kathat@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Nicolas.Ferre@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <Sripad.Balwadgi@microchip.com>, <Venkateswara.Kaja@microchip.com>
Subject: Re: [PATCH] wilc1000: move wilc driver out of staging
References: <20200625123712.14156-1-ajay.kathat@microchip.com>
Date:   Thu, 02 Jul 2020 10:00:40 +0300
In-Reply-To: <20200625123712.14156-1-ajay.kathat@microchip.com> (Ajay Kathat's
        message of "Thu, 25 Jun 2020 12:37:23 +0000")
Message-ID: <875zb6e6zr.fsf@tynnyri.adurom.net>
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
> WILC1000 is an IEEE 802.11 b/g/n IoT link controller module. The
> WILC1000 connects to Microchip AVR/SMART MCUs, SMART MPUs, and other
> processors with minimal resource requirements with a simple
> SPI/SDIO-to-Wi-Fi interface.
>
> WILC1000 driver has been part of staging for few years. With
> contributions from the community, it has improved significantly. Full
> driver review has helped in achieving the current state.
> The details for those reviews are captured in 1 & 2.
>
> [1]. https://lore.kernel.org/linux-wireless/1537957525-11467-1-git-send-email-ajay.kathat@microchip.com/
> [2]. https://lore.kernel.org/linux-wireless/1562896697-8002-1-git-send-email-ajay.kathat@microchip.com/
>
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
> ---
>
> As suggested, keeping all the changes in single commit with file rename
> so it's easy to move out of staging [3].
>
> Please choose whichever option you prefer between the git mv or patch series
> sent last Tuesday. The resulting driver is the same as no patch has been
> queued in between.
>
> [3]. https://lore.kernel.org/linux-wireless/20200623110000.31559-1-ajay.kathat@microchip.com/

As discussed with Greg I created an immutable branch for this and merged
the branch to wireless-drivers-next:

5625f965d764 wilc1000: move wilc driver out of staging

Greg, here's the location of the immutable branch:

git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git wilc1000-move-out-of-staging

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
