Return-Path: <linux-wireless+bounces-23358-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFE3AC2246
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 13:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C701BC1F8A
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 11:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1D21EE02F;
	Fri, 23 May 2025 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SGA0Y2ij"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6945D8F0
	for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 11:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748001542; cv=none; b=mQ6Y3X/IkmUkWyaAeuD1rDuuVLfRU+IJLJ8D+73bmlM99BwAKlKqkhY9S2iWqEluAP5OX15tVO7BeZMSpxAE+3cQcU/cLadjRujAj1r2wQuYGEMylM7xtrqACQojOLgGeI0yF9JA9uFftNJ5E/1IdMdJbTTzA7u5o/ytgd5VBh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748001542; c=relaxed/simple;
	bh=tg9Z2/C7Cvlvx0J305uqJ8kQlYGc9SuOKtHSzPFzmPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=vDAW/dkT+e5H0F++wniVUYDiiaEXctJ54OKc9xMyw5DB/IreAo1OxJJQIP9/MuY3I5N/cw4Y7GJDX6hmUIq5i+LkkQRLQLOhc/heqJeXCfRGpzNcXOkTQGvuk/yyh1RkLFg5zY55FHIXpPKxKX1DuTTob6pbig5hwIZDIlaD/lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SGA0Y2ij; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54N7mrtD003269
	for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 11:59:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=Qq51XT7YYtig8sR6o9TZUSlLWr6Yl9WicUlD2R+enF8=; b=SG
	A0Y2ijrt4V15gz+NikM5qcaRxE3EeWHOSoRpnXfONZC7j/XNdalpGicZhzzc2xpa
	WAmPDvRzJIwccrhdroqbUWIyuciERTYJmMvHia1MA2OhLq4BJsqYswYEbN1omfwz
	eZzxX9hLgma1AOmyvUt8BGQ9yJOBsfwiQqOfaqDG/NvD5vKbPDnV0StL2AFKDQH6
	9eineyr68Qu43vMqIx9n6lHA0XnJirrUvbXBIwOa+OlMYSCcefnvfQlWFAS6r67J
	gkly6AtmJVkEV9V34iAI1ceNHw5fsK/+hQXmzh1PSZlGzswOtDvdgx2+S3dqFItB
	MwoESFTlEj7E0DblUu4g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf0a2ha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 11:59:00 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2321215e4c1so8966895ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 04:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748001539; x=1748606339;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qq51XT7YYtig8sR6o9TZUSlLWr6Yl9WicUlD2R+enF8=;
        b=YuVa3rxWD6hdMnkn+NGh+M0bok4mQTmh2BRRSx52Xrq5cAG+KF3PmkdqN9vpC007Is
         6UyPkp9QQtjRDgn2A8upSV+N8j4w/j0GpWLz/xp5JkXLwlrvWUde3/qwzjxzAK94iQUJ
         Xqxcyp0nTmlz2LjmxT+4MTnv7lc+D3t9nS3SgN8BpQWKsHOdQEbVBMEOOK7+SyJf6eGD
         PPQhWsmw/D7OTYimRmfEYrypeDU1NPZgU44MdIHUj6AxcIp8MhCmEpkNNNREVN03DlF/
         t93cvfp57HZGlNr3ngQpd5UieGVu8BJ66N/91SiZPOclLg4kr8Z8GzpNpDkydCmK7Ub0
         3dYg==
X-Gm-Message-State: AOJu0YzoWAgSHy/1nfWzjikK4HrcGDTf9+LIS0dsQ9HHe3CxcfYDrYRv
	FtDIbdj9cr1toxJJfNwfMT6Sl8ZXBmW0yriFP/tNibVDfgjbS7XMCIwStrgtmjag2XAuFrV2OVQ
	SfDtr8r6BZD9xiE+AwPFrzjvffHPATCPL5aO3N5yimEdsq8MbrEO0hIvfd8kzX+Ai915LHg==
X-Gm-Gg: ASbGnctuqiEYzCu+NWFe53kYO9e+/ry1GOldiP2+Go8UOvJpsMZA3XLaWrztBYirwNU
	n3fyzIOMgedJ0DOv6R4UfShGE5SJ6AlC8oPiEFH47Z5L44aPSJrnwRg19KIMVpdhY8gVAyrHb62
	ad3RxhgGfLVR52vOKc/0uO+1ymwG1UrYx1DDnui9DMya7H0ErVVRlvPDPa+V9IxzO2L2KH/1MWA
	C84OdDTBaQ+jn9tWTisa1YC5uEThaahtKlhpBiqZouvMdtzMZIPMJX2v7WvLtBbs/YKjvrnqrXs
	3j16wHvBRxndDpgjuVehkZmhw9WeX3ahv+IhO0nPM4Yc9EA45L9kp1rIV8ERMN+WkmtOcquQGqn
	gnbZhA+Pops45373TyOrI6knVUsW7eMvaavDaXh5htJfFxg==
X-Received: by 2002:a17:902:da88:b0:215:a56f:1e50 with SMTP id d9443c01a7336-233f0671694mr50435885ad.8.1748001539235;
        Fri, 23 May 2025 04:58:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoGu0ITV+RzVbqTlbHTMQYU04CL82KgiCWrNEupxYn1CXXxlVYtS/NEpIWCA4mbtfJjScxjg==
X-Received: by 2002:a17:902:da88:b0:215:a56f:1e50 with SMTP id d9443c01a7336-233f0671694mr50435575ad.8.1748001538812;
        Fri, 23 May 2025 04:58:58 -0700 (PDT)
Received: from che-siroccolnx03.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-233f9e17e3csm7210725ad.177.2025.05.23.04.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 04:58:58 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH wireless-next v3 2/2] wifi: mac80211: process group addressed Rx data and mgmt packets on intended interface
Date: Fri, 23 May 2025 17:28:38 +0530
Message-Id: <20250523115838.481402-3-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250523115838.481402-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20250523115838.481402-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Proofpoint-GUID: SF7gb7XGxQ8iPTPLU8vv8n7xeo3BmnvO
X-Proofpoint-ORIG-GUID: SF7gb7XGxQ8iPTPLU8vv8n7xeo3BmnvO
X-Authority-Analysis: v=2.4 cv=ZP3XmW7b c=1 sm=1 tr=0 ts=68306304 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=Y7y7kotgnV_wd4PCqGcA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEwNSBTYWx0ZWRfX8dN4VJRXrqwy
 fZ+b2FAJzTt0N27WYFDbcPWzG4Iaz+6zOyQy1bvwEtiD9h7uY7vGH4Xv/ZAUMjbib47FX0Z6CWf
 d3vjdTyheitlelucSASFy/UXgXwrOGVsMn0wUP73aHlUi4DQZ1/6CdQbYJWeFTMki/1TcXPSf30
 uEqd4lyiC8P7aPs85eRMas1JLE2mIvm91p67bG/pPMAjZTqRVp3Do0G2YJfvxZY8u6gqEIsBNvt
 Qpqap2+6MOAtI5LH/XhUTlJD3ErTGhIB9CJEI6j1TX4CVYtO/6qaXeXQ3snzLDoz6rIcWHTMckr
 PznMvTlTvLX0hCV4RHOuf6Q8iAeH23RGJmLLCI0at2+ee70e9bWQXj5e77XiQnXzS+zY0gortXJ
 uaYQLc6GpAfRZxJFjkWdgrxR+AQxn9d9GtM/txBWcZpcJsyKKz2gPI7oI+GttwJqAaWKdYBV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_03,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 impostorscore=0 phishscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505230105
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Currently, in multi-radio devices, group-addressed data and management
frames received on one band are getting processed on an interface running
on a different band. This occurs because these frames do not have the
destination station information, unlike unicast Rx frame processing where
the transmitting station is known.

There is no check to ensure that the sdata is running on the same band as
the frames are received on before processing those frames.

Fix this by checking the operating frequency of the interface against the
frequency of the packets received before forwarding them to the interface
in multi-radio devices.

The current behavior is retained as a fallback mechanism when the frequency
is not reported by the drivers.

Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
---
 net/mac80211/rx.c | 48 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 09beb65d6108..59028c08dd52 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -5125,6 +5125,30 @@ static bool ieee80211_rx_for_interface(struct ieee80211_rx_data *rx,
 	return ieee80211_prepare_and_rx_handle(rx, skb, consume);
 }
 
+static bool
+ieee80211_rx_is_sdata_match(struct ieee80211_sub_if_data *sdata,
+			    int freq)
+{
+	struct ieee80211_link_data *link;
+	struct ieee80211_bss_conf *bss_conf;
+	struct ieee80211_chanctx_conf *conf;
+
+	if (!freq)
+		return true;
+
+	for_each_link_data(sdata, link) {
+		bss_conf = link->conf;
+		if (!bss_conf)
+			continue;
+		conf = rcu_dereference(bss_conf->chanctx_conf);
+		if (conf && conf->def.chan &&
+		    conf->def.chan->center_freq == freq)
+			return true;
+	}
+
+	return false;
+}
+
 /*
  * This is the actual Rx frames handler. as it belongs to Rx path it must
  * be called with rcu_read_lock protection.
@@ -5264,18 +5288,26 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 		 * the loop to avoid copying the SKB once too much
 		 */
 
-		if (!prev) {
-			prev = sdata;
-			continue;
-		}
+		/* Process the group addressed management and data packets
+		 * in the intended interface when the operating frequency
+		 * matches with rx_status->freq in multi-radio devices.
+		 * If rx_status->freq is not set by the driver, then
+		 * follow the existing code flow.
+		 */
 
-		rx.sdata = prev;
-		ieee80211_rx_for_interface(&rx, skb, false);
+		if (ieee80211_rx_is_sdata_match(sdata, status->freq)) {
+			if (!prev) {
+				prev = sdata;
+				continue;
+			}
 
-		prev = sdata;
+			rx.sdata = prev;
+			ieee80211_rx_for_interface(&rx, skb, false);
+			prev = sdata;
+		}
 	}
 
-	if (prev) {
+	if (prev && ieee80211_rx_is_sdata_match(prev, status->freq)) {
 		rx.sdata = prev;
 
 		if (ieee80211_rx_for_interface(&rx, skb, true))
-- 
2.17.1


