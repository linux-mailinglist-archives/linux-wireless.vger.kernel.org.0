Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC275124FE5
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 18:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfLRR4B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 12:56:01 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:40238 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727173AbfLRR4B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 12:56:01 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576691760; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=xhceGRhZWXnAhiZYFwilRLHUMIpy97+UQsvfiaP+f6c=;
 b=MEDoF6BEUDemA2sWshQxw9raW04nzKBgoVLSyDwxSwwoh9smbDL0qIBIIsB/1VAQTK8jpKyr
 4WAFzSys1Jc9G33FdHWOz/1B3927Q939sukCrjqbJiPlcAth1zwFQZf16NE1HM287HspcrX2
 ghusU7wLjwaCy7z+PCIeQK6DEyo=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfa682c.7f777efab998-smtp-out-n03;
 Wed, 18 Dec 2019 17:55:56 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7F45EC447A4; Wed, 18 Dec 2019 17:55:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5FF29C4479F;
        Wed, 18 Dec 2019 17:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5FF29C4479F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: checking for NULL vs IS_ERR()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191213105127.kijiazxwtghmubyk@kili.mountain>
References: <20191213105127.kijiazxwtghmubyk@kili.mountain>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Venkateswara Naralasetty <vnaralas@codeaurora.org>,
        Muna Sinada <msinada@codeaurora.org>,
        Shashidhar Lakkavalli <slakkavalli@datto.com>,
        Miles Hu <milehu@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191218175556.7F45EC447A4@smtp.codeaurora.org>
Date:   Wed, 18 Dec 2019 17:55:56 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The ath11k_ce_alloc_ring() function returns error pointers on error, not
> NULL.  The rest of the driver assumes that "pipe->src_ring" is either
> valid or NULL so this patch introduces a temporary varaible to avoid
> leaving it as an error pointer.
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

c76fa846b0e1 ath11k: checking for NULL vs IS_ERR()

-- 
https://patchwork.kernel.org/patch/11290421/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
