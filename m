Return-Path: <linux-wireless+bounces-35379-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJZ+ElV972lKBwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35379-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 17:14:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF86474FAB
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 17:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB6D130A4AB4
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 15:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7BA328B71;
	Mon, 27 Apr 2026 15:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="STFzx3r5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FIgGANaX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C9E326D75
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302562; cv=none; b=CDihRdC4+C3yvibKO+WMN4a87wGdCRz0vEAEUj24+gMho9mM3FpXgWaKZQSL5AsiU8KIwpq/3GYJA/GAzFzBGOkf9/XuBfLmngYRcBugHjd7NcpLqx2XikL6vN4czMoGvTjMdGQ77cwNh9mEnBdAvglINmepCBA2+7P87uS44yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302562; c=relaxed/simple;
	bh=FlDJUMCsCn9xU1N71MX4WAvzHL0B5SmPWsrraZSd2+M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mvWi94F//mP2aOtygWmEcAxd3roFEAkrusoczaYjY99z1FJytfZnDd9NyiPsOBVZgNLKZysauZ3P5wOj4y9i53DT/JKSM2CKYRDGCZw4V8Bf1iHdrLnHqomVXPgUUjoefxxSHQOBj+o/l6IHkxqM7l9eWTeB2ABCTM6Y4YB71tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=STFzx3r5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FIgGANaX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RCp9652382917
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 15:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=1kP2Dj8XxUqTd8poJ8VGwKUEfqe9RSgzEkl
	2m3GGhEk=; b=STFzx3r5rSvi0oCk3aSmPYyhbVVf1pAi/MWX1JQNmsg4q/765i6
	R6U6gVqyoksyPcjFtjiz9trSebFdDQ347e7nFeknIouWClDh5QuhmViACBq6vMIH
	JB8toAaJ0HMHtCfBMd+eF/yj7q1E++Uk4Mc5TNIIB91RDhU7l4kqxHyPOoJBxPNH
	SYCxRxJNctZPatAMtnpP6eNF8NfGODixPN8GbH3Zz99DOQbezyVueHZ2W4oIWGSL
	xyAt+KSfDUZ2GK002MFCaJ8qSrY2wZG2aZ2RJbPaHmBC4GX5bgRN8IyeZDcqKJ92
	Im/uL+uW8YTWpiHiOvPTKIcs5Ldrpszb9vg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt85xrhwy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 15:09:18 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35d9e67f6dcso12749172a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 08:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777302558; x=1777907358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1kP2Dj8XxUqTd8poJ8VGwKUEfqe9RSgzEkl2m3GGhEk=;
        b=FIgGANaXrDEEpaETM41GZSApfnpuZP0+EGsgDyQ5Vh+QZr7RFIFARlah8hww2lHG4K
         NDqsyRHXXssK4AGMv9oVDsNSEpPOnX6AmMYIUw2PU/sp74RBKcmYnZlZeMTulffgjCbt
         RFwTojeyZla4msuJZwRh+BCH6clFv64OGZbYt+mv4XINnL7Br3Z48PKuAHJGN4aIkFSf
         KZ1bh08wLGkckt5/gy7zm7Uh9QhFKbbsjZqT/guv2wHKkshi+ZJGeOBPOFNMDHaKk1qL
         Tjm6na48YMWAHzu9hzhM9IVobkW/cyPGOIL08KoBq/SPkIV1c/CNumo9jHkz/533kBhr
         Om8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777302558; x=1777907358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kP2Dj8XxUqTd8poJ8VGwKUEfqe9RSgzEkl2m3GGhEk=;
        b=AQsuKDMXj54ctg8Sb7DWGXXds33VYEqeBEJZghG8jJxlgccRIsev/s2tnm4oK+mBaO
         Pc2tf07ypacoPfm1linJwbbzUp8j7ywcUbQizsUXkGRpci37sD4goB/9qt/7u9/6dcdq
         jB3r/tqZXpmtkNdbeJUeZoC239c/VG0O1KU145VlDvM0Ya+ntTzv5CQSQIDFOLtwqpFT
         Z1be1u+wCSx8FHVgMqo9VpSCIq2oYxpY5Q+ILuamELekJqvqzVtwWAr/x6t85BCULkHu
         paqo9XO6mbcE0uQZ0kyRnVvaQD+el5y236PhKvcFiJmzyCx0E5z4uN984psgjlhndUpi
         Mh8Q==
X-Gm-Message-State: AOJu0YxKhhz/AKC682wL0JrJZNG/TkD3hZ0E4fX12nw+1X9lET6bXLWd
	ltDswLcu2DdTQE88CgmSavUrbi1mKgVHQe5eSjwoNOxeJZPSFpXwBregrssZbPb52Ul/P5DGj9u
	9mNHtA46BmGas0IYdp6KZ/QVOYNZvTseYEjeqWNJ9+d9gHnah+glcgXVaHa/GxFGj9zpTaQ==
X-Gm-Gg: AeBDieucJkRdOVw/TyLE59YsD+ZH2EGwqTv5E7p3InehA3sOrGT+hs7kGH8AaEntPwc
	07zN7wz8KFffxtxv8y1+eIMQwHsHdOObGKAQbxVSeA3lsGk5wU0OFZ4U7+IxJkRlMzFJcjx5MVW
	Nomr4uENDciMn/2nyWsiRnhmR4F0X1zvJhR73xL2jiiX43Ey3tnBAMPj9M4vgQaHEhJp7hXQrHw
	bKyws/tj8nuZAK49DzjlFna3TDcoqGS8RBVao4/zC/qw/D53kUMy6226+/aHt5YaaSgXwtrUgkM
	53vsbofne6od5cICCF5zv8aMKl0zqnXQefRFiSmimfGFalorDcc1VrrZ1rHv3KpLUS8Lv8YPMJG
	ArVUK/7GIoFyk2qFje1EDpuBGiANxEz2JlgaiUqvDE+YK0WS+SaGQE4w9fcU6w5Sc
X-Received: by 2002:a17:90a:d446:b0:35c:1f29:712f with SMTP id 98e67ed59e1d1-3614049a328mr42508465a91.24.1777302558013;
        Mon, 27 Apr 2026 08:09:18 -0700 (PDT)
X-Received: by 2002:a17:90a:d446:b0:35c:1f29:712f with SMTP id 98e67ed59e1d1-3614049a328mr42508435a91.24.1777302557509;
        Mon, 27 Apr 2026 08:09:17 -0700 (PDT)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36141868906sm31471363a91.3.2026.04.27.08.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 08:09:17 -0700 (PDT)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next 0/2] wifi: cfg80211/mac80211: indicate (Re)Association frame encryption in SME-in-driver mode
Date: Mon, 27 Apr 2026 20:37:33 +0530
Message-Id: <20260427150735.2391680-1-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Zs3d7d7G c=1 sm=1 tr=0 ts=69ef7c1e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=g4I2wzSH2HRaHSI79ckA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 3qqoBQt9rSrYRaYaCeYIoHeQsaVIevZf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE2MSBTYWx0ZWRfX+MVd/pjHjxM8
 avkuL1qLbdoOcFYb54wWQI8jPsaMSsq55YWIP4+8sRBIlRZgzDmpQnnfGaZLg6LKL70KUnr2mbb
 dtVakL6/bqN+5hAbKnTqlEPmEIZ9W5Wd9mCxsYlMr8QOd7ExYw7YiZAXkf/FY4wqzmmAPyu3M/I
 8aQN/wgOUwhRbSw+NJ2JV8Noyu1sg5+Ro3QjvIJA9/YfTQLZa+azUis7giOB3s074gM6ag8/oE5
 2Dq+SKKti4GU8cfqrVpV5PJrqrvYKDVhraVAqvBBP7iJ5zYvWTCC3Kubk5EcCq84CfTEpMcG7SX
 tzcOmZOjWUiXyf6LrG1UMyKeuEbSPb9LK/DUUG4uYGZwNgnQ0rpASIc59KyesyKBNqO0zZC/XbR
 OeK4nFwXmzecVK3PJJnFzWWy+6qiDJRtN2eOi5nQD2NbuOy3Q2VWSGRgVe1jHvJ4VMa1V2n+Bzl
 UINtNYr/mB4Ld8sPjMg==
X-Proofpoint-GUID: 3qqoBQt9rSrYRaYaCeYIoHeQsaVIevZf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270161
X-Rspamd-Queue-Id: 9CF86474FAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35379-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kavita.kavita@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]

Add support for indicating (Re)Association frame encryption
(IEEE P802.11bi/D4.0, 12.16.6) to userspace (e.g., wpa_supplicant)
in SME-in-driver mode.

These changes are tested with Hwsim Tool.

Kavita Kavita (2):
  wifi: cfg80211: indicate (Re)Association frame encryption to userspace
  wifi: cfg80211/mac80211: extend cfg80211_rx_assoc_resp_data() for
    assoc encryption

 include/net/cfg80211.h       | 6 ++++++
 include/uapi/linux/nl80211.h | 9 +++++++++
 net/mac80211/mlme.c          | 9 +++++++++
 net/wireless/mlme.c          | 1 +
 net/wireless/nl80211.c       | 5 ++++-
 net/wireless/sme.c           | 1 +
 6 files changed, 30 insertions(+), 1 deletion(-)


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
--
2.34.1


