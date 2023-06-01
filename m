Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3119C7199BC
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 12:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbjFAK3j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 06:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbjFAK3U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 06:29:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45CD10EA
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 03:28:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 450D663016
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 10:28:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2129C433EF;
        Thu,  1 Jun 2023 10:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685615323;
        bh=KRUWyi7px/1mj9hDeaRWyHxzW0DXlU/q5rjD+k9eiEU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=fvCqcw0kbH5TaIZtSXdySw6jZzrLVX2EakMYkauuNh6beNP8+BNdNbSjemVAaUkZx
         Jzvzb+DXGJIf+4c5HjZehTfJwxUJRJ2e2TH7OnIg9hBBnrdX6M+0FmpIYlbV/Q8fiP
         aNEr3EhBhEaqyHEkgPh4v8NoIuajTR6TjwtVXgNmvyfxco3o/ryrAep1bJ+eTrXT9M
         WX/RFT4rFeT8FPhx0hWeYRZpZvg/l9xdMsQOcqVbUF+TlUSNg0O9aY61gbQtXJBjR0
         HZdiflLuzszgAD21AWI82f7Ut7QJULxYwmAjccrBjPioacU3+4AYpdURyGYuOqW0YP
         KWG89ZYNi9k8w==
From:   Kalle Valo <kvalo@kernel.org>
To:     Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Govindaraj Saminathan <quic_gsaminat@quicinc.com>
Subject: Re: [PATCH v4 2/4] wifi: ath11k: optimize ath11k_tm_cmd_get_version
References: <20230517135934.16408-1-quic_rajkbhag@quicinc.com>
        <20230517135934.16408-3-quic_rajkbhag@quicinc.com>
Date:   Thu, 01 Jun 2023 13:28:35 +0300
In-Reply-To: <20230517135934.16408-3-quic_rajkbhag@quicinc.com> (Raj Kumar
        Bhagat's message of "Wed, 17 May 2023 19:29:32 +0530")
Message-ID: <878rd3jx2k.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Raj Kumar Bhagat <quic_rajkbhag@quicinc.com> writes:

> From: Govindaraj Saminathan <quic_gsaminat@quicinc.com>
>
> Currently ath11k_tm_cmd_get_version() uses local variable ret.
> optimize ath11k_tm_cmd_get_version() to avoid local variable use.
>
> Tested-on : IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Govindaraj Saminathan <quic_gsaminat@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath11k/testmode.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/testmode.c b/drivers/net/wireless/ath/ath11k/testmode.c
> index ebeca5eb6a67..f562f860ebf3 100644
> --- a/drivers/net/wireless/ath/ath11k/testmode.c
> +++ b/drivers/net/wireless/ath/ath11k/testmode.c
> @@ -24,7 +24,6 @@ static const struct nla_policy ath11k_tm_policy[ATH11K_TM_ATTR_MAX + 1] = {
>  static int ath11k_tm_cmd_get_version(struct ath11k *ar, struct nlattr *tb[])
>  {
>  	struct sk_buff *skb;
> -	int ret;
>  
>  	ath11k_dbg(ar->ab, ATH11K_DBG_TESTMODE,
>  		   "testmode cmd get version_major %d version_minor %d\n",
> @@ -36,18 +35,12 @@ static int ath11k_tm_cmd_get_version(struct ath11k *ar, struct nlattr *tb[])
>  	if (!skb)
>  		return -ENOMEM;
>  
> -	ret = nla_put_u32(skb, ATH11K_TM_ATTR_VERSION_MAJOR,
> -			  ATH11K_TESTMODE_VERSION_MAJOR);
> -	if (ret) {
> -		kfree_skb(skb);
> -		return ret;
> -	}
> -
> -	ret = nla_put_u32(skb, ATH11K_TM_ATTR_VERSION_MINOR,
> -			  ATH11K_TESTMODE_VERSION_MINOR);
> -	if (ret) {
> +	if (nla_put_u32(skb, ATH11K_TM_ATTR_VERSION_MAJOR,
> +			ATH11K_TESTMODE_VERSION_MAJOR) ||
> +	    nla_put_u32(skb, ATH11K_TM_ATTR_VERSION_MINOR,
> +			ATH11K_TESTMODE_VERSION_MINOR)) {
>  		kfree_skb(skb);
> -		return ret;
> +		return -ENOBUFS;
>  	}

When optimising something it's always good to provide numbers to show
the improvement. But I can't see how this really improves anything so I
dropped this patch 2.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
