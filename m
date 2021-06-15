Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2BC3A7F03
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 15:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhFONTK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 09:19:10 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:26077 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhFONTK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 09:19:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623763026; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Mn6nyIhRes4TN6bFvP57pyiLCo8HSXb1369OByUf/mI=;
 b=u9xNOA3iz2HgrBodLPIDVd+rRjzie6YVb2CDKtOCt4hqNQDh7QG6vhiPHKZj9sGkzkT58307
 GGHUYDpESntGBY4E0Da1PtFUn5WreQCdRr5rczShfcEcI7LyfGxlATj4JrBB9Yhy4a6xpbH6
 2125E+G5PT1DVOTyPOp4i9wa9m8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60c8a83ded59bf69ccddb67d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 13:16:45
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CDD41C433D3; Tue, 15 Jun 2021 13:16:44 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2F857C433F1;
        Tue, 15 Jun 2021 13:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2F857C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [1/3] libertas: remove leading spaces before tabs
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1621407345-10625-2-git-send-email-tanghui20@huawei.com>
References: <1621407345-10625-2-git-send-email-tanghui20@huawei.com>
To:     Hui Tang <tanghui20@huawei.com>
Cc:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tanghui20@huawei.com>, Ganapathi Bhat <ganapathi.bhat@nxp.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210615131644.CDD41C433D3@smtp.codeaurora.org>
Date:   Tue, 15 Jun 2021 13:16:44 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hui Tang <tanghui20@huawei.com> wrote:

> There are a few leading spaces before tabs and remove it by running the
> following commard:
> 
> 	$ find . -name '*.c' | xargs sed -r -i 's/^[ ]+\t/\t/'
> 	$ find . -name '*.h' | xargs sed -r -i 's/^[ ]+\t/\t/'
> 
> Cc: Ganapathi Bhat <ganapathi.bhat@nxp.com>
> Signed-off-by: Hui Tang <tanghui20@huawei.com>

3 patches applied to wireless-drivers-next.git, thanks.

bd65fe550973 libertas: remove leading spaces before tabs
084eb606dbcf rt2x00: remove leading spaces before tabs
7b7362ba27a2 wlcore: remove leading spaces before tabs

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1621407345-10625-2-git-send-email-tanghui20@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

