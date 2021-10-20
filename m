Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EA343464A
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Oct 2021 09:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhJTH4w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Oct 2021 03:56:52 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:23232 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhJTH4w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Oct 2021 03:56:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634716478; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=l1wCt2XwuXKYZBLiuE4Mb1G+nUelwSpcbnLazoCaWbw=;
 b=ZDWwht9UeL9gTPsAHE9RlLXccTE/1PFTZdEjmw13dtqc+1qs0lku3/Z1xsDSrV3wW0hg2Q7K
 BJ+9KIa0+DDQfhHCdK4J4lHZ9jpAtQjwt3bBR/CLH7zgwTueSE4IL6UgFIdpGZMrxQfw712u
 6Y7rTOnS2oL9bqw/gZLQ1Y26OSY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 616fcb32b03398c06c89d62b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 20 Oct 2021 07:54:26
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A0B87C4360D; Wed, 20 Oct 2021 07:54:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D33B8C4360C;
        Wed, 20 Oct 2021 07:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org D33B8C4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V2] ath10k: don't fail if IRAM write fails
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210722193459.7474-1-ojab@ojab.ru>
References: <20210722193459.7474-1-ojab@ojab.ru>
To:     ojab <ojab@ojab.ru>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, ojab <ojab@ojab.ru>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163471645955.23156.7506403648173685920.kvalo@codeaurora.org>
Date:   Wed, 20 Oct 2021 07:54:25 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ojab <ojab@ojab.ru> wrote:

> After reboot with kernel & firmware updates I found `failed to copy
> target iram contents:` in dmesg and missing wlan interfaces for both
> of my QCA9984 compex cards. Rolling back kernel/firmware didn't fixed
> it, so while I have no idea what's actually happening, I don't see why
> we should fail in this case, looks like some optional firmware ability
> that could be skipped.
> 
> Also with additional logging there is
> ```
> [    6.839858] ath10k_pci 0000:04:00.0: No hardware memory
> [    6.841205] ath10k_pci 0000:04:00.0: failed to copy target iram contents: -12
> [    6.873578] ath10k_pci 0000:07:00.0: No hardware memory
> [    6.875052] ath10k_pci 0000:07:00.0: failed to copy target iram contents: -12
> ```
> so exact branch could be seen.
> 
> Signed-off-by: Slava Kardakov <ojab@ojab.ru>
> Tested-by: Axel Rasmussen <axelrasmussen@google.com>

I'm planning to take this patch instead:

https://patchwork.kernel.org/project/linux-wireless/patch/20211020075054.23061-1-kvalo@codeaurora.org/

Patch set to Superseded.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210722193459.7474-1-ojab@ojab.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

