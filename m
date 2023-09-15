Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D267A18DA
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Sep 2023 10:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjIOIaX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Sep 2023 04:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjIOIaS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Sep 2023 04:30:18 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BCFE7E
        for <linux-wireless@vger.kernel.org>; Fri, 15 Sep 2023 01:29:35 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-401b0d97850so19186945e9.2
        for <linux-wireless@vger.kernel.org>; Fri, 15 Sep 2023 01:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694766574; x=1695371374; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wPnaOK9X13JDSk44+hj7zKjHWfxilVpyWkw4Bt4nUf8=;
        b=zks+HvYr3hSPQAsePCietKGcqAmQtcf2dEWb+h5gOZQhB2PTRjk4dKWHaW45Oj+Ymj
         BpRwHIc+hJT49KBAtMPeBsFyMUZ9w8QsGpvl+E8w4aBcG3s9qhGVJ1itYtmq7sPSBfyh
         XWRAYS8mgYysEH3psXQ25Aaxa0g3+Wihfa6EWA0YLmZ++xWU1aDVwiWB4HDJnpFa6tAY
         W/aMh/wjaWAh9tyTEZBwhI6om2tzT8d7VYWjEU8apUn8jHJL9zRYkNJ6kZDt8TyYgzl5
         tTQ5bX12094LaFDMo8wV+12X40/OlH242bXjMfFN4M1PopI/W+epiRukmoy7pFG73V2u
         xeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694766574; x=1695371374;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wPnaOK9X13JDSk44+hj7zKjHWfxilVpyWkw4Bt4nUf8=;
        b=aiQADmqWY2m2Sd9fIm4xREVt7Qx74YiYfRklaaKeZex8uRt99P9e9M/3fXORWaOMBo
         ++k6KA1KJ5QPTqNzH3AozsvH0ZcYZjF5v+JgaEimnGVCwLfIHz7N/N1AbBHSDBe8C5TR
         nYSwMv64zAv2NutlHN9EIPDXGlC6a3cA+OCER9d5uUHAORIeXKiUwCNThRPp58EIfDmp
         zranO2eRzQiawGF0X92xLrhsCmKbay/NtU1ksBl/fN0x5Y8ja/uRcPQlVm4G09gxHbWV
         4yXXYNEI/6BYkr3upvTTJEHiqdrrqvTQTLf9PxBkhggzdCs3kcleYnIoRMjhy8jcTsNU
         aNWQ==
X-Gm-Message-State: AOJu0YzTzIpygeY+mG+WQzmq1GJ8LzxT2pS6yi1rszOcuHDum60P4P47
        d9+oCWIzzH1DYkbmZgoX6bXkRQ==
X-Google-Smtp-Source: AGHT+IHj1TFHQb0m0RBwQMxstJzquzfOLYrNuiKiggEBMK+r1HS47p8gMoWerqn/MudnzcGm/bKKNA==
X-Received: by 2002:a1c:6a0a:0:b0:404:7462:1f6f with SMTP id f10-20020a1c6a0a000000b0040474621f6fmr868938wmc.8.1694766574117;
        Fri, 15 Sep 2023 01:29:34 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c214d00b003fc16ee2864sm3969752wml.48.2023.09.15.01.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 01:29:33 -0700 (PDT)
Date:   Fri, 15 Sep 2023 11:29:30 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     johannes.berg@intel.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] mac80211: accept key reinstall without changing anything
Message-ID: <220d9f82-c010-4c57-82ec-60bdedc5efcd@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Johannes Berg,

The patch fdf7cb4185b6: "mac80211: accept key reinstall without
changing anything" from Sep 5, 2017 (linux-next), leads to the
following Smatch static checker warning:

	net/mac80211/key.c:1385 ieee80211_gtk_rekey_add()
	warn: 'key' was already freed.

net/mac80211/key.c
   899  
   900          /*
   901           * Silently accept key re-installation without really installing the
   902           * new version of the key to avoid nonce reuse or replay issues.
   903           */
   904          if (ieee80211_key_identical(sdata, old_key, key)) {
   905                  ieee80211_key_free_unused(key);
                                                  ^^^
key is freed here.

   906                  return 0;
   907          }
   908  

net/mac80211/key.c
    1375                 return ERR_CAST(key);
    1376 
    1377         if (sdata->u.mgd.mfp != IEEE80211_MFP_DISABLED)
    1378                 key->conf.flags |= IEEE80211_KEY_FLAG_RX_MGMT;
    1379 
    1380         /* FIXME: this function needs to get a link ID */
    1381         err = ieee80211_key_link(key, &sdata->deflink, NULL);
    1382         if (err)
    1383                 return ERR_PTR(err);
    1384 
--> 1385         return &key->conf;
                        ^^^^^^^^^^
Use after free.

    1386 }

regards,
dan carpenter
