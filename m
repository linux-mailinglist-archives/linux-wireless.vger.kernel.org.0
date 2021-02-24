Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69FBE323776
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Feb 2021 07:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbhBXGjR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Feb 2021 01:39:17 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:14067 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233922AbhBXGjG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Feb 2021 01:39:06 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614148723; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=8Pydcp9COoIGHDaoT0QgAMFt7/h/mut2grD4T9bcAEo=;
 b=PVzQIFGTXP5RDlIt5hvXWnZcCxEUyB3H2oWiy2bHctKBux2uDdSnQbjcaANYCAVLq0bImLAH
 dtMqJWho128AtAugBZjfFq15AglA7gccpOMzO0KE9AhHL0ImKOeFkT2aWVGFip7ueXTQkohK
 aLmqLPE2Cl/4+tbkNKUQ5Q6o5iw=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 6035f466090a7742879077dc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 24 Feb 2021 06:38:30
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A025EC43461; Wed, 24 Feb 2021 06:38:30 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 59EF1C433CA;
        Wed, 24 Feb 2021 06:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 59EF1C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5.12] ath11k: fix AP mode for QCA6390
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1614006849-25764-1-git-send-email-kvalo@codeaurora.org>
References: <1614006849-25764-1-git-send-email-kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210224063830.A025EC43461@smtp.codeaurora.org>
Date:   Wed, 24 Feb 2021 06:38:30 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> wrote:

> Commit c134d1f8c436 ("ath11k: Handle errors if peer creation fails") completely
> broke AP mode on QCA6390:
> 
> kernel: [  151.230734] ath11k_pci 0000:06:00.0: failed to create peer after vdev start delay: -22
> wpa_supplicant[2307]: Failed to set beacon parameters
> wpa_supplicant[2307]: Interface initialization failed
> wpa_supplicant[2307]: wlan0: interface state UNINITIALIZED->DISABLED
> wpa_supplicant[2307]: wlan0: AP-DISABLED
> wpa_supplicant[2307]: wlan0: Unable to setup interface.
> wpa_supplicant[2307]: Failed to initialize AP interface
> 
> This was because commit c134d1f8c436 ("ath11k: Handle errors if peer creation
> fails") added error handling for ath11k_peer_create(), which had been failing
> all along but was unnoticed due to the missing error handling. The actual bug
> was introduced already in commit aa44b2f3ecd4 ("ath11k: start vdev if a bss peer is
> already created").
> 
> ath11k_peer_create() was failing because for AP mode the peer is created
> already earlier op_add_interface() and we should skip creation here, but the
> check for modes was wrong.  Fixing that makes AP mode work again.
> 
> This shouldn't affect IPQ8074 nor QCN9074 as they have hw_params.vdev_start_delay disabled.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> 
> Fixes: c134d1f8c436 ("ath11k: Handle errors if peer creation fails")
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to wireless-drivers.git, thanks.

77d7e87128d4 ath11k: fix AP mode for QCA6390

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1614006849-25764-1-git-send-email-kvalo@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

