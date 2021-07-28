Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C747B3D9711
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jul 2021 22:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhG1Uu6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jul 2021 16:50:58 -0400
Received: from lpdvacalvio01.broadcom.com ([192.19.166.228]:39214 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231594AbhG1Uu4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jul 2021 16:50:56 -0400
Received: from bld-lvn-bcawlan-34.lvn.broadcom.net (bld-lvn-bcawlan-34.lvn.broadcom.net [10.75.138.137])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 46ADA8281;
        Wed, 28 Jul 2021 13:50:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 46ADA8281
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1627505454;
        bh=IyeqqNEuGTva5pUwmFNZZ0PCNs9PQwEh3MqD7I/VfyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZAx1LJS50T2w+hLe1GIKm3a+XMjTWM2qb63SVJsbJYFOeLdfWbzPv+lEdPMqU0azG
         bYpxX281Vj5G1WUf4cNxb2Nhq61Umf4fjBHpmurkFSY0H2UuwYvEeLcxlMNodyakwt
         plYtITzvJQB5MrKqKZ0NrzNYtxqv8MckQoNxW3kk=
Received: from bld-bun-01.bun.broadcom.net (bld-bun-01.bun.broadcom.net [10.176.128.83])
        by bld-lvn-bcawlan-34.lvn.broadcom.net (Postfix) with ESMTPSA id 7E8701874BD;
        Wed, 28 Jul 2021 13:50:53 -0700 (PDT)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 3/4] brcmfmac: add xtlv support to firmware interface layer
Date:   Wed, 28 Jul 2021 22:50:33 +0200
Message-Id: <1627505434-9544-4-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1627505434-9544-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1627505434-9544-1-git-send-email-arend.vanspriel@broadcom.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Newer firmware API require commands to use xtlv format. Add support
for that in the firmware interface layer.

Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 .../broadcom/brcm80211/brcmfmac/Makefile      |   3 +-
 .../broadcom/brcm80211/brcmfmac/fwil.c        | 126 +++++++++++++++++-
 .../broadcom/brcm80211/brcmfmac/fwil.h        |   8 ++
 .../broadcom/brcm80211/brcmfmac/xtlv.c        |  82 ++++++++++++
 .../broadcom/brcm80211/brcmfmac/xtlv.h        |  31 +++++
 5 files changed, 244 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/xtlv.c
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/xtlv.h

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Makefile b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Makefile
index 9b15bc3f6054..13c13504a6e8 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Makefile
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/Makefile
@@ -23,7 +23,8 @@ brcmfmac-objs += \
 		feature.o \
 		btcoex.o \
 		vendor.o \
-		pno.o
+		pno.o \
+		xtlv.o
 brcmfmac-$(CONFIG_BRCMFMAC_PROTO_BCDC) += \
 		bcdc.o \
 		fwsignal.o
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c
index 9ed85420f3ca..d5578ca681bb 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c
@@ -15,6 +15,7 @@
 #include "bus.h"
 #include "debug.h"
 #include "tracepoint.h"
+#include "xtlv.h"
 #include "fwil.h"
 #include "proto.h"
 
@@ -150,7 +151,8 @@ brcmf_fil_cmd_data_get(struct brcmf_if *ifp, u32 cmd, void *data, u32 len)
 	mutex_lock(&ifp->drvr->proto_block);
 	err = brcmf_fil_cmd_data(ifp, cmd, data, len, false);
 
-	brcmf_dbg(FIL, "ifidx=%d, cmd=%d, len=%d\n", ifp->ifidx, cmd, len);
+	brcmf_dbg(FIL, "ifidx=%d, cmd=%d, len=%d, err=%d\n", ifp->ifidx, cmd,
+		  len, err);
 	brcmf_dbg_hex_dump(BRCMF_FIL_ON(), data,
 			   min_t(uint, len, MAX_HEX_DUMP_LEN), "data\n");
 
@@ -260,7 +262,8 @@ brcmf_fil_iovar_data_get(struct brcmf_if *ifp, char *name, void *data,
 		bphy_err(drvr, "Creating iovar failed\n");
 	}
 
-	brcmf_dbg(FIL, "ifidx=%d, name=%s, len=%d\n", ifp->ifidx, name, len);
+	brcmf_dbg(FIL, "ifidx=%d, name=%s, len=%d, err=%d\n", ifp->ifidx, name,
+		  len, err);
 	brcmf_dbg_hex_dump(BRCMF_FIL_ON(), data,
 			   min_t(uint, len, MAX_HEX_DUMP_LEN), "data\n");
 
@@ -383,14 +386,13 @@ brcmf_fil_bsscfg_data_get(struct brcmf_if *ifp, char *name,
 		err = -EPERM;
 		bphy_err(drvr, "Creating bsscfg failed\n");
 	}
-	brcmf_dbg(FIL, "ifidx=%d, bsscfgidx=%d, name=%s, len=%d\n", ifp->ifidx,
-		  ifp->bsscfgidx, name, len);
+	brcmf_dbg(FIL, "ifidx=%d, bsscfgidx=%d, name=%s, len=%d, err=%d\n",
+		  ifp->ifidx, ifp->bsscfgidx, name, len, err);
 	brcmf_dbg_hex_dump(BRCMF_FIL_ON(), data,
 			   min_t(uint, len, MAX_HEX_DUMP_LEN), "data\n");
 
 	mutex_unlock(&drvr->proto_block);
 	return err;
-
 }
 
 s32
@@ -414,3 +416,117 @@ brcmf_fil_bsscfg_int_get(struct brcmf_if *ifp, char *name, u32 *data)
 		*data = le32_to_cpu(data_le);
 	return err;
 }
+
+static u32 brcmf_create_xtlv(char *name, u16 id, char *data, u32 len,
+			     char *buf, u32 buflen)
+{
+	u32 iolen;
+	u32 nmlen;
+
+	nmlen = strlen(name) + 1;
+	iolen = nmlen + brcmf_xtlv_data_size(len, BRCMF_XTLV_OPTION_ALIGN32);
+
+	if (iolen > buflen) {
+		brcmf_err("buffer is too short\n");
+		return 0;
+	}
+
+	memcpy(buf, name, nmlen);
+	brcmf_xtlv_pack_header((void *)(buf + nmlen), id, len, data,
+			       BRCMF_XTLV_OPTION_ALIGN32);
+
+	return iolen;
+}
+
+s32 brcmf_fil_xtlv_data_set(struct brcmf_if *ifp, char *name, u16 id,
+			    void *data, u32 len)
+{
+	struct brcmf_pub *drvr = ifp->drvr;
+	s32 err;
+	u32 buflen;
+
+	mutex_lock(&drvr->proto_block);
+
+	brcmf_dbg(FIL, "ifidx=%d, name=%s, id=%u, len=%u\n", ifp->ifidx, name,
+		  id, len);
+	brcmf_dbg_hex_dump(BRCMF_FIL_ON(), data,
+			   min_t(uint, len, MAX_HEX_DUMP_LEN), "data\n");
+
+	buflen = brcmf_create_xtlv(name, id, data, len,
+				   drvr->proto_buf, sizeof(drvr->proto_buf));
+	if (buflen) {
+		err = brcmf_fil_cmd_data(ifp, BRCMF_C_SET_VAR, drvr->proto_buf,
+					 buflen, true);
+	} else {
+		err = -EPERM;
+		bphy_err(drvr, "Creating xtlv failed\n");
+	}
+
+	mutex_unlock(&drvr->proto_block);
+	return err;
+}
+
+s32 brcmf_fil_xtlv_data_get(struct brcmf_if *ifp, char *name, u16 id,
+			    void *data, u32 len)
+{
+	struct brcmf_pub *drvr = ifp->drvr;
+	s32 err;
+	u32 buflen;
+
+	mutex_lock(&drvr->proto_block);
+
+	buflen = brcmf_create_xtlv(name, id, data, len,
+				   drvr->proto_buf, sizeof(drvr->proto_buf));
+	if (buflen) {
+		err = brcmf_fil_cmd_data(ifp, BRCMF_C_GET_VAR, drvr->proto_buf,
+					 buflen, false);
+		if (err == 0)
+			memcpy(data, drvr->proto_buf, len);
+	} else {
+		err = -EPERM;
+		bphy_err(drvr, "Creating bsscfg failed\n");
+	}
+	brcmf_dbg(FIL, "ifidx=%d, name=%s, id=%u, len=%u, err=%d\n",
+		  ifp->ifidx, name, id, len, err);
+	brcmf_dbg_hex_dump(BRCMF_FIL_ON(), data,
+			   min_t(uint, len, MAX_HEX_DUMP_LEN), "data\n");
+
+	mutex_unlock(&drvr->proto_block);
+	return err;
+}
+
+s32 brcmf_fil_xtlv_int_set(struct brcmf_if *ifp, char *name, u16 id, u32 data)
+{
+	__le32 data_le = cpu_to_le32(data);
+
+	return brcmf_fil_xtlv_data_set(ifp, name, id, &data_le,
+					 sizeof(data_le));
+}
+
+s32 brcmf_fil_xtlv_int_get(struct brcmf_if *ifp, char *name, u16 id, u32 *data)
+{
+	__le32 data_le = cpu_to_le32(*data);
+	s32 err;
+
+	err = brcmf_fil_xtlv_data_get(ifp, name, id, &data_le, sizeof(data_le));
+	if (err == 0)
+		*data = le32_to_cpu(data_le);
+	return err;
+}
+
+s32 brcmf_fil_xtlv_int8_get(struct brcmf_if *ifp, char *name, u16 id, u8 *data)
+{
+	return brcmf_fil_xtlv_data_get(ifp, name, id, data, sizeof(*data));
+}
+
+s32 brcmf_fil_xtlv_int16_get(struct brcmf_if *ifp, char *name, u16 id, u16 *data)
+{
+	__le16 data_le = cpu_to_le16(*data);
+	s32 err;
+
+	err = brcmf_fil_xtlv_data_get(ifp, name, id, &data_le, sizeof(data_le));
+	if (err == 0)
+		*data = le16_to_cpu(data_le);
+	return err;
+}
+
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h
index ae4cf4372908..cb26f8c59c21 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h
@@ -97,5 +97,13 @@ s32 brcmf_fil_bsscfg_data_get(struct brcmf_if *ifp, char *name, void *data,
 			      u32 len);
 s32 brcmf_fil_bsscfg_int_set(struct brcmf_if *ifp, char *name, u32 data);
 s32 brcmf_fil_bsscfg_int_get(struct brcmf_if *ifp, char *name, u32 *data);
+s32 brcmf_fil_xtlv_data_set(struct brcmf_if *ifp, char *name, u16 id,
+			    void *data, u32 len);
+s32 brcmf_fil_xtlv_data_get(struct brcmf_if *ifp, char *name, u16 id,
+			    void *data, u32 len);
+s32 brcmf_fil_xtlv_int_set(struct brcmf_if *ifp, char *name, u16 id, u32 data);
+s32 brcmf_fil_xtlv_int_get(struct brcmf_if *ifp, char *name, u16 id, u32 *data);
+s32 brcmf_fil_xtlv_int8_get(struct brcmf_if *ifp, char *name, u16 id, u8 *data);
+s32 brcmf_fil_xtlv_int16_get(struct brcmf_if *ifp, char *name, u16 id, u16 *data);
 
 #endif /* _fwil_h_ */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/xtlv.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/xtlv.c
new file mode 100644
index 000000000000..2f3c451148db
--- /dev/null
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/xtlv.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2019 Broadcom
+ */
+
+#include <asm/unaligned.h>
+#include <linux/string.h>
+#include <linux/bug.h>
+
+#include "xtlv.h"
+
+static int brcmf_xtlv_header_size(u16 opts)
+{
+	int len = (int)offsetof(struct brcmf_xtlv, data);
+
+	if (opts & BRCMF_XTLV_OPTION_IDU8)
+		--len;
+	if (opts & BRCMF_XTLV_OPTION_LENU8)
+		--len;
+
+	return len;
+}
+
+int brcmf_xtlv_data_size(int dlen, u16 opts)
+{
+	int hsz;
+
+	hsz = brcmf_xtlv_header_size(opts);
+	if (opts & BRCMF_XTLV_OPTION_ALIGN32)
+		return roundup(dlen + hsz, 4);
+
+	return dlen + hsz;
+}
+
+void brcmf_xtlv_pack_header(struct brcmf_xtlv *xtlv, u16 id, u16 len,
+			    const u8 *data, u16 opts)
+{
+	u8 *data_buf;
+	u16 mask = BRCMF_XTLV_OPTION_IDU8 | BRCMF_XTLV_OPTION_LENU8;
+
+	if (!(opts & mask)) {
+		u8 *idp = (u8 *)xtlv;
+		u8 *lenp = idp + sizeof(xtlv->id);
+
+		put_unaligned_le16(id, idp);
+		put_unaligned_le16(len, lenp);
+		data_buf = lenp + sizeof(u16);
+	} else if ((opts & mask) == mask) { /* u8 id and u8 len */
+		u8 *idp = (u8 *)xtlv;
+		u8 *lenp = idp + 1;
+
+		*idp = (u8)id;
+		*lenp = (u8)len;
+		data_buf = lenp + sizeof(u8);
+	} else if (opts & BRCMF_XTLV_OPTION_IDU8) { /* u8 id, u16 len */
+		u8 *idp = (u8 *)xtlv;
+		u8 *lenp = idp + 1;
+
+		*idp = (u8)id;
+		put_unaligned_le16(len, lenp);
+		data_buf = lenp + sizeof(u16);
+	} else if (opts & BRCMF_XTLV_OPTION_LENU8) { /* u16 id, u8 len */
+		u8 *idp = (u8 *)xtlv;
+		u8 *lenp = idp + sizeof(u16);
+
+		put_unaligned_le16(id, idp);
+		*lenp = (u8)len;
+		data_buf = lenp + sizeof(u8);
+	} else {
+		WARN(true, "Unexpected xtlv option");
+		return;
+	}
+
+	if (opts & BRCMF_XTLV_OPTION_LENU8) {
+		WARN_ON(len > 0x00ff);
+		len &= 0xff;
+	}
+
+	if (data)
+		memcpy(data_buf, data, len);
+}
+
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/xtlv.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/xtlv.h
new file mode 100644
index 000000000000..e1930ce1b642
--- /dev/null
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/xtlv.h
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2019 Broadcom
+ */
+#ifndef __BRCMF_XTLV_H
+#define __BRCMF_XTLV_H
+
+#include <linux/types.h>
+#include <linux/bits.h>
+
+/* bcm type(id), length, value with w/16 bit id/len. The structure below
+ * is nominal, and is used to support variable length id and type. See
+ * xtlv options below.
+ */
+struct brcmf_xtlv {
+	u16 id;
+	u16 len;
+	u8 data[0];
+};
+
+enum brcmf_xtlv_option {
+	BRCMF_XTLV_OPTION_ALIGN32 = BIT(0),
+	BRCMF_XTLV_OPTION_IDU8 = BIT(1),
+	BRCMF_XTLV_OPTION_LENU8 = BIT(2),
+};
+
+int brcmf_xtlv_data_size(int dlen, u16 opts);
+void brcmf_xtlv_pack_header(struct brcmf_xtlv *xtlv, u16 id, u16 len,
+			    const u8 *data, u16 opts);
+
+#endif /* __BRCMF_XTLV_H */
-- 
2.27.0

