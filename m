Return-Path: <linux-wireless+bounces-24956-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE95AFCFE9
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 17:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79430580965
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 15:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC06224B00;
	Tue,  8 Jul 2025 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SMoFPHb8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8902E11A5
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990325; cv=none; b=u3WR4CKDQOukPX7+dR9EqCDlgrta03K8i9/JFA0++yvwKM2AxYJR9bnVmYmrxSa/sF694KRGBgIC4kDUxmAbMpaT76lwDsS+l1X44Rrjwi7jzMwnYiODYe3gLQufDCHUjFO34lG2jViu3XVnKWlS5vU7EGR9eeaglHwLfpUBxms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990325; c=relaxed/simple;
	bh=REk79Ja7xoa8mBqFlVY0hA53XrmTU0KFBCPpIbrmthQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KKMiCAe/2k9x6OKmaozomChMeckA7aL13oVyOxjt/i+mrkxG95/DUNbxcTCAI9Muj6XokSnvhSf32qi1DH5KFr72Q4wFfmFJFAmncqGr4msoLCScKW3JvFk1b73aja9I5i65hZGBPAW0kcLQCxxuoSlOD9I9tXPYWFf0jq7J8Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SMoFPHb8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAZSt032619
	for <linux-wireless@vger.kernel.org>; Tue, 8 Jul 2025 15:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R+ZCuxsQP/3xWVumYdaEzUdo8QVubQIKfQtjhcRd5/o=; b=SMoFPHb8o3KG2+Ii
	lr6Nf7S2KY7C720u99QDlCMniUtjxt0i1zp8CpHuu0VCotBE7BrvVD87iRLMBbqs
	l/dU9b11g9ff2Q4D+UGskeXfGKB1AmrAjpr0TDvFEF6Feqb3PGsnCZKsgTCCfE2q
	G4qIg9llUcmyqpO4FRKVNiuKH0pORwXMKWCEY3z01VOTogQAN13DynHm9LnkuG9j
	cbWjsfUoQdgok75H4otumSEpZTqcH/ZavlaJ3NSC1EHW2xf5obnNlLKG6HX1CCYe
	8xeAeh1f/XTIC4pJ5HAtgn3XfBDpHO3QK0R/dJzxFnMjdL86sVi60UF0GVhc4a7C
	3i9qpw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47rfq31vgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 08 Jul 2025 15:58:42 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23507382e64so39808355ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 08 Jul 2025 08:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751990321; x=1752595121;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+ZCuxsQP/3xWVumYdaEzUdo8QVubQIKfQtjhcRd5/o=;
        b=TIJV/4qJMsW5axginQW+HZqRvvuZHgG3yxZzaAhLtFj7Wba68DA4RJ40pk2OvrXhSK
         +7UkIgyM+jk1v4jLr//rI43qTalb1CwVwW+m8AlK40BD6FnXj7uJdQlRzLUQcAhRgQuV
         akyqFeVw9bQInPHg/sOwIL9SQCTJ6mhcpoCxWRpODuTs0mnGwrNW53C2mm3GO5lC6zp4
         Z0VK1XZh4tJR4Z3QM8GJRU6TFEzZuoQb8bmgfJS4YJ1Vw+/efh3qytsmv9vFi4Cr2ZoZ
         ZO/ksxBgngM1b2R58miBXhPBrPwxAdz85KY+bofBCEIuQikAHFsZVPcKLqbVjodkyipb
         1qEg==
X-Gm-Message-State: AOJu0YwTOjuZyp9xRpZdvuHnygyFGgo91qYsnU1Hu6BX5o9tKSHVJm4/
	rzkxhpgEsei18MkglYL4PQ/k5xIw81+1t8W0vcmqd2zRWRX8kDa4x3F1NaKitK7qMznCH7ggxGz
	glZZt7zjhUF9b/42oanpwgaX3fZUIU1VuwmoNRq9lHzX5tVHpQreAoLpXjIuQN9vwZPUEcg==
X-Gm-Gg: ASbGncuoTtSUrrvrUR255HX1rF2rCp0eSPaGLyJ3YeeTnzGFu3tZ2c8RD1A4+iJs4h/
	iI2efMhNS3pi7p39ZKVd1nBcgdiZZim+7ObrXDK7aZqKkRtNh6nCLmyYVw6nK4qMbRgwxzbskFt
	pB194A9z69G1OEGnx9qRO4JjfvUJkuNBFoX/oN3Um1F2K/fZZsezqLZLlGSbiMbLfLl2leduopr
	D3N/EQILnlNRanhCPucFhc9GvO5YzHB+KZVfERaWRa2MFHOVXq0kkI8XFwOWRhfBMUSWO0Y7bSY
	GkM19dFuKB8HemadTug1BiGcKjj2Rubqo0faK4WEMAVXyUdqe+DjqXtB3y1NLMqhwKTNpjL0bfx
	rVA==
X-Received: by 2002:a17:903:2c5:b0:235:efbb:9539 with SMTP id d9443c01a7336-23c87475fa5mr208728085ad.17.1751990321012;
        Tue, 08 Jul 2025 08:58:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO7t238xf3WwIiUkJVqpammCA1BuKtYIrzsR5y1tw4PdX3yUJa0EBvpsAFMpQNs2Dk4f5cDw==
X-Received: by 2002:a17:903:2c5:b0:235:efbb:9539 with SMTP id d9443c01a7336-23c87475fa5mr208727785ad.17.1751990320603;
        Tue, 08 Jul 2025 08:58:40 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8457e9ecsm120189125ad.178.2025.07.08.08.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 08:58:40 -0700 (PDT)
Message-ID: <ac54dedf-db95-45c2-96ae-a4d93f8261b7@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 08:58:39 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/5] wifi: nl80211: Add more NAN capabilities
To: Vinay Gannevaram <quic_vganneva@quicinc.com>,
        Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
        johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
References: <20250622222444.356435-1-andrei.otcheretianski@intel.com>
 <20250622222444.356435-3-andrei.otcheretianski@intel.com>
 <61213657-4df3-4ed5-9950-04e52be92df6@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <61213657-4df3-4ed5-9950-04e52be92df6@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEzNCBTYWx0ZWRfX7NHmChDdQz5S
 XD3t2rKWxE9+nxA42iqhRLUg4xBxHHrsNuJF+65PftZN9LksGFOUk6gsCP5T9XIO4ZCBCvrcoCZ
 XtRmjCctst//70AlZqXPFpTe4/0BOiBQZ2G123NiJ4Vw7kPLGS8dI2T7RSLBxgWpzTrEocS9xoP
 04ig6CEIV3h0VxBLt6m7z7oLrmKOX0UsQ5jZSG3LU4m3B5Qlhhy8i+R245qSbYl766fgw9iUrn+
 czbYE82hCoWZXYJDw7Dzj2Jp/ew0U0LcBaf8tnK8tLel3eF0hViZyMaX9bG0DSBFmVd4T2PFanG
 bYyHj8itsLWGYg6M1KSFqID0LfU4qJA/qjXlfoBxNNCjm8ktIAWCltHXI97ZcaT21NQ5aSbCL5U
 yusZaAU53mu8fcrOSlWELeTWyTP3Ey6X+CW2e5W8nn9DUkDuOI78o/Ke1hpLtb6OKRkuilJq
X-Proofpoint-ORIG-GUID: G_MK1XsVwmBTTQp5cgJiDOasFfw08uCT
X-Proofpoint-GUID: G_MK1XsVwmBTTQp5cgJiDOasFfw08uCT
X-Authority-Analysis: v=2.4 cv=SOBCVPvH c=1 sm=1 tr=0 ts=686d4032 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=5U3BiAXuqu-d_eOOdZgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=889 spamscore=0 impostorscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080134

On 7/8/2025 5:13 AM, Vinay Gannevaram wrote:
>   * @NL80211_NAN_CAPA_6G_SUPPORT: Flag attribute indicating if the device
>   *    supports NAN operation in 6 GHz band.

I have a generic request that in wifi we use GHZ instead of G in any
identifiers. This avoids confusion on whether G means a frequency band or
cellular generation.

/jeff

