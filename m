Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 613B4F1D03
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2019 18:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732455AbfKFR6Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Nov 2019 12:58:25 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37728 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732409AbfKFR6Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Nov 2019 12:58:25 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9A1586092C; Wed,  6 Nov 2019 17:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573063104;
        bh=BDkAFvmpP1pqvsT6Ptd54Z3W97BS25Pu4BZBWg081j8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=KQdk3qrQO/QFwJgsk9+7l9g23W/Dyz6tjw4vi3xfYgWpRMDOInHB/9XAMCfJIj6VJ
         As0qvMV3YmaKrpP0viilXBXmrUYq7CUyjjnoRLcVVmj7kPaqwQf70F+T0uL25AnRXa
         5ikD125pZ+IX06AJI3LnLKBfMO6zvbqpjG06/ILY=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1748260923;
        Wed,  6 Nov 2019 17:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573063102;
        bh=BDkAFvmpP1pqvsT6Ptd54Z3W97BS25Pu4BZBWg081j8=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=B8h1EXJEVIHADkYdPp6KfUPQ4lDWOCsH2wc3lA+/WzIz16khnjBmzK2U9tVdl5uhv
         mMNPcd1v+Zt3VIgrdF+Y/NrFCa4zlcmn6bWqX9eSoyMCJATn9c/1WfQM0sFDCA9Kys
         W3EPkeefOufInrvc6zK+IVANCr1IIqtWAsM5GbqI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1748260923
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: fix potential NULL pointer access for firmware
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191105090442.8378-1-yhchuang@realtek.com>
References: <20191105090442.8378-1-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <dan.carpenter@oracle.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191106175823.9A1586092C@smtp.codeaurora.org>
Date:   Wed,  6 Nov 2019 17:58:23 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> Driver could access a NULL firmware pointer if we don't
> return here.
> 
> Fixes: 5195b90426409 ("rtw88: avoid FW info flood")
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

f530c1961af2 rtw88: fix potential NULL pointer access for firmware

-- 
https://patchwork.kernel.org/patch/11227185/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

