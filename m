Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC145EAB44
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2019 09:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfJaIEm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Oct 2019 04:04:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41648 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfJaIEm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Oct 2019 04:04:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 41FF7603A3; Thu, 31 Oct 2019 08:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572509081;
        bh=6FSo0w7J6mXDh3vIgR3QN1KcGWuCBOF3X6J58rS2AWM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=dHKUD1TfKVcM+jQjW05PMW3OiL6Bg4p+jO2DRn5Z65zgpq/DH20rUQAvJv6FUUGEo
         /b5czR1BR6VpILlYKv0ZLrOIPcSXLcRwmc8I9TBnOYAO7Lj2+sCoosIgk+huaq2Bof
         uZLE6vopP2PR6kROpbmpmUP90ZMne+3YnqEhYp34=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9E3C1603A3;
        Thu, 31 Oct 2019 08:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572509080;
        bh=6FSo0w7J6mXDh3vIgR3QN1KcGWuCBOF3X6J58rS2AWM=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=ejkTqRZnJzMc6ULRZa/hU8LYdkOYPuMwIOlq24q8kovW27M+kN1bECZVUD4BFZ4qj
         3ZMhDGsWIKzD/0ES9TYKTsJIZ26Q7wDzS5nj3C0Opqd0Ndu0/q+wFjM5W4VSH6FDV0
         fINRIn16HYjEWpGKMX8G15hqVgCnQfzYeYysY9aY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9E3C1603A3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/6] rtw88: 8822b: add RFE type 3 support
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191025093345.22643-2-yhchuang@realtek.com>
References: <20191025093345.22643-2-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <g.schlmm@googlemail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191031080441.41FF7603A3@smtp.codeaurora.org>
Date:   Thu, 31 Oct 2019 08:04:41 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> Some of the modules use RFE type 3, add corresponding tables
> for them.
> 
> Tested-by: G.schlmm <g.schlmm@googlemail.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

5 patches applied to wireless-drivers-next.git, thanks.

7436a470b583 rtw88: 8822b: add RFE type 3 support
0b8db87da541 rtw88: use rtw_phy_pg_cfg_pair struct, not arrays
ff0dfe5b0377 rtw88: rearrange if..else statements for rx rate indexes
18a0696e85fd rtw88: fix potential read outside array boundary
5195b9042640 rtw88: avoid FW info flood

-- 
https://patchwork.kernel.org/patch/11211887/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

