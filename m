Return-Path: <linux-wireless+bounces-27556-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9858FB8F040
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 07:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 542953BB887
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 05:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D87223DED;
	Mon, 22 Sep 2025 05:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MH4cfgPN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582303AC39
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 05:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758518689; cv=none; b=Fk4DNS12oPKZ+dZ2HntaVuJ8cMm0+pEC1Ix+4BaKYy8mWEp4uRoiAfMxYXdBRZMUU4KbOzTEe/nm0REH56qYu3Jew3rFvPxk65LqDkIvr0m0TbqqtgG9EcCezxBff5huzm/KSjGy+FfmZCu+8rY1Tz2IlVhaNNx6wTQcL13Ogng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758518689; c=relaxed/simple;
	bh=ah4Nc10Y+vgKGYtnUW5yUl0dkBM5pDuUoLiYbTc7tjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uhVbk9d7WBbSNwRxOPWgDOya7kdlyItsrZic1I0h8fc9D6rHUCYnXYkV9wVEOYFVm1+GvCQiKK0fis2OjQm+kKmy+0Qh58HNQ2q6YTfF+pHglpP31pA/O3oIT6Et2NGmCzO9Zj1w5PXqLOluCIiQHui19aZ1GfqTe3xN6h6rxuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MH4cfgPN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58LNxPPu007111
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 05:24:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OkbSW9H/amUuFQbb8jimIft/9C2vbIODjOwt6yMDdAo=; b=MH4cfgPN2Y/zEGiS
	r8PN8MFrUH+KprwgQ2FBpnlk1loIp1hO5MJ+aFaKWAeX4lG5ZlJshXl4hJtqtgR8
	HLM8cLD/8DYjIxlcemhreugt/YukWbDatjJsQoYUahcod/lAeQ86/1DduKt71p/Y
	QIzKThvMwPkzzqaz53owoSgWxgu/nd3X/hdHtyt0R9W1+IH8EkIK2p6NYxUtHgzk
	QQ0vClp0XU06emNXQ38mQ3FFiyZTIW0TSg7sS6EWgKB9i0G2aA+GtxeiylcdJFwn
	8TxXH/NK5uXHmFDRcM+unHO6td7CTWP/gj73n5WcdLXI1F7kumxlG6pZv7iZXDEV
	ivc/bw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fbbry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 05:24:47 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77ecac44d33so1968924b3a.1
        for <linux-wireless@vger.kernel.org>; Sun, 21 Sep 2025 22:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758518687; x=1759123487;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OkbSW9H/amUuFQbb8jimIft/9C2vbIODjOwt6yMDdAo=;
        b=kfgZ6wMuZM3rLdlrf0n12IahvlkYmEs7hvL1AOveEpPsTSmQnq0z7+nXF8ZRK7ZfOg
         9tYN+wjVIBq9OtCjXOjimrBL996b2tLRKLtfaOeFen+2zL0lRHjPLDzRJe5/wsXccUcN
         lMoBkDtrz/0rA/aeecF6e2BlcG/AuCUOgeaMAhzoE50ykGi5syrp+XuFw2quPQN390ax
         pscLnlh3QaWIXzVv63VoTK6kjDcDw8Rg5AmMyJZWCavwkOEBxzOMSDHTsGvPW5SfK5TW
         goxDl+rM7qqzjsbbXWpLgK++apwm0cloYpVm7CMi00/OV2xrvPeGEeR6Q9PKwRvhoWgb
         Hohg==
X-Forwarded-Encrypted: i=1; AJvYcCU+7k3dOGt15TvCCFsnPwTQxq2IpLrjrhrV+qw9EormB4mOyFw6yg6mLsixIJ4BZhON+cxdWjpA1Nj7EBCh3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YygEBb/9Tu9EzTvJVn0LKIir6xdF8ekCj786zJrmuqAGzo8GBPj
	YM6l5L2puaREZkJAamz9MASn0csxH7sThVn3kpNbsCis7kR5eAeZjeruf8Ij/9UkRGEPTr2l0Hc
	LOphgr6qkgW6vXG9dPRucAcR5AaXGF+EQUgbrxnQspCL9sdTisOrqoaigSZXwocDw5l+Rrg==
X-Gm-Gg: ASbGncvI7i4l6sjIoOIvDYDPXAwVgN7ZzE7YxD9AKudT45WMvWwFVFgNZ1vk2PmrFOh
	q2IKIpKo/+bFBS/GLkKskKc+k4TkH8u4sRUyon8D3bYq6YFD4erKlpixxvsfwqMmB6hBHl148p9
	xoLE+ThOgQFgHgfXcMyWlB9nD8uem5YGTrD2siFKpkkmOeqxMW1B7Bo5Y80pqixwSHWRXVcUn0P
	z0lSH4nPERLqlDrOg83Bc8v6E7Hyj4L2uuVAbVL6scAy9fRApIkRAyuE8tfqWgwLNbeD0/mLbxp
	4cVo8X8ahCQDW5IKOy6j9HCuSYGHy4QsXgxZtpnnJiMhak6pzsmn1e8SSDP/NOchCSPCT+qGjpu
	ogpTthS5RwAcHefpr5TiazN8EiCBEJTX6c4Dh9e8Vi2y9Sz5lVRy7jW7IRwH8WIB1y99zAtkI
X-Received: by 2002:a05:6a00:1706:b0:772:260f:d7b1 with SMTP id d2e1a72fcca58-77e4eab77f0mr10379789b3a.16.1758518686595;
        Sun, 21 Sep 2025 22:24:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeNUKABaKEupDAehMgCB223TSXfwvR7DXEmHPq+sScY9GXMlhMP18WEdhCzlMmTYDnf/5hMg==
X-Received: by 2002:a05:6a00:1706:b0:772:260f:d7b1 with SMTP id d2e1a72fcca58-77e4eab77f0mr10379762b3a.16.1758518686041;
        Sun, 21 Sep 2025 22:24:46 -0700 (PDT)
Received: from hu-mdharane-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f1815af13sm5938567b3a.0.2025.09.21.22.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 22:24:45 -0700 (PDT)
From: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 10:54:25 +0530
Subject: [PATCH wireless-next 2/2] wifi: mac80211: Update csa_finalize to
 use link_id
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-stop_iface-split-v1-2-087403cea9f7@qti.qualcomm.com>
References: <20250922-stop_iface-split-v1-0-087403cea9f7@qti.qualcomm.com>
In-Reply-To: <20250922-stop_iface-split-v1-0-087403cea9f7@qti.qualcomm.com>
To: johannes@sipsolutions.net
Cc: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org
X-Mailer: b4 0.15-dev-1b0d6
X-Proofpoint-ORIG-GUID: Y9tmwhij9EMEf0OKC4oza_-k0LXDcsRK
X-Proofpoint-GUID: Y9tmwhij9EMEf0OKC4oza_-k0LXDcsRK
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d0dd9f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=ETHeo0C1wQhlV8YJICQA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfXyt42jp+PeE64
 5GBAwx+F9Xy5EpaieL+KfB1gHnQev1BBnbv9RF3/6V+YaDpPDCArQiCsuzSHHY8u1Yk3dK/PGUX
 Y2JTLhKUKlA4qbwHEADUFpUCcne/KRLVUX9mbLfwMQSnSDnTOj78pQ14Y7jmXY9xNWqM5nqP6LQ
 ulR19h/k5jF7FVxR5voHO0J32bunXaHpKM3nESN9+G0vhnBM6h2nrnk/fTZPnmO2q9G9axFIR0l
 BpHmzKRle+qfmug2vf7h/eSo2jJvpYL+rD3c2qSs1QBjuQUoXXMjwZj9NYy0BebDBLpCbhRJ0PO
 HW7uwrie8qil+APM/qq1pYxWdEGwZRR+L0UZzclsndD5atx4x50w3setny3DpsmAWpY3xih8WjP
 NBZJScD+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_10,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

With stop_iface infra to handle the event on the passed link_id, for
AP/P2P_GO interface types, there may be cases where finalizing the
CSA fails. In those cases, a link alone can be stopped instead of
stopping the whole interface.

Add changes to send link_id if its AP/P2P_GO type and -1, otherwise.

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Signed-off-by: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
---
 net/mac80211/cfg.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 9c951c1a2d6b00bc204d6f4097e9b1fe43c039f8..ad67d0c78e39cd4f57ee020912242d66fe85cc7c 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4031,12 +4031,18 @@ static int __ieee80211_csa_finalize(struct ieee80211_link_data *link_data)
 static void ieee80211_csa_finalize(struct ieee80211_link_data *link_data)
 {
 	struct ieee80211_sub_if_data *sdata = link_data->sdata;
+	u8 link_id = -1;
 
 	if (__ieee80211_csa_finalize(link_data)) {
 		sdata_info(sdata, "failed to finalize CSA on link %d, disconnecting\n",
 			   link_data->link_id);
+		/* link_id is expected only for AP/P2P_GO type currently */
+		if (sdata->vif.type == NL80211_IFTYPE_AP ||
+		    sdata->vif.type == NL80211_IFTYPE_P2P_GO)
+			link_id = link_data->link_id;
+
 		cfg80211_stop_iface(sdata->local->hw.wiphy, &sdata->wdev,
-				    -1, GFP_KERNEL);
+				    link_id, GFP_KERNEL);
 	}
 }
 

-- 
2.34.1


