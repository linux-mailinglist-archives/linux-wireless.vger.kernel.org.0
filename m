Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4CCDA69F0
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 15:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfICNf7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 09:35:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48550 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfICNf7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 09:35:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C095D6083E; Tue,  3 Sep 2019 13:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567517758;
        bh=OxttTyR5BnMrOhYghkVd1Ija74eT1WWjLfYs3n/PZL8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=KuSbaOXEdQmcjvSTKYB8FNMr1rPuXiIPacgcaWPCNWhKcZr3z/Xa8ynq7Y/uS6E/V
         +kEvTHfk34aJ9kgMBc2/cSXzozNYnSCTXn8lzqU+ZJGWNL9Fp49oeNCzUXKj3mLWMO
         5yvVY779SykTuX/LiKTC86WZ6zIdLW48sDAMgbLE=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D388A6058E;
        Tue,  3 Sep 2019 13:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567517758;
        bh=OxttTyR5BnMrOhYghkVd1Ija74eT1WWjLfYs3n/PZL8=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=Xk39SditLW7tfOFIyEdPvKduKpTP/b6oJYTZq7pRwNPs+KQj1yMmySZi9YzPJv/p/
         XLTh+/CnYq7KiyzKkQ0KdX6CTl67Tw9S8qd6zRotV/778d/WrVF4IW9i9+xCBZfuLP
         85qWRtAU7s9KQBNWeSdpotg7YCpI28RxcNhrnh14=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D388A6058E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5.4] rtw88: drop unused rtw_coex_coex_dm_reset()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190819181757.204572-1-briannorris@chromium.org>
References: <20190819181757.204572-1-briannorris@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     <linux-wireless@vger.kernel.org>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Guenter Roeck <groeck@chromium.org>,
        kbuild test robot <lkp@intel.com>,
        Brian Norris <briannorris@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190903133558.C095D6083E@smtp.codeaurora.org>
Date:   Tue,  3 Sep 2019 13:35:58 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> wrote:

> From: Guenter Roeck <groeck@chromium.org>
> 
> 0day reports:
> 
> sparse warnings:
> 
> drivers/net/wireless/realtek/rtw88/coex.c:2457:6: sparse:
> 	symbol 'rtw_coex_coex_dm_reset' was not declared. Should it be static?
> 
> rtw_coex_coex_dm_reset() is not called. Remove it.
> 
> Fixes: 4136214f7c46 ("rtw88: add BT co-existence support")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Guenter Roeck <groeck@chromium.org>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Patch applied to wireless-drivers-next.git, thanks.

d74d0767b95e rtw88: drop unused rtw_coex_coex_dm_reset()

-- 
https://patchwork.kernel.org/patch/11101615/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

