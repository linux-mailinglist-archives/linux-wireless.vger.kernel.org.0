Return-Path: <linux-wireless+bounces-37522-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IBZvOmy+JmqdcAIAu9opvQ
	(envelope-from <linux-wireless+bounces-37522-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 15:06:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C78CC6566EB
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 15:06:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="lByO/o0h";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=HsUn8NRu;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37522-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37522-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A857F3007A7E
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 13:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE9A3655EE;
	Mon,  8 Jun 2026 13:06:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B803F33FE02
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 13:06:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780923980; cv=none; b=BFYg3xxNIichZ9WNt5xsE2e/duihbzTL3/LMuph4xTnjdXnrv51aRX5/k+HbamEBRpHs14aw+gBBvRR2PIyCaHr04+TOBmpYSuBwlh/DpSKsID0cNwPW/1HnVVKBpFFFTt9IwWI8l+cJCV5E6nqLX5e20NpF59cWzbrD0B8sc2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780923980; c=relaxed/simple;
	bh=NqvsZXnfOZPX6IT2GpXw+YKrx8mrBMtpqWGTHtBz+7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VfvC1Ca9BlmyRzGQqudRDbT8vSUvJmdYg3/7lMANcwBzhdoJ9eKD39E/Pv+MUotmWwQVsn+WcueLqWNAr6xLXngdL9HjVYMUZ5ktZvJatkokTmjRhEAWVagzK78m6HtXMBy4Ydaep1X3/uJkLTVluAaajeP9Am07r5CazOTD50k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lByO/o0h; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HsUn8NRu; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658B9KLv2992933
	for <linux-wireless@vger.kernel.org>; Mon, 8 Jun 2026 13:06:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iNdqdZDJFQxlY6R1Ryt/x6EY4f0slKtUl0PwQLfYsMw=; b=lByO/o0hSCf6rc7T
	Ni3fEkzHdxUTpC+rRp19c+jES1+dnAElcaEqutDUsjn8E+++iGmHGVw22vfkk+ro
	4nqyEkEFdr2UwLL2qumZQQud+N55iEqYeQLdvAvmCoqcKla7p3CGHNPo371RamXW
	HuozDwLP2flKOoSmnS7+nSoiF2js3H4OhJl9leHvYZkiDt6LkPmWY/3y/kaD1Ode
	ckz2Src6ntbZamJ2pYqPfYocWa94oL6iAPRwZUL8yBBCIUFYa5oa5mYUBpkVucit
	maJEkczwVkv2e5qNOZogpq5Zk89FRwm1Q0isTPv1EnTXzRXjTjf1A60L5vesQDaW
	NXNsiQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enuna8rmk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 13:06:17 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-304b8d0ee63so5919264eec.0
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 06:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780923976; x=1781528776; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iNdqdZDJFQxlY6R1Ryt/x6EY4f0slKtUl0PwQLfYsMw=;
        b=HsUn8NRuzxUZCspAaopNi99lpJf2oBNvntxXeJOr9V1GGy9JzVDCWXJomIcr4gOta4
         HgeFAI8yQ5V1810QKhkR+SBR8lhAkjdtDdfdICFTq2kn0ibs6TDqrJbB3etzxOl2u8PS
         3+EUbmZbmxBqcqTvK9XSIh0uxu3HBTdTUqx7ma5JzHNLCKCTFEIDGTXm9fS6RBk2Z6LB
         geyQavJHQ9UbdxYLtufRFR+rs1SsxbBKR2OnHzRxW3fMCkQDt1NpiyqXeGPD11Ejd19k
         ip8qcMBDP3FmNom2EMDekVzVQkdIdpeOKlThbjAgEErgPw0nQ1+++aasLPyQjslvu57Q
         3oZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780923976; x=1781528776;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iNdqdZDJFQxlY6R1Ryt/x6EY4f0slKtUl0PwQLfYsMw=;
        b=SFdhFTTaMvc/EzQz7xHb79xeqvoOLlsbkwN5H3HFgqCXi6gKudhzBYVOZcZsmcokiM
         eT3bhdRfbNZwUg91BQ9ItL1r2/naqK1q2O7m+A+yrhbIqouqwq9cDh8W/ykLGynNcCFt
         dVkpkt60jkb4d1Ln5hASfEJeJ4JpLODUSxVh/vPKyPsIxwGEBvhZRoSrLKyUYwnnMC0g
         k/a1hhFE5XsECx2bdud64HpfFHPjjLJcItDTBIJ6oJd0PIG5Io+ZczMe7TH79MH3OkQ2
         Y2N2bF34+SJRb1eX3HNyBRuVmTuQhhQKayuSdmgWBaF5vHSZx/LPpmuyF6xaTsqAn4s2
         lHPw==
X-Gm-Message-State: AOJu0YyfQnbWxZxAOs3fLnbGBQOaQcFreFVMsHksKAOju61HMtktu7uK
	ebgd4y0iGyKVFf0xweWnpewu4XkP3iudLCnizTMTcCgSZRC0VoOBjB7vs18tYQGbF23ZWDCbXAa
	ZqBW3KonGwXxWZ6UO0d7I7EGdO/PWyeA4I6bG2Az3l7Rn/pIahfPuQQDUrBgQqQqDEnvkUg==
X-Gm-Gg: Acq92OGrvJZnrWfxUwXZSYPG15nlMWkREHrw+XeneizhAGW5n8yjV+LVIqC9MZi855L
	g2OYj0bboLj8bPK3yQxVL1sicdKjL+XsQ8Xda7DD/vy9O6TPt+Zbhogc0WK2z7aLTw29gAlhkf/
	waX3fKc+WDn6XCKbJTBM9qqlKRtZ1m8HN8wqka1z+MyHzX0/Y/opWZkySnD7qBXwmd1IHhBvvwo
	ljIiV+YdJss1TUX4tbLI3pCs6OcU7S+zfqdkuS/DX0RAA2L5rH5nramOTLYV7stubyumqRdg/5Z
	gLvyyVIj11x4xE7t2S9qwanNfXK08rEEfxr67if4wj8eXvDk7UbmVG2L4lIeEBs3ILw5az2Wqcl
	3oEtuNnPlzq/TtOAPMCWJfvt77YWF7a4apjpZaxbMM4sB4wc6/p7n1T88K+1V2Cz3DAsooYWESn
	YMSmzBw9PEtxY=
X-Received: by 2002:a05:7300:cc0c:b0:2ce:25be:c8e8 with SMTP id 5a478bee46e88-3077b22a360mr8791845eec.17.1780923975386;
        Mon, 08 Jun 2026 06:06:15 -0700 (PDT)
X-Received: by 2002:a05:7300:cc0c:b0:2ce:25be:c8e8 with SMTP id 5a478bee46e88-3077b22a360mr8791778eec.17.1780923974306;
        Mon, 08 Jun 2026 06:06:14 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dba9d43sm15666701eec.10.2026.06.08.06.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:06:12 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 06:06:07 -0700
Subject: [PATCH ath-next 2/3] wifi: ath11k: Update Qualcomm copyrights
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-ath12k-copyright-v1-2-e1a71f92d447@oss.qualcomm.com>
References: <20260608-ath12k-copyright-v1-0-e1a71f92d447@oss.qualcomm.com>
In-Reply-To: <20260608-ath12k-copyright-v1-0-e1a71f92d447@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org,
        ath10k@lists.infradead.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEyNCBTYWx0ZWRfX6bma26JONydt
 k8Vg13XEG/6EBMSH/ooKejLe1hW/Cymx8NeBuYm0wRDWJnoYHZITL8sjQXCOl80URLD1pTrIECH
 LQdz19jOth6yLUTIgMV+75HFN4hk7hIhW1MTYo1sP3nXSeUyMsUEM5od6qHyq5YUa7pjYX2KzF2
 PAZ4yCkGnCJhTGBwQPl7Pl9nF/g6AO7v2+g+rVMQTOz3iw/njx7ZgZpxGpOELltgR1z9uZn6g2X
 FP6G2uQZjd8BSw5QXuVwnAEIvXNXYc3I30hF6qEZ3JYo8SOfDcIm64qmzJ3gqgzDCHsCedHOHZT
 ALEC7rco/0YVDGz5h+AGMuZUfpM6wEhaul1Rb6q1ufBBjcLzB+UJ3FfcLSN/mNkIuLZi0GY2rYR
 bKDfvQmQHyIOxr0vt3hdPoruJW2pWsLPp8PIzB6LCvu/fnBCLNGdPwgys+hqCgevmm6dpVFXHXp
 jKiRpP5t6jHwc4N9v6Q==
X-Authority-Analysis: v=2.4 cv=RfugzVtv c=1 sm=1 tr=0 ts=6a26be49 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=1foTlPHGAKRYhzXQz54A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: 4ZKtj9SI84giP-AMbntFWhQRpMz7oTws
X-Proofpoint-GUID: 4ZKtj9SI84giP-AMbntFWhQRpMz7oTws
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080124
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37522-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:ath11k@lists.infradead.org,m:ath10k@lists.infradead.org,m:jeff.johnson@oss.qualcomm.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C78CC6566EB

Update Qualcomm copyrights per current legal guidance.

Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c               | 2 +-
 drivers/net/wireless/ath/ath11k/ahb.h               | 2 +-
 drivers/net/wireless/ath/ath11k/ce.c                | 1 -
 drivers/net/wireless/ath/ath11k/ce.h                | 2 +-
 drivers/net/wireless/ath/ath11k/coredump.c          | 1 -
 drivers/net/wireless/ath/ath11k/coredump.h          | 2 +-
 drivers/net/wireless/ath/ath11k/debug.c             | 1 -
 drivers/net/wireless/ath/ath11k/debugfs.c           | 1 -
 drivers/net/wireless/ath/ath11k/debugfs.h           | 2 +-
 drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c | 1 -
 drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h | 2 +-
 drivers/net/wireless/ath/ath11k/debugfs_sta.h       | 2 +-
 drivers/net/wireless/ath/ath11k/dp.c                | 1 -
 drivers/net/wireless/ath/ath11k/dp.h                | 2 +-
 drivers/net/wireless/ath/ath11k/dp_rx.h             | 2 +-
 drivers/net/wireless/ath/ath11k/dp_tx.c             | 1 -
 drivers/net/wireless/ath/ath11k/dp_tx.h             | 2 +-
 drivers/net/wireless/ath/ath11k/fw.c                | 1 -
 drivers/net/wireless/ath/ath11k/fw.h                | 2 +-
 drivers/net/wireless/ath/ath11k/hal_desc.h          | 2 +-
 drivers/net/wireless/ath/ath11k/hal_rx.c            | 2 +-
 drivers/net/wireless/ath/ath11k/hal_rx.h            | 2 +-
 drivers/net/wireless/ath/ath11k/hal_tx.c            | 2 +-
 drivers/net/wireless/ath/ath11k/hal_tx.h            | 2 +-
 drivers/net/wireless/ath/ath11k/hif.h               | 2 +-
 drivers/net/wireless/ath/ath11k/htc.c               | 2 +-
 drivers/net/wireless/ath/ath11k/htc.h               | 2 +-
 drivers/net/wireless/ath/ath11k/hw.c                | 2 +-
 drivers/net/wireless/ath/ath11k/mac.h               | 2 +-
 drivers/net/wireless/ath/ath11k/mhi.h               | 2 +-
 drivers/net/wireless/ath/ath11k/p2p.c               | 2 +-
 drivers/net/wireless/ath/ath11k/p2p.h               | 2 +-
 drivers/net/wireless/ath/ath11k/pcic.c              | 1 -
 drivers/net/wireless/ath/ath11k/pcic.h              | 2 +-
 drivers/net/wireless/ath/ath11k/peer.c              | 2 +-
 drivers/net/wireless/ath/ath11k/peer.h              | 2 +-
 drivers/net/wireless/ath/ath11k/qmi.h               | 2 +-
 drivers/net/wireless/ath/ath11k/reg.h               | 2 +-
 drivers/net/wireless/ath/ath11k/rx_desc.h           | 2 +-
 drivers/net/wireless/ath/ath11k/spectral.c          | 1 -
 drivers/net/wireless/ath/ath11k/spectral.h          | 2 +-
 drivers/net/wireless/ath/ath11k/testmode.c          | 2 +-
 drivers/net/wireless/ath/ath11k/testmode.h          | 2 +-
 drivers/net/wireless/ath/ath11k/thermal.c           | 2 +-
 drivers/net/wireless/ath/ath11k/thermal.h           | 2 +-
 drivers/net/wireless/ath/ath11k/trace.h             | 2 +-
 drivers/net/wireless/ath/ath11k/wow.c               | 2 +-
 drivers/net/wireless/ath/ath11k/wow.h               | 2 +-
 48 files changed, 38 insertions(+), 48 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 08d3a0c8f105..f566d699d074 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/module.h>
diff --git a/drivers/net/wireless/ath/ath11k/ahb.h b/drivers/net/wireless/ath/ath11k/ahb.h
index 415ddfd26654..8c1eb1e8e6b1 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.h
+++ b/drivers/net/wireless/ath/ath11k/ahb.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #ifndef ATH11K_AHB_H
 #define ATH11K_AHB_H
diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
index f2d5106adb01..c56dd8a86760 100644
--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
diff --git a/drivers/net/wireless/ath/ath11k/ce.h b/drivers/net/wireless/ath/ath11k/ce.h
index bcde2fcf02cf..308f425fcec0 100644
--- a/drivers/net/wireless/ath/ath11k/ce.h
+++ b/drivers/net/wireless/ath/ath11k/ce.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH11K_CE_H
diff --git a/drivers/net/wireless/ath/ath11k/coredump.c b/drivers/net/wireless/ath/ath11k/coredump.c
index 1949d57b007a..3de34295ddc8 100644
--- a/drivers/net/wireless/ath/ath11k/coredump.c
+++ b/drivers/net/wireless/ath/ath11k/coredump.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #include <linux/devcoredump.h>
diff --git a/drivers/net/wireless/ath/ath11k/coredump.h b/drivers/net/wireless/ath/ath11k/coredump.h
index 3960d9385261..1be82207690f 100644
--- a/drivers/net/wireless/ath/ath11k/coredump.h
+++ b/drivers/net/wireless/ath/ath11k/coredump.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #ifndef _ATH11K_COREDUMP_H_
 #define _ATH11K_COREDUMP_H_
diff --git a/drivers/net/wireless/ath/ath11k/debug.c b/drivers/net/wireless/ath/ath11k/debug.c
index 37d23a559ba3..f65e6cf846f7 100644
--- a/drivers/net/wireless/ath/ath11k/debug.c
+++ b/drivers/net/wireless/ath/ath11k/debug.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index 0c1138407838..70922612d3fb 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.h b/drivers/net/wireless/ath/ath11k/debugfs.h
index ed7fec177588..859071938a65 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.h
+++ b/drivers/net/wireless/ath/ath11k/debugfs.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022, 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef _ATH11K_DEBUGFS_H_
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
index 11d28c42227e..731f3ca86711 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h
index 476689bbd4da..856aa74ba365 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef DEBUG_HTT_STATS_H
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_sta.h b/drivers/net/wireless/ath/ath11k/debugfs_sta.h
index ace877e19275..6d4cf365d937 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_sta.h
+++ b/drivers/net/wireless/ath/ath11k/debugfs_sta.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef _ATH11K_DEBUGFS_STA_H_
diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index 5a50b623bd07..f389b97acbdd 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index 1bd513f68a3c..84f66839f0c6 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023, 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH11K_DP_H
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.h b/drivers/net/wireless/ath/ath11k/dp_rx.h
index c322e30caa96..f69d9301e0a1 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #ifndef ATH11K_DP_RX_H
 #define ATH11K_DP_RX_H
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 9c2310665713..cac970c92806 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.h b/drivers/net/wireless/ath/ath11k/dp_tx.h
index 795fe3b8fa0d..9303b5ba6e01 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.h
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021, 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH11K_DP_TX_H
diff --git a/drivers/net/wireless/ath/ath11k/fw.c b/drivers/net/wireless/ath/ath11k/fw.c
index 07d775a7b528..ef1b4c81843a 100644
--- a/drivers/net/wireless/ath/ath11k/fw.c
+++ b/drivers/net/wireless/ath/ath11k/fw.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
- * Copyright (c) 2022-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
diff --git a/drivers/net/wireless/ath/ath11k/fw.h b/drivers/net/wireless/ath/ath11k/fw.h
index d9893ceb2c3d..df2fab2c1143 100644
--- a/drivers/net/wireless/ath/ath11k/fw.h
+++ b/drivers/net/wireless/ath/ath11k/fw.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
- * Copyright (c) 2022-2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH11K_FW_H
diff --git a/drivers/net/wireless/ath/ath11k/hal_desc.h b/drivers/net/wireless/ath/ath11k/hal_desc.h
index b2fd180bd28e..c8b01f6921c0 100644
--- a/drivers/net/wireless/ath/ath11k/hal_desc.h
+++ b/drivers/net/wireless/ath/ath11k/hal_desc.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #include "core.h"
 
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
index 51e0840bc0d1..75f7b8d8a0d7 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include "debug.h"
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.h b/drivers/net/wireless/ath/ath11k/hal_rx.h
index 0fa9aef9d533..475807b89a1a 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH11K_HAL_RX_H
diff --git a/drivers/net/wireless/ath/ath11k/hal_tx.c b/drivers/net/wireless/ath/ath11k/hal_tx.c
index b919df6ce743..b7e9b1cdd76a 100644
--- a/drivers/net/wireless/ath/ath11k/hal_tx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_tx.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include "hal_desc.h"
diff --git a/drivers/net/wireless/ath/ath11k/hal_tx.h b/drivers/net/wireless/ath/ath11k/hal_tx.h
index 46d17abd808b..f2dc6e270534 100644
--- a/drivers/net/wireless/ath/ath11k/hal_tx.h
+++ b/drivers/net/wireless/ath/ath11k/hal_tx.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH11K_HAL_TX_H
diff --git a/drivers/net/wireless/ath/ath11k/hif.h b/drivers/net/wireless/ath/ath11k/hif.h
index cd9c4b838246..017fed1b4bd1 100644
--- a/drivers/net/wireless/ath/ath11k/hif.h
+++ b/drivers/net/wireless/ath/ath11k/hif.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2019-2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef _HIF_H_
diff --git a/drivers/net/wireless/ath/ath11k/htc.c b/drivers/net/wireless/ath/ath11k/htc.c
index 4571d01cc33d..5f9ee5e633da 100644
--- a/drivers/net/wireless/ath/ath11k/htc.c
+++ b/drivers/net/wireless/ath/ath11k/htc.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #include <linux/skbuff.h>
 #include <linux/ctype.h>
diff --git a/drivers/net/wireless/ath/ath11k/htc.h b/drivers/net/wireless/ath/ath11k/htc.h
index 86f77eacaea7..945c409bc08f 100644
--- a/drivers/net/wireless/ath/ath11k/htc.h
+++ b/drivers/net/wireless/ath/ath11k/htc.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH11K_HTC_H
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index d19c4b372a2a..93f9a03c48dc 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/types.h>
diff --git a/drivers/net/wireless/ath/ath11k/mac.h b/drivers/net/wireless/ath/ath11k/mac.h
index 5e61eea1bb03..59f83c7175fd 100644
--- a/drivers/net/wireless/ath/ath11k/mac.h
+++ b/drivers/net/wireless/ath/ath11k/mac.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023, 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH11K_MAC_H
diff --git a/drivers/net/wireless/ath/ath11k/mhi.h b/drivers/net/wireless/ath/ath11k/mhi.h
index 5c5c2b03c81f..7e7561ce883c 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.h
+++ b/drivers/net/wireless/ath/ath11k/mhi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022, 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #ifndef _ATH11K_MHI_H
 #define _ATH11K_MHI_H
diff --git a/drivers/net/wireless/ath/ath11k/p2p.c b/drivers/net/wireless/ath/ath11k/p2p.c
index 01e14523f1fe..77672099c602 100644
--- a/drivers/net/wireless/ath/ath11k/p2p.c
+++ b/drivers/net/wireless/ath/ath11k/p2p.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
- * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include "core.h"
diff --git a/drivers/net/wireless/ath/ath11k/p2p.h b/drivers/net/wireless/ath/ath11k/p2p.h
index d907940a9b09..449f0c61b600 100644
--- a/drivers/net/wireless/ath/ath11k/p2p.h
+++ b/drivers/net/wireless/ath/ath11k/p2p.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
- * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH11K_P2P_H
diff --git a/drivers/net/wireless/ath/ath11k/pcic.c b/drivers/net/wireless/ath/ath11k/pcic.c
index fc6e7da05c60..2259adc3bbdc 100644
--- a/drivers/net/wireless/ath/ath11k/pcic.c
+++ b/drivers/net/wireless/ath/ath11k/pcic.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
diff --git a/drivers/net/wireless/ath/ath11k/pcic.h b/drivers/net/wireless/ath/ath11k/pcic.h
index ac012e88bf6d..7a654a6ef9d1 100644
--- a/drivers/net/wireless/ath/ath11k/pcic.h
+++ b/drivers/net/wireless/ath/ath11k/pcic.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef _ATH11K_PCI_CMN_H
diff --git a/drivers/net/wireless/ath/ath11k/peer.c b/drivers/net/wireless/ath/ath11k/peer.c
index 027cc7aa58c8..b30a90698544 100644
--- a/drivers/net/wireless/ath/ath11k/peer.c
+++ b/drivers/net/wireless/ath/ath11k/peer.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include "core.h"
diff --git a/drivers/net/wireless/ath/ath11k/peer.h b/drivers/net/wireless/ath/ath11k/peer.h
index f5ef1a27f8f2..20c68ef52301 100644
--- a/drivers/net/wireless/ath/ath11k/peer.h
+++ b/drivers/net/wireless/ath/ath11k/peer.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH11K_PEER_H
diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index eae416db8b52..350816c81ee5 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH11K_QMI_H
diff --git a/drivers/net/wireless/ath/ath11k/reg.h b/drivers/net/wireless/ath/ath11k/reg.h
index 72b483594015..fed9bedc52ef 100644
--- a/drivers/net/wireless/ath/ath11k/reg.h
+++ b/drivers/net/wireless/ath/ath11k/reg.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH11K_REG_H
diff --git a/drivers/net/wireless/ath/ath11k/rx_desc.h b/drivers/net/wireless/ath/ath11k/rx_desc.h
index 2da6da727278..3780bd909bbf 100644
--- a/drivers/net/wireless/ath/ath11k/rx_desc.h
+++ b/drivers/net/wireless/ath/ath11k/rx_desc.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #ifndef ATH11K_RX_DESC_H
 #define ATH11K_RX_DESC_H
diff --git a/drivers/net/wireless/ath/ath11k/spectral.c b/drivers/net/wireless/ath/ath11k/spectral.c
index b6b0516819a6..03af39071839 100644
--- a/drivers/net/wireless/ath/ath11k/spectral.c
+++ b/drivers/net/wireless/ath/ath11k/spectral.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2019-2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
diff --git a/drivers/net/wireless/ath/ath11k/spectral.h b/drivers/net/wireless/ath/ath11k/spectral.h
index 789cff7c64a7..b582f2c36c08 100644
--- a/drivers/net/wireless/ath/ath11k/spectral.h
+++ b/drivers/net/wireless/ath/ath11k/spectral.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2019-2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH11K_SPECTRAL_H
diff --git a/drivers/net/wireless/ath/ath11k/testmode.c b/drivers/net/wireless/ath/ath11k/testmode.c
index c72eed358f6d..21a85301bf9f 100644
--- a/drivers/net/wireless/ath/ath11k/testmode.c
+++ b/drivers/net/wireless/ath/ath11k/testmode.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2023-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include "testmode.h"
diff --git a/drivers/net/wireless/ath/ath11k/testmode.h b/drivers/net/wireless/ath/ath11k/testmode.h
index 2f62f2c4422f..45019b79fcf1 100644
--- a/drivers/net/wireless/ath/ath11k/testmode.h
+++ b/drivers/net/wireless/ath/ath11k/testmode.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include "core.h"
diff --git a/drivers/net/wireless/ath/ath11k/thermal.c b/drivers/net/wireless/ath/ath11k/thermal.c
index 18d6eab5cce3..67246b5ca5bf 100644
--- a/drivers/net/wireless/ath/ath11k/thermal.c
+++ b/drivers/net/wireless/ath/ath11k/thermal.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/device.h>
diff --git a/drivers/net/wireless/ath/ath11k/thermal.h b/drivers/net/wireless/ath/ath11k/thermal.h
index cdaf4e01d92e..15e4e97c944f 100644
--- a/drivers/net/wireless/ath/ath11k/thermal.h
+++ b/drivers/net/wireless/ath/ath11k/thermal.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef _ATH11K_THERMAL_
diff --git a/drivers/net/wireless/ath/ath11k/trace.h b/drivers/net/wireless/ath/ath11k/trace.h
index 75246b0a82e3..d43776229bc9 100644
--- a/drivers/net/wireless/ath/ath11k/trace.h
+++ b/drivers/net/wireless/ath/ath11k/trace.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #if !defined(_TRACE_H_) || defined(TRACE_HEADER_MULTI_READ)
diff --git a/drivers/net/wireless/ath/ath11k/wow.c b/drivers/net/wireless/ath/ath11k/wow.c
index f02edc9b8a9e..d6c2725903cc 100644
--- a/drivers/net/wireless/ath/ath11k/wow.c
+++ b/drivers/net/wireless/ath/ath11k/wow.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/delay.h>
diff --git a/drivers/net/wireless/ath/ath11k/wow.h b/drivers/net/wireless/ath/ath11k/wow.h
index c85811e3f42b..13dbcfec9227 100644
--- a/drivers/net/wireless/ath/ath11k/wow.h
+++ b/drivers/net/wireless/ath/ath11k/wow.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef _WOW_H_

-- 
2.43.0


