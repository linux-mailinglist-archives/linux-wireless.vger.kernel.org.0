Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1213054F7C
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 14:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbfFYM7w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 08:59:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40700 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728651AbfFYM7w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 08:59:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E2E4B601E7; Tue, 25 Jun 2019 12:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561467590;
        bh=ZhKgz7fozsVXBvdm3X+dNXKO/VMC2NiAgSRnAoANBEA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=RIgkJzjLSSRXHPuNwSqp08tGvFmf/mjWJtabr73gymRbeLxMV93wsiSWfDJEiN8vX
         t0gqEH3SqOPAdMnjSq3bLdYnIca2AZ+2M1fWPs2VUOt1J+2a7YVQ/duOPEKXNgZXke
         MfM/Cc43etogeARtxpjyLfoxL0tORgGnC2L3Zd34=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7CBFA601B4;
        Tue, 25 Jun 2019 12:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561467590;
        bh=ZhKgz7fozsVXBvdm3X+dNXKO/VMC2NiAgSRnAoANBEA=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=AQmfT+qJlh/CyjaQM1LWEQCeZfu0aenMpVmUQtRnJ8X2Znh2wmlSB0mr6YmSmLaJv
         U9k0+v+aGtqjNdglU7MRO8dbkRrHsdgU5i1pjbilrmlIzWit1RQur/pYRWdecq4faS
         GxHK9qYcq4mEs3Prh56Q1eAH8AZ4ps6DkXgmjTgY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7CBFA601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ath10k: fix fw crash by moving chip reset after napi
 disabled
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1558667782-10998-1-git-send-email-miaoqing@codeaurora.org>
References: <1558667782-10998-1-git-send-email-miaoqing@codeaurora.org>
To:     Miaoqing Pan <miaoqing@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Miaoqing Pan <miaoqing@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190625125950.E2E4B601E7@smtp.codeaurora.org>
Date:   Tue, 25 Jun 2019 12:59:50 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Miaoqing Pan <miaoqing@codeaurora.org> wrote:

> On SMP platform, when continuously running wifi up/down, the napi
> poll can be scheduled during chip reset, which will call
> ath10k_pci_has_fw_crashed() to check the fw status. But in the reset
> period, the value from FW_INDICATOR_ADDRESS register will return
> 0xdeadbeef, which also be treated as fw crash. Fix the issue by
> moving chip reset after napi disabled.
> 
> ath10k_pci 0000:01:00.0: firmware crashed! (guid 73b30611-5b1e-4bdd-90b4-64c81eb947b6)
> ath10k_pci 0000:01:00.0: qca9984/qca9994 hw1.0 target 0x01000000 chip_id 0x00000000 sub 168c:cafe
> ath10k_pci 0000:01:00.0: htt-ver 2.2 wmi-op 6 htt-op 4 cal otp max-sta 512 raw 0 hwcrypto 1
> ath10k_pci 0000:01:00.0: failed to get memcpy hi address for firmware address 4: -16
> ath10k_pci 0000:01:00.0: failed to read firmware dump area: -16
> ath10k_pci 0000:01:00.0: Copy Engine register dump:
> ath10k_pci 0000:01:00.0: [00]: 0x0004a000   0   0   0   0
> ath10k_pci 0000:01:00.0: [01]: 0x0004a400   0   0   0   0
> ath10k_pci 0000:01:00.0: [02]: 0x0004a800   0   0   0   0
> ath10k_pci 0000:01:00.0: [03]: 0x0004ac00   0   0   0   0
> ath10k_pci 0000:01:00.0: [04]: 0x0004b000   0   0   0   0
> ath10k_pci 0000:01:00.0: [05]: 0x0004b400   0   0   0   0
> ath10k_pci 0000:01:00.0: [06]: 0x0004b800   0   0   0   0
> ath10k_pci 0000:01:00.0: [07]: 0x0004bc00   1   0   1   0
> ath10k_pci 0000:01:00.0: [08]: 0x0004c000   0   0   0   0
> ath10k_pci 0000:01:00.0: [09]: 0x0004c400   0   0   0   0
> ath10k_pci 0000:01:00.0: [10]: 0x0004c800   0   0   0   0
> ath10k_pci 0000:01:00.0: [11]: 0x0004cc00   0   0   0   0
> 
> Tested HW: QCA9984,QCA9887,WCN3990
> 
> Signed-off-by: Miaoqing Pan <miaoqing@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

08d80e4cd27b ath10k: fix fw crash by moving chip reset after napi disabled

-- 
https://patchwork.kernel.org/patch/10959057/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

