Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F333E1A73BB
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2020 08:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406039AbgDNGc1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Apr 2020 02:32:27 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:12793 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405991AbgDNGc0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Apr 2020 02:32:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586845946; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=ob+tAqQqPFUftyV/IRMjatbp23VWl19cMrBGgD5tvHo=; b=AcYWv/sTVnSdKAJ/sGADJNnua7Gvm6vnfhEIB+qyJ3vLlmzlcinZvzsF11mvKJo+usD7WDpy
 dk2qhF7sc/UhNF92RFidyAvM9ia9lvMokfIbwGnmGkpKHRsyuiyyC5CyTsluXqtj+mvNIPiK
 KDYIAhkPkSLdyGono5hpoSOr3cw=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9558e7.7f2324189810-smtp-out-n04;
 Tue, 14 Apr 2020 06:32:07 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 563A9C433BA; Tue, 14 Apr 2020 06:32:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E60EAC433CB;
        Tue, 14 Apr 2020 06:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E60EAC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 2/2] mt76: mt7615: introduce mt7663u support
References: <cover.1586451954.git.lorenzo@kernel.org>
        <464261d4bc9d28c220cc2bc13244f99709949359.1586451954.git.lorenzo@kernel.org>
Date:   Tue, 14 Apr 2020 09:32:01 +0300
In-Reply-To: <464261d4bc9d28c220cc2bc13244f99709949359.1586451954.git.lorenzo@kernel.org>
        (Lorenzo Bianconi's message of "Thu, 9 Apr 2020 19:09:42 +0200")
Message-ID: <87zhbelgri.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Introduce support for mt7663u 802.11ac 2x2:2 chipset to mt7615 driver.
> Main difference respect to pcie code base is the usb code needs to
> configure wtbl from non-atomic context
>
> Co-developed-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

[...]

> --- /dev/null
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
> @@ -0,0 +1,396 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2019 MediaTek Inc.

mt76 is ISC, why are you using GPL? I would like to avoid using
different licenses in the same driver.

While invistigating more I noticed other files using GPL:

Kconfig:# SPDX-License-Identifier: GPL-2.0-only
Makefile:# SPDX-License-Identifier: GPL-2.0-only
mt7603/Kconfig:# SPDX-License-Identifier: GPL-2.0-only
mt7603/Makefile:# SPDX-License-Identifier: GPL-2.0-only
mt7615/Kconfig:# SPDX-License-Identifier: GPL-2.0-only
mt76x0/Kconfig:# SPDX-License-Identifier: GPL-2.0-only
mt76x0/Makefile:# SPDX-License-Identifier: GPL-2.0-only
mt76x0/eeprom.c:// SPDX-License-Identifier: GPL-2.0-only
mt76x0/eeprom.h:/* SPDX-License-Identifier: GPL-2.0-only */
mt76x0/init.c:// SPDX-License-Identifier: GPL-2.0-only
mt76x0/initvals.h:/* SPDX-License-Identifier: GPL-2.0-only */
mt76x0/initvals_phy.h:/* SPDX-License-Identifier: GPL-2.0-only */
mt76x0/main.c:// SPDX-License-Identifier: GPL-2.0-only
mt76x0/mcu.h:/* SPDX-License-Identifier: GPL-2.0-only */
mt76x0/mt76x0.h:/* SPDX-License-Identifier: GPL-2.0-only */
mt76x0/phy.c:// SPDX-License-Identifier: GPL-2.0-only
mt76x0/phy.h:/* SPDX-License-Identifier: GPL-2.0-only */
mt76x0/usb.c:// SPDX-License-Identifier: GPL-2.0-only
mt76x2/Kconfig:# SPDX-License-Identifier: GPL-2.0-only
mt76x2/Makefile:# SPDX-License-Identifier: GPL-2.0-only
util.h:/* SPDX-License-Identifier: GPL-2.0-only */

Is there a reason for this? Can this be fixed?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
