Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB411813A4
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2020 09:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbgCKIrV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Mar 2020 04:47:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:55894 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728688AbgCKIrV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Mar 2020 04:47:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6858DAF8E;
        Wed, 11 Mar 2020 08:47:19 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 7/7] prism54: Use scnprintf() for avoiding potential buffer overflow
Date:   Wed, 11 Mar 2020 09:47:13 +0100
Message-Id: <20200311084713.18220-8-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200311084713.18220-1-tiwai@suse.de>
References: <20200311084713.18220-1-tiwai@suse.de>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Cc: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/net/wireless/intersil/prism54/oid_mgt.c | 34 ++++++++++++-------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/intersil/prism54/oid_mgt.c b/drivers/net/wireless/intersil/prism54/oid_mgt.c
index 5705ad925a51..9fd307ca4b6d 100644
--- a/drivers/net/wireless/intersil/prism54/oid_mgt.c
+++ b/drivers/net/wireless/intersil/prism54/oid_mgt.c
@@ -780,17 +780,17 @@ mgt_response_to_str(enum oid_num_t n, union oid_res_t *r, char *str)
 {
 	switch (isl_oid[n].flags & OID_FLAG_TYPE) {
 	case OID_TYPE_U32:
-		return snprintf(str, PRIV_STR_SIZE, "%u\n", r->u);
+		return scnprintf(str, PRIV_STR_SIZE, "%u\n", r->u);
 	case OID_TYPE_BUFFER:{
 			struct obj_buffer *buff = r->ptr;
-			return snprintf(str, PRIV_STR_SIZE,
+			return scnprintf(str, PRIV_STR_SIZE,
 					"size=%u\naddr=0x%X\n", buff->size,
 					buff->addr);
 		}
 		break;
 	case OID_TYPE_BSS:{
 			struct obj_bss *bss = r->ptr;
-			return snprintf(str, PRIV_STR_SIZE,
+			return scnprintf(str, PRIV_STR_SIZE,
 					"age=%u\nchannel=%u\n"
 					"capinfo=0x%X\nrates=0x%X\n"
 					"basic_rates=0x%X\n", bss->age,
@@ -801,9 +801,9 @@ mgt_response_to_str(enum oid_num_t n, union oid_res_t *r, char *str)
 	case OID_TYPE_BSSLIST:{
 			struct obj_bsslist *list = r->ptr;
 			int i, k;
-			k = snprintf(str, PRIV_STR_SIZE, "nr=%u\n", list->nr);
+			k = scnprintf(str, PRIV_STR_SIZE, "nr=%u\n", list->nr);
 			for (i = 0; i < list->nr; i++)
-				k += snprintf(str + k, PRIV_STR_SIZE - k,
+				k += scnprintf(str + k, PRIV_STR_SIZE - k,
 					      "bss[%u] :\nage=%u\nchannel=%u\n"
 					      "capinfo=0x%X\nrates=0x%X\n"
 					      "basic_rates=0x%X\n",
@@ -819,23 +819,23 @@ mgt_response_to_str(enum oid_num_t n, union oid_res_t *r, char *str)
 			struct obj_frequencies *freq = r->ptr;
 			int i, t;
 			printk("nr : %u\n", freq->nr);
-			t = snprintf(str, PRIV_STR_SIZE, "nr=%u\n", freq->nr);
+			t = scnprintf(str, PRIV_STR_SIZE, "nr=%u\n", freq->nr);
 			for (i = 0; i < freq->nr; i++)
-				t += snprintf(str + t, PRIV_STR_SIZE - t,
+				t += scnprintf(str + t, PRIV_STR_SIZE - t,
 					      "mhz[%u]=%u\n", i, freq->mhz[i]);
 			return t;
 		}
 		break;
 	case OID_TYPE_MLME:{
 			struct obj_mlme *mlme = r->ptr;
-			return snprintf(str, PRIV_STR_SIZE,
+			return scnprintf(str, PRIV_STR_SIZE,
 					"id=0x%X\nstate=0x%X\ncode=0x%X\n",
 					mlme->id, mlme->state, mlme->code);
 		}
 		break;
 	case OID_TYPE_MLMEEX:{
 			struct obj_mlmeex *mlme = r->ptr;
-			return snprintf(str, PRIV_STR_SIZE,
+			return scnprintf(str, PRIV_STR_SIZE,
 					"id=0x%X\nstate=0x%X\n"
 					"code=0x%X\nsize=0x%X\n", mlme->id,
 					mlme->state, mlme->code, mlme->size);
@@ -843,7 +843,7 @@ mgt_response_to_str(enum oid_num_t n, union oid_res_t *r, char *str)
 		break;
 	case OID_TYPE_ATTACH:{
 			struct obj_attachment *attach = r->ptr;
-			return snprintf(str, PRIV_STR_SIZE,
+			return scnprintf(str, PRIV_STR_SIZE,
 					"id=%d\nsize=%d\n",
 					attach->id,
 					attach->size);
@@ -851,7 +851,7 @@ mgt_response_to_str(enum oid_num_t n, union oid_res_t *r, char *str)
 		break;
 	case OID_TYPE_SSID:{
 			struct obj_ssid *ssid = r->ptr;
-			return snprintf(str, PRIV_STR_SIZE,
+			return scnprintf(str, PRIV_STR_SIZE,
 					"length=%u\noctets=%.*s\n",
 					ssid->length, ssid->length,
 					ssid->octets);
@@ -860,13 +860,13 @@ mgt_response_to_str(enum oid_num_t n, union oid_res_t *r, char *str)
 	case OID_TYPE_KEY:{
 			struct obj_key *key = r->ptr;
 			int t, i;
-			t = snprintf(str, PRIV_STR_SIZE,
+			t = scnprintf(str, PRIV_STR_SIZE,
 				     "type=0x%X\nlength=0x%X\nkey=0x",
 				     key->type, key->length);
 			for (i = 0; i < key->length; i++)
-				t += snprintf(str + t, PRIV_STR_SIZE - t,
+				t += scnprintf(str + t, PRIV_STR_SIZE - t,
 					      "%02X:", key->key[i]);
-			t += snprintf(str + t, PRIV_STR_SIZE - t, "\n");
+			t += scnprintf(str + t, PRIV_STR_SIZE - t, "\n");
 			return t;
 		}
 		break;
@@ -874,11 +874,11 @@ mgt_response_to_str(enum oid_num_t n, union oid_res_t *r, char *str)
 	case OID_TYPE_ADDR:{
 			unsigned char *buff = r->ptr;
 			int t, i;
-			t = snprintf(str, PRIV_STR_SIZE, "hex data=");
+			t = scnprintf(str, PRIV_STR_SIZE, "hex data=");
 			for (i = 0; i < isl_oid[n].size; i++)
-				t += snprintf(str + t, PRIV_STR_SIZE - t,
+				t += scnprintf(str + t, PRIV_STR_SIZE - t,
 					      "%02X:", buff[i]);
-			t += snprintf(str + t, PRIV_STR_SIZE - t, "\n");
+			t += scnprintf(str + t, PRIV_STR_SIZE - t, "\n");
 			return t;
 		}
 		break;
-- 
2.16.4

