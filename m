Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88879159003
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2020 14:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgBKNei (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Feb 2020 08:34:38 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:39650 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729120AbgBKNeh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Feb 2020 08:34:37 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581428076; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=DCm1dmFf/tnARUKiqpFNAp0JunUgKPiMRXdckXqP5Yw=; b=GGHbyggmzkC/MaF2XJPoSL6XlGM/SGDZWcgtphjJIk4gK+r3Qilfnq9fMwlcFIUOC31Vla1w
 UzPgeO4jU4T16RVGuoP55bVSJFU9lZ8BFI9KUL00sUqQ6Gw4tWS2TYHQMraBXO+Rh8qlMBWV
 fWDHihOZJfGwGVKe0C3cPkMf6KM=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e42ad66.7ff552f82490-smtp-out-n01;
 Tue, 11 Feb 2020 13:34:30 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EA72CC447A2; Tue, 11 Feb 2020 13:34:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4946AC447A0;
        Tue, 11 Feb 2020 13:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4946AC447A0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] ath11k: add thermal cooling device support
References: <1580860830-12696-1-git-send-email-pradeepc@codeaurora.org>
Date:   Tue, 11 Feb 2020 15:34:25 +0200
In-Reply-To: <1580860830-12696-1-git-send-email-pradeepc@codeaurora.org>
        (Pradeep Kumar Chitrapu's message of "Wed, 5 Feb 2020 05:30:29 +0530")
Message-ID: <874kvxxn6m.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pradeep Kumar Chitrapu <pradeepc@codeaurora.org> writes:

> Thermal cooling device support is added to control the temperature by
> throttling the data transmission for the given duration. Throttling is
> done by suspending all data tx queues by given percentage of time. The
> thermal device allows user to configure duty cycle.
>
> Throttling can be disabled by setting the duty cycle to 0. The cooling
> device can be found under /sys/class/thermal/cooling_deviceX/.
> Corresponding soft link to this device can be found under phy folder.
>
> /sys/class/ieee80211/phy*/device/cooling_device.
>
> To set duty cycle as 40%,
>
> echo 40 >/sys/class/ieee80211/phy*/device/cooling_device/cur_state
>
> Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>

[...]

> +++ b/drivers/net/wireless/ath/ath11k/thermal.h
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: BSD-3-Clause-Clear

This had a warning:

drivers/net/wireless/ath/ath11k/thermal.h:1: Improper SPDX comment style for 'drivers/net/wireless/ath/ath11k/thermal.h', please use '/*' instead
drivers/net/wireless/ath/ath11k/thermal.h:1: Missing or malformed SPDX-License-Identifier tag in line 1

I fixed that in the pending branch.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
