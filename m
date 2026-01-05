Return-Path: <linux-wireless+bounces-30349-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0D7CF2393
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 08:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A7D13026BF3
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 07:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253EB2D839D;
	Mon,  5 Jan 2026 07:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AHcHIR0Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aYjQ1r6U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790E4261393
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 07:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767597930; cv=none; b=FAbjhoQ4Y7RDt8OU24Mr12Se7+170jYW4TW9p9Y4BdXQj4Ee9tSNb1QvY9GGFzBEw0OFOuvHeWcruuaYRIA7QK2HgvqU+q8s9biszwWKkH/HoZdm4+dZol91FakeZpl1qzsbmUErO7Uy7WSGgsvGNaMOmjggBsQ71Xi3KhhKzPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767597930; c=relaxed/simple;
	bh=rbrvRRhzC/Q3YArqhgxjqq3hMIVhdNmnvTX/oILspjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H4Lke/+7gUlHDf4gy6Q/NBENhrVaTFLrarae0Y86qop1psRZQ+lnd2DVf6isTTGZyLd9YpJAXA66O5b57A5P+xImPXLBRBcj25romeCAPXSYzsqKmjXYqWQ6kdJO26D25cWRii6EN4iC6phClZyR/1n23YZfXuGWfUVxzbi/X/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AHcHIR0Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aYjQ1r6U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 605565QS3521074
	for <linux-wireless@vger.kernel.org>; Mon, 5 Jan 2026 07:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=vcGyjPojV48
	aUgyoSvfdJx172wF0m0YonmOBngr/8DU=; b=AHcHIR0ZIoBaGWAWZ3jyU1+Q1mm
	SqBTLVtSm6ibfeA77EFopBgnpO6ij2mFU9bsO1ktPiEDOYTIlXN7ljAaWi0d/wpr
	sfvurDecbjrajIzK8TieS+YjaRtMpY6jpYGSD8a/5u0kAkaZPDXfnu+ty9PsUWzh
	fJ+BD5nMTfaWHsgraRKDKYqilA1B7brN3i18w0bKH6NQ8qTZ2KgOzF/1P94ncmjx
	Gwv7nRT+nPxjdN6fs9QbHijbaw4+HsaDOLgKkebjKiuMaUHe2FJuDG30rL+pxzzV
	aKyP804GEpQtlSfY09AiKjLxTqQx22mNodClQ/T9Ftz7bL0OHYkZecmAZUw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bg6uu8bwn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 05 Jan 2026 07:25:23 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29f2381ea85so306104685ad.0
        for <linux-wireless@vger.kernel.org>; Sun, 04 Jan 2026 23:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767597922; x=1768202722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcGyjPojV48aUgyoSvfdJx172wF0m0YonmOBngr/8DU=;
        b=aYjQ1r6UvLandx/uZPQhuvDcjayOz1OY7n9U4Ce8+WrUqCWGXLKIJhJzZ+5GforLF/
         rXPkFYSL29MOH5ye+QGJn0MFbJBpMFv4BR8aHyLbb6Xd5K7m1l2j29lyU2LIxb8X2TT5
         DuwuUStGU/Cirt010nEJTA20CazT8/9t3+rk7xQQ5Iwapn4UYBsCdea1YN01IiLuGlUV
         /Xi05nxI9/Cm9cFN+PTHIz2eJxaAe2R0qcq0aC9nCTtjjqQ1I1lmlzqceOQwj+3VNxv0
         ommbloDSPa8LBuQWxGa6Dlw+fp9j8QlQY7mtb84PwarvdO5voBqo24aDPCgsXEe2MaZr
         hiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767597922; x=1768202722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vcGyjPojV48aUgyoSvfdJx172wF0m0YonmOBngr/8DU=;
        b=qYgWM9578x0sMVR0xRlPv8jwmKm/xIh4ZT6sgla/wWUBsPaXpAaTxajcgNw/i8QjhR
         uT/DX0Xj/TNacG4e2MmDTMmlmUMR5k+5JQGqM/R291zEHYr0EHzg0bGj6BNHrHHNpvly
         qW+wSC8h7/+J56Md9Y/t9faB6QV8EYPtc28UW9BaBwgGq+WZ2TokD1ln394jqhmwZsK8
         JKiAvPmeIFmIcEe2olXKNehRM9BJIqhGnpv8jXgN3rKFE60C+uEJo2BXtWU7GF3ei+XC
         pkmTmIwGpcu217kJWSMcnFo8my1o4Kmhzu9ZJfPSS/aApzP2NzepBejwO5z5f7nfuEmF
         U4bQ==
X-Gm-Message-State: AOJu0Yxeq9qlwlCM8BwIHUjoBVZkZSWzfIUNOVuD5GoawVGiwEw3xPbm
	85tgOim4ipQmDMXNWhXAVq9YOanDyTw7jGEAKfbj+UpLdDddXgv9g/WOgQAnbc6xOr2K44GQ+mY
	1o9x6r8RYXOWA3NXaj1nm6Cz5zgf2VzE9sx0FFdt4D3+1iL6r/5AaRv3tBEkacwb1wAmfqg==
X-Gm-Gg: AY/fxX4OhMr5uoz7ZOvJKluSbldw9N6JwD5Wh/3HmClA6V4kCYoEZ/+dVvT0GFv9g8B
	waRNxKRk/7oVcn+IiANB8SwtSykfVMBiEJ5iLgHDb41/y4M30uC2R8F547unYEV5wjZrsT/dq2U
	cLs4Bjrga7TFsAqxGUtcZdDRXTjTiXX+wy6E6lTk34La6pIO0TYDEj124bKAhC8kAC1MN+Gdk3E
	l/Ct7Mm3EpnVdQNSZUp7k5wJz2ZbeWOxtpuS3QT57qWq195LWix5MfowafjJP8JpohgvDyblbF+
	+gYP6SwObM8VfV6LsU4CHn6bkrrdCakU+yAJgCW6bXIj6i9jmTLXqoaviWsiSS6l8sHOoiZwr0/
	3pzRwvPzBcNIFcduRTsrPzCyBn1ul4xpwUuY2GCxG1Q==
X-Received: by 2002:a17:902:f78d:b0:2a0:c35c:572e with SMTP id d9443c01a7336-2a2f2836480mr495346015ad.30.1767597922064;
        Sun, 04 Jan 2026 23:25:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEixixmSs9go/wlTU7BhVWwuvDvfXFGsscFGDUXlH2/MIUB9hbj6woBHtbH1n6qI1yYocnRPg==
X-Received: by 2002:a17:902:f78d:b0:2a0:c35c:572e with SMTP id d9443c01a7336-2a2f2836480mr495345795ad.30.1767597921570;
        Sun, 04 Jan 2026 23:25:21 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c83325sm445201205ad.34.2026.01.04.23.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 23:25:21 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v2 7/9] wifi: mac80211: add support for EPPKE authentication protocol in non-AP STA mode
Date: Mon,  5 Jan 2026 12:54:13 +0530
Message-Id: <20260105072415.3472165-8-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260105072415.3472165-1-kavita.kavita@oss.qualcomm.com>
References: <20260105072415.3472165-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA2NiBTYWx0ZWRfX5PYEetTJ14kO
 qP/cmI4tISYNh0Y5lmv1rxfG6gqpPeNUVUglWL+u9GpjGcJ/S72x+g2aFdB+by6zMCRg6K9Dbil
 O9X7AmPEoEzFRsMCv6aTAMlpBOcW0qkuzk6uOiDd2/QVIBpZY8AnRgzku+Mdi1oy0nIgLl0Wy0S
 Dnc5KhVO2xeudYjorHWsUn6/6bjKX9hZ14zoAJqemOMAhDAZhcM5bktyMKLbgwnf6sCqD4jnnEj
 wpw7O+fL8v26BXdOuHcQhOixv/56if9KsYnyAyNv/d0hxEZnx1A0STTCFvMsbkScWLYDEaKvpdQ
 MyNovS3GMI9ZunL5cwPgaGd2V/Ns0CB7JHWYt+v63P/pWLObiYTgLU9vDwFTQaXDh9QtVvEu3W2
 S62kUzT+FBgImxRkHDv5qfDm7ziQjUFhYy2AETko2ESZYQnm7KaFiASOXcx4rtEF4arezhPXiHP
 /6/FRsucKEnFiXuTofw==
X-Authority-Analysis: v=2.4 cv=eZ8wvrEH c=1 sm=1 tr=0 ts=695b6763 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=UINr_V146bfacmMmwVQA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 5InP0Le9735z9-peg5I04TVDMR4q8eV9
X-Proofpoint-ORIG-GUID: 5InP0Le9735z9-peg5I04TVDMR4q8eV9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050066

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
in the Authentication frame body by userspace. If the MLE is not
present, reject the Authentication frame.

Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 net/mac80211/ieee80211_i.h |  2 +-
 net/mac80211/mlme.c        | 25 +++++++++++++++++++------
 net/mac80211/util.c        |  3 +++
 3 files changed, 23 insertions(+), 7 deletions(-)

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
index cfb87ae81bb8..4f3ef3d3d4ec 100644
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
@@ -8305,9 +8306,12 @@ static int ieee80211_auth(struct ieee80211_sub_if_data *sdata)
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
@@ -9222,6 +9226,9 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 	case NL80211_AUTHTYPE_FILS_PK:
 		auth_alg = WLAN_AUTH_FILS_PK;
 		break;
+	case NL80211_AUTHTYPE_EPPKE:
+		auth_alg = WLAN_AUTH_EPPKE;
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -9246,12 +9253,14 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
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
@@ -9302,7 +9311,11 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
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
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 3dc712bad8f7..d1eb55d8854b 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1103,6 +1103,9 @@ void ieee80211_send_auth(struct ieee80211_sub_if_data *sdata,
 		   !cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_MULTI_LINK,
 					   extra, extra_len));
 
+	if (auth_alg == WLAN_AUTH_EPPKE && add_mle)
+		return;
+
 	/* 24 + 6 = header + auth_algo + auth_transaction + status_code */
 	skb = dev_alloc_skb(local->hw.extra_tx_headroom + IEEE80211_WEP_IV_LEN +
 			    24 + 6 + extra_len + IEEE80211_WEP_ICV_LEN +
-- 
2.34.1


