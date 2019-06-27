Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 827835884C
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2019 19:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfF0R1m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jun 2019 13:27:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35738 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfF0R1m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jun 2019 13:27:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 21EE260A05; Thu, 27 Jun 2019 17:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561656461;
        bh=VRk9qBciVUNq6SNdf+gpzwb0SXyzLl2g2xB29SM7dG4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=K+grF9Um4X4adiBgVcMy5V8cudv1GnsFzD0aiDqAFjmI+rv0g8w/4/d6mvDlgJf70
         tcPobkS7LqdkRmcAj7QkB+VXvaCBgeMC1KLb710y+V1uUFADa8zkZ1D+hKtLICbFnd
         zePX2RF6D0ouTW2ogBFSdOuCuuhN/fEDbSvi8jkQ=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 053E46016D;
        Thu, 27 Jun 2019 17:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561656460;
        bh=VRk9qBciVUNq6SNdf+gpzwb0SXyzLl2g2xB29SM7dG4=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=O62Bhd6QfWbg/FjjzkjOR7W9HqMUHPdKW8+yVkzLohTY1/sMd2fHANLFXxEA6BZah
         JM9o6ZVlQX6VkJhvZHSABMpdKc+/jyn8Q7eG3bCQxdk+FHd9jiZ6AnUZMblWQTLVFH
         SsWnVBiGm7w0/PtmX7CpKCvRySIxokAB46CQDzIU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 053E46016D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/11] rtw88: resolve order of tx power setting routines
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1559116487-5244-2-git-send-email-yhchuang@realtek.com>
References: <1559116487-5244-2-git-send-email-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190627172741.21EE260A05@smtp.codeaurora.org>
Date:   Thu, 27 Jun 2019 17:27:41 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> Some functions that should be static are unnecessarily exposed, remove
> their declaration in header file phy.h.
> 
> After resolving their declaration order, they can be declared as static.
> So this commit changes nothing except the order and marking them static.
> 
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

10 patches applied to wireless-drivers-next.git, thanks.

fa6dfe6bff24 rtw88: resolve order of tx power setting routines
226746fd1201 rtw88: do not use (void *) as argument
43712199e05b rtw88: unify prefixes for tx power setting routine
522801493e7b rtw88: remove unused variable
764038160aea rtw88: fix incorrect tx power limit at 5G
adf3c676d1d2 rtw88: choose the lowest as world-wide power limit
93f68a865f11 rtw88: correct power limit selection
191c4257ba19 rtw88: update tx power limit table to RF v20
0d350f0a91f2 rtw88: remove all RTW_MAX_POWER_INDEX macro
b741422218ef rtw88: refine flow to get tx power index

-- 
https://patchwork.kernel.org/patch/10966415/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

