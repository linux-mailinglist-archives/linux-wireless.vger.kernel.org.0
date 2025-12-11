Return-Path: <linux-wireless+bounces-29661-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C71D9CB5E88
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 13:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0221330011BC
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 12:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B04B3101DF;
	Thu, 11 Dec 2025 12:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kyh49BNj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GmlH3856"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5677E30FF3B
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765456898; cv=none; b=TXnm3gjGlrJrqhd1Hm/t9M1zkMy6cviovMFt0MtxXakIwQJKeEDBaJ2IhPlXeF7nxT/lUkVX/+KTQx5E/quAla3sm7BlVDG3I66oQsy/6cRjJ9lTSRAVGptH014cCH1vn7n6wpeIbnW04Zt6yp4cSx9j+ee29LVmHYFZgu9z01A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765456898; c=relaxed/simple;
	bh=0U4qcosv1yEg/opGBW1JiJyqxeePUAozid1XTmSQH0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bECDN+NVWxnBJyLrzNcRcTuaVzHd9KTO5S5xT5c8WnMwTTfkxRCpZ8YYCgljM8soDZCQvOBu38mCk4qcvEyDCcC+1lP3AHDIBod8VJkAWCC+UXNh6dWrFnl6jXQg1XBzeeY/m/PUeOVhfOG3A2qdt2h2YqcY7xzw+F2NuvZr90Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kyh49BNj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GmlH3856; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBAXn8Q1597348
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=9X4R5+Dowlt
	9zjIyRv8w3/YtzMPCofeEEBL6FB0sNEM=; b=kyh49BNj0JvgaWtW/a9iemxz6rf
	PbzNccAq+hSXJRdd09r2hfmTRl9aBcDGj9hEuzv6wfOdi07kV/fxQuk9pQwRQQlf
	7dzi+cl9/iwF55pElLENIw20pe7B3J7T4UFLiYR2fD1L0Ejnb1sDT+rnlLSCCqwA
	5Fo7SYrikTn0WgpiY+smPcXeQ4yd2n5Wpr6UXrRENIzhDk78eDnfVMYcCUuI2Cvi
	Jf4h4sjBVSi1FcXQ2/uDALrkRoWm/lsbd5QyKyB6yQFb2iWF3IV5FA4/zLyzdO2W
	QtV7avVkHVV4pih4fY8rxYqcAmjCK/0fNXJ2nrNWWY8ojHZN0x5eK1A0SEg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aybhpbmr3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:32 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7b6b194cf71so9778b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 04:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765456892; x=1766061692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9X4R5+Dowlt9zjIyRv8w3/YtzMPCofeEEBL6FB0sNEM=;
        b=GmlH3856qMTWr3+8kdRMu7JTTz1yyfpkTFbktR4+2J38ar+Mv2wjux4A+sPVF46hbs
         x0eFPIKSBKATOQzyKUUuTsN2wqfbxICnWH/XcYsSN0xnV7reAAPDzjO4pUVTglXU87JF
         FT5BjjrPUp3Geyd/rTpvtuEM5aHORXKtyVr1ucw9lBIuQNhPooLPd+/wvCmojkhwEREa
         TFZdchZzlDYwFkC0pC/0RgwbupVgdoVRPiQ5RMAIKglWTKp2prkt/lXjQOANueE4c/EQ
         OyqgR4E6T7iiVKelXqZesDhJEREKeBEs7b+M1JOPNLdt2oua2H96docPPOpRhEHJvW+W
         Rp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765456892; x=1766061692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9X4R5+Dowlt9zjIyRv8w3/YtzMPCofeEEBL6FB0sNEM=;
        b=FYnTU3bRyHBeR57WRx9RKAEfBetz666K+cr4Td/Y0TgOjmfD2UJFh2DmV0Rngl8ZFM
         of2RS12YDSYLOpxMVf3FzUH0B1HFJC3kRMqTPcZ7EwpfcLQW4vm5LnJTLlnZeAoEuAMF
         gFy03KAtXl+jcS3lyYMMPtHZIAXNmTBwolv7oHCkYthOvt6lQ9nOWhur/1FEGrLUq5Mk
         WStCrhZVXobKpbjOJcHUxJ7Ep+Afc2IwTXkj3MKcPi4sZYb5+8f6kn+bYM6ILcdLwgkX
         5NBF3OnyjcWpQh0zHESIM/Ueyi45dV07LC2m+Y4SJAiBnW6lFR0M0tPjv8OQdlK363PL
         Vp+g==
X-Gm-Message-State: AOJu0YzRCAGoIVI/56NVjCsekBN3IsussOrcGEyM3VXrxHGnGcujnZkE
	OF3qiU4LF3lplXxJNAobrikAaiRQihK54xxAL3VVmBJMtXnBEP3f75ZoFY0LMKzFVWhpez0EHNL
	MhR8BFylrWO8S6CYR4goXAGszi9TCBxO8R9HoYIVWoKnySBwwWwCUAjeVyYJFeYE/sjfGhg==
X-Gm-Gg: AY/fxX4cswiQ+YkGAFAP91a4Xg8uECa9L68H8bSCxccqvj8+hFEEYe9l1pgLg40nmpH
	0oz/xYzOKyhl/Cy3kuRoWXpQSF3rSk8XvrRk1BX2tx/WKe19XS+hYSYFa+3+NZFR7ZviiC/VoZ9
	2JzLs7L69Itg8pPjdSxDr5RN8hO9CIx1GcBFWaITPA9b1E70UnAcUo9P5vpqo9dnSuTecokbm9k
	6Mr8iRLqyOQ8Y1936xuX9Bo6TC1vb3IWEBFgAWugtxxSDTGRwBIHWsP87/XH3pPx1XabL/hu4Hv
	peAtSqEwJby3StOOWAqnmLl+98Zyr7RAV4y7iDLvZiim5UmFkT3FPC6vQSCIr+me7nko4sb6E+B
	CaZpQdoBuA8TpHerBlNK0YpcZmEyrJ4m5qyY+B+Y8yA==
X-Received: by 2002:a05:6a20:7f98:b0:359:d678:5493 with SMTP id adf61e73a8af0-366e07e43d6mr6277561637.34.1765456891599;
        Thu, 11 Dec 2025 04:41:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmsOkNlZDAwbZOOakhYXLhzfEinRZJImEJFQHZbjc/Ba4f14NkgUz5wpMk+wmf74HIizLrog==
X-Received: by 2002:a05:6a20:7f98:b0:359:d678:5493 with SMTP id adf61e73a8af0-366e07e43d6mr6277527637.34.1765456890975;
        Thu, 11 Dec 2025 04:41:30 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2ae4e163sm2272297a12.20.2025.12.11.04.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 04:41:30 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next 07/14] wifi: nl80211: add a new netlink key attribute for Key Confirmation Key (KCK)
Date: Thu, 11 Dec 2025 18:10:44 +0530
Message-Id: <20251211124051.3094878-8-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
References: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDA5OSBTYWx0ZWRfX/mgOLMxqG5YY
 Opj1jQzR2GYhhSAPtLHeCh9kiF4z4tiYwm7dk6BAdUT+tsoxmgmrup8ZUenWlaPd6SfGfMf5Ywd
 8hqupII8LSzcnJ0g9f+HsUvdGtO3DtjwAKlmNrfyYYvf6+HxQZKfc21GExL6yvoyQUXR8qqT+Pz
 2v68jOAO+BjkV+8+pdyZNo1R/1e7e2/5zomVmoUxpTU8nDQjDkyUHjZ3LbpqKJMdGdfsSHK4YoO
 jb2rOfDIAnxxIDBUe38pbIw+4JCM243rhfkcqMPX48UboNitkFWr/r5PHCcMaZIGTr6/6EnBWhV
 u3WZUlF5WGScmuEe83/3e3rBr22SdOueEoGVDBx+zFvPNvZqbnu+0Cf7ly1HDWywsH385KlJl6J
 yR+XokM0KnLuOwcpIWeK9l3pbj+t1w==
X-Proofpoint-ORIG-GUID: d9tKtEtZO3LmetyyKmluVFBRnF-OAKT1
X-Proofpoint-GUID: d9tKtEtZO3LmetyyKmluVFBRnF-OAKT1
X-Authority-Analysis: v=2.4 cv=LJ9rgZW9 c=1 sm=1 tr=0 ts=693abbfc cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=1DcUhRcEI7L0RMijthEA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_01,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512110099

The IEEE 802.11bi standard introduces the Enhanced Privacy Protection
Key Exchange (EPPKE) authentication protocol as specified in
"IEEE P802.11bi/D3.0, 12.16.9". This protocol requires passing a Key
Confirmation Key (KCK) from userspace to the driver to construct the
Message Integrity Code (MIC) for authentication frames.

Introduce a new netlink attribute, NL80211_ATTR_KEY_KCK, to allow
userspace to provide the KCK via the NL80211_CMD_AUTHENTICATE command.
This attribute is only present when the connection uses the EPPKE
authentication protocol.

Extend struct cfg80211_auth_request with a kck field to carry the key
from cfg80211 to the mac80211 layer.

Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 include/net/cfg80211.h       |  4 ++++
 include/uapi/linux/nl80211.h |  8 ++++++++
 net/wireless/nl80211.c       | 10 ++++++++++
 3 files changed, 22 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 38d201d4e676..6f02d2fdfc71 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3187,6 +3187,8 @@ static inline const u8 *ieee80211_bss_get_ie(struct cfg80211_bss *bss, u8 id)
  * @key_len: length of WEP key for shared key authentication
  * @key_idx: index of WEP key for shared key authentication
  * @key: WEP key for shared key authentication
+ * @kck: Key Confirmation Key for EPPKE Authentication.
+ * @kck_len: length of the KCK key for EPPKE Authentication.
  * @auth_data: Fields and elements in Authentication frames. This contains
  *	the authentication frame body (non-IE and IE data), excluding the
  *	Authentication algorithm number, i.e., starting at the Authentication
@@ -3209,6 +3211,8 @@ struct cfg80211_auth_request {
 	const u8 *key;
 	u8 key_len;
 	s8 key_idx;
+	const u8 *kck;
+	u8 kck_len;
 	const u8 *auth_data;
 	size_t auth_data_len;
 	s8 link_id;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index f78f6e7c4ab7..d0008780ffcb 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2981,6 +2981,12 @@ enum nl80211_commands {
  *	(e.g., EPPKE). If set, transmit key data to the driver for installation/
  *	removal/modification before the non-AP STA is associated.
  *
+ * @NL80211_ATTR_KEY_KCK: (Binary) Key Confirmation Key (KCK);
+ *	This attribute is used with %NL80211_CMD_AUTHENTICATE. In case of the
+ *	Enhanced Privacy Protection Key Exchange (EPPKE) authentication protocol
+ *	as specified in "IEEE P802.11bi/D3.0, 12.16.9", this attribute
+ *	is used for MIC calculation.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3551,6 +3557,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_KEY_PREASSOC,
 
+	NL80211_ATTR_KEY_KCK,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index f297639b916f..d890d0f25191 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -933,6 +933,8 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_BSS_PARAM] = { .type = NLA_FLAG },
 	[NL80211_ATTR_S1G_PRIMARY_2MHZ] = { .type = NLA_FLAG },
 	[NL80211_ATTR_KEY_PREASSOC] = { .type = NLA_FLAG },
+	[NL80211_ATTR_KEY_KCK] = { .type = NLA_BINARY,
+				   .len = WLAN_MAX_KEY_LEN },
 };
 
 /* policy for the key attributes */
@@ -12034,6 +12036,14 @@ static int nl80211_authenticate(struct sk_buff *skb, struct genl_info *info)
 			if (!cfg80211_is_sae_akmp(akm_suite))
 				return -EINVAL;
 		}
+
+		if (auth_trans == 3) {
+			if (!info->attrs[NL80211_ATTR_KEY_KCK])
+				return -EINVAL;
+
+			req.kck_len = nla_len(info->attrs[NL80211_ATTR_KEY_KCK]);
+			req.kck = nla_data(info->attrs[NL80211_ATTR_KEY_KCK]);
+		}
 	}
 
 	local_state_change = !!info->attrs[NL80211_ATTR_LOCAL_STATE_CHANGE];
-- 
2.34.1


