Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2B02AA31A
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Nov 2020 08:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgKGH53 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Nov 2020 02:57:29 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:41382 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727242AbgKGH52 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Nov 2020 02:57:28 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604735848; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=XX2WXRQG/bEFSIQ05Lin7fjFrmnojryzZMmogjJwKjk=;
 b=dq4aLYzHn+28f3gxk4O/YvKEiR9UA9HHHbmZN5Z9HFdLtox98yemdjxp324Uq2D0naGEvnFk
 l2mxW19dG8HLaLchfMMYwSyhxGKTD1RWcOWiXEQMY/FBVrM6B5FBiTLBZoCU6dMFBWa31Hf6
 GR1EOLQrMfsWiGst/kRmCSfEcYc=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5fa6534923a1a2b32d29bf43 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 07 Nov 2020 07:56:57
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 62568C433C9; Sat,  7 Nov 2020 07:56:57 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DE6E5C433C6;
        Sat,  7 Nov 2020 07:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE6E5C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: fix compilation warning
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1604507837-29361-1-git-send-email-tamizhr@codeaurora.org>
References: <1604507837-29361-1-git-send-email-tamizhr@codeaurora.org>
To:     Tamizh chelvam <tamizhr@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Tamizh Chelvam <tamizhr@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201107075657.62568C433C9@smtp.codeaurora.org>
Date:   Sat,  7 Nov 2020 07:56:57 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tamizh chelvam <tamizhr@codeaurora.org> wrote:

> This change fixes below compilation warning.
> 
> smatch warnings:
>  drivers/net/wireless/ath/ath10k/mac.c:9125 ath10k_mac_op_set_tid_config() error: uninitialized symbol 'ret'.
> 
> No functional changes. Compile tested only.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Tamizh Chelvam <tamizhr@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

b91626451178 ath10k: fix compilation warning

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1604507837-29361-1-git-send-email-tamizhr@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

