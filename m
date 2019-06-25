Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA9854FF4
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 15:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbfFYNNb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 09:13:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47302 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbfFYNNa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 09:13:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 051A16085C; Tue, 25 Jun 2019 13:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561468410;
        bh=zjou1/WnfU1huNpIrswarKMERzdgOIeCb4I1Jwojw0s=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=T2Y3/YKse19ubmhp1Ki6L9kh5+lMws1Fk45et9eo9o8fS4eOs/hRZQcB91Vo7lvg6
         ATbReDqutoNK4ucvp0+WHiNg6tNWncu51TKhj9BMspMGsC/0hkbmNnyKQdhPw/Og0j
         DOk1OUe/YFXqUse9o1pMsT7B7TFoJ541HKx1/TeE=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DEA4761633;
        Tue, 25 Jun 2019 13:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561468409;
        bh=zjou1/WnfU1huNpIrswarKMERzdgOIeCb4I1Jwojw0s=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=oTRIOfvoS7WaotVJX8qZtiG3t0LGUk8D+p5AjglO8Cap85dlXqC35oil+XLVi5E5V
         C6eAZ0ymtwzYZblLdaxkjRDod16HsUvFpCWFVc6XIfaqb3E/U/FSfIFYt/Uow0Dfee
         uqnMzxgyABf2blzSAK2LxuAmS0ZsXsH6ppxNtB20=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DEA4761633
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: Add peer delete response event
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1550673001-8779-1-git-send-email-pillair@codeaurora.org>
References: <1550673001-8779-1-git-send-email-pillair@codeaurora.org>
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Dundi Raviteja <dundi@codeaurora.org>,
        Rakesh Pillai <pillair@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190625131330.051A16085C@smtp.codeaurora.org>
Date:   Tue, 25 Jun 2019 13:13:29 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rakesh Pillai <pillair@codeaurora.org> wrote:

> Peer creation in firmware fails if last peer deletion is still
> in progress.
> 
> The firmware sends a peer delete response event if it advertises
> the service WMI_SERVICE_SYNC_DELETE_CMDS. This peer delete response
> event is used to synchronize the peer deletion.
> 
> Add peer delete response event and wait for the event after
> deleting every peer from host driver to synchronize with firmware.
> 
> Tested HW: WCN3990
> Tested FW: WLAN.HL.2.0-01188-QCAHLSWMTPLZ-1
> 
> Signed-off-by: Dundi Raviteja <dundi@codeaurora.org>
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

c6f537a11b81 ath10k: Add peer delete response event

-- 
https://patchwork.kernel.org/patch/10822207/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

