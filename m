Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE27313095
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Feb 2021 12:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbhBHLU0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Feb 2021 06:20:26 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:62168 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233121AbhBHLSF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Feb 2021 06:18:05 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612783068; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=cNsLA6CAKDP2Rsw/KNOSGLW6Wt1ijLDYujjW4wCcEdQ=;
 b=AB7cEFNwHLOzSWTfwDokpS9DtzYRK9LbBgiXQxlY9NK71L10nfqgS6wZL/4EvUBHm4qJTWhc
 x3d6tMM0/DkWLUsnP8Me0fRji3fMy1glISGFH/cxSnXbQO80JmqpTLoyF7GBdCO1VsrA2i5e
 ur1jWPUk3FVXVvdwZDWHkr78o/s=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60211dadf112b7872c4021ad (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 08 Feb 2021 11:17:01
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 038CDC433ED; Mon,  8 Feb 2021 11:17:01 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2F5F7C433C6;
        Mon,  8 Feb 2021 11:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2F5F7C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] rtl8xxxu: remove unused assignment value
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210130072310.17252-1-samirweng1979@163.com>
References: <20210130072310.17252-1-samirweng1979@163.com>
To:     samirweng1979 <samirweng1979@163.com>
Cc:     Jes.Sorensen@gmail.com, davem@davemloft.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        wengjianfeng <wengjianfeng@yulong.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210208111701.038CDC433ED@smtp.codeaurora.org>
Date:   Mon,  8 Feb 2021 11:17:01 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

samirweng1979 <samirweng1979@163.com> wrote:

> From: wengjianfeng <wengjianfeng@yulong.com>
> 
> at first, ret was assigned to zero, but later assigned to
> a funciton,so the assignment to zero is no use, which can
> simple be removed instead.
> 
> Signed-off-by: wengjianfeng <wengjianfeng@yulong.com>

Patch applied to wireless-drivers-next.git, thanks.

199276b9bcef rtl8xxxu: remove unused assignment value

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210130072310.17252-1-samirweng1979@163.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

