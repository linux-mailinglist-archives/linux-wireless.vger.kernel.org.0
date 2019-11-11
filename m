Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE0BF6FEB
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2019 09:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfKKIuq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Nov 2019 03:50:46 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56894 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfKKIup (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Nov 2019 03:50:45 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 647A260A0B; Mon, 11 Nov 2019 08:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573462245;
        bh=GvOlQX+57Rq7/CbOJpGdatAOu9E/Itm4nXOE7A7fMOc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ftjqvakIJ5LUqtcbge0wBalpTQyUiXyQSk9ZPfG5XVvzokDYWrqAKzzHaKTOk595q
         EUTXCNBCNEj9baX8/rQ9B7yRBcUV2n5WiDf8AjwDkWeRQnTzU8+21uTCHEwXb/wdlp
         pLrMbi9aeQ8Sz2UcRRh7gaztUzPJR1Pdc6SExJUk=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EA89460117;
        Mon, 11 Nov 2019 08:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573462244;
        bh=GvOlQX+57Rq7/CbOJpGdatAOu9E/Itm4nXOE7A7fMOc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=jZBmFJshHVlV95Hh4FvUF1Zf1mCGE5NcW5JwKtk3zDo9FukBy0qV/Tsyi04ETOW6b
         Dy4tTJZ1E8himjpUNfRTNKvR8Nzhxzqw9+KeaFQvK4sbH0a0zAVGCZjuSnRco3plN/
         Wesb7xysSWkqROuzY4qmd8zvS6GzacatxKZH25fw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EA89460117
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Eduardo Abinader <eduardoabinader@gmail.com>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH] ath10k:mac: disassoc dbg msg after return check
References: <20191111083040.16824-1-eduardoabinader@gmail.com>
Date:   Mon, 11 Nov 2019 10:50:41 +0200
In-Reply-To: <20191111083040.16824-1-eduardoabinader@gmail.com> (Eduardo
        Abinader's message of "Mon, 11 Nov 2019 09:30:40 +0100")
Message-ID: <87lfsmssny.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Eduardo Abinader <eduardoabinader@gmail.com> writes:

> Signed-off-by: Eduardo Abinader <eduardoabinader@gmail.com>

No empty commit logs, please.

> --- a/drivers/net/wireless/ath/ath10k/mac.c
> +++ b/drivers/net/wireless/ath/ath10k/mac.c
> @@ -6786,13 +6786,13 @@ static int ath10k_sta_state(struct ieee80211_hw *hw,
>  		/*
>  		 * Disassociation.
>  		 */
> -		ath10k_dbg(ar, ATH10K_DBG_MAC, "mac sta %pM disassociated\n",
> -			   sta->addr);
> -
>  		ret = ath10k_station_disassoc(ar, vif, sta);
>  		if (ret)
>  			ath10k_warn(ar, "failed to disassociate station: %pM vdev %i: %i\n",
>  				    sta->addr, arvif->vdev_id, ret);
> +		else
> +			ath10k_dbg(ar, ATH10K_DBG_MAC, "mac sta %pM disassociated\n",
> +			   sta->addr);

I don't understand, how is this better?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
