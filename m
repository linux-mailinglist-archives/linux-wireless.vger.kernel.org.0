Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C4132555F
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Feb 2021 19:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhBYSXr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Feb 2021 13:23:47 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:39064 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232203AbhBYSXo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Feb 2021 13:23:44 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614277405; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=rc1CpEriyvyUZwq+kn5lMS6tGd6kx5KStb8LN33yHr4=; b=w80Z0uV0AiSv9bKrvRBsI8RBE89q2F0mzu30v0d9/afMlogqZUgkwxIlHOvKucMg1y18j8sY
 UfMiV3CcchXtW8frijmzVuHUK5iRwW9D1fAWe7vdLGz+FJscgV4luQY/7Bls2E+lLhiydTYu
 aCzaOm2tiaofYVnR61qk8q7jibw=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 6037eb18ba1dc15780d74280 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 25 Feb 2021 18:23:20
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EFA97C43461; Thu, 25 Feb 2021 18:23:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3C903C433CA;
        Thu, 25 Feb 2021 18:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3C903C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, rdunlap@infradead.org,
        luciano.coelho@intel.com
Subject: Re: [PATCH 5.12] iwlwifi: pcie: fix iwl_so_trans_cfg link error when CONFIG_IWLMVM is disabled
References: <1614236661-20274-1-git-send-email-kvalo@codeaurora.org>
Date:   Thu, 25 Feb 2021 20:23:14 +0200
In-Reply-To: <1614236661-20274-1-git-send-email-kvalo@codeaurora.org> (Kalle
        Valo's message of "Thu, 25 Feb 2021 09:04:21 +0200")
Message-ID: <878s7cdn1p.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> Randy reported an error on his randconfig builds:
>
> ERROR: modpost: "iwl_so_trans_cfg" [drivers/net/wireless/intel/iwlwifi/iwlwifi.ko] undefined!
>
> The problem was that when CONFIG_IWLMVM was disabled we were still accessing
> iwl_so_trans_cfg. Fix it by moving IS_ENABLED() check before the access.
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Fixes: 930be4e76f26 ("iwlwifi: add support for SnJ with Jf devices")

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
