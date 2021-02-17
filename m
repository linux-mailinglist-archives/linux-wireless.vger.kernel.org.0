Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBD931D70F
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Feb 2021 10:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhBQJjw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Feb 2021 04:39:52 -0500
Received: from z11.mailgun.us ([104.130.96.11]:19115 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhBQJjw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Feb 2021 04:39:52 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613554766; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=jUl5dkKVOyX/GS4SK+4hg3smk6Y58coDdPM1QG9SwG0=;
 b=pPn5mgHXJv18lEh0ATicFwZMXo8idsYU3UgNAV0lNNqqPMZ4gXBLjJiJIA7/1Gc7b2MGhi9r
 MYKWLTVQtc8GSxrz4lDFfXKYL+/Ly5FHan3x5V5cHJe6pEXHamdislirKFb2zcC2dLsttXNs
 xt3N8O8sHsHq1fOY2lyyzKKtXL8=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 602ce42b97484ee2ac2d29f8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 17 Feb 2021 09:38:51
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CCC2DC43461; Wed, 17 Feb 2021 09:38:50 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 17E1CC433CA;
        Wed, 17 Feb 2021 09:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 17E1CC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/11] ath11k: Refactor ath11k_msi_config
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1612946530-28504-2-git-send-email-akolli@codeaurora.org>
References: <1612946530-28504-2-git-send-email-akolli@codeaurora.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210217093850.CCC2DC43461@smtp.codeaurora.org>
Date:   Wed, 17 Feb 2021 09:38:50 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anilkumar Kolli <akolli@codeaurora.org> wrote:

> Move ath11k_msi_config to array of structures to add multiple
> pci devices support. No functional changes.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1.r2-00012-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

11 patches applied to ath-next branch of ath.git, thanks.

7a3aed0c3c36 ath11k: Refactor ath11k_msi_config
16001e4b2e68 ath11k: Move qmi service_ins_id to hw_params
fa5f473d7643 ath11k: qmi: increase the number of fw segments
5f67d306155e ath11k: Update memory segment count for qcn9074
a233811ef600 ath11k: Add qcn9074 mhi controller config
480a73610c95 ath11k: add static window support for register access
6fe6f68fef7f ath11k: add hal support for QCN9074
e678fbd401b9 ath11k: add data path support for QCN9074
6289ac2b7182 ath11k: add CE interrupt support for QCN9074
7dc67af063e3 ath11k: add extended interrupt support for QCN9074
4e80946197a8 ath11k: add qcn9074 pci device support

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1612946530-28504-2-git-send-email-akolli@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

