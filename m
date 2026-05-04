Return-Path: <linux-wireless+bounces-35836-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id L0tDCyWT+GmwwgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35836-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 14:37:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4E84BCFA1
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 14:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43B3A300E5E1
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 12:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3393D3D0E;
	Mon,  4 May 2026 12:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NLVJJjD6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OBUE66Sm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18B73D34AD
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 12:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777898274; cv=none; b=fs+gH797VW5qpDsyTznIDWgyUQnSDOSAqZ3ymUOzHjV2XyG6SWbv53JJWVkSMGKy5NrYLIpOVTI3TRA9n91/y9T+KS+Px1GHPIdMhJ7fUNS+O07Jlkb1MT7JfyfKxI6Z5mJr2jyeTgykK2Dp6zIQfYu5wUJcknI23SjzGrNVXhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777898274; c=relaxed/simple;
	bh=glZztMojxDMn3zGlFXfrZ6+xd4K9+7l7xYF0KWlrH8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lv1Jpj3MKodk7xb8PChl9E89U9VBDf00JsORh3VKBumRtZZo/3KoMqgDR84N63B30FxCncXbUqZ4lFH9LSvWE13i9YZqE9H4oHGddiudPR0tHwLKq0FGhMjZSYCCtYgcP6o/UWmJGMd4ThxldixvA3NOBaMXJKC5Lai9y0ahb84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NLVJJjD6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OBUE66Sm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644B4EHR4128839
	for <linux-wireless@vger.kernel.org>; Mon, 4 May 2026 12:37:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=UqTf8tlrQ3i
	Xm6TwT64zMTOsNwj6Mmi9JO3dv8vD/+U=; b=NLVJJjD6FIBnfgwZFRVub3FMVYU
	QejwcqMKPQQZHbBAKOXAdYTRhnmIfKwtYd+YNwafl07fRbxa5WExvu1LGhlldSmC
	dvqHF/H7ReVzyh0fxk0SbcgY/eNjacz7WF7TbzebNvB5QzxRv4sJBYV5NWgfP45/
	bEXz1fWHi8hx3+09BRK9d1i5EFW2yQnM59ETL80DV1QiexmyszWAfZiMI/w2ESne
	2Wa5HH4eVkUAFd5w0Gp1txv4qawMMwzdQWAMkNZA0k8RUx5jTlfTkT61IUW+WKYv
	mjNXsakeFQ7gHkBucQOl3DDZ/EFHQDV2vcmCVvRiUQDOWDVuxgA2S9x977Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxsdw0d8b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 12:37:52 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b2ecc96a9aso40292575ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 05:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777898272; x=1778503072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqTf8tlrQ3iXm6TwT64zMTOsNwj6Mmi9JO3dv8vD/+U=;
        b=OBUE66Sm71xqWJ/j2ItCRXo6KyoIAp32wQVBt5tDwkfH+8lq0fcTH+EpsRvrhRMe+O
         6NqBswRL7E95bX3TmdE/sH3HtETb24OvUdjurGtyHtURE9QlXTc7M47ZNmb5yHpUndpn
         fUhfeZPm88KpKqJo75dG8v3N/JRRbCKftE7a8RBkU4RSXCnh5Rllcu/tKUwxz9Pj340g
         52HV15ygTIY6CCKAr7ngAZW1YMDGkZ9tP4u9xDhClb0KhaAMTKWdl72WYGceOBl9Ki9V
         O/IPpbkvQtpAsOmeWo0S8v1l4nxV8rSGhP4p3GvH382gW+U6Ws33qc84Bd+DKFQjLAPL
         ZP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777898272; x=1778503072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UqTf8tlrQ3iXm6TwT64zMTOsNwj6Mmi9JO3dv8vD/+U=;
        b=k50dZXIjWwdwWf1Odl58w+oXRdegb4wI7BYBtY9CdjEqOuZFpNiJnEEf6sMFRRPwyF
         m3yrawgxZlWMT+MCywsfPYj88IuxdjKIcCqeV7EJnm44ihynKletOtdabRT9SIREb51Q
         X879MD8c7wnDKzxWUdHBUgQsGbCXBwdS6XL0HNnRfNlnd4McnFV22vp8yZgNTdPrJwEm
         YFBTmn6MExXzGICGQPC3tz0BaOJ2QLVmChQydQA6lTi+JQlcJGoHJyI0HV/GNXm7dnRJ
         zV5gJm5z8YtScfHKKLS31k8xhP9JSwitqLUD+H4DGlreORR2biL0PPPv8eTUQtegR+qU
         QN+Q==
X-Gm-Message-State: AOJu0YyJBzSuBLvzS04Rg3cxJKuV1l+ZtY3Me6V2MeOLUE3CODS+QdUe
	IMfawMI52ZD3Aw67Zi8CBJbMBBcPescuX3pSCbeHvLA8HRWf1eUHBF7rMcCvopw5YAF+XogtByI
	TRvwHFUb12J9/2T09J/qV50KFvuD9DezGm/eCrqAlWTnzmH3twO9xReRolFsc8enMuqDQTw==
X-Gm-Gg: AeBDieuxQyWF6S93ue2ZlqPyu7g9wl373VU6GbPUCIZrDZl+3qaOe6HooohMDKM0l55
	9/kuEWLdOkjAoNUS5mTvb44Cdvf4BUKnnUQOYFPpl8mYUVX19tr20dzL3Y3TKWu6tN+FYERByea
	80JJWm68U2nPQniyI1n55GIQnD1AsQY8TghrVWSPjRyXSNEX5SCbyxaer5LSTGtQsNmLfNILt9A
	t+ahUaJ5aj0w0R3Lvq0QYIuolTsgU4Ht6xfvt5IFBdAYIgc4JuYdsuaRpX4aeIcs+OXzlbk9RAw
	vb12GDmltUk1Fo0M0uxzZTwmDae4IOleI/0ciUMcvEGFfrJnL4a5oYxllF1jaokb2smQ6JxjV+N
	PIZoxseU7euLayqlgTDcybVx6fVysnepFBVhUdQyotGORDP+1vCFvJmYDNfrK32Cp
X-Received: by 2002:a17:902:ffcb:b0:2b4:7b57:5d77 with SMTP id d9443c01a7336-2b9f25f663bmr88860575ad.26.1777898271716;
        Mon, 04 May 2026 05:37:51 -0700 (PDT)
X-Received: by 2002:a17:902:ffcb:b0:2b4:7b57:5d77 with SMTP id d9443c01a7336-2b9f25f663bmr88860215ad.26.1777898270955;
        Mon, 04 May 2026 05:37:50 -0700 (PDT)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae6ac32sm107505145ad.83.2026.05.04.05.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 05:37:50 -0700 (PDT)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v3 2/2] wifi: mac80211: set assoc_encrypted for EPP associations
Date: Mon,  4 May 2026 18:06:24 +0530
Message-Id: <20260504123624.529218-3-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260504123624.529218-1-kavita.kavita@oss.qualcomm.com>
References: <20260504123624.529218-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=a7AAM0SF c=1 sm=1 tr=0 ts=69f89320 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=-eHc6TfEv9NJhruqS2oA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: QKzsnJl9W9BBpL6C9eTJDfrliUaRrJIU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDEzNCBTYWx0ZWRfX9paL2ObD4DQH
 rHMGZGNeC/aaeJY8xyLigpUHpCdbYJWnUTpXfqeTXASwNonNcahUX+t4jFEzuL+PUmrPLSo7ygX
 LwWAto6GQ1FkA+PBPUn0jIvNRpFI2841Ks6BKhzJaQK+mNFr72ESL3OVeWWYI6XSA+FpJhS6RMN
 Dp9jAFjMb0PAfjnlpw1uDc2AE6EJC9ZxfH368zbCWSsDQv8sTjyIeeVVQZAGX41HbfNK9waXL+m
 z2PCdIPxwNqTY5KyPFhbZggG7OR0XX3n998YD7fkMlOfoYfk5p6+flK4BHspd2LTFtZ5+IPLNu1
 l+s59p0tj7L99TScexqFm+4KkyK27Y+FQg1wRbHRiugWhC1FPLE6Y6r6MssYXqYF/dS2xlIMLF+
 2VwXxRT67+GEFn39gP84iMK2CQqrLtB6urPfgmxrq2gdYkjL7jTWSyMWzbMW2+sA/PFvilvbqya
 uvjxbzL5oM9JkFNB68w==
X-Proofpoint-ORIG-GUID: QKzsnJl9W9BBpL6C9eTJDfrliUaRrJIU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040134
X-Rspamd-Queue-Id: 7C4E84BCFA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35836-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kavita.kavita@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]

Populate the assoc_encrypted field in cfg80211_rx_assoc_resp_data
for mac80211-based drivers to indicate that the entire (re)association
exchange was encrypted.

When epp_peer is set, mac80211 enforces that unprotected
(Re)Association Request/Response frames are dropped. This ensures that
by the time the (Re)Association Response is processed, the entire
exchange was transmitted encrypted over the air.

Add support to populate assoc_encrypted based on epp_peer flag.

Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 net/mac80211/mlme.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 00b4beff0e43..a1246af09dc5 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6652,6 +6652,7 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 		.type = le16_to_cpu(mgmt->frame_control) & IEEE80211_FCTL_TYPE,
 	};
 	struct ieee802_11_elems *elems;
+	struct sta_info *sta;
 	int ac;
 	const u8 *elem_start;
 	unsigned int elem_len;
@@ -6847,6 +6848,14 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 		resp.ap_mld_addr = ap_mld_addr;
 	}
 
+	/*
+	 * If epp_peer set, unprotected (Re)Association Request/Response frames
+	 * are dropped, which ensures that the (re)association exchange is
+	 * encrypted over the air.
+	 */
+	sta = sta_info_get_bss(sdata, sdata->vif.cfg.ap_addr);
+	resp.assoc_encrypted = sta && sta->sta.epp_peer;
+
 	ieee80211_destroy_assoc_data(sdata,
 				     status_code == WLAN_STATUS_SUCCESS ?
 					ASSOC_SUCCESS :
-- 
2.34.1


