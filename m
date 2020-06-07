Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469901F0FD7
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Jun 2020 22:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgFGUkO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 7 Jun 2020 16:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgFGUkO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 7 Jun 2020 16:40:14 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BECC08C5C3
        for <linux-wireless@vger.kernel.org>; Sun,  7 Jun 2020 13:40:14 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id q19so15994576eja.7
        for <linux-wireless@vger.kernel.org>; Sun, 07 Jun 2020 13:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ZjKSDlwTzQLky7DtmNI0YbCRxrwYsYIAMlfqbe58+7E=;
        b=DY4LOKye/a0QSHIEaQVVQfa9lrvA1rCP4ouhdFTH6vG0jJolnqqFcuAnOw+IDvw7dK
         8FaYYqCpFMw2SVYjDeTPGY1Ge9wUF04pAqert1sM7SeNtX9Is7uk7TyioNq7+X1WdD2T
         EGth0QrjNwMRTbubU78xqfmGiFUndjuSRUMif0Xk4Wy2+/xGvoFUUiWnNoXS+vMQxjIK
         xj4RnMaQPfu06ARxnkM4hwgFIUbJuVFJLZv/DAWuHyYTLDa5NeDGM+JN/W8vVhCMJpkf
         hPkKmThPYG5yd76S0c+crxRYOr2/COVQyyv7I8LuXaj3Q6IUN2Gv0GacWEeC2gCYHPLm
         qxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ZjKSDlwTzQLky7DtmNI0YbCRxrwYsYIAMlfqbe58+7E=;
        b=RaTDtAWkIBcAXGR3mht1ypreOo00u5rjYsJROJ8qDUQ3GF3a8vm5j+XOovu9lFfb5H
         dapja1Nc9rR21bcX4pW5Seq/bcv5f21zEg3OoJsOld+uxMprziqlArz2VSxKDccboMEt
         P2CITLV/MZE96v2heUq2g/8eqrzxK3irW+5b3bkJ+yTFWMmT9hQywHbheJ7j24Kxln/g
         Mv15o56fZexXVisSzfefIzhBELDDiNkbGJohHqgIwNdlw/phC0St93cbUtPTZxamk3hF
         peW07cl582Zs4Y0eWNfRyjW7chdjW9iAhZFE7/S1sl5EH6+xzC2NVXqCBdRbdWhFh/fh
         0Bzg==
X-Gm-Message-State: AOAM533knTJ/6eL5kBjSNJ5tEcAzYgQncN88kyKD/J5w3eqm5FwPfaYV
        S1ZocJTCiOYYrI9J11rEVtQuXFOzbyaCx7yZbufc+KIUcf0=
X-Google-Smtp-Source: ABdhPJxUrRvCm+Yb1lHp+QEgjyn+K5OUER9mTcoSNgjV9ma29gXhiT8ArQn8ZxoAR7MD70yE9C8Xr32Qe6a4U0GhJTw=
X-Received: by 2002:a17:906:b41:: with SMTP id v1mr17713430ejg.147.1591562412464;
 Sun, 07 Jun 2020 13:40:12 -0700 (PDT)
MIME-Version: 1.0
From:   Lorenz Bonat <lorenzbonat2@gmail.com>
Date:   Sun, 7 Jun 2020 22:39:36 +0200
Message-ID: <CABcAdhgcbNWMRh5t7_dH_d2-nrTV0xwjR-Zu3e8cfF29SnM4kg@mail.gmail.com>
Subject: Many errors on dmesg and weak signal with driver rtw_8822be on
 Kubuntu 20.04
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

To whom it may concern,
I am using the last available driver on the lwfinger github
repository(https://github.com/lwfinger/rtlwifi_new/) for the RTL8822be
adapter. I am using kernel 5.7.0 and my laptop is an HP Envy x360
ag000xx series. I persistently have struggled with the signal
stability of this chip, and it continues to spit out errors into the
dmesg log. The signal strength is lower than in Windows 10, and when I
try to speedtest my internet connection I see a lot of variance
between runs.

The internet is unusable when surfing the web, and it is very annoying.

I have opened an issue on the repository of lwfinger, i will link it
for you because there are a lot of explanations there already.
https://github.com/lwfinger/rtlwifi_new/issues/607

I am attaching a file with all the dmesg entry outputted by the
rtw_8822be module(dmesg | grep rtw). I have noticed that I receive a
lot of "timed out to flush queue 1" errors and after a while the
driver crashes and I receive a "purge skb(s) not reported by firmware"
warning.

If you need more information please let me know, and I will provide
them. I am willing to test any experimental driver if you want to send
me some material to test.


Best regards

Bonat Laurence
