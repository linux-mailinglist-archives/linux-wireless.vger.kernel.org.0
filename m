Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5783240DDA4
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Sep 2021 17:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238694AbhIPPMb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Sep 2021 11:12:31 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:40435 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238608AbhIPPMa (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Sep 2021 11:12:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631805070; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=3GmProUL1RrIuDbt9MXonap06h8IMS/lbGchXicoQ2M=; b=hCea5SgAWbd78iSF//z1NfJ2NIlxa3zat8HxwVWqtHCR026pDgdlFC+MmHApZy5tsZG8/Yot
 1bWZq4fiwVfRa1P40RZ4tgs1ImWPiUXD9wX+yhENyZqQL0zmPYgwxJKARnmx3xWiWZ0l0quQ
 O+gmcX1raoFnSBtfcmnOEdDciAM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 61435e81b585cc7d244cec32 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 16 Sep 2021 15:10:57
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7467AC43617; Thu, 16 Sep 2021 15:10:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 85A06C4338F;
        Thu, 16 Sep 2021 15:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 85A06C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: Re: [PATCH 1/3] ieee80211: Add new A-MPDU factor macro for HE 6 GHz peer caps
References: <20210913175510.193005-1-jouni@codeaurora.org>
Date:   Thu, 16 Sep 2021 18:10:51 +0300
In-Reply-To: <20210913175510.193005-1-jouni@codeaurora.org> (Jouni Malinen's
        message of "Mon, 13 Sep 2021 20:55:08 +0300")
Message-ID: <87wnngy2ro.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> writes:

> From: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
>
> Add IEEE80211_HE_6GHZ_MAX_AMPDU_FACTOR as per IEEE Std 802.11ax-2021,
> 9.4.2.263 to use for peer max A-MPDU factor in 6 GHz band.
>
> Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> ---
>  include/linux/ieee80211.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
> index 694264503119..a1a7eda35cb5 100644
> --- a/include/linux/ieee80211.h
> +++ b/include/linux/ieee80211.h
> @@ -2084,6 +2084,7 @@ int ieee80211_get_vht_max_nss(struct ieee80211_vht_cap *cap,
>  
>  #define IEEE80211_HE_VHT_MAX_AMPDU_FACTOR	20
>  #define IEEE80211_HE_HT_MAX_AMPDU_FACTOR	16
> +#define IEEE80211_HE_6GHZ_MAX_AMPDU_FACTOR	13

Johannes, can I take this via my ath tree? I think that's the easiest as
the ath11k patches depend on this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
