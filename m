Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7E72CC66E
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Dec 2020 20:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgLBTUN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Dec 2020 14:20:13 -0500
Received: from m42-5.mailgun.net ([69.72.42.5]:45010 "EHLO m42-5.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgLBTUN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Dec 2020 14:20:13 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606936788; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=o7RSe0bRJHV7B9ojKQatbhp6drgmwn6YiumdZ4qe7QI=;
 b=IlL4lWukqoIZ6wsFT6quVefsZwmrKPDeTwLhaeo5nET1DD5qFnF0opeoVVM8OvoGDpBgob2M
 GjqPMTzhfjTn5q5mU5ZN1AILR88d01ViLaPd6XeQuCEPYCFQW/zUcsXHQ0F6LyI3DB/1KxVS
 td6j/AXpoG1GUavvTheiD2MukVg=
X-Mailgun-Sending-Ip: 69.72.42.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5fc7e8cf0b1f6587dd6899ed (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Dec 2020 19:19:43
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7EC37C433C6; Wed,  2 Dec 2020 19:19:43 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5A9F7C433ED;
        Wed,  2 Dec 2020 19:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A9F7C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] Revert "rtl8xxxu: Add Buffalo WI-U3-866D to list of
 supported
 devices"
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201121003411.9450-1-ikegami.t@gmail.com>
References: <20201121003411.9450-1-ikegami.t@gmail.com>
To:     Tokunori Ikegami <ikegami.t@gmail.com>
Cc:     ikegami.t@gmail.com, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201202191943.7EC37C433C6@smtp.codeaurora.org>
Date:   Wed,  2 Dec 2020 19:19:43 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tokunori Ikegami <ikegami.t@gmail.com> wrote:

> This reverts commit 28606150768a20b291a35dbbbb0ab4dd7d4739db.
> Since actually Buffalo WI-U3-866D is falied to power on with the change.
> 
> The rtl8812au driver code to power on is same with the rtl8821a code.
> But the rtl8821ae included rtl8821a does not support USB interface.
> So seems that rtl8812au should be supported by rt1l8821a code with USB.
> 
> Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
> Cc: linux-wireless@vger.kernel.org

Patch applied to wireless-drivers-next.git, thanks.

e220332c3a1a Revert "rtl8xxxu: Add Buffalo WI-U3-866D to list of supported devices"

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201121003411.9450-1-ikegami.t@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

