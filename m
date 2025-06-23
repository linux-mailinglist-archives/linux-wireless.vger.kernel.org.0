Return-Path: <linux-wireless+bounces-24361-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1E9AE4755
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 16:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2D2189DB5F
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 14:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EBE2750FB;
	Mon, 23 Jun 2025 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JROfLtqd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C06274FF0
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750690132; cv=none; b=idfE/cnJur5p4rHWOJ090F4fGwBkfW/EtTGU1H/iy4Uum+Ddyc7v6RSTBez/Un/EU0/QtbBOiYGslx7IKA590bC3XR6mEEDQsnvNNyCkDON2Ub8BkFYRReq1ArUlWUnUkgBC5UR0CDkVVJaQxOKvJc94znXqo9LSI72YK7BVC1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750690132; c=relaxed/simple;
	bh=lnIap2uoB9L6Gv6mGUMzZpCUEOQea4hLblMIRH05vMc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KC6WLzknkQqYyON570v2yt1oklhB0LfOjcLKdJuTIY2Njo1z7vriYUnvmADuFenKJK6ihhj73Q9nHgeyP23pKNK22/dCcxIyqnfWQJiVJQ0fOHY205jEm0rLZYqD7yf0sLGr2lA5qm4AFTLssCVpooBYCzUAmsYwFbpOb+/kOgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JROfLtqd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NCKWM5029889
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LOCM1tAGatqvuUpE1vuXd2MaWKze9bMXgr+n8TWjS6o=; b=JROfLtqdNL73TSL/
	fmVI8WpkH2TS5+pWTu4PqiPzXJ+Wu0mVPfpRyKsf6jZGPEpDP53OqwTNncIbz3S+
	thVlygQR/ws6ykyKJJzVoofEFbeYMOtMUqS78hS9MaktQVajoeb5/mUxztzjotf0
	wMEgkynMsoPx+BXySEArjZt2SUZrrUvHtbhihRbLwvwMowBYts5enM4fnlFTJJS5
	ndxy9ZxKpscNIJOrHuVnCAb+VnKzAKlisOgDT5S1FhXWkFk6TItXIgM/OKI8s15x
	tU8/CPKWZ5vx34HpssybRzqVgXMjUdrFzIsRWiZAS7Ecsc92kXVPVf74YXHfPdPi
	OSvYmg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ey7k1sy0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:50 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7398d70abbfso5744430b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 07:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750690129; x=1751294929;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOCM1tAGatqvuUpE1vuXd2MaWKze9bMXgr+n8TWjS6o=;
        b=qHtMHKWMvMOit3vk9ZLuxMpdEL03tFB/cgi2zXfuMsI9KNWtP+29zJf8BWplm5wPjs
         g/mQPR2tZk/9uWB7xzJQgoMBS7okn7cJDZxlL+IDsqAC/+muvxQPHXnLNzQ+C5uYltDx
         n7E5BguZacbqrkqA5ButSQ82c+Y9Yq4ikqA+mxUsROFI2x81IsLcaf7MQ02dtooe2iGA
         XGMiQU3Zo7vY/tlmenXW+NF102MkMVWdhVPvgVNmmuw0UKUxCRvnWsHi9LgYEBf4wu4n
         3SbROhWcVoB/HGUnQuzFJAOrizUrJfO0whS/YmPYHfXLLNC37SsJVcEi3vvxEF938Ufd
         GTlg==
X-Gm-Message-State: AOJu0Ywr1/t4yyYDA6zRKmpUYMxkb/ssxkymfBbD7wMX+SXMG40AWp0u
	HW6InKnfLY1tRGMbLTQ4jGbGpPc5KkJ+UFKNy5WXaUCu0Z9OW5CaPYSHJLL4KKjU9cSoXou/vDu
	XAKgrKD4w3eFxQHC8iCqTrAbnHAPZ4ImeEEZUpZzSNGbB6MBVPURluXlVcpEYTBaljmG7Vw==
X-Gm-Gg: ASbGncsMqWT9NZ5KoI/ev0djlMqu32DdWUQ73iiSL1o5ew8UcrzH2M6jMJlUfJKY2AR
	Fnrq93lghqJqLKhHU6tYNOwmUtO04Kb92HW0lcf9fis9JdTOmLbz7pOCE4zIqMhxpVwvQJRqHgY
	dMDgaxmSkCyjYVK4hzVqG08NAf5X3C1YCHYFmfHT5ZD2bJhdRJgq4Qz1aJYPEmpDf7ZB0L0Lx4A
	H73sTN0GZx+z3223FzhocgjJUWKrL0SABF1jSVkwgpKZI+xVuvrkXm7IZBjZFGZCyNxw3VaqZEK
	buidV/HyS/NFqUOs1naV+m6Gtl1uxkdX50vmYW2ERBltA2Vz7GBtL2F3Urw=
X-Received: by 2002:a05:6a00:3027:b0:749:464a:a77b with SMTP id d2e1a72fcca58-749464abce2mr4789113b3a.18.1750690129139;
        Mon, 23 Jun 2025 07:48:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlktiwR9SgURSgPFUS0DTsoXi5zB3HvrPc9cZdXpa1GmrQr0LxuniI0dtk0RcrFa5bKCimXA==
X-Received: by 2002:a05:6a00:3027:b0:749:464a:a77b with SMTP id d2e1a72fcca58-749464abce2mr4789082b3a.18.1750690128730;
        Mon, 23 Jun 2025 07:48:48 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a6d1eccsm8332894b3a.180.2025.06.23.07.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 07:48:48 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250609-qcn9274-reoq-v1-1-a92c91abc9b9@quicinc.com>
References: <20250609-qcn9274-reoq-v1-1-a92c91abc9b9@quicinc.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Enable REO queue lookup table
 feature on QCN9274 hw2.0
Message-Id: <175069012802.3758471.12950159281764113432.b4-ty@oss.qualcomm.com>
Date: Mon, 23 Jun 2025 07:48:48 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=YoEPR5YX c=1 sm=1 tr=0 ts=68596952 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=hk8jstzJOELweJxXsYQA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: gZuVwhBJSxBteB2H-iEe36rZDZc2OZlw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA4OCBTYWx0ZWRfXybHyIehciGHM
 iSLj+FWnzdUnHNJAItdLTJmg2kmQHmCDOmhwA32YSv/IKONOUHvrYIh4TjaIBNzF0EfIOjf61jl
 O0JpgrmgruMClSN6+A/9RJY05E2rdvHTxIYxHNd8TWN5YMWLNxXbPMbOSmiT77BcLWRElk3wHWf
 4vaF7LOEgMAmIO0q2jtllAbT3iPK2OAPOp4ZBVbtKlbP6UepqPs+ZrWc0UgzLvZLcNliG+/knXY
 iwrKLL4s5J+eG+6fbCyCoFCfKNpHzMMpWlSWTF6uBQMTjmN+H3Bwpe6ZhxvgUZNIMpevQw+ybck
 s4NOTCaK0rDHI9xXxDV6rDGi2LeVYTsOjhF8e/JI9Af/Am4jAH6kmXifhqBLfvqIl04xTQ0bYA9
 gC4mgZLoCoC5FVgvwu/KymI9c/pzp/mPw6MdDQp8HDMKmL2wux6kchqoHo6l8cZ6woQcNZRA
X-Proofpoint-GUID: gZuVwhBJSxBteB2H-iEe36rZDZc2OZlw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_06,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=844 spamscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230088


On Mon, 09 Jun 2025 08:48:50 +0530, Raj Kumar Bhagat wrote:
> The commit 89ac53e96217 ("wifi: ath12k: Enable REO queue lookup table
> feature on QCN9274") originally intended to enable the reoq_lut_support
> hardware parameter flag for both QCN9274 hw1.0 and hw2.0. However,
> it enabled it only for QCN9274 hw1.0.
> 
> Hence, enable REO queue lookup table feature on QCN9274 hw2.0.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Enable REO queue lookup table feature on QCN9274 hw2.0
      commit: b79742b84e16e41c4a09f3126436f39f36e75c06

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


