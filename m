Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1714249368B
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jan 2022 09:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237729AbiASItg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Jan 2022 03:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352571AbiASIte (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Jan 2022 03:49:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706FCC061574;
        Wed, 19 Jan 2022 00:49:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11208614B8;
        Wed, 19 Jan 2022 08:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDB9C340E3;
        Wed, 19 Jan 2022 08:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642582173;
        bh=f7Mv8iRpM88XNk2LC22R7OThKjTnidsB51bEaWygpKY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=YUS9c3e2F/VtS4CWpLVbSvlL766/2c/tYU2wPF0iUk59loi6zU8OF0m44ueNMJ1gZ
         cWBi3Im6C6pH2OXSA9bvnOrmzwK2YABh01Xl4wFXEW+h1ngGRaAtwkGMxTbrQg8ADl
         6+EKr8ED2bNFgFKHEwAsi+AK2s2K8/BP3lRwlxIX9Wyy1i7COffAHz3e9vY6QRwQmS
         6fNVuxhWa0kn5jc25Cpd8iDu0h1fVjMG0KABL3vcQgChHw+y7xU6WgQ7qSFzgj3SEU
         d7LZllKqMBfMc+dzYsdw4IwUEQtZQrDfYWqvZzIV7D6VqPDHxM159aXhrU+dM0CoQ1
         yoGXQxZesHS0g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/4] wcn36xx: Implement get_snr()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220115001646.3981501-2-bryan.odonoghue@linaro.org>
References: <20220115001646.3981501-2-bryan.odonoghue@linaro.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        loic.poulain@linaro.org, benl@squareup.com,
        bryan.odonoghue@linaro.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164258216749.21393.3097198740948062777.kvalo@kernel.org>
Date:   Wed, 19 Jan 2022 08:49:31 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:

> The wcn36xx BD phy descriptor returns both Received Signal Strength
> Information (RSSI) and Signal To Noise Ratio (SNR) with each delivered BD.
> 
> The macro to extract this data is a simple-one liner, easily imported from
> prima driver. This data will be useful to us when implementing
> mac80211-ops->get_survey().
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

4 patches applied to ath-next branch of ath.git, thanks.

039d5d4db4bc wcn36xx: Implement get_snr()
d6f2746691cb wcn36xx: Track the band and channel we are tuned to
29696e0aa413 wcn36xx: Track SNR and RSSI for each RX frame
51395cf204f2 wcn36xx: Add SNR reporting via get_survey()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220115001646.3981501-2-bryan.odonoghue@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

