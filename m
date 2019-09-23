Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5EBBAF45
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2019 10:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437945AbfIWIW0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Sep 2019 04:22:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51664 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437610AbfIWIWZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Sep 2019 04:22:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DB5CC61570; Mon, 23 Sep 2019 08:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569226944;
        bh=0ClyKPJlGM5Zhl2YlUVTmZ73pKnaiY9/tMco5ldP1Dc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=EtoAY7raojCv+XBX24ytesnQlYpmtkMomioAs/FAkfNHPs21r2vkpuFWeL9XRLbkE
         QKaDtm33682IG6ZDL/FwrG5NBN0E77PQ5G2cvlSaJM8yyoh5HzrHF74KRRFQCOf1QF
         zpsDBq0YeRqPbUCA/FUB1DngahB9iarZuVZxsLBY=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1CCD460850;
        Mon, 23 Sep 2019 08:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569226944;
        bh=0ClyKPJlGM5Zhl2YlUVTmZ73pKnaiY9/tMco5ldP1Dc=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=A4a6eJTzPZ43IXx2JhZCIVoQRf59O/d6TtYlAMevqzYWFQWovDClqjIadsgWHJ22q
         pb9n3Rnux41Ylrz9Kjts1tIIi4Vn/rgciZX8lqGeJ13Vpg2MSRI3J+TcdUySZ+hf/y
         bpGtjzYySkFSt21tbqDXcNRodI8H1GFzL4cRf25c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1CCD460850
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] ath10k: Fix rate table updation in tx stats
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1552319602-17795-2-git-send-email-pillair@codeaurora.org>
References: <1552319602-17795-2-git-send-email-pillair@codeaurora.org>
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Rakesh Pillai <pillair@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190923082224.DB5CC61570@smtp.codeaurora.org>
Date:   Mon, 23 Sep 2019 08:22:24 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rakesh Pillai <pillair@codeaurora.org> wrote:

> The index for updating rate table, which is displayed
> in the tx stats via debugfs, is calculated using the
> bandwidth value. The bandwidth values do not map
> correctly with the bandwidth values shown in the rate table.
> 
> Correct the bandwidth value calculation which is used
> to calculate the index for rate table updation for tx stats.
> 
> Tested HW: WCN3990
> Tested FW: WLAN.HL.3.1-00784-QCAHLSWMTPLZ-1
> 
> Fixes: e88975ca37d1 ("ath10k: dump tx stats in rate table format")
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

I requested Surabhi to include these patches into his patchset, due to the dependency.

https://patchwork.kernel.org/project/linux-wireless/list/?series=85455&state=*&order=date

2 patches set to Changes Requested.

10847733 [1/2] ath10k: Fix rate table updation in tx stats
10847737 [2/2] ath10k: Fix NSS tx stats for legacy rates

-- 
https://patchwork.kernel.org/patch/10847733/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

