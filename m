Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2E67C46A6
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 06:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfJBEe1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Oct 2019 00:34:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48334 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfJBEe1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Oct 2019 00:34:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 82BD06118D; Wed,  2 Oct 2019 04:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569990866;
        bh=wHJyThKok+oZ6Nt2f78hHuDioA//IWZAwkWNezb71oc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=CMQNWiHW7NI5JNrgf/Z9qJTk+md0/xJciKctcJ+dQ4hyoJVjQHlw79vrQi5UV0vsC
         PX5xaahhwPMg3EBonbvKHF3amBsJAIcHmQX/JSehlDotwjJ/QU0+CLW3kQcb828dXj
         DexbopA7UvjFBlb901u0ASqKJl7MbXkUzOYbKs1o=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 619E4602F2;
        Wed,  2 Oct 2019 04:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569990866;
        bh=wHJyThKok+oZ6Nt2f78hHuDioA//IWZAwkWNezb71oc=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=RsOyaqxAx12k2Xd423TqNZvwl4Y79PXGf/qURYschlNE2BzPvHGgQVsJb6kjN/f+l
         R0RguzhTI+98Pd6RNO+JW6+19sXtmxtRTfq7xTjnEzmgEyv5HRzGw9xZchDEIBCRMG
         n/OyAy14/yJTAHR+u+iJ14AvWZhHG0YyXkYqA6nw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 619E4602F2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 01/12] rtw88: remove redundant flag check helper
 function
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191002023128.12090-2-yhchuang@realtek.com>
References: <20191002023128.12090-2-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191002043426.82BD06118D@smtp.codeaurora.org>
Date:   Wed,  2 Oct 2019 04:34:26 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> These helper functions seems useless. And in some cases
> we want to use test_and_[set/clear]_bit, these helpers
> will make the code more complicated. So remove them.
> 
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

12 patches applied to wireless-drivers-next.git, thanks.

3c5196058508 rtw88: remove redundant flag check helper function
6f0b0d28fde8 rtw88: pci: reset H2C queue indexes in a single write
61d7309562b5 rtw88: not to enter or leave PS under IRQ
3d391c06d917 rtw88: not to control LPS by each vif
5235d63640c6 rtw88: remove unused lps state check helper
d3e20fd17d0b rtw88: LPS enter/leave should be protected by lock
37ba5de2e731 rtw88: leave PS state for dynamic mechanism
27e117e4b01b rtw88: add deep power save support
3a068a2a6585 rtw88: not to enter LPS by coex strategy
d3be4d115be0 rtw88: select deep PS mode when module is inserted
04b786e00987 rtw88: add deep PS PG mode for 8822c
bcde60e599fb rtw88: remove misleading module parameter rtw_fw_support_lps

-- 
https://patchwork.kernel.org/patch/11170203/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

