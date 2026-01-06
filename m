Return-Path: <linux-wireless+bounces-30408-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FB5CF9162
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 16:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1854830AB965
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 15:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB41A314A8E;
	Tue,  6 Jan 2026 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l2ZmllX5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bbHBVVKi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B861345741
	for <linux-wireless@vger.kernel.org>; Tue,  6 Jan 2026 15:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767713134; cv=none; b=ICJUFQRyn59n8SMsc1IzRcfQ9OIDrcLwz47/pNH0qUKaahLP+ZEL6CTG5Gz+xQap7qV916Akx0NuwaZNH1YEq4rGb/MTjYFIkU21iURSDgmrMdP3SF7912N7uKUQfiyIsx9xs6zpDndOYS2IohCSVWcKYV4VWFs8uXM/g6QQJTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767713134; c=relaxed/simple;
	bh=npYVMjK3jf1qVUxmD0lj1Xn0UUQCRJJWi4oVEzh4HT4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TSH/87E62nY7E/qW5Z+TT/NVo5dowBOlvh1ENLYq41627y1AiReQ04aioGYRkp05GDZ8VNawzSZK0qZXKdiginyNMFSNthE0dY5yfE/2FaMANqhWM/rXUh8t8LLWNDV2Ithp2zPGc0uuC8PWTX2rpHGlxyNnExGzZuo3Bc0fDV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l2ZmllX5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bbHBVVKi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606CAI4Y4048975
	for <linux-wireless@vger.kernel.org>; Tue, 6 Jan 2026 15:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=q+6uzRX9yuH
	DCrtURLaYJ1HgosnTvZ8ROlfCIwvhuEM=; b=l2ZmllX5UfLYQ+Dx1WMMkpAJPG5
	oq90lEJLvbqi6OlkmL6TmWC9DaYqpLUduDt4HvEJd0Ar89tidzQUI4mcfIyHofEh
	lFjZAyEdfSPynt/4RCmzq+4wFMtQHCanYgbtQBfbnVMP0zcU/LwcIO9TWW5S59Kr
	dbqjxBa5Iy+zcKyQcmrTxeQbP6k2XsDvvEqwaWZWaL5yOXt1Sy8asO86WJ8B5NgL
	fwivRkS2jidfp9t3sJWOO7aKhtLIlcMRym/YIHPRJDqUCfHVoGufzEB+XrrhOueS
	9QO4tAZEFhD3fb4V5fydua0WNihjeIMpVVgzBXRXQtUjruW9kxsU7aMFAdA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bh25rrj4c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 15:25:32 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a377e15716so26887945ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 07:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767713132; x=1768317932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+6uzRX9yuHDCrtURLaYJ1HgosnTvZ8ROlfCIwvhuEM=;
        b=bbHBVVKi2aYKkCtoJNrcejrM8yyQikgVVS9CZA4/kIsVNywn6CJI5E84Glf0D3SDVr
         IfpuQUcKdayJLWBPucky75VDp8/UDagc/BooJV6PbRWhmaBGvLd9NrG4egUSjiI4zy0G
         U2NqzuuUTt3O5oF5gb2wxcne/kWJ6Jn2JP1TGLDtSnjszEI56XRnjRhBU4K1DZT5xgN9
         2TDcMhNUwx0Ty9kFEU49z0Qk0B5CUZttT/gQj+luAqxZulB70wvbSu+WnVMhYh42IO8W
         SFJE42HNt4zU/y0eCK21QYcSsAuhb/uINHuiQnqdJaKF9KdJtW3JPk760HMLL9StCDat
         v33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767713132; x=1768317932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q+6uzRX9yuHDCrtURLaYJ1HgosnTvZ8ROlfCIwvhuEM=;
        b=Do4+Y00HzYtzJ5rp7nv3DSuYboE9jB8UQI1FAWgD2MwvygHYJjrpFgp9SnOPMmS2hf
         /NkAz3JObOiXmcFL4Ngf41lp/3V1tGnsSeFKf13FhzVwvp5/Yt79Mm1XYEHXQXwf8jkH
         wKaOVNPHFWyY9gN2ynVoWT064bdsz+eDDjE11RPmptSeAjE2CVraM0GSzI8LFiHNSEon
         IZaPg1+ZUMItpcH6Z1Cc1caTb/MnP70qlfbUs3LU50Cx2IaWTC53YSBxYprsUlnQFTWX
         +hyCgIiUqk2Cwi9ehAdkpQ1sSguqBYesnOjN5kduB1leQ0WN+IUDwMNdixsUwJKB8fjB
         Jfpw==
X-Gm-Message-State: AOJu0Yw+AGFTulBG/UWG8bkGstw9ww9O6kHoS/HPjdlgbxmnHrfF3C5D
	Gs6c9wd3d4qIDrEwJ5ta0JYuv5jFw2LAF9D0q3Sn5QW5as9u1A/YauwUNk94+93FVQ+qrTyI/7w
	KkQJzmkwAxb6jrdQeIE8hk+xPho5YCaUhxa4ItDi9kaSeNr0leZF7w6PxQu6MRdkbDzP93Q==
X-Gm-Gg: AY/fxX5EGHdKx1CPnO9mpTJYx+sCEguwu3n+3LGsYnYVgvhHiN2aryoaT+hennc5Mid
	agccsLJWvNexQhItgzB+hizSN51PLxZGPu0RSxkfKjNX6vlEqk0ILdk7tL+CWk2LnGEQaBtS/MX
	OwtCMxXxfT10isYe7lrPXK6JzFateE3PkQ0b+DPRlocTvW72iAM8beydWObs7+ImXfHMfZw4xL1
	PC6uAENh1z53gq4ltXHO/S9MLjKAGb/gW+3BPO0UwxM++IHiLRFfw0ML5CV0f5Q7/4UxFiYt9Ma
	WTa2zxxeYgzvplIYd73NB2A2vgFepgs0bxdUZiOaBp5zjTIgoG6w4y0DbuSmZazshuVM2jo2VRh
	JTWPVVW1BHeqZWhVwJQG61DiMKVP/5Of8rTpazgOZMw==
X-Received: by 2002:a17:902:e78f:b0:24e:3cf2:2453 with SMTP id d9443c01a7336-2a3e2e43732mr31448845ad.61.1767713131734;
        Tue, 06 Jan 2026 07:25:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjvp0QK4O+v/tvVmfeXU9K7CAfa45bjAxvyADBolQqbB4YtIuH3bfrKilb5KQj+KbYqYjeSA==
X-Received: by 2002:a17:902:e78f:b0:24e:3cf2:2453 with SMTP id d9443c01a7336-2a3e2e43732mr31448525ad.61.1767713131186;
        Tue, 06 Jan 2026 07:25:31 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2ea0sm26343595ad.62.2026.01.06.07.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 07:25:30 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v3 7/9] wifi: mac80211: add support for EPPKE authentication protocol in non-AP STA mode
Date: Tue,  6 Jan 2026 20:55:01 +0530
Message-Id: <20260106152503.223216-8-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260106152503.223216-1-kavita.kavita@oss.qualcomm.com>
References: <20260106152503.223216-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SC62Kci8olGhXQLAmW84ZYZcW2RZRZ71
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEzNCBTYWx0ZWRfX184lqJi3ALom
 0iMEdFcX4A6nSQh/xqXL1a+LlmkC8ZaiHVVAlX8V/8hTWluUiSafcckyxDv1F8RflgxtFHqz4l/
 X6+3lSYI9uv3hrWBWndPwBRFoHX9hu9bC1XyiKf/K3qLLskDgAU9qqd0EC2Pq1UcAh3GLuvJgNZ
 iZ4NacKE0Ucqb1I1r+nh0egHK4oIQ79DAaW8lZTqY3obuFsO9U0Q4WMskJM/fd42CPKH6Ne1TFK
 oQnQKslNjr0SQMMwSRc8q1oCLCBvWtRKAd7upnasbz88qJDrRurc4l3niYUdHZQbT/xCWBqy3Ot
 d/pxLPNwWMmbMB4J49N9kytL6LT0DikLsd+cbEs1bXyMFM2AAnkZUkhvDtQo1drQFWAEoB3wzzg
 V7jobaCWNFRHx7DEXQouh3UbPmIch0b/3Pac+oTxzspGd4TH1wqhY9n9VDu/+jnkjrLQi8jYoSR
 iLBS+Q8s2Lej1l7FHmQ==
X-Proofpoint-ORIG-GUID: SC62Kci8olGhXQLAmW84ZYZcW2RZRZ71
X-Authority-Analysis: v=2.4 cv=G48R0tk5 c=1 sm=1 tr=0 ts=695d296c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=UINr_V146bfacmMmwVQA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060134

Add support for the Enhanced Privacy Protection Key Exchange (EPPKE)
authentication protocol in non-AP STA mode, as specified in
"IEEE P802.11bi/D3.0, 12.16.9".

EPPKE is an RSNA authentication protocol that operates using
Pre-Association Security Negotiation (PASN) procedures. It consists
of three Authentication frames with transaction sequence numbers 1, 2,
and 3. The first and third from the non-AP STA and the second from the
AP STA.

Extend mac80211 to process EPPKE Authentication frames during the
authentication phase. Currently, mac80211 processes only frames with
the expected transaction number. In the case of EPPKE, process the
Authentication frame from the AP only if the transaction number matches
the expected value, which is 2.

After receiving the final Authentication frame with transaction number 3
from the non-AP STA, it indicates that both the non-AP STA and the AP
confirm there are no issues with authentication. Since this is the final
confirmation frame to send out, mark the state as authenticated in
mac80211.

For EPPKE authentication, the Multi-Link element (MLE) must be included
in the Authentication frame body by userspace in case of MLO connection.
If the MLE is not present, reject the Authentication frame.

Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 net/mac80211/ieee80211_i.h |  2 +-
 net/mac80211/mlme.c        | 31 +++++++++++++++++++++++++------
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 9d9313eee59f..50fd5e83ed6d 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -430,7 +430,7 @@ struct ieee80211_mgd_auth_data {
 
 	u8 ap_addr[ETH_ALEN] __aligned(2);
 
-	u16 sae_trans, sae_status;
+	u16 trans, status;
 	size_t data_len;
 	u8 data[];
 };
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index cfb87ae81bb8..54d088623b1f 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4911,6 +4911,7 @@ static void ieee80211_rx_mgmt_auth(struct ieee80211_sub_if_data *sdata,
 	case WLAN_AUTH_FILS_SK:
 	case WLAN_AUTH_FILS_SK_PFS:
 	case WLAN_AUTH_FILS_PK:
+	case WLAN_AUTH_EPPKE:
 		break;
 	case WLAN_AUTH_SHARED_KEY:
 		if (ifmgd->auth_data->expected_transaction != 4) {
@@ -8277,6 +8278,12 @@ static int ieee80211_auth(struct ieee80211_sub_if_data *sdata)
 	if (WARN_ON_ONCE(!auth_data))
 		return -EINVAL;
 
+	if (auth_data->algorithm  == WLAN_AUTH_EPPKE &&
+	    ieee80211_vif_is_mld(&sdata->vif) &&
+	    !cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_MULTI_LINK,
+				    auth_data->data, auth_data->data_len))
+		return -EINVAL;
+
 	auth_data->tries++;
 
 	if (auth_data->tries > IEEE80211_AUTH_MAX_TRIES) {
@@ -8305,9 +8312,12 @@ static int ieee80211_auth(struct ieee80211_sub_if_data *sdata)
 	auth_data->expected_transaction = 2;
 
 	if (auth_data->algorithm == WLAN_AUTH_SAE) {
-		trans = auth_data->sae_trans;
-		status = auth_data->sae_status;
+		trans = auth_data->trans;
+		status = auth_data->status;
 		auth_data->expected_transaction = trans;
+	} else if (auth_data->algorithm == WLAN_AUTH_EPPKE) {
+		trans = auth_data->trans;
+		status = auth_data->status;
 	}
 
 	if (ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS))
@@ -9222,6 +9232,9 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 	case NL80211_AUTHTYPE_FILS_PK:
 		auth_alg = WLAN_AUTH_FILS_PK;
 		break;
+	case NL80211_AUTHTYPE_EPPKE:
+		auth_alg = WLAN_AUTH_EPPKE;
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -9246,12 +9259,14 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 	auth_data->link_id = req->link_id;
 
 	if (req->auth_data_len >= 4) {
-		if (req->auth_type == NL80211_AUTHTYPE_SAE) {
+		if (req->auth_type == NL80211_AUTHTYPE_SAE ||
+		    req->auth_type == NL80211_AUTHTYPE_EPPKE) {
 			__le16 *pos = (__le16 *) req->auth_data;
 
-			auth_data->sae_trans = le16_to_cpu(pos[0]);
-			auth_data->sae_status = le16_to_cpu(pos[1]);
+			auth_data->trans = le16_to_cpu(pos[0]);
+			auth_data->status = le16_to_cpu(pos[1]);
 		}
+
 		memcpy(auth_data->data, req->auth_data + 4,
 		       req->auth_data_len - 4);
 		auth_data->data_len += req->auth_data_len - 4;
@@ -9302,7 +9317,11 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 	 * out SAE Confirm.
 	 */
 	if (cont_auth && req->auth_type == NL80211_AUTHTYPE_SAE &&
-	    auth_data->peer_confirmed && auth_data->sae_trans == 2)
+	    auth_data->peer_confirmed && auth_data->trans == 2)
+		ieee80211_mark_sta_auth(sdata);
+
+	if (cont_auth && req->auth_type == NL80211_AUTHTYPE_EPPKE &&
+	    auth_data->trans == 3)
 		ieee80211_mark_sta_auth(sdata);
 
 	if (ifmgd->associated) {
-- 
2.34.1


