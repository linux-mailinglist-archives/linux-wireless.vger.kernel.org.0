Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54B045CA9A
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Nov 2021 18:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242332AbhKXRJm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Nov 2021 12:09:42 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:50275 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242518AbhKXRJh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Nov 2021 12:09:37 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637773586; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=9AIBPHdpZnDFqk5hYjgPbB3hrnfSSYgKlUUZpZpTGwQ=;
 b=MI1OloshXf6PZ0qJ8kszOUPjTib3HOhDabS37bvk45ovUGYSE5ziF/8/a3kUKx4CiOwKsqAX
 OH2wIREq0OHbQr8ZtQ0mtYTsoReqsWXuZLcc3r1ET18NRrAKhRGYi7oAzS4mv47zFUTjxWeH
 At3jB77WmFZC9OVTplba6m7sANI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 619e7111bebfa3d4d5946f17 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 24 Nov 2021 17:06:25
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 989B5C4360D; Wed, 24 Nov 2021 17:06:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1D6D7C4338F;
        Wed, 24 Nov 2021 17:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 1D6D7C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Revert "ath11k: add read variant from SMBIOS for download
 board data"
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211124094316.9096-1-kvalo@codeaurora.org>
References: <20211124094316.9096-1-kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163777357973.11557.3669643271854630297.kvalo@codeaurora.org>
Date:   Wed, 24 Nov 2021 17:06:25 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> wrote:

> This reverts commit 46e46db313a2bf3c48cac4eb8bdb613b762f301b. Mark reported
> that it breaks QCA6390 hw2.0 on Dell XPS 13 9310:
> 
> [    5.537034] ath11k_pci 0000:72:00.0: chip_id 0x0 chip_family 0xb board_id 0xff soc_id 0xffffffff
> [    5.537038] ath11k_pci 0000:72:00.0: fw_version 0x101c06cc fw_build_timestamp 2020-06-24 19:50 fw_build_id
> [    5.537236] ath11k_pci 0000:72:00.0: failed to fetch board data for bus=pci,qmi-chip-id=0,qmi-board-id=255,variant=DE_1901 from ath11k/QCA6390/hw2.0/board-2.bin
> [    5.537255] ath11k_pci 0000:72:00.0: failed to fetch board-2.bin or board.bin from QCA6390/hw2.0
> [    5.537257] ath11k_pci 0000:72:00.0: qmi failed to fetch board file: -2
> [    5.537258] ath11k_pci 0000:72:00.0: failed to load board data file: -2
> 
> So we need to back to the drawing board and implement it so that backwards
> compatiblity is not broken.
> 
> Reported-by: Mark Herbert <mark.herbert42@gmail.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

72f412434772 Revert "ath11k: add read variant from SMBIOS for download board data"

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211124094316.9096-1-kvalo@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

