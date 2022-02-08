Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD25A4ACE1C
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Feb 2022 02:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238805AbiBHBsB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Feb 2022 20:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343607AbiBHBbK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Feb 2022 20:31:10 -0500
X-Greylist: delayed 376 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 17:31:10 PST
Received: from web.adapt-ip.com (mail.adapt-ip.com [107.194.246.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5789AC061355
        for <linux-wireless@vger.kernel.org>; Mon,  7 Feb 2022 17:31:10 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id D5F436A4575;
        Tue,  8 Feb 2022 01:24:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id rFJ6zLVmbu2o; Tue,  8 Feb 2022 01:24:51 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (c-67-188-101-182.hsd1.ca.comcast.net [67.188.101.182])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 347756A431E;
        Tue,  8 Feb 2022 01:24:50 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     sforshee@kernel.org
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH 1/2] wireless-regdb: add support for US S1G channels
Date:   Mon,  7 Feb 2022 17:24:49 -0800
Message-Id: <20220208012450.190982-1-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The 902-928MHz band is one of the US ISM bands, so follows
the same emission limits described in FCC part 15.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 db.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/db.txt b/db.txt
index 6dbda3c17e54..b6732070f6d7 100644
--- a/db.txt
+++ b/db.txt
@@ -1596,6 +1596,12 @@ country UG: DFS-FCC
 # frequency band, 2,483.5–2,500 MHz which is subject to strict emission limits
 # set out in 47 CFR § 15.205. TODO: reenable and specify a safe TX power here.
 country US: DFS-FCC
+	# S1G Channel 1-3
+	(902-904 @ 2), (30)
+	# S1G Channel 5-35
+	(904-920 @ 16), (30)
+	# S1G Channel 37-51
+	(920-928 @ 8), (30)
 	(2400 - 2472 @ 40), (30)
 	# 5.15 ~ 5.25 GHz: 30 dBm for master mode, 23 dBm for clients
 	(5150 - 5250 @ 80), (23), AUTO-BW
-- 
2.30.2

