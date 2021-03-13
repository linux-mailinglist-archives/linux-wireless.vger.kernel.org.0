Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C74339E8F
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Mar 2021 15:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbhCMOhN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Mar 2021 09:37:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42839 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229615AbhCMOgn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Mar 2021 09:36:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615646202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=l/W4np6g+F962qJ8QBJJR7xvTtsSuG8F4rC22BpYS78=;
        b=QsCoV2ai3/gQ0ZLaNToMzlymRJBXAsh5qJnkUFkR+t+w28GeYe9mrkQXfGntZRYe4MdU5g
        bBliASp64IB+TzQSDOVGLeW/zm6E4OFb9dUHidFrO7s1z0cf9tKh7rXAZTYie47GCNkw7T
        q9Wpmwwy9RtqLdBD8X+fya7Hpa4HXWo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-qC71K_RlMWKadlO6FY_Iig-1; Sat, 13 Mar 2021 09:36:40 -0500
X-MC-Unique: qC71K_RlMWKadlO6FY_Iig-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 862AA107ACCD;
        Sat, 13 Mar 2021 14:36:38 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-24.ams2.redhat.com [10.36.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3BFFD60C05;
        Sat, 13 Mar 2021 14:36:36 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-Hsien Lin <chi-hsien.lin@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Wright Feng <wright.feng@infineon.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5.12 regression fix] brcmfmac: p2p: Fix recently introduced deadlock issue
Date:   Sat, 13 Mar 2021 15:36:35 +0100
Message-Id: <20210313143635.109154-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Commit a05829a7222e ("cfg80211: avoid holding the RTNL when calling the
driver") replaced the rtnl_lock parameter passed to various brcmf
functions with just lock, because since that commit it is not just
about the rtnl_lock but also about the wiphy_lock .

During this search/replace the "if (!rtnl_locked)" check in brcmfmac/p2p.c
was accidentally replaced with "if (locked)", dropping the inversion of
the check. This causes the code to now call rtnl_lock() while already
holding the lock, causing a deadlock.

Add back the "!" to the if-condition to fix this.

Cc: Johannes Berg <johannes.berg@intel.com>
Fixes: a05829a7222e ("cfg80211: avoid holding the RTNL when calling the driver")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index 6d30a0fcecea..34cd8a7401fe 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -2439,7 +2439,7 @@ void brcmf_p2p_ifp_removed(struct brcmf_if *ifp, bool locked)
 	vif = ifp->vif;
 	cfg = wdev_to_cfg(&vif->wdev);
 	cfg->p2p.bss_idx[P2PAPI_BSSCFG_DEVICE].vif = NULL;
-	if (locked) {
+	if (!locked) {
 		rtnl_lock();
 		wiphy_lock(cfg->wiphy);
 		cfg80211_unregister_wdev(&vif->wdev);
-- 
2.30.2

