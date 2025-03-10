Return-Path: <linux-wireless+bounces-20117-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D48F8A5A452
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 21:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 884503A3045
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 20:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B2D15B971;
	Mon, 10 Mar 2025 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bQkMxjrE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CD71CD205
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 20:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741636968; cv=none; b=KwS/ELgIoR5n/mu6nF/2XTk5gCBAuwIAR8K3sBU7uFfLkUwCUT20BdoSN9htDAFE286jXvpiAgsr6o5bXJvqvcHNunJMzA/b4Zd/RypzpJbY3Ec1DKjSFvE9301LLZ9p9P0TPYVfb+IK38n9ZaSMhwqr42ICih0etx+unvpeX+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741636968; c=relaxed/simple;
	bh=RVdGRhcjf3Ir0WT5VtfPAR24+Tt0G/5RlYlntd0kF4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZtWmhONGdPoGlL/LTiCfOJg82wN0nnTr8GAaPpBOMOY1ebxpfbKcUXLVRXHNnm4QKTCIBl7JuT9XDuTvJ7wdMMWtzz39EZv4CzR2ShmlJHU1iFjboCDuKPywDvg9cySYMchtghgvZA2UideWsxHnNXr8ZHfJlbBv+Z0Vz+Ow/00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bQkMxjrE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AIdV0C025100
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 20:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ocngaqNuTAm
	FDtQ/nMV7R7IQxYddeURnB+NCuAeJxDc=; b=bQkMxjrE+aIY7f5CVBT6y3z8BJV
	baYMO+blcPkp7ZjMK/JeN7e8kjbm7/6MgRQRbx6GAbKmCXa4Nnj4D+fABjvRKZYZ
	al/MRWfRYWkAu56cov6HIVUrPEMKrbeKPpqIRDv7539GN8z2X31B/A7KxkSmjoXQ
	d6o3dTbXhkg+yuNUyfiW+B82K5hxHwe8AssxN/bhwWmja1TMQONPSFrBRiotbPvc
	FVbfh0t1cUgYCDcSIYkMXcuGPn8cCUz7aPUwxyYmIDM0gOq921e+D66LY+K1Xjr+
	QOfWbs28la5WHI4vG895qJQGskZyRt33IXzTWESkT4wN376alX1GE0NSqrg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458ex6x1v7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 20:02:45 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff58318acaso13226878a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 13:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741636964; x=1742241764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocngaqNuTAmFDtQ/nMV7R7IQxYddeURnB+NCuAeJxDc=;
        b=c6DCWdxlMDb4aHkuv4W2+nTThinR3G9kJNa6OBWMWVhXpqrLDzek7GgLoVWhtMqEth
         m9kLtFBNekEaLIPnC2jQpmiO6zUfIp19pdwoW/QPRF9vwgtvckCXtP2AcxzPEPJ+ZTKU
         C95mj3tuCSiEhz8VGRH1sKuxBb1cfXr5bZO9t0A85xqPENkoHiGoj7ZL/FvUNWEWNk94
         wga+gJsiuz2fZi6D1OyZsay+vweOdtg9W8o6rCRlTR1+5sDwE0XxRSTzlzfvwxhhCA0O
         dKK35cFQKl2/GPVP2ca72d3epx40QT1YB/PDSV20iYJlcycPqhpopS+hnWBxXPdGo6jh
         TUlA==
X-Gm-Message-State: AOJu0YxSS2B5SKBZsHYB80YtQ4RBLIKIqYifqDgYIJ+OL0cXiQZQa1T8
	Y6q3nh8AgMfXXJ9RUhf0szQMpcSFdyb04BwkUiSfIskJIkNDGbX6gsOp/QlxzIGrhz2aVrdyu7x
	TMtBViTFjO9Hu+Fo9o8reGtjvna+dN+zMY3y2WyaFivGMAgmEGy9R3kaVl8KCd8MXNg72qhGonQ
	==
X-Gm-Gg: ASbGncsuqLWlRup/5UXB5klHpa9d3sZKDgNhTL/EnONZsB0CVf/gB31i2nmBV3NKdAr
	ZdizDG0j6nmHtMLfOYwLNC3z9cMJqp/89EpT3l8+K1GQ9MLPhwb3lFOz4G6ewhMWqy/vhA5s/dJ
	qB5Apv2Foh491esmniG8bp+wLlexn7dJHaYkuSUHjnosU3G7Om6W7cH7DGhmYRbNVNCrIZ/j7O6
	F+KvybiLDgUE0XqYgB1psDDaWClrad77pzbo5j1Xl6hYaNqXGy37/8t+ZvIfSAB85LWuU6tWmCi
	nGXNbc81Q72Zqlk/HwcaHU5V0XzKjPvgOOjEqOvA6/P45u+S0uCNYGSxS1CbNZYx7AvWnpA=
X-Received: by 2002:a05:6a20:72a5:b0:1f0:e7e2:b295 with SMTP id adf61e73a8af0-1f544acd6a7mr17950239637.5.1741636962024;
        Mon, 10 Mar 2025 13:02:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPVM55Ipm+xg8CMpt0MVYTdLPhq0VahYP883c6p2nk/KwVbYVK9hWRJxAp3Mx4wa3aPTOijw==
X-Received: by 2002:a05:6a20:72a5:b0:1f0:e7e2:b295 with SMTP id adf61e73a8af0-1f544acd6a7mr17950208637.5.1741636961690;
        Mon, 10 Mar 2025 13:02:41 -0700 (PDT)
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736cbe3fb3fsm3730419b3a.83.2025.03.10.13.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 13:02:41 -0700 (PDT)
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
To: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        ath11k@lists.infradead.org
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Muna Sinada <muna.sinada@oss.qualcomm.com>,
        Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Subject: [PATCH v4 1/3] wifi: nl80211: add link id of transmitted profile for MLO MBSSID
Date: Mon, 10 Mar 2025 13:02:35 -0700
Message-Id: <20250310200237.652950-2-aloka.dixit@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310200237.652950-1-aloka.dixit@oss.qualcomm.com>
References: <20250310200237.652950-1-aloka.dixit@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=G8bmE8k5 c=1 sm=1 tr=0 ts=67cf4565 cx=c_pps a=vVfyC5vLCtgYJKYeQD43oA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=diLcHdusufV46o6eeBsA:9 a=N3MwnUSRF2nazewGnDsO:22 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: mT4suaRxNxTlbCjC97sMMDOCm046caMe
X-Proofpoint-ORIG-GUID: mT4suaRxNxTlbCjC97sMMDOCm046caMe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_07,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100155

From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

During non-transmitted (nontx) profile configuration, interface
index of the transmitted (tx) profile is used to retrieve the
wireless device (wdev) associated with it. With MLO, this 'wdev'
may be part of an MLD with more than one link, hence only
interface index is not sufficient anymore to retrieve the correct
tx profile. Add a new attribute to configure link id of tx profile.

Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Co-developed-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
Co-developed-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
---
 include/net/cfg80211.h       |  2 ++
 include/uapi/linux/nl80211.h |  6 ++++++
 net/wireless/nl80211.c       | 14 ++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 6b170a8d086c..0f7a4f410d45 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1286,11 +1286,13 @@ struct cfg80211_crypto_settings {
  * struct cfg80211_mbssid_config - AP settings for multi bssid
  *
  * @tx_wdev: pointer to the transmitted interface in the MBSSID set
+ * @tx_link_id: link ID of the transmitted profile in an MLD, default is 0.
  * @index: index of this AP in the multi bssid group.
  * @ema: set to true if the beacons should be sent out in EMA mode.
  */
 struct cfg80211_mbssid_config {
 	struct wireless_dev *tx_wdev;
+	u8 tx_link_id;
 	u8 index;
 	bool ema;
 };
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 9d8ecf20ef0d..ed2a181a2557 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -8022,6 +8022,11 @@ enum nl80211_sar_specs_attrs {
  *	Setting this flag is permitted only if the driver advertises EMA support
  *	by setting wiphy->ema_max_profile_periodicity to non-zero.
  *
+ * @NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID: Link ID of the transmitted profile.
+ *	This parameter is mandatory if the transmitted profile is part of an MLD
+ *	and the interface getting configured is a non-transmitted profile. For all
+ *	other cases it will be ignored.
+ *
  * @__NL80211_MBSSID_CONFIG_ATTR_LAST: Internal
  * @NL80211_MBSSID_CONFIG_ATTR_MAX: highest attribute
  */
@@ -8033,6 +8038,7 @@ enum nl80211_mbssid_config_attributes {
 	NL80211_MBSSID_CONFIG_ATTR_INDEX,
 	NL80211_MBSSID_CONFIG_ATTR_TX_IFINDEX,
 	NL80211_MBSSID_CONFIG_ATTR_EMA,
+	NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID,
 
 	/* keep last */
 	__NL80211_MBSSID_CONFIG_ATTR_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2c4e06610a79..0ebbce9fbaf4 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -469,6 +469,8 @@ nl80211_mbssid_config_policy[NL80211_MBSSID_CONFIG_ATTR_MAX + 1] = {
 	[NL80211_MBSSID_CONFIG_ATTR_INDEX] = { .type = NLA_U8 },
 	[NL80211_MBSSID_CONFIG_ATTR_TX_IFINDEX] = { .type = NLA_U32 },
 	[NL80211_MBSSID_CONFIG_ATTR_EMA] = { .type = NLA_FLAG },
+	[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID] =
+		NLA_POLICY_MAX(NLA_U8, IEEE80211_MLD_MAX_NUM_LINKS),
 };
 
 static const struct nla_policy
@@ -5561,6 +5563,18 @@ static int nl80211_parse_mbssid_config(struct wiphy *wiphy,
 			}
 
 			config->tx_wdev = tx_netdev->ieee80211_ptr;
+
+			if (config->tx_wdev->valid_links) {
+				if (!tb[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID])
+					return -ENOLINK;
+
+				config->tx_link_id =
+					nla_get_u8(tb[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID]);
+
+				if (!(config->tx_wdev->valid_links &
+				      BIT(config->tx_link_id)))
+					return -ENOLINK;
+			}
 		} else {
 			config->tx_wdev = dev->ieee80211_ptr;
 		}
-- 
2.34.1


