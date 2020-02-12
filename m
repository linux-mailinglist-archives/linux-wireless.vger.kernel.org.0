Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 984EF15AC9D
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2020 17:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgBLQDU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Feb 2020 11:03:20 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:20698 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726728AbgBLQDU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Feb 2020 11:03:20 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581523399; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=C6l9Cr80nZ5gkO/MxE7gy+ir7uQMQ4f7SqzlmFppX78=;
 b=m8n+wgAmQb41pxxxEZsx+qazcABDPGXU4hvrxXiDwJocDbY5qxd4+krfVx9Q1smQxxb9Zf3V
 r42/lvhM+ODsRDDwtVP28mVUJ0OaNmTCN9DAS4iuoMIHA1zlXqobetJK1blaf/zgN6TGAbvz
 oG5xMsQJ97dunSrTgMOZLQmq0aY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4421c6.7fed242d5ed8-smtp-out-n01;
 Wed, 12 Feb 2020 16:03:18 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A59BEC4479C; Wed, 12 Feb 2020 16:03:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5FABBC43383;
        Wed, 12 Feb 2020 16:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5FABBC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next] rtw88: use kfree_skb() instead of kfree()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200203024801.177044-1-weiyongjun1@huawei.com>
References: <20200203024801.177044-1-weiyongjun1@huawei.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Chin-Yen Lee <timlee@realtek.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-wireless@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200212160318.A59BEC4479C@smtp.codeaurora.org>
Date:   Wed, 12 Feb 2020 16:03:18 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wei Yongjun <weiyongjun1@huawei.com> wrote:

> Use kfree_skb() instead of kfree() to free sk_buff.
> 
> Fixes: b6c12908a33e ("rtw88: Add wowlan net-detect support")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Dan already submitted identical patch:
https://patchwork.kernel.org/patch/11356627/

Patch set to Superseded.

-- 
https://patchwork.kernel.org/patch/11361999/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
