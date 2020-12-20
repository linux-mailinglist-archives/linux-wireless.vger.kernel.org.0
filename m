Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62FB72DF55B
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Dec 2020 13:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgLTMQD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Dec 2020 07:16:03 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:23705 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgLTMQC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Dec 2020 07:16:02 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608466542; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=ucBVWkTy0hmL1N8oXUoYIXrS3gtZs4sukW42yuHiy7w=;
 b=Ft8uRyJamHD3kQCuIttyZXKKIEnSTvt7bCqPdhIr8aGI8A9abuLCH5AJ52fsnvcD8PkJChTZ
 hMwz0hPIOV4fpp7pV2ZF58aEeXqvjbX4gCCT+fkKBToqheRfizTUZcCxm0FHjA3UjEj+wlW8
 Cqf6gn3N/hs1JkGeRiCvPn7HSQE=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5fdf4052bfd08afb0de46193 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 20 Dec 2020 12:15:14
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9BB59C43463; Sun, 20 Dec 2020 12:15:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 217AFC433CA;
        Sun, 20 Dec 2020 12:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 217AFC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [-next] mt76: mt7915: fix MESH ifdef block
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201218173202.23159-1-rdunlap@infradead.org>
References: <20201218173202.23159-1-rdunlap@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201220121513.9BB59C43463@smtp.codeaurora.org>
Date:   Sun, 20 Dec 2020 12:15:13 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> wrote:

> Fix a build error when CONFIG_MAC80211_MESH is not enabled:
> 
> ../drivers/net/wireless/mediatek/mt76/mt7915/init.c:47:2: error: expected expression before '}' token
>   }, {
>   ^
> 
> Fixes: af901eb4ab80 ("mt76: mt7915: get rid of dbdc debugfs knob")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Shayne Chen <shayne.chen@mediatek.com>
> Cc: Ryder Lee <ryder.lee@mediatek.com>
> Cc: Lorenzo Bianconi <lorenzo@kernel.org>
> Cc: Felix Fietkau <nbd@nbd.name>
> Cc: linux-wireless@vger.kernel.org
> Cc: Kalle Valo <kvalo@codeaurora.org>

Patch applied to wireless-drivers.git, thanks.

0bd157fa2aaa mt76: mt7915: fix MESH ifdef block

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201218173202.23159-1-rdunlap@infradead.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

