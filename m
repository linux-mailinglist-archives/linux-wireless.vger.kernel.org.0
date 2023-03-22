Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D996C45B5
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Mar 2023 10:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjCVJII (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Mar 2023 05:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjCVJHz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Mar 2023 05:07:55 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECE65DEEA;
        Wed, 22 Mar 2023 02:07:37 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id p34so5995313wms.3;
        Wed, 22 Mar 2023 02:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679476055;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bvpf9FVCLctX7svqEM4yjqdyr40doXVNBus5SNiYttE=;
        b=Zell6gVeqXqMOHVt1r10CO4gZWFcFTbZd0+ujzqF/TkD16wyZ4O2KVQWrhg4dPH4Na
         +bj0qFQf7tnSPRsZU4m/Mabiz00PGEO1MhoJNen8HcmULlfl7EWgqrR5mq5oSv8aQrxJ
         SOiqMk65DM9oxTZKmMIINSWSPBxIxuupgAGLg82bUAX7lILoj4NqVhmsVCKMqEendmlP
         uhafYxbnqqToy8eaioZjxfvpeOddrVxYXpgTb8bss9MInyeaCC6sExXQTXLt4LCNdwp3
         kGWoiP1uMT6DjSk/3bl4HJtGWDutclAVloc2x1aFLtI74BhyjXsSyRbNdRxEH5ACPc4I
         crNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679476055;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bvpf9FVCLctX7svqEM4yjqdyr40doXVNBus5SNiYttE=;
        b=mQYWXLZCaVoOKYcuZxpgB6Y8qX8kSZI1bYJwrTukSlKYML93o+SAD2TRHuWm/0QrFg
         9NDo2ncrlzT7rjGXt1T016+5tdXVyz3geGTpMpFSUhdCrOcik496DvOK4ahSugPPkG+Z
         BVT3zAd8l/2i++ZYd/bdwH78l7od4Ns8DbR9UaaGsL0cQAs/hRCvlOAuJI4B176t9vBj
         7CvA3/3knpS+5+UjduvjDy7VyQGIfAMn+W5grA5Wg6LL/D3tU58aOOK+BYGgttwyHPJb
         UxxzxDoivEKAwlglwU7LJ0wkQxEPUZDfcMeYdJcMovDajnyf3TzEmNayBj8PXjHJHqWj
         EyKA==
X-Gm-Message-State: AO0yUKUMVpBlQZ1pYiVlH53OtIohTkUsdEacQMLSqaFmN85TeM33TqEb
        LhX05KK7q1AugvhGzruhcis=
X-Google-Smtp-Source: AK7set+O/UO9Z7680nU7FoZxLH9tluBh6OoKi85gcUNBbK1DlkoQhkwHrxlrhEzOC7K9IUEATYHnsg==
X-Received: by 2002:a7b:ce8a:0:b0:3ea:f883:53ea with SMTP id q10-20020a7bce8a000000b003eaf88353eamr4782665wmj.7.1679476055525;
        Wed, 22 Mar 2023 02:07:35 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id d8-20020a1c7308000000b003ed1f6878a5sm16282877wmb.5.2023.03.22.02.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 02:07:34 -0700 (PDT)
Date:   Wed, 22 Mar 2023 12:07:31 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Jussi Kivilinna <jussi.kivilinna@iki.fi>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] wifi: legacy: rndis_wlan: clean up a type issue
Message-ID: <d1f250a3-653a-497d-9c92-12dd628b7927@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The rndis_bss_info_update() returns type bool.  Change the NULL
returns to false.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/net/wireless/legacy/rndis_wlan.c | 6 +++++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/legacy/rndis_wlan.c b/drivers/net/wireless/legacy/rndis_wlan.c
index bf72e5fd39cf..49e846a0fafd 100644
--- a/drivers/net/wireless/legacy/rndis_wlan.c
+++ b/drivers/net/wireless/legacy/rndis_wlan.c
@@ -1972,7 +1972,7 @@ static bool rndis_bss_info_update(struct usbnet *usbdev,
 
 	if (bssid_len < sizeof(struct ndis_80211_bssid_ex) +
 			sizeof(struct ndis_80211_fixed_ies))
-		return NULL;
+		return false;
 
 	fixed = (struct ndis_80211_fixed_ies *)bssid->ies;
 
@@ -1981,13 +1981,13 @@ static bool rndis_bss_info_update(struct usbnet *usbdev,
 					(int)le32_to_cpu(bssid->ie_length));
 	ie_len -= sizeof(struct ndis_80211_fixed_ies);
 	if (ie_len < 0)
-		return NULL;
+		return false;
 
 	/* extract data for cfg80211_inform_bss */
 	channel = ieee80211_get_channel(priv->wdev.wiphy,
 			KHZ_TO_MHZ(le32_to_cpu(bssid->config.ds_config)));
 	if (!channel)
-		return NULL;
+		return false;
 
 	signal = level_to_qual(le32_to_cpu(bssid->rssi));
 	timestamp = le64_to_cpu(*(__le64 *)fixed->timestamp);
