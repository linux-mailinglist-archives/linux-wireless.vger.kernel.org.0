Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D00075FF3D
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jul 2023 20:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjGXSjm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jul 2023 14:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjGXSjl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jul 2023 14:39:41 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8926EA6
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 11:39:39 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1b059dd7c0cso3692109fac.0
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 11:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690223979; x=1690828779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=qHd1OKtKAPdnKEJPGdNA6g7tFSlkH0z/6Si2eMvqB2k=;
        b=oVO5YgH/SA4UZ7rcGRmAHVaVxI8P91IfG2aI3sQfTkUn+GoUzsX26cNVx05BIpE4/z
         loKZ4CF7uvzuNgA+SdBGGW6xIQuMuKnDban94S0tKlBQR+WJywgqASBMOqsvoNPeoMDr
         vi7v9bM5HJEj4SeT1r+nV4MlsoXbQxSiYw1A4Q8mhjUYj3JILJ4u0K6ScRikFm3c4EMw
         924aSG+t2fYcEh4ev6m7jb3K1qtbiMRQ/aD+JCgrBQ5HZm+xwkHhbKo6DIvn5FvHuHrh
         C59c6t6YXr/JurYU8zLoVUjQvekBDwtuQG5RIWJ496/PfLca8KIDsbSLGwl+vCeibyB+
         9dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690223979; x=1690828779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHd1OKtKAPdnKEJPGdNA6g7tFSlkH0z/6Si2eMvqB2k=;
        b=P+BkeaGGo1UIlwGYnBKIyeRWxgCDICywqNPA38li0RtZG2QMFHx4TfL5oO3xoHxz8c
         xktsU+L6gayUuhKMJOmGYSJBiMZP5lUCAbS+/z6NGEB/OSB7khBE4ll1+ar2YCN+CnIh
         KAmKGOQIq9+mRqjnA8wxD8Qox6zvhazGtp7wHUTwZpJmQ/6psohj9BdtJFGCMuCtG7rF
         f7NfTlH+lZuL5YWbCAy4bJfzBSrQGCtyg0oSbNRUtJpFC3bPZf1gsvM06dvw7HzbSqk3
         zhCPKOH+r5DHogHSS/oDyJzbmAWH5KuW6UFVf9U+xGspEWdOf/oK6lGy242gv3bOwDff
         I+Jw==
X-Gm-Message-State: ABy/qLbzLHpkLmLXEnj4Uc4NFCFzvtBbvAh0aZ/KzhEgukEKFiHQUGpw
        0B2p/s5N+B+6BOHoag/CCQI=
X-Google-Smtp-Source: APBJJlHFLcj5ZVfvXRkgj7Dh5J1tE65ck/Szabk9TwYwNDtu+PI+Vm2yFywEtF9MtrzEvd1hbfb5Lw==
X-Received: by 2002:a05:6870:d609:b0:1bb:5353:336c with SMTP id a9-20020a056870d60900b001bb5353336cmr6270771oaq.48.1690223978693;
        Mon, 24 Jul 2023 11:39:38 -0700 (PDT)
Received: from localhost.localdomain ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id e3-20020a056870944300b001b04434d934sm4618036oal.34.2023.07.24.11.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 11:39:38 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Ping-Ke Shih <pkshih@realtek.com>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] wifi: rtw89: Fix loading of compressed firmware
Date:   Mon, 24 Jul 2023 13:39:27 -0500
Message-ID: <20230724183927.28553-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When using compressed firmware, the early firmware load feature will fail.
In most cases, the only downside is that if a device has more than one
firmware version available, only the last one listed will be loaded.
In at least two cases, there is no firmware loaded, and the device fails
initialization. See https://github.com/lwfinger/rtw89/issues/259 and
https://bugzilla.opensuse.org/show_bug.cgi?id=1212808 for examples of
the failure.
  
When firmware_class.dyndbg=+p" added to the kernel boot parameters, the
following is found:

finger@localhost:~/rtw89>sudo dmesg -t | grep rtw89
firmware_class: __allocate_fw_priv: fw-rtw89/rtw8852b_fw-1.bin fw_priv=00000000638862fb
rtw89_8852be 0000:02:00.0: loading /lib/firmware/updates/5.14.21-150500.53-default/rtw89/rtw8852b_fw-1.bin failed for no such file or directory.
rtw89_8852be 0000:02:00.0: loading /lib/firmware/updates/rtw89/rtw8852b_fw-1.bin failed for no such file or directory.
rtw89_8852be 0000:02:00.0: loading /lib/firmware/5.14.21-150500.53-default/rtw89/rtw8852b_fw-1.bin failed for no such file or directory.
rtw89_8852be 0000:02:00.0: loading /lib/firmware/rtw89/rtw8852b_fw-1.bin failed for no such file or directory.
rtw89_8852be 0000:02:00.0: Direct firmware load for rtw89/rtw8852b_fw-1.bin failed with error -2
firmware_class: __free_fw_priv: fw-rtw89/rtw8852b_fw-1.bin fw_priv=00000000638862fb data=00000000307c30c7 size=0
firmware_class: __allocate_fw_priv: fw-rtw89/rtw8852b_fw.bin fw_priv=00000000638862fb
rtw89_8852be 0000:02:00.0: loading /lib/firmware/updates/5.14.21-150500.53-default/rtw89/rtw8852b_fw.bin failed for no such file or directory.
rtw89_8852be 0000:02:00.0: loading /lib/firmware/updates/rtw89/rtw8852b_fw.bin failed for no such file or directory.
rtw89_8852be 0000:02:00.0: loading /lib/firmware/5.14.21-150500.53-default/rtw89/rtw8852b_fw.bin failed for no such file or directory.
rtw89_8852be 0000:02:00.0: loading /lib/firmware/rtw89/rtw8852b_fw.bin failed for no such file or directory.
rtw89_8852be 0000:02:00.0: Direct firmware load for rtw89/rtw8852b_fw.bin failed with error -2
firmware_class: __free_fw_priv: fw-rtw89/rtw8852b_fw.bin fw_priv=00000000638862fb data=00000000307c30c7 size=0
rtw89_8852be 0000:02:00.0: failed to early request firmware: -2
firmware_class: __allocate_fw_priv: fw-rtw89/rtw8852b_fw.bin fw_priv=00000000638862fb
rtw89_8852be 0000:02:00.0: loading /lib/firmware/updates/5.14.21-150500.53-default/rtw89/rtw8852b_fw.bin failed for no such file or directory.
rtw89_8852be 0000:02:00.0: loading /lib/firmware/updates/rtw89/rtw8852b_fw.bin failed for no such file or directory.
rtw89_8852be 0000:02:00.0: loading /lib/firmware/5.14.21-150500.53-default/rtw89/rtw8852b_fw.bin failed for no such file or directory.
rtw89_8852be 0000:02:00.0: loading /lib/firmware/rtw89/rtw8852b_fw.bin failed for no such file or directory.
rtw89_8852be 0000:02:00.0: loading /lib/firmware/updates/5.14.21-150500.53-default/rtw89/rtw8852b_fw.bin.xz failed for no such file or directory.
rtw89_8852be 0000:02:00.0: loading /lib/firmware/updates/rtw89/rtw8852b_fw.bin.xz failed for no such file or directory.
rtw89_8852be 0000:02:00.0: loading /lib/firmware/5.14.21-150500.53-default/rtw89/rtw8852b_fw.bin.xz failed for no such file or directory.
rtw89_8852be 0000:02:00.0: Loading firmware from /lib/firmware/rtw89/rtw8852b_fw.bin.xz
rtw89_8852be 0000:02:00.0: f/w decompressing rtw89/rtw8852b_fw.bin
firmware_class: fw_set_page_data: fw-rtw89/rtw8852b_fw.bin fw_priv=00000000638862fb data=000000004ed6c2f7 size=1035232
rtw89_8852be 0000:02:00.0: Firmware version 0.27.32.1, cmd version 0, type 1
rtw89_8852be 0000:02:00.0: Firmware version 0.27.32.1, cmd version 0, type 3

The key is that firmware version 0.27.32.1 is loaded.

With this patch, the following is obtained:

firmware_class: __free_fw_priv: fw-rtw89/rtw8852b_fw.bin fw_priv=000000000849addc data=00000000fd3cabe2 size=1035232
firmware_class: fw_name_devm_release: fw_name-rtw89/rtw8852b_fw.bin devm-000000002d8c3343 released
firmware_class: __allocate_fw_priv: fw-rtw89/rtw8852b_fw-1.bin fw_priv=000000009e1a6364
rtw89_8852be 0000:02:00.0: loading /lib/firmware/updates/6.4.3-1-default/rtw89/rtw8852b_fw-1.bin failed for no such file or directory.
rtw89_8852be 0000:02:00.0: loading /lib/firmware/updates/rtw89/rtw8852b_fw-1.bin failed for no such file or directory.
rtw89_8852be 0000:02:00.0: loading /lib/firmware/6.4.3-1-default/rtw89/rtw8852b_fw-1.bin failed for no such file or directory.
rtw89_8852be 0000:02:00.0: loading /lib/firmware/rtw89/rtw8852b_fw-1.bin failed for no such file or directory.
rtw89_8852be 0000:02:00.0: loading /lib/firmware/updates/6.4.3-1-default/rtw89/rtw8852b_fw-1.bin.zst failed for no such file or directory.
rtw89_8852be 0000:02:00.0: loading /lib/firmware/updates/rtw89/rtw8852b_fw-1.bin.zst failed for no such file or directory.
rtw89_8852be 0000:02:00.0: loading /lib/firmware/6.4.3-1-default/rtw89/rtw8852b_fw-1.bin.zst failed for no such file or directory.
rtw89_8852be 0000:02:00.0: loading /lib/firmware/rtw89/rtw8852b_fw-1.bin.zst failed for no such file or directory.
rtw89_8852be 0000:02:00.0: loading /lib/firmware/updates/6.4.3-1-default/rtw89/rtw8852b_fw-1.bin.xz failed for no such file or directory.
rtw89_8852be 0000:02:00.0: loading /lib/firmware/updates/rtw89/rtw8852b_fw-1.bin.xz failed for no such file or directory.
rtw89_8852be 0000:02:00.0: loading /lib/firmware/6.4.3-1-default/rtw89/rtw8852b_fw-1.bin.xz failed for no such file or directory.
rtw89_8852be 0000:02:00.0: Loading firmware from /lib/firmware/rtw89/rtw8852b_fw-1.bin.xz
rtw89_8852be 0000:02:00.0: f/w decompressing rtw89/rtw8852b_fw-1.bin
firmware_class: fw_set_page_data: fw-rtw89/rtw8852b_fw-1.bin fw_priv=000000009e1a6364 data=00000000fd3cabe2 size=1184992
rtw89_8852be 0000:02:00.0: Loaded FW: rtw89/rtw8852b_fw-1.bin, sha256: 8539efc75f513f4585cf0cd6e79e6507da47fce87225f2d0de391a03aefe9ac8
rtw89_8852be 0000:02:00.0: loaded firmware rtw89/rtw8852b_fw-1.bin
rtw89_8852be 0000:02:00.0: Firmware version 0.29.29.1, cmd version 0, type 5
rtw89_8852be 0000:02:00.0: Firmware version 0.29.29.1, cmd version 0, type 3

Now, version 0.29.29.1 is loaded.

Fixes: ffde7f3476a6 ("wifi: rtw89: add firmware format version to backward compatible with older drivers")
Cc: Ping-Ke Shih <pkshih@realtek.com>
Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 27 +++----------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 9637f5e48d84..d44628a90046 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -312,31 +312,17 @@ rtw89_early_fw_feature_recognize(struct device *device,
 				 struct rtw89_fw_info *early_fw,
 				 int *used_fw_format)
 {
-	union rtw89_compat_fw_hdr buf = {};
 	const struct firmware *firmware;
-	bool full_req = false;
 	char fw_name[64];
 	int fw_format;
 	u32 ver_code;
 	int ret;
 
-	/* If SECURITY_LOADPIN_ENFORCE is enabled, reading partial files will
-	 * be denied (-EPERM). Then, we don't get right firmware things as
-	 * expected. So, in this case, we have to request full firmware here.
-	 */
-	if (IS_ENABLED(CONFIG_SECURITY_LOADPIN_ENFORCE))
-		full_req = true;
-
 	for (fw_format = chip->fw_format_max; fw_format >= 0; fw_format--) {
 		rtw89_fw_get_filename(fw_name, sizeof(fw_name),
 				      chip->fw_basename, fw_format);
 
-		if (full_req)
-			ret = request_firmware(&firmware, fw_name, device);
-		else
-			ret = request_partial_firmware_into_buf(&firmware, fw_name,
-								device, &buf, sizeof(buf),
-								0);
+		ret = request_firmware(&firmware, fw_name, device);
 		if (!ret) {
 			dev_info(device, "loaded firmware %s\n", fw_name);
 			*used_fw_format = fw_format;
@@ -349,10 +335,7 @@ rtw89_early_fw_feature_recognize(struct device *device,
 		return NULL;
 	}
 
-	if (full_req)
-		ver_code = rtw89_compat_fw_hdr_ver_code(firmware->data);
-	else
-		ver_code = rtw89_compat_fw_hdr_ver_code(&buf);
+	ver_code = rtw89_compat_fw_hdr_ver_code(firmware->data);
 
 	if (!ver_code)
 		goto out;
@@ -360,11 +343,7 @@ rtw89_early_fw_feature_recognize(struct device *device,
 	rtw89_fw_iterate_feature_cfg(early_fw, chip, ver_code);
 
 out:
-	if (full_req)
-		return firmware;
-
-	release_firmware(firmware);
-	return NULL;
+	return firmware;
 }
 
 int rtw89_fw_recognize(struct rtw89_dev *rtwdev)
-- 
2.41.0

