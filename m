Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4292D3C20
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 08:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgLIHX6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 02:23:58 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:42571 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgLIHX6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 02:23:58 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607498613; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=2mtiWECyJLbNztXFOgFTrwXg4rxB45YeSFLIB8BeWBY=;
 b=TozhOcOBfiBW0t1rUvUJynp6VGEYImyGP+XrUA7mWrhTG6cC8BrDAs+zuOmadvoeyEvFrK2f
 zil2HEL22LivT7DvPRFk94o5Xk/rDFj7n1g+EbjT+uiNpl6bI4IRsnnc9RwWcBoMVcfhPtQt
 y/6zFLgswr51PTkAPgE5W9s4/xQ=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5fd07b4ec2fb7b0d2b9cdfc2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 09 Dec 2020 07:22:54
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 824C1C43461; Wed,  9 Dec 2020 07:22:53 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 921BDC433C6;
        Wed,  9 Dec 2020 07:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 921BDC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtlwifi: rtl8192de: fix ofdm power compensation
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201207031903.7599-1-pkshih@realtek.com>
References: <20201207031903.7599-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <Larry.Finger@lwfinger.net>, <linux-wireless@vger.kernel.org>,
        <dan.carpenter@oracle.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201209072253.824C1C43461@smtp.codeaurora.org>
Date:   Wed,  9 Dec 2020 07:22:53 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> ofdm_index[] is used to indicate how many power compensation is needed to
> current thermal value. For internal PA module or 2.4G band, the min_index
> is different from other cases.
> 
> This issue originally is reported by Dan. He found the size of ofdm_index[]
> is 2, but access index 'i' may be equal to 2 if 'rf' is 2 in case of
> 'is2t'.
> 
> In fact, the chunk of code is added to wrong place, so move it back to
> proper place, and then power compensation and buffer overflow are fixed.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

3f79e541593f rtlwifi: rtl8192de: fix ofdm power compensation

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201207031903.7599-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

