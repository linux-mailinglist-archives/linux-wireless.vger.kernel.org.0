Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12A7C18EA90
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Mar 2020 17:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgCVQnb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Mar 2020 12:43:31 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:34722 "EHLO
        6.mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgCVQnb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Mar 2020 12:43:31 -0400
X-Greylist: delayed 453 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Mar 2020 12:43:30 EDT
Received: from player799.ha.ovh.net (unknown [10.108.57.49])
        by mo2.mail-out.ovh.net (Postfix) with ESMTP id 543141CDAD0
        for <linux-wireless@vger.kernel.org>; Sun, 22 Mar 2020 17:35:56 +0100 (CET)
Received: from awhome.eu (p4FF9153C.dip0.t-ipconnect.de [79.249.21.60])
        (Authenticated sender: postmaster@awhome.eu)
        by player799.ha.ovh.net (Postfix) with ESMTPSA id BFCDC10AFE330;
        Sun, 22 Mar 2020 16:35:54 +0000 (UTC)
From:   Alexander Wetzel <alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1584894953;
        bh=B//u3IXQXK9MkuMs/A45x5uxqtBpK8/P76uS7Ye3D8w=;
        h=From:To:Cc:Subject:Date;
        b=j4xDqqlTQnXLlh8Ym1hs6GjGOQfOxMJdmpbSK1wEwSOQOddefdMWR1mQrESTPHmJn
         UVUZXeXzuru5VOZOe48pzvXVhzNoHip+GXlv70kFLzsbQdWb8vd++L5qABRnLtExlz
         +SdzDC+c8OyQKVbjuPLBZof38bJzbR76BtX5qp2s=
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Alexander Wetzel <alexander@wetzel-home.de>
Subject: [PATCH] iw: Complete Extended Key ID detection
Date:   Sun, 22 Mar 2020 17:35:24 +0100
Message-Id: <20200322163524.1338224-1-alexander@wetzel-home.de>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10658612947258318023
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudegiedgleduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptehlvgigrghnuggvrhcuhggvthiivghluceorghlvgigrghnuggvrhesfigvthiivghlqdhhohhmvgdruggvqeenucfkpheptddrtddrtddrtddpjeelrddvgeelrddvuddriedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeelledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegrlhgvgigrnhguvghrseifvghtiigvlhdqhhhomhgvrdguvgdprhgtphhtthhopehlihhnuhigqdifihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

info: update text to have a unified spelling
scan: flag Extended Key ID in scans

Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
---

Add Extended Key ID detection to scans. While at it I also updated the
spelling for Extended Key ID to use capital letters to unify it with how
it's written in IEEE 802.11 and all other references.

Here a short sample:

BSS d0:ab:d5:82:2e:0e(on wlp2s0)
        TSF: 1839642566 usec (0d, 00:30:39)
        freq: 2422
        beacon interval: 100 TUs
        capability: ESS Privacy ShortPreamble ShortSlotTime (0x0431)
        signal: -33.00 dBm
        last seen: 5180 ms ago
        Information elements from Probe Response frame:
        SSID: Brix
        Supported rates: 6.0* 9.0 12.0* 18.0 24.0* 36.0 48.0 54.0
        DS Parameter set: channel 3
        Country: DE     Environment: Indoor/Outdoor
                Channels [1 - 13] @ 22 dBm
        ERP: <no flags>
        RSN:     * Version: 1
                 * Group cipher: CCMP
                 * Pairwise ciphers: CCMP
                 * Authentication suites: PSK SAE FT/SAE
                 * Capabilities: 16-PTKSA-RC 1-GTKSA-RC MFP-required MFP-capable Extended-Key-ID (0x20cc)
        BSS Load:
                 * station count: 0
                 * channel utilisation: 0/255
                 * available admission capacity: 0 [*32us]


 info.c | 2 +-
 scan.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/info.c b/info.c
index 97240f6..8d4cffc 100644
--- a/info.c
+++ b/info.c
@@ -698,7 +698,7 @@ broken_combination:
 			       "PMKSA caching supported in AP mode");
 		ext_feat_print(tb, SCHED_SCAN_BAND_SPECIFIC_RSSI_THOLD,
 			       "band specific RSSI thresholds for scheduled scan");
-		ext_feat_print(tb, EXT_KEY_ID, "extended key ID support");
+		ext_feat_print(tb, EXT_KEY_ID, "Extended Key ID support");
 		ext_feat_print(tb, STA_TX_PWR, "TX power control per station");
 		ext_feat_print(tb, SAE_OFFLOAD, "SAE offload support");
 		ext_feat_print(tb, VLAN_OFFLOAD, "VLAN offload support");
diff --git a/scan.c b/scan.c
index 1ccea94..57d4e9c 100644
--- a/scan.c
+++ b/scan.c
@@ -1018,6 +1018,8 @@ static void _print_rsn_ie(const char *defcipher, const char *defauth,
 			printf(" SPP-AMSDU-capable");
 		if (capa & 0x0800)
 			printf(" SPP-AMSDU-required");
+		if (capa & 0x2000)
+			printf(" Extended-Key-ID");
 		printf(" (0x%.4x)\n", capa);
 		data += 2;
 		len -= 2;
-- 
2.25.2

