Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB652807CB
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Oct 2020 21:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbgJATeB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Oct 2020 15:34:01 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:37916 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729993AbgJATeA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Oct 2020 15:34:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601580840; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=ORfjMZzpT+P9piuZ9Uc6zYh6lbTSeb5/0mT+qFQKj5U=;
 b=IAwOM2tDGNB65GqvS0PWNV0RypPJmissJ4np822zaJfehRBX73TQm1191J6mSfKW8H/iCF7D
 bzp/SUhDPLcQTQe4Qo3ph9b534D7Bo5u0SmpZBV5S5n88MyEG7t662E5TglFvZuwuXFk4vGL
 2BmfjjBxqLJ5dv7X03Q9TIw/gf4=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f762f20ce84f363c74b10e6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 01 Oct 2020 19:33:52
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 14D2FC433FE; Thu,  1 Oct 2020 19:33:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 11F11C433CA;
        Thu,  1 Oct 2020 19:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 11F11C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/8] ath11k: read and write registers below unwindowed
 address
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1601544890-13450-2-git-send-email-kvalo@codeaurora.org>
References: <1601544890-13450-2-git-send-email-kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201001193352.14D2FC433FE@smtp.codeaurora.org>
Date:   Thu,  1 Oct 2020 19:33:52 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> wrote:

> For QCA6390, host can read and write registers below unwindowed
> address directly without programming the window register. For
> registers below bar0 + 4k - 32, host can read and write regardless
> of the power save state. Shadow registers are located below
> bar0 + 4K - 32.
> 
> Before MHI power up, there is no need to wakeup MHI so ini_done is
> added to indicate it.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> 
> Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

8 patches applied to ath-next branch of ath.git, thanks.

a05bd8513335 ath11k: read and write registers below unwindowed address
e838c14a9ee1 ath11k: enable shadow register configuration and access
9df6d8399d67 ath11k: set WMI pipe credit to 1 for QCA6390
8ec5a6ab9c7e ath11k: start a timer to update TCL HP
506e7e9bbf3f ath11k: start a timer to update REO cmd ring
9b309970c4ea ath11k: start a timer to update HP for CE pipe 4
c83c500b55b6 ath11k: enable idle power save mode
404f5de2f997 ath11k: remove unnecessary casts to u32

-- 
https://patchwork.kernel.org/patch/11811243/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

