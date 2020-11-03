Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BFA2A4FD5
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Nov 2020 20:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgKCTR3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Nov 2020 14:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgKCTR3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Nov 2020 14:17:29 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EAFC0613D1
        for <linux-wireless@vger.kernel.org>; Tue,  3 Nov 2020 11:17:28 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id gn41so8587054ejc.4
        for <linux-wireless@vger.kernel.org>; Tue, 03 Nov 2020 11:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=5kNCjmO9xwLdAkLb/sFX7P25NLxMwYunPPD7wkaIBBM=;
        b=qqbsRUqTzpkxKS3W6z1wCXxeeC4dnpkClSDLP4+T+WPc34D+yhdwhSUsudGVvnNFIe
         jnTnDV7yiOK+EBnRnRZwDMYYih8xC3Oif/B9UpIzF+88OYupDxVg2N0HQ/CNMkcSbil6
         idWG+UuZVKlssgYZhwpVGH169zR0KPpykMIJM53f8S57h5dMtabfRZY6JR4pQyHpqG7Y
         jyStx1L83iUtexVH6PSrxWjQhcr4waVaSrtNE61uGPjsCNvB4ZEFsZlPKR2+KZPM9uYQ
         OqWq2p4SNHcsBHmvFKROAQDwVK2S+EMgKlvZJJpF5LWgKwZxpOXo1FIhFI6CpXLC0Mdb
         8NlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=5kNCjmO9xwLdAkLb/sFX7P25NLxMwYunPPD7wkaIBBM=;
        b=bhDQhPiuFGlgrul3bPii9cmfmWXTGSRtU616aAwIs+WCHAQr6Qdj8QTYpER8O9Z4tl
         H/bqkBZAb3K+s1/Te14B8M2gQ6DamdB8DkMou0P5QKnKEthf30F49SjyW6lS+uUB3e9N
         bTVQCPSdXWVysGrupi8lf1lQnK3YBn0AqTpLUzDz9v28KAUVk1EtQOjvjk8UxgeGD6m5
         GKd/DAzJWU0y2NxxoGLqgXmP7jL8sFiG03IEZyRSddtwFrlFspRRKEoY7UVPFzyt5ub5
         R0jXW+cyExn8T4MM5yzmF0wwJ9lsFw8+b0YgzoxqGpEOn4j4PixH6N92AUWUevKQ4hh7
         YMLQ==
X-Gm-Message-State: AOAM530NHLeQephUrOMkwSO5YxpgNMb8M07sR64k7QWQ4lstFf9gPLL4
        soX1F4Sk00w2QZQOqUqyaKAOB8eWrwY1jA==
X-Google-Smtp-Source: ABdhPJzvG7QMx6NWxdWiZ3cMz08gS1b5wTQQo78Jl2G46WQuXbCH4TW2SqVdVLTZTPhe/baBTcxCzQ==
X-Received: by 2002:a17:906:c0c1:: with SMTP id bn1mr1687499ejb.454.1604431047616;
        Tue, 03 Nov 2020 11:17:27 -0800 (PST)
Received: from eeec (host-95-244-250-221.retail.telecomitalia.it. [95.244.250.221])
        by smtp.gmail.com with ESMTPSA id j3sm12547632edh.25.2020.11.03.11.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 11:17:26 -0800 (PST)
Date:   Tue, 3 Nov 2020 20:17:25 +0100 (CET)
From:   Enrico Mioso <mrkiko.rs@gmail.com>
To:     linux-wireless@vger.kernel.org
cc:     linuxwifi@intel.com
Subject: WARNING: CPU: 7 PID: 259 at drivers/net/wireless/intel/iwlwifi/mvm/tx.c:1488
 iwl_mvm_rx_tx_cmd+0x42d/0x760 [Linux 5.10-rc1]
Message-ID: <46f977fb-8a8b-ddc6-b1f6-377e643344f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello!!
I am experiencing this issue any time I bring down my wi-Fi card. my Wi-Fi card:
iwlwifi 0000:03:00.0: loaded firmware version 17.3216344376.0 7260-17.ucode op_mode iwlmvm
iwlwifi 0000:03:00.0: Detected Intel(R) Dual Band Wireless AC 7260, REV=0x144
The warning is this one:
WARNING: CPU: 7 PID: 259 at drivers/net/wireless/intel/iwlwifi/mvm/tx.c:1488 iwl_mvm_rx_tx_cmd+0x42d/0x760 [iwlmvm]

The macine is:
DMI: Dell Inc. Precision M6800/0CF0TC, BIOS A14 05/24/2015
Please keep me in CC as I am not subscribed. Not posting full trace due to the comment in the tx.c file at the specified line.
The bug is not 100% reproducible, but with some patience, it should be reproducible.
It happens specifically when I kill hostapd. I also bring down the interface manually later, even knowing it's useless.

Thanks!

Enrico
