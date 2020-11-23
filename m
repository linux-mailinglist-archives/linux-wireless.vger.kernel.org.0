Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1590C2C1374
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Nov 2020 20:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbgKWSga (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Nov 2020 13:36:30 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:58176 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729216AbgKWSga (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Nov 2020 13:36:30 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606156589; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=rl+Onv2gPq3wQdrUuY83xmG4FKETM8aXO0A1z5prBd8=;
 b=FdEtF8xdLt1HdpE3yiHqzi0atIPdml1UkHQfQOkzHkbko9zUuT8xfW+qLgQkonov2oNEirHe
 D2YMgyW6qCdSbaLKKLD90CBLsE6NRNh89USJa+D74FgeAwLZ+9/p6GFttP36oqOORIcwjFMi
 1DoR0KYMVgHbIk06JBYiXSU65xc=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5fbc0128fa67d9becf0e690e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 23 Nov 2020 18:36:24
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 400CDC43461; Mon, 23 Nov 2020 18:36:23 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AC954C433ED;
        Mon, 23 Nov 2020 18:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AC954C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: add 64bit check before reading msi high addr
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1605758301-11249-1-git-send-email-akolli@codeaurora.org>
References: <1605758301-11249-1-git-send-email-akolli@codeaurora.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201123183623.400CDC43461@smtp.codeaurora.org>
Date:   Mon, 23 Nov 2020 18:36:23 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anilkumar Kolli <akolli@codeaurora.org> wrote:

> In QCN9074 ath11k boot, firmware crash is observed in 64-bit
> builds and is due to wrong 64 bit MSI address size. This patch
> fixes the firmware crash. Read msi high addr if 64-bit addresses
> allowed on MSI.
> 
> Tested-On: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1.r1-00026-QCAHKSWPL_SILICONZ-2
> 
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>

Fails to build:

drivers/net/wireless/ath/ath11k/pci.c: In function 'ath11k_pci_get_msi_address':
drivers/net/wireless/ath/ath11k/pci.c:273:43: error: 'ab_pci' undeclared (first use in this function); did you mean 'ar_pci'?
  273 |  if (test_bit(ATH11K_PCI_FLAG_IS_MSI_64, &ab_pci->flags)) {
      |                                           ^~~~~~
      |                                           ar_pci
drivers/net/wireless/ath/ath11k/pci.c:273:43: note: each undeclared identifier is reported only once for each function it appears in
drivers/net/wireless/ath/ath11k/pci.c:267:21: warning: unused variable 'ar_pci' [-Wunused-variable]
  267 |  struct ath11k_pci *ar_pci = ath11k_pci_priv(ab);
      |                     ^~~~~~
make[5]: *** [drivers/net/wireless/ath/ath11k/pci.o] Error 1
make[5]: *** Waiting for unfinished jobs....
make[4]: *** [drivers/net/wireless/ath/ath11k] Error 2
make[3]: *** [drivers/net/wireless/ath] Error 2
make[2]: *** [drivers/net/wireless] Error 2
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1605758301-11249-1-git-send-email-akolli@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

