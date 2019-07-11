Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D32665377
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2019 11:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbfGKJFY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jul 2019 05:05:24 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:59780 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728202AbfGKJFY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jul 2019 05:05:24 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 7FB2430C013;
        Thu, 11 Jul 2019 02:05:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 7FB2430C013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1562835922;
        bh=GIXH+NRBKde4WBMHyItiTvdxPxUbkTX/PNEEwiJsnJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XS30EbSNiPzii0dz75DRTjklKMTsWTNqiQsmkjJXa3z2Kej2D5iVm+25O5riZtj6w
         UCWFGkG7xjSlfyVpfqBWKAJiLJ2ME18iSYPxmIZ1w0fSwRkgFhk+aO17P982wYSPJl
         g0WbQ6FtWXYT7HSxqCO5NEUKLa2+YhrPaNsAEWgE=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id D4B4660D93;
        Thu, 11 Jul 2019 02:05:22 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id 155A4B02A3D; Thu, 11 Jul 2019 11:05:19 +0200 (CEST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 6/7] brcmfmac: simply remove flowring if bus is down
Date:   Thu, 11 Jul 2019 11:05:11 +0200
Message-Id: <1562835912-1404-7-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1562835912-1404-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1562835912-1404-1-git-send-email-arend.vanspriel@broadcom.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When the bus is down, eg. due to rmmod, there is no need to
attempt to inform firmware about it.

Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c
index 241747b..8428be8 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c
@@ -1398,6 +1398,13 @@ void brcmf_msgbuf_delete_flowring(struct brcmf_pub *drvr, u16 flowid)
 	u8 ifidx;
 	int err;
 
+	/* no need to submit if firmware can not be reached */
+	if (drvr->bus_if->state != BRCMF_BUS_UP) {
+		brcmf_dbg(MSGBUF, "bus down, flowring will be removed\n");
+		brcmf_msgbuf_remove_flowring(msgbuf, flowid);
+		return;
+	}
+
 	commonring = msgbuf->commonrings[BRCMF_H2D_MSGRING_CONTROL_SUBMIT];
 	brcmf_commonring_lock(commonring);
 	ret_ptr = brcmf_commonring_reserve_for_write(commonring);
-- 
1.9.1

