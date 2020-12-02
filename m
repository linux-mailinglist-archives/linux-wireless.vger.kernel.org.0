Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CED92CC50B
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Dec 2020 19:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgLBS1y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Dec 2020 13:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgLBS1y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Dec 2020 13:27:54 -0500
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E92C0613CF
        for <linux-wireless@vger.kernel.org>; Wed,  2 Dec 2020 10:27:14 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4CmS9p0qZQzQlB2;
        Wed,  2 Dec 2020 19:27:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doubly.so; s=MBO0001;
        t=1606933628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=UrOz2iwa/1LXpX+O00deRP3QCKCc3Veuj6NSg5Vfstk=;
        b=yTuhaxfKlpLrtMeyDG3VOoodIN04xx6sJ72Vb+5tjiVi99lhucnEqsI+8lYSkPf56y9HnY
        JaHpRrGyNOGzlfj4bY+IJPb20i3wAQyUacm1tBoD0keYt/mNGmVaBAL3xNxZPld5o9oOTe
        CRi0wgLYciW/9eJHgYyItAQe/Ng9viiFVZbBEL0W5McGP8gl0eRrfe59fRAUCE6QRnf895
        vsn5wrePXFT4fcbLp8+nTWwxOON2uL+QWHQIkvjxZccvgGT/rbWphhbkXFHSCw3kNfHvmT
        8Mey5w+cE2w0kIfhmTuYcfMj0dRoonfBbc3tH8/VxiuQ5H9TvCJvwzBTaGX63Q==
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id 5L_hoJTkQuk9; Wed,  2 Dec 2020 19:27:06 +0100 (CET)
Date:   Wed, 2 Dec 2020 19:27:05 +0100
From:   Devin Bayer <dev@doubly.so>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, kvalo@codeaurora.org
Subject: [PATCH] add ath11k MODULE_FIRMWARE macros
Message-ID: <20201202182705.dhkml4nb4rf2vwav@orac>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.68 / 15.00 / 15.00
X-Rspamd-Queue-Id: 0D3EB16FE
X-Rspamd-UID: c90786
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I am trying to get the ath11k driver to work with VyOS and during the
build it tries to discover the firmware blobs which drivers require.

This doesn't work with ath11k because it doesn't use the MODULE_FIRMWARE
macro. This patch fixes that.

Thanks,
Devin

Signed-off-by: Devin Bayer <dev@doubly.so>
---
 drivers/net/wireless/ath/ath11k/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index af59c23fea56..2add42ce729b 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -991,3 +991,9 @@ EXPORT_SYMBOL(ath11k_core_resume);
 
 MODULE_DESCRIPTION("Core module for Qualcomm Atheros 802.11ax wireless LAN cards.");
 MODULE_LICENSE("Dual BSD/GPL");
+
+/* QCA639x 2.0 firmware files */
+MODULE_FIRMWARE(ATH11K_FW_DIR "/QCA6390/hw2.0/" ATH11K_BOARD_API2_FILE);
+MODULE_FIRMWARE(ATH11K_FW_DIR "/QCA6390/hw2.0/" ATH11K_AMSS_FILE);
+MODULE_FIRMWARE(ATH11K_FW_DIR "/QCA6390/hw2.0/" ATH11K_M3_FILE);
+
-- 
2.25.1

