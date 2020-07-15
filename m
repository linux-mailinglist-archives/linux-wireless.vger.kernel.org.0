Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205DB220863
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2020 11:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbgGOJOL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jul 2020 05:14:11 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:40118 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730195AbgGOJOJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jul 2020 05:14:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594804448; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=GRTuG2zSQXreG8H4pH5m/X55HMkiymrlS19uFqhJn94=;
 b=ncIltNk9oVHdzIQ3I2ktPS1REoriJa1mGYqLRANmZjCWe4gUPG5mW9nPmnVUbXlbIvLneL/v
 hy0QI4eR9Iv+EItZ0iaxC+0XDi8uYB+5chETL+vsEhwLkTqjL4JY4Q+hiSxaIZRgnFCfxQGg
 Refh4r50yj2aWg0ilLI+vHQSxRw=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f0ec8b22991e765cd5b8d48 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 15 Jul 2020 09:13:22
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DE825C433CB; Wed, 15 Jul 2020 09:13:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EBCC4C433C9;
        Wed, 15 Jul 2020 09:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EBCC4C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mwifiex: Fix reporting 'operation not supported' error
 code
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200703112151.18917-1-pali@kernel.org>
References: <20200703112151.18917-1-pali@kernel.org>
To:     =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200715091321.DE825C433CB@smtp.codeaurora.org>
Date:   Wed, 15 Jul 2020 09:13:21 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pali Rohár <pali@kernel.org> wrote:

> ENOTSUPP (double PP) is internal linux kernel code 524 available only in
> kernel include file linux/errno.h and not exported to userspace.
> 
> EOPNOTSUPP (OP; double PP) is standard code 95 for reporting 'operation not
> supported' available via kernel include file uapi/asm-generic/errno.h.
> 
> ENOTSUP (single P) is alias for EOPNOTSUPP defined only in userspace
> include file bits/errno.h and not available in kernel.
> 
> Because Linux kernel does not support ENOTSUP (single P) and because
> userspace does not support ENOTSUPP (double PP), report error code for
> 'operation not supported' via EOPNOTSUPP macro.
> 
> This patch fixes problem that mwifiex kernel driver sends to userspace
> unsupported error codes like: "failed: -524 (No error information)".
> After applying this patch userspace see: "failed: -95 (Not supported)".
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Acked-by: Ganapathi Bhat <ganapathi.bhat@nxp.com>

Patch applied to wireless-drivers-next.git, thanks.

9187f4e84092 mwifiex: Fix reporting 'operation not supported' error code

-- 
https://patchwork.kernel.org/patch/11641737/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

