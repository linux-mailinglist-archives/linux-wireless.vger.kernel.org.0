Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2D226BC4C
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Sep 2020 08:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgIPGMv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Sep 2020 02:12:51 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:32383 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbgIPGMj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Sep 2020 02:12:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600236758; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=ENpHmoNNGHPsdeWRvPgXC2S1t1eowRnOK+MNktNQBf8=;
 b=FV5h0P+Yyhb3n5/SsNS63mYdNAgDq0QkOo79nny7H0uI/kgCnMbOYWzg4UEEUqe+s3kvRcIt
 riX2qxZgr9upJu5zZQzvEz/a0QcrevmnGTC9SbQOcgrxRCplR4A9aX/CpyC7nr9l+XgFN6SV
 nPxG/8SKEMipcX+PPeg62vdNo6g=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f61acd6ba408b30ce89b1f1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 16 Sep 2020 06:12:38
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 74540C433CA; Wed, 16 Sep 2020 06:12:37 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D718EC433C8;
        Wed, 16 Sep 2020 06:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D718EC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH -next 1/3] rtlwifi: rtl8723ae: fix comparison pointer to
 bool
 warning in rf.c
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200910141642.127006-2-zhengbin13@huawei.com>
References: <20200910141642.127006-2-zhengbin13@huawei.com>
To:     Zheng Bin <zhengbin13@huawei.com>
Cc:     <pkshih@realtek.com>, <davem@davemloft.net>, <kuba@kernel.org>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <zhengbin13@huawei.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200916061237.74540C433CA@smtp.codeaurora.org>
Date:   Wed, 16 Sep 2020 06:12:37 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Zheng Bin <zhengbin13@huawei.com> wrote:

> Fixes coccicheck warning:
> 
> drivers/net/wireless/realtek/rtlwifi/rtl8723ae/rf.c:52:5-22: WARNING: Comparison to bool
> drivers/net/wireless/realtek/rtlwifi/rtl8723ae/rf.c:482:6-14: WARNING: Comparison to bool
> 
> Signed-off-by: Zheng Bin <zhengbin13@huawei.com>

3 patches applied to wireless-drivers-next.git, thanks.

4eef91a8dbce rtlwifi: rtl8723ae: fix comparison pointer to bool warning in rf.c
9d886ac4397e rtlwifi: rtl8723ae: fix comparison pointer to bool warning in trx.c
f26506f06bf8 rtlwifi: rtl8723ae: fix comparison pointer to bool warning in phy.c

-- 
https://patchwork.kernel.org/patch/11767923/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

