Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89912BC994
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Nov 2020 22:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgKVVf3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Nov 2020 16:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgKVVf1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Nov 2020 16:35:27 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F473C0613CF
        for <linux-wireless@vger.kernel.org>; Sun, 22 Nov 2020 13:35:25 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id 23so16665380wrc.8
        for <linux-wireless@vger.kernel.org>; Sun, 22 Nov 2020 13:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=ZZgCNMw6md/0ewSx8q1901FCHTLmznKQ1NqxVvEmywM=;
        b=Tf8TRrJP3/Zgo+p5lffJNzUGUix1OhY9MJBz8H4/PvoFNPSEcmop0lAuZvcr5kSAkO
         TMEKuI/Ivc7Rcg0Biu1KlUNeHaAnLD5+mCs/lmqEenC3ARbcZqsC3DoDjYKjoxappCv7
         0y0hEu85V+Woj0tPpNEqWNG0cU/gJ4YfUnbrXmh7l7qU2Xuj1jALBTOwylks+kXfG3HT
         ksbkvwkjBRynJY0QyoeVkCte4I4VfntoVxlnJC3c3bTCDkl6SH7BKQCswQIOKu3Tynsu
         ZaltpdOUvinfW9U2weUMBoFvwnun7+DR2GocDbSVdFbY31/iEZHRcY+70D8B9aLzLglN
         2ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=ZZgCNMw6md/0ewSx8q1901FCHTLmznKQ1NqxVvEmywM=;
        b=lDeCbEr8SIa+/ATe/+OanJet537tk5XRNsdVCeH2F/FJaHfSr9DE4fYRj9jCVQBjcC
         rWOzlhe0wk/9G/vvv8q0j3G7V1x96kudqG3dyYNh/RIaHX8lukmNEQ9NHzxtHMW6aWQF
         o5O6qNqPcmsdsEMdcfSndlHkmr7XYSERItZXTMY32ETlh8fqB1ua7FuO2W6rJDr0Cr4s
         wIvhGq3WmzjGSqyZqbKM18Kc8jY9HlZAZITouxJ57Y65jPdRr156JWRAloIcm1lHEbMC
         3eU0oZAzUSped21zK7HdRhjLw4a8wmUkw1ZBAZTr/Jwu6MySIS8MQOVch3+kgQrkSS9h
         TWug==
X-Gm-Message-State: AOAM533r+nsqaC9R5yD9EvZy1JWBEPkg7WTFAyhr4ovCAxjq60fQ46Jm
        7Y1UCx4qTbaWsDIvk+z2F8r5ZW0MiarFpg==
X-Google-Smtp-Source: ABdhPJyz5NLw7NlO/qe6JwQKj16WwNoXQ5PX05zVGULfCi6D8jNPV9+jj1lbXtAh9D32WLYofY4zEg==
X-Received: by 2002:a5d:6411:: with SMTP id z17mr27781207wru.112.1606080923750;
        Sun, 22 Nov 2020 13:35:23 -0800 (PST)
Received: from ?IPv6:2003:ea:8f23:2800:2dfa:b12a:a00c:90c6? (p200300ea8f2328002dfab12aa00c90c6.dip0.t-ipconnect.de. [2003:ea:8f23:2800:2dfa:b12a:a00c:90c6])
        by smtp.googlemail.com with ESMTPSA id e5sm14603931wrs.84.2020.11.22.13.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2020 13:35:23 -0800 (PST)
To:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: AX210 version 0024 not detected by iwlwifi
Message-ID: <03e8284e-4ea8-fe3e-8da7-62a778b1a059@gmail.com>
Date:   Sun, 22 Nov 2020 22:35:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I have an AX210 card that isn't detected by iwlwifi.

01:00.0 Network controller: Intel Corporation Device 2725 (rev 1a)
        Subsystem: Intel Corporation Device 0024

Adding following entry seems to be sufficient.

        {IWL_PCI_DEVICE(0x2725, 0x0020, iwlax210_2ax_cfg_ty_gf_a0)},
+       {IWL_PCI_DEVICE(0x2725, 0x0024, iwlax210_2ax_cfg_ty_gf_a0)},
        {IWL_PCI_DEVICE(0x2725, 0x0310, iwlax210_2ax_cfg_ty_gf_a0)},

[  419.473140] iwlwifi 0000:01:00.0: enabling device (0000 -> 0002)
[  419.486984] iwlwifi 0000:01:00.0: api flags index 2 larger than supported by driver
[  419.487190] iwlwifi 0000:01:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 93.8.63.28
[  419.488828] iwlwifi 0000:01:00.0: loaded firmware version 59.601f3a66.0 ty-a0-gf-a0-59.ucode op_mode iwlmvm
[  419.533136] iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6 AX210 160MHz, REV=0x420

Maybe there are more AX210 subversion id's to be added ..

How about the api flags index warning? I saw it in several posts,
is there something to be fixed in the driver?
