Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636ED1B8594
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2020 12:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgDYKUT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Apr 2020 06:20:19 -0400
Received: from mailomta14-re.btinternet.com ([213.120.69.107]:10346 "EHLO
        re-prd-fep-042.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726088AbgDYKUS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Apr 2020 06:20:18 -0400
X-Greylist: delayed 59364 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Apr 2020 06:20:17 EDT
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
          by re-prd-fep-048.btinternet.com with ESMTP
          id <20200424175051.NJSI20795.re-prd-fep-048.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
          Fri, 24 Apr 2020 18:50:51 +0100
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=j.oldman998@btinternet.com
X-Originating-IP: [31.51.225.56]
X-OWM-Source-IP: 31.51.225.56 (GB)
X-OWM-Env-Sender: j.oldman998@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdduudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffosedttdertdertddtnecuhfhrohhmpeflohhhnhcuqfhlughmrghnuceojhhohhhnrdholhgumhgrnhesphholhgvhhhilhhlrdgtohdruhhkqeenucfkphepfedurdehuddrvddvhedrheeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghlohephhgvnhhrhidrhhhomhgvpdhinhgvthepfedurdehuddrvddvhedrheeipdhmrghilhhfrhhomhepoehjohhhnhdrohhlughmrghnsehpohhlvghhihhllhdrtghordhukheqpdhrtghpthhtohepoehjohhhnhdrohhlughmrghnsehpohhlvghhihhllhdrtghordhukheqpdhrtghpthhtohepoehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehlihhnuhigqdifihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehmsegsuhgvshdrtghhqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from henry.home (31.51.225.56) by re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as j.oldman998@btinternet.com)
        id 5E3A15B60CEBB0BC; Fri, 24 Apr 2020 18:50:51 +0100
From:   John Oldman <john.oldman@polehill.co.uk>
To:     m@bues.ch
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Oldman <john.oldman@polehill.co.uk>
Subject: [PATCH] :ssb sprom.c: Fixed block comments coding style issues
Date:   Fri, 24 Apr 2020 18:50:43 +0100
Message-Id: <20200424175043.16261-1-john.oldman@polehill.co.uk>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixed coding style issues

Signed-off-by: John Oldman <john.oldman@polehill.co.uk>
---
 drivers/ssb/sprom.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/ssb/sprom.c b/drivers/ssb/sprom.c
index 52d2e0f33be7..42d620cee8a9 100644
--- a/drivers/ssb/sprom.c
+++ b/drivers/ssb/sprom.c
@@ -78,7 +78,8 @@ ssize_t ssb_attr_sprom_show(struct ssb_bus *bus, char *buf,
 
 	/* Use interruptible locking, as the SPROM write might
 	 * be holding the lock for several seconds. So allow userspace
-	 * to cancel operation. */
+	 * to cancel operation.
+	 */
 	err = -ERESTARTSYS;
 	if (mutex_lock_interruptible(&bus->sprom_mutex))
 		goto out_kfree;
@@ -121,7 +122,8 @@ ssize_t ssb_attr_sprom_store(struct ssb_bus *bus,
 
 	/* Use interruptible locking, as the SPROM write might
 	 * be holding the lock for several seconds. So allow userspace
-	 * to cancel operation. */
+	 * to cancel operation.
+	 */
 	err = -ERESTARTSYS;
 	if (mutex_lock_interruptible(&bus->sprom_mutex))
 		goto out_kfree;
@@ -188,9 +190,11 @@ int ssb_fill_sprom_with_fallback(struct ssb_bus *bus, struct ssb_sprom *out)
 bool ssb_is_sprom_available(struct ssb_bus *bus)
 {
 	/* status register only exists on chipcomon rev >= 11 and we need check
-	   for >= 31 only */
+	 * for >= 31 only
+	 */
 	/* this routine differs from specs as we do not access SPROM directly
-	   on PCMCIA */
+	 * on PCMCIA
+	 */
 	if (bus->bustype == SSB_BUSTYPE_PCI &&
 	    bus->chipco.dev &&	/* can be unavailable! */
 	    bus->chipco.dev->id.revision >= 31)
-- 
2.17.1

