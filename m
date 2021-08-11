Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105FC3E948C
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Aug 2021 17:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbhHKP2t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Aug 2021 11:28:49 -0400
Received: from li1434-30.members.linode.com ([45.33.107.30]:46090 "EHLO
        node.akkea.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233176AbhHKP2s (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Aug 2021 11:28:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id AF41755E351;
        Wed, 11 Aug 2021 15:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1628695704; bh=oZRecWo3hf7nFre+mVbt6VMymLHXbxnodvh5R5BevZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Y0e8191p7dg7QwkpxxdoHgrPUHyhpj04RhoLmekIDbmoKpM0zNTxQSQRhb+lc8W6C
         iKZzYQQDQLGueUTdSJ1xB0Wz0/UD2uxOcBK9yLJsofPvJicz9MYYOZxZdW8ciZY7Gu
         J+nmlD2W97Cd5jYgWegxBsijfwz80olMR3iJev28=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QQL_Ki4d_weC; Wed, 11 Aug 2021 15:28:24 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 2841D55E344;
        Wed, 11 Aug 2021 15:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1628695704; bh=oZRecWo3hf7nFre+mVbt6VMymLHXbxnodvh5R5BevZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Y0e8191p7dg7QwkpxxdoHgrPUHyhpj04RhoLmekIDbmoKpM0zNTxQSQRhb+lc8W6C
         iKZzYQQDQLGueUTdSJ1xB0Wz0/UD2uxOcBK9yLJsofPvJicz9MYYOZxZdW8ciZY7Gu
         J+nmlD2W97Cd5jYgWegxBsijfwz80olMR3iJev28=
From:   Angus Ainslie <angus@akkea.ca>
To:     kernel@puri.sm
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com, Angus Ainslie <angus@akkea.ca>
Subject: [PATCH v2 3/3] brcmfmac: add patch ram for bluetooth
Date:   Wed, 11 Aug 2021 08:28:04 -0700
Message-Id: <20210811152804.2379405-4-angus@akkea.ca>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210811152804.2379405-1-angus@akkea.ca>
References: <20210811152804.2379405-1-angus@akkea.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bluetooth on the BCM43752 needs a patchram file to function correctly.

Signed-off-by: Angus Ainslie <angus@akkea.ca>
---
 drivers/bluetooth/btbcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index e5d706ed55ea..e4182acee488 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -387,6 +387,7 @@ struct bcm_subver_table {
 };
 
 static const struct bcm_subver_table bcm_uart_subver_table[] = {
+	{ 0x1111, "BCM4362A2"	},	/* 000.017.017 */
 	{ 0x4103, "BCM4330B1"	},	/* 002.001.003 */
 	{ 0x410d, "BCM4334B0"	},	/* 002.001.013 */
 	{ 0x410e, "BCM43341B0"	},	/* 002.001.014 */
-- 
2.25.1

