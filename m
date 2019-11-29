Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E57DB10D3B4
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2019 11:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfK2KMd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Nov 2019 05:12:33 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34664 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfK2KMd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Nov 2019 05:12:33 -0500
Received: by mail-pl1-f195.google.com with SMTP id h13so12735754plr.1
        for <linux-wireless@vger.kernel.org>; Fri, 29 Nov 2019 02:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iIXAN0l14uxJr46wvhgDbAs2sD7O8ChcW98emte0Oe4=;
        b=PEc7h88WdwkDeNwezNf3b1IFemZrj055k1nWUlmJhU3L5HPbizCcWoAOA585vnXYuv
         J6tyYgqW7hclZT91V7mea9WijzR3/rDhLDx8sH4SosvW0dAietG63UkvByySB/+smE8R
         g/UQBlbXvvS3KHjLjGIvCVUE9bupbmDLSYdBbpuenurd/NtAZo9wqox8rJk840HYySyD
         0c9mjYtDzd4Qt+IiWXmhoemhCQPHA4OSK/ww/GKtRc4RCaZ9w2qZTmGknX9Z8b9q0PW3
         JLXW32GR2Iehw9/aycVahZSc65OUpeGHRXyMscjpHYdCW8MGsAZ6mxIxwV91sCueE2YD
         WiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iIXAN0l14uxJr46wvhgDbAs2sD7O8ChcW98emte0Oe4=;
        b=SQj+5pw2obP4tSrkusotBoQxcNw4awqZX134WJE6SPmND8NWzS79VgV5vIJe2yelh9
         0o/eHQFyW53h3ACkbq180ekBUWJjks6Y/EsDSGZZmHIU2i4NWhQrfFp6HxNOoyxUvJcv
         WdnTCTazff5Y60Bv0JD3o0TptKwdn6Vc0QhJgh+jDmPLTP2eO+BTGKPVh/Vz6Y2DxZt/
         Q8CFromdpn72pfUoNQAJtCrrVkmVIb5KqQBovGKCiqska3NjmO5K8nNV7ZccEZXlytjH
         gkXfO2TE08q19211cIOnP5kjRvX1EMieZeGiY0fke+rfGH2rgziJnzzSAn4lQ+erGf3u
         Vulw==
X-Gm-Message-State: APjAAAU4jIQYbBvwOQiyHMoO2jLWXB4/QMleOA9+B0TMMn5Grz+sKR0A
        +358cASkJlk+3oNq7WcrmnfdBhchTkWD8MSz
X-Google-Smtp-Source: APXvYqy/B4W1d9+t/azCYv0AvIuuh2e/6923jqmYM4Dv+sZwfXtOolaivVoHIP21N+RBY3c1KQBvjg==
X-Received: by 2002:a17:90a:b109:: with SMTP id z9mr17374886pjq.108.1575022352267;
        Fri, 29 Nov 2019 02:12:32 -0800 (PST)
Received: from localhost.localdomain ([240e:82:f0a8:7d5b:124:6e01:5bc1:e947])
        by smtp.gmail.com with ESMTPSA id u7sm23062775pfh.84.2019.11.29.02.12.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Nov 2019 02:12:31 -0800 (PST)
From:   qize wang <wangqize888888888@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     amitkarwar@gmail.com, nishants@marvell.com, gbhat@marvell.com,
        huxinming820@gmail.com, kvalo@codeaurora.org, greg@kroah.com,
        dan.carpenter@oracle.com, solar@openwall.com,
        wangqize888888888@gmail.com
Subject: [PATCH v3] mwifiex: Fix heap overflow in mmwifiex_process_tdls_action_frame()
Date:   Fri, 29 Nov 2019 18:10:54 +0800
Message-Id: <20191129101054.2756-1-wangqize888888888@gmail.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mwifiex_process_tdls_action_frame() without checking
the incoming tdls infomation element's vality before use it,
this may cause multi heap buffer overflows.

Fix them by putting vality check before use it.

IE is TLV struct, but ht_cap and  ht_oper aren’t TLV struct.
the origin marvell driver code is wrong:

memcpy(&sta_ptr->tdls_cap.ht_oper, pos,....
memcpy((u8 *)&sta_ptr->tdls_cap.ht_capb, pos,...

Fix the bug by changing pos(the address of IE) to
pos+2 ( the address of IE value ).

v3: change commit log

Signed-off-by: qize wang <wangqize888888888@gmail.com>
---
 drivers/net/wireless/marvell/mwifiex/tdls.c | 70 ++++++++++++++++++++++++++---
 1 file changed, 64 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/tdls.c b/drivers/net/wireless/marvell/mwifiex/tdls.c
index 09313047beed..7caf1d26124a 100644
--- a/drivers/net/wireless/marvell/mwifiex/tdls.c
+++ b/drivers/net/wireless/marvell/mwifiex/tdls.c
@@ -953,59 +953,117 @@ void mwifiex_process_tdls_action_frame(struct mwifiex_private *priv,
 
 		switch (*pos) {
 		case WLAN_EID_SUPP_RATES:
+			if (pos[1] > 32)
+				return;
 			sta_ptr->tdls_cap.rates_len = pos[1];
 			for (i = 0; i < pos[1]; i++)
 				sta_ptr->tdls_cap.rates[i] = pos[i + 2];
 			break;
 
 		case WLAN_EID_EXT_SUPP_RATES:
+			if (pos[1] > 32)
+				return;
 			basic = sta_ptr->tdls_cap.rates_len;
+			if (pos[1] > 32 - basic)
+				return;
 			for (i = 0; i < pos[1]; i++)
 				sta_ptr->tdls_cap.rates[basic + i] = pos[i + 2];
 			sta_ptr->tdls_cap.rates_len += pos[1];
 			break;
 		case WLAN_EID_HT_CAPABILITY:
-			memcpy((u8 *)&sta_ptr->tdls_cap.ht_capb, pos,
+			if (pos > end - sizeof(struct ieee80211_ht_cap) - 2)
+				return;
+			if (pos[1] != sizeof(struct ieee80211_ht_cap))
+				return;
+			/* copy the ie's value into ht_capb*/
+			memcpy((u8 *)&sta_ptr->tdls_cap.ht_capb, pos + 2,
 			       sizeof(struct ieee80211_ht_cap));
 			sta_ptr->is_11n_enabled = 1;
 			break;
 		case WLAN_EID_HT_OPERATION:
-			memcpy(&sta_ptr->tdls_cap.ht_oper, pos,
+			if (pos > end -
+			    sizeof(struct ieee80211_ht_operation) - 2)
+				return;
+			if (pos[1] != sizeof(struct ieee80211_ht_operation))
+				return;
+			/* copy the ie's value into ht_oper*/
+			memcpy(&sta_ptr->tdls_cap.ht_oper, pos + 2,
 			       sizeof(struct ieee80211_ht_operation));
 			break;
 		case WLAN_EID_BSS_COEX_2040:
+			if (pos > end - 3)
+				return;
+			if (pos[1] != 1)
+				return;
 			sta_ptr->tdls_cap.coex_2040 = pos[2];
 			break;
 		case WLAN_EID_EXT_CAPABILITY:
+			if (pos > end - sizeof(struct ieee_types_header))
+				return;
+			if (pos[1] < sizeof(struct ieee_types_header))
+				return;
+			if (pos[1] > 8)
+				return;
 			memcpy((u8 *)&sta_ptr->tdls_cap.extcap, pos,
 			       sizeof(struct ieee_types_header) +
 			       min_t(u8, pos[1], 8));
 			break;
 		case WLAN_EID_RSN:
+			if (pos > end - sizeof(struct ieee_types_header))
+				return;
+			if (pos[1] < sizeof(struct ieee_types_header))
+				return;
+			if (pos[1] > IEEE_MAX_IE_SIZE -
+			    sizeof(struct ieee_types_header))
+				return;
 			memcpy((u8 *)&sta_ptr->tdls_cap.rsn_ie, pos,
 			       sizeof(struct ieee_types_header) +
 			       min_t(u8, pos[1], IEEE_MAX_IE_SIZE -
 				     sizeof(struct ieee_types_header)));
 			break;
 		case WLAN_EID_QOS_CAPA:
+			if (pos > end - 3)
+				return;
+			if (pos[1] != 1)
+				return;
 			sta_ptr->tdls_cap.qos_info = pos[2];
 			break;
 		case WLAN_EID_VHT_OPERATION:
-			if (priv->adapter->is_hw_11ac_capable)
-				memcpy(&sta_ptr->tdls_cap.vhtoper, pos,
+			if (priv->adapter->is_hw_11ac_capable) {
+				if (pos > end -
+				    sizeof(struct ieee80211_vht_operation) - 2)
+					return;
+				if (pos[1] !=
+				    sizeof(struct ieee80211_vht_operation))
+					return;
+				/* copy the ie's value into vhtoper*/
+				memcpy(&sta_ptr->tdls_cap.vhtoper, pos + 2,
 				       sizeof(struct ieee80211_vht_operation));
+			}
 			break;
 		case WLAN_EID_VHT_CAPABILITY:
 			if (priv->adapter->is_hw_11ac_capable) {
-				memcpy((u8 *)&sta_ptr->tdls_cap.vhtcap, pos,
+				if (pos > end -
+				    sizeof(struct ieee80211_vht_cap) - 2)
+					return;
+				if (pos[1] != sizeof(struct ieee80211_vht_cap))
+					return;
+				/* copy the ie's value into vhtcap*/
+				memcpy((u8 *)&sta_ptr->tdls_cap.vhtcap, pos + 2,
 				       sizeof(struct ieee80211_vht_cap));
 				sta_ptr->is_11ac_enabled = 1;
 			}
 			break;
 		case WLAN_EID_AID:
-			if (priv->adapter->is_hw_11ac_capable)
+			if (priv->adapter->is_hw_11ac_capable) {
+				if (pos > end - 4)
+					return;
+				if (pos[1] != 2)
+					return;
 				sta_ptr->tdls_cap.aid =
 					get_unaligned_le16((pos + 2));
+			}
+			break;
 		default:
 			break;
 		}
-- 
2.14.3 (Apple Git-98)

