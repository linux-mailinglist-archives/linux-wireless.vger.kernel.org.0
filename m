Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CE34A5ABB
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Feb 2022 11:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237015AbiBAK5V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Feb 2022 05:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237001AbiBAK5U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Feb 2022 05:57:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05864C061714
        for <linux-wireless@vger.kernel.org>; Tue,  1 Feb 2022 02:57:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BED2EB82D4C
        for <linux-wireless@vger.kernel.org>; Tue,  1 Feb 2022 10:57:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A79C340EB;
        Tue,  1 Feb 2022 10:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643713037;
        bh=dcw3g1XG1ijlkNOculpPUddmc2hf4nc9efO+ky0KgWE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=kcK6fG9EhmLU/4zz1CbyOVw09pYgd/W4EML5+T+PmyBoJZiVDqXtgv62jcQlNSQwG
         U+GfJq9xpZ+WdugwUiQ47c1ERi3sXu2TvyKX57qZrauwr4GWkle4Rc42aT8MUpB3x3
         IVqlqL8su5eehtWTMCTX+F91cdC71jgEgrX7q9vNtEl5AGttzuBLYLADLypgzhIKSi
         r6H+Z7j/vgtVBPHxsEtcoa9tHn6xdb1Ps8bcm60OOXBHNvC5BSo9EyBFbEYN88g6ZS
         H56926BXikqwps3aWslmpO+wqyz8ZI4U7Lr/ddo1JjW6VSkrGwHYK7b2ffqfQX9aOr
         iMLY4eYgJ64hw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V8 1/2] ath11k: add WMI calls to manually
 add/del/pause/resume
 TWT dialogs
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220131031043.1295-1-alokad@codeaurora.org>
References: <20220131031043.1295-1-alokad@codeaurora.org>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164371303517.12561.11692936701884999707.kvalo@kernel.org>
Date:   Tue,  1 Feb 2022 10:57:16 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aloka Dixit <alokad@codeaurora.org> wrote:

> These calls are used for debugging and will be required for WFA
> certification tests.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01179-QCAHKSWPL_SILICONZ-1
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

3d00e8b5b818 ath11k: add WMI calls to manually add/del/pause/resume TWT dialogs
fe98a6137d03 ath11k: add debugfs for TWT debug calls

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220131031043.1295-1-alokad@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

