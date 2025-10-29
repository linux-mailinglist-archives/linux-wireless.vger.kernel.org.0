Return-Path: <linux-wireless+bounces-28365-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 471CFC1B9F5
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 16:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 609BB6285F2
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 14:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCBF286D7B;
	Wed, 29 Oct 2025 14:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YWJ6W16a";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jL6oPA1A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D4E27AC31
	for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748103; cv=none; b=M01S+sC1M+3Nd56iXeo2TCHIXTJPx3H2AozaRqDSGLtSBl8rYbQC8tM0KKqHzJvRwBXkQ0S5fP0oWdeuUKAr/EuRP21FF4QROno0G1CXQJL3VeIgQHk2UiXYbXamV8pClZeQADOScCQlWdpGc1cDdDeUcw10/wmcXXM1ysR0T7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748103; c=relaxed/simple;
	bh=64Y1ODfA9sc3u5fAvb0/IWvzX3U5L+Tn76zCFX6s5mU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W2CZU1vPBfhEA2PipyFGPKoQGA1JCPVzdqIIQ+HiRLKz8x4d1qIxRjUxn8ZJiAP3W7Xoaod/3AOrZ+e+owPsC8g2idChYMOz5J0RTpvidWfJ+LQlWW5W8v0QuxenL9+PdJaRPTN+y0QNRJEfjqUGrdnrpRK/BcZsMhDp/q/3iYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YWJ6W16a; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jL6oPA1A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59TBeG2I435098
	for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 14:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vggPJY16TqzMi/evuM1V0ydgNwJL8MMswUJoiRHlisk=; b=YWJ6W16a7/7YaezD
	QwvfYSbq6m5asUI6VsLRiwCZoKSYZSGCn4Lx4aH1VZau+heT9PmeGC4R8jQAQZ2I
	fi2Z+51yiYILwilFcNqNhpf1pfiafA1ihZYvSGcw+n+jMXv6C+VO+aRvIG3VtioE
	ZlUcbNb0YlnpB4VH8AX154Fwfojh4ENWdaTN5JAuwViOGDKebmTCOzE8HpldXaqn
	HN4bdxP7zdhHfWKiYyj/Vp54Pn6v2wadaw+0l0l5xKqatIz6cw5TNUxNcRhTaeSG
	3KDiXbbDLZ9seZfUU46pyS7y411iRnrWzcheXy7iUivX4tLamE9eQeVpzfxW63Ek
	N/D4mA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3j8jrfj1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 14:28:20 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-294880e7ca4so130274345ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 07:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761748099; x=1762352899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vggPJY16TqzMi/evuM1V0ydgNwJL8MMswUJoiRHlisk=;
        b=jL6oPA1Ah+5dtC6MJR9phil2m+/n0WsEzEGxZy+2ZwaV25vGX1YzD7yit/vHOGCucj
         zGbJFBmnMOOnpwLvleUk70aEYZ9mZzrIuyUa9kHaHfZL2TmF2jv7j/WaVbdVI0KCu7J0
         WCiBEQdJkQFKQay5/gb9dXZMdrTbczoY3JzL1kaiNycuh+ss02MrfBdGUdjIv6JIIwvJ
         ALfNFwXLR9PL6QcxmKqHdaCvlu5rPAjEbQMwdba17f0RMuLta+S3r0sZFMJ0Xv/rbPu0
         pQu59baSF/oZtETOBDG58mBAxKq98MYsf74jkU/S/NvVi1gasF/qNXEp8vktlixgIhup
         hq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761748099; x=1762352899;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vggPJY16TqzMi/evuM1V0ydgNwJL8MMswUJoiRHlisk=;
        b=A2EWfkknsChrVM72DcrHRd+RDA7LDuJRpUBQSTW2eypXapaMgWTWRXY8Jm5fRG3Bsj
         XEVKTOFhP9oSP4XTZuBtpiiFIFJvlA+2jxiKkx31gVgxtbhpMEl2mMvq6vMnK3loaAsW
         JvKdkd6k51B2DZ9J0q9SHYKBaEO1MZvYt2f+ArJw7dgoHZCAOVqTlK25B+6D5RhYwG4O
         NWqbJg4TaHxlr/I0TqE9kLCnYAp96H7EaS1J4EALoVB8hmFLbUUJt3fDOAVGOnVHRNo2
         KGQ+jquo+wo352xGZG3iqMcnEjHHJmCd4MaRoUfnmb/b+9+h/ajCn/oFlmt95Ez5dvQs
         Pr7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+GyGxGbDeBf837rhs9mxKyfv/iXswPu8cUwKyPXHHNktS9fjoxId10SbwNZnZy6pFgJHWNDl+KvOwf/i71g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAds+833jVfvZx4tdeZ1AGsw9qiOPN+vC5gJXli97hzNnP9TOG
	hXRH4Z4HetAA5OR8fVGORcT24clOfLge7JaRWKSGSziUSXddgLnjCY3FX0Rab6eMlxgahBpPxnx
	c8zqHUpst0D5gi5wg217AQXH/taTdvd3fwP7AHTH+7M6zdVIoaDJ9rEuP450vnykXE/fq5zII7K
	cWdQ==
X-Gm-Gg: ASbGnctg9z7PWFBVLdEmYgq6M5hg+tzu74mEE1Ot7+YUKLOi80ZcK23qMtX2SMM+feD
	A3KZN/W/+f0KHiZiPk5WRF22wePCdjgLetdncB1D0KsT0H4SzJMSZkn6+tNlj51WOfUs0VzGQnv
	bRjNGv++W+PDsxrNlLlD4Am+Ja8cFtibxjK/Xy43e5QzpsuX94WuerDAXhg+d17AL4O0YvN2ULQ
	mBUubPE1HTdqrrcAy5eec6Z5zkgbl2YUNA2pH3HlHKan/1leeuWWoFerod2IynBDDwuLY2fi7SZ
	w9Qx5awPSfiQ20zF8LP8ZwGaxozwxQ+lflI5EejAio4UkyjD9kky+HBMledqx1LsZ6z/hgyAYYw
	JMr+mm9gFmXXHIJFvBqKCth09pgYxCqyBh1A=
X-Received: by 2002:a17:903:ac3:b0:24c:ca55:6d90 with SMTP id d9443c01a7336-294def4840dmr33515335ad.61.1761748099397;
        Wed, 29 Oct 2025 07:28:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXSG/iIAfbNKQsaW5cMe90cddH0fAKzPWthKI8ur+hYnd6C2vR441AKTqe3jtSdiOkoukbHQ==
X-Received: by 2002:a17:903:ac3:b0:24c:ca55:6d90 with SMTP id d9443c01a7336-294def4840dmr33514865ad.61.1761748098745;
        Wed, 29 Oct 2025 07:28:18 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0c414sm154236885ad.44.2025.10.29.07.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 07:28:18 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: jjohnson@kernel.org, Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ross Brown <true.robot.ross@gmail.com>
In-Reply-To: <20251028060744.897198-1-miaoqing.pan@oss.qualcomm.com>
References: <20251028060744.897198-1-miaoqing.pan@oss.qualcomm.com>
Subject: Re: [PATCH ath-current] Revert "wifi: ath12k: Fix missing station
 power save configuration"
Message-Id: <176174809787.67078.9723142274217890219.b4-ty@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 07:28:17 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDExMiBTYWx0ZWRfX+68rizeEUCnE
 6g5JraU+FHbDX1SP4wuCwXb7oVyjpSL/R0WHVx1ixbbxWi2h+ofttPV8EBFknL2NcIiuuVgNx8D
 fFYvuli+0jszF0rXVN7/klZKLyB1ZN1h2bTP2qqEoN0pi99/3gIdhKWhdjKaoDVG9t+fkfhatnz
 tqnOIMJH+KCPzddbzIGtf7qE8tR2AWdgC43YkRLnIxqtU5iS8oFfedzubYdRwTvkOA8moxKOqlk
 ApTT2qLmxinENO1ZnPBQ2NObR6oEXphkSuaIEdZ0kygqBtP1BDSXvbUVlHcQGlPPYQ3m7fc6aEq
 6cZYKGrWGby3VLFC1igoS+lfD+IknptD+JlB+tD871G1Uh7XI+iwSzYSVA1BinXWsU7xKrUVx3Z
 oM7DeDOtQBXbALMgR2eK/+RU+e7mng==
X-Authority-Analysis: v=2.4 cv=FOoWBuos c=1 sm=1 tr=0 ts=69022484 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=QZKgdDJMxHbNcH4R8hkA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: YtOZrMPByrwZHB1IcpKQJt0S5IqFhzKw
X-Proofpoint-GUID: YtOZrMPByrwZHB1IcpKQJt0S5IqFhzKw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290112


On Tue, 28 Oct 2025 14:07:44 +0800, Miaoqing Pan wrote:
> This reverts commit 4b66d18918f8e4d85e51974a9e3ce9abad5c7c3d.
> 
> In [1], Ross Brown reports poor performance of WCN7850 after enabling
> power save. Temporarily revert the fix; it will be re-enabled once
> the issue is resolved.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.IOE_HMT.1.1-00011-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
> 
> [...]

Applied, thanks!

[1/1] Revert "wifi: ath12k: Fix missing station power save configuration"
      commit: a7716c9d922d6245b308e92824b95831bde44553

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


