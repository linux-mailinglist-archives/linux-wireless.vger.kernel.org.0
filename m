Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCD8754EC3
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jul 2023 15:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjGPNOE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jul 2023 09:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGPNOD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jul 2023 09:14:03 -0400
X-Greylist: delayed 1054 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 16 Jul 2023 06:14:02 PDT
Received: from sphereful.sorra.shikadi.net (unknown [IPv6:2406:da1c:315:ab8f:92f3:fedd:c9d3:1f18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3B4E64
        for <linux-wireless@vger.kernel.org>; Sun, 16 Jul 2023 06:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=shikadi.net
        ; s=since20200425; h=MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References;
        bh=ND0pD31csde2KLHVwQ6L1FzB1O9wl5BeBq3v9vAOJ/A=; b=Syaq9i/vqdBxcywDaUFm+Bwm9N
        oo/sTso7gxQFhU10S/4pzfM3gc3VqCBGrDmqeKkt0JqP5f4pTqUyo3CgtcEroyPwvj290O9terQm4
        BEg4Cap8m3AzF+c6fvROWcEuW2ysHpwE4mW0fVJPKv5IJliXrj/bvrkNn3H+bOBiUpEUSf11LXkCT
        GQAqq0PVjjaDb0MFgxlCiIgiGX0REETOtzlix55czCQr72THEMR5viJ0l8fzNKnqwui+AvmxEAyTr
        zLNE2wmIDqj2Fou/G2/ToYM/wPNZqrJKhGz2qnMRCAWXIbVxtNT90sRbsOeLWJN32bUle62bHLLkP
        2Fft8r9Q==;
Received: by sphereful.sorra.shikadi.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <a.nielsen@shikadi.net>)
        id 1qL1IH-0000N9-6V; Sun, 16 Jul 2023 22:56:09 +1000
Date:   Sun, 16 Jul 2023 22:56:04 +1000
From:   Adam Nielsen <a.nielsen@shikadi.net>
To:     sforshee@kernel.org
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH] wireless-regdb: Update regulatory rules for Australia (AU)
 for June 2023
Message-ID: <20230716225604.1d5a136a@vorticon.teln.shikadi.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

 - Update legislation link from March 2022 version to June 2023.
 - Add comments for each frequency range referring back to legislation.
 - Switch units from dBm to mW to match values listed in legislation.
 - Allow 5850-5875 at low power, as this has always been permitted.
 - Combine 5150-5350 bands to permit a 160 MHz channel.

Signed-off-by: Adam Nielsen <a.nielsen@shikadi.net>
---

Hi all,

Just a few minor changes for AU.  I have included (5150 - 5350 @ 160) which
overlaps two existing bands, however I am not sure if this is the correct way
to do it.  From what I gather, having the two bands listed separately (items
61 and 62 in the patch below) would prevent a single 160 MHz channel from
being spread across both bands.  I figure adding another entry that covers
both frequency ranges (with the most restrictive limitations) would permit
the 160 MHz channel to be used, however please correct me if this is wrong.

I added a bunch of comments pointing back to the relevant section of the
legislation document as I found it a bit of a challenge to work out where
each entry mapped back to.  So hopefully this will make it easier for the
next person to work out where the rules are coming from.

If there are any other issues with the patch let me know.

Cheers,
Adam.

 db.txt | 46 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/db.txt b/db.txt
index ef4e609..d0b7ec6 100644
--- a/db.txt
+++ b/db.txt
@@ -124,20 +124,48 @@ country AT: DFS-ETSI
 	(57000 - 66000 @ 2160), (40)
 
 # Source:
-# https://www.legislation.gov.au/Details/F2022C00281
+# 'Item' in the comments below refers to each numbered rule found at:
+# https://www.legislation.gov.au/Details/F2023C00524
 # Both DFS-ETSI and DFS-FCC are acceptable per AS/NZS 4268 Appendix B.
 # The EIRP for DFS bands can be increased by 3dB if TPC is implemented.
 # In order to allow 80MHz operation between 5650-5730MHz the upper boundary
 # of this more restrictive band has been shifted up by 5MHz from 5725MHz.
 country AU: DFS-ETSI
-	(2400 - 2483.5 @ 40), (36)
-	(5150 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW
-	(5250 - 5350 @ 80), (20), NO-OUTDOOR, AUTO-BW, DFS
-	(5470 - 5600 @ 80), (27), DFS
-	(5650 - 5730 @ 80), (27), DFS
-	(5730 - 5850 @ 80), (36)
-	(5925 - 6425 @ 160), (24), NO-OUTDOOR
-	(57000 - 66000 @ 2160), (43), NO-OUTDOOR
+	# Item 58
+	(915 - 928 @ 4), (1000 mW)
+	(920 - 928 @ 8), (1000 mW)
+
+	# Item 59
+	(2400 - 2483.5 @ 40), (4000 mW)
+
+	# Item 61
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
+
+	# Item 62 (200 mW allowed if TPC is used)
+	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, AUTO-BW, DFS
+
+	# Combine the above two bands to get a 160 MHz channel.
+	(5150 - 5350 @ 160), (100 mW), NO-OUTDOOR, AUTO-BW, DFS
+
+	# Item 63(a) (1000 mW with TPC)
+	(5470 - 5600 @ 80), (500 mW), DFS
+
+	# Item 63(b) (1000 mW with TPC)
+	# The end is 5725 but we borrow 5 MHz from the following less restrictive band
+	# so we can get an 80 MHz channel.
+	(5650 - 5730 @ 80), (500 mW), DFS
+
+	# Item 60
+	(5725 - 5850 @ 80), (4000 mW)
+
+	# Item 22
+	(5850 - 5875 @ 40), (25 mW)
+
+	# Item 63AA (25 mW if outdoors)
+	(5925 - 6425 @ 160), (250 mW), NO-OUTDOOR
+
+	# Item 65
+	(57000 - 71000 @ 2160), (20000 mW), NO-OUTDOOR
 
 country AW: DFS-ETSI
 	(2402 - 2482 @ 40), (20)
-- 
2.40.0
