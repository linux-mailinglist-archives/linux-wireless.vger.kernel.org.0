Return-Path: <linux-wireless+bounces-30781-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF8CD1B449
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 21:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79199306BFB0
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 20:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4452BCF6C;
	Tue, 13 Jan 2026 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="VA8P9ZAe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16D0276051
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 20:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336825; cv=none; b=pi5z9m8/lVExadeFjkbc59U8P8mpRX8J1YQp9d7pmhlUXtPVgJISGXhRxpX7N6emqdeqe6CKx8/lvN4HnnV+svsuffLHopm+mm51T9eLIhHWF9nLp4g3UE+aq2cbUueYUJblXgyzFxMEdZWK1TGALpZzVCLvTo69jwub18kyPFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336825; c=relaxed/simple;
	bh=7c72xvFyVy2a3TJIwXmPzyjsK2hQfMOlPts7vrQSyR8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXa82WboDxVhjvtpIquPj2jOCm6frY4B2CSrLAAxobkFCSHFdIVb93qQ1eQC6JxQVGu7DwkcL5AlMBtqAbxhoch1p7u/48F6qQ6F5QbGacesmMSu5niK5SrYUu86j23EcuGvOkKVeyevsmcaB2bFQlM6Dphj3e93puIRx9M6WGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=VA8P9ZAe; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1768336823; x=1799872823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7c72xvFyVy2a3TJIwXmPzyjsK2hQfMOlPts7vrQSyR8=;
  b=VA8P9ZAePwFBJCoe8qvHbF5EehABzu3RfQAKcjw/H7cKqnnpYiaVoyy1
   xkfGTtW63y+3p1ej7D1ywN8dG8x4JLgmPno1h/2pZgcZDEyjlrEwZ+QET
   SAxkWLE2cNCIkyqUBpVrXfNolSKVwV2dBglhBvHfoQKBekU+mua6J3tYG
   4=;
X-CSE-ConnectionGUID: 4zBlRBWYQEWPaxUBCI4iVQ==
X-CSE-MsgGUID: fuQDAlW/RZKIbofY1Z5XPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="78107292"
X-IronPort-AV: E=Sophos;i="6.21,222,1763420400"; 
   d="scan'208";a="78107292"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 21:40:21 +0100
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 13 Jan
 2026 21:40:20 +0100
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 13 Jan 2026 21:40:18 +0100
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, <marex@nabladev.com>,
	<wlan-kernel-dev-list@infineon.com>, <gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next v2 26/34] wifi: inffmac: add ie.c/h
Date: Wed, 14 Jan 2026 02:03:39 +0530
Message-ID: <20260113203350.16734-27-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113203350.16734-1-gokulkumar.sivakumar@infineon.com>
References: <20260113203350.16734-1-gokulkumar.sivakumar@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE813.infineon.com (172.23.29.39) To
 MUCSE827.infineon.com (172.23.29.20)

Driver imeplementation to configure, handle and parse Information elements
of the Wi-Fi frames.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/infineon/inffmac/ie.c | 789 +++++++++++++++++++++
 drivers/net/wireless/infineon/inffmac/ie.h | 203 ++++++
 2 files changed, 992 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/ie.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/ie.h

diff --git a/drivers/net/wireless/infineon/inffmac/ie.c b/drivers/net/wireless/infineon/inffmac/ie.c
new file mode 100644
index 000000000000..97b6b002a14e
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/ie.c
@@ -0,0 +1,789 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2010 Broadcom Corporation
+ *
+ * Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include <linux/kernel.h>
+#include <linux/etherdevice.h>
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+#include <linux/string.h>
+#include <net/cfg80211.h>
+#include <net/netlink.h>
+
+#include "main.h"
+#include "utils.h"
+#include "chan.h"
+#include "debug.h"
+#include "dev_cmd.h"
+#include "p2p.h"
+#include "fwsignal.h"
+#include "cfg80211.h"
+#include "interface.h"
+#include "feature.h"
+#include "dev_cmd.h"
+#include "vendor.h"
+#include "he.h"
+#include "pmsr.h"
+#include "security.h"
+
+void inff_clear_assoc_req_ie(struct inff_cfg80211_info *cfg)
+{
+	struct inff_cfg80211_connect_info *conn_info = &cfg->conn_info;
+
+	kfree(conn_info->req_ie);
+	conn_info->req_ie = NULL;
+	conn_info->req_ie_len = 0;
+}
+
+void inff_clear_assoc_resp_ie(struct inff_cfg80211_info *cfg)
+{
+	struct inff_cfg80211_connect_info *conn_info = &cfg->conn_info;
+
+	kfree(conn_info->resp_ie);
+	conn_info->resp_ie = NULL;
+	conn_info->resp_ie_len = 0;
+}
+
+/* Traverse a string of 1-byte tag/1-byte length/variable-length value
+ * triples, returning a pointer to the substring whose first element
+ * matches tag
+ */
+const struct inff_tlv *
+inff_parse_tlvs(const void *buf, int buflen, uint key)
+{
+	const struct inff_tlv *elt = buf;
+	int totlen = buflen;
+
+	/* find tagged parameter */
+	while (totlen >= TLV_HDR_LEN) {
+		int len = elt->len;
+
+		/* validate remaining totlen */
+		if (elt->id == key && (totlen >= (len + TLV_HDR_LEN)))
+			return elt;
+
+		elt = (struct inff_tlv *)((u8 *)elt + (len + TLV_HDR_LEN));
+		totlen -= (len + TLV_HDR_LEN);
+	}
+
+	return NULL;
+}
+
+/* Is any of the tlvs the expected entry? If
+ * not update the tlvs buffer pointer/length.
+ */
+bool
+inff_tlv_has_ie(const u8 *ie, const u8 **tlvs, u32 *tlvs_len,
+		const u8 *oui, u32 oui_len, u8 type)
+{
+	/* If the contents match the OUI and the type */
+	if (ie[TLV_LEN_OFF] >= oui_len + 1 &&
+	    !memcmp(&ie[TLV_BODY_OFF], oui, oui_len) &&
+	    type == ie[TLV_BODY_OFF + oui_len]) {
+		return true;
+	}
+
+	if (!tlvs)
+		return false;
+	/* point to the next ie */
+	ie += ie[TLV_LEN_OFF] + TLV_HDR_LEN;
+	/* calculate the length of the rest of the buffer */
+	*tlvs_len -= (int)(ie - *tlvs);
+	/* update the pointer to the start of the buffer */
+	*tlvs = ie;
+
+	return false;
+}
+
+struct inff_vs_tlv *
+inff_find_wpaie(const u8 *parse, u32 len)
+{
+	const struct inff_tlv *ie;
+
+	while ((ie = inff_parse_tlvs(parse, len, WLAN_EID_VENDOR_SPECIFIC))) {
+		if (inff_tlv_has_ie((const u8 *)ie, &parse, &len,
+				    WPA_OUI, TLV_OUI_LEN, WPA_OUI_TYPE))
+			return (struct inff_vs_tlv *)ie;
+	}
+	return NULL;
+}
+
+struct inff_vs_tlv *
+inff_find_wpsie(const u8 *parse, u32 len)
+{
+	const struct inff_tlv *ie;
+
+	while ((ie = inff_parse_tlvs(parse, len, WLAN_EID_VENDOR_SPECIFIC))) {
+		if (inff_tlv_has_ie((u8 *)ie, &parse, &len,
+				    WPA_OUI, TLV_OUI_LEN, WPS_OUI_TYPE))
+			return (struct inff_vs_tlv *)ie;
+	}
+	return NULL;
+}
+
+struct inff_tlv *
+inff_find_iwie(const u8 *parse, u32 len)
+{
+	const struct inff_tlv *ie = NULL;
+
+	/* unfortunately it's too much work to dispose the const cast - inff_parse_tlvs
+	 * is used everywhere and changing its prototype to take const qualifier needs
+	 * a massive change to all its callers...
+	 */
+
+	ie = inff_parse_tlvs(parse, len, WLAN_EID_INTERWORKING);
+	if (ie)
+		return (struct inff_tlv *)ie;
+	return NULL;
+}
+
+s32
+inff_clear_iwie(struct inff_cfg80211_info *cfg, struct inff_if *ifp)
+{
+	struct ie_set_buffer ie_setbuf = {0};
+
+	inff_dbg(TRACE, "clear interworking IE\n");
+
+	memset(&ie_setbuf, 0, sizeof(struct ie_set_buffer));
+
+	ie_setbuf.ie_buffer.iecount = cpu_to_le32(1);
+	ie_setbuf.ie_buffer.ie_list[0].ie_data.id = WLAN_EID_INTERWORKING;
+	ie_setbuf.ie_buffer.ie_list[0].ie_data.len = 0;
+
+	return inff_fwcmd_iovar_data_set(ifp, "ie", &ie_setbuf, sizeof(ie_setbuf));
+}
+
+s32
+inff_add_iwie(struct inff_cfg80211_info *cfg, struct inff_if *ifp, s32 pktflag,
+	      u8 ie_id, u8 *data, u8 data_len)
+{
+	int err = 0;
+	u32 buf_len;
+	struct ie_set_buffer *ie_setbuf;
+
+	if (ie_id != WLAN_EID_INTERWORKING) {
+		inff_err("unsupported (id=%d)\n", ie_id);
+		return -EINVAL;
+	}
+
+	/* access network options (1 octet)  is the mandatory field */
+	if (!data || data_len == 0 || data_len > INFF_IW_IES_MAX_BUF_LEN) {
+		inff_err("wrong interworking IE (len=%d)\n", data_len);
+		return -EINVAL;
+	}
+
+	/* Validate the pktflag parameter */
+	if (pktflag & ~(INFF_VNDR_IE_CUSTOM_FLAG)) {
+		inff_err("invalid packet flag 0x%x\n", pktflag);
+		return -EINVAL;
+	}
+
+	buf_len = sizeof(struct ie_set_buffer) + data_len - 1;
+
+	/* if already set with previous values, delete it first */
+	err = inff_clear_iwie(cfg, ifp);
+	if (err)
+		return err;
+
+	ie_setbuf = kmalloc(buf_len, GFP_KERNEL);
+	if (!ie_setbuf)
+		return -ENOMEM;
+
+	strscpy(ie_setbuf->cmd, "add", sizeof(ie_setbuf->cmd));
+
+	/* Buffer contains only 1 IE */
+	ie_setbuf->ie_buffer.iecount = cpu_to_le32(1);
+	/* use VNDR_IE_CUSTOM_FLAG flags for none vendor IE . currently fixed value */
+	ie_setbuf->ie_buffer.ie_list[0].pktflag = cpu_to_le32(pktflag);
+
+	/* Now, add the IE to the buffer */
+	ie_setbuf->ie_buffer.ie_list[0].ie_data.id = WLAN_EID_INTERWORKING;
+	ie_setbuf->ie_buffer.ie_list[0].ie_data.len = data_len;
+	/* Returning void here as max data_len can be 8 */
+	(void)memcpy((u8 *)&ie_setbuf->ie_buffer.ie_list[0].ie_data.data[0],
+			data, data_len);
+
+	err = inff_fwcmd_iovar_data_set(ifp, "ie", ie_setbuf, buf_len);
+	if (err)
+		inff_err("Failed to add interworking IE\n");
+
+	kfree(ie_setbuf);
+
+	return err;
+}
+
+bool inff_valid_wpa_oui(u8 *oui, bool is_rsn_ie)
+{
+	if (is_rsn_ie)
+		return (memcmp(oui, RSN_OUI, TLV_OUI_LEN) == 0);
+
+	return (memcmp(oui, WPA_OUI, TLV_OUI_LEN) == 0);
+}
+
+bool inff_valid_dpp_suite(u8 *oui)
+{
+	return (memcmp(oui, WFA_OUI, TLV_OUI_LEN) == 0 &&
+		*(oui + TLV_OUI_LEN) == DPP_AKM_SUITE_TYPE);
+}
+
+s32
+inff_parse_vndr_ies(const u8 *vndr_ie_buf, u32 vndr_ie_len,
+		    struct parsed_vndr_ies *vndr_ies)
+{
+	struct inff_vs_tlv *vndrie;
+	struct inff_tlv *ie;
+	struct parsed_vndr_ie_info *parsed_info;
+	s32 remaining_len;
+
+	remaining_len = (s32)vndr_ie_len;
+	memset(vndr_ies, 0, sizeof(*vndr_ies));
+
+	ie = (struct inff_tlv *)vndr_ie_buf;
+	while (ie) {
+		if (ie->id != WLAN_EID_VENDOR_SPECIFIC)
+			goto next;
+		vndrie = (struct inff_vs_tlv *)ie;
+		/* len should be bigger than OUI length + one */
+		if (vndrie->len < (VS_IE_FIXED_HDR_LEN - TLV_HDR_LEN + 1)) {
+			inff_err("invalid vndr ie. length is too small %d\n",
+				 vndrie->len);
+			goto next;
+		}
+		/* if wpa or wme ie, do not add ie */
+		if (!memcmp(vndrie->oui, (u8 *)WPA_OUI, TLV_OUI_LEN) &&
+		    (vndrie->oui_type == WPA_OUI_TYPE ||
+		    vndrie->oui_type == WME_OUI_TYPE)) {
+			inff_dbg(TRACE, "Found WPA/WME oui. Do not add it\n");
+			goto next;
+		}
+
+		parsed_info = &vndr_ies->ie_info[vndr_ies->count];
+
+		/* save vndr ie information */
+		parsed_info->ie_ptr = (char *)vndrie;
+		parsed_info->ie_len = vndrie->len + TLV_HDR_LEN;
+		memcpy(&parsed_info->vndrie, vndrie, sizeof(*vndrie));
+
+		vndr_ies->count++;
+
+		inff_dbg(TRACE, "** OUI %3ph, type 0x%02x\n",
+			 parsed_info->vndrie.oui,
+			 parsed_info->vndrie.oui_type);
+
+		if (vndr_ies->count >= VNDR_IE_PARSE_LIMIT)
+			break;
+next:
+		remaining_len -= (ie->len + TLV_HDR_LEN);
+		if (remaining_len <= TLV_HDR_LEN)
+			ie = NULL;
+		else
+			ie = (struct inff_tlv *)(((u8 *)ie) + ie->len +
+				TLV_HDR_LEN);
+	}
+	return 0;
+}
+
+u32
+inff_vndr_ie(u8 *iebuf, s32 pktflag, u8 *ie_ptr, u32 ie_len, s8 *add_del_cmd)
+{
+	strscpy(iebuf, add_del_cmd, VNDR_IE_CMD_LEN);
+
+	put_unaligned_le32(1, &iebuf[VNDR_IE_COUNT_OFFSET]);
+
+	put_unaligned_le32(pktflag, &iebuf[VNDR_IE_PKTFLAG_OFFSET]);
+
+	memcpy(&iebuf[VNDR_IE_VSIE_OFFSET], ie_ptr, ie_len);
+
+	return ie_len + VNDR_IE_HDR_SIZE;
+}
+
+s32
+inff_parse_extension_ies(const u8 *extension_ie_buf, u32 extension_ie_len,
+			 struct parsed_extension_ies *extension_ies)
+{
+	struct inff_ext_tlv *ext_ie;
+	struct inff_tlv *ie;
+	struct parsed_ext_ie_info *parsed_info;
+	s32 remaining_len;
+
+	remaining_len = (s32)extension_ie_len;
+	memset(extension_ies, 0, sizeof(*extension_ies));
+
+	ie = (struct inff_tlv *)extension_ie_buf;
+	while (ie) {
+		if (ie->id != WLAN_EID_EXTENSION)
+			goto next;
+		ext_ie = (struct inff_ext_tlv *)ie;
+
+		/* len should be bigger than ext_id + one data */
+		if (ext_ie->len < 2) {
+			inff_err("invalid ext_ie ie. length is too small %d\n",
+				 ext_ie->len);
+			goto next;
+		}
+
+		/* skip parsing the HE capab, HE_6G_capa & oper IE from upper layer
+		 * to avoid sending it to the FW, as these IEs will be
+		 * added by the FW based on the MAC & PHY capab if HE
+		 * is enabled.
+		 */
+		if (ext_ie->ext_id == WLAN_EID_EXT_HE_CAPABILITY ||
+		    ext_ie->ext_id == WLAN_EID_EXT_HE_OPERATION ||
+		    ext_ie->ext_id == WLAN_EID_EXT_HE_6GHZ_CAPA)
+			goto next;
+
+		parsed_info = &extension_ies->ie_info[extension_ies->count];
+
+		parsed_info->ie_ptr = (char *)ext_ie;
+		parsed_info->ie_len = ext_ie->len + TLV_HDR_LEN;
+		memcpy(&parsed_info->ie_data, ext_ie, sizeof(*ext_ie));
+
+		extension_ies->count++;
+
+		inff_dbg(TRACE, "** EXT_IE %d, len 0x%02x EXT_ID: %d\n",
+			 parsed_info->ie_data.id,
+			 parsed_info->ie_data.len,
+			 parsed_info->ie_data.ext_id);
+
+		/* temperory parsing at most 5 EXT_ID, will review it.*/
+		if (extension_ies->count >= VNDR_IE_PARSE_LIMIT)
+			break;
+next:
+		remaining_len -= (ie->len + TLV_HDR_LEN);
+		if (remaining_len <= TLV_HDR_LEN)
+			ie = NULL;
+		else
+			ie = (struct inff_tlv *)(((u8 *)ie) + ie->len +
+				TLV_HDR_LEN);
+	}
+	return 0;
+}
+
+s32 inff_get_assoc_ies(struct inff_cfg80211_info *cfg, struct inff_if *ifp)
+{
+	struct inff_pub *drvr = cfg->pub;
+	struct inff_cfg80211_assoc_ielen_le *assoc_info;
+	struct inff_cfg80211_connect_info *conn_info = &cfg->conn_info;
+	struct inff_cfg80211_edcf_acparam edcf_acparam_info[EDCF_AC_COUNT];
+	u32 req_len;
+	u32 resp_len;
+	u32 flags;
+	s32 err = 0;
+
+	inff_dbg(CONN, "req: %p, req len (%d) resp: %p resp len (%d)\n", conn_info->req_ie,
+		 conn_info->req_ie_len, conn_info->resp_ie, conn_info->resp_ie_len);
+
+	if (conn_info->req_ie_len && conn_info->resp_ie_len &&
+	    conn_info->req_ie && conn_info->resp_ie)
+		return 0;
+
+	inff_clear_assoc_ies(cfg);
+
+	memset(cfg->extra_buf, '\0', WL_EXTRA_BUF_MAX);
+	err = inff_fwcmd_iovar_data_get(ifp, "assoc_info",
+					cfg->extra_buf, WL_ASSOC_INFO_MAX);
+	if (err) {
+		iphy_err(drvr, "could not get assoc info (%d)\n", err);
+		return err;
+	}
+	assoc_info =
+		(struct inff_cfg80211_assoc_ielen_le *)cfg->extra_buf;
+	req_len = le32_to_cpu(assoc_info->req_len);
+	resp_len = le32_to_cpu(assoc_info->resp_len);
+	flags = le32_to_cpu(assoc_info->flags);
+	if (req_len > WL_EXTRA_BUF_MAX || resp_len > WL_EXTRA_BUF_MAX) {
+		iphy_err(drvr, "invalid lengths in assoc info: req %u resp %u\n",
+			 req_len, resp_len);
+		return -EINVAL;
+	}
+	if (req_len) {
+		memset(cfg->extra_buf, '\0', WL_EXTRA_BUF_MAX);
+		err = inff_fwcmd_iovar_data_get(ifp, "assoc_req_ies",
+						cfg->extra_buf,
+						WL_ASSOC_INFO_MAX);
+		if (err) {
+			iphy_err(drvr, "could not get assoc req (%d)\n", err);
+			return err;
+		}
+
+		if (flags & INFF_ASSOC_REQ_IS_REASSOC)
+			conn_info->req_ie_len = req_len - sizeof(struct dot11_reassoc_req);
+		else
+			conn_info->req_ie_len = req_len - sizeof(struct dot11_assoc_req);
+
+		conn_info->req_ie =
+		    kmemdup(cfg->extra_buf, conn_info->req_ie_len,
+			    GFP_KERNEL);
+		if (!conn_info->req_ie)
+			conn_info->req_ie_len = 0;
+	} else {
+		conn_info->req_ie_len = 0;
+		conn_info->req_ie = NULL;
+	}
+
+	/* resp_len is the total length of assoc resp
+	 * which includes 6 bytes of aid/status code/capabilities.
+	 * the assoc_resp_ie length should minus the 6 bytes which starts from rate_ie.
+	 */
+	if (resp_len) {
+		memset(cfg->extra_buf, '\0', WL_EXTRA_BUF_MAX);
+		err = inff_fwcmd_iovar_data_get(ifp, "assoc_resp_ies",
+						cfg->extra_buf,
+					      WL_ASSOC_INFO_MAX);
+		if (err) {
+			iphy_err(drvr, "could not get assoc resp (%d)\n", err);
+			return err;
+		}
+		conn_info->resp_ie_len = resp_len - sizeof(struct dot11_assoc_resp);
+		conn_info->resp_ie =
+		    kmemdup(cfg->extra_buf, conn_info->resp_ie_len,
+			    GFP_KERNEL);
+		if (!conn_info->resp_ie)
+			conn_info->resp_ie_len = 0;
+
+		err = inff_fwcmd_iovar_data_get(ifp, "wme_ac_sta",
+						edcf_acparam_info,
+						sizeof(edcf_acparam_info));
+		if (err) {
+			inff_err("could not get wme_ac_sta (%d)\n", err);
+			return err;
+		}
+
+		inff_wifi_prioritize_acparams(edcf_acparam_info,
+					      cfg->ac_priority);
+	} else {
+		conn_info->resp_ie_len = 0;
+		conn_info->resp_ie = NULL;
+	}
+	inff_dbg(CONN, "req len (%d) resp len (%d)\n",
+		 conn_info->req_ie_len, conn_info->resp_ie_len);
+
+	return err;
+}
+
+void inff_clear_assoc_ies(struct inff_cfg80211_info *cfg)
+{
+	struct inff_cfg80211_connect_info *conn_info = &cfg->conn_info;
+
+	kfree(conn_info->req_ie);
+	conn_info->req_ie = NULL;
+	conn_info->req_ie_len = 0;
+	kfree(conn_info->resp_ie);
+	conn_info->resp_ie = NULL;
+	conn_info->resp_ie_len = 0;
+}
+
+s32
+inff_config_ap_mgmt_ie(struct inff_cfg80211_vif *vif,
+		       struct cfg80211_beacon_data *beacon)
+{
+	struct inff_pub *drvr = vif->ifp->drvr;
+	s32 err;
+
+	/* Set Beacon IEs to FW */
+	err = inff_vif_set_mgmt_ie(vif, INFF_VNDR_IE_BEACON_FLAG,
+				   beacon->tail, beacon->tail_len);
+	if (err) {
+		iphy_err(drvr, "Set Beacon IE Failed\n");
+		return err;
+	}
+	inff_dbg(TRACE, "Applied Vndr IEs for Beacon\n");
+
+	/* Set Probe Response IEs to FW */
+	err = inff_vif_set_mgmt_ie(vif, INFF_VNDR_IE_PRBRSP_FLAG,
+				   beacon->proberesp_ies,
+				   beacon->proberesp_ies_len);
+	if (err)
+		iphy_err(drvr, "Set Probe Resp IE Failed\n");
+	else
+		inff_dbg(TRACE, "Applied Vndr IEs for Probe Resp\n");
+
+	/* Set Assoc Response IEs to FW */
+	err = inff_vif_set_mgmt_ie(vif, INFF_VNDR_IE_ASSOCRSP_FLAG,
+				   beacon->assocresp_ies,
+				   beacon->assocresp_ies_len);
+	if (err)
+		inff_err("Set Assoc Resp IE Failed\n");
+	else
+		inff_dbg(TRACE, "Applied Vndr IEs for Assoc Resp\n");
+
+	return err;
+}
+
+s32 inff_vif_set_mgmt_ie(struct inff_cfg80211_vif *vif, s32 pktflag,
+			 const u8 *vndr_ie_buf, u32 vndr_ie_len)
+{
+	struct inff_pub *drvr;
+	struct inff_if *ifp;
+	struct inff_vif_saved_ie *saved_ie;
+	s32 err = 0;
+	u8  *iovar_ie_buf;
+	u8  *curr_ie_buf;
+	u8  *mgmt_ie_buf = NULL;
+	int mgmt_ie_buf_len;
+	u32 *mgmt_ie_len;
+	u32 del_add_ie_buf_len = 0;
+	u32 total_ie_buf_len = 0;
+	u32 parsed_ie_buf_len = 0;
+	struct parsed_vndr_ies old_vndr_ies;
+	struct parsed_vndr_ies new_vndr_ies;
+	struct parsed_vndr_ie_info *vndrie_info;
+	s32 i;
+	u8 *ptr;
+	int remained_buf_len;
+	struct parsed_extension_ies new_ext_ies;
+	struct parsed_extension_ies old_ext_ies;
+	struct parsed_ext_ie_info *extie_info;
+
+	if (!vif)
+		return -ENODEV;
+	ifp = vif->ifp;
+	drvr = ifp->drvr;
+	saved_ie = &vif->saved_ie;
+
+	inff_dbg(TRACE, "bsscfgidx %d, pktflag : 0x%02X\n", ifp->bsscfgidx,
+		 pktflag);
+	iovar_ie_buf = kzalloc(WL_EXTRA_BUF_MAX, GFP_KERNEL);
+	if (!iovar_ie_buf)
+		return -ENOMEM;
+	curr_ie_buf = iovar_ie_buf;
+	switch (pktflag) {
+	case INFF_VNDR_IE_PRBREQ_FLAG:
+		mgmt_ie_buf = saved_ie->probe_req_ie;
+		mgmt_ie_len = &saved_ie->probe_req_ie_len;
+		mgmt_ie_buf_len = sizeof(saved_ie->probe_req_ie);
+		break;
+	case INFF_VNDR_IE_PRBRSP_FLAG:
+		mgmt_ie_buf = saved_ie->probe_res_ie;
+		mgmt_ie_len = &saved_ie->probe_res_ie_len;
+		mgmt_ie_buf_len = sizeof(saved_ie->probe_res_ie);
+		break;
+	case INFF_VNDR_IE_BEACON_FLAG:
+		mgmt_ie_buf = saved_ie->beacon_ie;
+		mgmt_ie_len = &saved_ie->beacon_ie_len;
+		mgmt_ie_buf_len = sizeof(saved_ie->beacon_ie);
+		break;
+	case INFF_VNDR_IE_ASSOCREQ_FLAG:
+		mgmt_ie_buf = saved_ie->assoc_req_ie;
+		mgmt_ie_len = &saved_ie->assoc_req_ie_len;
+		mgmt_ie_buf_len = sizeof(saved_ie->assoc_req_ie);
+		break;
+	case INFF_VNDR_IE_ASSOCRSP_FLAG:
+		mgmt_ie_buf = saved_ie->assoc_res_ie;
+		mgmt_ie_len = &saved_ie->assoc_res_ie_len;
+		mgmt_ie_buf_len = sizeof(saved_ie->assoc_res_ie);
+		break;
+	default:
+		err = -EPERM;
+		iphy_err(drvr, "not suitable type\n");
+		goto exit;
+	}
+
+	if (vndr_ie_len > mgmt_ie_buf_len) {
+		err = -ENOMEM;
+		iphy_err(drvr, "extra IE size too big\n");
+		goto exit;
+	}
+
+	/* parse and save new vndr_ie in curr_ie_buff before comparing it */
+	if (vndr_ie_buf && vndr_ie_len && curr_ie_buf) {
+		ptr = curr_ie_buf;
+		inff_parse_vndr_ies(vndr_ie_buf, vndr_ie_len, &new_vndr_ies);
+		for (i = 0; i < new_vndr_ies.count; i++) {
+			vndrie_info = &new_vndr_ies.ie_info[i];
+			memcpy(ptr + parsed_ie_buf_len, vndrie_info->ie_ptr,
+			       vndrie_info->ie_len);
+			parsed_ie_buf_len += vndrie_info->ie_len;
+		}
+		inff_parse_extension_ies(vndr_ie_buf, vndr_ie_len, &new_ext_ies);
+		for (i = 0; i < new_ext_ies.count; i++) {
+			extie_info = &new_ext_ies.ie_info[i];
+			memcpy(ptr + parsed_ie_buf_len, extie_info->ie_ptr,
+			       extie_info->ie_len);
+			parsed_ie_buf_len += extie_info->ie_len;
+		}
+	}
+
+	if (mgmt_ie_buf && *mgmt_ie_len) {
+		if (parsed_ie_buf_len && parsed_ie_buf_len == *mgmt_ie_len &&
+		    (memcmp(mgmt_ie_buf, curr_ie_buf,
+			    parsed_ie_buf_len) == 0)) {
+			inff_dbg(TRACE, "Previous mgmt IE equals to current IE\n");
+			goto exit;
+		}
+
+		/* parse old vndr_ie */
+		inff_parse_vndr_ies(mgmt_ie_buf, *mgmt_ie_len, &old_vndr_ies);
+		/* parse old ext_ie */
+		inff_parse_extension_ies(mgmt_ie_buf, *mgmt_ie_len, &old_ext_ies);
+
+		/* make a command to delete old ie */
+		for (i = 0; i < old_vndr_ies.count; i++) {
+			vndrie_info = &old_vndr_ies.ie_info[i];
+
+			inff_dbg(TRACE, "DEL ID : %d, Len: %d , OUI:%3ph\n",
+				 vndrie_info->vndrie.id,
+				 vndrie_info->vndrie.len,
+				 vndrie_info->vndrie.oui);
+
+			del_add_ie_buf_len = inff_vndr_ie(curr_ie_buf, pktflag,
+							  vndrie_info->ie_ptr,
+							  vndrie_info->ie_len,
+							  "del");
+			curr_ie_buf += del_add_ie_buf_len;
+			total_ie_buf_len += del_add_ie_buf_len;
+		}
+		/* make a command to delete old extension ie */
+		for (i = 0; i < old_ext_ies.count; i++) {
+			extie_info = &old_ext_ies.ie_info[i];
+
+			inff_dbg(TRACE, "DEL EXT_IE : %d, Len: %d , ext_id:%d\n",
+				 extie_info->ie_data.id,
+				 extie_info->ie_data.len,
+				 extie_info->ie_data.ext_id);
+
+			del_add_ie_buf_len = inff_vndr_ie(curr_ie_buf,
+							  pktflag | INFF_VNDR_IE_CUSTOM_FLAG,
+							  extie_info->ie_ptr,
+							  extie_info->ie_len,
+							  "del");
+			curr_ie_buf += del_add_ie_buf_len;
+			total_ie_buf_len += del_add_ie_buf_len;
+		}
+	}
+
+	*mgmt_ie_len = 0;
+	/* Add if there is any extra IE */
+	if (mgmt_ie_buf && parsed_ie_buf_len) {
+		ptr = mgmt_ie_buf;
+
+		remained_buf_len = mgmt_ie_buf_len;
+
+		/* make a command to add new ie */
+		for (i = 0; i < new_vndr_ies.count; i++) {
+			vndrie_info = &new_vndr_ies.ie_info[i];
+
+			/* verify remained buf size before copy data */
+			if (remained_buf_len < (vndrie_info->vndrie.len +
+							VNDR_IE_VSIE_OFFSET)) {
+				iphy_err(drvr, "no space in mgmt_ie_buf: len left %d",
+					 remained_buf_len);
+				break;
+			}
+			remained_buf_len -= (vndrie_info->ie_len +
+					     VNDR_IE_VSIE_OFFSET);
+
+			inff_dbg(TRACE, "ADDED ID : %d, Len: %d, OUI:%3ph\n",
+				 vndrie_info->vndrie.id,
+				 vndrie_info->vndrie.len,
+				 vndrie_info->vndrie.oui);
+
+			del_add_ie_buf_len = inff_vndr_ie(curr_ie_buf, pktflag,
+							  vndrie_info->ie_ptr,
+							  vndrie_info->ie_len,
+							  "add");
+
+			/* save the parsed IE in wl struct */
+			memcpy(ptr + (*mgmt_ie_len), vndrie_info->ie_ptr,
+			       vndrie_info->ie_len);
+			*mgmt_ie_len += vndrie_info->ie_len;
+
+			curr_ie_buf += del_add_ie_buf_len;
+			total_ie_buf_len += del_add_ie_buf_len;
+		}
+		/* make a command to add new EXT ie */
+		for (i = 0; i < new_ext_ies.count; i++) {
+			extie_info = &new_ext_ies.ie_info[i];
+
+			/* verify remained buf size before copy data */
+			if (remained_buf_len < (extie_info->ie_data.len +
+							VNDR_IE_VSIE_OFFSET)) {
+				iphy_err(drvr, "no space in mgmt_ie_buf: len left %d",
+					 remained_buf_len);
+				break;
+			}
+			remained_buf_len -= (extie_info->ie_len +
+					     VNDR_IE_VSIE_OFFSET);
+
+			inff_dbg(TRACE, "ADDED EXT ID : %d, Len: %d, OUI:%d\n",
+				 extie_info->ie_data.id,
+				 extie_info->ie_data.len,
+				 extie_info->ie_data.ext_id);
+
+			del_add_ie_buf_len = inff_vndr_ie(curr_ie_buf,
+							  pktflag | INFF_VNDR_IE_CUSTOM_FLAG,
+							  extie_info->ie_ptr,
+							  extie_info->ie_len,
+							  "add");
+
+			/* save the parsed IE in wl struct */
+			memcpy(ptr + (*mgmt_ie_len), extie_info->ie_ptr,
+			       extie_info->ie_len);
+			*mgmt_ie_len += extie_info->ie_len;
+
+			curr_ie_buf += del_add_ie_buf_len;
+			total_ie_buf_len += del_add_ie_buf_len;
+		}
+	}
+	if (total_ie_buf_len) {
+		err  = inff_fwcmd_bsscfg_data_set(ifp, "vndr_ie", iovar_ie_buf,
+						  total_ie_buf_len);
+		if (err)
+			iphy_err(drvr, "vndr ie set error : %d\n", err);
+	}
+
+exit:
+	kfree(iovar_ie_buf);
+	return err;
+}
+
+s32 inff_vif_clear_mgmt_ies(struct inff_cfg80211_vif *vif)
+{
+	static const s32 pktflags[] = {
+		INFF_VNDR_IE_PRBRSP_FLAG,
+		INFF_VNDR_IE_BEACON_FLAG,
+		INFF_VNDR_IE_ASSOCRSP_FLAG
+	};
+	int i;
+
+	if (vif->wdev.iftype == NL80211_IFTYPE_AP)
+		inff_vif_set_mgmt_ie(vif, INFF_VNDR_IE_ASSOCRSP_FLAG, NULL, 0);
+	else
+		inff_vif_set_mgmt_ie(vif, INFF_VNDR_IE_PRBREQ_FLAG, NULL, 0);
+
+	for (i = 0; i < ARRAY_SIZE(pktflags); i++)
+		inff_vif_set_mgmt_ie(vif, pktflags[i], NULL, 0);
+
+	memset(&vif->saved_ie, 0, sizeof(vif->saved_ie));
+	return 0;
+}
+
+/* Is any of the tlvs the expected entry? If
+ * not update the tlvs buffer pointer/length.
+ */
+bool
+wl_cfgoce_has_ie(const u8 *ie, const u8 **tlvs, u32 *tlvs_len,
+		 const u8 *oui, u32 oui_len, u8 type)
+{
+	/* If the contents match the OUI and the type */
+	if (ie[TLV_LEN_OFF] >= oui_len + 1 &&
+	    !memcmp(&ie[TLV_BODY_OFF], oui, oui_len) &&
+	    type == ie[TLV_BODY_OFF + oui_len]) {
+		return true;
+	}
+
+	if (!tlvs)
+		return false;
+	/* point to the next ie */
+	ie += ie[TLV_LEN_OFF] + TLV_HDR_LEN;
+	/* calculate the length of the rest of the buffer */
+	*tlvs_len -= (int)(ie - *tlvs);
+	/* update the pointer to the start of the buffer */
+	*tlvs = ie;
+
+	return false;
+}
diff --git a/drivers/net/wireless/infineon/inffmac/ie.h b/drivers/net/wireless/infineon/inffmac/ie.h
new file mode 100644
index 000000000000..c6259cb1b7af
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/ie.h
@@ -0,0 +1,203 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2010 Broadcom Corporation
+ *
+ * Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_IE_H
+#define INFF_IE_H
+
+#define	DOT11_MGMT_HDR_LEN		24	/* d11 management header len */
+#define	DOT11_BCN_PRB_FIXED_LEN		12	/* beacon/probe fixed length */
+
+#define WPA_OUI				"\x00\x50\xF2"	/* WPA OUI */
+#define WPA_OUI_TYPE			1
+#define RSN_OUI				"\x00\x0F\xAC"	/* RSN OUI */
+#define	WME_OUI_TYPE			2
+#define WPS_OUI_TYPE			4
+#define WFA_OUI_TYPE_MBO_OCE		0x16
+
+#define VS_IE_FIXED_HDR_LEN		6
+#define WPA_IE_VERSION_LEN		2
+#define WPA_IE_MIN_OUI_LEN		4
+#define WPA_IE_SUITE_COUNT_LEN		2
+
+#define VNDR_IE_CMD_LEN			4	/* length of the set command
+						 * string :"add", "del" (+ NUL)
+						 */
+#define VNDR_IE_COUNT_OFFSET		4
+#define VNDR_IE_PKTFLAG_OFFSET		8
+#define VNDR_IE_VSIE_OFFSET		12
+#define VNDR_IE_HDR_SIZE		12
+#define VNDR_IE_PARSE_LIMIT		5
+
+#define IE_MAX_LEN			512
+
+/* IE TLV processing */
+#define TLV_LEN_OFF			1	/* length offset */
+#define TLV_HDR_LEN			2	/* header length */
+#define TLV_BODY_OFF			2	/* body offset */
+#define TLV_OUI_LEN			3	/* oui id length */
+
+/* 802.11 Mgmt Packet flags */
+#define INFF_VNDR_IE_BEACON_FLAG	0x1
+#define INFF_VNDR_IE_PRBRSP_FLAG	0x2
+#define INFF_VNDR_IE_ASSOCRSP_FLAG	0x4
+#define INFF_VNDR_IE_AUTHRSP_FLAG	0x8
+#define INFF_VNDR_IE_PRBREQ_FLAG	0x10
+#define INFF_VNDR_IE_ASSOCREQ_FLAG	0x20
+/* vendor IE in IW advertisement protocol ID field */
+#define INFF_VNDR_IE_IWAPID_FLAG	0x40
+/* allow custom IE id */
+#define INFF_VNDR_IE_CUSTOM_FLAG	0x100
+
+/* P2P Action Frames flags (spec ordered) */
+#define INFF_VNDR_IE_GONREQ_FLAG     0x001000
+#define INFF_VNDR_IE_GONRSP_FLAG     0x002000
+#define INFF_VNDR_IE_GONCFM_FLAG     0x004000
+#define INFF_VNDR_IE_INVREQ_FLAG     0x008000
+#define INFF_VNDR_IE_INVRSP_FLAG     0x010000
+#define INFF_VNDR_IE_DISREQ_FLAG     0x020000
+#define INFF_VNDR_IE_DISRSP_FLAG     0x040000
+#define INFF_VNDR_IE_PRDREQ_FLAG     0x080000
+#define INFF_VNDR_IE_PRDRSP_FLAG     0x100000
+
+#define INFF_VNDR_IE_P2PAF_SHIFT	12
+
+/* flags */
+#define INFF_ASSOC_REQ_IS_REASSOC 0x01 /* assoc req was actually a reassoc */
+
+/* Max length of Interworking element */
+#define INFF_IW_IES_MAX_BUF_LEN	8
+
+struct dot11_assoc_req {
+	u16 capability;		/* capability information */
+	u16 listen;		/* listen interval */
+};
+
+struct dot11_reassoc_req {
+	u16 capability;		/* capability information */
+	u16 listen;		/* listen interval */
+	u8 ap[ETH_ALEN];	/* Current AP address */
+};
+
+struct dot11_assoc_resp {
+	u16 capability;		/* capability information */
+	u16 status;		/* status code */
+	u16 aid;		/* association ID */
+};
+
+/**
+ * struct inff_tlv - tag_ID/length/value_buffer tuple.
+ *
+ * @id: tag identifier.
+ * @len: number of bytes in value buffer.
+ * @data: value buffer.
+ */
+struct inff_tlv {
+	u8 id;
+	u8 len;
+	u8 data[];
+};
+
+/* Vendor specific ie. id = 221, oui and type defines exact ie */
+struct inff_vs_tlv {
+	u8 id;
+	u8 len;
+	u8 oui[3];
+	u8 oui_type;
+};
+
+struct parsed_vndr_ie_info {
+	u8 *ie_ptr;
+	u32 ie_len;	/* total length including id & length field */
+	struct inff_vs_tlv vndrie;
+};
+
+struct parsed_vndr_ies {
+	u32 count;
+	struct parsed_vndr_ie_info ie_info[VNDR_IE_PARSE_LIMIT];
+};
+
+struct inff_ext_tlv {
+	u8 id;
+	u8 len;
+	u8 ext_id;
+};
+
+struct parsed_ext_ie_info {
+	u8 *ie_ptr;
+	u32 ie_len;	/* total length including id & length field */
+	struct inff_ext_tlv ie_data;
+};
+
+struct parsed_extension_ies {
+	u32 count;
+	struct parsed_ext_ie_info ie_info[VNDR_IE_PARSE_LIMIT];
+};
+
+struct ie_info {
+	__le32 pktflag;			/* bitmask indicating which packet(s) contain this IE */
+	struct inff_tlv ie_data;	/* IE data */
+} __packed;
+
+struct ie_buf {
+	__le32 iecount;			/* number of entries in the ie_list[] array */
+	struct ie_info ie_list[1];	/* variable size list of ie_info_t structs */
+} __packed;
+
+struct ie_set_buffer {
+	char cmd[VNDR_IE_CMD_LEN];	/* ie IOVar set command : "add" + NUL */
+	struct ie_buf ie_buffer;	/* buffer containing IE list information */
+} __packed;
+
+/* Check whether the given IE looks like WFA OCE IE. */
+#define wl_cfgoce_is_oce_ie(ie, tlvs, len)	\
+	wl_cfgoce_has_ie(ie, tlvs, len,		\
+			 (const u8 *)WFA_OUI, TLV_OUI_LEN, WFA_OUI_TYPE_MBO_OCE)
+
+bool
+wl_cfgoce_has_ie(const u8 *ie, const u8 **tlvs, u32 *tlvs_len,
+		 const u8 *oui, u32 oui_len, u8 type);
+
+const struct inff_tlv *inff_parse_tlvs(const void *buf, int buflen, uint key);
+
+bool inff_tlv_has_ie(const u8 *ie, const u8 **tlvs, u32 *tlvs_len,
+		     const u8 *oui, u32 oui_len, u8 type);
+
+struct inff_vs_tlv *inff_find_wpaie(const u8 *parse, u32 len);
+
+struct inff_vs_tlv *inff_find_wpsie(const u8 *parse, u32 len);
+
+struct inff_tlv *inff_find_iwie(const u8 *parse, u32 len);
+
+s32 inff_clear_iwie(struct inff_cfg80211_info *cfg, struct inff_if *ifp);
+
+s32 inff_add_iwie(struct inff_cfg80211_info *cfg, struct inff_if *ifp,
+		  s32 pktflag, u8 ie_id, u8 *data, u8 data_len);
+
+bool inff_valid_wpa_oui(u8 *oui, bool is_rsn_ie);
+bool inff_valid_dpp_suite(u8 *oui);
+
+s32 inff_parse_vndr_ies(const u8 *vndr_ie_buf, u32 vndr_ie_len, struct parsed_vndr_ies *vndr_ies);
+
+u32 inff_vndr_ie(u8 *iebuf, s32 pktflag, u8 *ie_ptr, u32 ie_len, s8 *add_del_cmd);
+
+s32 inff_parse_extension_ies(const u8 *extension_ie_buf, u32 extension_ie_len,
+			     struct parsed_extension_ies *extension_ies);
+
+s32 inff_get_assoc_ies(struct inff_cfg80211_info *cfg, struct inff_if *ifp);
+
+void inff_clear_assoc_ies(struct inff_cfg80211_info *cfg);
+
+s32 inff_vif_set_mgmt_ie(struct inff_cfg80211_vif *vif, s32 pktflag,
+			 const u8 *vndr_ie_buf, u32 vndr_ie_len);
+s32 inff_vif_clear_mgmt_ies(struct inff_cfg80211_vif *vif);
+s32 inff_config_ap_mgmt_ie(struct inff_cfg80211_vif *vif, struct cfg80211_beacon_data *beacon);
+
+void inff_clear_assoc_req_ie(struct inff_cfg80211_info *cfg);
+void inff_clear_assoc_resp_ie(struct inff_cfg80211_info *cfg);
+
+#endif /* INFF_IE_H */
-- 
2.25.1


