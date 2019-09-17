Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 634D4B5005
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2019 16:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfIQOKP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Sep 2019 10:10:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49456 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbfIQOKP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Sep 2019 10:10:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5220B6141D; Tue, 17 Sep 2019 14:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568729414;
        bh=xrdKWbHp5KFkkzsKLC1BzPpgWftrm2wfUu5CqMPTaf8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Jyrvi6TpfuBtAE+R/tcU80aHQ9MeoqePLmVD4IFoB3qxtQ113ovT98PIm89nB6M30
         +yWnuBmOlTO8DHcVlwGyYRQeKnQ056eFyPQMgJ/wo88nf2WZcy0ssQwuBZQJ23ikjq
         UpJJfcMO8X127qEJdNremPXfx+eNMJseHCjn1tLI=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 58D95602F3;
        Tue, 17 Sep 2019 14:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568729414;
        bh=xrdKWbHp5KFkkzsKLC1BzPpgWftrm2wfUu5CqMPTaf8=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=NtqQwmYFHQnAjzAt8wC0gZohjveeuwuIHsYb2hgDutfRFyDw6DDPcZW4WXm+lTe5d
         qgSCSWIKkDP2bj1GZEl/seQVTAvCXuc8C7t5X2ANTz1rGScRW2O4sRgoKadHnNwXWO
         mlTa8maadG+PphAgBcNlePDyFprB6dy1deg/Ledg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 58D95602F3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ath10k: use ath10k_pci_soc_ functions for all warm_reset
 instances
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1564305118-3059-1-git-send-email-pozega.tomislav@gmail.com>
References: <1564305118-3059-1-git-send-email-pozega.tomislav@gmail.com>
To:     =?utf-8?q?Tomislav_Po=C5=BEega?= <pozega.tomislav@gmail.com>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190917141014.5220B6141D@smtp.codeaurora.org>
Date:   Tue, 17 Sep 2019 14:10:14 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tomislav Požega wrote:

> Use ath10k_pci_soc_read32 / ath10k_pci_soc_write32 functions for
> the rest of warm_reset functions. Until now these have been used
> only for ath10k_pci_warm_reset_si0, but since they already exist
> it makes sense to simplify code a bit.
> Runtime tested with QCA9862.
> 
> Signed-off-by: Tomislav Požega <pozega.tomislav@gmail.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

9c44bf4c1255 ath10k: use ath10k_pci_soc_ functions for all warm_reset instances

-- 
https://patchwork.kernel.org/patch/11062915/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

