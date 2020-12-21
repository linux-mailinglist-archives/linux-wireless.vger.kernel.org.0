Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262AA2DFEC2
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Dec 2020 18:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgLURJf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Dec 2020 12:09:35 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:14870 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgLURJf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Dec 2020 12:09:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608570551; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=pGeMzAVRZjV6bmGW6mYo9M0ETpj1teVIb876RuOlJcU=;
 b=xIm+Tu7lQ3WMVEIMlVbjRvC63DSRhwF7R89QMsGMEyy7F1h48fnSWA/8YUiFhFjx/10KIMlN
 kjYjMvqc7EhXyc/L98lKov1r2KBtNtfPZfSedTU0PwOyuc+fVxdi+ErSYbCBBGSesrBozeSF
 qxdkC0ANOLmknK5bYNRcgfvPl+s=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5fe0d68ddb8e07fa6c2c89cc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 21 Dec 2020 17:08:29
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 585A1C433ED; Mon, 21 Dec 2020 17:08:29 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E222FC433CA;
        Mon, 21 Dec 2020 17:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E222FC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] MAINTAINERS: switch to different email address
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201220141807.17278-1-aspriel@gmail.com>
References: <20201220141807.17278-1-aspriel@gmail.com>
To:     Arend van Spriel <aspriel@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <aspriel@gmail.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201221170829.585A1C433ED@smtp.codeaurora.org>
Date:   Mon, 21 Dec 2020 17:08:29 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arend van Spriel <aspriel@gmail.com> wrote:

> Switching to private mail account as work email is polluted with a legal
> disclaimer. Just making it extra clear by changing the email address in
> the MAINTAINERS file as well.
> 
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Arend van Spriel <aspriel@gmail.com>

Patch applied to wireless-drivers.git, thanks.

bfe55584713b MAINTAINERS: switch to different email address

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201220141807.17278-1-aspriel@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

