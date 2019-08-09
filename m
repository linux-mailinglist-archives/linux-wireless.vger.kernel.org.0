Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8CBC8716F
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2019 07:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfHIFZk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Aug 2019 01:25:40 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:36231 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfHIFZk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Aug 2019 01:25:40 -0400
Received: by mail-qt1-f170.google.com with SMTP id z4so94772902qtc.3
        for <linux-wireless@vger.kernel.org>; Thu, 08 Aug 2019 22:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=KfpmdAj8e83x0hqfCvASlRQVgn/DwsVZsTHNWgDgops=;
        b=YgiJ7bMSMCSBh2XzQjYGzxmUkicYKeqGwqTdgkFrvjZNFfcqJ1fG2/S5XNZQcjxBvc
         WZ/sBOTTDMCEhEBMfeysuoY84qH09fkDQPnJEkzaiEw8Z///J9uom50YVn3FPQUrMk6B
         po2y9T8BzM0KUJryl59UFjnmLobkhU5cO2PWl3WZybMeD9GICG4v+UTNGwCrly5HGz/F
         LVg0gIgbN2zfNzjCZX5HagZEm6aC9Osk5EMuk4+wNsTd1cJA3UziFWVFvr1yeTku4Tgf
         MbG8BnYCNhKsPa46Er1zgYiznCFW64/zba+ULL7EQd4P92Eop8o2EC2CDG9b/F2lvVgj
         VsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KfpmdAj8e83x0hqfCvASlRQVgn/DwsVZsTHNWgDgops=;
        b=BmW+8lwbmTVohIrgCIwFeMGeMv9KrUJN0qdI/fhiMmKdqOWb7IKSFgszw8CFjFCXWy
         9ihuCGKZVPvdKUnVk8BfNKJn8/Q6No15XdzIgMGKR8gn/gtmNwAQG3E4VRzdMpu+FFQ3
         ISSM/Gn4aBW632mhVep3ktOpEUf3mVPQby0xWUa7hfkJDGDYbvlVDvvHYWv5UqGoC5dk
         E0H/Z8PORCMbJNVW2opt98WQ/f+MYb06RGSmt6YVH+Flvb/qRV7mTNLzDdBpDTZBUGJ7
         Vl1Dg1R4CUbk7U7gby2tuqQNNmNWjsSlx4FtEsx2XhVXLbGS7qntXvdK9QEi1v75hoFO
         CgkA==
X-Gm-Message-State: APjAAAVFjdnXebaB/Hu0wBqd8sKXb4YvxxvgE/qVcjbRLLhBFdruRa1J
        KqXHKXY55m9iPkLP0mk+v7qbVS1fYbAvDJAgadB0xwKF
X-Google-Smtp-Source: APXvYqyLwmToiQ99ivMgqliMlSbA8TzoWLwIkOVWApMLBNSiT8NKwaevDw8vjQ9vZXMhNwOUsRE2e+ZHfTW4Q4Yg2wg=
X-Received: by 2002:ac8:3258:: with SMTP id y24mr3713956qta.183.1565328338985;
 Thu, 08 Aug 2019 22:25:38 -0700 (PDT)
MIME-Version: 1.0
From:   Sergey Kharitonov <haritonovsb@gmail.com>
Date:   Fri, 9 Aug 2019 09:25:28 +0400
Message-ID: <CAHmv74wK2NYuj2JuDUz-og5w+e=H1=ef9eCSMTbO6otaYQatKg@mail.gmail.com>
Subject: [Linux Realtek Wi-Fi support] rtl8192ee related bug
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dear Linux-Wireless,
Some time ago a bug was reported
https://bugzilla.kernel.org/show_bug.cgi?id=202943 related to
rtl8192ee, the essence of which is high ping latency (even to the
access point) without downloading something. If you generate a network
load with a background download or just ping -i 0.001 -s 512.... the
latency stabilizes and stays low.
I tested my TP-Link TL-WN881ND v2 adapters (I got two of them in my
PCs plugged in different motherboards (ASUS and MSI)) and the problem
still persists in kernel 5.2.6 (archlinux current default). Just to
mention, I tested with different module options and also two available
firmwares I found (rtlwifi/rtl8192eefw.bin and
rtlwifi/rtl8192eefw_new.bin).
Would you please take some time to look at the bug? I can provide any
additional information needed.
Please let me know if we can make rtl8192ee driver better.

Best regards,
Sergey Kharitonov
