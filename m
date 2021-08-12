Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFFC3EA8DA
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Aug 2021 18:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbhHLQ4G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Aug 2021 12:56:06 -0400
Received: from li1434-30.members.linode.com ([45.33.107.30]:46106 "EHLO
        node.akkea.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233542AbhHLQ4F (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Aug 2021 12:56:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 2159F55E344;
        Thu, 12 Aug 2021 16:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1628787340; bh=oZRecWo3hf7nFre+mVbt6VMymLHXbxnodvh5R5BevZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WtSlu69Qn2+pZz9PxZzurWKOXPiVVf6po72rDamBYmPdu452iWT9Y++trwV/FBxgO
         fOpnDFD12uujNamm5rglvKZmTzZN9gQwmVpx20J+8FiGyy78hFdPypFxEKH5RXOAn3
         4QzVZA1SLaAl0oMXjj14WiNUzZx0t+HEO0S8/jqM=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lUV0yPLaj7jd; Thu, 12 Aug 2021 16:55:39 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 7D8BC55E34E;
        Thu, 12 Aug 2021 16:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1628787339; bh=oZRecWo3hf7nFre+mVbt6VMymLHXbxnodvh5R5BevZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Lp9jVdjOPS9N5SXmtEZik3+FFv1HC5eLp4M0X/7sENsE/zvF5WkkD/lFlZyQNmLhG
         MXj2iKqDGLWwhrso1CGfDQY0BEdRWyuMJIQzJLCfNYtFuxLROo6m85FlBuM4ExSO0q
         W+dFtKtnNrLU3L5JEx21l9IjdDgp4x+NZK7TPXSE=
From:   Angus Ainslie <angus@akkea.ca>
To:     kernel@puri.sm
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        linux-bluetooth@vger.kernel.org, Angus Ainslie <angus@akkea.ca>
Subject: [PATCH v3 2/2] btbcm: add patch ram for bluetooth
Date:   Thu, 12 Aug 2021 09:52:18 -0700
Message-Id: <20210812165218.2508258-3-angus@akkea.ca>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210812165218.2508258-1-angus@akkea.ca>
References: <20210812165218.2508258-1-angus@akkea.ca>
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

