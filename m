Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20DB34292DE
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 17:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbhJKPN4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 11:13:56 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:60311 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbhJKPNz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 11:13:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633965115; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=ax258dGkFHdlEtg7gdzITAbzaEoTc1TinVq+aehmmo0=;
 b=bNzD/zyZD9B7YHJU1b9AH9XwhgFeaCvg+OwOTWb9lqy5Yzf3vbXhad1v/eQ7rW3q0tZUN3OK
 cgEL6ON316ADQpRmV7QLtEaWCIh++cpL1qKP5crBAvnzfG94+SafJX03BZCxEeeUFA0UrqXF
 NGyJtjqsLXil4ok+LVZ1ejqs7q0=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6164543503355859c8ef0c19 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Oct 2021 15:11:49
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4167EC4360D; Mon, 11 Oct 2021 15:11:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8CEBAC4338F;
        Mon, 11 Oct 2021 15:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 8CEBAC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5/5] ath11k: Handle MSI enablement during rmmod and SSR
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210913180246.193388-5-jouni@codeaurora.org>
References: <20210913180246.193388-5-jouni@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Baochen Qiang <bqiang@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163396510235.19083.7350385840200082489.kvalo@codeaurora.org>
Date:   Mon, 11 Oct 2021 15:11:49 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> wrote:

> When doing "rmmod ath11k_pci", ath11k performs global SOC reset
> and MHI reset, where 0 address access is captured by IOMMU. See
> log below:
> 
> ...
> [  133.953860] ath11k_pci 0000:02:00.0: setting mhi state: DEINIT(1)
> [  133.959714] ath11k_pci 0000:02:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000a address=0x0 flags=0x0020]
> [  133.973854] ath11k_pci 0000:02:00.0: MHISTATUS 0xff04
> [  133.974095] ath11k_pci 0000:02:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000a address=0x0 flags=0x0020]
> ...
> 
> This issue is also observed in SSR process, cause a similar
> sequence as above is performed.
> 
> Such an invalid access occurs because, during rmmod or SSR, MSI
> address is cleared but HW MSI functionality not disabled, thus HW
> target is able to raise an MSI transaction with 0 as MSI address.
> 
> So it can be fixed by simply disabling MSI before reset. For SSR,
> since MSI functionality is still needed after target is brought
> back, we need to reenable it.
> 
> Also change naming of some interfaces related.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

96527d527b27 ath11k: Handle MSI enablement during rmmod and SSR

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210913180246.193388-5-jouni@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

