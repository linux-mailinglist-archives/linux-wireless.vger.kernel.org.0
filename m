Return-Path: <linux-wireless+bounces-24717-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA889AEF5B1
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 12:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C3D1C0096F
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 10:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6248242D8C;
	Tue,  1 Jul 2025 10:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qpnO/GR5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC87670810;
	Tue,  1 Jul 2025 10:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751367382; cv=none; b=lPfexhZtUkbdQQKyuC6BgM/89IB30aYdYvHuj17Fgr5HDTYmBWJZwP4BRmdrBUGpmY0b/BGNEjAuWzhM6itk95+11+n4urs4lv3Z3WsQOzu+YJ1D5X5H0L1kxNfnSbyJQEQkteFDZ0GuVNPW+8QNTC1iNK2S3C9R8gUYfhPGNUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751367382; c=relaxed/simple;
	bh=/mpJLFgTBsmMundcmLbZ3GeCWvFKmDAizX58ReQPyV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GTQ+UpZqkNVFCWvTt9foz48ohUw8OXEgVdLdASYZD64BjWfpx5rpG96AsHatBdosHgUNDChdAqYdBU9Y0iATxUZs4hkZX9aE+XFTUnq/STLiuWGdd01i7o27s8XMxOtmfMoiqBC4zjuLtf6porcrBUnONaSD8Ty3my3J8FlxX1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qpnO/GR5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44CEC4CEEB;
	Tue,  1 Jul 2025 10:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751367382;
	bh=/mpJLFgTBsmMundcmLbZ3GeCWvFKmDAizX58ReQPyV4=;
	h=From:To:Cc:Subject:Date:From;
	b=qpnO/GR57EaZT+fJz7lpFpY+GS5CFU62UpERmhiNjsk1e63dr9CH08bzYhk78WnVn
	 dg6WEPr6WTPynAAA5CGd+Wyc9MwFNv5oVfHnFaC0x3GltRVGpcOI3j1R4qN1jfZxc8
	 8jQtGIWkGxATTvOu1oT4NetsAw3VhLpCLhuePJkw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Subject: [PATCH v5] wifi: cfg80211: move away from using a fake platform device
Date: Tue,  1 Jul 2025 12:56:17 +0200
Message-ID: <2025070116-growing-skeptic-494c@gregkh>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 128
X-Developer-Signature: v=1; a=openpgp-sha256; l=4335; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=/mpJLFgTBsmMundcmLbZ3GeCWvFKmDAizX58ReQPyV4=; b=owGbwMvMwCRo6H6F97bub03G02pJDBnJ+y6IVyneWLUhqH+12K4/EXcPPtGWTOtzXphy7uDuG LNzL9QbOmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAi33cyzGabNetwsLsTk9HS ze8u9b8+c5cz4RfDTMajpvaP5rXvYX79XW2GtOov87Ud6gA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Downloading regulatory "firmware" needs a device to hang off of, and so
a platform device seemed like the simplest way to do this.  Now that we
have a faux device interface, use that instead as this "regulatory
device" is not anything resembling a platform device at all.

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: <linux-wireless@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v5: - rebase against 6.16-rc4 and actually cc: the relevant maintainers
      and mailing lists this time, doh!
v4: - api tweaked due to parent pointer added to faux_device create
      function.
v3: - no change
v2: - new example patch in a larger series

 net/wireless/reg.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index c1752b31734f..2524bc187a19 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -53,7 +53,7 @@
 #include <linux/list.h>
 #include <linux/ctype.h>
 #include <linux/nl80211.h>
-#include <linux/platform_device.h>
+#include <linux/device/faux.h>
 #include <linux/verification.h>
 #include <linux/moduleparam.h>
 #include <linux/firmware.h>
@@ -105,7 +105,7 @@ static struct regulatory_request __rcu *last_request =
 	(void __force __rcu *)&core_request_world;
 
 /* To trigger userspace events and load firmware */
-static struct platform_device *reg_pdev;
+static struct faux_device *reg_fdev;
 
 /*
  * Central wireless core regulatory domains, we only need two,
@@ -583,7 +583,7 @@ static int call_crda(const char *alpha2)
 	else
 		pr_debug("Calling CRDA to update world regulatory domain\n");
 
-	ret = kobject_uevent_env(&reg_pdev->dev.kobj, KOBJ_CHANGE, env);
+	ret = kobject_uevent_env(&reg_fdev->dev.kobj, KOBJ_CHANGE, env);
 	if (ret)
 		return ret;
 
@@ -779,7 +779,7 @@ static bool regdb_has_valid_signature(const u8 *data, unsigned int size)
 	const struct firmware *sig;
 	bool result;
 
-	if (request_firmware(&sig, "regulatory.db.p7s", &reg_pdev->dev))
+	if (request_firmware(&sig, "regulatory.db.p7s", &reg_fdev->dev))
 		return false;
 
 	result = verify_pkcs7_signature(data, size, sig->data, sig->size,
@@ -1061,7 +1061,7 @@ static int query_regdb_file(const char *alpha2)
 		return -ENOMEM;
 
 	err = request_firmware_nowait(THIS_MODULE, true, "regulatory.db",
-				      &reg_pdev->dev, GFP_KERNEL,
+				      &reg_fdev->dev, GFP_KERNEL,
 				      (void *)alpha2, regdb_fw_cb);
 	if (err)
 		kfree(alpha2);
@@ -1077,7 +1077,7 @@ int reg_reload_regdb(void)
 	const struct ieee80211_regdomain *current_regdomain;
 	struct regulatory_request *request;
 
-	err = request_firmware(&fw, "regulatory.db", &reg_pdev->dev);
+	err = request_firmware(&fw, "regulatory.db", &reg_fdev->dev);
 	if (err)
 		return err;
 
@@ -4300,12 +4300,12 @@ static int __init regulatory_init_db(void)
 	 * in that case, don't try to do any further work here as
 	 * it's doomed to lead to crashes.
 	 */
-	if (IS_ERR_OR_NULL(reg_pdev))
+	if (!reg_fdev)
 		return -EINVAL;
 
 	err = load_builtin_regdb_keys();
 	if (err) {
-		platform_device_unregister(reg_pdev);
+		faux_device_destroy(reg_fdev);
 		return err;
 	}
 
@@ -4313,7 +4313,7 @@ static int __init regulatory_init_db(void)
 	err = regulatory_hint_core(cfg80211_world_regdom->alpha2);
 	if (err) {
 		if (err == -ENOMEM) {
-			platform_device_unregister(reg_pdev);
+			faux_device_destroy(reg_fdev);
 			return err;
 		}
 		/*
@@ -4342,9 +4342,9 @@ late_initcall(regulatory_init_db);
 
 int __init regulatory_init(void)
 {
-	reg_pdev = platform_device_register_simple("regulatory", 0, NULL, 0);
-	if (IS_ERR(reg_pdev))
-		return PTR_ERR(reg_pdev);
+	reg_fdev = faux_device_create("regulatory", NULL, NULL);
+	if (!reg_fdev)
+		return -ENODEV;
 
 	rcu_assign_pointer(cfg80211_regdomain, cfg80211_world_regdom);
 
@@ -4372,9 +4372,9 @@ void regulatory_exit(void)
 	reset_regdomains(true, NULL);
 	rtnl_unlock();
 
-	dev_set_uevent_suppress(&reg_pdev->dev, true);
+	dev_set_uevent_suppress(&reg_fdev->dev, true);
 
-	platform_device_unregister(reg_pdev);
+	faux_device_destroy(reg_fdev);
 
 	list_for_each_entry_safe(reg_beacon, btmp, &reg_pending_beacons, list) {
 		list_del(&reg_beacon->list);
-- 
2.50.0


