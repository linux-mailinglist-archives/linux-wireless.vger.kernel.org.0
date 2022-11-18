Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CAB62FADE
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Nov 2022 17:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242360AbiKRQy6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Nov 2022 11:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241367AbiKRQy5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Nov 2022 11:54:57 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82ACF6A764
        for <linux-wireless@vger.kernel.org>; Fri, 18 Nov 2022 08:54:56 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id z26so5422697pff.1
        for <linux-wireless@vger.kernel.org>; Fri, 18 Nov 2022 08:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qkJ6eq/fIahCF8o8UiVfnfFhlL7awmXBJQtRWOpGmqU=;
        b=UogA1CMJuDCS5kW93n44fMAJHDPCoXm/kKTw86eNm8lbL18uCLPvJ8jJQvRyaBwV0J
         zshx3ls6pm30x5NULXL6Q1ZA+b+N2IWs6NECGAVbA0AHECidbuzdgxX/N6kVG1BHqHPo
         OKRH2/o0DU7FlwYadK4GvZBUV4OycoXpPrhcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qkJ6eq/fIahCF8o8UiVfnfFhlL7awmXBJQtRWOpGmqU=;
        b=S75d+zvAE7lc96QRGk6dxv4Ln3ZGiAnA4NnyOeeZdCkA16P5PHf29cpX/jyjM8TRPV
         ALSoZcTkEMDxQBSs+tEPpNC/zhIOYUS4t/pcjYFQSAKsW2aPH8vV35MszTO/h2lhsk1M
         szpua80FLY4pudfiUSkUHAFOfcrmxrt/PrbLEZfKH54oaY2F7iL6+I608+0si6zu2+pQ
         C7ciYZgwRIU6/uVitX8me1bgMVj0wlKdBjQX7Hwq9n9cI7xBmNSqIfk5hwdPMjTi+UhQ
         wnoRm3Gccsb0vUdo8DVoNsfUQEuDdha8u2lB2ShgLiihKPHuwRzHNuYATe6Jcf0rFL8+
         cV3Q==
X-Gm-Message-State: ANoB5pnlGDuKVaEGhGkiJ164k/2GAi115reNdDMx2olU2ZOYwmJzvlw2
        hSGz+horLpR76FbUm8tl+sqRCT86sZ3R2Q==
X-Google-Smtp-Source: AA0mqf4TdqgLeKRagwwALD8Gxu+PQC0hD+r1aGZbWUB3kl2trIcaAzvMBP0naIGIsuzPtEcUTtpH4Q==
X-Received: by 2002:a63:1c66:0:b0:476:c782:e5d1 with SMTP id c38-20020a631c66000000b00476c782e5d1mr7298165pgm.261.1668790496027;
        Fri, 18 Nov 2022 08:54:56 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f7-20020a625107000000b0056b818142a2sm3391659pfb.109.2022.11.18.08.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 08:54:55 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Fri, 18 Nov 2022 08:54:54 -0800
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     Luca Coelho <luciano.coelho@intel.com>,
        Haim Dreyfuss <haim.dreyfuss@intel.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Petr Stourac <pstourac@redhat.com>,
        linux-kernel@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Nathan Errera <nathan.errera@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Shaul Triebitz <shaul.triebitz@intel.com>,
        netdev@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>,
        Abhishek Naik <abhishek.naik@intel.com>,
        Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
        Ayala Beker <ayala.beker@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org,
        Sriram R <quic_srirrama@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>,
        Mike Golant <michael.golant@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: iwl_mvm_sec_key_add(): Memory - corruptions
Message-ID: <202211180854.CD96D54D36@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20221118 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Thu Nov 10 13:26:51 2022 +0200
    5c75a208c244 ("wifi: iwlwifi: mvm: support new key API")

Coverity reported the following:

*** CID 1527370:  Memory - corruptions  (OVERRUN)
drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c:123 in iwl_mvm_sec_key_add()
117
118     	if (WARN_ON(keyconf->keylen > sizeof(cmd.u.add.key)))
119     		return -EINVAL;
120
121     	if (keyconf->cipher == WLAN_CIPHER_SUITE_WEP40 ||
122     	    keyconf->cipher == WLAN_CIPHER_SUITE_WEP104)
vvv     CID 1527370:  Memory - corruptions  (OVERRUN)
vvv     Overrunning buffer pointed to by "cmd.u.add.key + 3" of 32 bytes by passing it to a function which accesses it at byte offset 34 using argument "keyconf->keylen" (which evaluates to 32). [Note: The source code implementation of the function has been overridden by a builtin model.]
123     		memcpy(cmd.u.add.key + IWL_SEC_WEP_KEY_OFFSET, keyconf->key,
124     		       keyconf->keylen);
125     	else
126     		memcpy(cmd.u.add.key, keyconf->key, keyconf->keylen);
127
128     	if (keyconf->cipher == WLAN_CIPHER_SUITE_TKIP) {

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527370 ("Memory - corruptions")
Fixes: 5c75a208c244 ("wifi: iwlwifi: mvm: support new key API")

keyconf->keylen is only bounds-checked against sizeof(cmd.u.add.key),
but the memcpy() is starting a write at key + 3.

Thanks for your attention!

-- 
Coverity-bot
