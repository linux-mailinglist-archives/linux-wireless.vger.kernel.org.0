Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94142BCA8C
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2019 16:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387411AbfIXOrR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Sep 2019 10:47:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36974 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfIXOrP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Sep 2019 10:47:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6706560E73; Tue, 24 Sep 2019 14:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569336434;
        bh=oBdYXAVc/3GBGvYDVgDiAjq2lG5AEM14I5dke4IqQr4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=huHJ/JgsKGNDED0e2ZWYI0sQKhU/PRxeUTyJUCRxBgXBazYXWI5xA1ARzPPkti0MC
         qQv+otwpvQAPPozacjhEeUrPBb2q8c//yQrXWoVRFd2uSK9eEJCLmCMgqtqch5hHc5
         jxeHmlDaUD1Th1L/64cEgVsBPHtcBv9TN5oKAKBY=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 59BAC602E1;
        Tue, 24 Sep 2019 14:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569336434;
        bh=oBdYXAVc/3GBGvYDVgDiAjq2lG5AEM14I5dke4IqQr4=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=mKxT9FZCOxaazeNBRL+0eXZA+Ay7dAz+PzHqwcGkkJSAHqA09MAHR/n4o/fZ9n9Nm
         d9i7pKsxFb0LXaEm3KtvoEIegm4iT8FmvDCOr2Qwiw9FPtsdqa516ZvJp/Fp8wpaIh
         SsgpPr9Gul0hcqIMXzsFJJjxLu0Sp1zOz42voEJw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 59BAC602E1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5.4] iwlwifi: fw: don't send GEO_TX_POWER_LIMIT command
 to FW version 36
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190924103057.17147-1-luca@coelho.fi>
References: <20190924103057.17147-1-luca@coelho.fi>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190924144714.6706560E73@smtp.codeaurora.org>
Date:   Tue, 24 Sep 2019 14:47:14 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Luca Coelho <luciano.coelho@intel.com>
> 
> The intention was to have the GEO_TX_POWER_LIMIT command in FW version
> 36 as well, but not all 8000 family got this feature enabled.  The
> 8000 family is the only one using version 36, so skip this version
> entirely.  If we try to send this command to the firmwares that do not
> support it, we get a BAD_COMMAND response from the firmware.
> 
> This fixes https://bugzilla.kernel.org/show_bug.cgi?id=204151.
> 
> Cc: stable@vger.kernel.org # 4.19+
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

Patch applied to wireless-drivers.git, thanks.

fddbfeece9c7 iwlwifi: fw: don't send GEO_TX_POWER_LIMIT command to FW version 36

-- 
https://patchwork.kernel.org/patch/11158395/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

