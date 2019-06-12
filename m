Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1997143049
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 21:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfFLTgD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 15:36:03 -0400
Received: from durin.narfation.org ([79.140.41.39]:33950 "EHLO
        durin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfFLTgD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 15:36:03 -0400
Received: from sven-desktop.home.narfation.org (p200300C5971631EE000000000000070D.dip0.t-ipconnect.de [IPv6:2003:c5:9716:31ee::70d])
        by durin.narfation.org (Postfix) with ESMTPSA id C85BE1100ED;
        Wed, 12 Jun 2019 21:36:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1560368160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1yok9X+eLKIU63OeWQG4dpp/52wQ+AsAlnmIWw9C1HU=;
        b=vQx+IJPUZmLTlY7wKgYmsEyTnZqhyE2QCuWujNGP839+TrXAPIIPerx7F3CEu4WEJJeACV
        SQRgdpTzWt/pYyiZpplX1cDvsYCm1Po3KObcooznVH8RNQT6JGrgQKKZQgUphKm6+vyc3D
        NhmBWRzyKT01AYNFXRPsHxGADy89ASQ=
From:   Sven Eckelmann <sven@narfation.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, Sven Eckelmann <sven@narfation.org>
Subject: [PATCH v3 0/3] mac80211/ath11k: HE mesh support
Date:   Wed, 12 Jun 2019 21:35:07 +0200
Message-Id: <20190612193510.29489-1-sven@narfation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1560368160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1yok9X+eLKIU63OeWQG4dpp/52wQ+AsAlnmIWw9C1HU=;
        b=RIC0ZdvTy+ZfgXFgVvb+9nuUJVdMmSFYPObzldEMorG1dvneoXjP88/6Wp0DHOC99ZxMTh
        ehePOpbs+irOJY01ItN/YdUKWOegvrsBT/X/768ttZQ0caNJdoc0UcICjmsuHb9VLQzYcz
        ZwBTbtpplwHQtfHP58RxREXccfuPRcg=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1560368160; a=rsa-sha256;
        cv=none;
        b=y+NqFZM7tFa8XPgSakfYPOFeF7w/yIe7D82Am2afNYSQk5e2aVlcBB1qO+Ma+aL5GvjuWw
        KYy5lBLKAxYYBrgvnmkNJqAvlMGtDGFmxYYmVCbQCpAqGZD+hD6j6P4jkvKsIB34GhM9FP
        M64GFyB4VUCg0mlBNsOeZUHGcv67QlA=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sven smtp.mailfrom=sven@narfation.org
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Some features of 802.11ax without central organizing (AP) STA can also be
used in mesh mode. The main goal is to get HE mesh working with ath11k.
For persons without ath11k compatible hw, hwsim can be used in the as basis
for further development of these features.


* v3

  - force ath11k PHY mode for meshpoint vif to HE mode to avoid hang of
    firmware when HE (or VHT on 2.4GHz) device tries to connect

* v2:

  - add of ath11k patch

* v1:

  - initial RFC


Kind regards,
        Sven

Sven Eckelmann (3):
  mac80211_hwsim: Register support for HE meshpoint
  mac80211: implement HE support for mesh
  ath11k: register HE mesh capabilities

 drivers/net/wireless/ath/ath11k/mac.c |  63 ++++++
 drivers/net/wireless/mac80211_hwsim.c | 283 +++++++++++++++++---------
 include/net/cfg80211.h                |  19 ++
 net/mac80211/ieee80211_i.h            |   2 +
 net/mac80211/mesh.c                   |  61 ++++++
 net/mac80211/mesh.h                   |   4 +
 net/mac80211/mesh_plink.c             |  11 +-
 net/mac80211/util.c                   |  52 +++++
 8 files changed, 400 insertions(+), 95 deletions(-)

-- 
2.20.1

