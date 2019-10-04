Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBEC5CB860
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2019 12:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387480AbfJDKes (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Oct 2019 06:34:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56684 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729427AbfJDKes (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Oct 2019 06:34:48 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 80C5A602F2; Fri,  4 Oct 2019 10:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570185287;
        bh=Hw2/gsH1gbeTBfIyDO0ihG5v4cTqAGsJO1mayKUidA8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=FNf/IP6ywLTQy3561R1Sq6YzvuJgPDiwEiN58/T2f+rujSE2uo+Ezq+FThVZ97lvn
         x7wo3YfoJRuHM8p08zftTF5rqq2sUNIgp5zCEMOqUjWyT2E+G/1o02/icn2RQi1zkx
         f4yyQwYSCfz0DTTscYuW/T0tle6rqPfpo3pCPmuI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (85-76-46-241-nat.elisa-mobile.fi [85.76.46.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9E96E619F4;
        Fri,  4 Oct 2019 10:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570185285;
        bh=Hw2/gsH1gbeTBfIyDO0ihG5v4cTqAGsJO1mayKUidA8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=EZBi/yL6fzoQUYwp91FRy2kqHORk8eIoW2yNAK3jp4JJSQ3ZIJ0F3wSZDkiLOLjgy
         8PrF1bgVbc7Sz0lAwE9XN5oma3WS46MzMgiLKrpxa65QG3yxKcSwTQV3a1DMA50osy
         y7LYhVNINHG4vzRj1ni9/2E+qx6nGaG7u2RZD4dA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9E96E619F4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH 5.4 regression fix] brcmfmac: Fix brcmf_cfg80211_get_channel returning uninitialized fields
References: <20191003200821.819594-1-hdegoede@redhat.com>
Date:   Fri, 04 Oct 2019 13:34:38 +0300
In-Reply-To: <20191003200821.819594-1-hdegoede@redhat.com> (Hans de Goede's
        message of "Thu, 3 Oct 2019 22:08:21 +0200")
Message-ID: <87r23ssssh.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hans de Goede <hdegoede@redhat.com> writes:

> With the new edmg support struct cfg80211_chan_def has been extended
> with a number of new members. brcmf_cfg80211_get_channel() was not setting
> (clearing) these causing the cfg80211_edmg_chandef_valid() check in
> cfg80211_chandef_valid() to fail. Triggering a WARN_ON and, worse, causing
> brcmfmac based wifi cards to not work.
>
> This commit fixes this by clearing the entire passed struct to 0 before
> setting the members used by the brcmfmac code. This solution also makes
> sure that this problem will not repeat itself in the future if further
> members are added to the struct.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index e3ebb7abbdae..480c05f66ebd 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -5041,10 +5041,10 @@ static int brcmf_cfg80211_get_channel(struct wiphy *wiphy,
>  	}
>  
>  	freq = ieee80211_channel_to_frequency(ch.control_ch_num, band);
> +	memset(chandef, 0, sizeof(*chandef));
>  	chandef->chan = ieee80211_get_channel(wiphy, freq);
>  	chandef->width = width;
>  	chandef->center_freq1 = ieee80211_channel_to_frequency(ch.chnum, band);
> -	chandef->center_freq2 = 0;
>  
>  	return 0;
>  }

Is this a separate issue from the cfg80211 fix:

cfg80211: initialize on-stack chandefs

https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git/commit/?id=f43e5210c739fe76a4b0ed851559d6902f20ceb1

-- 
Kalle Valo
