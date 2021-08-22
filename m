Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B4D3F4093
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Aug 2021 18:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhHVQts (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Aug 2021 12:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhHVQtq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Aug 2021 12:49:46 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9996EC061575
        for <linux-wireless@vger.kernel.org>; Sun, 22 Aug 2021 09:49:05 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id y6so26875155lje.2
        for <linux-wireless@vger.kernel.org>; Sun, 22 Aug 2021 09:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=kj+F/iivvvpon61c7DD9W/irW+je8k1Oa5+INDP5Jrk=;
        b=L6OCr7wdb7keKFej8krtdy0G1ItcZxQTdGV9XqIBAdNfiWHdVnUDP0c2cxH0/fOhr5
         KgXzwR8nrvmz34cS8iGEbd7ciKVMlJG4KNaM5ChmpvqJM1/eHuWm+Pq9eYLDvW4DnTv4
         w1XODFFGLWFw39llHUk7ypbnUOqglJ/AgglXt26eUsvyFn/WifNnYzt3+llmD8/0zKtV
         OZv4HmnWQ59EOeRScfCdyC6Btl0qIuDxC/YGekPOYX2+m/bhAE6DqCGcek6sniT7hhQf
         w20/cvPNRig+/EdjYuSJlbf6ptkMlr8eGx2wOYhfVh7ulwbmf0KPihkD0dlqJlvuOJWN
         e2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=kj+F/iivvvpon61c7DD9W/irW+je8k1Oa5+INDP5Jrk=;
        b=C4OnN7rXzm9x7fU2RIXfXSjlOm/TISD4t+ShO2tkV4uMDd98rKKBrl8JxioQIcHImM
         4ko2g6+0fxadccpq+AmyekhQYlu2e8bDtvPKsR/NmOuoF5ZuDSbSc+P2lVJobdaR9gvu
         DRQJ0lpjhO+iMd8ao08GNYE8NyJ67gy5kQ5f7UXNJTj5zh+FiiTpyaiCxndEOKOh1uy4
         du3ljdlW/kx/qKqfP7hFhgr71IHM09BGQcqNNWnmJ8Wh7l1U2fzMQMpZBdsyiTx76Wah
         lPqj6d1EgM6Sj+dSDEe54IaYdk9VxC4oq4IBgp9lN5Y1QPkuUQvtDWT0chM4k3Ex8dWz
         NEZg==
X-Gm-Message-State: AOAM533AMCElXb1rHYyF6cHRcskYU2DSwLz+hboNi5wCrAH/IWxImFTk
        sOYooi6L2vYKj/Hxy7cBbdnXf0NdpvQ=
X-Google-Smtp-Source: ABdhPJzWplplqm5odJS3im829yPVY/Ppj/Hl+97zaQRmiJ+EMwyujosNwE9vDyKw8KtVzUJfjK6lIA==
X-Received: by 2002:a2e:b80c:: with SMTP id u12mr24643290ljo.436.1629650943638;
        Sun, 22 Aug 2021 09:49:03 -0700 (PDT)
Received: from localhost ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id a22sm1230098lfl.259.2021.08.22.09.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 09:49:02 -0700 (PDT)
Date:   Sun, 22 Aug 2021 19:49:02 +0300
From:   Andrey Skvortsov <andrej.skvortzov@gmail.com>
To:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Cc:     Wen Gong <wgong@codeaurora.org>, Kalle Valo <kvalo@codeaurora.org>,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Brian Norris <briannorris@chromium.org>,
        Julian Calaby <julian.calaby@gmail.com>, svp <svpm@yandex.ru>,
        felix+debian@gueux.org, Massimo Maggi <me@massimo-maggi.eu>
Subject: Revert: ath: add support for special 0x0 regulatory domain
Message-ID: <YSJ//ki/A1EgfLga@skv.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

this patch broke several 5GHz AP in my home based on different Atheros
cards (ath9k and ath10k). Both of them have FCC ID and were purchased from
different suppliers (EU and non-EU) in 2020 and in 2018. I know many other
users are affected as well.

I know this problem was discussed several times already. But I have a
couple of questions.

1) Current behaviour maps 0x0 regulatory domain to the most restrictive
world domain. According to the wiki (probably based on Atheros
documentation) 0x0 means US. Does wiki contain wrong information?

2) If I understand correctly, 0x0 is always replaced with 0x64 and that
makes the following code useless, because it will never be executed. Is it
ok?

drivers/net/wireless/ath/regd.c:703:708

if (reg->country_code == CTRY_DEFAULT &&
        regdmn == CTRY_DEFAULT) {
            printk(KERN_DEBUG "ath: EEPROM indicates default "
                "country code should be used\n");
            reg->country_code = CTRY_UNITED_STATES;
}

3) Previously it was possible to get regulatory information using 'iw reg
get', but now it doesn't work anymore. Is it expected behavior?

[--------------------4.19 ---------------------------------]
# iw reg get
global
country 98: DFS-UNSET
(2400 - 2483 @ 40), (N/A, 20), (N/A)
(5150 - 5250 @ 100), (N/A, 20), (N/A), NO-OUTDOOR
(5250 - 5350 @ 100), (N/A, 20), (0 ms), NO-OUTDOOR, DFS
(5650 - 5730 @ 80), (N/A, 20), (0 ms), NO-OUTDOOR, DFS
(5730 - 5850 @ 80), (N/A, 20), (N/A), NO-OUTDOOR
(57240 - 66000 @ 2160), (N/A, 40), (N/A), NO-OUTDOOR

phy#0
country US: DFS-FCC
(2400 - 2483 @ 40), (N/A, 30), (N/A)
(5150 - 5250 @ 80), (N/A, 23), (N/A), AUTO-BW
(5250 - 5350 @ 80), (N/A, 23), (0 ms), DFS, AUTO-BW
(5470 - 5730 @ 160), (N/A, 23), (0 ms), DFS
(5730 - 5850 @ 80), (N/A, 30), (N/A)
(57240 - 71000 @ 2160), (N/A, 40), (N/A)

phy#1
country US: DFS-FCC
(2400 - 2483 @ 40), (N/A, 30), (N/A)
(5150 - 5250 @ 80), (N/A, 23), (N/A), AUTO-BW
(5250 - 5350 @ 80), (N/A, 23), (0 ms), DFS, AUTO-BW
(5470 - 5730 @ 160), (N/A, 23), (0 ms), DFS
(5730 - 5850 @ 80), (N/A, 30), (N/A)
(57240 - 71000 @ 2160), (N/A, 40), (N/A)


[--------------------- 5.10 --------------------------------]
#iw reg get
global
country RU: DFS-UNSET
(2400 - 2483 @ 40), (N/A, 20), (N/A)
(5150 - 5350 @ 160), (N/A, 20), (N/A), NO-OUTDOOR
(5650 - 5850 @ 160), (N/A, 20), (N/A), NO-OUTDOOR
(57000 - 66000 @ 2160), (N/A, 40), (N/A), NO-OUTDOOR

[-----------------------------------------------------------]

4) As many users are affected by this problem and maintainers don't really
want to revert the problematic patch, is there any other solution to make
AP work again using a clean mainline kernel? Firmware upgrade or any other
solution? What should we do with non-working hardware now?

1. https://wireless.wiki.kernel.org/en/users/drivers/ath#the_0x0_regulatory_domain

P.S. sorry, I've resent the message using other MTA, because it wasn't delivered to MLs.

-- 
Best regards,
Andrey Skvortsov
