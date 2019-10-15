Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 054E7D7D44
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2019 19:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730793AbfJORTF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Oct 2019 13:19:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47483 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727163AbfJORTE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Oct 2019 13:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571159943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=aiICBq+klD7gts5SC7Lw3KPTDcrLbo2thywzxGgTe5U=;
        b=a8ygi3Z5h1JihYNzjpsxf73M0d5eNV0TVdqPxenhfRFl5uO3iAUgymhOCQS/BFtrgxvPCN
        ZPmFPazC/Luiio3y0xHMXjiEB6jzXYclNE5Kax7J34PtpV5Xety5ONe+7+5nRQDvbeQjWw
        zvSDU7ZLPFKAapPSfP5t6yRUvUa6f2I=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-2owlj4sUPraFnOVeDMJ2Hg-1; Tue, 15 Oct 2019 13:19:01 -0400
Received: by mail-lj1-f198.google.com with SMTP id p18so4056271ljn.1
        for <linux-wireless@vger.kernel.org>; Tue, 15 Oct 2019 10:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=Y9ZicZO6b29gZwYmEAgc0Vga9o23GaUpVran/Wv7Gas=;
        b=Yd4RVlhsV68C+MQVDVW5W2BTSFRUs7JsLw5xc7KwaAIhbieIVtMc2SiG1LZetJlOyE
         ZnJf1eu4fCtR3qTmX7s+JNaHSWaAFSH+po8UzzVqfLCT8sfS0e6Zt8qymMsZsWKC4NLs
         Tl2ayZhQ/7ywh4F1yn7q+KaBb9L3HAAFBG7+hxfYJHYcpbEye3PXPfXBJ5ytF4OD+Pi3
         djio/E8adF82vNrLpU5xhFHGsXblpK12qZNIQSFyP24azeoX5cAaKACeX2wYtCOIvZ17
         GaU8Xpju7gF0iQx7Q89sWIU8O5BpRoxQeLEYY0Wdyl8stARrwLluBcGYeu3GDH27VJ3v
         dSxg==
X-Gm-Message-State: APjAAAWLOwPwBeztprgy0ES/sPSxzuoBbGdpztyGcH38ubW5tZa/LAhZ
        XRLfGLOsmdiDf8SZgcKsNuk5JNnlQS/+yMTjJtAx9WX95p5gqAtFgyZQhxudFKDOzNRRrVZxxPG
        TY22egpy6RTjznNgBCuqo7Ntm+dA=
X-Received: by 2002:ac2:46d9:: with SMTP id p25mr9407716lfo.174.1571159939664;
        Tue, 15 Oct 2019 10:18:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy4GGvaQ++TIAujXuUFP1I9PfblNVucnrgy1g/FJr66h0DYi2to2kGkxbuh0iD28epJYmQE3Q==
X-Received: by 2002:ac2:46d9:: with SMTP id p25mr9407696lfo.174.1571159939436;
        Tue, 15 Oct 2019 10:18:59 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id v1sm5331272lfa.87.2019.10.15.10.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 10:18:58 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A2AF31803A8; Tue, 15 Oct 2019 19:18:57 +0200 (CEST)
Subject: [PATCH v2 0/4] Add Airtime Queue Limits (AQL) to mac80211
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Kan Yan <kyan@google.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Date:   Tue, 15 Oct 2019 19:18:57 +0200
Message-ID: <157115993755.2500430.12214017471129215800.stgit@toke.dk>
User-Agent: StGit/0.20
MIME-Version: 1.0
X-MC-Unique: 2owlj4sUPraFnOVeDMJ2Hg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series is a first attempt at porting the Airtime Queue Limits concept =
from
the out-of-tree ath10k implementation[0] to mac80211. This version takes Ka=
n's
patch to do the throttling in mac80211, and replaces the driver API with th=
e
mechanism from the previous version of my series, which instead calculated =
the
expected airtime at dequeue time inside mac80211, storing it in the SKB cb
field.

This series also imports Felix' airtime calculation code from mt76 into
mac80211, adjusting the API so it can be used from TX dequeue, by extractin=
g the
latest TX rate from the tx_stats structure kept for each station.

As before, I've only compile tested this (lacking the proper hardware to do=
 more
testing). So I'm hoping someone with a proper testing setup can take the wh=
ole
thing for a spin... :)

The series is also available in my git repo here:
https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/log/?h=3Dmac=
80211-aql-02

Changelog:

v2:
  - Integrate Kan's approach to airtime throttling.
  - Hopefully fix the cb struct alignment on big-endian architectures.

---

Kan Yan (1):
      mac80211: Implement Airtime-based Queue Limit (AQL)

Toke H=C3=B8iland-J=C3=B8rgensen (3):
      mac80211: Rearrange ieee80211_tx_info to make room for tx_time_est
      mac80211: Import airtime calculation code from mt76
      mac80211: Use Airtime-based Queue Limits (AQL) on packet dequeue


 include/net/cfg80211.h     |    7 +
 include/net/mac80211.h     |   52 +++++-
 net/mac80211/Makefile      |    3=20
 net/mac80211/airtime.c     |  375 ++++++++++++++++++++++++++++++++++++++++=
++++
 net/mac80211/debugfs.c     |   78 +++++++++
 net/mac80211/debugfs_sta.c |   43 ++++-
 net/mac80211/ieee80211_i.h |    8 +
 net/mac80211/main.c        |    9 +
 net/mac80211/sta_info.c    |   32 ++++
 net/mac80211/sta_info.h    |    8 +
 net/mac80211/status.c      |   38 ++++
 net/mac80211/tx.c          |   62 +++++++
 12 files changed, 693 insertions(+), 22 deletions(-)
 create mode 100644 net/mac80211/airtime.c

