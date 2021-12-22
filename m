Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20ED847D5FF
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Dec 2021 18:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344399AbhLVRs3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Dec 2021 12:48:29 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57104 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbhLVRs2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Dec 2021 12:48:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1293B81DCA
        for <linux-wireless@vger.kernel.org>; Wed, 22 Dec 2021 17:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA20C36AE8;
        Wed, 22 Dec 2021 17:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640195306;
        bh=LeZIZwE1uSLlmis8PEu2mDdAeWhhcfQxzx9alF+szkI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=PvbuazDDxbOKNKdJqu7Cdpvm+jiEdfoEfvzg+tHxyJdZ9L2reKlQezN4ZRuQfUkie
         WksA6EURpqbMq0+Rv+O8MFlYQ9+RbjtgzldZf9XVWWhJc3NaYd+0T55viQRQnI9O7F
         1udst9TMGHGUvgHs1ScfjCcU/MI2Y4utA0HsKyZhf3gdbzurWtTsjICYvkcDHHX3Jv
         z28el+r2LB1DC53SzGRi6MraQ/47rDekhr5FxgAoQo5zYvi8DhUnxOz8E2i/F/P/1T
         aB7PW4dDX7c8AG4eaM96b41Vo7pd0+rhzByB+qDc55qeOIocWMCCaUwSUVO4/N+xcT
         15uSFN3guGAmw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] brcmfmac: use ISO3166 country code and 0 rev as fallback
 on
 some devices
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211218185643.158182-1-hdegoede@redhat.com>
References: <20211218185643.158182-1-hdegoede@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-Hsien Lin <chi-hsien.lin@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, Shawn Guo <shawn.guo@linaro.org>,
        Soeren Moch <smoch@web.de>,
        Fabio Aiuto <fabioaiuto83@gmail.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164019530057.12144.15683892767137900754.kvalo@kernel.org>
Date:   Wed, 22 Dec 2021 17:48:23 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hans de Goede <hdegoede@redhat.com> wrote:

> This is a second attempt at honering the country code send out by access
> points. This was first added in commit b0b524f079a2 ("brcmfmac: use
> ISO3166 country code and 0 rev as fallback").
> 
> Subsequently this was reverted in commit 151a7c12c4fc ("Revert "brcmfmac:
> use ISO3166 country code and 0 rev as fallback""), because it was causing
> issues with AP mode on some brcmfmac models (specifically on BCM4359/9).
> 
> Many devices ship with a nvram ccode value of X2/XT/XU/XV/ALL which are
> all special world-wide compatibility ccode-s. Most of these world-wide
> ccode-s allow passive scan mode only for 2.4GHz channels 12-14,
> only enabling them when an AP is seen on them.
> 
> But at least on brcmfmac43455 devices this is not working correctly, these
> do not see accesspoints on channels 12-14 unless the ccode is changes to
> a country where these channels are allowed.
> 
> Translating received country codes to an ISO3166 country code and 0 rev
> ccreq fixes devices using a brcmfmac43455 with a X2/XT/XU/XV/ALL ccode
> not seeing accesspoints on channels 12-14.
> 
> To avoid this causing issues on other brcmfmac models again, the
> fallback is limited to only brcmfmac4345* chips this time.
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Soeren Moch <smoch@web.de>
> Cc: Fabio Aiuto <fabioaiuto83@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Arend, can you take a look?

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211218185643.158182-1-hdegoede@redhat.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

