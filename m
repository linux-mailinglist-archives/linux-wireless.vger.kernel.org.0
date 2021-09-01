Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812FD3FD90D
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Sep 2021 13:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243904AbhIALzm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Sep 2021 07:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbhIALzm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Sep 2021 07:55:42 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFFDC061760
        for <linux-wireless@vger.kernel.org>; Wed,  1 Sep 2021 04:54:45 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id x2-20020a1c7c02000000b002e6f1f69a1eso4536456wmc.5
        for <linux-wireless@vger.kernel.org>; Wed, 01 Sep 2021 04:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rDf09/KFN5QZpt6FbNdm+OOEGrC0WLzxPwgvwyd1B2s=;
        b=IaOZ3ItjVkWMipeKPxxOEj7b65NIIcgmEsNf7DYTafwJMEqcbGq4+pbU/7GUGPowDQ
         8m3FL1FrFvG86O+y6G5Xf3ovzL+VRLlZOaN5lkm/Lo7/m6/9lB3qNiyCamby168GUhOa
         U8gWKNUBx+aVXr5AiHhoFBIlx342MlTRBNRs6cjppjSPa8uDd2g707NZBbd1W105evMC
         ultCvSbSLXpVOQKKwnElfVH6n7aZ4HcFAJ3qANDih1pIT+zeZ4k1g1JQNg1pDNinUAgc
         QW9NcxgAgYf5Jt1Za0tXZa4KiPGAr2mTSF9xLDXgrXGX3tjQk6tRpmIDNPpuqP7oq/GJ
         27Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rDf09/KFN5QZpt6FbNdm+OOEGrC0WLzxPwgvwyd1B2s=;
        b=EONhFl5MvLVxkyboqMYaeenhf0ESIRGi9szG4GB14WU+SzMYc9HhR9M6y+QQJ8KHMV
         985ILxkESnlr3iJs7q/ZtjDZmBBjN56W72rMJieqKjhcVNehA0wq2EpgxN3QBmKmo4z6
         /6e7PjdVrGdWj3quzhZLS/ePu4NIfq7R2Gf39tbCRKnDUl1XHBT3U/P+c5XG2IATjAVU
         slOPwBBbPvRVnLKiLsDMY59kKDVGJfhzD/uPY2eqtDt0YI5FaC5eTch9R8zPJEPD1mr4
         e89AmbHe8iIlJud/vnTRVcGicgSlURW2BfyOdKiL/WQs2CY6l+7cpaH5eXDdQBfP1iSf
         BLjw==
X-Gm-Message-State: AOAM532ODaSL25yMnPQgedFYt01FkWdNOYKZKXrPwpKaWO+BiPyxuf2u
        eRdJbTjbf7tyBWL63siqVP85Ug==
X-Google-Smtp-Source: ABdhPJxGgHr6Nx+lzKwjs7lpIVXMvBLteCbGxrmJ+TOV2UIDkjx6RtHb7uSvxeVEb9d1yG1Ncclumw==
X-Received: by 2002:a1c:ed10:: with SMTP id l16mr9230740wmh.8.1630497284057;
        Wed, 01 Sep 2021 04:54:44 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id r15sm5770339wmh.27.2021.09.01.04.54.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 04:54:43 -0700 (PDT)
Subject: Re: [PATCH] wcn36xx: handle connection loss indication
To:     Loic Poulain <loic.poulain@linaro.org>,
        Benjamin Li <benl@squareup.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, stable@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210901030542.17257-1-benl@squareup.com>
 <CAMZdPi_frOfwf+9nfiUw2NJhfuSVgcPj3=Hx2g0d8UsaZza5MA@mail.gmail.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <b6157d1f-b548-13c0-3683-2d8c35964d1d@linaro.org>
Date:   Wed, 1 Sep 2021 12:56:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAMZdPi_frOfwf+9nfiUw2NJhfuSVgcPj3=Hx2g0d8UsaZza5MA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 01/09/2021 07:40, Loic Poulain wrote:
> iw wlan0 set power_save off

I do this on wcn3680b and get no loss of signal

If I do this though

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c 
b/drivers/net/wireless/ath/wcn36xx/smd.c
index 03966072f34c..ba613fbb728d 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2345,6 +2345,8 @@ int wcn36xx_smd_feature_caps_exchange(struct 
wcn36xx *wcn)
                 set_feat_caps(msg_body.feat_caps, DOT11AC);
                 set_feat_caps(msg_body.feat_caps, 
ANTENNA_DIVERSITY_SELECTION);
         }
+       set_feat_caps(msg_body.feat_caps, IBSS_HEARTBEAT_OFFLOAD);
+       set_feat_caps(msg_body.feat_caps, WLANACTIVE_OFFLOAD);

         PREPARE_HAL_BUF(wcn->hal_buf, msg_body);

@@ -2589,7 +2591,7 @@ static int wcn36xx_smd_missed_beacon_ind(struct 
wcn36xx *wcn,
         struct wcn36xx_hal_missed_beacon_ind_msg *rsp = buf;
         struct ieee80211_vif *vif = NULL;
         struct wcn36xx_vif *tmp;
-
+wcn36xx_info("%s/%d\n", __func__, __LINE__);
         /* Old FW does not have bss index */
         if (wcn36xx_is_fw_version(wcn, 1, 2, 2, 24)) {
                 list_for_each_entry(tmp, &wcn->vif_list, list) {
@@ -2608,7 +2610,7 @@ static int wcn36xx_smd_missed_beacon_ind(struct 
wcn36xx *wcn,

         list_for_each_entry(tmp, &wcn->vif_list, list) {
                 if (tmp->bss_index == rsp->bss_index) {
-                       wcn36xx_dbg(WCN36XX_DBG_HAL, "beacon missed 
bss_index %d\n",
+                       wcn36xx_info("beacon missed bss_index %d\n",
                                     rsp->bss_index);
                         vif = wcn36xx_priv_to_vif(tmp);
                         ieee80211_connection_loss(vif);


bingo

root@linaro-developer:~# iw wlan0 set power_save off 
 


# pulls plug on AP

root@linaro-developer:~# [   83.290987] wcn36xx: 
wcn36xx_smd_missed_beacon_ind/2594
[   83.291070] wcn36xx: beacon missed bss_index 0
[   83.295403] wlan0: Connection to AP e2:63:da:9c:a4:bd lost

I'm not sure if both flags are required but, this is the behavior we want

