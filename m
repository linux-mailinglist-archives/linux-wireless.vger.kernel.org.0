Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1588FE17F2
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2019 12:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404448AbfJWK3p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Oct 2019 06:29:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35926 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391067AbfJWK3m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Oct 2019 06:29:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8DD45609DD; Wed, 23 Oct 2019 10:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571826581;
        bh=z4intaI4GGy+Ezfoxd0Jj1d1aTHxxla8MnjHpbrLwq8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=eTXD0/hYhLRkQCV9MvWWByT4guug4HAeIPC6KKEJo8CZo36yKBCSH6LYLn9JxBBHq
         DJ+JEc2LXIHlh8/H1z31rbEM8McNm3BPPeiFMEcCqdhMMU+lediW8GMBUrPJoOgsXI
         wYVPMUGylG/J+aN4ndyl9cowwRGxuHyGbbyWFIHI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (unknown [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E41D560930;
        Wed, 23 Oct 2019 10:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571826580;
        bh=z4intaI4GGy+Ezfoxd0Jj1d1aTHxxla8MnjHpbrLwq8=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=R4VMQWDp8u8frK6GQjU4vW+nhg4iKnFe9ebr6gEtafB/z6tSerlvAIGP+7taP7KV8
         QjFp5hnERBZm0EMgt5wMyvDAPw2OkjI+l9KsVoascbQazgBwj0FAPxsVA2hsyi2o8e
         KWS/vJRhAhvFmEnNwfenj6KZTKtmH3pjoh0/PPlY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E41D560930
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5.4] iwlwifi: pcie: fix merge damage on making QnJ
 exclusive
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191018104748.37249e76f17d.Id28ce460f03b8bac50e05d648e8ac15d32d6f14d@changeid>
References: <20191018104748.37249e76f17d.Id28ce460f03b8bac50e05d648e8ac15d32d6f14d@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191023102941.8DD45609DD@smtp.codeaurora.org>
Date:   Wed, 23 Oct 2019 10:29:41 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Luca Coelho <luciano.coelho@intel.com>
> 
> Two patches were sent out of order: one removed some conditions from
> an if and the other moved the code elsewhere.  When sending the patch
> that moved the code, an older version of the original code was moved,
> causing the "make QnJ exclusive" code to be essentially undone.
> 
> Fix that by removing the inclusive conditions from the check again.
> 
> Fixes: 809805a820c6 ("iwlwifi: pcie: move some cfg mangling from trans_pcie_alloc to probe")
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

Patch applied to wireless-drivers.git, thanks.

7cded5658329 iwlwifi: pcie: fix merge damage on making QnJ exclusive

-- 
https://patchwork.kernel.org/patch/11197655/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

