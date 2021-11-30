Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5B5463E8A
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Nov 2021 20:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245734AbhK3TUX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Nov 2021 14:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343499AbhK3TUQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Nov 2021 14:20:16 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2A9C061574
        for <linux-wireless@vger.kernel.org>; Tue, 30 Nov 2021 11:16:56 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id o13so46593509wrs.12
        for <linux-wireless@vger.kernel.org>; Tue, 30 Nov 2021 11:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=ke6qYn4L1dD4yyUdywk/RaQttoSjgqO/YSfbUwxrZn4=;
        b=bruIPCVqgHj+pTxMLgHWSeTsTVmKuQl2WzKrxkKUQrBDWvE8VfkMM7TQO9z36BJNCr
         ceO/Zq1qhKI2nL/kL7Azu937FiFMsBC5jWeyznPc3DosqeBqegdXHHoM+UavEdcpk7u7
         UWrXdrrkpK++3bRF0bNeuqjUc7h7UzbHb5Gz12BPNKsJ2k59ppbiFR/QK0jPnB6Qdnp9
         m0T1s+rrvXh2cUPRuPujDDxJDKwp4zN2hEgLsTES/ZztvlD9DbpOrQHJoxsJdfH4jr+a
         +hU7FUiYT8ItWp/vq8PqT1y6L+XzT4C+BRlXiF/ClIyCBddUu3Owa6bYIc73lMrOPoOC
         gwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ke6qYn4L1dD4yyUdywk/RaQttoSjgqO/YSfbUwxrZn4=;
        b=FLbZ/sLc6kN1L4EKC0H2bEnJ/+ebNwLYbbMGWYBTU3AO1FvpbA5j8I7Y5jPc6dJy5m
         ltsLqXXp2RZHQrejjrDQ8W7H6PvQCTUl+moD95miOq/uQ2gzNqpQlN9/vgUkQGVAU5JH
         8E+nhmaFTJX53RE6opQqa9vZshiBqNsLWBY5EBTTUp31PUKlP6YohcXqJ8C2n+jG7twE
         cGiuxy8atzEq4bgOdSqbxuAeFADAPO3EoSxk+glF1uQ8hcAyseuP0cQvV8efUHw5di16
         QhbPOEmle9kWzp4e/8aDYyNzwFzn4RNoAgzLRWPW7rUsxlnTulod1/Ccvdf2GT0C2Sap
         2jIw==
X-Gm-Message-State: AOAM530Z7iQC2azZ3rW1TGMNrFbnvNFGA8svqcQydhyOeiGC6Hf4/fJV
        QNhA3uk+lJO3QamG5NiR4Vub4VjHYCSWu47bkw6e0NoPxZ8bVA==
X-Google-Smtp-Source: ABdhPJw7LeH257sOEAZmQEbdPlVJdOFmJqCWuWk5Lk13ViiDlDoK6ZJu34gnFrerO14LGgfbwjY98ziXJos+1Hr2PMo=
X-Received: by 2002:adf:f60e:: with SMTP id t14mr1079269wrp.112.1638299814507;
 Tue, 30 Nov 2021 11:16:54 -0800 (PST)
MIME-Version: 1.0
From:   Jeff Clay <jeffclay@gmail.com>
Date:   Tue, 30 Nov 2021 13:16:18 -0600
Message-ID: <CACJOGMP0k1AH9Coz2DjZjkeoxPGjSyP60MYMSHrMN-hSJrrvTQ@mail.gmail.com>
Subject: Latency spikes in rtw89
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, I am using the rtw89 driver for Realtek 8852AE in my Lenovo T14
AMD Gen2. I have obtained and installed this driver from source at
https://github.com/lwfinger/rtw89/tree/main I am having an issue where
the latency during a ping test to hosts on my LAN spikes to 200ms or
above. According to lwfinger, this is known and acceptable
https://github.com/lwfinger/rtw89/issues/85  However, I am hoping I
may be able to work with you to resolve this issue as a tester.
