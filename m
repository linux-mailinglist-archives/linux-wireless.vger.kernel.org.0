Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3AF321167
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Feb 2021 08:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhBVHdK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Feb 2021 02:33:10 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:14913 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229966AbhBVHdI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Feb 2021 02:33:08 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613979162; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=3NdAcsGlLHGtqIG+XNl2l8drEy707vG543eK+2qT4LY=;
 b=H4i5u118Ykv+ejSuCtxQx7ucZonZzdZ7KyVoxbyd7xTUlOLEVwjURwChsSshIYFTHjL1cUKc
 Fp6TpXreJq+OxuK2eHN4i9or6ucmnwGQwooiolFQCYTvMfC0q+ZDszq/jBYJbHzCUItmpNND
 /AJW49AB+FKkRMhp6nbKJFqs6nc=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 60335dfa9946643859bf6064 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Feb 2021 07:32:10
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1DEF0C43461; Mon, 22 Feb 2021 07:32:10 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 90A1AC433C6;
        Mon, 22 Feb 2021 07:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 90A1AC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: print hardware name and version during
 initialisation
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1613589400-18891-1-git-send-email-kvalo@codeaurora.org>
References: <1613589400-18891-1-git-send-email-kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210222073210.1DEF0C43461@smtp.codeaurora.org>
Date:   Mon, 22 Feb 2021 07:32:10 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> wrote:

> This way it's easy for the user to find what device is actually installed. This
> also helps reporting bugs.
> 
> Screenshot:
> 
> [  459.988812] ath11k_pci 0000:06:00.0: BAR 0: assigned [mem 0xdb000000-0xdbffffff 64bit]
> [  459.988867] ath11k_pci 0000:06:00.0: enabling device (0000 -> 0002)
> [  459.997048] ath11k_pci 0000:06:00.0: qca6390 hw2.0
> [  460.058093] mhi mhi0: Requested to power ON
> [  460.059741] mhi mhi0: Power on setup success
> [  460.476924] ath11k_pci 0000:06:00.0: chip_id 0x0 chip_family 0xb board_id 0xff soc_id 0xffffffff
> [  460.477032] ath11k_pci 0000:06:00.0: fw_version 0x101c06cc fw_build_timestamp 2020-06-24 19:50 fw_build_id
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> 
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

6b7abacb9cbe ath11k: print hardware name and version during initialisation

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1613589400-18891-1-git-send-email-kvalo@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

