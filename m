Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F34388DDE
	for <lists+linux-wireless@lfdr.de>; Wed, 19 May 2021 14:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346225AbhESMVz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 May 2021 08:21:55 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:33023 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346175AbhESMVz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 May 2021 08:21:55 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <pborgers@zedat.fu-berlin.de>)
          id 1ljLBi-00037C-Ik; Wed, 19 May 2021 14:20:34 +0200
Received: from a36t-ffs1.berlin.freifunk.net ([77.87.51.11] helo=mi.fu-berlin.de)
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <borgers@mi.fu-berlin.de>)
          id 1ljLBh-000PJl-DI; Wed, 19 May 2021 14:20:34 +0200
Received: by mi.fu-berlin.de (sSMTP sendmail emulation); Wed, 19 May 2021 14:20:33 +0200
From:   Philipp Borgers <borgers@mi.fu-berlin.de>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Philipp Borgers <borgers@mi.fu-berlin.de>
Subject: [PATCH v2 0/3] mac80211: do not use low data rates for data frames with no ack flag
Date:   Wed, 19 May 2021 14:20:16 +0200
Message-Id: <20210519122019.92359-1-borgers@mi.fu-berlin.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Original-Sender: borgers@mi.fu-berlin.de
X-Originating-IP: 77.87.51.11
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Version 2 of this patch set adds a helper function that checks if a frame is a
data frame taking hardware encapsulation into account. Suggested by Johannes
Berg and Felix Fietkau.

The refactoring of the rc_no_data_or_no_ack_use_min function makes use of this
new function too. I added a comment about the refactoring too. Suggested by
Kalle Valo.

Best Regards

Philipp Borgers

Philipp Borgers (3):
  mac80211: add ieee80211_is_tx_data helper function
  mac80211: do not use low data rates for data frames with no ack flag
  mac80211: refactor rc_no_data_or_no_ack_use_min function

 include/net/mac80211.h | 18 ++++++++++++++++++
 net/mac80211/rate.c    | 10 +++++-----
 2 files changed, 23 insertions(+), 5 deletions(-)

-- 
2.31.1

