Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFB93199DF
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Feb 2021 07:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhBLGMy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Feb 2021 01:12:54 -0500
Received: from so15.mailgun.net ([198.61.254.15]:38191 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229701AbhBLGMr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Feb 2021 01:12:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613110349; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=NS+j9B8F4UbvzG79z6s402dP/vEhbKM4061Z8Tc+74w=; b=oglDq3B3eyCLPtqwUuGpGdUHBGAV+7kUcW5xA0Drxh/6fJ55hlLtc0Di6iIJi4M3sFKBUwep
 PBOnfEjyUs+sPGoiTz/JtEfkwHCLL7S9+zaw1mzaaSAyrH7b/9TiGsLza5IGuAJPvVGrBMzM
 TqLqoH6r7jat8uBchjmcEkrvZ0U=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 60261c2be4842e91289980e1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 12 Feb 2021 06:11:55
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1D3CAC433ED; Fri, 12 Feb 2021 06:11:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 74E4FC433CA;
        Fri, 12 Feb 2021 06:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 74E4FC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] iwlwifi: remove incorrect comment in pnvm
References: <iwlwifi.20210211223049.40d545a0fa89.I04793aaa5312b926335c8db32131f000432df511@changeid>
Date:   Fri, 12 Feb 2021 08:11:51 +0200
In-Reply-To: <iwlwifi.20210211223049.40d545a0fa89.I04793aaa5312b926335c8db32131f000432df511@changeid>
        (Luca Coelho's message of "Thu, 11 Feb 2021 22:30:55 +0200")
Message-ID: <87o8gpstlk.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Luca Coelho <luciano.coelho@intel.com>
>
> We use this driver as a backport that also runs on older kernels (as
> part of the backports project).  So we use some checks to backport or
> prevent code from compiling in incompatible kernel version.
>
> When I took one of the PNVM patches from the backport, I accidentally
> left the comment that a certain part of the code doesn't work in older
> kernels.  This obviously should never be valid for the mainline.
> Remove this comment.
>
> Reported-by: Kalle Valo <kvalo@codeaurora.org>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

Thanks, I assigned this to myself on patchwork and apply directly to
wireless-drivers-next.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
