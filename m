Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA161068FC
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 10:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfKVJoA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 04:44:00 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:35154 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfKVJoA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 04:44:00 -0500
Received: by mail-pj1-f65.google.com with SMTP id s8so2836990pji.2
        for <linux-wireless@vger.kernel.org>; Fri, 22 Nov 2019 01:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=1kENrBK+Si8GTG/z7vluv90p0vaDDTLdLP0ZTBYtdys=;
        b=gFC1GPvmciglvQH3QRWVdrtGLMliah1xCIA8nZta7Mis7sATxTwTG/XMZ/G4Zb8efA
         bvc58q+E3uHBiZOOCVFqZrDhJzM1SJVkOtFKPIquJLhmKms1Rd7FLwLFKwbq9DKE28C4
         crZUPOja7RMESC2jajleQdZ9YO/o/LEA+6QmEKIQFZ11R7j/qT/bNTdf08hDTINa7VVq
         r20OL/q5iTBYBqodQaQVOPHH7f8iRs46gS/23GSX8E8Lo920r4wtTUPXXBidt0bay7ID
         L2CF8vLLDGRe4Dohd71wCJgl54yVxF1Fi9qAvQluyVTulAtDVNw8Ol9hFdLa9R7j2M2z
         9wWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=1kENrBK+Si8GTG/z7vluv90p0vaDDTLdLP0ZTBYtdys=;
        b=lGAdjvr9L1WcGIvtpY5RO07jVV2t+CQ7rGsSqHcqyoDarWzcfl+FowtU0U+OV0Uf0k
         Dxs4mJ+rml43X7SrPljpiHzQB1mRWWnTcIKwO9YFH1DbuMxYpTV/AdDtkyLGwQEPCTu2
         U/RIv2CvLNWTGQYXAqUH4wZJ0MAo0w2fWX8QeMCWarAPRgOsyeT9LEZQT6ypWzy9bAKs
         ri4P+HqxmhlvDFb3ij0pl0x7hhOOhDCSdzZEfy8MGL/wmxdbOLM5AV8DevGNLEZHZrJ9
         AHHgRlkUPn5esIeIhTiYu3hox+z4GLrcRZccqcL3O9QM9rKX6SyNF9MjoEIgD5WK7ycl
         Tlvg==
X-Gm-Message-State: APjAAAVLU8HZian8Pqy8r1Iwnjga8cqc70tKNQWQHXIQ/WEWDgKWDzip
        dkM+yuOUv3M4BD3u8wHsttGE4Sk9BqOSqA==
X-Google-Smtp-Source: APXvYqxWR1wx4sFD+yyfHofiemrR7B+b6xLDxQu9tS4dKDTYtMBUggkRWVG0Y4CUsP1DbHGVYW2rGg==
X-Received: by 2002:a17:90a:c004:: with SMTP id p4mr17937350pjt.104.1574415837353;
        Fri, 22 Nov 2019 01:43:57 -0800 (PST)
Received: from [127.0.0.1] (187.220.92.34.bc.googleusercontent.com. [34.92.220.187])
        by smtp.gmail.com with ESMTPSA id 71sm6800121pfx.107.2019.11.22.01.43.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 01:43:56 -0800 (PST)
From:   qize wang <wangqize888888888@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: [PATCH] mwifiex: Fix heap overflow in 
 mmwifiex_process_tdls_action_frame()
Message-Id: <E40E893E-D9B4-4C63-8139-1DD5E1C2CECB@gmail.com>
Date:   Fri, 22 Nov 2019 17:43:49 +0800
Cc:     amitkarwar <amitkarwar@gmail.com>, nishants <nishants@marvell.com>,
        gbhat <gbhat@marvell.com>, huxinming820 <huxinming820@gmail.com>,
        kvalo <kvalo@codeaurora.org>, Greg KH <greg@kroah.com>,
        security <security@kernel.org>,
        linux-distros <linux-distros@vs.openwall.org>,
        "dan.carpenter" <dan.carpenter@oracle.com>,
        Solar Designer <solar@openwall.com>
To:     linux-wireless@vger.kernel.org
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mwifiex_process_tdls_action_frame() without checking
the incoming tdls infomation element's vality before use it,
this may cause multi heap buffer overflows.

Fix them by putting vality check before use it.

Signed-off-by: qize wang <wangqize888888888@gmail.com>
---
drivers/net/wireless/marvell/mwifiex/tdls.c | 70 =
++++++++++++++++++++++++++---
1 file changed, 64 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/tdls.c =
b/drivers/net/wireless/marvell/mwifiex/tdls.c
index 09313047beed..7caf1d26124a 100644
--- a/drivers/net/wireless/marvell/mwifiex/tdls.c
+++ b/drivers/net/wireless/marvell/mwifiex/tdls.c
@@ -953,59 +953,117 @@ void mwifiex_process_tdls_action_frame(struct =
mwifiex_private *priv,

		switch (*pos) {
		case WLAN_EID_SUPP_RATES:
+			if (pos[1] > 32)
+				return;
			sta_ptr->tdls_cap.rates_len =3D pos[1];
			for (i =3D 0; i < pos[1]; i++)
				sta_ptr->tdls_cap.rates[i] =3D pos[i + =
2];
			break;

		case WLAN_EID_EXT_SUPP_RATES:
+			if (pos[1] > 32)
+				return;
			basic =3D sta_ptr->tdls_cap.rates_len;
+			if (pos[1] > 32 - basic)
+				return;
			for (i =3D 0; i < pos[1]; i++)
				sta_ptr->tdls_cap.rates[basic + i] =3D =
pos[i + 2];
			sta_ptr->tdls_cap.rates_len +=3D pos[1];
			break;
		case WLAN_EID_HT_CAPABILITY:
-			memcpy((u8 *)&sta_ptr->tdls_cap.ht_capb, pos,
+			if (pos > end - sizeof(struct ieee80211_ht_cap) =
- 2)
+				return;
+			if (pos[1] !=3D sizeof(struct ieee80211_ht_cap))
+				return;
+			/* copy the ie's value into ht_capb*/
+			memcpy((u8 *)&sta_ptr->tdls_cap.ht_capb, pos + =
2,
			       sizeof(struct ieee80211_ht_cap));
			sta_ptr->is_11n_enabled =3D 1;
			break;
		case WLAN_EID_HT_OPERATION:
-			memcpy(&sta_ptr->tdls_cap.ht_oper, pos,
+			if (pos > end -
+			    sizeof(struct ieee80211_ht_operation) - 2)
+				return;
+			if (pos[1] !=3D sizeof(struct =
ieee80211_ht_operation))
+				return;
+			/* copy the ie's value into ht_oper*/
+			memcpy(&sta_ptr->tdls_cap.ht_oper, pos + 2,
			       sizeof(struct ieee80211_ht_operation));
			break;
		case WLAN_EID_BSS_COEX_2040:
+			if (pos > end - 3)
+				return;
+			if (pos[1] !=3D 1)
+				return;
			sta_ptr->tdls_cap.coex_2040 =3D pos[2];
			break;
		case WLAN_EID_EXT_CAPABILITY:
+			if (pos > end - sizeof(struct =
ieee_types_header))
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
+			if (pos > end - sizeof(struct =
ieee_types_header))
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
+			if (pos[1] !=3D 1)
+				return;
			sta_ptr->tdls_cap.qos_info =3D pos[2];
			break;
		case WLAN_EID_VHT_OPERATION:
-			if (priv->adapter->is_hw_11ac_capable)
-				memcpy(&sta_ptr->tdls_cap.vhtoper, pos,
+			if (priv->adapter->is_hw_11ac_capable) {
+				if (pos > end -
+				    sizeof(struct =
ieee80211_vht_operation) - 2)
+					return;
+				if (pos[1] !=3D
+				    sizeof(struct =
ieee80211_vht_operation))
+					return;
+				/* copy the ie's value into vhtoper*/
+				memcpy(&sta_ptr->tdls_cap.vhtoper, pos + =
2,
				       sizeof(struct =
ieee80211_vht_operation));
+			}
			break;
		case WLAN_EID_VHT_CAPABILITY:
			if (priv->adapter->is_hw_11ac_capable) {
-				memcpy((u8 *)&sta_ptr->tdls_cap.vhtcap, =
pos,
+				if (pos > end -
+				    sizeof(struct ieee80211_vht_cap) - =
2)
+					return;
+				if (pos[1] !=3D sizeof(struct =
ieee80211_vht_cap))
+					return;
+				/* copy the ie's value into vhtcap*/
+				memcpy((u8 *)&sta_ptr->tdls_cap.vhtcap, =
pos + 2,
				       sizeof(struct =
ieee80211_vht_cap));
				sta_ptr->is_11ac_enabled =3D 1;
			}
			break;
		case WLAN_EID_AID:
-			if (priv->adapter->is_hw_11ac_capable)
+			if (priv->adapter->is_hw_11ac_capable) {
+				if (pos > end - 4)
+					return;
+				if (pos[1] !=3D 2)
+					return;
				sta_ptr->tdls_cap.aid =3D
					get_unaligned_le16((pos + 2));
+			}
+			break;
		default:
			break;
		}
--=20
2.14.3 (Apple Git-98)

