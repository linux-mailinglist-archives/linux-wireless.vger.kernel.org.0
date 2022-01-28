Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0956849FD94
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 17:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349892AbiA1QEL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 11:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbiA1QEK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 11:04:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AC4C061714
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 08:04:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6092DB80D2E
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 16:04:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00078C340E0;
        Fri, 28 Jan 2022 16:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643385847;
        bh=CbOBii48d3GBdvvhA+Twrl5R9kyuOBsdujfIKZA/wmc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=IOpDIaXdKLCneEoh07POUJoCWu3DhdefiV6JxrCuEpD1AK03pt26r2ouepxGEauBY
         EI6eItUXSI541u8zg4OcfxLgzbvRkJQ1LqibDKytS0kIS1L1W1d+dMMVWoF8Vapju7
         DW74zlH6IQlQsJJZNMgV7jPrdVJteJcqMGtReVbsXRnllJ77w3ks7rbj4ji7GVFCfs
         TRDFKJ99j1aNia+m3Bcb24hHGSwL/odrXjod0ozN3mGkM+Ij6Eha01a7UlkvWKi3v8
         fRDzjdXraB0LASZ9zeSUc/7IxHiHdslv3qPu6fKplk9LgY/8xbSawF39DmsTDCYTKM
         Ji6N3G2bMl+tA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Message-ID: <164338584045.19531.14609213809350354500.kvalo@kernel.org>
Date:   Fri, 28 Jan 2022 16:04:03 +0000 (UTC)
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
> Tested-by: Soeren Moch <smoch@web.de>  # on BCM4359/9

Patch applied to wireless-next.git, thanks.

a21bf90e927f brcmfmac: use ISO3166 country code and 0 rev as fallback on some devices

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211218185643.158182-1-hdegoede@redhat.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

