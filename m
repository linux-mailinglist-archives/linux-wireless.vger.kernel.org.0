Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93CBC42028B
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Oct 2021 18:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhJCQFT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 3 Oct 2021 12:05:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38602 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230426AbhJCQFT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 3 Oct 2021 12:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633277011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mKlqbnV68ucu/9jGoGO5InU05AHLqBboI/a+lod6Kwo=;
        b=HU+YO/x8kfPr+aff/likY6a36NlZ1xLEWKpkWtqcl/PaTkjJ6qHOjVMkN8xybYTOOhxwbn
        xMqr1rxIxy6onA5Hmjnd4kP0xTzfADKOR70PPB/2DdA3iBsqTPMBDJfQCiCUlGfobXmu5a
        BcDeTNFOIvTPKvlNRK+e1NsJoC2n9s8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-k7omOiuhN9-aw4Syjc8ycw-1; Sun, 03 Oct 2021 12:03:30 -0400
X-MC-Unique: k7omOiuhN9-aw4Syjc8ycw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDC77362F8;
        Sun,  3 Oct 2021 16:03:28 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0AD8608BA;
        Sun,  3 Oct 2021 16:03:26 +0000 (UTC)
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
        SHA-cyfmac-dev-list@infineon.com
Subject: [PATCH] brcmfmac: firmware: Treat EFI nvram ccode=XT the same as ccode=XV
Date:   Sun,  3 Oct 2021 18:03:25 +0200
Message-Id: <20211003160325.119696-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In some cases the EFI-var stored nvram contains "ccode=ALL", "ccode=XV"
or "ccode=XT", to specify "worldwide" compatible settings, but these
ccode-s do not work properly. "ccode=ALL" causes channels 12 and 13 to
not be available, "ccode=XV" / "ccode=XT" may cause all 5GHz channels
to not be available.

ccode="ALL" and ccode="XV" where already being replaced with ccode="X2"
with a bit of special handling for nvram settings coming from an EFI
variable. Extend this handling to also deal with nvram settings from
EFI variables which contain "ccode=XT", which has similar issues to
"ccode=XV".

This fixes 5GHz wifi not working on the HP ElitePad 1000 G2.

This was also tested on a Lenovo Thinkpad 8 tablet which also uses
"ccode=XT" and this causes no adverse effects there.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../wireless/broadcom/brcm80211/brcmfmac/firmware.c    | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
index 0eb13e5df517..f150af8ede21 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
@@ -432,10 +432,10 @@ struct brcmf_fw {
 };
 
 #ifdef CONFIG_EFI
-/* In some cases the EFI-var stored nvram contains "ccode=ALL" or "ccode=XV"
- * to specify "worldwide" compatible settings, but these 2 ccode-s do not work
- * properly. "ccode=ALL" causes channels 12 and 13 to not be available,
- * "ccode=XV" causes all 5GHz channels to not be available. So we replace both
+/* In some cases the EFI-var stored nvram contains "ccode=ALL", "ccode=XV" or "ccode=XT",
+ * to specify "worldwide" compatible settings, but these ccode-s do not work properly.
+ * "ccode=ALL" causes channels 12 and 13 to not be available, "ccode=XV" / "ccode=XT"
+ * may cause all 5GHz channels to not be available. So we replace these
  * with "ccode=X2" which allows channels 12+13 and 5Ghz channels in
  * no-Initiate-Radiation mode. This means that we will never send on these
  * channels without first having received valid wifi traffic on the channel.
@@ -447,6 +447,8 @@ static void brcmf_fw_fix_efi_nvram_ccode(char *data, unsigned long data_len)
 	ccode = strnstr((char *)data, "ccode=ALL", data_len);
 	if (!ccode)
 		ccode = strnstr((char *)data, "ccode=XV\r", data_len);
+	if (!ccode)
+		ccode = strnstr((char *)data, "ccode=XT\r", data_len);
 	if (!ccode)
 		return;
 
-- 
2.31.1

