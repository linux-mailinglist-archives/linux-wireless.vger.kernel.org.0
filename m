Return-Path: <linux-wireless+bounces-32334-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id RaooFB4MpWmS0QUAu9opvQ
	(envelope-from <linux-wireless+bounces-32334-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 05:03:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DFE1D2DCC
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 05:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AF8030068DB
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2026 04:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95FB175A66;
	Mon,  2 Mar 2026 04:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HJ+fi9dN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KxspG5oD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9551413B284
	for <linux-wireless@vger.kernel.org>; Mon,  2 Mar 2026 04:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772424217; cv=none; b=EBFzmLIPPRzdfORo2vMSvhvPb37GYxgnGvjPgevtHbESB95prBA6iBsaBHsIJpFFikHPR4U8O0g4PR7dQeYXNmfOh3cbm6+TWHWAv/VHlN6gAyKbHYlGEqOr9cdBC4sGCYGfcV15uMjHtPGAdO0G9o+hq+uwQMrDmXeC56AzwdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772424217; c=relaxed/simple;
	bh=y7LL+AnocKjbyYT7RURi5r1/rBYHdhPHW5SK4XIVOhI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G4bmpZ0qeEf62XC1M7GJqGPpXKQZ2oz7jLTbCU7/WEoDhBYSKPVNMymGRLbh5Nx6wynvQZJ1O+ao3YvjHiSIoGRW1+Vez2pri0zdh2TxuHqAA24jvHdFRQLh8+hqgZ0ApQwy057DB6LkIg3gCXYHwGDR6cvuox47lM2EkoLyl3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HJ+fi9dN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KxspG5oD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6216bEYt860810
	for <linux-wireless@vger.kernel.org>; Mon, 2 Mar 2026 04:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=6t8XgGP05bTcFYnIOAvh/FTAvGrhziC2Ah6
	P7XuqUGQ=; b=HJ+fi9dNiVs3pgs2xxwYT2R1w3nLGrFVZV9c8NkrLu/BUFD3Xrw
	NrNim/wLcmlIxRBuDOE4rRwc8w2VEJjfvDAqghgtzV3a4jyLNwibu17luoOo/8en
	2E3fkkGpGz9kyPD6JHFdlIaSIkynVKjhQqon3yVzqny/g9o+jNcbnU40WRZmmQuF
	HV9kNaGl6wWd25KcLNDg9gpsNFQJG7xKJ8qAwNjrM56/l1nlnxpyS0nO4GtBGAwc
	0EkcN3ANbXcvZAz4+HcstNJcAW/xQtcIQ9lGXO5DOJ/8o+v8NbSGHF5BNlMRT7al
	1yMbwOFx1g08GI3m+t8d6J9qwV9RMHQ8VKg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cmgbask9e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 02 Mar 2026 04:03:35 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82743548918so2945482b3a.2
        for <linux-wireless@vger.kernel.org>; Sun, 01 Mar 2026 20:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772424214; x=1773029014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6t8XgGP05bTcFYnIOAvh/FTAvGrhziC2Ah6P7XuqUGQ=;
        b=KxspG5oDGVee9hZL+vysiItKdMqe+0d+5CpJCaVVnSnVYOCgk8hes0hqhXJFPmi5ns
         guP5Ul3C3E2szomCHo5pWcgVyKDrXS9VxE7a0c4Ub4Z1iGatBs0UzsFC4XJdX8omdQFO
         gqBOxoQ2xTx31YQg850E6GOy4GnudQoKbySeWLyu7oRQ8wnogQ2YGYXu90mTdPvM4Pjn
         Ce5kxwOC7Vl8P0HSd22JUVgLik7V0deion6m85vRiP1sDKfSMT3ZZemYVA5q247tMAvH
         w7jO9i/p/39FVdSuo8uyvi9Ph7nN2/TeauVucnp1L3eWuNOLBH+v8nwNGSM6EPWQ/qXl
         antA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772424214; x=1773029014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6t8XgGP05bTcFYnIOAvh/FTAvGrhziC2Ah6P7XuqUGQ=;
        b=rXfRc2rhdQJ051fEbzGTzud82SknbSgTb2K+JpNvLjclZk1dBWP+gp7hmLfh2q1jPG
         2afltNsEpb0UVcdNwReJiMYmQ5qxY121A8H24JQX/wMHFM5EdNTBkZJ3rQd5GapCZc04
         eFhEe/UWNa6N9sT4qx1wCTNEbK0OLHM/TKqZG6aSIFGdeLwqnvuAiBHQciQwCeMEcEOr
         tHH3qpdealy6XP5C8VSkhXw9w/85LCIqo1Lb/6zQFWFvpdGOi96vryYMXTBXuw7kh3p1
         O+7+J0N31zFh1Q4N4MSCmzRBSlvAJDYzL2K4rzHlCnFn/o8F1WWg1Wlm/EKpfdwNn95u
         uCUw==
X-Gm-Message-State: AOJu0YwMo1+HDob9gcJ/77j5/5ZLHoFAyYfeLIEhh9UrEUtjiUxr0cR9
	zrYXSpqndTm9sD1JHhRK25GmOSWyYqKvbkNg7Pqbq7cLe39k1/Gligr6GrR3GFPVsiwX8MYU8pA
	mkTzRaxD+KH36G0OZWDphBV9e6imiwRZDFiW2AbdmdSbjQ9AJILGpf5hRFStLtETpVHWCGQV9O5
	SKVQ==
X-Gm-Gg: ATEYQzy9YGU4wT8FmCVdCaKqQQqPcNOrf4Wf64ireer6GK19jSdVcdUkFP/tYvycYdH
	QpvmC8Hm67YXjDFibZAfxeLICLIt5HYqoEiE9w5J+PWdB83VI+H+23jSE6MqCTb1YTEt5ULA6dT
	e2ZIYSB6C/8sKhbqbawixrzPxFFTEaPvvArmoTu2GO0bdumapsy677ZqK602MnMUxJZJwTkNwNo
	iUM67ynRFSJYDryKBsY2UBJyf6kXzanHRhnNdkzq1UzgL/ng6sjvKjdrmWBzOUU6JQzHgq8HwlX
	LLRTvS6y9J42miTTQL1wt5vEyWrcdiwdpgafr4plJjaRLNixuijVLaDtWb9YF9oOPhi9eS+utqK
	+9HC/kYmmaTwOwA1LW4kqD0gwpsF2hrOXp/r1hfqo9qSjNrw/8s5ZzTavBd9BI+Vy+HpBURS/D7
	jeIHFztjukYkE+iCWox+IzTpscxVfs6x3Bd4XyZ19fse1BZrSYFNY=
X-Received: by 2002:a05:6a00:32c9:b0:81c:96b7:7fb6 with SMTP id d2e1a72fcca58-8274d9e6759mr10925651b3a.35.1772424214178;
        Sun, 01 Mar 2026 20:03:34 -0800 (PST)
X-Received: by 2002:a05:6a00:32c9:b0:81c:96b7:7fb6 with SMTP id d2e1a72fcca58-8274d9e6759mr10925626b3a.35.1772424213661;
        Sun, 01 Mar 2026 20:03:33 -0800 (PST)
Received: from hu-hbasuthk-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d4c910sm11385640b3a.8.2026.03.01.20.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 20:03:33 -0800 (PST)
From: Hariharan Basuthkar <hariharan.basuthkar@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Hariharan Basuthkar <hariharan.basuthkar@oss.qualcomm.com>
Subject: [PATCH] iw: util: Fix 6 GHz 80 MHz CF1 configuration
Date: Mon,  2 Mar 2026 09:33:24 +0530
Message-Id: <20260302040324.2443341-1-hariharan.basuthkar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDAzMiBTYWx0ZWRfX5J04llbMbjOi
 KINI2FTYBoKL18U57lkYvPg1rGAQKRZB/JaX9wjJqx15lInRN9bSVPooMKKEKckQOutN3XuPeA2
 8j/6vctXlVAGLpkny4StNvZFv7B3fPyYNTj1nE112JwRw4VVAasHIJlUu0q90lG1s1Lq9yjFmZg
 /2sahbLF4ikKBV7q5XmOKW3VwHVtR/0cNpI0fT68NSag6k5tuVgC8fVLNknmYZWrlgkci9gJc6n
 1RgxudQoEZiclqy0jHYlBSi+QHoftlrWdH0OOYVP5RRCa/SD6ySNSEnnzPEC6Ad1x2VZ4xA+Px4
 n5p8A6ZWlWZgosUWk1DijqsvJsGtIesXblp2qv3ppXGnVq/23yb+gPm7iocYbc+bGGDvXwoURTj
 ArAMELzH73Og9sPESwKCBqJMhFEmYIZtJ2N7TF2SI7iOxBJItXTpg2A+jM4bNR8o+lNc118v/Yh
 ASd0h9gsn/80offr+jw==
X-Authority-Analysis: v=2.4 cv=QfVrf8bv c=1 sm=1 tr=0 ts=69a50c17 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=57rUsDOu33otRx_0NAQA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: iSu84vMSGMClyvDUgLpjYTVGUEMEBrqt
X-Proofpoint-GUID: iSu84vMSGMClyvDUgLpjYTVGUEMEBrqt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_01,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1011
 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020032
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32334-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[hariharan.basuthkar@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B4DFE1D2DCC
X-Rspamd-Action: no action

Fix the 80 MHz base-frequency table used by get_cf1().

Replace the incorrect 6195 MHz entry with 6915 MHz in bw80[] so center_freq1
is computed correctly for 6 GHz 80 MHz channels.

Signed-off-by: Hariharan Basuthkar <hariharan.basuthkar@oss.qualcomm.com>

---
 util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util.c b/util.c
index 06c3347..e6d42e5 100644
--- a/util.c
+++ b/util.c
@@ -2097,7 +2097,7 @@ int get_cf1(const struct chanmode *chanmode, unsigned long freq)
 	unsigned int bw80[] = { 5180, 5260, 5500, 5580, 5660, 5745,
 				5955, 6035, 6115, 6195, 6275, 6355,
 				6435, 6515, 6595, 6675, 6755, 6835,
-				6195, 6995 };
+				6915, 6995 };
 	unsigned int bw160[] = { 5180, 5500, 5955, 6115, 6275, 6435,
 				  6595, 6755, 6915 };
 	/* based on 11be D2 E.1 Country information and operating classes */

base-commit: b9f9dda5898bd03ae679922e424097f556351790
-- 
2.34.1


