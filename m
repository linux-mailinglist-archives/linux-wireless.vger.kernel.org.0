Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0459124FA5
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 18:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfLRRri (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 12:47:38 -0500
Received: from m228-19.mailgun.net ([159.135.228.19]:60421 "EHLO
        m228-19.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfLRRri (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 12:47:38 -0500
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Dec 2019 12:47:36 EST
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576691257; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=h0C3L7ahJgISuMamVC6pjPTTLiet1h2s1zvk7prZq6g=;
 b=VyZyhPCmQtFBDbMkXPc2bakDbMb8jJHQsxFd+PW1tGbxpGT+6Mbi9o5S48CTf8O6DWucwZnR
 t3DzPftjWMyO8bIY91Vh/5jr1EYoZuBk6LkS/4tm3w0Kf/iz5MByRaO/cZrHc0vTR/A0gqd9
 hryVHNwOI4QYaJfbz4g7bGholiw=
X-Mailgun-Sending-Ip: 159.135.228.19
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfa6503.7f4255fda3e8-smtp-out-n02;
 Wed, 18 Dec 2019 17:42:27 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1D953C433CB; Wed, 18 Dec 2019 17:42:27 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 86DE1C43383;
        Wed, 18 Dec 2019 17:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 86DE1C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V2 1/2] ath11k: fix pdev when invoking
 ath11k_wmi_send_twt_enable_cmd()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191213153457.11946-1-john@phrozen.org>
References: <20191213153457.11946-1-john@phrozen.org>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        John Crispin <john@phrozen.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191218174227.1D953C433CB@smtp.codeaurora.org>
Date:   Wed, 18 Dec 2019 17:42:27 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> wrote:

> The code currently uses the wrong pdev id when enabling TWT. Fix this by
> using the correct ones.
> 
> Fixes: e65a616f4e74 ("ath11k: add TWT support")
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

2 patches applied to ath-next branch of ath.git, thanks.

485add35771b ath11k: fix pdev when invoking ath11k_wmi_send_twt_enable_cmd()
aacb46223e08 ath11k: set the BA buffer size to 256 when HE is enabled

-- 
https://patchwork.kernel.org/patch/11290725/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
