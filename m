Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE2FC50BC6
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2019 15:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730723AbfFXNUk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jun 2019 09:20:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34982 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbfFXNUj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jun 2019 09:20:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D943C60A33; Mon, 24 Jun 2019 13:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561382438;
        bh=nFbdjS9mIBi+l74pnUkTQvtrYWuHVCczzVcOmfPyQGI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=N9CTco/1TNso0d/bNHY1pu7XzxZaNyzwsWqDsEo6qS0vfzHAEcvaGFYXoCInzw8hP
         fvxzfCfDkH5j5H+ju1W4U6ikXVYVFb/G4MhI0q53/BPCxZopTiUNj19gRLPDJbH/B4
         dlsdviFOrcA6m07V7uooodfVQn9t/dAQe8Cip+Gw=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 66E62607DE;
        Mon, 24 Jun 2019 13:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561382438;
        bh=nFbdjS9mIBi+l74pnUkTQvtrYWuHVCczzVcOmfPyQGI=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=fW99x9W7cqieE1syVBMwdF87T/GYVc8htnibQE3I/I1aQFAwOyC0lrrdAmwUpm2BS
         FJuYVvJe/tPOeIhe18FItULBN0cCkRxuFGN2mSUhEi27y9w4yKOPdgZAiQYR4TLva7
         1OiZpnlv/anOFIZUHhOErFmFeYv8oT0hznm0+7Nk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 66E62607DE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/3] iwlwifi: add new cards for 22000 and change wrong
 structs
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190619175902.16053-1-luca@coelho.fi>
References: <20190619175902.16053-1-luca@coelho.fi>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org,
        Ihab Zhaika <ihab.zhaika@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190624132038.D943C60A33@smtp.codeaurora.org>
Date:   Mon, 24 Jun 2019 13:20:38 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Ihab Zhaika <ihab.zhaika@intel.com>
> 
> add few PCI ID'S for 22000 and chainge few cards structs names
> 
> Signed-off-by: Ihab Zhaika <ihab.zhaika@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

Patch applied to wireless-drivers.git, thanks.

a976bfb44bdb iwlwifi: add new cards for 22000 and change wrong structs

-- 
https://patchwork.kernel.org/patch/11004991/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

