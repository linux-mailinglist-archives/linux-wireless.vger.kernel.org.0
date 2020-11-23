Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A005D2C12E4
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Nov 2020 19:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388730AbgKWSGQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Nov 2020 13:06:16 -0500
Received: from z5.mailgun.us ([104.130.96.5]:36954 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730318AbgKWSGQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Nov 2020 13:06:16 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606154775; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=QsC3NpM/du25lzbH05z2akZjR3GfALtU00tCNrq06JM=;
 b=FoyvBaKHKEOnyNCX7iQYwsoKZPpHhhOWV3IGJKna+SY2hFDfICgUDRLn6EGvl4JpAmFgHPWU
 eGr7Me2NFO7gdsx3pQD0abJ+Z4hS8XbdAIew2r8L7oZXOp3B2eMTYxNcodlQfKRTo8GaJ9F6
 0qJaTcYmSiUXb1bNV8u+/hzMHPE=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5fbbfa177f0cfa6a16c9a523 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 23 Nov 2020 18:06:15
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C8F47C43461; Mon, 23 Nov 2020 18:06:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 76447C433C6;
        Mon, 23 Nov 2020 18:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 76447C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] ath11k: add processor_id based ring_selector logic
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1604914915-12831-1-git-send-email-ppranees@codeaurora.org>
References: <1604914915-12831-1-git-send-email-ppranees@codeaurora.org>
To:     P Praneesh <ppranees@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        P Praneesh <ppranees@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201123180614.C8F47C43461@smtp.codeaurora.org>
Date:   Mon, 23 Nov 2020 18:06:14 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

P Praneesh <ppranees@codeaurora.org> wrote:

> Current ring selector logic follows round-robin scheduling,
> when a process switch from one processor to another each time,
> the data in the cache would have to be invalidated
> and re-loaded from RAM leads to poor cache utilization.
> 
> Therefore smp_processor_id() attempt to keep processes
> on the same processor via processor affinity which improves
> cache utilization. Also, ring selection could be chosen round
> robin when the processor_id based ring selection does not
> have the resources.
> 
> Tested-on : IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00874-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: P Praneesh <ppranees@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

0eaa4c1d34c5 ath11k: add processor_id based ring_selector logic

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1604914915-12831-1-git-send-email-ppranees@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

