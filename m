Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C0554A146
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jun 2022 23:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243819AbiFMVV1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jun 2022 17:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243093AbiFMVVN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jun 2022 17:21:13 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23AD1D306
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 14:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=o/zK7HihkjohxLKzRQiJNxVvrBgHHxOI1eWND5theSI=; t=1655154249; x=1656363849; 
        b=gyh6KO7nQaQAz51OFSzA334wpd8TtoqnQiaCoP2j8dEsyTuNqw7oyCtuo6vbeY9mMX3K3wyWQ9j
        U6FvfBcX/jL/X6B452kHqYhNnx9bFh9GEkyFEDeaFuSlHX2jKcTjWOWHlblo+ArftgdYjzEKPC0RT
        2RfsSYgxOBxqxnbmX30tfMRtYSZiv3bRuxTrdfgNG1R7RgAaCv7PZhFLu3gqEJPmV5TR/30VJ1ufR
        98x6le4IrUNBj+NYiIbpLWYS1I2KNl4yTiAenA25uBjmfh3D5mrbdrCm2nViOYhapxNJpg9vH04nX
        eQuLGN1svbDAF7aV0sPPNu3f9hxSwF+GNeDQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1o0rEB-004hJK-Ta;
        Mon, 13 Jun 2022 23:04:04 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] mac80211_hwsim: set virtio device ready in probe()
Date:   Mon, 13 Jun 2022 23:04:01 +0200
Message-Id: <20220613210401.327958-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Just like a similar commit to arch/um/drivers/virt-pci.c, call
virtio_device_ready() to make this driver work after commit
b4ec69d7e09 ("virtio: harden vring IRQ"), since the driver uses
the virtqueues in the probe function.  (The virtio core sets
the device ready when probe returns.)

Change-Id: I617d3b819b5e5345471a8e79db25342981a92424
Fixes: 8b4ec69d7e09 ("virtio: harden vring IRQ")
Fixes: 5d44fe7c9808 ("mac80211_hwsim: add frame transmission support over virtio")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 02108b94d6b8..d2b31595856d 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -4951,6 +4951,8 @@ static int hwsim_virtio_probe(struct virtio_device *vdev)
 	if (err)
 		return err;
 
+	virtio_device_ready(vdev);
+
 	err = fill_vq(hwsim_vqs[HWSIM_VQ_RX]);
 	if (err)
 		goto out_remove;
-- 
2.36.1

