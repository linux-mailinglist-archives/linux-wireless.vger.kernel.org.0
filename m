Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52CFB2724EE
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Sep 2020 15:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbgIUNM3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Sep 2020 09:12:29 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:35905 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727376AbgIUNMZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Sep 2020 09:12:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600693944; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=cmnKU9pmuAqRnqLmlEpHwADF5pbQ5idf6SvJpsOHm1c=;
 b=fVHIF6MBcT8OpCpB4OIrEg76IA47fSfRVvFkp9xboeEBshz09Kpb/cTauHStT6Isn+XMml4S
 M4Lcrv4vmqOC1XFqZAmf+72KbWeyNF91BulpycWUalacRUr8uPIkwixbllu1rvDeiLlsuzVg
 WHqY0dNGz+IOjSdrDEj0INR0Qig=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f68a6a64ab73023a7c83f6b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 21 Sep 2020 13:12:06
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A14D1C43395; Mon, 21 Sep 2020 13:12:06 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 85943C43385;
        Mon, 21 Sep 2020 13:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 85943C43385
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Remove rproc references from common core layer
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1600090615-18904-1-git-send-email-govinds@codeaurora.org>
References: <1600090615-18904-1-git-send-email-govinds@codeaurora.org>
To:     Govind Singh <govinds@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200921131206.A14D1C43395@smtp.codeaurora.org>
Date:   Mon, 21 Sep 2020 13:12:06 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Govind Singh <govinds@codeaurora.org> wrote:

> IPQ8074 HW uses rproc with AHB as underlying hif layer.
> Move rproc references from common core layer to target
> hif layer. Remove IS_ENABLED check for CONFIG_REMOTEPROC
> as it's not required anymore.
> 
> No functional changes. Compile tested only.
> 
> Signed-off-by: Govind Singh <govinds@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

ba929d6fe31a ath11k: Remove rproc references from common core layer

-- 
https://patchwork.kernel.org/patch/11773797/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

