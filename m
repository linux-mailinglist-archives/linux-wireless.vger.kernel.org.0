Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47401F176C
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2020 13:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbgFHLS2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Jun 2020 07:18:28 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:35705 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729528AbgFHLS2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Jun 2020 07:18:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591615107; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=TKC0V/VIkd6m4e9NYPzBYE0dnQfWwnrnE4QzekjDAFc=;
 b=G/3UZs6Ob+EtnIXTAmn6hm9CLG29rvip+z0wlVoYE4X+wPYrVTc5YhrdH5WkCJpzJ/ixVK4Q
 Zg/jiQMhPig5d0sDvFJZZy86LywYc9g4gv0hSUpNwh03mOi2ix7VY61XYy5+dQ8hmfvZOoBt
 C1K4LwOZMAI9iUABnzpnQfLdJg4=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5ede1e709545e9541f5af4b4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 08 Jun 2020 11:18:08
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7970DC433CA; Mon,  8 Jun 2020 11:18:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 40286C433C6;
        Mon,  8 Jun 2020 11:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 40286C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: Move msa region map/unmap to init/deinit path
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1591191231-31917-1-git-send-email-govinds@codeaurora.org>
References: <1591191231-31917-1-git-send-email-govinds@codeaurora.org>
To:     Govind Singh <govinds@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200608111808.7970DC433CA@smtp.codeaurora.org>
Date:   Mon,  8 Jun 2020 11:18:08 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Govind Singh <govinds@codeaurora.org> wrote:

> With kernel qrtr switch from user space qrtr, fw crash is seen
> during reboot. During reboot modem rproc shutdown causes wlan qmi
> service exit and msa region gets unmapped. Since pdev is not suspended
> hw still accessing the msa region and this results in  fw crash as
> msa region is unmapped.
> 
> Decouple msa mapping from wlan qmi server arrive/exit to init/deinit
> path.
> 
> Testing is pending with "0c2204a4ad71 net: qrtr: Migrate nameservice
> to kernel from userspace", only regression sanity performed with user space
> qrtr on QCS404/SC7180.
> 
> Fixes: 0c2204a4ad71 net: qrtr: Migrate nameservice to kernel from userspace
> Signed-off-by: Govind Singh <govinds@codeaurora.org>

Dropped as requested

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/11585699/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

