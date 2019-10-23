Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E98DBE1806
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2019 12:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404487AbfJWKcW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Oct 2019 06:32:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38782 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404332AbfJWKcW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Oct 2019 06:32:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C640060D74; Wed, 23 Oct 2019 10:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571826742;
        bh=Vr3Ti+yqOdVbPPkqbfxwtvP0DpKD+iIYNCkyt5fUdB8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=W/9BWNRXdzAGwCF3sxAZHy7gg+jiFd1mAmujJIUvnMnKHhREThOpxOZCSgIBx21Fm
         LpZQ1BNZZa+e1zauKEhZ9R+3owp4j6XbhZv779ovcm/QjiM8VBxEdaZuco15WTgWez
         MCrd4Ls0xTFsmNjCGpqiEFzbYEcipe+e4/zAXL2o=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4FE3C601EA;
        Wed, 23 Oct 2019 10:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571826741;
        bh=Vr3Ti+yqOdVbPPkqbfxwtvP0DpKD+iIYNCkyt5fUdB8=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=VIS0hrcgIgu103w78JuXCn6L7hJD+n+9QzgrjOv91niHSj8M+n34V072a3C8k5O1D
         09Nav4wupY98WLtYG7eB9BZXtva7M2l5858G/OBTtWUFACfOh+0o6NBMAG7SzlcpAb
         MXAo28sgW6/46Aex8IaWO7RAGDjDOKOn+QK/sj3M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4FE3C601EA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] iwlwifi: pcie: fix PCI ID 0x2720 configs that should
 be soc
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191019100331.21322-2-luca@coelho.fi>
References: <20191019100331.21322-2-luca@coelho.fi>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191023103221.C640060D74@smtp.codeaurora.org>
Date:   Wed, 23 Oct 2019 10:32:21 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Luca Coelho <luciano.coelho@intel.com>
> 
> Some entries for PCI ID 0x2720 were using iwl9260_2ac_cfg, but the
> correct is to use iwl9260_2ac_cfg_soc.  Fix that.
> 
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

5 patches applied to wireless-drivers.git, thanks.

6dea7da7019a iwlwifi: pcie: fix PCI ID 0x2720 configs that should be soc
e55890150a96 iwlwifi: pcie: fix all 9460 entries for qnj
91cf5dede57f iwlwifi: mvm: handle iwl_mvm_tvqm_enable_txq() error return
9a47cb988338 iwlwifi: pcie: add workaround for power gating in integrated 22000
17c216ed6b9e iwlwifi: pcie: 0x2720 is qu and 0x30DC is not

-- 
https://patchwork.kernel.org/patch/11200077/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

