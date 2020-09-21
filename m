Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21DC2724CA
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Sep 2020 15:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgIUNLb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Sep 2020 09:11:31 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:35905 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbgIUNLX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Sep 2020 09:11:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600693882; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=RnNXoGJCqQ4mueFmIJRmRFdNcp/CeeC7DGPBkDYuxBU=;
 b=dB7DSMGsGCpkuc3H9U3LpispRbLlBzyuT3rPsW2KGS08vTsvVsUnv/6SCJGlxYLnJ721jbkh
 nP4oWq2kmrvvwNYuC0RBfN3xKviYmhytNF0/+wc2aDFk+HQml+r+Qe7YAT2QAOkzqnTT+E9C
 bowt9L+EB50gtx+pZzkxZuglvWQ=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f68a440f1e3eb89c70a057f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 21 Sep 2020 13:01:52
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6DFE8C433CA; Mon, 21 Sep 2020 13:01:51 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 94FE4C433C8;
        Mon, 21 Sep 2020 13:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 94FE4C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ssb: Remove meaningless jump label to simplify the code
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200915020330.96067-1-jingxiangfeng@huawei.com>
References: <20200915020330.96067-1-jingxiangfeng@huawei.com>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc:     <m@bues.ch>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jingxiangfeng@huawei.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200921130151.6DFE8C433CA@smtp.codeaurora.org>
Date:   Mon, 21 Sep 2020 13:01:51 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jing Xiangfeng <jingxiangfeng@huawei.com> wrote:

> The out jump label has nothing to do. So remove it to simplify the code.
> 
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>

Patch applied to wireless-drivers-next.git, thanks.

41650c45fbd2 ssb: Remove meaningless jump label to simplify the code

-- 
https://patchwork.kernel.org/patch/11775319/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

