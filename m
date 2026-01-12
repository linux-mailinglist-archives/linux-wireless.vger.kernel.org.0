Return-Path: <linux-wireless+bounces-30677-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F01CCD10E94
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 08:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22678306FC6B
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 07:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2216A331A5B;
	Mon, 12 Jan 2026 07:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AyQ2STQG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XOj2Si5B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32F82652B0
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203424; cv=none; b=NPokBu6qkUFNdp2/MrjpP2RFr0jZF+uCd3s6JmX+q6MTAF/g0ghKfglR8nHXzDnhljwcCQNragi2n2BpGxIOIQVUR9np+w2tRZ99/i9SoYcdHNlp+etrTP1GqNJzZcrMZ1Fbdme51nP3Dh0mttUPPq2ow1WiItpGPtJpQ3+3tLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203424; c=relaxed/simple;
	bh=rriBX6gT9nrNXDZlKCmhXyXFCXjBvZIezMIVTGNaRQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eyIeFGwYh71t2/vTJq6+fB5sXfS/tCQij8lQ16V+yRLx58GvFUtowHA0RYU9VQIuNgT6rKiJk/wfK8M9SKA9gOV5WT633fzzK6JPA/ymyg1CmDjnqD0vVUEzMAhHj1LeRMqDKvs4/CgOkAn+vqXiymNLheP65tWBRpRCdON8y80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AyQ2STQG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XOj2Si5B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60C2No7k113367
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	arthdfnc7nsVai6q8H5JKb4gBCDzValB0SGVEOtsN/U=; b=AyQ2STQGKCQBgWrt
	0SbSxlOk3JxIJUrRXBeTBvVWR4M6RXo17fkNduXbOeVe7wyjNQTamma+/fmDUoVo
	Q8Y2pAsofwdy5I1wZ3DFDflmrlA7Go2feIsTRJ8gjYIOcAXVP7/07NEYGidY8XxW
	sFGBOP2L4r4F/g27yKBTrT59gzDn892XaXpiZIrTMoXRFu3zF80bZtJtLvtGrlTM
	ISbwctdqJf/C7J14z54cq/TxM4OwRVAVwM3RCEFR3O6+xKZMJq+zz0rpfO2N/mTA
	edvKpdmiTK2dK5WYCTAjNIFkiCZ3FFu7x5gLGd48TCZ/7jilxnqPwuP5wgfO1mWs
	sS99Xw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bmr4ugsad-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:02 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-81f53036ac9so551812b3a.3
        for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 23:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768203421; x=1768808221; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=arthdfnc7nsVai6q8H5JKb4gBCDzValB0SGVEOtsN/U=;
        b=XOj2Si5BhVRa1yiwfy4bdsls4ZzwREwGQwW3te03FHvOST2v49xiOOSwVTXwWBBup9
         5giHDccMKcgeVMn9EMgL/R5iCHsKDocAtYb5yR6qrOE7nrSAPpOd1AxZzhvHLte9Vktl
         xlc4c64ssPdCRvPN7irO+g3RHZfx2eUenHVgmgwkWtxLNdspqSap6Kt4C0Y9/H1Eb8d4
         YTNQ9CBJIWXVRovGLwVpyqiTW1xhckMLIDe1qpuAqMH+qq9UvFGlxnOTn9SWQiWQtbKq
         WqEXVAaLSX6EMo28rMwYQ2bsGK+Y2LA6Q8H8tDy5q95cpoDb977/hf+oIX6ZbVQ3yXoS
         xrow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768203421; x=1768808221;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=arthdfnc7nsVai6q8H5JKb4gBCDzValB0SGVEOtsN/U=;
        b=JpCJi6y3UsYtTzlw03EbwfY9Kdj3wbxxTIAsKANUXjgzUELYhqAPwaJHwAr7DtwtQS
         NCeDrsZfoFkK9vO77jVQNNl+ThEPAin55lPUvQCxudBVM8aA8/OFxnD8wmkeaE3lexKi
         9e7oIXVrLvxcMJApUqe3u2JZgde/+JLZpGbmIZJduwFHoAgQjE4mMu6zHpo83rTysNRy
         /rJU2NQ85izDOl9h5KdjtY0cX71utw6Pjbaktlq9f1cYgSIiMqQCvfDB1PTl9qCfS5he
         EK723wAaHV1XBwGJDbRQhVOvoOZhjkcS1wbe6SJ3ibSQgEVJgD8Gbhv5Kpr34kXgrbJX
         N3vQ==
X-Gm-Message-State: AOJu0Yx9sdayPRkt3rHT4oYXHHsIR6tQPzAKy0E2XFoOKsAqHgjw4lVC
	RDgSx0ocTWMoDXWB8R7NagydKqMRn4+8A4nCQo5x8DEMolhWxoV0Bt/dZBwC3Ys0V3hBBTNbTjj
	fNISgvSo6AcAoBjy/VBwJzH8ha43Ce/CaciH3OUzqqnSC/Y5QTlHvqIXDXaOXrIgib2KZ/w==
X-Gm-Gg: AY/fxX5syrvUM6K/0PT6/4kxc+/p9zcU2np+f7CGWpV8yIorELC0oPACQAUBkRVDVa9
	zb4A2Jjnzi4g/LJ79ZyZAYiYprWgnK9U+ZyOphL6AZPjmCc+VfnCTen9pQWaKaV9X4vgraa1oDF
	a/8niUKEQovX/cw3gqcc1xLlrDUdYNNOmarj/T1o5N9duZe32oj/6zJTP5NEDWcnt9DSh1I9zdX
	Z3BKl/dZJsFbYKi8VeOl7RH6HU3L0UPoOWUGW9ldU/QRkL9Pby/BD3g45cVYqh71pHiPaRP3kG/
	qh30lxvEAKLz5WT1JHpuwDEOU6nc/OeNrfMv3TRcKjxBKdtcvgTvQ//EPddMnuZCrryseDyrbKR
	rrcl3dKXEghdtOE3X7BLkEP27S0A8ncwBrRURWXRcDiLvAxc1QJHjARynwZ7hS0s=
X-Received: by 2002:a05:6300:218a:b0:37b:992f:8764 with SMTP id adf61e73a8af0-3898f96bfe3mr15069282637.34.1768203421407;
        Sun, 11 Jan 2026 23:37:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeYllVPKi4LiALHfmYM2WVbvhbBCTZynuio8RJugvEi6VFhgjvZZqHrDe81U1+x621yb4BzQ==
X-Received: by 2002:a05:6300:218a:b0:37b:992f:8764 with SMTP id adf61e73a8af0-3898f96bfe3mr15069266637.34.1768203420897;
        Sun, 11 Jan 2026 23:37:00 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbf28faa9sm16548684a12.2.2026.01.11.23.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 23:37:00 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 12 Jan 2026 15:36:24 +0800
Subject: [PATCH ath-next v2 04/18] wifi: ath12k: fix preferred hardware
 mode calculation
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-ath12k-support-qcc2072-v2-4-fc8ce1e43969@oss.qualcomm.com>
References: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
In-Reply-To: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA1OCBTYWx0ZWRfX2dB7KGZuWKZ7
 B56zXUit8PkNOmFOT+HboyeLIV35JCbvbOwJNqBxnIOU3JNkKGSXmYFl7oEuW5ZqC8fNHqZAdwU
 NPHroFpmp2uQKJFvTJ4x3vbCtcAIjcRi/mAAL9RXaCC/mxeq0d9MnoMuymewuC0lfDi7OC2Vg1y
 3FKFck3QedTGmDnzE6iv4QsYFRPYI0kKtKF5W5pVeYTmdqsIiHrOdQF/gnK519Dnow00QqsGMZL
 Gttuj0d6X2jFCIoyprD3fwgHdkYQ+3PmjaYU23KF91Eu9HPety6o4w+mKLWtQ/ljSfksxJva3wc
 eQ02WlunkP6Uw1JC7uvR2qslnQjTWv67yPiZZ9zSDp4CdDKaY8EHB+SJws3UDpurtEjNhYSeayo
 uuQ6NEnSCXqxUgcp59GxmBrkrGH0ev6SBEMmsJxMH7VN38/RMVx3o5FRTNX3fI+KZacez+AM2zI
 xXsFbIm3Or8WfPxVPRA==
X-Proofpoint-ORIG-GUID: sGLbJSIq-8et6ZBkLthMzuE1xm_BOweT
X-Authority-Analysis: v=2.4 cv=YocChoYX c=1 sm=1 tr=0 ts=6964a49e cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=zY3FkhqSlrVAWUjZaU8A:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: sGLbJSIq-8et6ZBkLthMzuE1xm_BOweT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601120058

For single pdev device like WCN7850/QCC2072, preferred_hw_mode is
initialized to WMI_HOST_HW_MODE_SINGLE. Later when firmware sends
supported modes to host, each mode is compared with the initial one
and if the priority of the new mode is higher, update the parameter
and store mode capability.

For WCN7850, this does not result in issue, as one of the supported
mode indeed has a higher priority. However the only available mode of
QCC2072 at this stage is WMI_HOST_HW_MODE_SINGLE, which fails the
comparison, hence mode capability is not stored. Subsequently driver
initialization fails.

Fix it by accepting a mode with the same priority.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 17ffc4822741..32c4e7fe03c4 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -4449,7 +4449,7 @@ static int ath12k_wmi_hw_mode_caps(struct ath12k_base *soc,
 
 		pref = soc->wmi_ab.preferred_hw_mode;
 
-		if (ath12k_hw_mode_pri_map[mode] < ath12k_hw_mode_pri_map[pref]) {
+		if (ath12k_hw_mode_pri_map[mode] <= ath12k_hw_mode_pri_map[pref]) {
 			svc_rdy_ext->pref_hw_mode_caps = *hw_mode_caps;
 			soc->wmi_ab.preferred_hw_mode = mode;
 		}

-- 
2.25.1


