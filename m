Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB95211AE62
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2019 15:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbfLKOwq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Dec 2019 09:52:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23452 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728265AbfLKOwq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Dec 2019 09:52:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576075965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cRlO5uubkPHkhMBspZCc2IkOi9uLD5U64xLEgqnE2Ng=;
        b=VfuENVRJ3kAPAS5DMsxdLAlA3kyiLXp5CXh/5mR1ouZkFCC+ZWfv1E1ucKfILOfDKMn8rE
        Gv35Lrf/cyybQUw4+Ubi47LKpeZzy3yUL+ijWKzHqR3qItTc/suUf8EZS9vN4Eu6gV83gy
        /5BjUhzYZZ2aQ7zqSLHwToq1brEFSCg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-n2cWVv03NfCEGIFuXBWNLg-1; Wed, 11 Dec 2019 09:52:41 -0500
Received: by mail-lf1-f69.google.com with SMTP id d6so2970996lfl.3
        for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2019 06:52:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D5yiVuP3AaqyXU3FTXqB0XygHNzWMsUmIJQkHT0KzxA=;
        b=dSc42Nmv43q+DWXqCwOBCCqsCXu7inRd8D5i53t3dpJ32jC7tcUphKuWuaAFeoxEHT
         m/2lLcGSscbGXBmRJ8xlgU+/+YsecEFwnKjteN6rgArxHzROCGwOE9/hilL9H3TgI28N
         jhbFD3vNeh9uKz2RU+WykRZW5FMMq97kyF9hdQhb7qG4htMjHHkF/xWcPDdXTFeyyTH4
         kk3wsIa0Jo9lHFNwP7xjmg/0g51GcZz385TQoF308rU4rnnBQW2koV/kW/YscQO/GhoA
         Dvj6LCKFYNuqzXRQeJStpvyW3VRLBT+6Glsai/aUooZbJYNg1Q4liYhBk6JNOsq0hi70
         Dj+w==
X-Gm-Message-State: APjAAAX23oXOTv7swWDtMyQXOXZSzeYGlNjHC1kHSZD8hzpj87t4rxYA
        qmQDzY/0U/5DlC5brcpP2xP2kWo3NhJABORUsVhLOO+AelPxhOUwYMDNOC9owEJ+HvtX7ClOuLi
        479zf+0V1fSuiNwqEkqA2EMo+5AE=
X-Received: by 2002:a2e:3e11:: with SMTP id l17mr2403268lja.45.1576075959772;
        Wed, 11 Dec 2019 06:52:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqx64vgszgWxJkOp/5uXIlG12jevtxZZIjUOjAFSYLd/cByfoJacYghRn6ggT5jiccCyfojoHw==
X-Received: by 2002:a2e:3e11:: with SMTP id l17mr2403259lja.45.1576075959633;
        Wed, 11 Dec 2019 06:52:39 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id o19sm1557300lji.54.2019.12.11.06.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 06:52:37 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D358818033F; Wed, 11 Dec 2019 15:52:35 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH 0/2] mac80211: Turn AQL into a proper NL80211_EXT_FEATURE flag
Date:   Wed, 11 Dec 2019 15:52:28 +0100
Message-Id: <20191211145230.200132-1-toke@redhat.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-MC-Unique: n2cWVv03NfCEGIFuXBWNLg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It turns out that there are some issues with just enabling AQL for all
drivers; so instead, this series turns it into an NL80211_EXT_FEATURE
flag, and only enables it for ath10k.

Some coordination to make sure the mac80211 and the driver patch goes
into the same -rc would be good.

Toke H=C3=B8iland-J=C3=B8rgensen (2):
  mac80211: Turn AQL into an NL80211_EXT_FEATURE
  ath10k: Enable Airtime Queue Limits feature

 drivers/net/wireless/ath/ath10k/mac.c |  1 +
 include/uapi/linux/nl80211.h          |  1 +
 net/mac80211/debugfs_sta.c            | 76 ++++++++++++++++++++-------
 net/mac80211/main.c                   |  4 +-
 net/mac80211/sta_info.c               |  3 ++
 net/mac80211/sta_info.h               |  1 -
 net/mac80211/tx.c                     |  4 +-
 7 files changed, 66 insertions(+), 24 deletions(-)

--=20
2.24.0

