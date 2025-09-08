Return-Path: <linux-wireless+bounces-27070-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F191AB4824D
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 03:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2A9A3BD8D0
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 01:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62FD1DDC33;
	Mon,  8 Sep 2025 01:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nPkKeZ/+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319331C860F
	for <linux-wireless@vger.kernel.org>; Mon,  8 Sep 2025 01:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757296311; cv=none; b=RpXojzE5txe7nrqUBN/7/ian9iAhMTcI7RsWIhI0VO9crCBNtfGCO13zS499a3xiLvLJkuHY+p9TOC/DmACfVMXBjoz7m4zlIaZbGADEsawWc6VYxbuJuYVQFR+WksWdVu/HHYsuDSiHX7rDYQhStGjj+lLK4+w0VcU43eVGtOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757296311; c=relaxed/simple;
	bh=/aDIxeT3TsNj1FBfWntIgZ7OZ6D7aYjEUEGG45hiKgA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dQzcVT4YIBCav1SaJFiFhaiXNSnIizwSR/viP9gOMiIV2M0cX9juYU4SGsUac3Jhjqpxqd8mrEvaOLB1K1jCLlNq3Yf2/ibC5HIuG0onioO3EH1W0BSKLtcdW80iRQ7VeDa2hKOfDDJx7rtD8Xry4NZ+0I/r9D1RleITIepKgkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nPkKeZ/+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587MP51U028233
	for <linux-wireless@vger.kernel.org>; Mon, 8 Sep 2025 01:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Rrx/5RgS1f+GZ05XDctzozDGEviN6tc7NYb
	3BzDD0ng=; b=nPkKeZ/+N6M7TJS43xNiUwDoAU9ojji6wx1ArbpHU2C9yuJHWYp
	Xaav4bzkVdKjd92KfTmEOqfN40/lHX//pwN2h5CY279jkuOfv28zqa/CjRMsoca3
	aGgoCUHmysiHpsxrq0POCqniaoCx9GRSB7I8kLmOcc7AkmI3RK/lbHH8E/q0pbvh
	qK/Ob6f5hFRNOF4LjXcHuzkj/+Qg+YdZlxwmAejYDtcbWdrauMLw7XRRTNMsjWhR
	pQWiPOFA1WP9hfBoO3geOWw2U730cGm4mvRi+R8ZizoF7oLdVUZW2nlDIHdeKQb3
	6cYWvV4oB+jOJKf3YQobIX2BTNerXx3SfqQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490c9j2ys9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Sep 2025 01:51:49 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32b698861d8so3666006a91.2
        for <linux-wireless@vger.kernel.org>; Sun, 07 Sep 2025 18:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757296308; x=1757901108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rrx/5RgS1f+GZ05XDctzozDGEviN6tc7NYb3BzDD0ng=;
        b=AAKKexSy+pI48at/tEpxlUBnDr7YUb49AMb0Q73ZkzaZYI4K7GTqBLSlCVa0qPK7UA
         b1Xd11RUoEJCZ/jEpzM+kZYQWMd1fSlcrhOYzGmoo/astwhUaTD9pHDwrJsxkJFfT+ot
         24cLuGgm/3xqjifHeaSXSCzY1pmNqnRw/q5j/X3OvWR63nbq1/CFeEfLiIMs7EsUTab6
         3kH7GvmycBCIA6PY7nYFzKADu46EgYUbzAF6ORikoKKR66Yy+OwoZUobKRYTE70JPnQL
         IRgL/dkFOcbNUfTvIjnaBcVVuSZpUan8yYlZJbDptiQQx19GMgUtRaPiHZhMjh+yg4f9
         fk3g==
X-Forwarded-Encrypted: i=1; AJvYcCUykLthkP/Qi1F86KEPiUmO+733mQFUCsRdBTbjEb6DK1qD4cy8pkCbZKRmsotNsyFljrSDSswnnHtRimEjTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUf4F3CIz3g4/n3RXFzZkfgW8IdNfSqg657yGe2cEZprWNjgXe
	f+zfRRNMk0NiPy8o6FQBDkGWaouoeXosUm/64Yit0WIngQhmcx1qFLgj7vpqZBnwbhbFh1xpdSG
	l7mhI5HdaHWd0FVm8Ut2PpDcQrk7f1Osqi3JlI2OuHACrzmHKo6WBRBpDkyyh93PmPxjqxA==
X-Gm-Gg: ASbGnctRieQkWVzg80pi0pnEWdh63Tz+QSztN1/t1CtNZPThWrqb2Mm8zewWJ2BtWJC
	3dnMfuHpCN1zJ1g//Ftd8gC3cPtFTZm2v6MMH2kKH5R+sjzuvGKBwyINosXHdoigfvmZcmkmfzk
	jZkUjd2QFWKHIW9pWG0i3KfCEHDoBR0Vy+X78DPxChrU1byKOTYHaTj/LTDXNMWviMu2YgmBxnP
	jRQN0nXgWyGBDEAD/59ygnUoQG0F9PKZpZ5dMmBw4phmOLUVoLfKwGj3M+G28w6RU12Sb8rC8I3
	pz+UQwvQFbegfoQKjzNg00iTA6JMiYqn+bkUaQ2r1gnsK7Uvnybj+T7pdoPUxnnOC7/SvvYsdtp
	Ny8FRU244CUHkrmeb8hUaxr4=
X-Received: by 2002:a17:90b:38d0:b0:32b:d183:facf with SMTP id 98e67ed59e1d1-32d43f76ba9mr7024660a91.28.1757296307556;
        Sun, 07 Sep 2025 18:51:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5nRDidvM463gKG+C+xMPrHa3szfL3WmBr/t6VEt4l6o0AtEY94nQNcmFlQKvdElZnhnqKbg==
X-Received: by 2002:a17:90b:38d0:b0:32b:d183:facf with SMTP id 98e67ed59e1d1-32d43f76ba9mr7024628a91.28.1757296307064;
        Sun, 07 Sep 2025 18:51:47 -0700 (PDT)
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b58d8ca8dsm14563309a91.7.2025.09.07.18.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 18:51:46 -0700 (PDT)
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: [PATCH ath-current] wifi: ath12k: fix WMI TLV header misalignment
Date: Mon,  8 Sep 2025 09:51:39 +0800
Message-Id: <20250908015139.1301437-1-miaoqing.pan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMiBTYWx0ZWRfX/tn52zl3lLSV
 vuRoVyC8FUJaFO9U7RSka+dlDUcs0s6xM0wa1JQWCV/6XNHmjbJDKKGuz1NwCWTxKaN9WOOora1
 Fi9gVwDEbwVI/nm8CaZOtMapfBjdLQ7MOGXkk1BjoSmOu2t1Ai9Aqk4ExhLzFlcpCyG/mwYgfjS
 e0Teonixa9DJqLS094mU3fHwSHKz1DbtA3t7p8zIaLSX4UcAMEJylYp8qcd/vxb2kJFZ04BvxMo
 NIBYMAHCdfY0uKQdnCWyNzqPDWoMR6qQcBjkXioyj1IoOBPnw2P29DlHuolsGJe9HZ8QOt+oxtc
 9ODHH8f953FUqKk55b09FSahKSvZNzAq5OXmwj7GMiPwroxY5Qjy7wK9UFuDwFcy1wYnywh4Djm
 nap+0csM
X-Proofpoint-ORIG-GUID: EtlaN0Ab9uG_m8MMFNKoce_BZcMF21De
X-Authority-Analysis: v=2.4 cv=PpOTbxM3 c=1 sm=1 tr=0 ts=68be36b5 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=dYpq24IgevQlpX1txhoA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: EtlaN0Ab9uG_m8MMFNKoce_BZcMF21De
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-07_10,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060022

When buf_len is not 4-byte aligned in ath12k_wmi_mgmt_send(), the
firmware asserts and triggers a recovery. The following error
messages are observed:

ath12k_pci 0004:01:00.0: failed to submit WMI_MGMT_TX_SEND_CMDID cmd
ath12k_pci 0004:01:00.0: failed to send mgmt frame: -108
ath12k_pci 0004:01:00.0: failed to tx mgmt frame, vdev_id 0 :-108
ath12k_pci 0004:01:00.0: waiting recovery start...

This issue was observed when running 'iw wlanx set power_save off/on'
in MLO station mode, which triggers the sending of an SMPS action frame
with a length of 27 bytes to the AP. To resolve the misalignment, use
buf_len_aligned instead of buf_len when constructing the WMI TLV header.

Tested-on: WCN7850 hw2.0 PCI WLAN.IOE_HMT.1.1-00011-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 742ffeb48bce..29dadedefdd2 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -843,7 +843,7 @@ int ath12k_wmi_mgmt_send(struct ath12k_link_vif *arvif, u32 buf_id,
 	cmd->tx_params_valid = 0;
 
 	frame_tlv = (struct wmi_tlv *)(skb->data + sizeof(*cmd));
-	frame_tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_BYTE, buf_len);
+	frame_tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_BYTE, buf_len_aligned);
 
 	memcpy(frame_tlv->value, frame->data, buf_len);
 

base-commit: 27893dd6341b929f87d45fc4d65c5778179319dd
-- 
2.34.1


