Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680E0332390
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Mar 2021 12:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhCILDG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Mar 2021 06:03:06 -0500
Received: from z11.mailgun.us ([104.130.96.11]:46352 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229689AbhCILDC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Mar 2021 06:03:02 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615287782; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=IGZc1gOCO6ryrX2y2Ulh5Hjc13TCZJDZVJpHST0oSik=;
 b=VoAGQj0Y8Hy3ztCA6Z21B09CGgVDJetTmLcIiXSPMkDZ5PCTu5QChgrpnCe9OdlKqp6HDRPc
 UWV9fpxuNZtJ2ZzJS0jP8bCIktLCrdtWLOCmI+toO0At7zxvNIKGZlpgJoXxlSN9JBoiZcfm
 bMEq88bu3eTzs2njeEWBnzA9a8Y=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 604755dffcddd4bda636578b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Mar 2021 11:02:55
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5D744C433C6; Tue,  9 Mar 2021 11:02:54 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D078FC433C6;
        Tue,  9 Mar 2021 11:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D078FC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Add support for STA to handle beacon miss
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1614340859-28867-1-git-send-email-lavaks@codeaurora.org>
References: <1614340859-28867-1-git-send-email-lavaks@codeaurora.org>
To:     Lavanya Suresh <lavaks@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Lavanya Suresh <lavaks@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210309110254.5D744C433C6@smtp.codeaurora.org>
Date:   Tue,  9 Mar 2021 11:02:54 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lavanya Suresh <lavaks@codeaurora.org> wrote:

> When AP goes down without any indication to STA, firmware detects
> missing beacon, and sends wmi roam event with reason BEACON_MISS
> to the host.
> 
> Added support for STA mode to trigger disassociation from AP,
> on receiving this event from firmware.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01717-QCAHKSWPL_SILICONZ-1
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> 
> Signed-off-by: Lavanya Suresh <lavaks@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

26f697923729 ath11k: Add support for STA to handle beacon miss

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1614340859-28867-1-git-send-email-lavaks@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

