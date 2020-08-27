Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9ADF254390
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Aug 2020 12:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgH0KTJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 06:19:09 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:19374 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728895AbgH0KTH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 06:19:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598523547; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=QbKK+5+ggvjqHyMHZ4elMsujh+LOHuTBEDXE/1UtSuQ=;
 b=scvtUKcPTemn11peCbKUPDXhHFPTvKLy/S11LVTqDW9rGKAGFwhX3IQLlxDq2cHpTMdyJhP0
 +vqWxAkHlYb08aplxxa9uYEh0ro6H9mRF/wCM085D57Ed53fvYJuG/P2PqfczII8PPVzBaSk
 aypVnsgcP9OqAW5pmfMqog57de4=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f478897c598aced5430085b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 27 Aug 2020 10:19:03
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 970DAC433AD; Thu, 27 Aug 2020 10:19:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C3B27C433CB;
        Thu, 27 Aug 2020 10:19:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C3B27C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: return error if firmware request fails
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200825143040.233619-1-alex.dewar90@gmail.com>
References: <20200825143040.233619-1-alex.dewar90@gmail.com>
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     unlisted-recipients:; (no To-header on input)
        Alex Dewar <alex.dewar90@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     unlisted-recipients:; (no To-header on input)Alex Dewar <alex.dewar90@gmail.com>
                                                                     ^-missing end of address
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200827101903.970DAC433AD@smtp.codeaurora.org>
Date:   Thu, 27 Aug 2020 10:19:03 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Alex Dewar <alex.dewar90@gmail.com> wrote:

> In ath11k_qmi_prepare_bdf_download(), ath11k_core_firmware_request() is
> called, but the returned pointer is not checked for errors. Rather the
> variable ret (which will always be zero) is checked by mistake. Fix
> this and replace the various gotos with simple returns for clarity.
> 
> While we are at it, move the call to memset, as variable bd is not used
> on all code paths.
> 
> Fixes: 7b57b2ddec21 ("ath11k: create a common function to request all firmware files")
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

342b6194a75b ath11k: return error if firmware request fails

-- 
https://patchwork.kernel.org/patch/11735787/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

