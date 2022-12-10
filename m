Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B0C648D31
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Dec 2022 06:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiLJFO5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 10 Dec 2022 00:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiLJFO4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 10 Dec 2022 00:14:56 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8ED1740A
        for <linux-wireless@vger.kernel.org>; Fri,  9 Dec 2022 21:14:55 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id o12so6865725pjo.4
        for <linux-wireless@vger.kernel.org>; Fri, 09 Dec 2022 21:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfSkCZZTaum/zbIaddE+5uqJoL8f+1OxNZGBKyqDKR0=;
        b=dXNgKW9kXZiNWmAf5EANHEXUZZ24EMTKJdVwwBBaQsvZt8S51qS7WO0YGl8rRxo1Nz
         cTFTqyOxygMNNZL3fYKjd0VSIkUOhk+e+9kMVv8fXtTgYOfPNLDu1ssPtRPj9fSusmIP
         63S22beFbiRA85akDwSiglmzRgxWZDWMqzGt0rwO4Ec3niIawyV0GlT+acrk+K1P9Pds
         Q+kaksZcCn9e++vNEXHLqsvU0q90mxmo/PYBJAW4iFvSDMRmkLwv04OKZgaFb0UltRl2
         h0KHPCwVoU/Gly/TH8per8w4B3j+ZygvNyPJV+v9DJxz9wcnki0402pvdMcBgS4uzb9X
         9GOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfSkCZZTaum/zbIaddE+5uqJoL8f+1OxNZGBKyqDKR0=;
        b=vlb/KVLD3ZEcA4XamwhjzSdsXxTHRUs6dHahlY68XDgat+dtU/cMjCOQDApW3tMsgk
         +hd13IxNMkQTspz0+6FeK3sBr5TTGY61cDvbGWzncx2MTMRSmdJFkZYMbdHboCTJBOBb
         H/ofdwKrbG7cHD3Jz6mNQD4KLTAzmisMKAEKv2LBEHfn22NyQgqyjHfqtxMpTtMfucSn
         AjNK7RwPw9ITaMTev/u+q62cfJIb6mt+QWNgEOqHSMhfUbJi0k0WINxQifuZ1L0QuFrj
         SHJCgElv7qKZfPvvsS1ZErIAIOo0T3MJKynCS96T1YcMVP1po1AkW+grtcpMBnoPCjpR
         ZWhA==
X-Gm-Message-State: ANoB5plj/z3Cdvn7YNueszR10nKokDefdzaiJLjFY8LNHoS17LZEKE6X
        JYt7AFevU86m+V+kan+a+kv/aBVrbDc=
X-Google-Smtp-Source: AA0mqf7+HBgVWD/Eg2UQIXV+4naLQTve61vPyHY3k4Q+lqoD4MGU67Cn1+87NFques1dUgMIPPmtgw==
X-Received: by 2002:a17:902:eb8b:b0:189:ced9:a5ff with SMTP id q11-20020a170902eb8b00b00189ced9a5ffmr9466308plg.26.1670649295111;
        Fri, 09 Dec 2022 21:14:55 -0800 (PST)
Received: from smtpclient.apple (c-73-63-191-127.hsd1.ca.comcast.net. [73.63.191.127])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902ce8f00b00178b6ccc8a0sm2154447plg.51.2022.12.09.21.14.54
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Dec 2022 21:14:54 -0800 (PST)
From:   Debbie Xu <debbiexu@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: NetLink nl80211 support on Android
Message-Id: <58B23AB2-C906-48C5-8BA9-9B4385FC838F@gmail.com>
Date:   Fri, 9 Dec 2022 21:14:53 -0800
To:     linux-wireless@vger.kernel.org
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I read from Android developers website recently, it looks like that =
Google is advocating Android developers to switch to AOSP higher-level =
API instead of Netlink sockets with nl80211 commands, to access WiFi =
interface.

Does anybody know whether/when the Netlink + nl80211 support will be =
disabled on AOSP?

Thanks,
Debbie=
