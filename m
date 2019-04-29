Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05DBDE57F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 16:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbfD2OyM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 10:54:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47636 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbfD2OyL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 10:54:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B36C161157; Mon, 29 Apr 2019 14:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556549650;
        bh=D3p73H9DBZZeHMrWmU118GN9gCpBzpMfZfYbHtTct/k=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=lNHdL2K2HsL06FoGMYtl1T7rTKe3IPTHAhqyNr1EA85wGR5Tz3uqRf5fGns/gwi+K
         SK8YjBOkhRraiMf/flbzUpRrgN7kxFp5F3LJ89TYCI3WNeEim72jh2oh9Qs5bqcp7y
         bd+V3/x7Cq8x5qIRmjaiECu0RrWfbjx2gxWioKWQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C926260E7A;
        Mon, 29 Apr 2019 14:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556549649;
        bh=D3p73H9DBZZeHMrWmU118GN9gCpBzpMfZfYbHtTct/k=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=WDGu879VQ3q4PzxkWUN1xKNz8nnKi/tX/RysPzu9x0dXc6E3XSEJpEC2np1X2Z6Zq
         uK/rOP+lZGjpELux06a6lFmjm4cix4GWrVja0Lrgqq+UXx/v0t8NbaDSk6i5g+mEYZ
         2YBpiRow7FUqG/C4OrVj72RwnnvByXU3OhM/yYQw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C926260E7A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath9k: Differentiate between max combined and per chain
 power
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190320103723.27228-1-sven@narfation.org>
References: <20190320103723.27228-1-sven@narfation.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     linux-wireless@vger.kernel.org,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        Sven Eckelmann <sven@narfation.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190429145410.B36C161157@smtp.codeaurora.org>
Date:   Mon, 29 Apr 2019 14:54:10 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sven Eckelmann <sven@narfation.org> wrote:

> The ath9k driver uses as maximum allowed txpower the constant
> MAX_RATE_POWER. It is used to set a maximum txpower limit for the PHY
> (which is combined txpower) and also the maximum txpower for per chain
> rates. Its value 63 is derived from the maximum number the registers can
> store for the per chain txpower.
> 
> The max txpower a user can set because of this is 31 dBm (floor(63 / 2)).
> This also means that a device with multiple tx chains is even limited
> further:
> 
> * 1 chain:  31 dBm per chain
> * 2 chains: 28 dBm per chain
> * 3 chains: 26 dBm per chain
> 
> This combined txpower limit of 31 dBm becomes even more problematic when
> some extra antenna gain is set in the EEPROM. A high power device is then
> no longer able to reach its potential limits.
> 
> Instead the code dealing with the combined txpower must use a higher limit
> than 63 and only the code dealing with the per chain txpower have to use
> the limit of 63. Since the antenna gain can be quite large and 8 bit
> variables are often used in ath9k for txpower, a large, divisible by two
> number like 254 is a good choice for this new limit.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

b037b107565f ath9k: Differentiate between max combined and per chain power

-- 
https://patchwork.kernel.org/patch/10861389/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

