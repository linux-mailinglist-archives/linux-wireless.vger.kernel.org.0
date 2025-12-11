Return-Path: <linux-wireless+bounces-29660-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF82ECB5E97
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 13:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 152D230454F5
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 12:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72413101C4;
	Thu, 11 Dec 2025 12:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G8GmhhkC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B14KD6Yn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A45230FF36
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765456895; cv=none; b=sLWMfBCSv1HjWfMGTAq8CHdZYOmGenTBmbyXlsdBnL/pGrq6Q2FzXIUUziJi/RRfYHi36qFQbAOoJMOVKGyeUcr5raHww4xnfEz5FJPkzpixqD8VY7R6LACOHk8ku1jTfADs6KNqwHFZcUtZ1r946Chh67ynV9mf16WHHuxfJWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765456895; c=relaxed/simple;
	bh=4GhtPuK7cC/qUcksmwO6jr/+SCsnUNuvBuX9Z2BMhtA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fLxyDNNpOeCli/Yr/74RFEYbnNCnA5S4Kbhi5rCJ94FtvIV+VzbrG84zCJ586ad5aAxfV/BnRLNWO5yV4Ym4YchSvvVakyAsHLoEGOwtPAHjv+0mPhTMFP/sjLK39O23ehvzlaaHvsZ01EsS/7eLJM/Z7pMN1MB8uchLmbKL3RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G8GmhhkC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B14KD6Yn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBAXqxY1597496
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zIwwt70/vvI39gR2XT26otoU/wiaAbg9/IKfn9T2Moc=; b=G8GmhhkCX5ah9RzI
	2gUizCSrCZ81vOp49AZnUwHZfHyBwbmCTs64S6hSU9tTR3Zhr1Q92ooGHSXE9gXW
	UrqMTRxeyawkxBe5y34B5upHDwKXXdPP+89KPARgNOGBMwom6EVmi6OA+9K09fhj
	jWGN5EjeRs9vSwlVRSbKsUG8VLaR85UquYrhAuQHPktm27xAw5OqCng3Vwj+Yem4
	/k9GObmsuRyBL2L7SLQ8SbdB5NFtdv0bTI0y/GiSACTEmmly1iRTZcHTX86dQV8J
	ztTiMDFrW6wR0+7GcPEQvUAp+EMVzB1yt9u8Ete+17a2T+XxvRtFpJgwx0q9iFBt
	5oC3Eg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aybhpbmqj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:29 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34a49cc88dcso10072a91.0
        for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 04:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765456889; x=1766061689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIwwt70/vvI39gR2XT26otoU/wiaAbg9/IKfn9T2Moc=;
        b=B14KD6YnW5H+5c3pXmZiM59x4Nv/bBFoN1agBgM7mVO4iMhHgT6iUnw9ALMoGd6kb2
         xMWazgMis91/QSh0uo94zFZzasFYjVxcCVa4awDHWvxlQ0aUHwATfnHKAtGwDw5mMcve
         1O1t5CRB3mBTUiHhq6v/6y/stmKkTn7LZfZKb9aEOG3xBgQ+AFYtwkAx3CfXDuUoikkb
         8g2BTQkX6LGuGKwBrLdfLiUAX6BB7Hw9F04rcpgiJPUYMhUA5F3GObwt1RCKMbRO9z5J
         +GKF35ReWuKh4TwIB+uwfeBW1Kg9n7rzgPAgop3KARFkS5Tcj/HCewWX1I6zXQ7dHDue
         KQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765456889; x=1766061689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zIwwt70/vvI39gR2XT26otoU/wiaAbg9/IKfn9T2Moc=;
        b=TMVlRWjwv1neMenqAqDwjJjNmw7w+JIOGS2pTOrKbnuheLhb8BCUFiueyrktbnH6by
         7Br2C9HumIESOm7XhYxmdYlV/ElYqjCSqgvLL0Okuug8M55UL4TQkGNnfQ6eycDEmS42
         sbTnnZa1AVAroRTk/puNUX+5zEE0Q0vOVCN4XbytHhUgrtoBj2Pi+Q21ft0L+fv+B0ad
         Cg87ozs4KZoA96IsHG0AFTIDXGAfgeQ8E6t7qzPALbyMrBC/GqAwyrjPVL8cV54bq+dx
         4aBylZo882dD71c9pK2ma7uRfQH3ogcwiTQltgAmu2VfGWTubQzdUTtV+GsZigcDhzGJ
         dthA==
X-Gm-Message-State: AOJu0Yy1N7Ahix+jxtfzQEl062mDCHDbsM5tAI5yH8dLudYZnixO6Tkl
	2xC0+9qzdKE+TJpn1/wr7zJe2QbCOyRwwHCBobWPBsrDJEEDoB0zjdFMcP2aVyF4y+ozYH7U3XZ
	0y/m1QGKMndbWc9s9igHYWdqauaLz8fPeodkoKDV1CXvLWjKzH7BK5pHJaA/e+wO43C2jAg==
X-Gm-Gg: AY/fxX6ztfGg9dUyMdK8XBZxwdx6a5vvq0wriDoozeCUwV/dEPKFv06Svk10iZL0Vxr
	Dj9rfEisSKmISu7E+VVvWRqzi6xJj7HG0k7nnWPNTrOTSK4X11FO7pbaDv/c73bo/dAM0GLkmMk
	vDEWeOhnbpFpht5gt4n+VyNSCQB8PF5MNttd7STzpGnXRZ8BjLGHwe8pyh+tw4tGZv5BAnIRqRd
	HFYTkoYZxhHFjiAw6FrBLBWXUs4SGb1WtOeO8xjLqVHQe6P7ePuLQ13evPopdvG0VAS9U2hMSNw
	qYRZhaHZwKxqwOSo+yj8A7bRC17sXqyBi/cm62lLA0TirRh9snNyIzf9nneyJE/OiteW1giJpGO
	p2sXrrDifa1ew1DnQTzSurQBnpClCfWi88DXxaOj84g==
X-Received: by 2002:a17:90b:510f:b0:343:747e:2ca4 with SMTP id 98e67ed59e1d1-34a928461d4mr1830376a91.9.1765456888948;
        Thu, 11 Dec 2025 04:41:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+ioZfDig4X/NgVPo0OW4BJmHTakcyQyR8h5MbGOp1zrcITd8X1GbR8RokfxTwK6Q4ITdk2A==
X-Received: by 2002:a17:90b:510f:b0:343:747e:2ca4 with SMTP id 98e67ed59e1d1-34a928461d4mr1830361a91.9.1765456888463;
        Thu, 11 Dec 2025 04:41:28 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2ae4e163sm2272297a12.20.2025.12.11.04.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 04:41:28 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next 06/14] =?UTF-8?q?wifi:=20mac80211:=20add=20s?= =?UTF-8?q?upport=20for=20EPPKE=20authentication=20protocol=20in=20non?= =?UTF-8?q?=E2=80=91AP=20STA=20mode?=
Date: Thu, 11 Dec 2025 18:10:43 +0530
Message-Id: <20251211124051.3094878-7-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
References: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDA5OSBTYWx0ZWRfX+foiOgJLbH7w
 j/Ld+9Mgl+hbg02AjwzX2ifBUxIoJO53kZYdtIj8lD5VM/HA0dvQQQtaGRY+SBQUL5upJ/3wlx1
 WVvAujydUjYqLRmGw3pHfdisA5758B+NCv0rfxzbsB8doaQ+3oitZ/C7TG9WeWAoWJkKhc9DSOx
 2racFMNfvDFw9tS9dd4fl8cKIepnjYgejP+FSHxx0I8CycTNIEKVIUkxbXLp8jtiYUa9ihYqoAF
 mLTdg5qPmNgojnCqlYtYCLpm2EKsr/Vl4paBZqcr4Dd1UPONCZWpwOXuqvow0nYl6vhz83E55V/
 e1BA5CT2+oNS7ttomvdtGJIfxjX8NWOPwa9MIy0NRnPFgIxuXPxRh7DRQQbihXjL/YSEr/aI2O6
 HCZ0NyyuFp+qWqci4KfK/Uv4+9jdow==
X-Proofpoint-ORIG-GUID: x6EzIPpvAAKl7EjAKMPa50fLwqhGKlrY
X-Proofpoint-GUID: x6EzIPpvAAKl7EjAKMPa50fLwqhGKlrY
X-Authority-Analysis: v=2.4 cv=LJ9rgZW9 c=1 sm=1 tr=0 ts=693abbf9 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=5KLPUuaC_9wA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=fZ45S7WUne2r9gDRtxoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_01,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512110099

Add support for the Enhanced Privacy Protection Key Exchange (EPPKE)
authentication protocol in non‑AP STA mode, as specified in
"IEEE P802.11bi/D3.0, 12.16.9".

EPPKE is an RSNA authentication protocol that operates using
Pre‑Association Security Negotiation (PASN) procedures. It consists
of three Authentication frames with transaction sequence numbers 1, 2,
and 3. The first and third from the non-AP STA and the second from the
AP STA.

Extend mac80211 to process EPPKE Authentication frames during the
authentication phase. Currently, mac80211 processes only frames with
the expected transaction number. In the case of EPPKE, process the
Authentication frame from the AP only if the transaction number matches
the expected value, which is 2.

After receiving the final Authentication frame with transaction number 3
from the non‑AP STA, it indicates that both the non‑AP STA and the AP
confirm there are no issues with authentication. Since this is the final
confirmation frame to send out, mark the state as authenticated in
mac80211.

Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 net/mac80211/ieee80211_i.h |  2 +-
 net/mac80211/mlme.c        | 25 +++++++++++++++++++------
 2 files changed, 20 insertions(+), 7 deletions(-)

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
index e56ad4b9330f..cc6bc58b0f1f 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4908,6 +4908,7 @@ static void ieee80211_rx_mgmt_auth(struct ieee80211_sub_if_data *sdata,
 	case WLAN_AUTH_FILS_SK:
 	case WLAN_AUTH_FILS_SK_PFS:
 	case WLAN_AUTH_FILS_PK:
+	case WLAN_AUTH_EPPKE:
 		break;
 	case WLAN_AUTH_SHARED_KEY:
 		if (ifmgd->auth_data->expected_transaction != 4) {
@@ -8302,9 +8303,12 @@ static int ieee80211_auth(struct ieee80211_sub_if_data *sdata)
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
@@ -9215,6 +9219,9 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 	case NL80211_AUTHTYPE_FILS_PK:
 		auth_alg = WLAN_AUTH_FILS_PK;
 		break;
+	case NL80211_AUTHTYPE_EPPKE:
+		auth_alg = WLAN_AUTH_EPPKE;
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -9239,12 +9246,14 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
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
@@ -9295,7 +9304,11 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
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


