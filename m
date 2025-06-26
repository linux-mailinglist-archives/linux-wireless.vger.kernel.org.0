Return-Path: <linux-wireless+bounces-24584-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F83AAEAA5C
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 01:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8201C27257
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 23:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EF123505E;
	Thu, 26 Jun 2025 23:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m90FKIyk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C48322B8A4
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750979723; cv=none; b=gPmaJriLXFKFqPPpb+ExUY0PILLmSFPeV9cV6WSYoModhzkimhX556WXGN1icB2sQJXfcFqxnJuhYWhxLCp3Hv3Iel+PyAiBp74ynVbAIXBWygU3JaqdU9la/4tX+43gGwI9oChFyWPEI1F6DgnfVUNISCEvJAVLKY4ZRgxYdTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750979723; c=relaxed/simple;
	bh=umNmeih+NCcfNo3NKezPQrC1JTTx2F3NeUJ9cChDMcI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IG4l66t6Is3uLpXy9MSNNDwc5v3sciv31sp2FNbXZQXc1jsBRYXGQOFCr80bBoWLCOqg3nBGrI+rQWD5+3SnHLrfO2ywH6fSrQNR2zPCxUIovO7/CGH/l4k9rhg3k7c0PSH556ThMmToNyjr8epkLXBp3o4oLrdBdPhDkyPe83Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m90FKIyk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QJd8g5000453
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6v7dg9aLq/3BqM4qFRm/sKBzay6K+XSiGPaARUEG1es=; b=m90FKIykcJWK3qc4
	Qv9Ed4RAfvhgxTeYtwMNMi9vtrOs5pJYqukOEu03Cg4w/1N7OyuiONKoJVfjOeqF
	7dd7neKGPYXlW/Fj0zDuVYJYF8AVwXsbIPPcsPeLKbdA2vsLgLuiyREYn07Aqe5k
	KX6SXBahwUH2Jo0VDAI11HGnWGmbHVOo53Qx3MV1jYsIMSwG0HDiozSXMvQ5Y5hq
	xGRWHFn5lsm1CS6NstTlgCsNF9kjqPmDGfsMD/GrvuwvB6f6tW3m2Vdy9ljI5jd5
	MYJSzW7Owoou9l1cAPQ4cb7FwD5dj+WJVDNbMYYnc9bhyUG6szBw/QYBMnQ/e5P/
	PZ3LLQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f2rq51x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:19 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-235196dfc50so14154715ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 16:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750979719; x=1751584519;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6v7dg9aLq/3BqM4qFRm/sKBzay6K+XSiGPaARUEG1es=;
        b=YddDQ62xCZDYKD4oX8qH87CW/n7yqllvXxSiyfMgmDEwBVVFCfAg94lO3QSUcM3qwA
         zFEXiB+YOVdHpueIVpDepnKkogOoIpKsS2u9QNb/XRuGd7p11yJwOh7w0UTjHnd4nF6N
         FizfI8ufHeSln+5QeG9CIYA/uNQ9cFmtJxFVXKDX8JlvqIZS7DLJnqa8SMpPMHDG6q/f
         F0v6nUxFV8j+Eqp4cakzvEQr8FR2GiNWkDXHgd/CWfaMnHf4VVMxZsVbep9jgUvZCTeX
         bIxN1xzp1+0cz7FPnzFZhXrK0TdbCgCZKAwVRigIZAXxvrQz6jwOHtjB9xQe2w3TJDyw
         QClA==
X-Forwarded-Encrypted: i=1; AJvYcCU+L6l1+GOcSHFE+VgxH61NtGUP3WeoVPOCe7RUS5MAa5uZh33UWdLSSWebnE8zawoW9olq6A+Utllc1a0CPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfn9725y27U2HbWNlKusb16KLeQyoTRd3hj2pzX6B2gpCK0nDq
	X+wO4gbDQSNgd4KYERXR8HrHR57Tbfhvi4iok9Q986QC7bLLGw3Sr9IWFR0VRSBOBJL+312DQoy
	kPZ+l/6VJrpO5ECpG69Ip1xiDzOmM9+dL71ZQhIGfaT9IMhmZCIloTAwTjZynAJEEG0zkRg==
X-Gm-Gg: ASbGncvxD5jRbefRRN+s/GaY4h13w5EpMF+tqXneLsx/v4WldXx5pWzI80gC5QhEs1X
	lEsZc93D5NOpgX4S6JBh99COQ0FWuPtkkwsHzSU6duZgMjueDp/DvOEWmWqANr6mKNeYyaUpuwq
	p1Vf9aDckJ1VBeWvNlHa5FsKfOVpVRW/b5T/cy60VEztMH33eEXRRdL7WhYonw+WjdBOCyi1qqV
	pkioC5e1PF6b1nCSGC3cto00PlD0GypcbS0/K91f2nd14I+Ve0IdvIUAULHnq1a6QF6B9wi6QrV
	+O9mkyPCsnC/m2xaecJcEwm9fXNHpH9DM5KRMQkIfre19KlmH58uBGr5kQQ=
X-Received: by 2002:a17:902:e5d2:b0:237:e3bc:7691 with SMTP id d9443c01a7336-23ac59ab6a4mr13412785ad.13.1750979718649;
        Thu, 26 Jun 2025 16:15:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8MyYb5DgNriJcxgS1vLDwImzLrT7L7rSqE74R6A7X3DgIB+k3j9LmAbjtcQvtoy2UgGWcIw==
X-Received: by 2002:a17:902:e5d2:b0:237:e3bc:7691 with SMTP id d9443c01a7336-23ac59ab6a4mr13412375ad.13.1750979718235;
        Thu, 26 Jun 2025 16:15:18 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3adeeasm1548105ad.156.2025.06.26.16.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 16:15:17 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, Johan Hovold <johan+linaro@kernel.org>
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250604143457.26032-1-johan+linaro@kernel.org>
References: <20250604143457.26032-1-johan+linaro@kernel.org>
Subject: Re: [PATCH v2 0/5] wifi: ath11k: fix dest ring-buffer corruption
Message-Id: <175097971753.153431.15108889978896769332.b4-ty@oss.qualcomm.com>
Date: Thu, 26 Jun 2025 16:15:17 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=NdDm13D4 c=1 sm=1 tr=0 ts=685dd487 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=5RTc_1txDYSjDPOt6ikA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDIwMCBTYWx0ZWRfX67MNBT9aO4Pa
 in7nZrU5Nq0f8yyu8ABCHw0cmsogKT3vbc9sSScL7u6X9f6CIDEQPk3Kds+8py9EHep6C2cWCo6
 +2ja+vFo+X68OeS8k6SPMTmKCzxI/i8DGgxJK0yVfSeytnOoSBAY4QKM1FV7yUWV7pridiuMpbn
 9JNaoQQ/ueyLixPAh5SXaaSnKyzmy2fYmI7j4StClh1QaU+VkvEEkMTFI8z33+c3gdCM/wvjpp1
 hikcbUZqYtvDOWhLyRh5vgUidK4cXi1K8CxZRvFjJTsDQ10u3w+IqmaIkJKMp4x1g895JbMjfX3
 7MOetDplzdgvhPE5OZ8bVsmWoDFNUR9Ob3SmCRUJcEyskcKwqhzsXM7Gq+pUljM1KhQoESGwfN6
 HZLGbhIdONqOMUik+fqSBDASqduzawQGrLPhAuqxei8BX0CWgotjQwXRA2GcKxbWNUbD6JWC
X-Proofpoint-ORIG-GUID: WYoACct_cAF7WChMSGKeVsfzauMAxbal
X-Proofpoint-GUID: WYoACct_cAF7WChMSGKeVsfzauMAxbal
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_07,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=887 adultscore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260200


On Wed, 04 Jun 2025 16:34:52 +0200, Johan Hovold wrote:
> As a follow up to commits:
> 
> 	6d037a372f81 ("wifi: ath11k: fix ring-buffer corruption")
> 	ab52e3e44fe9 ("wifi: ath11k: fix rx completion meta data corruption")
> 
> add the remaining missing memory barriers to make sure that destination
> ring descriptors are read after the head pointers to avoid using stale
> data on weakly ordered architectures like aarch64.
> 
> [...]

Applied, thanks!

[1/5] wifi: ath11k: fix dest ring-buffer corruption
      commit: 8c1ba5091fa9a2d1478da63173b16a701bdf86bb
[2/5] wifi: ath11k: use plain access for descriptor length
      commit: 3a690e9091ec07f70cedd9a7dcc074c8554f1bed
[3/5] wifi: ath11k: use plain accesses for monitor descriptor
      commit: 4aba95fb1faed7fe7f6e1edfb60c333e0275dfc1
[4/5] wifi: ath11k: fix source ring-buffer corruption
      commit: 6efa0df54022c6c9fd4d294b87622c7fcdc418c8
[5/5] wifi: ath11k: fix dest ring-buffer corruption when ring is full
      commit: aa6956150f820e6a6deba44be325ddfcb5b10f88

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


