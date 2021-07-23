Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB583D379E
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jul 2021 11:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhGWIll (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Jul 2021 04:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhGWIlk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Jul 2021 04:41:40 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54517C061575
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jul 2021 02:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=stU9pJoPalbyezozxSsqWZmSpy/iGnZV6lWR6Vk9KtY=;
        t=1627032134; x=1628241734; b=syf33xKbeEhhR6dHh3IR4dOfrP5EVACO1PhQ5PBAt66E8Ct
        PEbtiupit0Iz8gAaf/vf45vPmzonEzl+UABYNczHdEWbRtmRkK9nk9565LsjKuo53M6yJLMOA2k9u
        nCVsPrFM20AU6der31YJ1O6BWPmUxRbdbC+uW6JJFmhKdnCl3UPUsdNpIhoPfGIhESGETR2wUje+A
        Kbi0Wqi9KteNR1tyQrvAsMZIW4FyTgBJ3Sc7kqS3nNimT5x/KzE5Uohleak0SNJz9J1R2NrZBSx4p
        9LP9PLTeiywTfVUW7FcE6Td1uu720lXnPVaYm9b2nAVHs+3xJuw0CfEIhF9QwPWQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1m6rL7-000TwL-LR; Fri, 23 Jul 2021 11:22:08 +0200
Message-ID: <fccc9724374281d2d95e1ef52391788892552268.camel@sipsolutions.net>
Subject: Re: [PATCH 1/9] cfg80211: add power type definition for 6G Hz
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 23 Jul 2021 11:22:07 +0200
In-Reply-To: <20210517201932.8860-2-wgong@codeaurora.org> (sfid-20210517_222034_404094_2413CDB0)
References: <20210517201932.8860-1-wgong@codeaurora.org>
         <20210517201932.8860-2-wgong@codeaurora.org>
         (sfid-20210517_222034_404094_2413CDB0)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Sorry it took me so long to look at this. I started earlier, but then
found some questions and then ... sorry.

> 
> +/**
> + * enum nl80211_ap_reg_power - regulatory power for a Access Point
> + *
> + * @NL80211_REG_UNSET_AP: Access Point has no regulatory power mode
> + * @NL80211_REG_LPI: Indoor Access Point
> + * @NL80211_REG_SP: Standard power Access Point
> + * @NL80211_REG_VLP: Very low power Access Point
> + */
> +enum nl80211_ap_reg_power {
> +	NL80211_REG_UNSET_AP,
> +	NL80211_REG_LPI_AP,
> +	NL80211_REG_SP_AP,
> +	NL80211_REG_VLP_AP,
> +	NL80211_REG_MAX_AP_TYPE = 3,

That last one is missing docs. Also, why should it be numbered
explicitly? Better add something like

	NUM_NL80211_REG_POWER_TYPE,
	NL80211_REG_MAX_TYPE = NUM_NL80211_REG_POWER_TYPE - 1

or something?


> +enum nl80211_client_reg_power {
> +	NL80211_REG_UNSET_CLIENT,
> +	NL80211_REG_DEFAULT_CLIENT,
> +	NL80211_REG_SUBORDINATE_CLIENT,
> +	NL80211_REG_MAX_CLIENT_TYPE = 2,

same here.

johannes

