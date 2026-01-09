Return-Path: <linux-wireless+bounces-30587-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 63360D07093
	for <lists+linux-wireless@lfdr.de>; Fri, 09 Jan 2026 04:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55D3A304676F
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jan 2026 03:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8C922652D;
	Fri,  9 Jan 2026 03:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N8MfpHMS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XbCbxUBu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F410C17AE11
	for <linux-wireless@vger.kernel.org>; Fri,  9 Jan 2026 03:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767930562; cv=none; b=rHQZL0LFJhCYILuKBlAaM1zWW59cWiM6YwEpxyV4Hj2RXpaJNE8OANJR5uRTOYJUDYmRoHpobD0pl31cu7k1LrNu/62v9ulIQDXmTqzVxCQiAWyXJEObKwrn9IvopPB9HXiPSD9tA0P4dgF9tXukypIQ80gBGiodCe0CddLZniE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767930562; c=relaxed/simple;
	bh=E6uak/Ar9yaFC3JmbUDoii0AA+gHqfswdIvHfuc27nk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fXiNroc1mjJKKx7wyN4DBgugth7xoTAQac3aW7hxe9TsasVgw7vYvMV9+/Fpulsh24UYnv739NS8h6nNaPe4xg0a4BUci/nk4/oPQpVSKpPntGGVskcYX+bDmRwZrZb+N9KiIjWKjB0xiGYyW4ksyFaUheobX+j4hGHApHLy3+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N8MfpHMS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XbCbxUBu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6091qR3e3324800
	for <linux-wireless@vger.kernel.org>; Fri, 9 Jan 2026 03:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=hrxldEW31Afsmv9xZ+lc9kFVxv6juPRQRMA
	F+8nCLvA=; b=N8MfpHMSR6pNTkogfmuF0plz6CTVRZa3dYBm49iOoaI4oEqu+Cu
	WFNJqLzbHTtJmvkPr9IT8RgfPnnbD7zFu4k8qVof2xoHhBF2H7KPdvo4+75MPsLO
	N5Eu2PUHRFDarRWbRiwUw06ykjV97WHdapylXvb6UKGqTREySGavLbbf4QGFJJhB
	mgzikCNFSz/Y6zer0SF3kofxsOsi9D2NqbGr5C+tzmR/qKcnIHOJBjOn0gchHj1p
	c2v9iFPMp1ezcLV5F38lrATrsOyJYqB5k4YpzKExECAcwZ5AWOqjgZmYn2d6E2//
	hOhhzPtUerbVBpkIclrrNewFzeA5OIGaogQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjrd6g91q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 09 Jan 2026 03:49:20 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34c387d3eb6so3238126a91.2
        for <linux-wireless@vger.kernel.org>; Thu, 08 Jan 2026 19:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767930559; x=1768535359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hrxldEW31Afsmv9xZ+lc9kFVxv6juPRQRMAF+8nCLvA=;
        b=XbCbxUBu4DiDHy9DWE5tsLUHeVIPiX8sm/hNWpLt1FFABg7cK66vlNQdIHroLb5mg+
         l60yVRMPfi4vKGFMBSSDIyewwfZNBcwGcrE2SHYPemrFK0VaATYpoaMkBLtaGkxjvcn/
         ijGJbu/8aIx+KS00nZSk+SaIDxfWvL5bwQO+rZpvzF8ok60ySTr4CMU2uMP7p+uN4jTI
         B8JycRyBal+4R8/IG5hEGf/o68ePwrUxiVzfSDOMSho0/TI23xmsgzkoOd/l/n1PirG9
         FIM5MHmgUFQ3eglmc2lL1BUp6BfRU0mPIHH/jEebDCHm0hCzxupjyWj/GM/KUmDuy4TP
         kD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767930559; x=1768535359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrxldEW31Afsmv9xZ+lc9kFVxv6juPRQRMAF+8nCLvA=;
        b=Khlf6NElplKVphwbm5RXahCqdb0JMjG0F2ML3VnpHEf6PRcwLBHikwoUOPIM+l842d
         apPpE08huN9qk1IOcrnXohXFyKKCesFsu+M6bYrmzG1TGeFAbyzJeYBfK5jE29o3AKHy
         Qzq8lH7MFuGMaAXQt51/rEp55eHMKr90LFWJ3sK2rzzAnKX6fUlSgNpKrzYWAxO4gFO9
         uNvgmN4YlabUh1csbeMP9ldA+9xA2u7DIPSjEEOoqhkblNDMKhI2KqqqJqb58AhLt5cA
         qObXwwdym9WU1tiW2dtMFt6+LMOF1c2lvyCIctA6WXzYb8k6FWM7QSvu63upsyuvnjWF
         9dqg==
X-Gm-Message-State: AOJu0YxTGHZKG2HX9u2G5bNRdLh4YyJ4xPq7mLKXIKgnLpaf5wlFguw8
	cVaIarVZhJVZK3tDJBUAqoUeAO5YflLNPJp+dN4+VpAlk1QhlvCKuSTQh2ZsKBbPyI6zRGF2UtC
	HgBIs5eao7hS5kUIefGWcOwDbqCB1K6wGaOKaE3pf68rDBC17DuXRcdWvjm36nrSAxEafmTVUg0
	iNpw==
X-Gm-Gg: AY/fxX4DzU7fwz2OTeleWbGFyS7YvpnD3UheFUCx3xEWQfVDZHX3uYspscva6JSnP8S
	L+ZCjzJ8pPeDTWeYlDs9pPYZ12EV8ahpFeKUaQuGVGZ5ywlwBwpudq9u3THqR7aLb/pRS07+79D
	FX6TbHoMeXtDypA7mykxnowPjBiB+vrch9VyCJd9oJaWM2O7aCNhZ87ZbPDCHx2xiLYKfvXaG4b
	kMGI8OdMWXEQbU5l8UZuRM+6np4VMk9dDvmSTg9ALoU51OCGFE/nNmPUDHbfCxQfIGdmYyjCiy5
	iakZzbbIHqe8f8XRvzAKISy7iQBxEB28B/9q2otvIgDX9djE03aABnOjhru4hXcWATJooxXmDUq
	PVGr26tRHEB2qgS4DgrKgkJ0fED0Eh80ncvExsrRP5fcKMynvWBfFoGUrVPJk9LK3dF9QAYEm3d
	0Sd8ZRqjWw0QwF4w5nsnpdeubVD5+ab2w=
X-Received: by 2002:a17:90b:2789:b0:32e:6fae:ba52 with SMTP id 98e67ed59e1d1-34f68b4cd37mr8619332a91.6.1767930559309;
        Thu, 08 Jan 2026 19:49:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhR20Xd6Q8+vTHqgYWWLOnGMLqjj2SuuBK7d0QsAvFQXHyVxZTZ4eWQ6W+XhWQpp3xOnFiqA==
X-Received: by 2002:a17:90b:2789:b0:32e:6fae:ba52 with SMTP id 98e67ed59e1d1-34f68b4cd37mr8619313a91.6.1767930558795;
        Thu, 08 Jan 2026 19:49:18 -0800 (PST)
Received: from hu-sarishar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f6b8ab110sm2752484a91.4.2026.01.08.19.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 19:49:18 -0800 (PST)
From: Sarika Sharma <sarika.sharma@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Sarika Sharma <sarika.sharma@oss.qualcomm.com>
Subject: [PATCH wireless-next] wifi: mac80211: check BSSID before dereference
Date: Fri,  9 Jan 2026 09:18:29 +0530
Message-Id: <20260109034829.1489135-1-sarika.sharma@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDAyMyBTYWx0ZWRfX+gQUoLoLXyFk
 1KxeK39W+hbQGdvIvgdBXbioSPTZrThQti1GFqyEH3lQJIe9MrutVdKG93vn+krevH0kN0T/xii
 aoLdmwQHb+zwWMSQfKC2oleFRjFVjc6EakykWr/5l6e/JJ2eSPF7L13Ps7cyMGSNGLwp/u0YlNH
 yHbqHKzBypXda4suDJLeg77ZQXhA67RNsjQXSBuRkvRPqQadNSDvunfjaepoxcmVwJ7VcG4vm9v
 9FkBuhlS4g05Uu1+oqmjhgG/NCXMBAS9rrkMEaATQVPUHEDKtUNC2Isbvr2yLYt+Bm6rPRBgczc
 WyCg87qCKIN4NgY2sfkaqUwdqrNmLY+oQKaEa52d7S3f5tQLTzH1oNc3QkP1dB0f3L10H7drnB/
 kKaZMOq2XKo01C0DVTcWb3miTNLCMKDFl1Zgykzawzvs0AeqhYIHKBJNWMId7f+L9VFgBV1xr4P
 0XqR9TLyL7nAB3FNN1g==
X-Proofpoint-GUID: DggyDEszmLV-ARrDADuf4qCPcSHz8IZ3
X-Proofpoint-ORIG-GUID: DggyDEszmLV-ARrDADuf4qCPcSHz8IZ3
X-Authority-Analysis: v=2.4 cv=Xtf3+FF9 c=1 sm=1 tr=0 ts=69607ac0 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=iPK2hTW19hyQfKlhfZsA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_01,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601090023

Currently, when retrieving the BSSID value using the function
ieee80211_get_bssid(), it may return NULL under error conditions.
Later, in ieee80211_rx_h_sta_process(), this value is used to
compare Ethernet addresses with the function ether_addr_equal().
Since ether_addr_equal() expects two valid addresses, this could
lead to a NULL pointer dereference or other undefined behavior.

Hence to prevent this, add a NULL check for the BSSID before
dereferencing.

Signed-off-by: Sarika Sharma <sarika.sharma@oss.qualcomm.com>
---
 net/mac80211/rx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index e0ccd9749853..26555033f7a4 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1856,7 +1856,9 @@ ieee80211_rx_h_sta_process(struct ieee80211_rx_data *rx)
 	if (rx->sdata->vif.type == NL80211_IFTYPE_ADHOC) {
 		u8 *bssid = ieee80211_get_bssid(hdr, rx->skb->len,
 						NL80211_IFTYPE_ADHOC);
-		if (ether_addr_equal(bssid, rx->sdata->u.ibss.bssid) &&
+
+		if (bssid &&
+		    ether_addr_equal(bssid, rx->sdata->u.ibss.bssid) &&
 		    test_sta_flag(sta, WLAN_STA_AUTHORIZED)) {
 			link_sta->rx_stats.last_rx = jiffies;
 			if (ieee80211_is_data_present(hdr->frame_control) &&

base-commit: d66676e6ca96bf8680f869a9bd6573b26c634622
-- 
2.34.1


