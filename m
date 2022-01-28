Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8466A49F784
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 11:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239158AbiA1KmL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 05:42:11 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41996 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiA1KmK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 05:42:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78A2461E94;
        Fri, 28 Jan 2022 10:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB45DC340E0;
        Fri, 28 Jan 2022 10:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643366529;
        bh=94+xk3kijD/tfXwMq0MLqwhq9v5/ZCQkbFHtYHR4uIU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=fMBer27VyXF7Tsmz7ZjK9lDGzLQ7PQ6Igs2HUcOZhK77LzVbHKI+Gy24VjoEkDQfM
         Ft68pHNhIh4uvXpP2OL/Qs59ngg+kPGomJ24E4Pcpa65EuEpjoY4RCL+VblZa+rW0a
         fpvQj2j3d85i3LzXf9Gje/ylzTfwqxJFAvuZJA0abVQcdcXdESjGymBSO6yPnX76Bq
         aa5cRjFpfija2d0maT7iypE1nA1HSbsQqxwaMexgju2SUr7gcx1xyF5fak5VlKw30X
         NzufE+6Ekmvmb/0wB39c4ocAv7/sHH0TT4Z3IlYhLLv4Rat5SIWJHsKfTAAdqdqGf8
         tXtdgZEQC3F4g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>
Subject: Re: [PATCH v2 18/19] ath11k: Add support for targets without trustzone
References: <1642337235-8618-1-git-send-email-quic_mpubbise@quicinc.com>
        <1642337235-8618-19-git-send-email-quic_mpubbise@quicinc.com>
Date:   Fri, 28 Jan 2022 12:42:04 +0200
In-Reply-To: <1642337235-8618-19-git-send-email-quic_mpubbise@quicinc.com>
        (Manikanta Pubbisetty's message of "Sun, 16 Jan 2022 18:17:14 +0530")
Message-ID: <87sft8f8g3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:

> Add the support to attach WCN6750 and map iommu domain
> for targets which do not have the support of TrustZone.
>
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>

Is this not needed in the initial WCN6750 support? If yes, please submit
this patch after WCN6750 support has been commited. That way we can
reduce patchset size.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
