Return-Path: <linux-wireless+bounces-36619-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHExDSO6C2q3LgUAu9opvQ
	(envelope-from <linux-wireless+bounces-36619-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 03:17:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A4733575F88
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 03:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97C123047772
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 01:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B2827B32C;
	Tue, 19 May 2026 01:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FFmWWLYU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HiJnKatR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C8028468E
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 01:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779153395; cv=none; b=GzcvYGTAKNxrDg7muxDDItFJFsXtUy9WWZg88BVnG9G5EriAJ027OqpRktB6WBBDB7ZjMlSh5FbjwKs0rmoK32vQQft0otneClGOJvcUOSLZuaZ30TQZmqi7NHmOcbxq9eW+tFGbMucQPgrBML6vENMEtaLZ/Q8qvIsZurNx9Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779153395; c=relaxed/simple;
	bh=m+P9/H5rRFirJigWUy91D279ji0I3OdhT3cdOE9JlGo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fcYTkXNNoumP0fKBBBSrw/PGRyq3w9IuX8InMShKC19S35mCLl0CE5DQrjqUC7PapRBALxZA+4zUA1O7Wwnn2i6JMGclCIIs5GifEhMMvvp/i3r42EyTUShGcpOyEDqNrARTU7OgHG7DeME/BihP9h09RAbM9piddWeN2u9a0dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FFmWWLYU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HiJnKatR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IHVl3n2685069
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 01:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=VdxRsPjdTBsC7e7Sg3Bl18uS5fzDNNIQr8v
	SLmb2Vpw=; b=FFmWWLYU57FPP/sWa7tHOnKhGaWzkob4MiRRZvRppNylAMqDAK5
	OSsuYA8OJmOrTg6xRLNfStWu+48VEJ1IwKBGhK7N13IYiEQxF+5dHfKDsrim1eDP
	j92ohorklVBC+115bQnPj2oXODtVr22CscfjQlT+VxLHKxlcb7rpg6cN6xdpw94T
	5G38CD3JVjXDinxfnyvKQuD5PGJgHsBBF0QOIDSueN9Wy5E2d6Y4W8G+qulniJEm
	cgIzCb7TBzKn+OBYoD+OKZKT2mniq6nF9grViJb6+qYVZ+LOg+kLZAzr906engBQ
	mArYqQYDB15JfwS31dLvfTxvLk/kAUlCOFA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e7vrbv99y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 01:16:33 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bc860066a6so21612485ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 18:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779153392; x=1779758192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VdxRsPjdTBsC7e7Sg3Bl18uS5fzDNNIQr8vSLmb2Vpw=;
        b=HiJnKatRfAALDd1Pzk20f0ToL85bPIo++aAQtanovex7852x6x385yH+DjZm8qjurI
         iccoJg0sEftEmcLbgadbZnJ4FPkALj0yxNksoERW9P0wTamyHUe6W9hL3T3vtIHJidih
         KQxRnz7ttYe9m8CPSEkPU8GQXNCC7WfDAlRJfvpc1E7R3I19vGeDxnQRUsEnBWH/tMEl
         yOFg70Zstvb2GEDmqzzpIeOetLnUJIlzUnz5TO2NhNb+v5r3qipgsQqnTDou2XxyGO5Z
         9MHqiHZ4Qd4kIyqRJOR2oCy4WdqOQqE/SlwvHL5LewqcBz/qzXy/j0mxx5gPGpv7iyO4
         XFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779153392; x=1779758192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VdxRsPjdTBsC7e7Sg3Bl18uS5fzDNNIQr8vSLmb2Vpw=;
        b=eyY7MVeIjWeo8r+zvhDsSgqwVi/iyZ4TLG+ezQihVfYJiQGZItCmire0vyZrWtELFX
         iNlg/AvX4kYW5I4sDftK5027EIdl6Q15IiRWCCvQYtH/ZXpFlhvriF7BhzRtNptf6hri
         Cl6BmySd+2kBgqzZwq6Byv51ldNhFDcAgV4Ny10UKh2gNDSWxxjCqX71pMSG8MAD/BXB
         IuM7xXRHsg9Q/xL0lCemaj3eOmve5IpzzAVhB28bgg4jaZSnAKCa8bTcqfrfDurOclvn
         9922W2CWw/Tu8unNC/Vxpkn1apGJAKkt99q8Mwghg2+A5nxl3wErQZva9oxvz7u/jjOJ
         5yIQ==
X-Gm-Message-State: AOJu0YxkV4tlV2Zti01DDXBVcDvR8oCUeJUucQiiCyQ2Q90cuJoL14MX
	hkGDH0l0h7VCl9sQE5chUTkWCn+ywvPRxjIo2xEKst+iFbHsYd5HdrsG00zZVyjq+kox44MU/G7
	2PzBEyda3A1K5Td5u63klkc7fVO4s0JbjY8bwOyS6Be0OdV5vb4JA6UX9pmfwE+KCuQxvBQ==
X-Gm-Gg: Acq92OETnM0iIghE/ubz9ght3VSE9AAVk5P8Tw92NCY9pozHm5wIZnO4eIB0xx4tH3t
	uoa0S7+/1VH59P4sQ2zzyyhX6hSKL770AIdDzGub/vsru8LCPi8yKdeJeD84aFnzgy8wZncDOzQ
	4etlZ0PWfraDcA8kRx4TWjykeK1k/7EpH582O3rnHIag4EOEG/E6ODY3MzxDYYnS3BprDiZVxsz
	UHlebxgVDgHUzfrhvvCCaUvZ/O0jCWYQ8nEF4rVvn35XRZSR3MbiTcNMxACzfEtn7fElbqR3rg7
	JgvM6uWzOol5c0nfCV5zLqsLNn9rX3HSVFMr1Q4VNP7BG32aoOrp1yOtrUoQSulvAUwDMkNvGZy
	QnDkIxrMFE0WFwa14cy3jDwSwjaLxE8K0v4ITojkvY9j78wMKEhO9APSpOpRUW7Wde9r5nQlmlV
	IF3mRNfEZQHg==
X-Received: by 2002:a17:902:da90:b0:2ba:6ebe:4897 with SMTP id d9443c01a7336-2bd7e8ae0afmr202208385ad.3.1779153392465;
        Mon, 18 May 2026 18:16:32 -0700 (PDT)
X-Received: by 2002:a17:902:da90:b0:2ba:6ebe:4897 with SMTP id d9443c01a7336-2bd7e8ae0afmr202208075ad.3.1779153391987;
        Mon, 18 May 2026 18:16:31 -0700 (PDT)
Received: from hangtian-z2-2004.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe49a4sm151727265ad.38.2026.05.18.18.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 18:16:31 -0700 (PDT)
From: Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>
To: tglx@kernel.org, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 0/2] genirq/ath12k: fallback to threaded NAPI when IRQ affinity is unavailable
Date: Tue, 19 May 2026 09:16:25 +0800
Message-Id: <20260519011627.713068-1-hangtian.zhu@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -Hf8RkzrIV7qpoXQoWPm17X-9eq_PYe2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDAwOSBTYWx0ZWRfX3DfNl51Bb4/s
 QLWLrNvrdDx8zvmFwr672jotWoT2R7zG7ebKEgwr73xt5brr+aeDIsZPe4xfMK8qe1QDZF/Nb8Y
 rlo+iCvX82BW6jgb+MEujjlKBmleSKZvd1kQim1KltFQSD/jEh7BtoJfDpTVtxJcyVqUkG+gv+H
 Qg+7lJWamsQwPYKVaaCxohP8qKxP7MvHdI4EXlUpwv8RFnZUuOXfL4m5/A3h6bVdEc1fRWU4TyF
 LJlzK2BP1ZwRRsWsNTq5hqxaCxAYaMPHA+W6Oiz3kd2bU4rXLJO+Dn3UQ4P3oMb3yjufv3ucH0g
 ecoJiGVGmOOUlUmx9828WKKisA3KyWBO0DutyPvjzKRVEzvDtr75aPLjr/5LvM97ke35BXpZrTP
 Q2h4KL3p4NzaotH4lj90sY/1n8Zby8v3TnkCBlTGs3V5lOm7pUlMCSsbFevBxN9RUk9C71XXe0O
 6899M1PUgt4CZhzWfsQ==
X-Authority-Analysis: v=2.4 cv=KZ3idwYD c=1 sm=1 tr=0 ts=6a0bb9f1 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=wq-1lD5fFhYcRPXe29MA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: -Hf8RkzrIV7qpoXQoWPm17X-9eq_PYe2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190009
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36619-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hangtian.zhu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A4733575F88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series improves ath12k datapath behavior on platforms where the
effective IRQ path for WLAN MSI interrupts does not support affinity
setting.

In such setups, DP processing cannot be distributed as intended and can
become CPU-constrained. The ath12k change switches to threaded NAPI when
runtime IRQ capability indicates affinity is unavailable.

Patch 1 exports irq_can_set_affinity() for module drivers so they can
reuse the IRQ core helper instead of open-coding equivalent checks.

Patch 2 uses irq_can_set_affinity() in ath12k PCI to enable threaded NAPI
for DP interrupt groups only when affinity cannot be set.

On RB3Gen2 with QCC2072, EHT160 UDP downlink throughput improved from
802 Mbps to 2.58 Gbps after enabling threaded NAPI.

Tested-on: QCC2072 hw1.0 PCI WLAN.COL.1.0.c2-00074-QCACOLSWPL_V1_TO_SILICONZ-1

Thanks,
Hangtian Zhu

Hangtian Zhu (2):
  genirq: export irq_can_set_affinity() for module drivers
  wifi: ath12k: enable threaded NAPI when DP IRQ affinity is unavailable

 drivers/net/wireless/ath/ath12k/pci.c | 11 ++++++++++-
 kernel/irq/manage.c                   |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)


base-commit: db17e958184be9fe2b6242b7c5b7b261c0ce7110
-- 
2.25.1


