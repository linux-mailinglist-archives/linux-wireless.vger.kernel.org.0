Return-Path: <linux-wireless+bounces-19969-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D49E2A55C11
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 01:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD138189B339
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 00:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE9D748D;
	Fri,  7 Mar 2025 00:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IXyjZ8pb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97231611E
	for <linux-wireless@vger.kernel.org>; Fri,  7 Mar 2025 00:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741307869; cv=none; b=oaXGW+FOGp4BU2K5V9zTkPcC1GJQgD+y+sboJK136ZHiS+Q0Vp1AA+8+7BsEM+jeXJKm0eoV7ZY7vPg4/dBUzF4d3Qa0wCdI7+h1w+eh//ZF/TeFBWEjvvgGvm9laPlzwTFRvx63NjF27Uqhab4lRTavUoGBBPoiw/pERGOrAZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741307869; c=relaxed/simple;
	bh=ehXUGifF6e/Em2e1rk9Rlbf01DxvafcaNCTAN8ZRsXc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y09UGciMCfMhbfOXQtaaYy5zqPEA8HjqE+WcggDaOY5NHxIwytXNAhgcZgrzy28ei/83wvmRgRx6ehRQ5FmYJ0LCFoE+R5i2sd31/WOyeiN7Ij8Sf9U3SRQ1HuKXwi97E+l7/1bSoitDnbjeOgctETkUi+I0+v09it4OgGHHBeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IXyjZ8pb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526M6TYc032038
	for <linux-wireless@vger.kernel.org>; Fri, 7 Mar 2025 00:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=JU/FfjPzV86iiegNHXuI0CRVVlZaSOLEOUm
	0ZyWYfaA=; b=IXyjZ8pbMp6+YsGd5hOACkl1Z/AzaxeHLnzym6XnBMiaqGFys+V
	BnEoeCkC/LQJkwRr464DJ4shKlNsl+GL9PgLkbymfDoPrc4ETPyZB7iC5Vc8nVH/
	W1TeQzr7zZISFXdH+eWSjwHDerSVsPxH+AmmUNd1UA2O5EdVpgj1sd03NVueXg+T
	ESQCx4b/VWLPJ/C25nWKglHgBBf3uLHtZCkWE0x3qTuvhGlxFoZmTsZizrzmqEBe
	uVn6ykil4tIvpuuCdEbixyuC7PE3n3+3D2Utp1FSBVU4dzGpAcaXyYGnePCUYsft
	BSEh4hGl//c1wJ/YhIXTMr7CWY8kmiT9MNA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 457aghj3hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 07 Mar 2025 00:37:46 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff78bd3026so1023777a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 06 Mar 2025 16:37:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741307865; x=1741912665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JU/FfjPzV86iiegNHXuI0CRVVlZaSOLEOUm0ZyWYfaA=;
        b=whCvS1kvcrz0bgFOhvL3lFdJMUEp7B/g58MsmCSl+jcjB0IXY8AZkB9dYUwZvm6B/F
         YjxWaogeNGxEedk/7/isgWFlaTzEoHb9UZ+07DZpclPxrjqODKLfk384HKnpe3hUO2OC
         K4lpgmUO1eDhX/Fv8Ng2UkIsUMnpeWhTtQ+gk4hxYZzEX2BxRIaCcbR7pb0eSVYo6RyP
         IaiexIS3ANXq8hV6QJTiu3jfB7Z2bvZsdhaXv1APUMWUCJ5pLvWo3uUMZ+d5ngZpoQqs
         FuVPCzmY1Rf/tOYKpfB6RdGIXEc8YzHUPg0l/P3GTpp8MwtFB3VWSutI0TYIoXgmpcvW
         yqEA==
X-Gm-Message-State: AOJu0YysEiOknCHfzMMC7uWM3IBQp+aAMTRH9Ih1j7kgyMBMYlxEf9a/
	KmykpMbFi+vrBhTcSfpj9YmBZkF8q1xLK3PM55Dq8WZ4AyF8n2RCbllyWjf8EHggsh7OdIZ7wx1
	JQ87GhmiP6utc2HAeHNjBq9o10Zi91nhJM9tTucQa5ajiQKrI/6LLFolQBnklTZ6SwA==
X-Gm-Gg: ASbGncv+iEld2vH0vOUCfUmwJhZfk92n7tglCGd5X73zgpJbfiEPhMM1tqdoPanGpiS
	DTJ9ORboD5fRDN7VKhoIb+DoENPK81Cd9TfH74wIW9z//uiGhnM0oe55Q4q9AsDIgCcxOJNT0Yl
	us1gvSd0ChJY57r2LHnsmFmLQI9MLx9anQNKCqRmypYbcfj8QEfxrBcbG/0buvm+pEzxe51KOL4
	Zm7MWm2z43AF1u/X0EBz7iARHhGhAwqMAirLuYXZqTTf/8bN414AeMgbyAhduxKMbua7ws2n2I3
	pGJxnWf85NmlhXNe7DyYpEL5s+lBDV1rX+fIx4Ui1w4N1DwRGOCYPdCnMux+VxiDUP1kqw0M
X-Received: by 2002:a17:90b:17c3:b0:2ff:784b:ffe with SMTP id 98e67ed59e1d1-2ff7ce8361fmr2216926a91.11.1741307865413;
        Thu, 06 Mar 2025 16:37:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErhnWI6vJRZS77+kTcpaFxRWIb98i/GJughI7XPsdM2XyKwp+hwMi5kQiuS+f0GAXCsogCeg==
X-Received: by 2002:a17:90b:17c3:b0:2ff:784b:ffe with SMTP id 98e67ed59e1d1-2ff7ce8361fmr2216896a91.11.1741307865029;
        Thu, 06 Mar 2025 16:37:45 -0800 (PST)
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f8b6sm18559185ad.136.2025.03.06.16.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 16:37:44 -0800 (PST)
From: Muna Sinada <muna.sinada@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, Muna Sinada <muna.sinada@oss.qualcomm.com>
Subject: [wireless-next v2 0/2] wifi: mac80211: MLO handling for Dynamic VLAN
Date: Thu,  6 Mar 2025 16:37:38 -0800
Message-Id: <20250307003740.1329351-1-muna.sinada@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _QS0CGBkwXes3k25ijR_jfMdzMJ8gPsv
X-Authority-Analysis: v=2.4 cv=R5D5GcRX c=1 sm=1 tr=0 ts=67ca3fda cx=c_pps a=vVfyC5vLCtgYJKYeQD43oA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=Vs1iUdzkB0EA:10 a=MQcm2JhZiowH7QVKKW4A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: _QS0CGBkwXes3k25ijR_jfMdzMJ8gPsv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_08,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 mlxlogscore=529 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503070001

Currently for AP_VLAN interfaces that are a part of a MLD master AP,
links are not created for the interface. Additionally, mac80211
handles duplicating multicast traffic on each link when a driver/hw
is not handling such action.

With the introduction of MLO, there are two areas where additional
handling is needed to enable Dynamic VLAN traffic: creating separate
links for AP_VLAN interface and enabling mac80211 to send multicast
Dynamic VLAN traffic on each link.

4addr mode + MLO is not currently supported.

Muna Sinada (2):
  wifi: mac80211: Create separate links for VLAN interfaces
  wifi: mac80211: VLAN traffic in multicast path

 net/mac80211/chan.c        |  3 ++
 net/mac80211/ieee80211_i.h |  3 ++
 net/mac80211/iface.c       | 22 +++++++++-
 net/mac80211/link.c        | 90 ++++++++++++++++++++++++++++++++++++--
 net/mac80211/tx.c          |  6 ++-
 5 files changed, 116 insertions(+), 8 deletions(-)

-- 
2.34.1


