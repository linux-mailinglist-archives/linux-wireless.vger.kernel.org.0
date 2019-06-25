Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE4D85229C
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 07:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfFYFMp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 01:12:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46838 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfFYFMo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 01:12:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B57B360867; Tue, 25 Jun 2019 05:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561439563;
        bh=r/tGvEZOJPHra4fP7IYj1O8+ibu5+G1t5YDkSHhrbiE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=lIsoDU9bfJLKdey/L+2Id3mTz5iJU932xdTpQQCg9kV+dGGPiD8vbd8AVlxdxdhsm
         i2KUGhWbS021E4AxB7clH+zjKCXHn4PjwV18uypLQJ5hqv3CSBgd97xweJhKBdv5L2
         sLNkxZKWzSshNDmaLBuicE+0rRAqHwZBBBl0x3lw=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 42CD76029B;
        Tue, 25 Jun 2019 05:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561439563;
        bh=r/tGvEZOJPHra4fP7IYj1O8+ibu5+G1t5YDkSHhrbiE=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=ePqKsHMhoXUIkggq8OWM4f0NlPvPJrzTEw/To4Jo0eWgw8ObeiE0+5uA9ViaHAs9p
         XtNcc44BBaLKOkR7lpzg34AhS5P8J8r7cRdczeoET8pFs6k+N2uvuBTIhgunmCTR3o
         veMXAP1HGwz27L2GuRIwbVWHpT6MOVVj2twyt9Ro=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 42CD76029B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] airo: switch to skcipher interface
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190617084338.24918-1-ard.biesheuvel@linaro.org>
References: <20190617084338.24918-1-ard.biesheuvel@linaro.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-wireless@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, ebiggers@kernel.org,
        johannes@sipsolutions.net, linux@rainbow-software.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190625051243.B57B360867@smtp.codeaurora.org>
Date:   Tue, 25 Jun 2019 05:12:43 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> The AIRO driver applies a ctr(aes) on a buffer of considerable size
> (2400 bytes), and instead of invoking the crypto API to handle this
> in its entirety, it open codes the counter manipulation and invokes
> the AES block cipher directly.
> 
> Let's fix this, by switching to the sync skcipher API instead.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Patch applied to wireless-drivers-next.git, thanks.

e5db0ad7563c airo: switch to skcipher interface

-- 
https://patchwork.kernel.org/patch/10998553/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

