Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 652CEAEB33
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2019 15:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbfIJNMp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Sep 2019 09:12:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33848 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730517AbfIJNMp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Sep 2019 09:12:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1343F6050D; Tue, 10 Sep 2019 13:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568121164;
        bh=KQToKmaWm/fWAohRUFoScC5Iid7B75pf763E2R9dIFs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=NlJMLbtFM4BgSKL+Swo5REmh4d2rXGSYK+n9Z442+05p2jwGSw0bAr0yVOOKt+izi
         r2yiMVV40T7wZ2TgN/DC5YqtZsR8rNDsGvXJV6FWwhse/jDIAqDgGXB73MU77oQJQp
         m+JGAJzQ82adad+YX42GzkRJQsoAnJsV3pcC5iHY=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DD4CF602BC;
        Tue, 10 Sep 2019 13:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568121163;
        bh=KQToKmaWm/fWAohRUFoScC5Iid7B75pf763E2R9dIFs=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=bafT6GmJv+rs1Lo3+49K2FiHFCKq6s8pIyQztgUDUhX5en07eAsnhOcLrQjfvmLCE
         pyJvngQgWH8Uf+koJ+GbhvDhKpU5HpsfbQbSPrK09xXcrr8KBmIG3AAV21J2WIQH74
         v+2r6zF7jGtT3py8/CWIldYffRb8WTkAlbK7tCTw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DD4CF602BC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k:  Free beacon buf later in vdev teardown.
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190227162756.13048-1-greearb@candelatech.com>
References: <20190227162756.13048-1-greearb@candelatech.com>
To:     greearb@candelatech.com
Cc:     linux-wireless@vger.kernel.org,
        Ben Greear <greearb@candelatech.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190910131244.1343F6050D@smtp.codeaurora.org>
Date:   Tue, 10 Sep 2019 13:12:44 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

greearb@candelatech.com wrote:

> My wave-1 firmware often crashes when I am bringing down
> AP vdevs, and sometimes at least some machines lockup hard
> after spewing IOMMU errors.
> 
> I don't see the same issue in STA mode, so I suspect beacons
> are the issue.
> 
> Moving the beacon buf deletion to later in the vdev teardown
> logic appears to help this problem.  Firmware still crashes
> often, but several iterations did not show IOMMU errors and
> machine didn't hang.

I'm not really fond of fixing issues just by luck but after a quick look at the
code I can't see any harm in this change either. So I guess it's ok.

But can you provide the exact hardware and firmware you used for testing, I'll
add it to the commit log. I want to document that in every commit:

https://wireless.wiki.kernel.org/en/users/drivers/ath10k/submittingpatches#guidelines

Please also CC ath10k list when submitting patches.

-- 
https://patchwork.kernel.org/patch/10831867/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

