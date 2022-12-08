Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB9F647052
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Dec 2022 14:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiLHNAy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Dec 2022 08:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiLHNAx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Dec 2022 08:00:53 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6F08C69E
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 05:00:52 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id kw15so3615312ejc.10
        for <linux-wireless@vger.kernel.org>; Thu, 08 Dec 2022 05:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7OO2KHG058YoZvm8oeczbxoH51PktZ4F404Z0YI0wUY=;
        b=t79L3CEApL9wxNlXQmkcXk2pHUfIutULCchChTrDm9E94pbFKC04l2QldTYJv8gMDw
         zcj8AUNg04g73kdlc8pvDbfzNsv4Wfrz1yB1kig0QwEISwHVWisvHv+MZSXPoNycSWYZ
         /a6LmbEgeh0Gbeargnv4hBSejl4KkeRdKKmMPQhij2Ag9hS10DCamUcQHmH4s2qI7/qR
         5K1oJvW0YqH42yUigl/7Vy3KF4GbXJD6oDoi+NuTJ2og814PGu8Lk9mMldrkQvHA7iR/
         PrpvDgAij5qmvGyklTWdFFzgXpsmizvmC8hUdtW5s8pKc/UeuAyIRopB+LgFY7zWMIzp
         2Wwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OO2KHG058YoZvm8oeczbxoH51PktZ4F404Z0YI0wUY=;
        b=tQvqIvQK70N0sBb3X2Qg5h9L6UdO58BslSNxvIPJrN+bnO5YvTN6gzMHdiPP5tmsq8
         D8OluqMhp/Vi56bp9D1SCeFsbCV9Uz9oGnW8cJrUHyLTlIrWYFhaQj3Hb/IMuEbTe+I5
         lW4BB2kzFDDPcSMZvHXzYutoUHEU9yA53kSL/c6VjDt8CK3+CHoR8QGL3bScKb9VZ2ke
         kwgCTighteQMs/cZ9aXuoxZLR6xvOFeHg5dOWFUQmQcU7C8dd6OK4j0FO8sekPNxU775
         fL5t9hOK0tDizPx3/xpkN+HefD1r/aJqBVMAmbn5dhp8fnR7xxN8QVohcXhlEMcaebQT
         eMNg==
X-Gm-Message-State: ANoB5pltuOKcmoPfCna6Q2Bevu++M5IVoCHpgLszxD6efjgpnfavyUTE
        IaPIEjW0wKRk+oqCudLSdIc9RA==
X-Google-Smtp-Source: AA0mqf6gJybkq7/Yf6L6qrNgxRMNN6lp0z8eZRUGQJ5jkYeYBv/Y3gjiGtM297T3XTv3MMdNL281Ew==
X-Received: by 2002:a17:906:bcf3:b0:7c1:22a6:818c with SMTP id op19-20020a170906bcf300b007c122a6818cmr1302416ejb.46.1670504450560;
        Thu, 08 Dec 2022 05:00:50 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id l1-20020a1709060cc100b00779cde476e4sm9697495ejh.62.2022.12.08.05.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 05:00:49 -0800 (PST)
Date:   Thu, 8 Dec 2022 14:00:48 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Zhengchao Shao <shaozhengchao@huawei.com>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        stas.yakovlev@gmail.com, kvalo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linville@tuxdriver.com, weiyongjun1@huawei.com,
        yuehaibing@huawei.com
Subject: Re: [PATCH] ipw2200: fix memory leak in ipw_wdev_init()
Message-ID: <Y5HgAAVpYB9WQbz6@nanopsycho>
References: <20221208122630.2850534-1-shaozhengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208122630.2850534-1-shaozhengchao@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thu, Dec 08, 2022 at 01:26:30PM CET, shaozhengchao@huawei.com wrote:
>In the error path of ipw_wdev_init(), exception value is returned, and
>the memory applied for in the function is not released. Also the memory
>is not released in ipw_pci_probe(). As a result, memory leakage occurs.
>So memory release needs to be added to the error path of ipw_wdev_init().
>
>Fixes: a3caa99e6c68 ("libipw: initiate cfg80211 API conversion (v2)")
>Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>---
> drivers/net/wireless/intel/ipw2x00/ipw2200.c | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
>index 5b483de18c81..cead5c7fc91e 100644
>--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
>+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
>@@ -11397,9 +11397,15 @@ static int ipw_wdev_init(struct net_device *dev)
> 	set_wiphy_dev(wdev->wiphy, &priv->pci_dev->dev);
> 
> 	/* With that information in place, we can now register the wiphy... */
>-	if (wiphy_register(wdev->wiphy))
>+	if (wiphy_register(wdev->wiphy)) {

While you are at it, how about to take the actual return value of
wiphy_register() into account?


> 		rc = -EIO;
>+		goto out;
>+	}
>+
>+	return 0;
> out:
>+	kfree(priv->ieee->a_band.channels);
>+	kfree(priv->ieee->bg_band.channels);
> 	return rc;
> }
> 
>-- 
>2.34.1
>
