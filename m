Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F981B7939
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2019 14:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390178AbfISMWt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Sep 2019 08:22:49 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35112 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390153AbfISMWt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Sep 2019 08:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568895768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=isNRrW8L9F22pq5xM7BOGhz77XjDOSFbu+TmWX4qsbw=;
        b=PFutPdF3IR7x8GpB63Fg8qVzhXhm+YhP5zomEsbXgwYQjseCwm2Zfzlty5aGECxAr73NCG
        dxGSkWGCbn7IXUOzHO1XiAg2p0THtAU+tB7DhpyD2609bTK81mfrIC0FibQZnLLDy4dalt
        iw0L9nPsQV9rk41I9ViXCfoEVb3tTxk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-dxZaYjXiP5Owr3oplxZHZw-1; Thu, 19 Sep 2019 08:22:47 -0400
Received: by mail-ed1-f70.google.com with SMTP id a22so1851865edx.7
        for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2019 05:22:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=YF7NkGK3XYY0L7S0iEBXU53xgOoC7FCZFfbEUKaXSrE=;
        b=ItZEXvxEc/ty1J+XkrkLmk2MoSzPR3r2xFK/7OyH0JsGbBvvUKoOd3Xl0rOMIgPRCo
         2rACdnH17aJ9gyMrg32h+hw2o5BfV+1oNmacwqHEhCsu87S6ncx3VwGSt7V4rJztVNKf
         z/oM+pn70VhQi4TSzGgEjGAV2h0y6C81iekekz0+THcqqeHaVaU9pat30BnFJcsdg0Rr
         pyNPWkaed1qOkQtI1eIuX9RbGbLcGnYTtBAJRRx+jkLs/0A+fSuD+ogYvO+iqXoa9vXV
         ChPe/rBMw0WEtp7YAg6zwpjF6eT+nP/tTvKrSQ8MD23VYmQwmXusf8Ev5JSj1JpkWsJn
         KH0Q==
X-Gm-Message-State: APjAAAXCXxsIipnNcnSNC0lMOW6z9fu0SAsPEOLyzyC6WtH1xuJLBj2Z
        6OC58X8Hm6hOjrE3uWGhLeTgVwxG4OTNl7x1N41Z3wk6Hnmg+WHBToAFh/bQFI0QPUXxk6lpoWt
        CU0EY5z0TRs4jeb1onL6M4v3eAyw=
X-Received: by 2002:a17:906:8258:: with SMTP id f24mr14210162ejx.234.1568895765885;
        Thu, 19 Sep 2019 05:22:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwQoorps5W+n3aN9kOZgic4NMVdtT8Do0sNQ0QKJ6pqDafaa691ryfwUKyx5gnPF6rBOWZOZQ==
X-Received: by 2002:a17:906:8258:: with SMTP id f24mr14210142ejx.234.1568895765668;
        Thu, 19 Sep 2019 05:22:45 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id x4sm686757eds.87.2019.09.19.05.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 05:22:44 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 590BA18063E; Thu, 19 Sep 2019 14:22:44 +0200 (CEST)
Subject: [PATCH RFC/RFT 0/4] Add Airtime Queue Limits (AQL) to mac80211
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Date:   Thu, 19 Sep 2019 14:22:44 +0200
Message-ID: <156889576422.191202.5906619710809654631.stgit@alrua-x1>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
X-MC-Unique: dxZaYjXiP5Owr3oplxZHZw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series is a first attempt at porting the Airtime Queue Limits concept =
from
the out-of-tree ath10k implementation[0] to mac80211. I limited the scope o=
f
this RFC to ath10k, but it should be straight forward to enable other drive=
rs
(they just need to provide a last TX bitrate).

Unfortunately I don't currently have access to hardware to test this, so I'=
m
posting it here in the hope that someone else will take it for a spin. Do n=
ote
that this means that the series is completely untested (although it should
compile :)).

Also note that the series does make a couple of assumptions, as explained i=
n the
individual patches. In particular, it relies on fields surviving in
ieee80211_tx_info; Johannes, care to comment on whether this is a valid
assumption (and whether you're OK with what I'm doing to that struct in the
first patch)?

The series is also available in my git repo here:
https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/log/?h=3Dmac=
80211-aql-01


[0] https://chromium-review.googlesource.com/c/chromiumos/third_party/kerne=
l/+/588190/13/drivers/net/wireless-4.2/ath/ath10k/mac.c#3845

---

Toke H=C3=B8iland-J=C3=B8rgensen (4):
      mac80211: Rearrange ieee80211_tx_info to make room for tx_time_est
      mac80211: Add API function to set the last TX bitrate for a station
      ath10k: Pass last TX bitrate up to mac80211
      mac80211: Apply Airtime-based Queue Limit (AQL) on packet dequeue


 drivers/net/wireless/ath/ath10k/htt_rx.c |    1 +
 include/net/mac80211.h                   |   32 ++++++++++++++++++++-----
 net/mac80211/debugfs.c                   |   24 +++++++++++++++++++
 net/mac80211/ieee80211_i.h               |   11 +++++++++
 net/mac80211/sta_info.c                  |    9 +++++++
 net/mac80211/sta_info.h                  |    2 ++
 net/mac80211/status.c                    |   22 +++++++++++++++++
 net/mac80211/tx.c                        |   38 ++++++++++++++++++++++++++=
+++-
 8 files changed, 131 insertions(+), 8 deletions(-)

