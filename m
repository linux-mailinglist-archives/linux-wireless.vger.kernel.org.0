Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58E7381663
	for <lists+linux-wireless@lfdr.de>; Sat, 15 May 2021 08:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhEOGru (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 May 2021 02:47:50 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:33481 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231481AbhEOGrt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 May 2021 02:47:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621061197; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=kKIjxOOdAi/MzbkuceliiOCov4XBsWRGF6FBw7N3Kyk=;
 b=svlB72t3m1ISQKXlmYpP7iwskge711Ncc1/U/UETQ52gjaLkRVnEVR/KKF91clDxVRGGeN8T
 qffJgoGPStJP9l2rDwBIDKOnpqoDxpNNFQzBkpCYE7IR0eaWW3RSxNMhDplHh2tzurybJWg4
 p6QWBRwatDTGf+g2/CKQLfwVYhg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 609f6e49f752fca668851026 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 15 May 2021 06:46:33
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 35E53C4323A; Sat, 15 May 2021 06:46:33 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6DF42C433D3;
        Sat, 15 May 2021 06:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6DF42C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mt76: mt7615: do not set MT76_STATE_PM at bootstrap
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <3ff8e1901f38a943c4ca487a93d036ed368b46e1.1619543861.git.lorenzo@kernel.org>
References: <3ff8e1901f38a943c4ca487a93d036ed368b46e1.1619543861.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210515064633.35E53C4323A@smtp.codeaurora.org>
Date:   Sat, 15 May 2021 06:46:33 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Remove MT76_STATE_PM in mt7615_init_device() and introduce
> __mt7663s_mcu_drv_pmctrl for fw loading in mt7663s.
> This patch fixes a crash at bootstrap for device (e.g. mt7622) that do
> not support runtime-pm
> 
> Fixes: 129fac01ffe85 ("mt76: connac: introduce wake counter for fw_pmctrl synchronization")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Lorenzo, you wanted to have this to v5.13, right?

Fixes tag is wrong:

Git commit not found or invalid id: 129fac01ffe85

Please provide me the correct commit id and I can fix it during commit.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/3ff8e1901f38a943c4ca487a93d036ed368b46e1.1619543861.git.lorenzo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

