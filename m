Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F262D2392
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Dec 2020 07:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgLHGYa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Dec 2020 01:24:30 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:43377 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgLHGYa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Dec 2020 01:24:30 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607408646; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=MY5jl5iQhbaMKsCtcmqzUA41XPaUXL7dxhgq0JknUYg=; b=guX0oaoSFD7mPcL8FuUk9wxu653CG/8+8oNBwfxT4jJyvQ27H6u4eJeOUiFEnGxAS+oU5Gk6
 X5MUK/J2vf/mvcptOP+9J3y4zxrDl/SC+0KH81eXlUVWkPTG9ghDuj1YywLmRwf/OdfTLSF5
 VscF50Li4uLOyc/RYUcoRwkXfeI=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5fcf1bdcaac94550972c1b78 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 08 Dec 2020 06:23:24
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E2B20C43461; Tue,  8 Dec 2020 06:23:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 35094C433CA;
        Tue,  8 Dec 2020 06:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 35094C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Shayne Chen <shayne.chen@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] mt76: mt7915: fix "defined but not used" compiler warning
References: <20201203113210.16354-1-shayne.chen@mediatek.com>
Date:   Tue, 08 Dec 2020 08:23:16 +0200
In-Reply-To: <20201203113210.16354-1-shayne.chen@mediatek.com> (Shayne Chen's
        message of "Thu, 3 Dec 2020 19:32:10 +0800")
Message-ID: <87im9c4y0b.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Shayne Chen <shayne.chen@mediatek.com> writes:

> If CONFIG_NL80211_TESTMODE is not set, the following compiler warning
> appears:
>
> warning: 'mt7915_mac_tx_rate_val' defined but not used [-Wunused-function]
>
> Since mt7915_mac_tx_rate_val() is only used by
> mt7915_mac_write_txwi_tm(), merge them to get rid of this warning.
>
> Fixes: 3ac860a ("mt76: mt7915: implement testmode tx support")

Fixes line is wrong:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#fixes_line_is_incorrect

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
