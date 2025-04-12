Return-Path: <linux-wireless+bounces-21462-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB09A86AC4
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Apr 2025 06:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8691C1B84197
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Apr 2025 04:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFC2189528;
	Sat, 12 Apr 2025 04:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B3BMefDa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BA71624DE
	for <linux-wireless@vger.kernel.org>; Sat, 12 Apr 2025 04:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744431854; cv=none; b=kXLCIB1ImWJhEGr+2uUFDEHk7cUDs4Pkg59xIZIpOkK3Sl2G7fxQqStNFCj7wgm/vZbnqPv8AorvjmmVUhOCexKRFwYBBkKAsxWwutBZdXyg0aynEym8uWE57mH01BKLUZk45Cx8hpLFALLFa8WY0lUqcalqw8Qsub3PIB1Z2+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744431854; c=relaxed/simple;
	bh=c5a7ZyeEl9+091MU9wjzxsxvx5f4RLGE34b/+73AcwQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UyzU2ZLizIPdQte9SXoAkNe5xTTXbGtGRUCQTY+Lkcgpr4FdZm30fDHmaSwhAr/fwKxU6V6P60IMptrETNQH3sLuhybmARVk1hXWRjP7KevhIZVSKtZDaU4WZ6wFv/Qdc/+OSdriD4UkWkiEDe8mjutJB5aj2ECgf5vHzOzh9Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B3BMefDa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53C3jaN5016182
	for <linux-wireless@vger.kernel.org>; Sat, 12 Apr 2025 04:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YXlkgyW/d2uW7tyDlPRx3ZyerxZ0v0AnHxvv95MSB/Q=; b=B3BMefDaBtOa3kPq
	5wPtiApLL+SBIdfvKFAgzXXsRDygxJmxg9k7AT0sWHibfRZpVBgM/+dM/ayZWKOM
	Y6G74/fx+rz8v7Z2RoqYlsH/UD3OC3NBgtJ/TG7lgFDDoIKHjWc+57tMvLlYK/K7
	rhEzpuRYDO8pwFZCNnxfxK+KUdk0xlPWJIKFWOWXibakIb/eGhjYtu1nhs8O8ZoK
	Dh+CUCQ+Rwj2LGUWkFdKdbLy0uvuv0lhAbKk6U7QeUK6tTJzVvpCU+11SwwdSI16
	ICthw13sQ20P2q+LhinHab5ob2u2J7FYc/EaTd7JJv3Q4yOSzGGVS2/iEH/vg+eO
	fwXrHQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twtbcd1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 12 Apr 2025 04:24:11 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-30828f9af10so1904288a91.3
        for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 21:24:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744431851; x=1745036651;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXlkgyW/d2uW7tyDlPRx3ZyerxZ0v0AnHxvv95MSB/Q=;
        b=epERatEUCMzH5dXHxges5jhOhbRrUwvyfClqMp30/tVDIwhOPgWDBSxFtKYbKeYtuB
         2oJ9zQOBnS0E1jJzoiP6u+Q1TFCrbZYj+nL9dIZiKAoAzXSkd7bTaM/HlAZ8XX9vpYpp
         ThEBQbX9o4VTBj8OpQ9/UPayXVeSEVDED2ZPXkvY1kt8wTPqqsa39M39l7NJzNujbkZs
         HzS82tvRuzT5EyoYodoeicNlEp5LZKDoNfijtgzqe6chRPRoef4S168n4k4+HZ2Gsqw/
         3LbGvZzvk9F/pMpkSXIJeb4eFSKk4VnzIPQ+yV83By3MMKekbT4/H2jZ4v9l8iqjZgBX
         CkKw==
X-Gm-Message-State: AOJu0YxvPJJVbfGbA6kubIkJFbQGJX7Bm/pM+InRXO1GuN/imgRuB548
	UIuKKpcgS2mL0DNFEq6eEnQYb4YMNHSE3Qvj9PqHwpwAt+FB4cLT1aKZL6z/qC+TskwMh2NYT1K
	QUD5+w6CPb+HisAg08kvLgFWh/PqGncucfnJCQX+/iLmMJia6FPgbmxQl2da4mjynzfvJRrdNqQ
	==
X-Gm-Gg: ASbGnctyT/8z57m52p90TTAan9zEoqQdFJVey9y2anNBiJGRfk3hBImW1AMUoefUupD
	I4kH2+3MfAn2INTOebJ98rQuxhZtwfKcLVWvKWiTi7w6UL6mS44HcibCUkCC1PxCv++aFoClCFu
	sSOErIViy/IFejQXh4iB8ikbvZ6FgT5Hjmi3+tl1R6+QZiqSaaOn7Vj4LaJXIPz/yhi0y6f+9Pn
	Uj0YgrzuosH0OI9Fgf7KEpjPSpkW1sdN8Rbyw6GRO+DEu64243Fe9RwayxeeWnJM1uMOKYe2TgU
	xebabBySpPK4iO368GVa95OL3+/kj/R0sENQOqllLO5oPejy
X-Received: by 2002:a17:90b:2dd2:b0:2ff:72f8:3708 with SMTP id 98e67ed59e1d1-3082365241fmr9190627a91.17.1744431850649;
        Fri, 11 Apr 2025 21:24:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCLK3oAOFk6ELgexdBpH+9HMWc7+kC5/VbiDQAM5BHeLyNGhNwJ8k3OSvOeEtleNqFL9FmoQ==
X-Received: by 2002:a17:90b:2dd2:b0:2ff:72f8:3708 with SMTP id 98e67ed59e1d1-3082365241fmr9190596a91.17.1744431850190;
        Fri, 11 Apr 2025 21:24:10 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd11e643sm6829912a91.12.2025.04.11.21.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 21:24:09 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250403082207.3323938-1-aaradhana.sahu@oss.qualcomm.com>
References: <20250403082207.3323938-1-aaradhana.sahu@oss.qualcomm.com>
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: Handle of key_cipher in MLD
 AP
Message-Id: <174443184946.2972989.13905647697868648381.b4-ty@oss.qualcomm.com>
Date: Fri, 11 Apr 2025 21:24:09 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: B_hkHbeA1MwTWyDa01ss_dlmz-eK1IFr
X-Authority-Analysis: v=2.4 cv=LLlmQIW9 c=1 sm=1 tr=0 ts=67f9eaeb cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=FZy-mCtp5WpF6d4t7MsA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: B_hkHbeA1MwTWyDa01ss_dlmz-eK1IFr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-12_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=646 malwarescore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504120029


On Thu, 03 Apr 2025 13:52:05 +0530, Aaradhana Sahu wrote:
> This patch series ensures the correct handling of key_cipher, which
> represents the group cipher of the MLD AP.
> 
> Aaradhana Sahu (2):
>   wifi: ath12k: Resolve multicast packet drop by populating key_cipher
>     in ath12k_install_key()
>   wifi: ath12k: Introduce check against zero for ahvif->key_cipher in
>     ath12k_mac_op_tx()
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: Resolve multicast packet drop by populating key_cipher in ath12k_install_key()
      commit: d61c0b3c63462d17e63e5a2b4815e0f1ad17f57e
[2/2] wifi: ath12k: Introduce check against zero for ahvif->key_cipher in ath12k_mac_op_tx()
      commit: 4f4b067dd61695e860f97cae6ed6589a3a7dfba3

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


