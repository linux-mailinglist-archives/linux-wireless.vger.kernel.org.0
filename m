Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3341A73CA
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2020 08:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406068AbgDNGh7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Apr 2020 02:37:59 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:15563 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728133AbgDNGh6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Apr 2020 02:37:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586846278; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=o0Gyh/mmXnEx8d7nkWvk3UTOpVw4EYc81wUWo5sTSfc=; b=F3i87vmXcKeKjZIz868ZfXDqRsYbxCop4Li236pC86NoAMWEjFyrUVO8Wt/D7oLCtZ2w0fjg
 1EG0bxZcwOvaAfNXd8bhVB9jEHS3dCP0jZyca0zYFwKG3jDjMh8uHcpa4/ooWesPOC2I10sG
 xih3xMzZI4YgsSzn0aeG1SnO6VA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e955a3b.7f02ffa0b570-smtp-out-n02;
 Tue, 14 Apr 2020 06:37:47 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 930E5C433CB; Tue, 14 Apr 2020 06:37:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2AE91C433F2;
        Tue, 14 Apr 2020 06:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2AE91C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Chih-Min Chen <chih-min.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 06/16] mt76: add mac80211 driver for MT7915 PCIe-based chipsets
References: <cover.1586507878.git.ryder.lee@mediatek.com>
        <3d9a74111aaadde7be00ec7c8c53d095daf4f9d2.1586507878.git.ryder.lee@mediatek.com>
Date:   Tue, 14 Apr 2020 09:37:42 +0300
In-Reply-To: <3d9a74111aaadde7be00ec7c8c53d095daf4f9d2.1586507878.git.ryder.lee@mediatek.com>
        (Ryder Lee's message of "Fri, 10 Apr 2020 16:54:43 +0800")
Message-ID: <87mu7elgi1.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ryder Lee <ryder.lee@mediatek.com> writes:

> Add support for the MediaTek latest generation IEEE 802.11ax 4x4
> device MT7915E, which supports concurrent dual-band operation at
> both 5GHz and 2.4GHz.
>
> Note that this patch just add basic part and will add more HE
> capabilities support in the further patches.
>
> The driver supports AP, Station, Mesh and monitor mode.
>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> Signed-off-by: Chih-Min Chen <chih-min.chen@mediatek.com>
> Tested-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
> Acked-by: Yiwei Chung <yiwei.chung@mediatek.com>
> Acked-by: YF Luo <yf.luo@mediatek.com>

[...]

> --- /dev/null
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/Kconfig
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0-only

Same as in my earlier comment today: mt76 is ISC, why are you using GPL?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
