Return-Path: <linux-wireless+bounces-37647-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +4JUDoUsKmpVjgMAu9opvQ
	(envelope-from <linux-wireless+bounces-37647-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 05:33:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E66F66DFD9
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 05:33:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="QgL2yBS/";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=J+UzdLd7;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37647-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37647-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67C5430A0E81
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 03:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088182F9984;
	Thu, 11 Jun 2026 03:33:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01E12BDC05
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 03:33:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781148801; cv=none; b=lzmno3T2unEKjJkSB4TdZiiDesgA1D7ahlSs5W4Esqlrp2QdkKRzavuRxUWshORVqgnRhO83eaWVfzOaC9RJ9YQkSTe1IiTk97FnhEuiN9apCQM5UikSXEAE6W2LCU5GqD7385z7/yO9YTTQVKZzsHTQ3m4KmukrWtgJyRm+uO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781148801; c=relaxed/simple;
	bh=qJ1TtHsv1pFlSELvaimOzo5CTKc92AbkVYw+kcKIhCY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g+Q7ZklEn/H0RMTpav3nm23LVzX+um3wzWPWJHVNYJqfjJOxQK7ijEqU+2p8ssVCgX78NQ1j6YSbSCjCUmCjwY4sU7YuK5cCvOIl5VWnnC5zYzAyxU+5f52wQR5rxuUFfQHladhnNH0af/d9+Mw6JM2J5hIhq6D3HDjN1HLt70Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QgL2yBS/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J+UzdLd7; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B0NPDn3159467
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 03:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=SZBP2bJj3MzkP6d85wYve0QKBVeG+83ASUb
	pCuF2T5U=; b=QgL2yBS/JyhjRUXBFfxjWFtTI9QDbKha7+Es8zn/NFGQiOe8Czr
	d4c6cO49E/Q6vIQQURuhABSbX6OQYKY8cjPbraUZDyI1Cyh6j0p99QxGR/Y8Wt4N
	/kOf7TXfAI9SvxwB6QyAZHbCZszlkVd4YDETWl8wQstSExC+11f/PC5pXaDFNOV3
	jmy3pMUwaz7+eksMJ67J3tHbmVqPPL47rPj7nt/63PGYjoOYdaJPz5xnsNhbj4jb
	XO2Z+LJq9C1HBUzF3qt40ECCZ4l/uhlTjRcK83g7NlqacETyNGe+Sl2fxp8nLUKT
	jcG0qkidJcVh502NsPlzweQvLI4+MPaWjjw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe701e9a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 03:33:19 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36b9d265308so5600008a91.2
        for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 20:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781148799; x=1781753599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SZBP2bJj3MzkP6d85wYve0QKBVeG+83ASUbpCuF2T5U=;
        b=J+UzdLd7B/Yxd3wG0zjnCi6Nc3I4MUnlqf/vKcuoEwCS/bNAOQiJEcmM1raCcWTjYd
         hjJAzzNjjd/GlQcFQDmC3s62wv8mlESGx4+RUrrGQVyJ7Oh1d6Dppj1dnnk1YfekTeWy
         agpathZhCdW9u8ofaJGPiLPOufY8fyQyrJZOnodUsqAORPuK2n7L+i8FkWx84E0Q/JI0
         APiPzwQU9+/6fKTSqrpGU3Cobtx0S8e8jT1KsYDJRNuTAPfVN15KIrK9M2636lWn6gk1
         hpWfOkqcN0xjld61kmvyaNo2emrO9PGZOVLcTAMZ485vzDuIGNDMGQMdikWgUOtCU6KZ
         IFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781148799; x=1781753599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZBP2bJj3MzkP6d85wYve0QKBVeG+83ASUbpCuF2T5U=;
        b=V450OsZtYMw0fJMz5Qn6WzQYZi9vvB0Jw8qYwe7GdgR1197jaPfB1FfLhyrURknc+N
         BLgThWL9Kupcvl+0XFsN7umzni/WAl3WS3GmVYq2wcrPpmaEuk2ok2eOM0RfFV41a+Dv
         xgVfyTXopHxrbeRO9BdQ0PGl0Y4BII/Sm0XO0hLSEoRwDlSfWvlCYvSoNmOEzy/zrW8C
         BgVBleYwPe0qfXhbqsFPMvpZPxqyG/5HenmFk7gTreAo0zQQa8JPTvYy9rbIqOcDu4Cs
         QUqE52A7lTgk7uJDcMM3iC7sJrtn7nzDz0PBpZpPbiop/yJXxr6FcvXPujg/neTzpHuS
         Rq8Q==
X-Gm-Message-State: AOJu0YyC6OTUVFQQBmS/6L7WtWVn8czVJcqkLJZM56iU04siPwvI1PZK
	BJBMdQ1y3aBy6MhbglBHrIY6Aty5xpl7ZeaQoBlcJ43OXOE8RxxFKqoUzLAe4RqgQqu1YA98dsX
	ZsJQtAy6x3/lU0aP6XWXCAIBhdsQNxu75ivcrrZFjJgwCrZP5pxDWRxoH2S1n3OyajFT31w==
X-Gm-Gg: Acq92OHE0bZ7LBTkNeNqFxTHwtcMH+dPp116E7v8E+24PjW7rJHNT5EPBBsdXiRMFqv
	4DgeaIxfJB+7SutcBvfqeT0iUifXXWL5NdO1YMKSPyg8REtipd/cP3YLOAPhA8oaRNNbi3uTGrM
	RHe8wu3oaQXZRZRVDGg93/bvdAnlC62wQAFkHM9+an+2sq4WfzTrtaHjHdfXDTU87Kn/CQcHCWw
	CZ/8XbAgojqlDPvbMX6lBV94pMZDp9bH9B0VBVJMhju4SguOcRBKA/OAAZMDmX+z0ooR/I1wfTg
	4AK2RnE+sD86ySVqAdgnLMt+so8FH+/DUR/TQAmR+m55mvUYGbLR9RCui3lUMiiYFadILEtUhMd
	acFKwKhlXix2zuU2mEI950uKaCxAprpM+jESz/9cuY+xscRsUjfk4cYrp1yqzUo7EG0tcWZffX9
	Y70X6+ENKm00nYTqcujxSHMoJ4EybbTvaHDyxLSEniPY6/amd4H0cqwJM=
X-Received: by 2002:a17:90b:4984:b0:36c:e254:4d5 with SMTP id 98e67ed59e1d1-3779c569455mr1173537a91.4.1781148799317;
        Wed, 10 Jun 2026 20:33:19 -0700 (PDT)
X-Received: by 2002:a17:90b:4984:b0:36c:e254:4d5 with SMTP id 98e67ed59e1d1-3779c569455mr1173511a91.4.1781148798864;
        Wed, 10 Jun 2026 20:33:18 -0700 (PDT)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3775287186dsm896041a91.6.2026.06.10.20.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:33:18 -0700 (PDT)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH ath-next 0/3] wifi: ath12k: Fix memory allocation and improve reserved memory handling
Date: Thu, 11 Jun 2026 09:03:11 +0530
Message-Id: <20260611033314.2330-1-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDAzMSBTYWx0ZWRfX7WhzVlJwKXss
 bdDRh5GM0Pj7IBssGOSD/VqfsL1P2N4wju3q3JICNvGz2LA4uJ9uSTnvVZOH3wP0B5/Up8SjRi5
 ojJILKNV2ezdH8lWLYUFoI7ZzJ9yc3NjVXIhPi6c2tNFdyz+7lkvSRw+ic+1/xHrkr0ccUHKcWF
 pkJ7tnj/i3piCk7qLud9r8YkY4XYz8IXc1XRh+MeZ+0HUc8qTlVTr/mO6mWoUSlZ71/ad9Wy7It
 z7RdyvNzinmsHqLTIO5hGQn+cB5eRv6Fhl65b5tRyNQAeAYCeXgG8DeFxlTQHnzPQ/ZgPDDXOxd
 cV1hSlJxHe4ynS3CiGUPbrMHAjQ29Nry0FDZkI4U/jQaKQu4KCwEw13G1S9EIgi3DRRBzJkYMVN
 /u+Kx1c0MtQtYl9M2pdLQexjBdirN17o4LEwrE5P4vfVt94AFHhODbWC3V+1zZkspyasWY5z8+9
 4HIn0T/+/Z6/pFogEkQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDAzMSBTYWx0ZWRfX5E2ioFI//sFr
 iI+peS+vjZbMgbNGyL89D588dQyjDgJ82dGoB5K0W0mKMRbiNstEIFF103G80rTv0tAEQ0W1PUf
 HaT3/KEHuVvXICQpaokEo+2IZ6vjV/U=
X-Proofpoint-GUID: y-6aGBUXiFO5sZd9o86S3AO6Hk5EAKF2
X-Proofpoint-ORIG-GUID: y-6aGBUXiFO5sZd9o86S3AO6Hk5EAKF2
X-Authority-Analysis: v=2.4 cv=Z5Tc2nRA c=1 sm=1 tr=0 ts=6a2a2c7f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=tue8EDAknadLuvyRn9wA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110031
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37647-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:aaradhana.sahu@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E66F66DFD9

The current implementation relies on index-based device tree reserved
memory lookup. Different platform variants define reserved memory
regions in different orders and combinations, making the index-based
lookup fragile across platforms.

Currently, the driver allocates the HOST_DDR_REGION_TYPE
starting from the base of the Q6 region, which overlaps the Q6 read-only
firmware section. This causes firmware assertions during QMI memory
allocation, as the firmware expects writable regions to be placed after the
read-only section.

Address these issues by:
- switching to name-based reserved memory lookup to remove dependency on
  device tree node ordering,
- refactoring QMI memory assignment logic to reduce code duplication and
  improve maintainability,
- placing HOST_DDR and BDF regions after the Q6 read-only firmware section
  using the bdf_addr_offset parameter.

This series ensure correct reserved memory handling across different
platform variants, prevent overlapping memory allocations, and maintain
backward compatibility by reusing existing reserved memory region names
defined in device tree bindings.

Overview:
  - Patch [1/3] switches to name-based reserved memory lookup for platform
    compatibility.
  - Patch [2/3] refactors QMI memory assignment to eliminate code
    duplication.
  - Patch [3/3] fixes memory allocation to place HOST_DDR and BDF regions
    after Q6 read-only section.

Aaradhana Sahu (3):
  wifi: ath12k: switch to name-based reserved memory lookup
  wifi: ath12k: refactor QMI memory assignment
  wifi: ath12k: allocate HOST_DDR and BDF regions after Q6 RO region

 drivers/net/wireless/ath/ath12k/ahb.c  |  18 +--
 drivers/net/wireless/ath/ath12k/core.c |  25 ----
 drivers/net/wireless/ath/ath12k/core.h |   2 -
 drivers/net/wireless/ath/ath12k/qmi.c  | 168 ++++++++++---------------
 4 files changed, 78 insertions(+), 135 deletions(-)


base-commit: 83f028be15fe071efbee8e27837538d6cca77e87
-- 
2.34.1


