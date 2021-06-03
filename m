Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E14399DCE
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jun 2021 11:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhFCJcx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Jun 2021 05:32:53 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:14217 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhFCJcw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Jun 2021 05:32:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622712668; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=c5xIgrlxWshRfO3bg2y2nyBdTH28b2MQ4/Vkjfk0pLc=;
 b=vm1034NxDOVb12wzJO0gXsH6aKMeOuU9vvmNZXR8cC91HJUih7KGkO4bCkQZjomTZ3bbiFHQ
 fx/1F2zJcEjIgxEVHKifiBdUTDTnWRq7NFP2BkVjIVhKEU7CRJGkrmNOMX0d1FkQfgD60I9p
 6gv/1YbsH2OB3NL4raMFb3zybUU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60b8a1578491191eb3ca75c3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 03 Jun 2021 09:31:03
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 73322C433D3; Thu,  3 Jun 2021 09:31:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BFBD6C433F1;
        Thu,  3 Jun 2021 09:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BFBD6C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/1] b43: phy_n: Delete some useless TODO code
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210511034203.4122-2-thunder.leizhen@huawei.com>
References: <20210511034203.4122-2-thunder.leizhen@huawei.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        b43-dev <b43-dev@lists.infradead.org>,
        netdev <netdev@vger.kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210603093103.73322C433D3@smtp.codeaurora.org>
Date:   Thu,  3 Jun 2021 09:31:03 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Zhen Lei <thunder.leizhen@huawei.com> wrote:

> These TODO empty code are added by
> commit 9442e5b58edb ("b43: N-PHY: partly implement SPUR workaround"). It's
> been more than a decade now. I don't think anyone who wants to perfect
> this workaround can follow this TODO tip exactly. Instead, it limits them
> to new thinking. Remove it will be better.
> 
> No functional change.
> 
> By the way, this helps reduce some binary code size.
> Before:
> text    data    bss     dec     hex
> 74472   9967    0       84439   149d7
> 
> After:
> text    data    bss     dec     hex
> 74408   9919    0       84327   14967
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Patch applied to wireless-drivers-next.git, thanks.

da16f5be45d0 b43: phy_n: Delete some useless TODO code

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210511034203.4122-2-thunder.leizhen@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

