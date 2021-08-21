Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1AB3F3B9A
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Aug 2021 19:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhHURQR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Aug 2021 13:16:17 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:56601 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbhHURQJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Aug 2021 13:16:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629566130; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=0gqoEThOkZsqmH6ayiZE8s8BcSpuWG8/rDIVo7PX22g=;
 b=eXHr8y6qv3W3DCWkmGMgOMgOvmoC+RYsoAALBoE3DVF11T0CvSLz4UfMrtqYDU2Naz4DBCeX
 1vT4EtWOEe7JMqFBit2nfDnWoIdqlm8ab8ZgRWpjOFkNAXbypoXQGiACMS+HMlZAP86uxP2u
 7zcEeQRpG5rECKIE+RsMt1UNRro=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 612134ada2d1fbf62b21a14f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 21 Aug 2021 17:15:25
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7F430C4338F; Sat, 21 Aug 2021 17:15:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F2A7FC4338F;
        Sat, 21 Aug 2021 17:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org F2A7FC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ipw2x00: Use struct_size helper instead of open-coded
 arithmetic
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210717142513.5411-1-len.baker@gmx.com>
References: <20210717142513.5411-1-len.baker@gmx.com>
To:     Len Baker <len.baker@gmx.com>
Cc:     Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Len Baker <len.baker@gmx.com>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210821171524.7F430C4338F@smtp.codeaurora.org>
Date:   Sat, 21 Aug 2021 17:15:24 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Len Baker <len.baker@gmx.com> wrote:

> Dynamic size calculations (especially multiplication) should not be
> performed in memory allocator function arguments due to the risk of them
> overflowing. This could lead to values wrapping around and a smaller
> allocation being made than the caller was expecting. Using those
> allocations could lead to linear overflows of heap memory and other
> misbehaviors.
> 
> To avoid this scenario, use the struct_size helper.
> 
> Signed-off-by: Len Baker <len.baker@gmx.com>

Patch applied to wireless-drivers-next.git, thanks.

6f78f4a41ee0 ipw2x00: Use struct_size helper instead of open-coded arithmetic

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210717142513.5411-1-len.baker@gmx.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

