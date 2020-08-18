Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAFE2484F4
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Aug 2020 14:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgHRMmT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Aug 2020 08:42:19 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:53797 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726451AbgHRMmM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Aug 2020 08:42:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597754523; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Y/RDDb3mAt7QvX6HBbapdibqafkKhm7pXFr4Ti4glJk=;
 b=haByhK5J+zLpphj5I2OgP0Gi+1AK99wIdCJQlqajqsHrYpgd5VrXsPX20uuzuqerKKGQSnf8
 LJ4JPfQIUcnr4Xw+IJI0h2NKm9LiZtSPFCpWEvdSGCtaq3PDmPhm705Ppx5cH7bJf229vMYI
 mLwpv9Duhi+aA4bzzXXAKKNrRqg=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5f3bcc8bd96d28d61efbd3e0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 18 Aug 2020 12:41:47
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 27D1DC43391; Tue, 18 Aug 2020 12:41:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 96AC0C433CA;
        Tue, 18 Aug 2020 12:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 96AC0C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] p54: avoid accessing the data mapped to streaming DMA
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200802132949.26788-1-baijiaju@tsinghua.edu.cn>
References: <20200802132949.26788-1-baijiaju@tsinghua.edu.cn>
To:     Jia-Ju Bai <baijiaju@tsinghua.edu.cn>
Cc:     chunkeey@googlemail.com, davem@davemloft.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju@tsinghua.edu.cn>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200818124147.27D1DC43391@smtp.codeaurora.org>
Date:   Tue, 18 Aug 2020 12:41:47 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jia-Ju Bai <baijiaju@tsinghua.edu.cn> wrote:

> In p54p_tx(), skb->data is mapped to streaming DMA on line 337:
>   mapping = pci_map_single(..., skb->data, ...);
> 
> Then skb->data is accessed on line 349:
>   desc->device_addr = ((struct p54_hdr *)skb->data)->req_id;
> 
> This access may cause data inconsistency between CPU cache and hardware.
> 
> To fix this problem, ((struct p54_hdr *)skb->data)->req_id is stored in
> a local variable before DMA mapping, and then the driver accesses this
> local variable instead of skb->data.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju@tsinghua.edu.cn>

Can someone review this?

-- 
https://patchwork.kernel.org/patch/11696391/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

