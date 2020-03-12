Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A87A1831CC
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 14:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgCLNlk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 09:41:40 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:34557 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727170AbgCLNlk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 09:41:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584020500; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=kxoYFrKaH3QjFdJNKDoikz6gYrpuvqBs9DEBfaq2kGA=;
 b=o3RKeN9F4+sCaR6iL85+DYNisNU3FszPtR/BSV/FJ4nge70TDMg+iYmuLrDRA+GoLDzglWsi
 QuPv/TaKmiQndh7oFhdLIlW8hJuYK3qyCeNVjdF7niY0dLHPbYuUloR/kzndFlA9MP6fiZTM
 illcnTII/4SL/xnFgv56JHAGGj4=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6a3c13.7fafbb167848-smtp-out-n02;
 Thu, 12 Mar 2020 13:41:39 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 86707C433CB; Thu, 12 Mar 2020 13:41:39 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 96255C433D2;
        Thu, 12 Mar 2020 13:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 96255C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] iwlegacy: Remove unneeded variable ret
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200221104303.3901-1-vulab@iscas.ac.cn>
References: <20200221104303.3901-1-vulab@iscas.ac.cn>
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     stf_xl@wp.pl, davem@davemloft.net, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200312134139.86707C433CB@smtp.codeaurora.org>
Date:   Thu, 12 Mar 2020 13:41:39 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Xu Wang <vulab@iscas.ac.cn> wrote:

> Remove unneeded variable ret used to store return value.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

Patch applied to wireless-drivers-next.git, thanks.

310443268b29 iwlegacy: Remove unneeded variable ret

-- 
https://patchwork.kernel.org/patch/11396229/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
