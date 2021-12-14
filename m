Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098AB47467B
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Dec 2021 16:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbhLNPct (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Dec 2021 10:32:49 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51582 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbhLNPct (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Dec 2021 10:32:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED88761583
        for <linux-wireless@vger.kernel.org>; Tue, 14 Dec 2021 15:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D62DC34601;
        Tue, 14 Dec 2021 15:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639495968;
        bh=rNQOyKP91WXUWPlQpTUVmCNNBaTB58gSLYUa6dOW958=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=s2cMsEd2G4PvMLhNSdPeCRLjaCETeFxMk5+TnFFYzIImvKBUEQpy7WQEKcmjOK82r
         AM2l9iRyJtyp1XMBQznDkJdOCOUIez1Blxa714NYBlORln/O7xHf+SWsMg8oQwu4rY
         7JXlJMKP/uMkDXQgBHNT2oVONCeKm2NyLr3Yr6PWlW+lfV6IP2pV56S9Si5VXuCNny
         ZVmDHJu5LILz8n9/zV9XsN2QwAwVv6GgUugaLs6NbAsq216M34aMkTL6AkkYnvsRg3
         l7TTVuQB12GctC97Udi+j9LOHuHYhbi074tu8NjXLG/iR2diN+It/ZtZbAyYaAFHZ9
         x0XMwB4kc04QA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/2] ath11k: add ab to TARGET_NUM_VDEVS & co
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211209104351.9811-2-kvalo@kernel.org>
References: <20211209104351.9811-2-kvalo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163949596601.10444.7465143029436513701.kvalo@kernel.org>
Date:   Tue, 14 Dec 2021 15:32:47 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> wrote:

> The next patch changes TARGET_NUM_VDEVS to be dynamic and need access to ab.
> Add ab separately to keep the next patch simple.
> 
> Compile tested only.
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

523aafd0f071 ath11k: add ab to TARGET_NUM_VDEVS & co
beefee71336b ath11k: Change qcn9074 fw to operate in mode-2

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211209104351.9811-2-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

