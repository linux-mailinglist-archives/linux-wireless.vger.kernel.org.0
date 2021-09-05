Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A68400E65
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Sep 2021 08:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbhIEGNN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Sep 2021 02:13:13 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:50370 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbhIEGNN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Sep 2021 02:13:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630822330; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=ECiXLk/29oWzHj/i402TCaubZLema0VXpywFNl85Os4=;
 b=Sbtgs0lQE0WgYYZ0t+1cK/7cHjWTEEkY32wcL58DgO2r3fkpvUj59fd5G3XP/xbq9udg74RW
 dJATRRBReNiyixxtE/jnZcEAR4Dj70qN+BQtzB+35Z/OPnB4Tl1hoCvGAQ7i8Ksu37q5wo44
 pNNh/mkdWe7TpRPWd/ddbXmKuLE=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 61345f8f1567234b8c99f677 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 05 Sep 2021 06:11:27
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8B6F9C43618; Sun,  5 Sep 2021 06:11:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0EE14C4338F;
        Sun,  5 Sep 2021 06:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 0EE14C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] iwlwifi: pnvm: Fix a memory leak in
 'iwl_pnvm_get_from_fs()'
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1b5d80f54c1dbf85710fd285243932943b498fe7.1630614969.git.christophe.jaillet@wanadoo.fr>
References: <1b5d80f54c1dbf85710fd285243932943b498fe7.1630614969.git.christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     luciano.coelho@intel.com, davem@davemloft.net, kuba@kernel.org,
        johannes.berg@intel.com, pierre-louis.bossart@linux.intel.com,
        drorx.moshe@intel.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210905061126.8B6F9C43618@smtp.codeaurora.org>
Date:   Sun,  5 Sep 2021 06:11:26 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> A firmware is requested but never released in this function. This leads to
> a memory leak in the normal execution path.
> 
> Add the missing 'release_firmware()' call.
> Also introduce a temp variable (new_len) in order to keep the value of
> 'pnvm->size' after the firmware has been released.
> 
> Fixes: cdda18fbbefa ("iwlwifi: pnvm: move file loading code to a separate function")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> Acked-by: Luca Coelho <luca@coelho.fi>

Patch applied to wireless-drivers.git, thanks.

45010c080e6e iwlwifi: pnvm: Fix a memory leak in 'iwl_pnvm_get_from_fs()'

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1b5d80f54c1dbf85710fd285243932943b498fe7.1630614969.git.christophe.jaillet@wanadoo.fr/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

