Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17442D5E2A
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2019 11:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730585AbfJNJI1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Oct 2019 05:08:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48058 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730432AbfJNJI1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Oct 2019 05:08:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 12C1E60307; Mon, 14 Oct 2019 09:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571044106;
        bh=tcvVJ0TolgYa2MR6qFQFWh/BBCwTCNXbz5RS/q19Ku4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=mK2pr+b0I4eprnfkwe5IAGJeql1+1PP78/ljbnA6FzjKUMM3sgGSgTAUZsh/JwSZI
         kpamvsXXGztLzwB54Nbk2yAWJ3/ikQjti/rUVK9eKlatUg2J1hKb6DCukYGhOGUouy
         ClwqzhzregGOIERJ4EgHb+UPha+jm1NJ5OFwsjT0=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F086060112;
        Mon, 14 Oct 2019 09:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571044105;
        bh=tcvVJ0TolgYa2MR6qFQFWh/BBCwTCNXbz5RS/q19Ku4=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=g1GM7hhCDM1hg+0AqSlxinq+xkNFYbVb3cQTYE1HHQEN0UekLwyTsb5oosnKz3mQn
         bjS1Kzs6nSq0Mg4JcBqhdywNORxKYqtvpdN0t+YAakWwsu/3lc6OY6LcUoI11YMoiS
         zkKoOZywEkezjYlNwmftphJkBalEICQBCN229Mok=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F086060112
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 03/10] rtw88: config 8822c multicast address in MAC init
 flow
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191008082101.2494-4-yhchuang@realtek.com>
References: <20191008082101.2494-4-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191014090826.12C1E60307@smtp.codeaurora.org>
Date:   Mon, 14 Oct 2019 09:08:25 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Tzu-En Huang <tehuang@realtek.com>
> 
> Multicast address should be congiured in the initialization flow.
> The value is created by a hashed calculation that is also implemented
> by the hardware for multicast address filtering.
> 
> Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

27c65bfc434f rtw88: config 8822c multicast address in MAC init flow

-- 
https://patchwork.kernel.org/patch/11179135/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

