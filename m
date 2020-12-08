Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2902D2465
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Dec 2020 08:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgLHHer (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Dec 2020 02:34:47 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:56447 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgLHHeq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Dec 2020 02:34:46 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607412863; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Y9wKlEfV1a6eckS39I+B3YekUWDcVTB/fgctU6CZTdA=;
 b=s9aGZOGBTzQlVBfP7Pa+yFynk3V9MWBaDUUPLDL9DRrqfUXGzdM4hu7G/AEn8RewHn49x+a/
 1x5Evr5UV+qmdtU6jPS3bwhdgh43K2YCkgRw3HB9om4iyZmNfhk8suDXDoGUMIVvewEPMmmD
 nGxtxFzwWDuFNOtDRMwEvuzWm50=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5fcf2c5b7d6a74e409944b0f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 08 Dec 2020 07:33:47
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9B332C433CA; Tue,  8 Dec 2020 07:33:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2FB11C433C6;
        Tue,  8 Dec 2020 07:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2FB11C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/1] mwifiex: Fix possible buffer overflows in
 mwifiex_cmd_802_11_ad_hoc_start
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201206084801.26479-1-ruc_zhangxiaohui@163.com>
References: <20201206084801.26479-1-ruc_zhangxiaohui@163.com>
To:     Xiaohui Zhang <ruc_zhangxiaohui@163.com>
Cc:     Xiaohui Zhang <ruc_zhangxiaohui@163.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>, davem@davemloft.net,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201208073347.9B332C433CA@smtp.codeaurora.org>
Date:   Tue,  8 Dec 2020 07:33:47 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Xiaohui Zhang <ruc_zhangxiaohui@163.com> wrote:

> From: Zhang Xiaohui <ruc_zhangxiaohui@163.com>
> 
> mwifiex_cmd_802_11_ad_hoc_start() calls memcpy() without checking
> the destination size may trigger a buffer overflower,
> which a local user could use to cause denial of service
> or the execution of arbitrary code.
> Fix it by putting the length check before calling memcpy().
> 
> Signed-off-by: Zhang Xiaohui <ruc_zhangxiaohui@163.com>

Patch applied to wireless-drivers-next.git, thanks.

5c455c5ab332 mwifiex: Fix possible buffer overflows in mwifiex_cmd_802_11_ad_hoc_start

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201206084801.26479-1-ruc_zhangxiaohui@163.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

