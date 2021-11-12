Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09CBC44E338
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Nov 2021 09:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbhKLIeZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Nov 2021 03:34:25 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:61609 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234766AbhKLIeR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Nov 2021 03:34:17 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636705887; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Bscd3c16R/hEOC7YJcDkDsPfos4+Hdbw1xj3IIDxf4k=;
 b=ktHcxQH2ad15ujLX6JW58Y8B6+baibgdTkPpHFln+vkbG8HpwidBlCql3+1o1QK/iZqlH1o8
 axgi8/EOGfflfxBDY1l4Lt7VNVIgYbI3A7pURK2o49sjE2XP3S3y8xjVUNXmJ5zlhZF0z96+
 hXWtO++ADMLqFC1lijWLx2chFxo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 618e265efacd20d795827198 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 12 Nov 2021 08:31:26
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D8041C43637; Fri, 12 Nov 2021 08:31:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D08ABC4314C;
        Fri, 12 Nov 2021 08:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org D08ABC4314C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 2/3] ath11k: Refactor update channel list function
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1634906227-22028-3-git-send-email-ppranees@codeaurora.org>
References: <1634906227-22028-3-git-send-email-ppranees@codeaurora.org>
To:     P Praneesh <ppranees@codeaurora.org>
Cc:     ath11k@lists.infradead.org, johannes@sipsolutions.net,
        linux-wireless@vger.kernel.org,
        P Praneesh <ppranees@codeaurora.org>,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163670587845.25141.12042890222760708077.kvalo@codeaurora.org>
Date:   Fri, 12 Nov 2021 08:31:25 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

P Praneesh <ppranees@codeaurora.org> wrote:

> For sending scan channel list command to firmware through wmi, remain on
> channel's scan request parameter needs to be updated. Add scan_req_params
> as an argument to the existing update_scan_chan_list to update scan request
> parameter through wmi. Also, rename regulatory update scan channel list to
> the ath11k_wmi_update_scan_chan_list since it is moved to wmi file.
> 
> Co-developed-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
> Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
> Signed-off-by: P Praneesh <ppranees@codeaurora.org>

Why is ath11k_reg_update_chan_list() moved to wmi.c? I couldn't figure
out what's the reason for that.

2 patches set to Changes Requested.

12577691 [v3,2/3] ath11k: Refactor update channel list function
12577693 [v3,2/3] ath11k: Add ROC support for wide band scan

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1634906227-22028-3-git-send-email-ppranees@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

