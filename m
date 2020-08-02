Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7326235821
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Aug 2020 17:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgHBPYA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 11:24:00 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:26424 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726325AbgHBPYA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 11:24:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596381839; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=jV530tqOxRYH07sPXXeVWaBLwTosH6zGUNSa+mEsVps=;
 b=PaFkVCWSV3UytOc+bwIxeiwP/ejgQmBz5ia7O6TaZ3mUL8tQ+ipuifYljIyMruSdwdN4/ALO
 Bd5XvpEvj93k2uvMjj6d1uIRQ6gvOeEjQV0XHjWNBiBJdmUQSktX8gmp6R6ax5yneGmTDhm0
 5b4+11LRaCzPJgFeYOId3lgGAB8=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n16.prod.us-east-1.postgun.com with SMTP id
 5f26da822c24b37bbe135e3f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 02 Aug 2020 15:23:46
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 74F80C43395; Sun,  2 Aug 2020 15:23:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9F524C433C6;
        Sun,  2 Aug 2020 15:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9F524C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 7/9] intersil: fix wiki website url
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200723135254.594984-1-f.suligoi@asem.it>
References: <20200723135254.594984-1-f.suligoi@asem.it>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Flavio Suligoi <f.suligoi@asem.it>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200802152345.74F80C43395@smtp.codeaurora.org>
Date:   Sun,  2 Aug 2020 15:23:45 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Flavio Suligoi <f.suligoi@asem.it> wrote:

> In some Intersil files, the wiki url is still the old
> "wireless.kernel.org" instead of the new
> "wireless.wiki.kernel.org"
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>

Patch applied to wireless-drivers-next.git, thanks.

4dd9e7e08bc3 intersil: fix wiki website url

-- 
https://patchwork.kernel.org/patch/11681025/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

