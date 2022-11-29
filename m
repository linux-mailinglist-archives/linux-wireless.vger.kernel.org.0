Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD30263C343
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Nov 2022 15:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbiK2O74 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Nov 2022 09:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiK2O7y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Nov 2022 09:59:54 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77B4D2E7
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 06:59:47 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id h193so13231985pgc.10
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 06:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yonsei-ac-kr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gf5GhpcBACNp2wOH1j1vhVHJDChLCkVB3EAvyR7WlI=;
        b=Aifo53vDWDBlkXYnnaaPYQlj7uYCMvWuIYL9E6mBknAgDBzM8JOx7lti6Lx3NU2Ghs
         Kg62HBegg/fKY3hfvTP+jQnpmQx5KmidQBbYTNLxo/FqTJ0rktdgSw0/9cAsSbZpt8DP
         nRbH0Sq6ZlnEriaWOcLAG3mF3B9nhYX2oAtGVQQAKKspNsUpO4509ESmfYVm9hxkRziL
         4MDEgt0pxE6AG4m4G7c2Vef4EAulgjYrNQS8rTvn4VIpeaz/kX9SKlHxcTf1JQstzTID
         K2E29n+PTey5xeODpnu7Gr3KFJheVCMCwjr5PrHuJu9b4rzZicwXi/y6ZftPmiUPmoOt
         hTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8gf5GhpcBACNp2wOH1j1vhVHJDChLCkVB3EAvyR7WlI=;
        b=M7fJDiz2LV+XPa+dsGLmMd/BKYjMtMY6N8VFOHuEQ5Rl9m+E4jg2qE1WAV4/NYbbjL
         6FbQyebQMSyCVoOscAP7YovIoTnSPtEraa5A1OrHLqSa7h3A6ke1Mikrd3cuyJ1JPIs3
         u4fEMBxPDVsXlF7ech4W7en3D2ev8+RHv6uigNZQ4jN2w9mCVfN4LdPXBkTD5IDxryhB
         oM7DUHwkTEK1KfeWSardqzMAo7btAqT6932Jgi5DKNEOol+ZZU0pXmyidzR49nZ7KQku
         pZdHByTrLS2/rVHbynG+d/VDq0ck54fKYNgR9wbgtgRL2x6wriAwBgGDTE26kLkztYa1
         Ic9Q==
X-Gm-Message-State: ANoB5pncEIeupaOR/RLXUjmQMOvJ3R7oVIZA74HTF9CkXM3mAKjgknAd
        JKrwcyFPYX7SMKChQiRSYn0U2g==
X-Google-Smtp-Source: AA0mqf768WPeTA/3rMLdwnDBQlLdt9Yb7LX75yqTsPsxfW1iEaIGCfnQH6FNTl8PX6taydQlAC3Q0g==
X-Received: by 2002:a62:be16:0:b0:56b:676e:1815 with SMTP id l22-20020a62be16000000b0056b676e1815mr38765144pff.66.1669733987460;
        Tue, 29 Nov 2022 06:59:47 -0800 (PST)
Received: from localhost.localdomain ([165.132.118.52])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090341cb00b00186b55e3cd6sm11052781ple.133.2022.11.29.06.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 06:59:47 -0800 (PST)
From:   Minsuk Kang <linuxlovemin@yonsei.ac.kr>
To:     arend.vanspriel@broadcom.com
Cc:     linux-wireless@vger.kernel.org, kvalo@kernel.org,
        dokyungs@yonsei.ac.kr, jisoo.jang@yonsei.ac.kr,
        Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Subject: Re: [PATCH v2] wifi: brcmfmac: Check the count value of channel spec to prevent out-of-bounds reads
Date:   Tue, 29 Nov 2022 23:56:33 +0900
Message-Id: <20221129145632.1072379-1-linuxlovemin@yonsei.ac.kr>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221116142952.518241-1-linuxlovemin@yonsei.ac.kr>
References: <20221116142952.518241-1-linuxlovemin@yonsei.ac.kr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Minsuk Kang <linuxlovemin@yonsei.ac.kr> wrote:

> v1->v2: Added a macro BRCMF_MAX_CHANSPEC_LIST
> 
>  .../broadcom/brcm80211/brcmfmac/cfg80211.c      | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index ae9507dec74a..bff3128c2f26 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -101,6 +101,9 @@
>  #define BRCMF_ASSOC_PARAMS_FIXED_SIZE \
>  	(sizeof(struct brcmf_assoc_params_le) - sizeof(u16))
>  
> +#define BRCMF_MAX_CHANSPEC_LIST \
> +	(BRCMF_DCMD_MEDLEN / sizeof(__le32) - 1)
> +
>  struct brcmf_dump_survey {
>  	u32 obss;
>  	u32 ibss;
> @@ -6840,6 +6843,13 @@ static int brcmf_construct_chaninfo(struct brcmf_cfg80211_info *cfg,
>  			band->channels[i].flags = IEEE80211_CHAN_DISABLED;
>  
>  	total = le32_to_cpu(list->count);
> +	if (total > BRCMF_MAX_CHANSPEC_LIST) {
> +		bphy_err(drvr, "Invalid count of channel Spec. (%u)\n",
> +			 total);
> +		err = -EINVAL;
> +		goto fail_pbuf;
> +	}
> +
>  	for (i = 0; i < total; i++) {
>  		ch.chspec = (u16)le32_to_cpu(list->element[i]);
>  		cfg->d11inf.decchspec(&ch);
> @@ -6985,6 +6995,13 @@ static int brcmf_enable_bw40_2g(struct brcmf_cfg80211_info *cfg)
>  		band = cfg_to_wiphy(cfg)->bands[NL80211_BAND_2GHZ];
>  		list = (struct brcmf_chanspec_list *)pbuf;
>  		num_chan = le32_to_cpu(list->count);
> +		if (num_chan > BRCMF_MAX_CHANSPEC_LIST) {
> +			bphy_err(drvr, "Invalid count of channel Spec. (%u)\n",
> +				 num_chan);
> +			kfree(pbuf);
> +			return -EINVAL;
> +		}
> +
>  		for (i = 0; i < num_chan; i++) {
>  			ch.chspec = (u16)le32_to_cpu(list->element[i]);
>  			cfg->d11inf.decchspec(&ch);

I have incorporated your review in this patch.
Please let me know if any further changes are needed.
