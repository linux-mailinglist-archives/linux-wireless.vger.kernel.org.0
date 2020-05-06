Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDDA91C6BCF
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2020 10:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgEFIdC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 May 2020 04:33:02 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:15298 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728362AbgEFIdC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 May 2020 04:33:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588753981; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=qH+vCEx8KLreAZPwfhn/ZHD1N/t4AEdE0BQqkYtDN/M=;
 b=BJq2zAkhq1JMNZOX805TQX/SyRvP/wbHCGIPzXRDr99nwyMljio0cfy+mCke8uq/oes1akJE
 zEgeTNMOC/cFyedY2Rz36mldHPdqEKRtM1VmK/8UQgHtyR7YDoRLuGhqMgo62hYZDfNQ9PWb
 e3BiHEJjpMq6wzR5I7i4WPsDGHc=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb27639.7fcea71aba08-smtp-out-n02;
 Wed, 06 May 2020 08:32:57 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5F2ABC43637; Wed,  6 May 2020 08:32:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 49389C433BA;
        Wed,  6 May 2020 08:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 49389C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtlwifi: use true,false for bool variable in
 rtl_init_rfkill()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200426094115.23294-1-yanaijie@huawei.com>
References: <20200426094115.23294-1-yanaijie@huawei.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     <pkshih@realtek.com>, <davem@davemloft.net>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jason Yan <yanaijie@huawei.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200506083257.5F2ABC43637@smtp.codeaurora.org>
Date:   Wed,  6 May 2020 08:32:57 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jason Yan <yanaijie@huawei.com> wrote:

> The 'blocked' is a bool variable, and '==' expression itself is bool
> too. So no need to convert it to 0/1.
> 
> This fixes the following coccicheck warning:
> 
> drivers/net/wireless/realtek/rtlwifi/base.c:508:13-41: WARNING:
> Comparison of 0/1 to bool variable
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Patch applied to wireless-drivers-next.git, thanks.

fb1a9fc550cf rtlwifi: use true,false for bool variable in rtl_init_rfkill()

-- 
https://patchwork.kernel.org/patch/11510335/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
