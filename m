Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8599CE0AD
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 12:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfD2KmF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 06:42:05 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35383 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbfD2KmF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 06:42:05 -0400
Received: by mail-qt1-f194.google.com with SMTP id e5so4357428qtq.2
        for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2019 03:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mti7KwMi+FS7lNJiLBXoxgVN3ENDHL6rbQJBPEZLm8c=;
        b=e6Z9KN+6jcezK4vxJLAWJ4wS+bpxKehspqny2MSjUgaOejBm5SChPK+bwk3HlBKrwj
         cxjDmvPu1FDIMhcQNGe0i3iacMH6nOIdGlv9koKvO+L23/izsmwYOK3RSUyqLnk+Z4S/
         40b9hQCT4A7O4M06WpDPjq4S0Nb9QQNLU2Rio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mti7KwMi+FS7lNJiLBXoxgVN3ENDHL6rbQJBPEZLm8c=;
        b=c4M+FbRyS8MPNehAiSjmOw6CznHvXqxhEn61uImuV/L7v4po9ZvE8k3cK977mKi+vN
         rX8/c8usluzp6Syu68aK3KdL8SGg/Bq3IXalxxFau83sTZv8/cuR3cU2EBECDSn02fzB
         mK4EMElgxWOmhBIkbsEh2gBzOYC8c7a0j1uZ49dJmjoMvK4LiZDOYINLBK9MDca1pnnb
         /vzETx+rRxdZwwiXM8j1dDAXrbFfrV2iXya4GIOu+Hm38D8o+Ae5pKXn3RbLeLqQjPt1
         q46jd9UuafnSkMStWU3iqsqTyP8OQycv30TPh/WuxIO7TTkiaT7+pijobEq4wIDTqn91
         +XNA==
X-Gm-Message-State: APjAAAWKvnQch/oX3PzSVstrlUzsmb4JTuicJ7eFO6mV/oq+VVyC04C/
        fi1S2+RSXU4x39mZYUtgAkjXTWIGTKKd+Q/H
X-Google-Smtp-Source: APXvYqzk5aYxV58w7N95dNyia/fQ/eV9udrxxcCCgAMyYC9mR+6R1h32BFob+FsBQYmrnc2bEQ3YGA==
X-Received: by 2002:aed:3e1b:: with SMTP id l27mr38214440qtf.328.1556534523968;
        Mon, 29 Apr 2019 03:42:03 -0700 (PDT)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com. [209.85.222.179])
        by smtp.gmail.com with ESMTPSA id u3sm16405304qkc.21.2019.04.29.03.42.01
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 03:42:02 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id d14so1437890qkl.11
        for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2019 03:42:01 -0700 (PDT)
X-Received: by 2002:a37:4c7:: with SMTP id 190mr37260660qke.128.1556534521618;
 Mon, 29 Apr 2019 03:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <2884043.Jv1Mn93hE8@aspire.rjw.lan> <20190403195718.GA74723@google.com>
 <87o94tutdz.fsf@kamboji.qca.qualcomm.com> <CAJZ5v0ifD=DATprUeeO2_LGs04aEEhPB6AcGVPxWUdQaOma+ww@mail.gmail.com>
In-Reply-To: <CAJZ5v0ifD=DATprUeeO2_LGs04aEEhPB6AcGVPxWUdQaOma+ww@mail.gmail.com>
From:   Claire Chang <tientzu@chromium.org>
Date:   Mon, 29 Apr 2019 18:41:50 +0800
X-Gmail-Original-Message-ID: <CALiNf2_qV+iViHbS0tQquTMZfu6XfFvQCH14mdT5bixn94DZ2Q@mail.gmail.com>
Message-ID: <CALiNf2_qV+iViHbS0tQquTMZfu6XfFvQCH14mdT5bixn94DZ2Q@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Drop WARN_ON()s that always trigger during system resume
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sriram R <srirrama@codeaurora.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>, ath10k@lists.infradead.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Todd Brandt <todd.e.brandt@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tested-by: Claire Chang <tientzu@chromium.org>

> Still, I'm quite sure that the WARN_ON()s trigger during system resume
> regardless of the hw/fw combination.

Also see this on sido:

[    4.925278] ath10k_sdio mmc1:0001:1: qca6174 hw3.2 sdio target
0x05030000 chip_id 0x00000000 sub 0000:0000
[    4.935721] ath10k_sdio mmc1:0001:1: kconfig debug 1 debugfs 1
tracing 1 dfs 0 testmode 1
[    4.948750] ath10k_sdio mmc1:0001:1: firmware ver
WLAN.RMH.4.4.1-00007-QCARMSWP-1 api 6 features wowlan,ignore-otp crc32
b98adaf8
[    5.132728] ath10k_sdio mmc1:0001:1: board_file api 2 bmi_id 0:4
crc32 6364cfcc
