Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CABA350BBE
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2019 15:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbfFXNTz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jun 2019 09:19:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34050 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbfFXNTy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jun 2019 09:19:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 06E7860CED; Mon, 24 Jun 2019 13:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561382393;
        bh=7CiXJb+hnJN28jGPrcuyzq7dXaep2XAJltvqrZeZ8Ck=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Zl42+7T6tV2KF/mBOWKZBFN9ereXzZLP52rYtlSQg1ioftAMHp3qk+ci6rgmENzLQ
         pdql8x5xrIh7a+fjG7UGiruR77sw0SPlnUMCzZ01NMX0xqBFwVCsS5Cci4XITqc8gI
         X1QwM5GrMZV43eLjBJrrwg8WcWUmZq1JCQdQb7OE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AC69F60CEC;
        Mon, 24 Jun 2019 13:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561382391;
        bh=7CiXJb+hnJN28jGPrcuyzq7dXaep2XAJltvqrZeZ8Ck=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=DDqLVdUSrgPLM4FfelSMostQu6Jck9ardoaX5vsx5XuUNe9K1Iwe+eBQ+7F1olEo6
         KtsUizqUKH1/a0Af+lyWusq3WzrQeUxzJFBCfGD/GcOnB6fKMvE07BNgxW1tJ1Q2pl
         OGoo05oqzQxepJ+F843XUJ7S2A2Me/SOk/MRaP8I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AC69F60CEC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] iwlwifi: add new cards for 22000 and fix struct name
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190614084852.386-2-luca@coelho.fi>
References: <20190614084852.386-2-luca@coelho.fi>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org,
        Ihab Zhaika <ihab.zhaika@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190624131953.06E7860CED@smtp.codeaurora.org>
Date:   Mon, 24 Jun 2019 13:19:52 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Ihab Zhaika <ihab.zhaika@intel.com>
> 
> add few PCI ID'S for 22000 and fix the wrong name for one
> of the structs
> 
> Signed-off-by: Ihab Zhaika <ihab.zhaika@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

Patch applied to wireless-drivers.git, thanks.

d151b0a2efa1 iwlwifi: add new cards for 22000 and fix struct name

-- 
https://patchwork.kernel.org/patch/10994725/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

