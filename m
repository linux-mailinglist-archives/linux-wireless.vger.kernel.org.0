Return-Path: <linux-wireless+bounces-31287-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WG2kE93EemmY+QEAu9opvQ
	(envelope-from <linux-wireless+bounces-31287-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 03:24:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3A1AB173
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 03:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10388301D321
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 02:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA2F54739;
	Thu, 29 Jan 2026 02:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="imxW8SMf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZjZgegpL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACBD3563DA
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 02:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769653464; cv=none; b=Pbss6/tfk8ezalpAxJ4f6BA2cCNZ6lbPxDxF1EtUzjzhrILUVnwQdPwusEicczIvN7N3286SsSB1J2OIT1XcE3iXbRH37wDpBH/EhbvmT9LjXWgVxXqSuPLCc+XC4qc/WcN5SWrcLE335Hj/V6Xvc4VCSBB4743rFlQtxWSB9TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769653464; c=relaxed/simple;
	bh=2anUMpann6uGU2mUUy6jsIMMDcipM97EI3G2alShpuw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=naZ1f/iVhqeYXe2ALA0q1/eOG+ibmjf14pn8KnT05+XOOYW2x9jtVHAwBoLGYaRt7D0E/YxBxir/Bdz0mtO7d6cEgYHlDA8sNw5wh8ShrpyuYYDGV36XfUXwTT1Tj8J9moSS4fzMn/2+YhOTuKo26/l/6Xuuni0UaHXIaceM8ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=imxW8SMf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZjZgegpL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60SH7NKL1129295
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 02:24:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=NZdSkvgrGItreWwuCnFrAr
	KneP3zMI97nSFxIWRWok4=; b=imxW8SMfjOyosK+e5TMu86tqsmBg9DniaGQZUC
	bhXe9Dy2OusY1DjFSUP5CA4eVyd+ll7x63mw+wFX9ZhapJaINtxQv2nhL3tgaCrn
	BDtlBMVSuxOTc7yU6RQotxa/HAdabzhCquZJKVf7Sip7eQED5fXGYMH3zBCg+ciM
	0aeYmNLsGnW8G50yX53va99eUTUeOfiht5xkOIK25H2ixRI37IP56EJw+vbl7IVR
	YfV++kcHf8zyDeAjX7bPkPMU1DQAHm6ccMtiVLaa46H1VVcnEPX4c+5SZUghTHou
	sYs68AGIRx6QIPneFxyOZEB191tzKuYHozWSeK1xS+bo0LZg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bypk21hbr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 02:24:22 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a7701b6353so4232535ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 18:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769653461; x=1770258261; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NZdSkvgrGItreWwuCnFrArKneP3zMI97nSFxIWRWok4=;
        b=ZjZgegpLk5wjEIbWKjDZxClqum2h+OkTfw4MaGEKdDwyU9DrSi/2xX8rGy7KWJpOBa
         k8eHiWicqZrQfGa77okLbktI5on99+OxDv8oe+EUuJPXmnlhXS+TOWvOeaIOR+xvU2mk
         ttwsin4sMnnEzJQx5FiGYla+7857O1Cmatwn9k9MmN4EO/N0I0SLgkQbNT1Om9/Uvh/5
         YNo6isLq3P1242A3jtsqjcBoX72AvdYwU4+pz0PbV3uwA9L0OtiEK6g0phIfb7KXLKMX
         VLPlR1+o6KRTrpLmle5qV8DVVnNn3FPB7m1R8ihsorwDUq67kvCj7jlWVw7ZrzplIU1A
         LdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769653461; x=1770258261;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZdSkvgrGItreWwuCnFrArKneP3zMI97nSFxIWRWok4=;
        b=drgo+OOwK9n/dBkWMRqctLAXTuFfilKT3bQMm3zm0wcSekehyDhCjvfJ8zPsMlQcSQ
         JDxKW5hR5NY13yFEl9gyZCBUpa8INu7mXsv4CoamMCneD2Ud7660K83EMhbJzI3Lw0uI
         lXD1/VSn+YFM+K5xccCifayTz0F2gNMsUE/h+NBjigFVAGk7dQY5sMs1lZNrp4ePYGGF
         g1mqud0vdai7ZYL2wn12+XEIR6Pf/mQFP2o1zZsHsQnbN7RSo9PbwFQ7zbv8kIt0O1lc
         bA6WyDyhOAVnQUOvJfDIGZmSosHhZNadsyRdR7CkkNttkfqsMGraHM6eAedEMm+PH0T+
         mAWQ==
X-Gm-Message-State: AOJu0Yzq4lGbkOc+kQeKWJ0uJlanfg4SYPSnn6qQhwm2PLvWj4kjfPzk
	PZN8LIzhu+u7vSR+MrAECBc0yIf+fpsyUfYuHdW+rkpvvysu05OjihyzOAd7Oh5RzFQIgXBXnkz
	V0rVMi/HGAaFFl/x9A0utazoARD/dKCxgC7K9L9nR1yVuCxjitoqxr2qNR433qY5sDVcjbcF1eG
	ysMPmV
X-Gm-Gg: AZuq6aJ5k4wSS3WWfYKlVusGHGzppiPMDhfMP/cghMV+UECRDZ3UzTTyusburBbjs4c
	c2FXr/UCQOPWQx1vKrvN3RMyEAXkGaDHmRarMP4VigcuX2/sDSIAkLRshxoWmh/qEx/fAS3HjAh
	s4D3DgJoFmx9L4cE7TsSOWRhnkTrvhJbPmp0budcXBkLhjUmkzGTdRNerXf9qoRvWF171ee2v4F
	L3jACzNLD4OSWI55GROccu+CuCzCF1CEivqkNnxEuQKCJOzSZTecIGH+jZTeVcOnmiUu1JDj3L6
	yptetzGbw45Aa5SJw4dBRdq4BWhY7mt1WoX2YyA5L++LPsoWN3IDSxApEUNUbebyoeZoa0V2Hvx
	+G9qVOXZ9Qannxh2NwXdnu2zJU049Yd251KhcnPEwfmtyibyVLPL4FVo9IKb825w=
X-Received: by 2002:a17:902:cecf:b0:2a1:3cd9:a739 with SMTP id d9443c01a7336-2a870e579dcmr67853815ad.43.1769653461391;
        Wed, 28 Jan 2026 18:24:21 -0800 (PST)
X-Received: by 2002:a17:902:cecf:b0:2a1:3cd9:a739 with SMTP id d9443c01a7336-2a870e579dcmr67853605ad.43.1769653460909;
        Wed, 28 Jan 2026 18:24:20 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d92a9sm33851035ad.69.2026.01.28.18.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 18:24:20 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Subject: [PATCH ath-next 0/2] wifi: ath12k: fixes to station statistics
 request
Date: Thu, 29 Jan 2026 10:24:04 +0800
Message-Id: <20260129-ath12k-fw-stats-fixes-v1-0-55d66064f4d5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMTEemkC/43NwarCMBAF0F+RrB3JJGlqXL3/EBchTWxQW18nV
 kX67w7lvZ0FNwOXyz3zEhSHHEnsVi8xxDFT7jsOuF6J0PruGCE3nIWSqkJUCL60qE6Q7kDFF4K
 UH5HARim33sjKpEbw9jrEueDpXvAEuvgo4sBNm6n0w3N+OOLc/9lmwR4RJCSdGm01utBUPz3R5
 vfmz6G/XDZ8ZnhU/5iViNUSphhz3ltnnZLWmQVMf4VpxkKta7S49cHUH7Bpmt7oZsfYZQEAAA=
 =
X-Change-ID: 20251121-ath12k-fw-stats-fixes-6e008a4054fd
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=PfvyRyhd c=1 sm=1 tr=0 ts=697ac4d6 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=PKihFRAcjKX8bj3HC08A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 9qAgK7eURn1WLLu8b9CMSm0LLJmVtQay
X-Proofpoint-ORIG-GUID: 9qAgK7eURn1WLLu8b9CMSm0LLJmVtQay
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDAxNiBTYWx0ZWRfX8kSXpC56/O27
 q5aTwIssfSto0JYltYbc4z40TQWpWb3NYTcKVZ/3d5xKjFe2pgwyhid9bs76btkO1omxg5XhceQ
 3SZedc1Gf3bhpvcBSqPqYym6X1cqR3LH3zjMdxFY6Svt96mTRSZvgQtMwEp8rl9LNfOA4mvVDB/
 e3AILzYmLtMBXwswWvOvpZt53c4PYgOp1B6lNNAxE97BJmGzJbOPxEEgkpe1rcyS64bzEBwVhlG
 psuL+d0fReVWCBECsIb4/TAfM4SLy5KF/PUHzoCYDYKLmhWHUNOEyuiI2nPuFwiGOel3D14lCYi
 XI0Gk7gsKzTN5TQIiL/sFVpmp7CZhs8E8wyykYqAqj3AfgNxf58giiueK5veXCUxevu0ujao4hG
 GVOxKyksuvkl+PY5JgFQfRBkNqqVxVXBjOzpMtV775K3DZmR168MsH1CzNPjv1IAnxk21pzDFm7
 DYAbUyDJINNhkA37b+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290016
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31287-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BA3A1AB173
X-Rspamd-Action: no action

ath12k hits timeout and memory leak when requesting firmware statistics,
fix them.

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
Baochen Qiang (2):
      wifi: ath12k: use correct pdev id when requesting firmware stats
      wifi: ath12k: fix station lookup failure when disconnecting from AP

 drivers/net/wireless/ath/ath12k/mac.c |  6 +++---
 drivers/net/wireless/ath/ath12k/wmi.c | 36 +++++++++++++----------------------
 2 files changed, 16 insertions(+), 26 deletions(-)
---
base-commit: 8c6bd5e9db28152563c984d8c48322610cac8609
change-id: 20251121-ath12k-fw-stats-fixes-6e008a4054fd

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


