Return-Path: <linux-wireless+bounces-26391-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 483FDB274D3
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Aug 2025 03:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BBA6568190
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Aug 2025 01:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FE82877CA;
	Fri, 15 Aug 2025 01:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M93puMou"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805D52877F3
	for <linux-wireless@vger.kernel.org>; Fri, 15 Aug 2025 01:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222322; cv=none; b=MCocNCGY1DY7c/6yQ7CPgx7fXajx5q+x9kkfWIRDzQt66hzc1IcTPCQf02SmfU0sFImnL/iA5C30PiLRZp0yePN7FlJNGANGxMUdbF0Jrv6pmw5ePnGpQ+cqsls4tUx1usz01rkRfoqYYd+34IRqVbcwXK1ExMulSv7FwS+zNd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222322; c=relaxed/simple;
	bh=Ooh4F6PH697oKIemfVheQzHdNaYpbQC31p+1w2jl4Jc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GAs7lQcubs9fZY5SWU+O7Syoh32krPQRNlNg3TG4+0/qxs+3NmJJWgSyL1qhwbfXsQ+9T2dhvGPbruiDoTusAV9IoK32gdSzrHp7ItgthIxAkVVm3FaxXNGDXdpmKQtm60Iy5dwiRY77Qp043Q9+BBcvyKwb6WUD1D/4O3o/Dts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M93puMou; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57EIYn9Q012279
	for <linux-wireless@vger.kernel.org>; Fri, 15 Aug 2025 01:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f2JJpNn1stvDlteeqX4h1Cq06+aEkFey/378SB+Go3s=; b=M93puMouYWldia7v
	EGGfEOnkU6CZm+O1LhdzImwJn4mzZXeXy4wdHj64ihFoeVzxkLcISt/fmFFnKoUM
	o96Nr1JYaVHXX3glaEpkJ0U3WZnvioThOyLjoyn15F1/XoRFmRasElUdYqLlLm+9
	ZQQaBKsM3lyB9HjQJgNC5EFae/qBbfdXIL24RIMsLNzip97RH94XiZshcquLqxRH
	aiSGoxFRqcp9802s0pNkKHFbpGHuVQDXWAMAhpaj/JfohpCmGDIAqgPHJjzXud0s
	7w0ioKn0iVPZfGi+DKslCpwYvv5bmsnKGgE1CK4fOKqF/sBt/ssj9vPJvqu4FO7i
	7mAEMA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48eqhxftxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 15 Aug 2025 01:45:19 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-323266d8396so1558335a91.0
        for <linux-wireless@vger.kernel.org>; Thu, 14 Aug 2025 18:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755222318; x=1755827118;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2JJpNn1stvDlteeqX4h1Cq06+aEkFey/378SB+Go3s=;
        b=oYzi3y4BsXAN9mOkkGMyrgEM5LsffOxVDYWXAdITAHIlQLMPGUMBPqoajUTHYriFRO
         RgyNSqf1Hc2V2HP0051KCMbaP4MQphGEP4rBXTeHqic3p+tAGz441/xqkfBaagGGsPBk
         GKGklFTeh2hjaW0uqFH5FHBQifzW7j7jn6CuTAirk3WdOhln0Zij39qBQ+JgqwIUbxOw
         dlkAzU1978vZDvjC9Kvg2AzA3JDRzMamTaZDD61hR6Vb8MTASRrrBapMnp7/urxKmGCX
         O3++QQCs/DQPawYw9M8ZkG30WNoX3ApOkKZ+oLln2Zj+/Do0P9BAPERyPAN8FEP42BC7
         mmDg==
X-Gm-Message-State: AOJu0Yyt/4njlR/Y0caN9M307akJUhasqULkn2mlQIanYeMClZ7UX+lM
	3eqRm2lp+ceBWFlwm2uUE6zc98y91X9bdfniQrfGWk3u0+ICEarT9bTSHD1qWTTB6Lc/csiUIq+
	uDDxZFcP72qx9Yo6MAAPMLjIoNDVO+Io7kIwaIxPE/VsCvd2TyKNPN0XIL66lDKcETIIemQ==
X-Gm-Gg: ASbGncu6xbRw+hbM8kFjcNg6A9w0EDOfFzDtA9cjgz8hM8E7oVfsy98IjvOKbHPGmYc
	Rrkd+wJ3pSDqdDsoecSACv3xLqbTGX6kAmP6W2FiMIjctS45+7beYYn0+QOm1WS+Qs2Br0AIXf7
	chKK3ZofvZucQL7c+ZqhIlRlCbdYu+C7VzFw6XsngC4oWmJ6UHziwbB6UruVMOYSi1UpLGp+QYS
	6VjzaI7cSKYXjU7dd/IrkYmobKbIPz2pGzVuWfcb74ie9Nd5UnQx4SOSnyLyh5sczcRhIUQzAhp
	EMPiiRXgc3JvLOQufPJpugcT4iIq3UZRDDUy8jxxzNUR2v1DQU/A90cK3E5DIH4DBSan0O4BN7C
	pokvSjHP0XDyRaFTH
X-Received: by 2002:a17:90b:180d:b0:321:7a2f:985d with SMTP id 98e67ed59e1d1-3234216190bmr588161a91.25.1755222318010;
        Thu, 14 Aug 2025 18:45:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTATHglsejKDU1aURWUA2qjKt/Z9C08Zt0r1OWZF/vn9I1mLXPEpEoSQOPZtYki1JSB3Pf3w==
X-Received: by 2002:a17:90b:180d:b0:321:7a2f:985d with SMTP id 98e67ed59e1d1-3234216190bmr588123a91.25.1755222317407;
        Thu, 14 Aug 2025 18:45:17 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d7735f4sm20273a12.48.2025.08.14.18.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 18:45:17 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Fri, 15 Aug 2025 09:44:56 +0800
Subject: [PATCH ath-next 1/3] wifi: ath11k: downgrade log level for CE
 buffer enqueue failure
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-ath-dont-warn-on-ce-enqueue-fail-v1-1-f955ddc3ba7a@oss.qualcomm.com>
References: <20250815-ath-dont-warn-on-ce-enqueue-fail-v1-0-f955ddc3ba7a@oss.qualcomm.com>
In-Reply-To: <20250815-ath-dont-warn-on-ce-enqueue-fail-v1-0-f955ddc3ba7a@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Carl Huang <quic_cjhuang@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Sriram R <quic_srirrama@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Balamurugan Selvarajan <quic_bselvara@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
        ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA1NyBTYWx0ZWRfX/2ShCHr4ESWx
 mmJbjAq9xJKfacBmUe8kAFJvCWvuSI0VfA+iCazrzRMZgM5DVMc5i5mL/JVbGGTfdsR9L6B82i6
 t6UP2oLp5b/mxvsRi1THMBMkVjN/jC7wgVlIevweKm3EIo1qwPyWqdXUt85UYuIfT6ols8sF1Gm
 EkNhpIMhYg/0vL795lNTX5ln9j1PdCyj1VrebgMxiY5HyrD4AucfCeASWI9Pz84HD4x63zr0qUZ
 eF8glK9kdH1mhiPqqUoPdg/CdBkMRDUmX4WbINnoTMD0qBhi5XDFdPJ4+m7xaBuMaawK8F7J3uS
 AfD4HbbX4FqKQv7OwPirI0BWxTglnuVOv235kzBfISCGEj6DY6bXr767fFqLJstCDx9C0bNkFYq
 Lzk6zWPF
X-Proofpoint-GUID: vDlYHMPorsKoYEaVz7lNL_giJaG_Oalg
X-Authority-Analysis: v=2.4 cv=aYNhnQot c=1 sm=1 tr=0 ts=689e912f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=4avV6w9vhD41MOPHW_EA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: vDlYHMPorsKoYEaVz7lNL_giJaG_Oalg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508100057

There are two rings involved in the Copy Engine (CE) receive path
handling, the CE status (STS) ring and the CE destination (DST) ring.
Each time CE hardware needs to send an event (e.g. WMI event) to host,
CE hardware finds a buffer (to which the tail pointer (TP) points) in
DST ring and fills it with payload, then hardware fills meta data in
STS ring and fires interrupt to host. Please note the TP of DST ring is
expected to be advanced by CE hardware before interrupting host. While
handling the interrupt, host finds that DST ring buffers are used hence
increases rx_buf_needed to record the number of buffers to be replenished.
Note before that, host compares TP and head pointer (HP) of DST ring to
see if there is available space. Normally rx_buf_needed simply equals
available space. But sometimes CE hardware doesn't (for whatever reason)
update TP timely, making the comparison fails, then enqueue is cancelled
and a warning is logged:

	ath11k_pci 0000:02:00.0: failed to enqueue rx buf: -28

However even enqueue fails this time, rx_buf_needed still records the
numbers of needed buffers. Later when TP gets updated correctly, the
missing buffer will be eventually replenished. And there is no doubt on
the late update, it always comes (or lots of such warnings should be seen).

Since this won't cause any functional issue, downgrade logging level to
avoid misleading.

Compile tested only.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220269
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/ce.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
index c65fc9fb539ef10ba44f1c1d5571462b40fa098d..a7a163621b21067ba5a4f96131aafdccfbda3d03 100644
--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -354,7 +354,8 @@ static int ath11k_ce_rx_post_pipe(struct ath11k_ce_pipe *pipe)
 		ret = ath11k_ce_rx_buf_enqueue_pipe(pipe, skb, paddr);
 
 		if (ret) {
-			ath11k_warn(ab, "failed to enqueue rx buf: %d\n", ret);
+			ath11k_dbg(ab, ATH11K_DBG_CE, "failed to enqueue rx buf: %d\n",
+				   ret);
 			dma_unmap_single(ab->dev, paddr,
 					 skb->len + skb_tailroom(skb),
 					 DMA_FROM_DEVICE);

-- 
2.25.1


