Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85920155E8
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2019 00:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfEFWFB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 May 2019 18:05:01 -0400
Received: from 0.ictbs.com ([203.137.112.168]:53104 "EHLO 0.ictbs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfEFWFB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 May 2019 18:05:01 -0400
Received: by hq.local (Postfix, from userid 1000)
        id 2F1FA66429; Tue,  7 May 2019 00:04:53 +0200 (CEST)
Date:   Tue, 7 May 2019 00:04:53 +0200
From:   Victor Bravo <1905@spmblk.com>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH RFC v3] brcmfmac: sanitize DMI strings
Message-ID: <20190506220453.z5ke7dss3t4meg7e@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

as I expect to be busy tomorrow, I'm sending polished, hopefully more
readable version of the patch, and also some more implementation details
which can be useful in the search for proper sanitizing function.

Patch description:
Sanitize DMI strings in brcmfmac driver to make resulting filenames
contain only safe characters. This version replaces all non-printable
characters incl. delete (1-31, 127-255), spaces and slashes with
underscores.

This change breaks backward compatibility, but adds control over strings
passed to firmware loader and compatibility with CONFIG_EXTRA_FIRMWARE
which doesn't support spaces in filenames.

Implementation details:
The algorithm for sanitizing function was selected after following
choices were considered (C = number of allowed characters , N = number
of characters in sanitized strings):

ALGORITHM	TIME COMPL.	DATA	DISADVANTAGES
bitmask-based	O(N)		16	no macro to make mask from string
hardcoded-check	O(N)		0	not universal, big / prone to growth
runtime-mask	O(C+N)		16+C	C+N and 16+C don't seem "best" enough
string-based	O(C*N)		C	slow, big, far from "best possible"

(runtime-mask means bitmask-based algorithm with runtime mask
initialization from string of allowed characters)

Bitmask-based implementation won due to results summarized above.
It's only 7-bit clear, because this allows to save 16 bytes of data
at the price of single (char < 0) comparison, and C char is kind
of 7-bit anyway.

Known issues:
Function like brcmf_dmi_sanitize() shouldn't be part of driver, as
this practice leads to duplicate code, which is not acceptable for many
good reasons. An existing function from lib/ should be used instead,
or implemented there if no suitable replacement is found.
---
Changes from v1: don't revert fresh commit by someone else
Changes from v2: outfactor check to BRCMF_DMI_SANE_CHAR in an attempt to
		 make the code more readable, improve comments, +Luis

Signed-off-by: Victor Bravo <1905@spmblk.com>

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
index 7535cb0d4ac0..c8cb9c0b3f6e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
@@ -23,6 +23,18 @@
 /* The DMI data never changes so we can use a static buf for this */
 static char dmi_board_type[128];
 
+/*
+ * Array of 128 bits representing 7-bit characters allowed in DMI strings,
+ * byte-based to avoid endianess issues.
+ */
+static unsigned char brcmf_dmi_allowed_chars[] = {
+	0x00, 0x00, 0x00, 0x00, 0xfe, 0x7f, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x7f
+};
+
+/* Safe character to replace disallowed ones. */
+#define BRCMF_DMI_SAFE_CHAR '_'
+
 struct brcmf_dmi_data {
 	u32 chip;
 	u32 chiprev;
@@ -99,6 +111,19 @@ static const struct dmi_system_id dmi_platform_data[] = {
 	{}
 };
 
+/* Checks character value agains bitmask of allowed characters */
+#define BRCMF_DMI_SANE_CHAR(mask, value) \
+	(mask[value / 8] & (1 << (value % 8)))
+
+void brcmf_dmi_sanitize(char *dest, const unsigned char *allowed, char safe)
+{
+	while (*dest) {
+		if ((*dest < 0) || !BRCMF_DMI_SANE_CHAR(allowed, *dest))
+			*dest = safe;
+		dest++;
+	}
+}
+
 void brcmf_dmi_probe(struct brcmf_mp_device *settings, u32 chip, u32 chiprev)
 {
 	const struct dmi_system_id *match;
@@ -126,6 +151,9 @@ void brcmf_dmi_probe(struct brcmf_mp_device *settings, u32 chip, u32 chiprev)
 	if (sys_vendor && product_name) {
 		snprintf(dmi_board_type, sizeof(dmi_board_type), "%s-%s",
 			 sys_vendor, product_name);
+		brcmf_dmi_sanitize(dmi_board_type,
+				   brcmf_dmi_allowed_chars,
+				   BRCMF_DMI_SAFE_CHAR);
 		settings->board_type = dmi_board_type;
 	}
 }
