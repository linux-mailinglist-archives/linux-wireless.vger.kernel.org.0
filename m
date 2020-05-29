Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881091E8540
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 19:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgE2RkN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 13:40:13 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:10102 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgE2RkM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 13:40:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590774012; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=fw7yQjOrmEqi1+wMCqYqitTs104Q/9ENLpxgX4Z7qCA=;
 b=GiGaZ01SenpWctKShP2sqI+1txMwk51395XyQ+OXGlVoU8u/rFk0E8ve7AUs+XqcMj7p+UeF
 AhO4SUxoQm74dJABvf1xHQwHXkssXFSuY1oH+mLK3P7U/15AxtgjB1cBjUc0qj8nuPxakoGB
 Enh5ImqTWtXJqNvGvjA3v81DVHs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5ed148f42c5499847529f7ae (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 May 2020 17:40:04
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 501D3C433C9; Fri, 29 May 2020 17:40:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E7074C433CB;
        Fri, 29 May 2020 17:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E7074C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V2 1/5] brcmfmac: set F2 blocksize for 4373
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200529034938.124533-2-chi-hsien.lin@cypress.com>
References: <20200529034938.124533-2-chi-hsien.lin@cypress.com>
To:     Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Chi-hsien Lin <chi-hsien.lin@cypress.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200529174003.501D3C433C9@smtp.codeaurora.org>
Date:   Fri, 29 May 2020 17:40:03 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Chi-Hsien Lin <chi-hsien.lin@cypress.com> wrote:

> From: Wright Feng <wright.feng@cypress.com>
> 
> Set F2 blocksize to 256 bytes for 4373. It fixes DMA error while having
> UDP bi-directional traffic. Also use a defined F1 MesBusyCtrl value.
> 
> Signed-off-by: Wright Feng <wright.feng@cypress.com>
> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>

5 patches applied to wireless-drivers-next.git, thanks.

2a7621ded321 brcmfmac: set F2 blocksize for 4373
528158a8d452 brcmfmac: fix 4339 CRC error under SDIO 3.0 SDR104 mode
2bee41270f3b brcmfmac: set F2 blocksize and watermark for 4354/4356 SDIO
df18c257bd6a brcmfmac: fix 43455 CRC error under SDIO 3.0 SDR104 mode
113a57a400a2 brcmfmac: 43012 Update MES Watermark

-- 
https://patchwork.kernel.org/patch/11577647/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

