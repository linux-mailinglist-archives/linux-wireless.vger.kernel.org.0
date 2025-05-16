Return-Path: <linux-wireless+bounces-23101-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E454ABA438
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 21:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B20189240A
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 19:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB94280A35;
	Fri, 16 May 2025 19:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M+eZWZpu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8715528030A
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 19:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424436; cv=none; b=W08edLNc/GrmmF5jCkHvlTmpfbeCIM22pCUxYdF1TJtKH+vXiNEPeboHRfetAiUyej7D9tII5c3PzszVQwMg6ieq1liPOOn9yp+MILsR6NA5stVcnfttJSZACHNIjzrxkqHGse/ZvWyRg0ddQjACKY+I44DgFDlP/UQew+d38+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424436; c=relaxed/simple;
	bh=1k2wNBRDNovOGE5AF87DqINGQLwzh8hmLfMYYi4gORo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eSAAZhKvBxHsSPwHp69uDZ8mUzErE7B/N+ZvWpa5g3MWb/fgxL59cX0HSF+rx+hy7fBUHsyFuamutRfHY2sAmYPncwHMcMkDbdyrt4OfLd0phLQ0Yr6PDlvkYQ2xibMuLz3Ay99CVLhY0iKw7wNGOmucQCTI5Jb++igq5tFQ+eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M+eZWZpu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GBDpJb026140
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 19:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1dsDs631HdzngiwCSPmiub7XN25JZzjnVP9wtjNYdQ8=; b=M+eZWZpueKtBq1IT
	3ywdNaR+tgAn6PIm8PN3YXACUpk/JJYhKkgJNDwTaBAdG8fhs4uO9lvJN4ht/y+H
	nJCHTyxjq9akeqmNzSu6NRD7ySgMJA4fYgtpTH5pRG1D32fhLePL3Jhnb7ugZ1gB
	oMSTb0UFYjFDpy0qN12AjlOjXqGH+vlhiUUqFYYnBLQ+/puFM1XQBDDfuV9Viu3e
	41miN6ndKOMHYhi3lgbzar2dbyxQ/7d7mQ3YAtX8/kieq24/8rtc7XrYdKBlHZ7f
	FoqNqFZpIyzHmfjeH2hqVe1j4riBrFSeOmPgQ4M3cgvcGSoI7Q9S/GWyoSajJ42S
	yYatwg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcyu82m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 19:40:33 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23201f062afso509375ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 12:40:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747424433; x=1748029233;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dsDs631HdzngiwCSPmiub7XN25JZzjnVP9wtjNYdQ8=;
        b=mgcTEmliZPitDR8nyuITLkBZhutQqPYDYMW+DEmNP9bL4DiBKmZWIpe2rVTXquB06h
         6Hn55F2+CxQYzVcKemqJxMy+aRBTg0xl7HIKQNk8VWDvZEX2dw6D/owUv+M2wvykAC5N
         KfQpt2bUnUTjXEjONGLAL6K1Pg0AqYA1ynP99il3SRUkCB2egP9nGb/UiU1b4Xzm7NM0
         YapWI2o6dKWrAiod89zQ3V5bYYfltWbB/7I8z0UhqdCOZspTqcTrfstKONVG+krT93nI
         GGg9Qt3Zqv84uWRswIK3ouhhae2nQC+njeqcCu0v3ofCstPo9PBCyhE3KJfSRPFZlUfn
         ukaw==
X-Gm-Message-State: AOJu0YyQmO6KAmf3AZfgcKOHcxPf66WTSqhxSO1ZggigYW/ALaAvjXXp
	CpS4Ad45xylCwlYmyb+O874I36akTTSPTLLOWS8I5WH5wMbdW3NyLAhkgTvIXj7faGpmt8H6Lqh
	HSEbeOndcBPpjfd8OSOTgZrzojUmW+9D8XH+fG38mLFUkWpidS9DX/Ve3qoYoSJpJNKGVUQ==
X-Gm-Gg: ASbGncsvV5piROv4WfXLM/hR8TCEbr5FdhSFOfN8w+Pgs1O055o+yV1GpsOQeD4JyHU
	Tg83w5pWLZzqhNr2EIgOlGrlb/wVj4pK1QY54VuWSolBnxyPUL3NgbdgoK/pWmlcJo3HnuaFtV2
	4mHjfshYWqDDwf4G5dWROiNg9h2uDB9fp+NdLxrkaLsOlBcwtmHo7SH6Jsnag+qzhqvnGTgc21A
	k5Wt1QZiAsyInoegjw72uwiakL+1YGOke+fcrxUBz5zlw4O79t+SRC0GqvQHWKvYy8BwV5F2wIM
	p7rUOlPrQ0ZWT5qDHeC8t9vuWVhboYh+wNpzaZ2+iRmIMV+J
X-Received: by 2002:a17:902:d2c9:b0:231:c9bb:60f8 with SMTP id d9443c01a7336-231c9bb70ffmr70079325ad.7.1747424432613;
        Fri, 16 May 2025 12:40:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHic32aBxSJ3QdKs82sAE6/YJvBcHpICFqViK2RJ5pmnLswkj6YggBE5ME+bzL4+Skotui04g==
X-Received: by 2002:a17:902:d2c9:b0:231:c9bb:60f8 with SMTP id d9443c01a7336-231c9bb70ffmr70079125ad.7.1747424432202;
        Fri, 16 May 2025 12:40:32 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e97798sm17955255ad.147.2025.05.16.12.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 12:40:31 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org,
        Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
In-Reply-To: <20250422094255.131226-1-nithyanantham.paramasivam@oss.qualcomm.com>
References: <20250422094255.131226-1-nithyanantham.paramasivam@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Enable AST index based address
 search in Station Mode
Message-Id: <174742443150.3316767.7243329584051307853.b4-ty@oss.qualcomm.com>
Date: Fri, 16 May 2025 12:40:31 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: 4UTHEWW0Tasp2btiVnvmo-A6QbLglSDG
X-Proofpoint-ORIG-GUID: 4UTHEWW0Tasp2btiVnvmo-A6QbLglSDG
X-Authority-Analysis: v=2.4 cv=JszxrN4C c=1 sm=1 tr=0 ts=682794b1 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=FBhK97DmYzCrVHyfCLwA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE5MyBTYWx0ZWRfX6GDwjE/wnmbB
 fH19lMbtxd26wxH1irLy176OIvCpniaUoVc4MIzoBJ24DUNwoSQ599ZcCXjdbCTCbwJHxsMrmxf
 Key/9sLB88Dih4FIk7fO/W2xEQDygkxt3622EPw8tEy0Aj0ZUiZLYcR3Y7+rQ3wbp/gnxA6v2pO
 eopAchHzyKihTMjdlFN/z0aaswebkWOrRPyWkMpbGTbbIXO8GDMyJwjZjzNq2l5TR3LOI4L5CtT
 wikIry0+c0/LdiAmHdi2OeRVrGtXRI/TYnKws22xN+EWQ+Gn5nX6Du7HTou0rpJ1qVQabxoqdZr
 K1Ucyp6GCUNzNk1jkOORdLWwH8nKIjs4DZd27ZKt+hgVDEB6JGLqYu7CaAjsaEG8YH9fyOFYFnc
 NM3L/Qaio4PXY8XwIssExoGDUdJMOj7kIaslEeY0z9AANQfwAbz7Hvuxb1O7p+RX0c6yyLvw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=716 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505160193


On Tue, 22 Apr 2025 15:12:55 +0530, Nithyanantham Paramasivam wrote:
> Currently, TCL performs the TX address search for each entry during
> transmission, which may lead to packet delays.
> 
> To mitigate this issue, enable AST index-based address search during
> transmission in station mode. This AST index-based search is not
> enabled in AP mode due to the complexity involved in fetching peer
> information.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Enable AST index based address search in Station Mode
      commit: 55cbbf25fbde8ed713a55a29f399adda8540e135

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


