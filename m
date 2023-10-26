Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602AF7D8105
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Oct 2023 12:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbjJZKmw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Oct 2023 06:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344648AbjJZKmY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Oct 2023 06:42:24 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3AAD64
        for <linux-wireless@vger.kernel.org>; Thu, 26 Oct 2023 03:42:06 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c503dbe50dso11186991fa.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Oct 2023 03:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698316924; x=1698921724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XyCnnP8S53LJCOoW53IAuKx0l5pIW3cQAjaLRYUze6c=;
        b=ze52VoPs7EcBjo3QVgXuBaJ1WpLcLIhODqEEZb/hebAp2rfWBim9jNiuKJxrsVALkD
         1l6sj29ZDxpT6LmAh33AzfmIkzx+6Cc4rMxykij38rKvL9iC9XQKJ3OtiJDYGov5AcPz
         raQ8qwmxB66qBs9MFKFDmGtCykLiTAIfZMnedGNWtqRnLyG4iaGBupMBxwD2mwu6seVk
         tD4Q4CD7VAuSx2iOuce31OOSzlspGd1ofMv987qLOL6HuRWNL6FJYakVQmdW5GboJQ96
         0+qBo4IpY3gy+4a8shHfeAd9seEsvr1aSA4wRXIgij9tFq/+mSCR6tyR+ZxQ87thTJ8O
         boFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698316924; x=1698921724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyCnnP8S53LJCOoW53IAuKx0l5pIW3cQAjaLRYUze6c=;
        b=h9AWqFE0TIv1oOXdPE61l1Bokr5UsXAtM+vQoz+E0yEvnXFCfm5lI3JQ7G7x259GFB
         UbsBNc7oFSggibC8+hTJX2l59XKrh+NHqr4sptxu2HOm1/0b3UuscTNyrMy8iK07wCUS
         ZSk6lXdVehDNUC20+nbeI04xtJXiVi2j8GrflppUejGyQL7A+vOYOoV4ABOXuwjmetef
         t7OhTbAT6rvCsoQ8dYaFa4n3MSlQwyqt8JUCiVKrKgXcmD+CkmCftBuJu4aaX8OJ0xuJ
         rz+CXU8AVqk1DfmrZYDzBNwFCZgioo9vKW5B+ufkzhu3MT9gmCrZb8IwneE6e1AFXfeI
         kTHg==
X-Gm-Message-State: AOJu0YzaA2OoT80IZjeBOxHel+LWF/S2i/kbaWaf+DlXCLwhj8nEuVEX
        HlBWMxormPTHEpNVC1e5aI2xrw==
X-Google-Smtp-Source: AGHT+IG1GMne5atwKenhd1l2WoZcVdwnLhRNArbCtQrH7H4ObuobEPO35dMkQ2loeI0+gr3ts9F+8A==
X-Received: by 2002:a2e:be14:0:b0:2c5:380:7bff with SMTP id z20-20020a2ebe14000000b002c503807bffmr13441810ljq.25.1698316924463;
        Thu, 26 Oct 2023 03:42:04 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c021a00b0040813e14b49sm2188665wmi.30.2023.10.26.03.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 03:42:04 -0700 (PDT)
Date:   Thu, 26 Oct 2023 13:42:00 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Gregory Greenman <gregory.greenman@intel.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Shaul Triebitz <shaul.triebitz@intel.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] wifi: iwlwifi: mvm: fix an error code in
 iwl_mvm_mld_add_sta()
Message-ID: <79f70bb6-ca33-48fc-ab33-6a6cd8ba2e1d@kadam.mountain>
References: <75e4ea09-db58-462f-bd4e-5ad4e5e5dcb5@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75e4ea09-db58-462f-bd4e-5ad4e5e5dcb5@moroto.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping?

regards,
dan carpenter

On Wed, Sep 27, 2023 at 03:40:41PM +0300, Dan Carpenter wrote:
> This error path should return -EINVAL instead of success.
> 
> Fixes: 57974a55d995 ("wifi: iwlwifi: mvm: refactor iwl_mvm_mac_sta_state_common()")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> I copy and pasted this approach from similar code in the same patch.
> 
>  drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
> index 1464aad039e1..f2e952481ff8 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
> @@ -707,8 +707,10 @@ int iwl_mvm_mld_add_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
>  			rcu_dereference_protected(mvm_sta->link[link_id],
>  						  lockdep_is_held(&mvm->mutex));
>  
> -		if (WARN_ON(!link_conf || !mvm_link_sta))
> +		if (WARN_ON(!link_conf || !mvm_link_sta)) {
> +			ret = -EINVAL;
>  			goto err;
> +		}
>  
>  		ret = iwl_mvm_mld_cfg_sta(mvm, sta, vif, link_sta, link_conf,
>  					  mvm_link_sta);
> -- 
> 2.39.2
