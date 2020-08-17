Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70BC1246443
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Aug 2020 12:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgHQKTO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Aug 2020 06:19:14 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:34531 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726151AbgHQKTO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Aug 2020 06:19:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597659553; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=ygawbP2j5cRTeRcGHB/5Z0VSU8uDIA0b+4PjtCnH1GE=;
 b=YcxkeAE7gnPfRQqW225PhbLmQeSXe4gNY8KpqHbiL2EdEtigCcI5lD46tjDBgWbxQyF/9hHG
 y4ptJsbh6fyMBQpgpNA8zXp/YeJtCD2aH+ZIzFK+VRNiZ7vxDtAnHX5LEZqfqfSvlJPLMLwX
 yKsxEabG0rRJDDIO4uxSBPOkw+I=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f3a59a0440a07969a553528 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 17 Aug 2020 10:19:12
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5F992C433CB; Mon, 17 Aug 2020 10:19:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 370F0C433CA;
        Mon, 17 Aug 2020 10:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 370F0C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/11] ath11k: add support for m3 firmware
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1597389030-13887-2-git-send-email-kvalo@codeaurora.org>
References: <1597389030-13887-2-git-send-email-kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200817101911.5F992C433CB@smtp.codeaurora.org>
Date:   Mon, 17 Aug 2020 10:19:11 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> wrote:

> PCI devices like QCA6390 have a separate firmware image for the m3
> micro-controller. Add support to load the firmware using m3.bin file.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2
> 
> Signed-off-by: Govind Singh <govinds@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

11 patches applied to ath-next branch of ath.git, thanks.

569704544778 ath11k: add support for m3 firmware
6eb6ea513828 ath11k: add board file support for PCI devices
eb8de0490e1f ath11k: fill appropriate QMI service instance id for QCA6390
654e959ae0a1 ath11k: pci: add read32() and write32() hif operations
c4eacabee224 ath11k: configure copy engine msi address in CE srng
2c3960c2253d ath11k: setup ce tasklet for control path
26f3a021b37c ath11k: allocate smaller chunks of memory for firmware
f44dd33e6336 ath11k: fix memory OOB access in qmi_decode
6c809d04c542 ath11k: fix KASAN warning of ath11k_qmi_wlanfw_wlan_cfg_send
727fae1478a5 ath11k: enable internal sleep clock
f7eb4b04ce6f ath11k: hal: create hw_srng_config dynamically

-- 
https://patchwork.kernel.org/patch/11713607/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

