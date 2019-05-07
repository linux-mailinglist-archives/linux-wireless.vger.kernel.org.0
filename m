Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6F4B164FB
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2019 15:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfEGNut (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 May 2019 09:50:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55696 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfEGNut (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 May 2019 09:50:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D201E60E57; Tue,  7 May 2019 13:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557237048;
        bh=UMGwbXcx64tBezxSNuvo+YAOX1QBmq2Crgw3gSp06pY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=F2jNQ6S9dPglpjfAefOHLfoCRBZUw2qvO8RXhQga57AASd8EH40rHyJiex/GO6zw3
         iuGPraS3j6tFscrrgZwUiwpcS+D55OQINkTJP5hGzHeeokJ3SK4iKhudHrAQ3p8raq
         KYRW31k+YjEaQINztptawwlGYc1MhQTp8fGjWPXs=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8B6E760CEC;
        Tue,  7 May 2019 13:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557237047;
        bh=UMGwbXcx64tBezxSNuvo+YAOX1QBmq2Crgw3gSp06pY=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=U7u5HFoV3zCtub88Fi06bNmoqAcolRP+yQy034+0CdJOGwWo5/WlBEzY7fWCakmTV
         A+43FpyzmLWs4w2FX+/K96+nbSUF4B0D9Hqn0c4/5tlpP9LM/v9ucvf9rWj9FMiqZo
         GpuCd2iTxlpCuxJmXi/hxZMAJ/s101ajYRaq/oy0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8B6E760CEC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: Fix encoding for protected management frames
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1554208970-16527-1-git-send-email-pillair@codeaurora.org>
References: <1554208970-16527-1-git-send-email-pillair@codeaurora.org>
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Rakesh Pillai <pillair@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190507135048.D201E60E57@smtp.codeaurora.org>
Date:   Tue,  7 May 2019 13:50:48 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rakesh Pillai <pillair@codeaurora.org> wrote:

> Currently the protected management frames are
> not appended with the MIC_LEN which results in
> the protected management frames being encoded
> incorrectly.
> 
> Add the extra space at the end of the protected
> management frames to fix this encoding error for
> the protected management frames.
> 
> Tested HW: WCN3990
> Tested FW: WLAN.HL.3.1-00784-QCAHLSWMTPLZ-1
> 
> Fixes: 1807da49733e ("ath10k: wmi: add management tx by reference support over wmi")
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

42f1bc43e6a9 ath10k: Fix encoding for protected management frames

-- 
https://patchwork.kernel.org/patch/10881571/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

