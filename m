Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82DE63FAA2F
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Aug 2021 10:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbhH2IeT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Aug 2021 04:34:19 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:50590 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234823AbhH2IeS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Aug 2021 04:34:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630226006; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=NV3/CEzKXbT42V1aeGnkslgVyhouRPG377hwk77k9wA=;
 b=USKhb4CEiSuTHsZn2SwPXZoc6G9gIUezUtQDJAyvdLrcqnl5e7YebeVRBgbatWq76mFUc/V2
 KS7ffgtCREDPUcuEywJRHvdPVL2g6xucJlQBqs89Xu5CSGxFu3CkHqgn/K2i7GGklpNdBrKG
 Tw9pd2mf0AIDqkznsi3N4K7BU9s=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 612b465640d2129ac1b8c5a6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 29 Aug 2021 08:33:26
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 68477C43617; Sun, 29 Aug 2021 08:33:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7FF61C4338F;
        Sun, 29 Aug 2021 08:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 7FF61C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] brcmfmac: Add WPA3 Personal with FT to supported
 cipher
 suites
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210824221330.3847139-1-czajernia@gmail.com>
References: <20210824221330.3847139-1-czajernia@gmail.com>
To:     =?utf-8?q?Pawe=C5=82_Drewniak?= <czajernia@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        =?utf-8?q?Pawe=C5=82_Drewni?= =?utf-8?q?ak?= 
        <czajernia@gmail.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210829083326.68477C43617@smtp.codeaurora.org>
Date:   Sun, 29 Aug 2021 08:33:26 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Paweł Drewniak <czajernia@gmail.com> wrote:

> This allows the driver to connect to BSSIDs supporting SAE with 802.11r.
> Tested on Raspberry Pi 4 Model B (STA) and UniFi 6LR/OpenWRT 21.02.0-rc2.
> AP was set to 'sae-mixed' (WPA2/3 Personal).
> 
> Signed-off-by: Paweł Drewniak <czajernia@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

4b51de063d53 brcmfmac: Add WPA3 Personal with FT to supported cipher suites

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210824221330.3847139-1-czajernia@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

