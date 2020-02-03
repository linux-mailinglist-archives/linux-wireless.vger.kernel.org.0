Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0FFD150F22
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2020 19:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgBCSK6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Feb 2020 13:10:58 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:34331 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728319AbgBCSK6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Feb 2020 13:10:58 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580753457; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=3CTvLLzXqTZeONPfPLu31GcM4WwXKq2PqNvyqStAQCE=;
 b=Hz5UnMjdfuc+b1Gq6mLjbR/28ETXVZMEbnlcEEk/AKHbXVeJmACzDfdcWUk3gis19I4Azb/f
 39rV4ZzQbkno9Sf+P5HmaTXxZz9O2pdo43FaohSlppwrZR6sRlqj6vNr6yYaf+uwwYyTRpzc
 g5DMTU4lkbZdcZxX1T5pDwKFqps=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e38622b.7f8191e13ca8-smtp-out-n02;
 Mon, 03 Feb 2020 18:10:51 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B99E1C4479C; Mon,  3 Feb 2020 18:10:51 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D0563C433CB;
        Mon,  3 Feb 2020 18:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D0563C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5.6] rtw88: Fix return value of rtw_wow_check_fw_status
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200203060157.15330-1-yhchuang@realtek.com>
References: <20200203060157.15330-1-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <natechancellor@gmail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200203181051.B99E1C4479C@smtp.codeaurora.org>
Date:   Mon,  3 Feb 2020 18:10:51 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Chin-Yen Lee <timlee@realtek.com>
> 
> Clang warns that ret is used uninitialzed.
> And we found that actually the return type should be "int" instead
> of "bool".
> 
> Fixes: 44bc17f7f5b3 ("rtw88: support wowlan feature for 8822c")
> Link: https://github.com/ClangBuiltLinux/linux/issues/850
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com> # build

Patch applied to wireless-drivers.git, thanks.

ebe8e6116ac4 rtw88: Fix return value of rtw_wow_check_fw_status

-- 
https://patchwork.kernel.org/patch/11362063/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
