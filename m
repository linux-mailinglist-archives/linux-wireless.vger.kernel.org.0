Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4ACC43822A
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Oct 2021 09:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhJWHOJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Oct 2021 03:14:09 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:23777 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhJWHOJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Oct 2021 03:14:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634973110; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=Swlovz/lXSjdBIjRavIDTbDKMXM0ToW3nYw/J3WqSbs=; b=NzSEdW2Ndt389iPuGmBdySdap2pBIbgRiUMDVvMptahqrNeDErrIZ3v82A4HccyagusnWin6
 U4jBp10f+ZyVmOB2cff4o2WnZLsogfdJjnYSknNsXCCYuChIskktVUV7rsge5JhoEkt56v5L
 u/74j7oTJKf/L6+sPz46vKAENIM=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 6173b5a5fd91319f0ffeb8a1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 23 Oct 2021 07:11:33
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AA660C4360D; Sat, 23 Oct 2021 07:11:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 83709C4338F;
        Sat, 23 Oct 2021 07:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 83709C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, rdunlap@infradead.org,
        sean.wang@mediatek.com
Subject: Re: [PATCH] mt76: mt7921: fix mt7921s Kconfig
References: <1ce6cb04ba1ab5aabd2b06b45fd8266537ef5359.1634893214.git.lorenzo@kernel.org>
Date:   Sat, 23 Oct 2021 10:11:28 +0300
In-Reply-To: <1ce6cb04ba1ab5aabd2b06b45fd8266537ef5359.1634893214.git.lorenzo@kernel.org>
        (Lorenzo Bianconi's message of "Fri, 22 Oct 2021 11:02:31 +0200")
Message-ID: <87tuh8dxlr.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Add missing MMC dependency in mt7921s Kconfig
>
> Fixes: 48fab5bbef409 ("mt76: mt7921: introduce mt7921s support")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

I had missed this before I submitted the pull request to net-next :(

Felix, I'll take this directly to wireless-drivers-next so that I can
submit the fix to net-next ASAP. Please drop it from your tree.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
