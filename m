Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4129F324BD7
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Feb 2021 09:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbhBYIOs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Feb 2021 03:14:48 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:45200 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230142AbhBYIOr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Feb 2021 03:14:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614240867; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=mjpCUN75mxBIkE9oG7YOQEDH03kOxOJ1QPxbXjijrOo=; b=VcRCGKnSXsrejslxxJgbUOHsT51yeJpe4LVl3DbQBW19qrKyPrbPd6D4qepvGMm2a5Acvh8H
 04MwSmoJMaLgNSpuVHeiP/1h9V+PovU5/LGLSCr024dRg1wlGQZ+VIaq+niJGleQKBmZzgDs
 Yd3dIrOIzGbuyfhioXAF786DGzg=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60375c47669548ff7a814e71 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 25 Feb 2021 08:13:59
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D0A1CC433C6; Thu, 25 Feb 2021 08:13:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A05B6C433CA;
        Thu, 25 Feb 2021 08:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A05B6C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luca Coelho <luciano.coelho@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: linux-next: Tree for Feb 23 [drivers/net/wireless/intel/iwlwifi/iwlwifi.ko]
References: <20210223173539.049dd40d@canb.auug.org.au>
        <a3f440a5-2178-ffd8-a043-25b18fa42f0f@infradead.org>
Date:   Thu, 25 Feb 2021 10:13:50 +0200
In-Reply-To: <a3f440a5-2178-ffd8-a043-25b18fa42f0f@infradead.org> (Randy
        Dunlap's message of "Tue, 23 Feb 2021 11:52:13 -0800")
Message-ID: <87r1l4ef9d.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> On 2/22/21 10:35 PM, Stephen Rothwell wrote:
>> Hi all,
>> 
>> Please do not add any changes destined for v5.13 to your linux-next
>> included branches until after v5.12-rc1 has been released.
>> 
>> Changes since 20210222:
>> 
>
> Still seeing this build error on x86_64:
>
> ERROR: modpost: "iwl_so_trans_cfg" [drivers/net/wireless/intel/iwlwifi/iwlwifi.ko] undefined!
>
>
> Full randconfig file is attached.

Still? I don't recall seeing this report before, but maybe I have missed
it. Anyway, I sent a fix but it would be great if you can test it:

https://patchwork.kernel.org/project/linux-wireless/patch/1614236661-20274-1-git-send-email-kvalo@codeaurora.org/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
