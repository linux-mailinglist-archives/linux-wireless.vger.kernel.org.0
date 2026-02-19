Return-Path: <linux-wireless+bounces-32033-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCaiIsJnl2nfxwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32033-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 20:42:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC84E1621BB
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 20:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF4D13013B6E
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 19:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741CB3093C3;
	Thu, 19 Feb 2026 19:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d/YoCMPy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hvsRFWe1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428A2309F18
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 19:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771530174; cv=none; b=lir8NR6bxMo1MZmUDTJyWtTxNETNLOHB5E8Vv6NSrG9FT1Ziqb99r7DBrQyoWL25ovmgLK1wjHB+cKyQ4eHhT9fo7I7RrkTmL4knxrGz1V5VyqUePRRtSSiVBVy7DOZ74JoyfO5DtfppZt/2UugOD/XoYmANJaEV50ILMMyVdqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771530174; c=relaxed/simple;
	bh=cpM+L/riCzLmjyPoNanntQSKkyDU41/tX5tw1oGc8/8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u6E2CwibIgpe7ILjpROWIcT6Y68iuNNiDxqx5zTrbpLyoiFWwwZ05dOYW/WXhDgAFoRK2fpR4EhJVkGey5pdp4z5JacaWkTHGwfxMpq0sUAqRtDf+JrJxr77CSiZNJWFFWNQHxdzBAq/RtTud3fE0YOZ4C1dSyMZLfiivBRiDk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d/YoCMPy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hvsRFWe1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JJAU592006133
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 19:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=17XK3meZ03iUdZqQRtoxox
	HX9Zd+qrkGcSktTTzYFBM=; b=d/YoCMPy3dOPOftDx6PKyh5Y831zNqbl3bgSE5
	tNQsbdMlSrX0VIEyb8wsG2NCoR5XgmamsqgheAxCxsgFtCOtIwvtQnWvAjhZZOWW
	KOqhYOdZa1uc+j4vO4CzzHD0zhsqe6/Knu3CjsAinJ9mQYxt8rNq1cYm5lZecwfY
	K3wIginPCaUvDsixSxFO4zHKzqF1hrIDgm5UiYBxiAI8r3uMJdCVXoHWLNQi/MM1
	+iei5YtJSncVUWWdC4UWIv4/Aj1d0f53feS9bZIIofS0ta4vIqK7PHPMVfzKkaz1
	S0xqLnF3p/0xM8vo+uo0i1OyLH/873tnxfhm5Jfg0xtjiNEA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cdn1qk8xb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 19:42:52 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a75ed2f89dso13031675ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 11:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771530171; x=1772134971; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=17XK3meZ03iUdZqQRtoxoxHX9Zd+qrkGcSktTTzYFBM=;
        b=hvsRFWe1EAbYb3RMjaiP1p+Niw+ebu+o8ITVKBVJ3tNjU/StGkufUlATFcUzT1n+2q
         7PpOvG5Ul0aW0hHCYw3VEtlcxDWG72kjCmDasQX+LbEQVadgQDI72lOG3tGqNXwqsSpZ
         AR6DnLbu1eC1JxyTlXXDL9NBuzW1CLHNfFpXpZ+kvH76DbPiXU6nlTHtaBpuoYqGoVvW
         xEvXha95hW7y1jO/POLVuBjvv1daqhNPptL9mP61WQAcWMC07tu7kATTZ+XGILkOow7Q
         NpNmD77puts9OPvUUCFy2peMi4/0m32xft6L+8aKy5k42nJuUIP7PBShdrIYsBwaRMPi
         wNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771530171; x=1772134971;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17XK3meZ03iUdZqQRtoxoxHX9Zd+qrkGcSktTTzYFBM=;
        b=sfvXloY9IWuGA7OtLhanOZUcsdBy7cQgC/Ui+NFOQw+NVSyHcLwK8VKu+KbTOmSc1F
         MHf+mJhYzLKNPYCNviGXWPWl2piAlf82SzzpcdNB6/jPs/3O0IKmSNwf0gdUYMpnUWNZ
         6qeBzm7mq7AESKdipRVl2w5ujupYrNADXLAFIbXSWfStZVs3WByJ4Pp/cHGiBC0dd1A/
         VbSkGUotr0weAH7E3g1pVoSSxtV5ZJ6IrXAya9oHTLmN0HlVpIaq2u/HMmtwPnGYedpI
         GiTQaIEqfG0KNEfsz/AUN9xC4h0sxahIbaK7wJVdbQT2VTLE5HMAUdqbE7JAoL0cPd68
         fPTA==
X-Gm-Message-State: AOJu0Yz1Q/Wg1BRa+6mFkG3XcdY5cTIqE6luZpwah/uBlQX2Sk33N1ks
	tCLqpP5dXtLY8TPbZr7FTayfLPYMFhJ1ycUPK6MwXQZ+34xYamBVaQEZvIZ99O1BwXjygBNjnKb
	jEwLVkEBMdajG7HSGV88OcJw4CkZcmbQVfiZCguFF00JOu/aSBtCM7MrSWQR/v9gdiWAiYQ==
X-Gm-Gg: AZuq6aLaHAKoRutA0jA/c/ImB8lg7MqsxKbphZxZuBLQak7tZ5UJVvEukU3MnMxMII6
	y64KtJ3YmZmFSPQos5JpGE5ZH78/njcSqdRbmpGs65S+km72vnmQeiAhyPf4L48pXSKsalfVuHU
	xhmDSNBzlytBbka7P3dVcGSjX74cG5bciKvXQHOMmTKsZ2LxS9veW2KAhaGcewlByjjaaz2UXU3
	qyB6n/gfiDJqRrf0OBuUMc7LNEenlhpotxi5XLfIuVIMiFcSykOINwyysbMmtEHFjkxUPN3QFGR
	3pLI7rA25DklCFlOiHXTbGy/Cox/CNY83BfdaT/oXcIaBx6jC+/4XWz0l5h8txRgWvzvHsYPTuD
	1A//p77pBilKSXa9L+uF5nSaoCFq23CxVcWAKhWbtUuMr99tdiGfAhbBcDiEkhedyIvxsANtQPn
	vcXrchN3WaEy3s4i9NKsNiMzA3TvYusML4L+QGSqM=
X-Received: by 2002:a17:902:ce87:b0:2a9:5f11:3a26 with SMTP id d9443c01a7336-2ad1740bcaamr190724085ad.7.1771530171162;
        Thu, 19 Feb 2026 11:42:51 -0800 (PST)
X-Received: by 2002:a17:902:ce87:b0:2a9:5f11:3a26 with SMTP id d9443c01a7336-2ad1740bcaamr190723835ad.7.1771530170705;
        Thu, 19 Feb 2026 11:42:50 -0800 (PST)
Received: from hu-rajkbhag-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a712ed9sm264404225ad.20.2026.02.19.11.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 11:42:50 -0800 (PST)
From: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Subject: [PATCH wireless-next 0/2] wifi: mac80211: fetch FILS and
 unsolicited probe response templates by link ID
Date: Fri, 20 Feb 2026 01:12:40 +0530
Message-Id: <20260220-fils-prob-by-link-v1-0-a2746a853f75@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALBnl2kC/x3MQQqDMBBG4avIrDuQBLHgVcRFU/+0gyHKTKkW8
 e6GLr/FewcZVGDUNwcpvmKylAp/a+j5fpQXWKZqCi50LgTHSbLxqkvk+OMsZWYg+XvX+jb5SLV
 bFUn2/3OgTRQZZlywf2g8zwuoT+8IcgAAAA==
X-Change-ID: 20260220-fils-prob-by-link-eef176414f1b
To: Jeff Johnson <jjohnson@kernel.org>, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Sriram R <quic_srirrama@quicinc.com>,
        Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: b4uUa54Uq_X9yshkFPkjo9qrH20nnRsZ
X-Proofpoint-GUID: b4uUa54Uq_X9yshkFPkjo9qrH20nnRsZ
X-Authority-Analysis: v=2.4 cv=c7umgB9l c=1 sm=1 tr=0 ts=699767bc cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=wJPCH--AHzS56o4of04A:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDE3OSBTYWx0ZWRfXwHPPGGqjAoUU
 JdH075rIFMAFmJM6Knq7bB2jf79tmI5qmwWEIlS/YHEhI5+H2qXJ7e9S2gIsXarEdb9gdDsKzZR
 mVfX56JAJ9SnRz+/OCnEdWB2+9PBhoHtubmS9DCBxc27tAL0I/SRBg3RJc/Q/hVlpvxNAuBB9FN
 S1HLM3VaBx0wQ9pIPOUd2o87AvdOxSQoAkbc127gY35MFr+58JUEGLkEg8r3sX6Jl7lqwCLASbM
 e8EQbhhiA9zQI7x2XlH32NnfgwsnQ+0GuD2LzgdGHvPCd6mQsmmWU3+99gPN9ulN/D9HV1fn75l
 3sT2cjV+b/zYgNZynAUSur6N/2dfSVjOxfFoeE1or21E6U0Dm3+QPs2ozacM6Bs4gqToDHEsl+X
 C5jToIkG2X2J2kfV8lZwU9myJd2mdZ9HQTHrYtQRFquwM4LeKhk5dQ6fXusfwTkd+tGA1K9weck
 goSztzrOuFGDKQTEsOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_04,2026-02-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1011 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602190179
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32033-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[kernel.org,nbd.name,mediatek.com,gmail.com,collabora.com,sipsolutions.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raj.bhagat@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EC84E1621BB
X-Rspamd-Action: no action

Currently, the FILS discovery and unsolicited probe response templates
are always fetched from the default link of a virtual interface in both
Multi-Link Operation (MLO) and non-MLO cases. However, in the MLO case
there is a need to fetch these templates from a specific link instead of
the default link.

Hence, add support for fetching these templates based on the link ID from
the corresponding link data.

---
Sriram R (2):
      wifi: mac80211: fetch FILS discovery template by link ID
      wifi: mac80211: fetch unsolicited probe response template by link ID

 drivers/net/wireless/ath/ath11k/mac.c           |  4 +--
 drivers/net/wireless/ath/ath12k/mac.c           |  6 ++--
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c |  4 +--
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c |  6 ++--
 include/net/mac80211.h                          |  8 +++--
 net/mac80211/tx.c                               | 40 ++++++++++++++++---------
 6 files changed, 44 insertions(+), 24 deletions(-)
---
base-commit: 37a93dd5c49b5fda807fd204edf2547c3493319c
change-id: 20260220-fils-prob-by-link-eef176414f1b


