Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B744A220860
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2020 11:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730536AbgGOJOC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jul 2020 05:14:02 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:25246 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730275AbgGOJOB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jul 2020 05:14:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594804441; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=3S7iyBl1wh3Nm0MvpG8iaSC7Y4tz2Wmy4aArmdzDCYg=;
 b=Vf2kaQR1iU01C0juq9RPyfAu29ZImcBLqChJpO21yLy+mOEmOcowy4Rf9YlRGYXlkqkvUsMN
 MajUSolItA0RJlgxHMQsZDeQhiYFjmyhYU5ecVcVBkv0ta+9hBRXenJ2lLTJL6UVA+5z7yJ4
 NyDDr7aKXOLy0Q1AQuSukBV4xEI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f0ec8ca75eeb235f652c876 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 15 Jul 2020 09:13:46
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5FF4DC433A0; Wed, 15 Jul 2020 09:13:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 53F98C433C6;
        Wed, 15 Jul 2020 09:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 53F98C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next] mwifiex: Prevent memory corruption handling keys
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200708115857.GA13729@mwanda>
References: <20200708115857.GA13729@mwanda>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "John W. Linville" <linville@tuxdriver.com>,
        Bing Zhao <bzhao@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Marc Yang <yangyang@marvell.com>,
        Frank Huang <frankh@marvell.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200715091346.5FF4DC433A0@smtp.codeaurora.org>
Date:   Wed, 15 Jul 2020 09:13:46 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The length of the key comes from the network and it's a 16 bit number.  It
> needs to be capped to prevent a buffer overflow.
> 
> Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Acked-by: Ganapathi Bhat <ganapathi.bhat@nxp.com>

Patch applied to wireless-drivers-next.git, thanks.

e18696786548 mwifiex: Prevent memory corruption handling keys

-- 
https://patchwork.kernel.org/patch/11651443/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

