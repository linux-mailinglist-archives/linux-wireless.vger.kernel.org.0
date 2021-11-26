Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D3D45F187
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Nov 2021 17:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378669AbhKZQSc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Nov 2021 11:18:32 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:32781 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232901AbhKZQQb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Nov 2021 11:16:31 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637943197; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=/Yjcpjn/MmG0DyWxUT6Ze3r1NBhS3uCi+i0e0IPmDYY=;
 b=lK+eRAPcLctuBYFKw5BxNqIZijvNIYdF1l2COpnlXIpz+pbFnhKg4Gcz+akOEkMp9oK5sOGu
 FWIb42fohQ5SIjS/w3qdFr2VU3USrNQKxlcV6v5xVyhGUhHLQjbFE05o6she8J7+VtJRfmAx
 hgbV0IGH9yQpUR3EU5KWjIw+Io4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 61a1079a135a8a9d0e979a25 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Nov 2021 16:13:14
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BC6FFC4360D; Fri, 26 Nov 2021 16:13:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6AC54C4338F;
        Fri, 26 Nov 2021 16:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 6AC54C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw89: fix potentially access out of range of RF register
 array
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211119055729.12826-1-pkshih@realtek.com>
References: <20211119055729.12826-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <dan.carpenter@oracle.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163794318856.10370.13417278834028282033.kvalo@codeaurora.org>
Date:   Fri, 26 Nov 2021 16:13:13 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The RF register array is used to help firmware to restore RF settings.
> The original code can potentially access out of range, if the size is
> between (RTW89_H2C_RF_PAGE_SIZE * RTW89_H2C_RF_PAGE_NUM + 1) to
> ((RTW89_H2C_RF_PAGE_SIZE + 1) * RTW89_H2C_RF_PAGE_NUM). Fortunately,
> current used size doesn't fall into the wrong case, and the size will not
> change if we don't update RF parameter.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

30101812a09b rtw89: fix potentially access out of range of RF register array

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211119055729.12826-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

