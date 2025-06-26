Return-Path: <linux-wireless+bounces-24588-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D61AEAA61
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 01:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDDC14E1562
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 23:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEA8258CDF;
	Thu, 26 Jun 2025 23:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X5i/TOi4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E022571DC
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750979728; cv=none; b=Mk98+54p4NBk4mQDdK2t2g/7jhM5I84yn7V9onLA0Hr2QwGe6XAxTUIMr6h9rlGWxNC6LPrpXMSQeeIwjw6mx+bgZ1FfmkgvIFDVIu3SZMTiGCwNGQeLfu0iVxSJMst9DLrgBgMg5jxs9XnwoY2h6TKMDOUQeBMbQZsQSCcirkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750979728; c=relaxed/simple;
	bh=97W1rsgKHzHK4hJpu3UD9S8uZtaZeOLCFfCG1uGYbCU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ggw5hn2v+4XGgzwhKb2walO6WhmGcgA/GHoZKByqBXaf454Lc5QmoJ8qu60nL1JLkUBwsB+RTa5dgff/xxtctzUUZEpmrBdbK6Py2/4jQYtaByhWS2dPnOOHMaNfW5RoCzQpf3hLqr3VrCl11V+CDCFb05G0JrIQXOKwDxatqts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X5i/TOi4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QIUPsU031194
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H26vxPDDq+45HdVk7MgggFQ05RRmGtxq08BAPOL5aEM=; b=X5i/TOi4nWVDdWog
	okhKpoV77N44ftlUgo2eqXrtNzVnp0J0h9ubCdTgiDt1pkM2YaYSerr/0Ci/Kb0m
	JuySKnwJrOUaNmS2Rj6/X/7APDerAogX5/LCvKK7Q4JvlWt4lHB2LmVdFBI/Utx0
	lJA3vk/6VxWo3NzWEo5uZK0FNBopVhzlkvmtaZKTf0H8+ZzbsygdKNEsxfoaoM9S
	J2c7/mm3Ln4b5l2QvgQOQQjeTWerZJjO6UY9qPHcvgBi0JIwLCluw0H9g1m1ormN
	QRZSqbAWYSaEIxHb1tawtcKjjhBVafudpsSGGIQVt1onOUw9j3EMuwiG7OSU71rO
	DWcang==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f4b44r23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:26 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3141f9ce4e2so2370436a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 16:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750979721; x=1751584521;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H26vxPDDq+45HdVk7MgggFQ05RRmGtxq08BAPOL5aEM=;
        b=Hyh/BtVAwsNJ8UJz3H8vbEyLC0E+2UP8+hs6Kwlxy3SZWNimW4JaZ/zSCG+2gQe8ZA
         npJi09Y7510wFyO6FIDch7ZpJga6GIDW+/56OD7+qiaz7zaHc2clURS4v0gdbfVflG7T
         WT0CCMd2/Dmc+NKXNrz/75A/7FbjQO/rrMBIMG2NxtMoqRtp79YidWjCaFz27Pt6Ykmf
         C0VVPka0QhBWymT+NTFICjoRF0hD6Sq02bwBD0KCoFQi6AZBmXoecDAMYXG0OcYsrpMe
         Mze3xKv0K84vspdGEb0nxYdxSxoG1gat40HHG+sg4QLstXvhFGgdXgANthFdcbrPFNXQ
         JwMA==
X-Gm-Message-State: AOJu0YxZ3DSz1bvUbLtYLS5tbss5q7KWjNvrp7Kmq7kjYjnLB/zfmE9Z
	U/WheHukQWbeCxinqRAnlflEfViODhEJvaCaJLpJjjl4C4TjDSmgeOhJ7m4ISnd+HW1GfAlxsZ/
	GBZgcF9A6ZYigdx7ld+SxNc02yXG2QGn6DVZlz1qqA6gGN/YU7ddiSUSPeP40siF0eIIERA==
X-Gm-Gg: ASbGncuqJ6XOATk2alz0kf5VZUDpEvVEwFA1JDXucusTBZB3b8RHhUjWeMw8Dr01YUg
	VX5cFwv6Kxc6pllGEmQqVth1i0hMBZfXcRfWWGKTOzvqkZyopcM4vIsY13MJ7yBMN3leZSSG9yR
	5Y4KKqX2WpSfBoW4yHOcSM2sOi8XMdx0jspZxlbrjj3tQBHW0wdO7e9DQACpcmEM1pbMs8ZumUs
	cjYlaqZtRj3T22THFmRZxI5K4hM1A/qU3BiNNnl/7yjaqERp2PdEbd14jCdLd50sTK/lMyKxZJL
	KWxu/3pyJqTPDwE+BRU1T4q/wcouIHdj8dVdqrlJ3ZvimPIOcFf5vnBFZUc=
X-Received: by 2002:a17:90b:3ecc:b0:312:e731:5a66 with SMTP id 98e67ed59e1d1-318c8ff22cbmr1173006a91.3.1750979721251;
        Thu, 26 Jun 2025 16:15:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqidKcjAC4nR/68Z/+1APw/4OSLlwWrzEMUEAtOi7Fsn49vHdOdDvFV4Ta+JWW+3IzNJFt1A==
X-Received: by 2002:a17:90b:3ecc:b0:312:e731:5a66 with SMTP id 98e67ed59e1d1-318c8ff22cbmr1172963a91.3.1750979720804;
        Thu, 26 Jun 2025 16:15:20 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3adeeasm1548105ad.156.2025.06.26.16.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 16:15:20 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org,
        Saleemuddin Shaik <quic_saleemud@quicinc.com>
In-Reply-To: <20250617112139.865788-1-quic_rdevanat@quicinc.com>
References: <20250617112139.865788-1-quic_rdevanat@quicinc.com>
Subject: Re: [PATCH ath-next v2] wifi: ath12k: Add support for transmit
 histogram stats
Message-Id: <175097972023.153431.8301439641819737889.b4-ty@oss.qualcomm.com>
Date: Thu, 26 Jun 2025 16:15:20 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDIwMCBTYWx0ZWRfX99dCAkeN5RXa
 7zFuoI0ZB/gchYzCKbzJUqbYAVY7etj+2eXDax1XgBay/G9jK05+j6xSH47vP+wvja/rnHcSdQt
 r9ueFnDGx6tUL2EVN46DuOftELnvB0kYK1MXZ3GIrWedvisRU1CEXKbIXQOX9SVetXjR/xeelPs
 O4jo3Ma5waGnjQnM6b/M+eSctiGUJGPXSGCiYhE04OtlM5ud0BrzG8EjG5RYfKi2mh9c+AQqH3o
 l5AQsszYtJUwdmlTf8vRCsnJmapVAzLlahKBchpvcQjsEgBOplTDon6ky13LyOI8XEMNC4dXBaY
 NzclbxPOQV8CuD5UYJFX0mu7fGgVQfQAfyG4HknApB66Tu5Fd4SFfg3MXAPmkDcfjcyIudMvYIk
 U9Tr0a8/H/fQC9XNS6CV9BBsAWJZS4nZKiogM7YJdOyGEHuFyQVY71L3w3TDI062h9WQ1vIs
X-Proofpoint-ORIG-GUID: 18BN-X6_hDyuln_hZ_GLrsB1WcymxT2h
X-Proofpoint-GUID: 18BN-X6_hDyuln_hZ_GLrsB1WcymxT2h
X-Authority-Analysis: v=2.4 cv=A8BsP7WG c=1 sm=1 tr=0 ts=685dd48e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=MMKcxVdVYhlKfOLOBpoA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_07,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxlogscore=988 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506260200


On Tue, 17 Jun 2025 16:51:39 +0530, Roopni Devanathan wrote:
> Add support for transmit histogram stats under HTT stats type 9. These
> stats give information about drop count, MCS drop rate, histogram
> count, etc.
> 
> Note: WCN7850 firmware version -
> WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3 does not support tag
> HTT_STATS_TX_PDEV_HISTOGRAM_STATS_TAG(144), currently.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Add support for transmit histogram stats
      commit: ffc7adb0a121cd72a02095106bd006f44593ee35

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


