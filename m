Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E12345B01
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Mar 2021 10:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhCWJhL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Mar 2021 05:37:11 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:28444 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhCWJg4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Mar 2021 05:36:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1616492216; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=dCdviXRjazHmRpoHm/NuapDWhm6l+3gwwKSyHdiffnE=;
 b=QyLPst4G8igsiSd6Ye6be9+DFbX+EriDlyjJGBDyoOtlVxUd13bmrtWUQTR69LMom+Ke2gmW
 2nksnSATdkgehCHZx6ec15JnDfN4UvQvzzfsHHdljC/laJywNrT4PVzqFpHgVaPWFOwCQ84x
 nfm1UhiecrYbFjV1qD/4JszA6Po=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 6059b69fc32ceb3a91c03b6f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Mar 2021 09:36:31
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 333FBC433ED; Tue, 23 Mar 2021 09:36:31 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F10EDC433CA;
        Tue, 23 Mar 2021 09:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F10EDC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless-drivers] mt76: mt7921: fix airtime reporting
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <c05333be0e3e85a50a71bb2de81034fe425e3701.1615284335.git.lorenzo@kernel.org>
References: <c05333be0e3e85a50a71bb2de81034fe425e3701.1615284335.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        nbd@nbd.name, sean.wang@mediatek.com, leon.yen@mediatek.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210323093631.333FBC433ED@smtp.codeaurora.org>
Date:   Tue, 23 Mar 2021 09:36:31 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Fix {tx,rx}_airtime reporting for mt7921 driver. Wrong register definitions
> trigger a tx hangs before resetting airtime stats.
> 
> Fixes: 163f4d22c118d ("mt76: mt7921: add MAC support")
> Tested-by: Leon Yen <leon.yen@mediatek.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Acked-by: Felix Fietkau <nbd@nbd.name>

Patch applied to wireless-drivers.git, thanks.

8f6a70fd71a3 mt76: mt7921: fix airtime reporting

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/c05333be0e3e85a50a71bb2de81034fe425e3701.1615284335.git.lorenzo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

