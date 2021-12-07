Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B4D46BF1F
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Dec 2021 16:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbhLGPVl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Dec 2021 10:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234933AbhLGPVk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Dec 2021 10:21:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40695C061574
        for <linux-wireless@vger.kernel.org>; Tue,  7 Dec 2021 07:18:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06831B817B6
        for <linux-wireless@vger.kernel.org>; Tue,  7 Dec 2021 15:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1CBC341C1;
        Tue,  7 Dec 2021 15:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638890287;
        bh=h0Ql3E0ICU7/XRtzNOTsUF2pda4AqGfhADdvOMsJBOE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=OVrAbnre31eIC9fIyHDTKAq5GSc8RD5dQTFKEXFc2LwXVonSqG1ES4JZA+RCDg0gO
         T7pN+cAd2cOaXAvCXnEXJPup17TS56VI92pSdWzLRPSfjKL298T0zRGVW8uYal4Cm1
         klpvzv2RRm+3OXXa7xD4LedFFcv6gq6piA2H8DdIG37xpZaY8q5G6+7nvDRztpcfvY
         TWsvKxr3dqQwgwdo+l4mrjbAugQXZUoeYrFS0RnayytGselBR+yP3xwXBAf5Sgb6jr
         eSpQPBOAKtDvthF+VxuuuxNShGTlsfEXHlp9rtuZSeFlmYkxT1ch2jhLClYJZEVvD6
         Hm8b9jUQyEzZw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Fix QMI file type enum value
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1638182754-18408-1-git-send-email-quic_seevalam@quicinc.com>
References: <1638182754-18408-1-git-send-email-quic_seevalam@quicinc.com>
To:     Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163889028518.23771.5686155539421838446.kvalo@kernel.org>
Date:   Tue,  7 Dec 2021 15:18:06 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Seevalamuthu Mariappan <quic_seevalam@quicinc.com> wrote:

> bdf_type for caldata in QMI_WLANFW_BDF_DOWNLOAD_REQ_V01 is wrongly
> sent as 1. But, expected bdf_type value for caldata and EEPROM is 2 and 3
> respectively. It leads to firmware crash. Fix ath11k_qmi_file_type enum
> values.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 336e7b53c82f ("ath11k: clean up BDF download functions")
> Signed-off-by: Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

18ae1ab04525 ath11k: Fix QMI file type enum value

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1638182754-18408-1-git-send-email-quic_seevalam@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

