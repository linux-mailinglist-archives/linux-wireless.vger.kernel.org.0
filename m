Return-Path: <linux-wireless+bounces-28632-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD5AC3728E
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 18:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63F065602A8
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 17:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595A63328FF;
	Wed,  5 Nov 2025 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ivMvtIxW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Buoi7NJ5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35E32248BE
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762363352; cv=none; b=ZFAMnOcXdU1rVpP43LA2bLLHH6Ld0EljzYuRgg8PLjj0Dl0yLygTsV9N2QXtMwITO4oOZF4jfMj3gvsHT4q3SDK4LUzPulyPKHsOkhcrhL4++2U+v0DrOYll8IJfFNFnugYKcinlWkK9Jdn9VuLAVFziEfJqU2gfRUl0rzM9yZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762363352; c=relaxed/simple;
	bh=gTzO9ZLz/gkWRMxADXfShEqG8Uk4ovzbXbxRfh2LddY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bAB3kCKFmgzzwaQR4pfKe+z3z1l1yf3GnF1iy1JGBCrpnA1lQYVeXbDnDsTwuSksZI2rFoT74SZfenKAAWbsZiDVxCOlUQEQBSMkKJNnS6Ru0Ue6KOBqUV+KSUTQCs8nyzRvoNvzs2BK4N84xHrPDT7yJDoMZNvVS6/9e8hvS/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ivMvtIxW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Buoi7NJ5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5B31MF655017
	for <linux-wireless@vger.kernel.org>; Wed, 5 Nov 2025 17:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=U+YUYIU9pHv3xXIvUkPp9A
	DNA4qZc7XK8z6vznVXTVs=; b=ivMvtIxWESCNmyu/GgAvo+qFhK8pZqvjYvrtdW
	KrdvKIBoFeSy2hEs+JxyxzBr5LVIPA8oT3Ec/LZ7G/co7yQFti07gc11vvqbgG0S
	8rcDLsG6FuI7DgeD2wWFv85FlcfEo3j3tQNy/cZnuCOCXJVUBU8TpVd7y4kl7fR6
	s0myNNww2eXyC5rYO8HovjgIjPWK6oQ+Hsn4V1QthzwXsfYqJ4E0SwYYPPBJaBcM
	N1d29lOKmtk2ZHrbBcU4wXA6VYaFpsFpgrT1FlTAwlz7OsSEa34BpHF6PaM4HT3G
	9yYL8MiQ5DgCM0vbn9LPrH+wFknzpUDaB8vpJW+iNCZh4FrQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a85c8h2n0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 05 Nov 2025 17:22:29 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-ba433d88288so9395a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 05 Nov 2025 09:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762363349; x=1762968149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U+YUYIU9pHv3xXIvUkPp9ADNA4qZc7XK8z6vznVXTVs=;
        b=Buoi7NJ5Ywnn5i6hXgrAYZ3QrigfpC8B6yyhvSP2zGjJtBWaAEvDvHjxP9i+0tJloI
         auPbUfv0hh0QSLt9wxOETYpiBMavkUheBMOkfEZXld2HuwvITl2N/jomRjGUf40gHgSi
         iUB0Fdq/e05NnYYakHVKt9EC/P9FYcypgUkJT87HN5sRL7A8QOPtehLhDjaedIDfSa1+
         aDoyutJEDi2o1Wc+c0FI27qxRyyZMBOKBArWazr4dttogNONXnqHfjHXFn/v8U9ryQy/
         w6gq+cX6y2YXjQeipCQGIK+gCETBiI9WIIKGw7icQChZFUiMGdIM27SZk0bm7jUK0Re8
         Zm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762363349; x=1762968149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+YUYIU9pHv3xXIvUkPp9ADNA4qZc7XK8z6vznVXTVs=;
        b=G59on7uyGHxEzgJsw202kYZZYuHs4FzCSMTcwK8t5UGVDpB6Gp6ZnaUM5BNPXawXCd
         UK+7v/Ho8kjxWcrbmATXiklWwGWkFDV0pmz3gY+m1uVAAzXPmqAYW8uRGr3JOrMElBBU
         GgAUpJXOBOQ9Wrd7i8zTpBfTiTtXqsLVWzcOh2gwtYqymRRZ3RCaO7Xj5gNlAOMfaQ51
         hECNR2KIQN0tDVcl90pvj2gig0sVI+kExC3AHRCEvHZYDWQaFM7m4ob2jWtvHp8c831Q
         3vp1+yQCBDWYaZk0qOtNACJ9d0mBAUu0cAPlztWR722rXu+1gfjRLevlPebQIFplBDpC
         jaAw==
X-Forwarded-Encrypted: i=1; AJvYcCUy2aR2OtiDIgV+aiKKL24gYEBtYodzQ7zaCMN/6oAZPlyfwzfE0Fhlnc1ILTM6/R/HWPNzrxI9j/iZLZxaeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2I+MVNgwlRGZw7Lh3muUrOthcOdV6X1gtZoh8m52U/lrOpKBr
	6VWuU1eVhi7ofjLUHlg+n0r83Rox67RQSvhVmzNSzr65htq1+HJzg5/iEg3TuFMbadsBphbVMn1
	HAj76DPagULbc0yFt980+Y+d1i4/Z7RRRAfQd9aXLV224c0yIhgQ28ZRSQmNUXc/7afo1Kg==
X-Gm-Gg: ASbGncvcNwrA42+2D6/GUgMde8DyJebjYre1ymO+XqnLXUk5JO3oW2+zAi33ihuJmi2
	Bj/EK87MSqTxl74Yes4gqmbEzcanqM1VQ6vD0QbcFLEIFNgIVuVbeIUfshRnqmNLrCFwqE2m/9C
	jX9pc67G5/pDzYbx3A3VPiyS8j06xpkh1bmThIGF1SqYiNQlyCbD0smkHZDRAerDAxd9Ll4oCTf
	gKdwuTQPc6yA9AILnOJkMzESTL1M3d+l+1GlOJSJl7mXyvQaNUAenm1SpMrcf+VCGPqQoN5lei4
	Ft+vQ/E2bwYBrARZbxiTkarpTlLQAziUl6pE59YOOdzhs3r8+WaCgKkefnA8bDVdhn3xdH4rPXl
	btbNB2ILhC4UtNKsxjoYdb7OOFW8ewBt7Lxxb2wiF7o3U
X-Received: by 2002:a05:6a20:7484:b0:33e:eb7a:4473 with SMTP id adf61e73a8af0-34f846fdc8bmr5054421637.23.1762363348395;
        Wed, 05 Nov 2025 09:22:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZwVfSw3eIQPRT1N/Rx23JfWFgBnMquNlKK4SWJ6as0e82cODYlNwm+u4AWn0nKCkC7l45OQ==
X-Received: by 2002:a05:6a20:7484:b0:33e:eb7a:4473 with SMTP id adf61e73a8af0-34f846fdc8bmr5054375637.23.1762363347827;
        Wed, 05 Nov 2025 09:22:27 -0800 (PST)
Received: from hu-yuzha-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af48d83c20sm518014b3a.62.2025.11.05.09.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:22:27 -0800 (PST)
From: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: baochen.qiang@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: [PATCH ath-next v3 0/6] wifi: ath11k: Add single shot/periodic CFR capture support
Date: Wed,  5 Nov 2025 09:22:20 -0800
Message-Id: <20251105172226.3182968-1-yu.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Gp7x_WfmD3wOJM5XVMmFRld85pHhSvdp
X-Proofpoint-GUID: Gp7x_WfmD3wOJM5XVMmFRld85pHhSvdp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzNSBTYWx0ZWRfX28Heez83+FFS
 Oe1LaUyPKK+VkiRKYa56vf6IYrtimnoB5wdmboVvVqaNXBE7I90dxTmxgDGNFDOzqsMRoDsfiyj
 We5xxw9wSWBq3FCUCl18NwZY63bYZLyA0CRg0mUMxOiwhvrl0OdDmfEJGzJTun3+N0ylN3d+lfc
 HN36VLe4/Z7Qo+zMbtrLazsjWvXp+gA/UjLfCZYzkHHURPEobyE3G7hgU9lP8q4vuv4rALcHtD+
 3/zwnlkwuyDFapMuI6oLdHxhlfVPWVEuW7QnJUd3w8Z9JM3ZOutrpUWtPQPl3ey5YL5TFT27m6k
 pmQtTQ3f1nhYua6NM2mbw5hN5XoiOn3Rj/A40qazQE0SzBzuw+XrkY9kdSIvRhPN6kFhK/zdMMI
 PdjLsEYxzFGPPo0LcuHvhM+qftPIqw==
X-Authority-Analysis: v=2.4 cv=apS/yCZV c=1 sm=1 tr=0 ts=690b87d5 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=DEz-XpLMnQOtgUD9lTEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050135

To enable/disable cfr feature use command,

echo <val> > /sys/kernel/debug/ieee80211/phyX/ath11k/enable_cfr

where, val: 0 to disable CFR and 1 to enable CFR.

To enable CFR capture for associated peers,

echo "<val> <bw> <periodicity> <method>"
 >
/sys/kernel/debug/ieee80211/phyX/netdev\:wlanx/stations/<mac>/cfr_capture

val: 0 - stop CFR capture
     1 - start CFR capture
bw: CFR capture bandwidth
     0 - 20MHZ
     1 - 40MHZ
     2 - 80MHZ
Periodicity: Periodicity at which hardware is expceted to collect CFR
dump.
     0 - single shot capture.
     non zero - for Periodic captures (value should be multiple of 10
ms)
method: Method used by hardware to collect the CFR dump.
     0 - from the ACKs of QOS NULL packets.

To enable CFR capture for unassociated clients,

echo “<mac address> <val> <periodicity>”
 > /sys/kernel/debug/ieee80211/phyX/ath11k/cfr_unassoc

Mac address: mac address of the client.
Val: 0 - start CFR capture
     1 – stop CFR capture
Periodicity: Periodicity at which hardware is expceted to collect CFR
dump.
     0 - single shot capture.
     non zero - for Periodic captures (value should be multiple of 10
ms)

To collect the cfr dump,
cat /sys/kernel/debug/ieee80211/phy0/ath11k/cfr_capture0 > /tmp/cfr.bin

Previous link:
https://lore.kernel.org/all/1645005922-7252-1-git-send-email-quic_vnaralas@quicinc.com/

Signed-off-by: Yu Zhang(Yuriy) <yu.zhang@oss.qualcomm.com>

---
Changes in v3:
 - Update related comments. 
Changes in v2:
 - Update related comments. 
---

Venkateswara Naralasetty (6):
  wifi: ath11k: Add initialization and deinitialization sequence for CFR
    module
  wifi: ath11k: Register debugfs for CFR configuration
  wifi: ath11k: Add support unassociated client CFR
  wifi: ath11k: Register relayfs entries for CFR dump
  wifi: ath11k: Register DBR event handler for CFR data
  wifi: ath11k: Register handler for CFR capture event

 drivers/net/wireless/ath/ath11k/Kconfig       |   11 +
 drivers/net/wireless/ath/ath11k/Makefile      |    1 +
 drivers/net/wireless/ath/ath11k/cfr.c         | 1007 +++++++++++++++++
 drivers/net/wireless/ath/ath11k/cfr.h         |  302 +++++
 drivers/net/wireless/ath/ath11k/core.c        |   41 +-
 drivers/net/wireless/ath/ath11k/core.h        |   19 +-
 drivers/net/wireless/ath/ath11k/dbring.c      |   50 +-
 drivers/net/wireless/ath/ath11k/dbring.h      |    8 +-
 drivers/net/wireless/ath/ath11k/debug.h       |    8 +-
 drivers/net/wireless/ath/ath11k/debugfs_sta.c |  143 ++-
 drivers/net/wireless/ath/ath11k/hal.c         |    3 +-
 drivers/net/wireless/ath/ath11k/hw.h          |    5 +-
 drivers/net/wireless/ath/ath11k/mac.c         |   17 +-
 drivers/net/wireless/ath/ath11k/wmi.c         |  147 ++-
 drivers/net/wireless/ath/ath11k/wmi.h         |   97 +-
 15 files changed, 1833 insertions(+), 26 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/cfr.c
 create mode 100644 drivers/net/wireless/ath/ath11k/cfr.h


base-commit: 059ca8fd692b67a77fb89e9d4e8f57cf08e32b08
-- 
2.34.1


