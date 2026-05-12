Return-Path: <linux-wireless+bounces-36279-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPm1L0OPAmryuQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36279-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 04:24:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64777518EA8
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 04:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C749A301AF46
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 02:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AC335AC33;
	Tue, 12 May 2026 02:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M3bCmgqt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iVENXRp7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8A8314A6B
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 02:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778552641; cv=none; b=BB3e/oiKItLdSuQZVQRr5nlcOXIeb4UwAk2KDDwyAMzTnszS/fC+kTQoJxbz1dmYHneIdZCIpfsAMj06hgSL9SXkAfIR/JjdZSir9gCkfDmWzEQ1zWBKdiRbrnDRdhM5ZWuKA8hp64Gj/TZ0tfOyi3vJvASyVegqMzJ3Vno5C6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778552641; c=relaxed/simple;
	bh=5O4Iw/ynusG8DFd4asIhv/zB2US0DBjf3r16x2tpXPc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=THbFLD6csCDnAr4dNEy+hsJ66C4KKMyPhzaLAlk0OlaVqE4Qeb9pzVRF2HJm92GGvRMjnIf98bkJ3N+RlnMxiFzrgd2qFlS/EUMaDHQrNYUWZ8XxyaPIjPI8Hb9VKBpVA0M54+QibF2h9zs25uh6O9BAhP7M4aD92hVBwb5nHJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M3bCmgqt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iVENXRp7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK6WPR2994873
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 02:23:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=OnJEs0Wj//JNnby7JdJtEwWZDbjb5cwkS9h
	/+IB7cXA=; b=M3bCmgqt9gaQScMW8ayQ2YfzJ9T9ghL080yfT0iRyW/Zps3KaLF
	lJKfp/mHHFF0BI7RbhfwEhEKt5kYY6UoaqMJPqsxwB4QoDGJ+IitiSWk8LVhXQHO
	25Hym6atLCAgrlGF2c8mP5SyRN2YyOsaemkU/4WrM8x0YvRQcydrp8cnAxCbkt7P
	WpHJ5Z2nPLbOo6n032Wa5LpiU0FHagnZBy+ppcvQDIEHo+p1UU7FUdLmzMhtEzJm
	Og9JQibHKxIvVfC5LGOC46e2jegeEmyw0ks/4BpSljpkDKbMiix7gbWi+QsugyUo
	m9mk1YVRB4AMYxxTtQMJFhugjOz6W9c3iDA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv0s396-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 02:23:58 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-83836443305so2804973b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 19:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778552637; x=1779157437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OnJEs0Wj//JNnby7JdJtEwWZDbjb5cwkS9h/+IB7cXA=;
        b=iVENXRp7b1GF6iZxNu4p/VIEaMzzW2q9Q2dRUrFqlDQKz83IgIaBZYjcg8YBLcJT4g
         mNiAwTE/imWRMlRRAwoeYKRTrIqaMVyR8BLIsixHwpE7wonMS70wSg7AzKdGLCz7slUV
         +2BVwGvGvEfhYlrJgD8wjKjEr7fhyE+KSb7SzEC8Gy+l5Lo/D3qbbgHQ8dNVSj6Ae0oT
         276l/595gPv6JK00LuZlaRcheHOD8kcp1m1/4yCxOEzeZYHJUtP6q9E11Y1SMTQS5yYu
         QTZjFOFHOePWRJ77S4bYh0Evay0FnQx2B1U9A/L4tN0d0ef9u09FtCan90I9/zyxFt5k
         m/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778552637; x=1779157437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnJEs0Wj//JNnby7JdJtEwWZDbjb5cwkS9h/+IB7cXA=;
        b=Y13vIZ8d7P2R1f9IeT2pKgMtkgNsGtXO+bZ3Tgk/x4UZRwCFMCpa2Y11lC5FsJaKl6
         vFm6UCZu34b6YroBolDRI29TcF5xbb+UEBZvOXeB6ITE43SlbGvfWUWaRLTkO5sdzw4U
         /ex2QxlJxr28SK5HJoe6s9pU71kAE4b8zH9SIuYrC/ta11leEoIp5x9S0UTwqeNagRCo
         oK2nyzNplWtkP1PjUjJ6a+Us3uTQRtWujrV3SCoJHgq4i1hTBVc3d3c5Uv2kDbE4DjDM
         ZeM+p9aCN1pQyqVfOEcb5/eCNGjvCL4T/xXc0qFKrvpB/uaGfUPfTBHSW5z4FGL9vAXw
         2EZA==
X-Forwarded-Encrypted: i=1; AFNElJ/Ksl3xpjpw6fxHaVp/ZaP05ZTwPUjQskWldAapZk3r7OR6XjAMKPI1h61uikw0sV3AHI7BrZ80Qf6H/S3lBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAadTqlwxodav6yOHan+5q8iOaTPuqllyEA5phX8PRzHQYqVzx
	2ODS17+aBysNKmED16Ghg7SkP4y2mrvmwYQ82zkYFjMr2YLgnl+6+lbWdRc48GyC6a1ooZ/6KCF
	LJqNF2b7FEegy8Gok7OxXdx7HCAr0nJTgrndQ+SvlgkJZGf6qaL84SYhyCDofYJQzaLLGu6xuWd
	GLEsO6Z3A=
X-Gm-Gg: Acq92OE1+m2ndvYC5n0PKSWQJoTHmFNgWXSwsy9RC4gQDRcajrQBDCbsBDnSIJdwFmb
	OwQURLQEFaH0GM5KaevL31+zZpkO6wY1nqk+Cs8W8I+IWDFy6kmsmvgD+vmiJaIeRJmk9sptRDf
	3xgRDo+pf1oLoprzFF6LlbmDN0xJinY6neMvN4F5a7UB/ZE+xSZQOgcHUf+RJMVot6liD9A2uvn
	0Mq6B1mTDfr/EDZSArdrgt88A3K23CwEKuBca3ihbQyygk7/ob67biSNHJZN0H1bPj+wP48AL6u
	JHFSBiNy8aq/KIuV9dHPIhH5LXTMVrzc/7zgOTes4ykLbALB8B/i0H2s4UCw0AIYs0xK/TkhGm1
	HJCGPX1A5wYj6mm05wNuuKS5nmCZgQjhSY9znydWLDJEFJXuUk652zQ4vC7ayvtK09uNzudirDk
	ywhJ2j
X-Received: by 2002:a05:6a00:3389:b0:837:b97d:2fe with SMTP id d2e1a72fcca58-83a5b9d822amr26524035b3a.18.1778552637547;
        Mon, 11 May 2026 19:23:57 -0700 (PDT)
X-Received: by 2002:a05:6a00:3389:b0:837:b97d:2fe with SMTP id d2e1a72fcca58-83a5b9d822amr26524013b3a.18.1778552636995;
        Mon, 11 May 2026 19:23:56 -0700 (PDT)
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbcf16sm25199256b3a.40.2026.05.11.19.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 19:23:56 -0700 (PDT)
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: [PATCH ath-next 0/2] wifi: ath11k: dp rx sanity checks for invalid length in error paths
Date: Tue, 12 May 2026 10:23:49 +0800
Message-Id: <20260512022351.2033155-1-miaoqing.pan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PN0/P/qC c=1 sm=1 tr=0 ts=6a028f3e cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=49tfinYE_bPl-5IrK10A:9 a=zZCYzV9kfG8A:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: gaZul9FqFZc9zbgdOgKndyJ_EGAsu8-N
X-Proofpoint-ORIG-GUID: gaZul9FqFZc9zbgdOgKndyJ_EGAsu8-N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAyMCBTYWx0ZWRfX6YQKAqCPqE3K
 sjHQy/51SYKTJbmFjX4+WCW+XScp1hx8qWYdoMR96IIKAhQaGvCc8yKU8f7PXncRKjvIxw/eEZl
 BEIqmt4MuGXHvqizl79DQ0/GI4HYB+uwaQyePr/u/KcDEOK9MJ4kETh+7oOQdpMSpRaDo38rOAZ
 4w30LsfkZQtv7075dHQkF3hTLOlqiXIPUmb5T/rMEhVcWKDV4MeW2mSxZO6J48E6yqGOXxsPXnS
 SPwSlnXCKW9YEVgY8jyLfn+RQZqw783X9dc2Pd9TWxEfI7LM2U8svwV3UKyR6WJkREK+4K9bt5X
 FlkLamnCY4Ib+RDGa/XT3UiSlx1gjs7SfFnwofT4S9BuXUG0tG8Rvzvz5ujFQAYmPOmL/PgGN98
 QwKbDBAn+6YCHS7Axopxa5N6lxLYK1C7dCYhgvae2CIieaQnN03AnH+TlIUjp061R+qMrWG+sY1
 FdBiGsJ7sgc2eLu6gNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 spamscore=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120020
X-Rspamd-Queue-Id: 64777518EA8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36279-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miaoqing.pan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

This patch series adds two defensive sanity checks in ath11k DP RX
handling to prevent invalid memory access when hardware/descriptor
contents are unexpected, especially in WBM error scenarios.

Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
---
Miaoqing Pan (2):
  wifi: ath11k: fix invalid data access in ath11k_dp_rx_h_undecap_nwifi
  wifi: ath11k: add MSDU length validation for TKIP MIC error

 drivers/net/wireless/ath/ath11k/dp_rx.c | 59 +++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 3 deletions(-)


base-commit: 7b25796f571fc09a7aa6fe7efb23edccd326917d
-- 
2.34.1


