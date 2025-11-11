Return-Path: <linux-wireless+bounces-28856-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6EEC4F3E5
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 18:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 972384E26FE
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 17:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610B42777F9;
	Tue, 11 Nov 2025 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XbaScViB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JXE02eXq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFFB23F27B
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 17:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762882098; cv=none; b=MdQjcsG+H8jpPLRrLUIjPl43Aq4xZwHQcJHIGXOTua89rCpgmfSIEpcTJAFTajNr7aznpIctkTB0P7og0hLEfGuFoWuA4cjoPLxcwabU37OOm38aqeSHCwyjwLSqsz4eS10eSWCsfYkdQ8+pz7wxEBWazsXV20aEuP/YrdHFLSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762882098; c=relaxed/simple;
	bh=3V2s946jiLatnDceKD6KPhq7EruaYaSpDIDxObtof/I=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=HMGb3E5nbF+ub+ePc+syyYuLzxsovkfpuwLtSCC+pxPIUVyGjtSC+DnUM10xkzVRRXs8K6b14h+MGYfl4pFuxU95KLsA1/B/xsn2uGXeDrU5imuvPBqgsi3Rmh4/q9CdRCqazxIIV2e285xmimlx8+7XrCdsbFtADuJ6gya+K8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XbaScViB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JXE02eXq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABBGONB2054742
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 17:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=1yTPDHSc2XG60aIrPablLQ
	3QyMPBQoJr8FY38lTVHzE=; b=XbaScViBdNyZlvJaRxBTh1MRQ0m11aaITfv+7j
	JNqOsNxBJdpg7A1YVGJA8sWWsLKnnxVLnytsRzfgGP4PTxTLQIn+SutyD/8jueju
	fMTUQyGf5FDGN8e3MC6GgFVVotukYEDuG/Zuztu8IB31nKmRu85Bbat6C3Ch7qDA
	bMCWfeJ6Aqxyb2YieHsKOYT2eVSGF2WeV5NJECQdHZ7ez94T6c6tZHEucaT3Mzs4
	OU0dLnUHLnUb2U/4WlNEdYm4IxcdY8XXyRDbeHNwFOI3o9gPhW65JrLU3Oka8Mnt
	N6ZdOpW5zQC0th7teoBD57uURh/aXsZT1bS6Oz+ceULJ14GA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ac11x1pce-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 17:28:15 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3437f0760daso7817023a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 09:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762882095; x=1763486895; darn=vger.kernel.org;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yTPDHSc2XG60aIrPablLQ3QyMPBQoJr8FY38lTVHzE=;
        b=JXE02eXqMszYgDcv+BuHZmebDcIetCYi4fjK57ts+aLHdEoWjtTmsAloeCzx6btPi5
         Hklx9lIJY9tG0fnLIuN4Er7ejVBrU8fbUIMhFPR6aE42XpUgYbcP4Mynoh5GFwfmtk0t
         5kZzvBiff8kqK78HIOaGmfVGf9GCfpH7fg885HyPkff7BpokhfAvspJXK77px0ZgugiZ
         A3qaGzOp1Q0Z1oZSHyphlPXnylDMtWwp8MJLegEafY4ASn6CCnSs9L0rzLv0qYCeBsKZ
         zQ7bGwK/Hui5WVRlxYX9iTsppYMXLANgDXncd7aCeEMNYudHDmWKz4iGA02qyLlw/PY+
         O78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762882095; x=1763486895;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1yTPDHSc2XG60aIrPablLQ3QyMPBQoJr8FY38lTVHzE=;
        b=AaLHFSI8PEj9Zl99F0yq0z7i+UQTcBLaddK5qvovxm5rVwJe+lcgizCrsKqfC2Ferm
         5N33GbhLXMaBWOc/hs+ZZqTvZPKFl1A674vZ17Fd5HkTb6c94NJmF75IqaFxpbEcvpsi
         7bQZifkP08HiuMgfpYXh5qyXyWkxzaOQQUWfqNvL+c0BWvWROzwAIre5wS1EcpB9OigI
         xDc5Rai6g49d8W+Rp7YkIhhnOO2vlBYG9fBvsAg9MnXPUynl4j8Bky84qtw9blTITqzw
         jf6usJ+c4h2mW5kaag6RPxh9hewMWzhMRtzqXmWUPu8e/pBWOFoP7mgW+aLgK0e9CdYk
         D3PA==
X-Gm-Message-State: AOJu0Yx69a/GqjRYBXBk726Iia8x+fjN/FFEZyZmfisQL7lF9KuH9Lnm
	seE1jXUSX0pkVFZbFN4Wlr1B/oxrsb47XX8S1KC1q1ZlTefjib5Dxo4Xz7h4LMsXvmzLC8uwAR5
	asenk71pbL2XZLOG8u6qzQFip1mCwSXT4y+s4+8Cg1x8Komf4KXWUgGDGguTsuqX5ZK+1z7pJW0
	WLGw==
X-Gm-Gg: ASbGncuJwIfJ/SXZB9PNTLO5RlVEUleS861h4R2lqdx1saxjIPUKYIl1SGMf7cn3QkJ
	OjBsC9pq56Tfhk9NrixL4I3MNfKelMdfUnIYyJ3KGA22KgvnzDgP4DCsROZcASe97l5XX7fz2xs
	6UCXsBPGZQ+tXezU0NU7s6yj70mcQIku2fx2gnToM/aIaouEBVWYbpavS5+oTm4eAYX+y2GF0PQ
	PsNxUT0PtPT357KoGVqYYnsK7tG2jBWPF7YoyY4iokuftzR9xpx1RpyV6YLHvAChCQoLJFBd1mV
	F4BujBskDSMMb4d2xQhOxxoT4QJvVa1JItYAomKvBhBinhlvQxhUIkYL0H4QbjWOqPObVLekRL/
	+OrUnVPAfVuw1VZO22Gw0udBrARl/Uw9vFEA=
X-Received: by 2002:a17:90b:4c04:b0:340:b06f:712e with SMTP id 98e67ed59e1d1-343ddec5998mr119189a91.19.1762882095000;
        Tue, 11 Nov 2025 09:28:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbddsu6FdKyudkS0lKZNwLRY1hL64MQLZC+zahT2rFZHB4c/OuxDy9ljnq3D8WemPe/3hrNQ==
X-Received: by 2002:a17:90b:4c04:b0:340:b06f:712e with SMTP id 98e67ed59e1d1-343ddec5998mr119160a91.19.1762882094449;
        Tue, 11 Nov 2025 09:28:14 -0800 (PST)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9ff8538sm15987444b3a.28.2025.11.11.09.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 09:28:14 -0800 (PST)
Message-ID: <15a98cae-0274-45f4-9b8e-be6fa9720884@oss.qualcomm.com>
Date: Tue, 11 Nov 2025 09:28:13 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
Cc: ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, jjohnson@kernel.org
Subject: pull-request: ath-next-20251111
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDE0MiBTYWx0ZWRfX9AB8PZQUWG3Z
 2a0q56yoNwuyNyVDGGu2kMlND/z6xQ2kIbTboRfG2/m+3lFq6UWL2ZM0o29b1TWoFZNVZK75YGJ
 hKluT5tKOPt+wuquh5gtWuNazl4jCWNelxkzlvp0/OA4hAZ1fM+cozYVhNoe2KKm9NkuPukEJiX
 pQtl7Mc5jT4ynHF64cn1dUAk6TuPXaC52oYQGE5gNT0AQUXcjanhKAgUsDsA8uosOBGZOiFko+d
 JXauM7+iX1jtFBebn8IVtxYOyYO4jH50GiL34opfaQjFr9vXBo2lkHriSHEZbGXUX2C9x+y4f4e
 l7o/mZ0MFwjB5LKq5maB+3mcjUEM85M7oAJ1dxoFd+gEZ3iD/cTbsWwo10i3kgJj1B1S1WKXvYf
 h8jWWJm44IHewVzkR+FWpKmMSc4tmg==
X-Proofpoint-ORIG-GUID: _BBRUZCtfj6tC86KWqbvGNjH8pn4_io-
X-Authority-Analysis: v=2.4 cv=L94QguT8 c=1 sm=1 tr=0 ts=6913722f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=Z3JRDe02xMfDgAAcrXgA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: _BBRUZCtfj6tC86KWqbvGNjH8pn4_io-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_03,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110142

The following changes since commit 2f6adeaf92c4ea4adf5a91b87497ba13bb057996:

  Merge tag 'ath-next-20251103' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath into wireless-next (2025-11-05 16:29:11 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-next-20251111

for you to fetch changes up to 2977567b244f056d86658160659f06cd6c78ba3d:

  wifi: ath12k: Fix timeout error during beacon stats retrieval (2025-11-06 07:33:31 -0800)

----------------------------------------------------------------
ath.git patches for v6.19 (#2)

Just one 2-patch series for this PR.

Once pulled into wireless-next, ath-next will fast-forward, and that
will provide the baseline for merging ath12k-ng into ath-next.

----------------------------------------------------------------
Manish Dharanenthiran (2):
      wifi: ath12k: Make firmware stats reset caller-driven
      wifi: ath12k: Fix timeout error during beacon stats retrieval

 drivers/net/wireless/ath/ath12k/core.c    |  2 --
 drivers/net/wireless/ath/ath12k/core.h    |  1 -
 drivers/net/wireless/ath/ath12k/debugfs.c |  9 +++------
 drivers/net/wireless/ath/ath12k/mac.c     | 15 ++++++++++-----
 drivers/net/wireless/ath/ath12k/wmi.c     | 12 +-----------
 5 files changed, 14 insertions(+), 25 deletions(-)

