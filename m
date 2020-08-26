Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2279C2531AB
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Aug 2020 16:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgHZOoX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Aug 2020 10:44:23 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:63871 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726734AbgHZOoX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Aug 2020 10:44:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598453062; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=U/m4jJyjO54IDfksgY4gT/Ig37eP0pugC9C6u4Tuz0M=; b=N2ddSfTDrx3ypW0qBMqUhSgVs+F/PnfFX+npbgycSyZ/jGmJJNN83ExBjygmLUG0jswJtVwr
 owXAmRwLqGhuIW8jFihTIROXF2B/HRlFewLZSwReTDLs16AIymHkwq2QpYzlBGsFSajgU9af
 b406LEEQaWyjNhgy/vABT2dIAuI=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f4675240f94f6538daf66e5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 26 Aug 2020 14:43:48
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 451C4C43387; Wed, 26 Aug 2020 14:43:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DDAC2C433CA;
        Wed, 26 Aug 2020 14:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DDAC2C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     "Rakesh Pillai" <pillair@codeaurora.org>
Cc:     "'Peter Oh'" <peter.oh@eero.com>,
        'Brian Norris' <briannorris@chromium.org>,
        'linux-wireless' <linux-wireless@vger.kernel.org>,
        'Doug Anderson' <dianders@chromium.org>,
        'ath10k' <ath10k@lists.infradead.org>,
        'LKML' <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ath10k: Add interrupt summary based CE processing
References: <1593193967-29897-1-git-send-email-pillair@codeaurora.org>
        <CAD=FV=V_ynwukeR92nbJXkuQ7OAW4mLaTjxko7fXt5aEfDUNhA@mail.gmail.com>
        <CAD=FV=XJDmGbEJQ1U-VDuN2p0+V+uRm_1=DwBnDPmPQsXqS4ZA@mail.gmail.com>
        <CA+ASDXNOCFZhdNMDk9XTuC2H+owQ0+wHipDbkJAGnU9q7BXz_w@mail.gmail.com>
        <871rlcx8uv.fsf@codeaurora.org>
        <CALhWmc1PbTKhrkaPn9yfpx3gZHAMuR-bPY=4_o4wQHv_H5D9dA@mail.gmail.com>
        <CALhWmc3i9Z+KiG1cJNvpSWNsiFhOa5jBw=XfcFz_gKwi_5QibA@mail.gmail.com>
        <CALhWmc1B0+SONV6_AF+nUzgxZdekPD3sZuhrsmwVQx1Q-cgT_g@mail.gmail.com>
        <CALhWmc0qF5stKRcikjwbeFmE-32hNCDazgQdqTMidUyt7u-T1Q@mail.gmail.com>
        <CALhWmc0JtQZE5CfLPb1WnwhE9wCYsjE-53kYWbwtFCs1k7FrCQ@mail.gmail.com>
        <CALhWmc11OefTh6Ov5GqP-yHMVTUO4r9CxqkdHT1F3yzor72v7g@mail.gmail.com>
        <000201d65f51$83d2ac60$8b780520$@codeaurora.org>
Date:   Wed, 26 Aug 2020 17:43:42 +0300
In-Reply-To: <000201d65f51$83d2ac60$8b780520$@codeaurora.org> (Rakesh Pillai's
        message of "Tue, 21 Jul 2020 16:54:30 +0530")
Message-ID: <877dtlcvs1.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(Guys, PLEASE edit your quotes. These long emails my use of patchwork
horrible.)

"Rakesh Pillai" <pillair@codeaurora.org> writes:

>> -----Original Message-----
>> From: Peter Oh <peter.oh@eero.com>
>> Sent: Tuesday, July 21, 2020 7:03 AM
>> To: Kalle Valo <kvalo@codeaurora.org>
>> Cc: Brian Norris <briannorris@chromium.org>; Doug Anderson
>> <dianders@chromium.org>; linux-wireless <linux-
>> wireless@vger.kernel.org>; Rakesh Pillai <pillair@codeaurora.org>; ath10k
>> <ath10k@lists.infradead.org>; LKML <linux-kernel@vger.kernel.org>
>> Subject: Re: [PATCH] ath10k: Add interrupt summary based CE processing
>> 
>> I'll take my word back.
>> It's not this patch problem, but by others.
>> I have 2 extra patches before the 3 patches so my system looks like
>> 
>> backports from ath.git 5.6-rc1 + linux kernel 4.4 (similar to OpenWrt)
>> On top of the working system, I cherry-picked these 5.
>> 
>> #1.
>> ath10k: Avoid override CE5 configuration for QCA99X0 chipsets
>> ath.git commit 521fc37be3d879561ca5ab42d64719cf94116af0
>> #2.
>> ath10k: Fix NULL pointer dereference in AHB device probe
>> wireless-drivers.git commit 1cfd3426ef989b83fa6176490a38777057e57f6c
>> #3.
>> ath10k: Add interrupt summary based CE processing
>> https://patchwork.kernel.org/patch/11628299/
>
> This patch is applicable only for snoc target WCN3990, since there is
> a check for per_ce_irq. For PCI targets, per_ce_irq is false, and
> hence follows a different path.

This information should be in the commit log. But I have a patch in the
pending branch which removes per_ce_irq:

[v2,2/2] ath10k: Get rid of "per_ce_irq" hw param

https://patchwork.kernel.org/patch/11654621/

So how will multilple hardware support work then?

In theory I like the patch but there's no information in the patch if
this works or breaks other hardware, especially QCA9884 or QCA6174 PCI
devices. I really need some kind of assurance that this works with all
ath10k devices, not just WCN3990 which you are working on.

I have written about this in the wiki:

https://wireless.wiki.kernel.org/en/users/drivers/ath10k/submittingpatches#hardware_families

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
