Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6361D19F8
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2020 17:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgEMPyq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 May 2020 11:54:46 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:60774 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728678AbgEMPyq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 May 2020 11:54:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589385285; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=9nLOC/dBRnoxqzo7ADPSEzrZAZHibC7vaPbTf+EANks=;
 b=rmtC+NJYSkG2nG0mT2Op9H6qXhxfoCw0Gaksbi3GcJCzHcZPhH2neR9s/JwYazSEamQ+HuUt
 XKwm4x2ldUmWxPQH0o5NIzipfsJX0saERqhZ697byX2wjqysYay3M/P1P1IdMlrgOccN9A7n
 1jd/G9MAovsi0x9Gk5KXSTrZwJs=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebc1843.7feb8c773a08-smtp-out-n02;
 Wed, 13 May 2020 15:54:43 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C957DC433D2; Wed, 13 May 2020 15:54:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 75BD0C433F2;
        Wed, 13 May 2020 15:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 75BD0C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: 8723d: fix sparse warnings for power tracking
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200512103534.5889-1-yhchuang@realtek.com>
References: <20200512103534.5889-1-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200513155443.C957DC433D2@smtp.codeaurora.org>
Date:   Wed, 13 May 2020 15:54:43 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> sparse warnings: (new ones prefixed by >>)
> 
> >> drivers/net/wireless/realtek/rtw88/rtw8723d.c:1899:6: sparse: sparse:
> symbol 'rtw8723d_pwr_track' was not declared. Should it be static?
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

0c4402385ac4 rtw88: 8723d: fix sparse warnings for power tracking

-- 
https://patchwork.kernel.org/patch/11542931/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
