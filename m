Return-Path: <linux-wireless+bounces-23994-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9740CAD5B93
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 18:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 187B63A5465
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 16:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E1F1F9EC0;
	Wed, 11 Jun 2025 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g7I16cCR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7711F463E
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749658445; cv=none; b=ZSGpKeJZoy414DlsH9FZ2fnUL8M9BAt2WdKzJTX2s9mT0hAIu6GwhnPkpx0nd0a8PfHW7P7W0usBIlU9JyhxrfrIPr8dKw8wjmQqBt1TyrHUMxOiys40VXJ29wGfhocKlNVmvYvtOlsKcLZ79kWr991mCS3y9BKk3a/BU2gm72o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749658445; c=relaxed/simple;
	bh=Gm3OVPXgn470EOMBz+eFvJMSUkApvrDeG7Z/6+fJwBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XRILpJRCVTAOmrcif8cnySV2CzmVCKiZo+QkAKA1V85NGl/gw22+pMD+5ZoS3N2yPpDjmYa4vWaNMfuTe1Az9276FSk8ScYvEeXxSa95yv1TSJWnGn7jhASZBhjp7V7Oaiy/PLFwHwa61vq+hc5ZkU4V+QsB4bpwIhl77pCGOus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g7I16cCR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B9DFdf013465
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 16:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fFtho7ENWI3L1kMm7ZZN60IgLuiwgvFjuHWZccWmsz0=; b=g7I16cCROfAeXNgH
	8KtUdf+KS7FzAM7sRJghl4Dm/PLyqnde6Vp9guqSFc7Iy+cK+ZwUkEF0szD0DIEa
	/aY6dTY8bn0ythUazLdawkZvL5KBgb/MLOd0IL8XgLCcGxQe/PzV1/wiiFhJKkM+
	jnsSmIlJF62FfnTtUih8lei6WWlHQlpESgpgez16GW3q+ct9efT8FH05hg7ouzJk
	u79d2+/TIUnZMlNWZE/pwK2fJEIRKy7PB/XvkG/g3XjoQYfmmfgIKrx66O+2cxkF
	3/Qu4i69vdRX4LvIgExuelKBK7bHL+WztPxoWDtCk6p5nYmhIaH3HuxX60r5VNPB
	BepFrQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 476fmnd7fj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 16:14:02 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-747adea6ddbso47534b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 09:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749658442; x=1750263242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFtho7ENWI3L1kMm7ZZN60IgLuiwgvFjuHWZccWmsz0=;
        b=Xj8rwfrl0CYo+SBAwgjSdPatRoDwcpkmcXdJzbPXg+gTgnb6HGVJmi5O1m+Ylk6W9S
         zC68KoSd16uPyO2/TSzIvWwv7EvqwQuhhG4tN5KYdHvxGo25bGLKHAewTDoaWNZqFiul
         t2lM1vapa5Wy6P7zv+PqKDZjXxqiDpfqCYcQcxClKpZ1CcSeMnbCqNG+jorH68bGryEU
         mmNf2ljk/L//9IjxoF6OBNUVyv5Tq0UQ+wxaHxh43cXHI+hORSyxIWsNVsz4s2UVYwfA
         SdjeGomPl84Mjcqg6yr0jW4Qt4QmjoR1C3pfRzWpH2AGP2buctW8jkSm/s3Wiunusz8d
         Xxaw==
X-Gm-Message-State: AOJu0Yx4xoqp6ABH8ZfjhPoZkZalMpN3AmvOtAbyCCndvk3cMGkgUnBN
	aitSZN2FnqEho2+N2vjihgOhALDsO+Z59T/LGWKETxtbWFaChVk95uEVaswf755FicSwBKb6NJ6
	mPg+53uAlWXvM4dRZTJ183kSRj1p33jX+I8icjQ3lkWs9ISHhnyo05fDv5DNqB02dEC5U/Q==
X-Gm-Gg: ASbGncuFp6815b0Ev4RD/JCJsX92vcpYT1QhFKWmrZIr6pKoRPBE00E4u0OrUYKB3fm
	bJpQYYotEFXEFZZF/fFENb8cT1uCtlO4aa828KQxd2y1RBphllIRQXwzBc9kDzWm9U8V4q/sl1Q
	9ryBGzf13Ff8nkr0sg9TOS7h1QH3MfJBtxoy+5dPPst2IHFeqX/BaLnD2bScRSEccPNjxVzhWpM
	Djsvbaw6HmUc/OpRRK8XsfntdoSfK+daVDelnlR38C99uPe6WLeWFVaYJe0htrfsAl3dA8RL9PY
	LtpxvpoA64BJ3RxGXaPIvbc+qLqPA8fjkjrt9ubegTB83qKovVivZORHU1M=
X-Received: by 2002:a05:6a00:124e:b0:742:aecc:c46b with SMTP id d2e1a72fcca58-7486cbd8633mr4706287b3a.15.1749658441817;
        Wed, 11 Jun 2025 09:14:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFO0qGQZKOb/hJZ+5EWYGdrvpghWgbeGHWYq9TkhEW2zl0TjeFA4FC23wTXpeMr4FHA8EIFAQ==
X-Received: by 2002:a05:6a00:124e:b0:742:aecc:c46b with SMTP id d2e1a72fcca58-7486cbd8633mr4706260b3a.15.1749658441432;
        Wed, 11 Jun 2025 09:14:01 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482cdf1c41sm9443708b3a.149.2025.06.11.09.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 09:14:01 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Wed, 11 Jun 2025 09:13:54 -0700
Subject: [PATCH ath-next 1/5] wifi: ath: Add missing include of export.h
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-ath-unused-export-v1-1-c36819df7e7b@oss.qualcomm.com>
References: <20250611-ath-unused-export-v1-0-c36819df7e7b@oss.qualcomm.com>
In-Reply-To: <20250611-ath-unused-export-v1-0-c36819df7e7b@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: E_1rpnMos-hvlQBAUEOsVcAJ6L_UuAz_
X-Proofpoint-GUID: E_1rpnMos-hvlQBAUEOsVcAJ6L_UuAz_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDEzNiBTYWx0ZWRfX61dquiCiXgdG
 bVNRiednOgqDm5mpMt9kfBpRLglPmqDHXcOWgYcRdChXPtjaYz0AI5W8j+W+vbmmjL2hYLTr3jh
 bRIS8wp7Xz26s4RdBXEoA5o2JAjvcd2UNP7TQLZZACYoBD2hjz9ENlE1xGoB6dmkikZqmuEWR6L
 OCOpV33PI8K1lsej3+T+JG6hL/DsN1ueyqGq7E/HpKPoGb5oMx92UdTVWyey6/qwlQ0VUbOyjUO
 E7yuTPQgY1wYDIMAvC8q9Ymmnh76GfSkJjJJEktwGETiTpVANVy65E2vB9r/NOEzQ3MCjchuA7C
 5dBnjPSYshMKt3+NXzg+kc+gw188aCG3EpROiMxjA1QqlhWfid0wJx/VZxzDRZ7Viscl+4uoLtT
 GEeSAd7uP4AG+tsrLeiQ4DvJ/eCVvJ3KqD18tPKrX4FxpsaPAso7KmF4wvkWzsXhmeFdNjZK
X-Authority-Analysis: v=2.4 cv=K8wiHzWI c=1 sm=1 tr=0 ts=6849ab4a cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=rLkratNtAnnL-XKjWSkA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506110136

Commit a934a57a42f6 ("scripts/misc-check: check missing #include
<linux/export.h> when W=1") introduced a new check that is producing
the following warning:

drivers/net/wireless/ath/main.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing

Add the missing #include to satisfy the check.

Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
 drivers/net/wireless/ath/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/main.c b/drivers/net/wireless/ath/main.c
index 89f4b0513946916230dad4529df7c2d30402f2d8..d79d73738a816479107b130c6c0849de72442887 100644
--- a/drivers/net/wireless/ath/main.c
+++ b/drivers/net/wireless/ath/main.c
@@ -16,6 +16,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 

-- 
2.42.0


