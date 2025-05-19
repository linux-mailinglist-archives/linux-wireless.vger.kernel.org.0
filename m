Return-Path: <linux-wireless+bounces-23144-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A38DABBA15
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 11:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A5C8C12E2
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 09:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CA2270555;
	Mon, 19 May 2025 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kKKAZkPI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4D8270563
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 09:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747647779; cv=none; b=RNIAADkKiTNoZh1WH0IVyyUUyNgdMTnNF2Tz4NhonZFL2SbbHusDqnXKTWLyIvpsb0EYofaZN7PFMFGejcap8fl/cZgUxXmoNAgB0iyq7UzHgt00ILwrHAxxzZkkhcn8IseMn11Oo26vDlKbVopvPx/+zCZxjfwJi+hjjXFD604=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747647779; c=relaxed/simple;
	bh=MfTQ3eSGE1lsQsEKDfhk3n4vHJQjv6X96tSeWcGlv9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sVvBzbomlsIF4Z6zs/vCMgatHVp2n4FURYuZCEGYtj0pwH0lgDQlYFV8Xp2zrZ0livisGya28gzd/xM9KZoEJXln7spGQR4goynK9mmrf0in3hVQYyeDxNKoYz6/ZL82tAnVDyw4mYOYnVpNbWrz5GXbC0pLCKc5kFWsFfVnIUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kKKAZkPI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J98DBa029025
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 09:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J1/73SEf4ytXoZ1yrIlcLZ+v5wHcPMuVTgw0lx2XQTo=; b=kKKAZkPI6RNDjmuv
	H7XiYRa14vGzrsv8xoWeuBl5p9PkYLjXZjfgj2farMRVSOKTrJvtAcSUOyZIA2Tk
	gr5SDApVc0yZ0cBJOS7SeY6oPQ2zdxwlhpK+ovGFSxvdjNjQCp2yQlZvREG2nawD
	FhG+siBqr34WwgYXCOik3NDK7Vhr+FWyQEbvuqCOabyK6CPzTJTSXuoO9u+NZ1j9
	gDskj05FmwZrVo3Q2wxMs2/6QkIJ6cW0LTb3BL1mSP03wku10Glv4rib8/lB9PTX
	bx7UU6sw14ByggecxvDtPmriXj7Yzje8EdBnYEVYZEwptYv8/jjYGF11UOUi9P4d
	bknKNg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pjm4uw1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 09:42:57 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-742c6140589so836205b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 02:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747647776; x=1748252576;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1/73SEf4ytXoZ1yrIlcLZ+v5wHcPMuVTgw0lx2XQTo=;
        b=ewQoCQVnH3h0z8U8sHSTamFvUOr2cCptWxgM2GMuahXpROdBznwpZ+mIxr+eopcxte
         UXj3cTxLllT2m7NTpVwtFBOOJHAtyJz2+nn/u/4VHeSQUvXzKB46UXYd4E3s5t9nePgd
         BPktNLXXeARqjUh7MnvfuCD0gHKQpA6d6c1BHKI9YUZkzL+KiLfJD77r+imM8hX1R47R
         2roNNoOYxYXhfPsq3jDRislgwzPPlsGaLT44ofasinAVR8lI7dOi/nwPeaei+qv28Ymq
         6za2qdsW3m4CadJM97n9mEIJirzTp+7J8PPfJybyxD7LP49+MkQrhSFzGdmjBCPO4zOK
         Afwg==
X-Forwarded-Encrypted: i=1; AJvYcCUOpgub+YFkmOcTG9Yp9vZGdncoxgL4wsBaqeHHvRanxXdZ+CZF/SVBL0ysfegVywte18ZbuXGetB5BM0ba6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YywV87igaOio5i3f5Bh0uH/9hAL6LXkzrAbd8YfQ/C6PDcLXSSe
	kpRBI9sF/cGdYkHgmPlwPCO5DwsIeHNmkAayH+nD8Z/xCFpxxxJx6zVsYjypXbAGtPMQQ0Mpf8Z
	ZZF84PmID3ZMO4Lnsc3jdhENer1RNoPo+GEeAthgifDFNw/j/LXQ2Y+8Ox5gEzO0a+PVQTA==
X-Gm-Gg: ASbGnctrG1dHq04nKQOYspd9iascrP2FUa0V9nU9woECdfAovlTJyNWenLTz9+7maG4
	STKEQsnaioy6mMHnYBMzDzP9qBMplo2IP0s+lrUPMXIxx+sKEABLDA7buuQf/ohDg2Wuf5UObzb
	C1NcP/cGjY0wAYt2QtV42xiF01rQ5EN4OqUOg089tt6Uc/UxBabUzsaHGjoGU9BrtYPUSC3BUmE
	alTsQYPfvyZ2ZQ6gOSbaRK36INnGSa7S9+t0dxLtTwMw3q8i49AJVKYCm+n6C4y3n29voAvhGw4
	b+lU4BfO8PXT4MsWABtGmbbQHg5URGeQ/Soj2a9Bp6iD0tQ=
X-Received: by 2002:a05:6a00:ac1:b0:736:3ea8:4813 with SMTP id d2e1a72fcca58-742a99fab76mr15619572b3a.2.1747647776274;
        Mon, 19 May 2025 02:42:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6FoWtfS3J3KvBeQkijcvhEZQEo0F73rDNyaSDtfdrDQW3C1qk8ZesN/i6Mh3j6GEYFvr+HA==
X-Received: by 2002:a05:6a00:ac1:b0:736:3ea8:4813 with SMTP id d2e1a72fcca58-742a99fab76mr15619544b3a.2.1747647775854;
        Mon, 19 May 2025 02:42:55 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a97398f8sm5809092b3a.78.2025.05.19.02.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 02:42:51 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 19 May 2025 15:12:17 +0530
Subject: [PATCH v3 04/11] PCI/ASPM: Clear aspm_disable as part of
 __pci_enable_link_state()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250519-mhi_bw_up-v3-4-3acd4a17bbb5@oss.qualcomm.com>
References: <20250519-mhi_bw_up-v3-0-3acd4a17bbb5@oss.qualcomm.com>
In-Reply-To: <20250519-mhi_bw_up-v3-0-3acd4a17bbb5@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747647743; l=1002;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=MfTQ3eSGE1lsQsEKDfhk3n4vHJQjv6X96tSeWcGlv9o=;
 b=Yem+nDFvzc6dsaIOAR4b6zXLoldPziYHuM1lIowV7FV6LiFHouh58R4R3CqoekwHVIv/w/HTI
 vxXIWwGg9BDBlBKkBDVhf2SY+qlPn4lRdA9jAvQfk0MP/izsfcAVMWG
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=dIimmPZb c=1 sm=1 tr=0 ts=682afd21 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=JOcJ30pghDwnvxMqNTgA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: RnxxWsqCnL9iKyxPUAY_sV1qVK88Cu94
X-Proofpoint-GUID: RnxxWsqCnL9iKyxPUAY_sV1qVK88Cu94
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDA5MSBTYWx0ZWRfXyK9KIVT4dhWN
 4MXEnN5Z4/xBMs+mAkObk6XgYiH5jlO//CvK3UYbYNEqdAGBBoSvJVP5X1eA38uIHx7OZhpbyjL
 qwzkkngJ7+0YLtcYeIuEcc80EHxLBC8lh8cGVYSd8Xs0ckRQ0qnjiAjwV/qO8nmVTePMy23nXHW
 Nkza3XfFirQG1H5alJoINYfcvOSHcBCYQXFwu9WIInTLe9IwPNd+ncaYB12LHnJovD0xnOc+Oof
 sXRZAUVA0LO7MGtkCdLqm5p8dQPqE3wonMcKCBvKbJ2Jic00tuHymC2rqh/InNtB9qDs8Voc63t
 hJ4jTISoX78GvpWLQWnv4MQpIDggDYF+MDmLPxXBqy6U9jXKNXhDRNAex2DAgosauieUe5wu8o/
 qT6Jb1IB0tvfvvhPPdsgBRGC/sHz07of3A16O8YUMcukdhVyXwYUqtLNmcCPGR5pm3EpWuSk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=940 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505190091

If a driver wants to enable ASPM back after disabling ASPM for some
usecase, it is not being enabled properly because of the aspm_disable
flag is not getting cleared. This flag is being properly when aspm
is controlled by sysfs.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/pcie/aspm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 94324fc0d3e650cd3ca2c0bb8c1895ca7e647b9d..0f858ef86111b43328bc7db01e6493ce67178458 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1453,6 +1453,7 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
 		down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);
 	link->aspm_default = pci_calc_aspm_enable_mask(state);
+	link->aspm_disable &= ~state;
 	pcie_config_aspm_link(link, policy_to_aspm_state(link));
 
 	link->clkpm_default = (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;

-- 
2.34.1


