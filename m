Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3D6316051
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 08:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbhBJHsm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 02:48:42 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:25615 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233011AbhBJHrX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 02:47:23 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612943224; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=iSB3ttwA0JFsbKBWrzyvbO2MfU9rmRMghR0q+MB5dO8=;
 b=K9Ij4EeV1p60JXAD7Zf9KKlJh3MFdZNRaankkxtAZvxodHI0D9gUAsCzI4NTs/tR3tMEQbxx
 Kbk7ySulGVnDB1XabiuFWXsPRFewC/TeiTEekovWG2wgCWnorFnPXnZ4l1Vegbvvh0/XwUw9
 wcjMcjNrURTsn+ziJPq8ZI0rjR8=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 60238f5381f6c45dcef81ebc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Feb 2021 07:46:27
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 04D54C43463; Wed, 10 Feb 2021 07:46:27 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EFF00C433C6;
        Wed, 10 Feb 2021 07:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EFF00C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ath11k: fix a locking bug in ath11k_mac_op_start()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <YBk4GoeE+yc0wlJH@mwanda>
References: <YBk4GoeE+yc0wlJH@mwanda>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Peter Oh <peter.oh@eero.com>, Carl Huang <cjhuang@codeaurora.org>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210210074627.04D54C43463@smtp.codeaurora.org>
Date:   Wed, 10 Feb 2021 07:46:27 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> This error path leads to a Smatch warning:
> 
> 	drivers/net/wireless/ath/ath11k/mac.c:4269 ath11k_mac_op_start()
> 	error: double unlocked '&ar->conf_mutex' (orig line 4251)
> 
> We're not holding the lock when we do the "goto err;" so it leads to a
> double unlock.  The fix is to hold the lock for a little longer.
> 
> Fixes: c83c500b55b6 ("ath11k: enable idle power save mode")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> [kvalo@codeaurora.org: move also rcu_assign_pointer() call]
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

c202e2ebe1dc ath11k: fix a locking bug in ath11k_mac_op_start()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/YBk4GoeE+yc0wlJH@mwanda/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

