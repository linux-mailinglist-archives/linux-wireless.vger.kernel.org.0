Return-Path: <linux-wireless+bounces-23179-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 468A5ABDE15
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 17:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAC803A73D0
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 15:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EF52512DE;
	Tue, 20 May 2025 15:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HRzxnmjJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167C0242D95
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747753287; cv=none; b=F139MZPcrpyUKz0qHlm1P56Dbd43M/GVjPNBptLfas061lQNstjGr+J2W0AODL1sT1mRBBndfXII02grPHfGDtzPyoKRvHFvK3fhbfDbW47vcpm8hbq6SzWgpGfVQqR4D5yrS25qCUCpVGxgKbdaGAX6r+J9v3KKHA3N5IY8UZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747753287; c=relaxed/simple;
	bh=IbS1Uc2HTadK04DpE0mfO/OV3dYF4pKbttUeUoxR/xE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ThME+JUzxS1i0k2qFf5Qdr+2cwEttBc6KalkHxCP2uyQe5Zr9w9Zgf4VUfgIkjug3XU0WbwpqgqDCYa0E3gizG2GSUEzdFUQfO806M2o9oIbJw6UXKSD3ldTthAningPVJY8dcTFg0xjWO6UAqsbuJDniipeftAATy9xwn6RP8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HRzxnmjJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K82rvd014679
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 15:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NVW1HN4/a6Zx1t9y/+29FG3QqYnDpr07zoTdtPbkx9A=; b=HRzxnmjJQTT2KlLW
	4U4vW9ndK8tzLiguKhNj7w/f6eBzw5fJ10QwANXgMAPED4Uu2y8PPI5PbfoYdhD0
	7A07eV0fnZIlsLk8Vat8u6YKf49TT1TyC6wuQQc93fsOL0VxADFWo/rYwX2SeR7o
	qPo9umoA1MReuz76u132xBi1AK8cyUQNQ5qCz/97DBrDo3mJgEs7iPRWJzqU1U0P
	9tQlcNGW57TDzxfNCpoVeUsUsjq+bXLW/lmMALAtUomYauCK6mHohdl4fvz3Heex
	q+VSPxVBzDD/Ismh8n9Fl9385wriLZIqx1eX5aJCUlyQWNzCjCmQDMMrKdxTv/MG
	hEhDKw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rbt22jkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 15:01:24 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-74299055c3dso8119222b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 08:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747753284; x=1748358084;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVW1HN4/a6Zx1t9y/+29FG3QqYnDpr07zoTdtPbkx9A=;
        b=mX/+GkfjMi1BSWIsrdDyeKV+XB/zVcIE0e2GKfd7DmC7xv0jgVCz4P280k+V5eXM7g
         U5vJNemcd6l+4k/xiJH0Te+8D1EJ1RgGJjqoWkGsjUpDAa+tEBGfjE2c5v4Agc19gslo
         B7YCB7FY1wBxlmnMqjmneiPrcrDLu30J1pHi1zD6rpt6n9bj2USZ49+Kd2b8eA675/c9
         FTGQkf6zkR6gfdFWpI89bQeXrbJ+XK6UjavxN+h20O0XqkDFyX1gmeuhj06k7Usa06ve
         ywKeDb0L0TvgLTlngkfVufI3HUPo8wAXEDhy1O+lMG04bV+dCjKJ4KGP+8qc5zOx87//
         wVLQ==
X-Gm-Message-State: AOJu0YxuN8Gf2Wgs4XoUzIFfjeEXnXsfjNMQiFeO56Bsw+01Nh5nvNFs
	Fwrcx+Z7fMVe+iSF+R81PX5Q9ambSCFOX39FS7ginTMBi+JNEkPzuoLLP9/GOp1M2ws2TMl7dUT
	bh8A40RnFyUo9DBsBuyrIIVmRGsZX91HM81X1iNOOeL+u8KIBTe496rInWs2O8mwSVyW+Pjsw6I
	hpyA==
X-Gm-Gg: ASbGncs9JNBJgkdWORzdF+GIsqHPs3PpU4CLPYFWReN9BjHw/5HhvXq/6V6upIg/dgY
	uA4kjQWceadVw/I2vVlhYREHcqmbb7H92VconYC0nLwdvT3wlhgtb5KhPVgJGtyZpAan7H8YmuW
	+k7iMrGdFHmt6mXMeZRJJ2jusLIApsce7seSp3zoXSP/fZP7g00k2/phuKOqXRX8aBt+AjtyIUB
	b62Xf7m2b8FjVdhW1i+l7ZHGmbjhok8ZcptT3EqqQ+E8cwvoIebQTfmlVOp+qW4efOXuJLOKvnk
	3r0Un3qzp+S6a2Km4OHQqUIPf9HH8hJkc0Co570MpLMxrF0W
X-Received: by 2002:a05:6a00:10c6:b0:740:a52f:9652 with SMTP id d2e1a72fcca58-742a97aa35emr21560802b3a.6.1747753283560;
        Tue, 20 May 2025 08:01:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQAL11R4glAnMVIuS+cl0+A5byXfmxOdflGOSIWjM0YvJU5P/JAG0giWvVQ4ZafL+gvC7paw==
X-Received: by 2002:a05:6a00:10c6:b0:740:a52f:9652 with SMTP id d2e1a72fcca58-742a97aa35emr21560754b3a.6.1747753282973;
        Tue, 20 May 2025 08:01:22 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a96e2106sm8264258b3a.17.2025.05.20.08.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 08:01:22 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Mohan Kumar G <quic_mkumarg@quicinc.com>
Cc: linux-wireless@vger.kernel.org,
        Dhanavandhana Kannan <quic_dhanavan1@quicinc.com>
In-Reply-To: <20250505153536.3275145-1-quic_mkumarg@quicinc.com>
References: <20250505153536.3275145-1-quic_mkumarg@quicinc.com>
Subject: Re: [PATCH ath-next v2] wifi: ath12k: Send MCS15 support to
 firmware during peer assoc
Message-Id: <174775328188.1942021.8694986570679072778.b4-ty@oss.qualcomm.com>
Date: Tue, 20 May 2025 08:01:21 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyMSBTYWx0ZWRfX5BOm54OaFXtV
 DtjQueIjA1tZ9GazZJDP/4KYVmwkTbjiBRYt3oaKb/A3SjBSq09XgW0TsW2m47XSuVrAgbc0mP7
 i2IdOiDILev69bZJN4vjBLAK2zeDjmNQ0hFIEppu/3JZurRhoZNg/PzLb3lr8kdAu+s4IEGrQmN
 r8XVnxfZ2Hqe/soGZDngb3bGI4UErPv7ajyMOJD8MSBjybfH3ZzDKVKrWyI1GMWlu/53Ji9E+PU
 Kp10UjCsREpgY0Hlg3T05SS4IhZxcES+QCE3XB5g2oGw1DvHb/wrRx8CXjeOLZjHwSkH/+tRHxF
 srYHvVhR6UE/0SsswSJTqxHgRSMJV/6McrUespdj2GeI+Z/8vbAaKq1REFUxvo4RMHIy2P9V513
 vdNzoU5Ynyrcz0lyIQYvoBNY5O9ztpxVarp8JNbrB4GY7pcs+R7pTPI2EJLyLvj4adABr0FB
X-Proofpoint-GUID: iyYGaqiIo-nw0KbLN0USvaDPAzetfwhP
X-Proofpoint-ORIG-GUID: iyYGaqiIo-nw0KbLN0USvaDPAzetfwhP
X-Authority-Analysis: v=2.4 cv=dISmmPZb c=1 sm=1 tr=0 ts=682c9944 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=KWIm60pxQzOdfeBkbBsA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505200121


On Mon, 05 May 2025 21:05:36 +0530, Mohan Kumar G wrote:
> As per IEEE 802.11be-2024 - 9.4.2.321, EHT operation element
> contains MCS15 Disable subfield as the sixth bit, which is set when
> MCS15 support is not enabled.
> 
> During association, firmware will use this MCS15 flag to enable or
> disable the reception of PPDU with EHT-MCS15 capability.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Send MCS15 support to firmware during peer assoc
      commit: e66396cd08049ff3ec1a2c4653a5233fc7f323ba

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


