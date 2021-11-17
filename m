Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE834541D2
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Nov 2021 08:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbhKQHao (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Nov 2021 02:30:44 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:28239 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbhKQHal (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Nov 2021 02:30:41 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637134063; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=hwDc6VXQecDCbbtqjpFiE+B2bvoB30ymVBFSC5L5fPk=;
 b=JghwdC5rSa+1YEaibSek3HLxER2ZYw9Z4maLI5XFKa0FtFjnEFAPF3kc6IQdzZ0kF8N2llvJ
 P9nU0swJSOHP4oJUeg+KHOYJ5sexgG2QFHpIVFr9JX8wQIIh41SJBe6tliSQ7d/luk1IYVWb
 5h9XB0PJdpTGDX2x5Ek83Tn5QHw=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 6194aeea665450d43aecc2ea (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 17 Nov 2021 07:27:38
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B672CC43618; Wed, 17 Nov 2021 07:27:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 95CB3C43460;
        Wed, 17 Nov 2021 07:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 95CB3C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Fix ETSI regd with weather radar overlap
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211112153116.1214421-1-sven@narfation.org>
References: <20211112153116.1214421-1-sven@narfation.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Sven Eckelmann <sven@narfation.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163713405345.31320.10844437499755849817.kvalo@codeaurora.org>
Date:   Wed, 17 Nov 2021 07:27:37 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sven Eckelmann <sven@narfation.org> wrote:

> Some ETSI countries have a small overlap in the wireless-regdb with an ETSI
> channel (5590-5650). A good example is Australia:
> 
>   country AU: DFS-ETSI
>         (2400 - 2483.5 @ 40), (36)
>         (5150 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW
>         (5250 - 5350 @ 80), (20), NO-OUTDOOR, AUTO-BW, DFS
>         (5470 - 5600 @ 80), (27), DFS
>         (5650 - 5730 @ 80), (27), DFS
>         (5730 - 5850 @ 80), (36)
>         (57000 - 66000 @ 2160), (43), NO-OUTDOOR
> 
> If the firmware (or the BDF) is shipped with these rules then there is only
> a 10 MHz overlap with the weather radar:
> 
> * below: 5470 - 5590
> * weather radar: 5590 - 5600
> * above: (none for the rule "5470 - 5600 @ 80")
> 
> There are several wrong assumption in the ath11k code:
> 
> * there is always a valid range below the weather radar
>   (actually: there could be no range below the weather radar range OR range
>    could be smaller than 20 MHz)
> * intersected range in the weather radar range is valid
>   (actually: the range could be smaller than 20 MHz)
> * range above weather radar is either empty or valid
>   (actually: the range could be smaller than 20 MHz)
> 
> These wrong assumption will lead in this example to a rule
> 
>   (5590 - 5600 @ 20), (N/A, 27), (600000 ms), DFS, AUTO-BW
> 
> which is invalid according to is_valid_reg_rule() because the freq_diff is
> only 10 MHz but the max_bandwidth is set to 20 MHz. Which results in a
> rejection like:
> 
>   WARNING: at backports-20210222_001-4.4.60-b157d2276/net/wireless/reg.c:3984
>   [...]
>   Call trace:
>   [<ffffffbffc3d2e50>] reg_get_max_bandwidth+0x300/0x3a8 [cfg80211]
>   [<ffffffbffc3d3d0c>] regulatory_set_wiphy_regd_sync+0x3c/0x98 [cfg80211]
>   [<ffffffbffc651598>] ath11k_regd_update+0x1a8/0x210 [ath11k]
>   [<ffffffbffc652108>] ath11k_regd_update_work+0x18/0x20 [ath11k]
>   [<ffffffc0000a93e0>] process_one_work+0x1f8/0x340
>   [<ffffffc0000a9784>] worker_thread+0x25c/0x448
>   [<ffffffc0000aedc8>] kthread+0xd0/0xd8
>   [<ffffffc000085550>] ret_from_fork+0x10/0x40
>   ath11k c000000.wifi: failed to perform regd update : -22
>   Invalid regulatory domain detected
> 
> To avoid this, the algorithm has to be changed slightly. Instead of
> splitting a rule which overlaps with the weather radar range into 3 pieces
> and accepting the first two parts blindly, it must actually be checked for
> each piece whether it is a valid range. And only if it is valid, add it to
> the output array.
> 
> When these checks are in place, the processed rules for AU would end up as
> 
>   country AU: DFS-ETSI
>           (2400 - 2483 @ 40), (N/A, 36), (N/A)
>           (5150 - 5250 @ 80), (6, 23), (N/A), NO-OUTDOOR, AUTO-BW
>           (5250 - 5350 @ 80), (6, 20), (0 ms), NO-OUTDOOR, DFS, AUTO-BW
>           (5470 - 5590 @ 80), (6, 27), (0 ms), DFS, AUTO-BW
>           (5650 - 5730 @ 80), (6, 27), (0 ms), DFS, AUTO-BW
>           (5730 - 5850 @ 80), (6, 36), (N/A), AUTO-BW
> 
> and will be accepted by the wireless regulatory code.
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

086c921a3540 ath11k: Fix ETSI regd with weather radar overlap

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211112153116.1214421-1-sven@narfation.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

