Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C5930267E
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Jan 2021 15:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbhAYOre (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Jan 2021 09:47:34 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:64227 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729740AbhAYOoc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jan 2021 09:44:32 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611585849; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=4T7ERctewZCW8kd5OrD8b3ZUYuyf5FjbU9FL4ui5tsQ=;
 b=cKB5bFAymK7KttLvVhikxpSJup+g4zzpw3GoJlHT9m1vhk1DIPhEthterv6CGNkk1f1tknbI
 VCfq6YB+KtwfokI0HeDUMcnp+GdAOy3/wAAEonUmZYc1kgRDGsxiOvKgL8vbIAv1HwTcCYLF
 cCQVTGqvQKWKjemB1CtFctbJjsM=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 600ed931bdcf4682878ed727 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 25 Jan 2021 14:44:01
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 49273C43461; Mon, 25 Jan 2021 14:44:00 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AA44DC433CA;
        Mon, 25 Jan 2021 14:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AA44DC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] iwl4965: do not process non-QOS frames on
 txq->sched_retry
 path
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210119100621.439134-1-stf_xl@wp.pl>
References: <20210119100621.439134-1-stf_xl@wp.pl>
To:     stf_xl@wp.pl
Cc:     linux-wireless@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210125144400.49273C43461@smtp.codeaurora.org>
Date:   Mon, 25 Jan 2021 14:44:00 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

stf_xl@wp.pl wrote:

> From: Stanislaw Gruszka <stf_xl@wp.pl>
> 
> We have already WARN_ON(!qc) for non-QOS frame on txq->sched_retry path,
> but we continue to process, what makes no sense since tid is not
> initialized. Non QOS frame should never happen when aggregation
> is enabled on queue, so do not process that.
> 
> Patch should fix smatch warning:
> drivers/net/wireless/intel/iwlegacy/4965-mac.c:2822 il4965_hdl_tx() error: uninitialized symbol 'tid'.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>

Patch applied to wireless-drivers-next.git, thanks.

4832bb371c41 iwl4965: do not process non-QOS frames on txq->sched_retry path

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210119100621.439134-1-stf_xl@wp.pl/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

