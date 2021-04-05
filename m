Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE5C3547DE
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Apr 2021 22:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237360AbhDEUy4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Apr 2021 16:54:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51232 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236805AbhDEUyv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Apr 2021 16:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617656083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l/W4np6g+F962qJ8QBJJR7xvTtsSuG8F4rC22BpYS78=;
        b=JhinQ0m9sm9+UMa1m+M9hqxUcsB3cIMSJDMtH7xwwXPkVaUDOuMDScpcKFYUY/AKVYGjOb
        xo/UEr3VLm6JIcsF+3w3jVcUQDp10GG5FaGSXy8LACHoWbAapicMfff7XzXytj+l3c+X2B
        v77bRC71cXiV/9P7Fhvw6CK1IThV/Ec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-4kXFPnznOUCVZ_iu0Nh7bA-1; Mon, 05 Apr 2021 16:54:38 -0400
X-MC-Unique: 4kXFPnznOUCVZ_iu0Nh7bA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E2CF9CC05;
        Mon,  5 Apr 2021 20:54:36 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-31.ams2.redhat.com [10.36.112.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FFDA5D9F0;
        Mon,  5 Apr 2021 20:54:32 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-Hsien Lin <chi-hsien.lin@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
Subject: [PATCH 5.12 regression fix resend 1/1] brcmfmac: p2p: Fix recently introduced deadlock issue
Date:   Mon,  5 Apr 2021 22:54:29 +0200
Message-Id: <20210405205429.19304-2-hdegoede@redhat.com>
In-Reply-To: <20210405205429.19304-1-hdegoede@redhat.com>
References: <20210405205429.19304-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

