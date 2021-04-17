Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D42363196
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Apr 2021 19:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236765AbhDQRgr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Apr 2021 13:36:47 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:42039 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236692AbhDQRgq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Apr 2021 13:36:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618680980; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=DewB6uui/Am2kjHHHieni4Rg1X3tTTSVqo2vBJ6xLIU=;
 b=qM14NiVPa62748qRoWBOhAgXOwmNWu9VPYboC7NYuGNJ8GGK7d/AS5ku4RbZGXETaNQOwwSt
 MSbOKEU4Rt8sfa3ScLKzWCnxvk2FQM+PYvDRWN87iQ+0u4Chla6tDQmtsl2NbbrI5FKcQszK
 FmTtMcg/4pmGUO4G2flZcA4OGH8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 607b1c87a817abd39a1f46de (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 17 Apr 2021 17:36:07
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 166C8C433F1; Sat, 17 Apr 2021 17:36:07 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5678EC433D3;
        Sat, 17 Apr 2021 17:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5678EC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v2] ipw2x00: potential buffer overflow in
 libipw_wx_set_encodeext()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <YHaoA1i+8uT4ir4h@mwanda>
References: <YHaoA1i+8uT4ir4h@mwanda>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        James Ketrenos <jketreno@linux.intel.com>,
        Jeff Garzik <jgarzik@pobox.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210417173607.166C8C433F1@smtp.codeaurora.org>
Date:   Sat, 17 Apr 2021 17:36:07 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The "ext->key_len" is a u16 that comes from the user.  If it's over
> SCM_KEY_LEN (32) that could lead to memory corruption.
> 
> Fixes: e0d369d1d969 ("[PATCH] ieee82011: Added WE-18 support to default wireless extension handler")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Acked-by: Stanislav Yakovlev <stas.yakovlev@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

260a9ad94467 ipw2x00: potential buffer overflow in libipw_wx_set_encodeext()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/YHaoA1i+8uT4ir4h@mwanda/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

