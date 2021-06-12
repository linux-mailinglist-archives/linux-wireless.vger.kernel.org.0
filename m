Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7193A4E31
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jun 2021 12:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhFLKdi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Jun 2021 06:33:38 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:56106 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229584AbhFLKdh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Jun 2021 06:33:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623493898; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=WYhAij5didyRMDoFtERoOpr07Z4/8PXzHPjXz3ajra8=;
 b=oX0j4i4e6Wb7bfjHH2vysf5KliewFVLdTmEbWIAnZ30dVrVcKCAWC5H0RDwhoNICjeffeciQ
 QjbIWWPXG88+njmc84UkYhqfMD7yFxGGkZUNBxk59h6uNP6gUBp8SEcFxNzF1X+VkByIO9MF
 LP2IL0f2PPPhKBZMx1/EbnRVigk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60c48d01b6ccaab75379a3ee (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 12 Jun 2021 10:31:29
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D83C1C43460; Sat, 12 Jun 2021 10:31:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E710DC433D3;
        Sat, 12 Jun 2021 10:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E710DC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/7] ath11k: add hw reg support for WCN6855
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210511162214.29475-2-jouni@codeaurora.org>
References: <20210511162214.29475-2-jouni@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Baochen Qiang <bqiang@codeaurora.org>,
        Govind Singh <govinds@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210612103128.D83C1C43460@smtp.codeaurora.org>
Date:   Sat, 12 Jun 2021 10:31:28 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> wrote:

> Reg address of WCN6855 is different from other devices,
> so add separate reg definition for this target.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Govind Singh <govinds@codeaurora.org>
> Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

7 patches applied to ath-next branch of ath.git, thanks.

755b1f73173e ath11k: add hw reg support for WCN6855
e4073430ee1d ath11k: add dp support for WCN6855
0d55b76fd815 ath11k: setup REO for WCN6855
ed66849e159b ath11k: setup WBM_IDLE_LINK ring once again
8845fed1ad7b ath11k: add support to get peer id for WCN6855
0fbf19570099 ath11k: add support for WCN6855
5088df0504fe ath11k: don't call ath11k_pci_set_l1ss for WCN6855

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210511162214.29475-2-jouni@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

