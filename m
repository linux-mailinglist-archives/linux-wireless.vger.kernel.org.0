Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAE23D3539
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jul 2021 09:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhGWGtH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Jul 2021 02:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbhGWGtG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Jul 2021 02:49:06 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4B7C061575
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jul 2021 00:29:40 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id b25-20020a4ac2990000b0290263aab95660so177286ooq.13
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jul 2021 00:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=yf0KoklWovY/OTTG8zwRfWU5yPhljcwry8QJCsRfdNQ=;
        b=VzYQUjbVLEI6gS5GKjYSFLi4UOyWsB7fTNMT/FMZuOZGnVCgQST1gpNdyA4/6V8PfU
         YACuC+NTBrJklWfr2HX8SsxlLzNhz9LWWrDTd5DP7d5ZczcQJ69lixqubztxSHyVyhf3
         bvnckPSauAvIXDQ8eVjzQIisl+ZwsbLxCGergBeLSdWYZ/2yyBwffI9aHdYFkk8RwBHW
         4ArXzUOsTAQABSrIczEvbPlwh0UCKFsD/FOtKbjV3d9iK0EqOjlFtNeWQl6iVUoL8WJu
         RvOWOzN8fpA0poJcqzrwbRkEAwvRzhbevYpyL/s6wPhgVJDV6JV0Nr1LB9mNNHakDgyG
         vjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=yf0KoklWovY/OTTG8zwRfWU5yPhljcwry8QJCsRfdNQ=;
        b=samyYkURsYJeHoqNhW8Mh3mOgsX1CG+HLrdHjNLz2t7lFBlyDXwpwCDQ36LvGc8PeE
         jAlwSwhvK/azKI8YKB1ghMaQUoJVuM6Jg9OsDLXiRcMBCvrK1o34PNHa9P7AvaCJ1JQ0
         UhbK8MqM24p4Zz8wFwHKaI5Got9O0/fWB+9rVm/kfZZ9BqMJaYv97D9hV4ACrq29DGMl
         R5nF6AeZWdifRjDHugm886kuEEHndtNvfOikpy2iJdYzyU8qXMesfkdogbgWay1gHz5H
         wlJ8nIGKIV6joIlS+Vsshvq/0EmTTz5Tfbu8YhUYIKTM0XG6FGbQXTzrjrV0ysf0BdC7
         qTgg==
X-Gm-Message-State: AOAM532LtJQXcl0GvTVrgPCsmaYfJtrmo8f/B92Ad0ee85uxpCGrGp76
        WDehXartheR03qdzOOgJls52nps6wem40e97wowL2vSyypLhbA==
X-Google-Smtp-Source: ABdhPJxpa/zzhmCZ5yAmcWx8gX49QqZEIFKriGAeym3SGe+BMkjytuv4iha/ceOjFdJHD2ha48p9Ua39H5BNzrkCWhA=
X-Received: by 2002:a4a:4c55:: with SMTP id a82mr1882412oob.84.1627025379287;
 Fri, 23 Jul 2021 00:29:39 -0700 (PDT)
MIME-Version: 1.0
From:   Govind Singh <govind.sk85@gmail.com>
Date:   Fri, 23 Jul 2021 12:59:29 +0530
Message-ID: <CAO_MH4amptKSBGGj7mPgnVeXPEdo=aB8R6N9-Y1J3MZiOWTBZQ@mail.gmail.com>
Subject: reg 802.11s support with SDIO based Wi-Fi Modules
To:     linux-wireless@vger.kernel.org, kvalo@codeaurora.org,
        ryder.lee@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I am investigating if any SDIO based Wifi Module(not EOL) supports
802.11s mesh mode.
Can anyone share more details if support is tested/deployed with
upstream driver by any vendor with SDIO based radio?

Based on the available information and looking at the source code I
have below observation.

SD8987/97(mwifiex): not supported as NL80211_IFTYPE_MESH_POINT is not handled.

QCA9377(ath10k): Driver support is available. Does QCA9377
FW(WLAN.TF.2.1) support the same?


MT7663(mt76): NL80211_IFTYPE_MESH_POINT is handled and advertised in
wiphy if combinations. Is FW support available and tested?

BR,
Govind
