Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C762744E2C2
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Nov 2021 09:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbhKLIEz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Nov 2021 03:04:55 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:38054 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230464AbhKLIEy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Nov 2021 03:04:54 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636704124; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=7xz5juRc++U5jOSGEHBg//LXfIOPsTHeDZw9ypeO++8=;
 b=cDN3ia9+MOmDl3aQSv5WQRyFZE1xAM/sgaBWi4pqxop9LOF0Fdr6G9Tz0oIGqkjIhESoAels
 nylV+DsFyY1vRjR7wT8F88Z7NHe0Ek+fsCTODOzYsIwWvMIb50yRgh7mFt7qlKT/Az0pQLlP
 zcvi8Vkd3euE7u6rv78oaDRq5Lk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 618e1f76d8b69943a35771c3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 12 Nov 2021 08:01:58
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1643BC4360C; Fri, 12 Nov 2021 08:01:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 64283C43460;
        Fri, 12 Nov 2021 08:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 64283C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Clear auth flag only for actual association in
 security mode
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1635177786-20854-1-git-send-email-quic_ramess@quicinc.com>
References: <1635177786-20854-1-git-send-email-quic_ramess@quicinc.com>
To:     Rameshkumar Sundaram <quic_ramess@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        Lavanya Suresh <lavaks@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163670411421.15262.14071753785667937503.kvalo@codeaurora.org>
Date:   Fri, 12 Nov 2021 08:01:58 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rameshkumar Sundaram <quic_ramess@quicinc.com> wrote:

> AUTH flag is needed when peer assoc command is sent from host in
> security mode for non-assoc cases. Firmware will handle AUTH flag
> when client is associating as AUTH flag will be set after key exchange.
> For internally provided peer assoc commands from host, there won't be
> any key exchange, so AUTH flag is expected to be set in host.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01838-QCAHKSWPL_SILICONZ-1
> 
> Co-developed-by: Lavanya Suresh <lavaks@codeaurora.org>
> Signed-off-by: Lavanya Suresh <lavaks@codeaurora.org>
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

c802b6d7815d ath11k: Clear auth flag only for actual association in security mode

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1635177786-20854-1-git-send-email-quic_ramess@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

