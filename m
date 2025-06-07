Return-Path: <linux-wireless+bounces-23824-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED097AD0E02
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Jun 2025 16:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299203B10C7
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Jun 2025 14:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5956D1EE032;
	Sat,  7 Jun 2025 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RjboE1O2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11C81E1E04
	for <linux-wireless@vger.kernel.org>; Sat,  7 Jun 2025 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749307448; cv=none; b=VnXJbScjaF7uT9fg7Z4iAauD3/xmSnyLLrSMJzWuQ9i5ijglr+oijnaj7lmdyVyXCxdYbDKhk+PGMQCFcoJwLzjB9yZ4S3C4eDfiXWNlggb64hecscFh3GJWDptsnXusNREAIXE5xs5fxVS0aeorMJSrkUSamoCqq2frdPW/z24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749307448; c=relaxed/simple;
	bh=2OEkL0/1YloljiLmR1/wOlJR74RgEaLuu5nTvCl8Gio=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Tt1W2i5XTYYVj1LmosAl/rtnR8wS7Q+NCUn+Mn2F63i+YgwgUuRivpcXDysfdYkKnT/ReqUtD5MB/JO0YFymT62HxZs4DLwYl4qsoi8ncx08Q4dXgnHx82ZQbxN/cX2aKpZvuQueZ0TSDPGkViJEPf+4KfQYTIMOIdUb2gsb6c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RjboE1O2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5574D6Vr022829
	for <linux-wireless@vger.kernel.org>; Sat, 7 Jun 2025 14:44:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4iU8Te9v2e7dO4cRDhE2B48yNbmx+gn8TOOV1jRgY0E=; b=RjboE1O2wQ2/k2CO
	CBz6ZxBjoxbC+ccEwE72EkFZwtwJnrKxs1VGOa0K4ZYUPbM79rKLIakPEjeJd8jo
	9EshUoKvRZckZgc+F52WLxUfXUXN/oBjlhTfLShcBZMe4INCxQVzMPHUPEzA8z67
	+ZY+YrCa1zWqW7b310RiUPgn/TnWDu4mLMIIO04WqhHoux8GFL1lOSU3MMxUJ/LV
	gLdIKsZaQ777JV383hdi5xW5DcyiUxMkWfKb6MxTmdiVtL1jasBFV8iMf2NColEd
	/s6v58jRlR5sMgiZ8ljtFuBnc+DTwhWFu/mQeY8WaaxlCEapZ0RrwMjS7x1Ie/RW
	NePaTQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474dgxgpu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 07 Jun 2025 14:44:05 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23495f5924aso23661715ad.0
        for <linux-wireless@vger.kernel.org>; Sat, 07 Jun 2025 07:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749307444; x=1749912244;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iU8Te9v2e7dO4cRDhE2B48yNbmx+gn8TOOV1jRgY0E=;
        b=q1xgBTOEYGE/SOF92CDEcwW6ifUv0c/1ScbITalwJkQIbuK0b/Vnx8vdt83e8XWyZK
         jprJCKIZWLU8XiLpS4dCV0Nr0bloO1bAZls3UkSl6iX4wyhCPR987e48NO4Rrck1iDZQ
         vBo16eSWs1mC/pn7aFhiOv4gddQLwmNOr4LtUrOi4czoXxOdw1hgTj85RaKdxoXlPTHe
         5zNta+zIvGxE7YxKBWTR/If4gW7aysq7bNE0Z/gFfVxvYI/+NSk8W+0DmF8c5UJghuhW
         W+mQyXfXaL8HDrUyoi2HWRLUHgLf16zClvOanHfzCHquswkfFwv3VsFWmCwbcJ0rVBUp
         A7WQ==
X-Gm-Message-State: AOJu0YxTKpyMseF5YD/h3WhsvzNbrjBhDFpwrSAUWY0hGVcrTospoYdL
	6eRvbBCfMnJGx0GITX9jyjA9TROacIHLMtZMhAUhslozZCobtLddw/5hKWxzLt/zsSo6bLhuzR8
	4tHLRaQoLLZRKs9ap3KeOqarYPHOSrZJiID+mctDx7ka8eLPGq+5fy5lwKmVndssGFjsefA==
X-Gm-Gg: ASbGncurlbN3VHzJ1rMb8ANDQsvzOJN5BwoW/avp9lBe1tHX7Izz09xEjVkdD6pXOGs
	sFavq8auDFfTCRHfkFSkeC3z5CODrkht1mBrIevxgqups7eITvtlhFGTlKo7xPVFNAadxJHD017
	ZF9nxBF42aM1oFNEqQ2oRrJSqXiibjqhSQCwvZ/q8yCR+BrFUSiRCDZAYOWDP4LKl9ZVaJq4EOX
	GQwgtrNLfhjh7v/VD9/KM5VUW0/bBDY2SLW9qoMJTN+ULWmNKHTxcilXWSZ9l2lJKtCbNF+cVUK
	WtI4ARCms52m8VCHaIYEGADp+TADQiRa783nyxQUiF8uv2zWyJJNBM2U7f0=
X-Received: by 2002:a17:902:cece:b0:231:ad5a:fe9c with SMTP id d9443c01a7336-2360207d144mr100448655ad.15.1749307444456;
        Sat, 07 Jun 2025 07:44:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeKUIj12Oorwr6eMwdlFcVN5kpcaOIa+5CYqOuw7TexiO57rHPLTcjS8SGWf1NRkYcWeiceg==
X-Received: by 2002:a17:902:cece:b0:231:ad5a:fe9c with SMTP id d9443c01a7336-2360207d144mr100448475ad.15.1749307444096;
        Sat, 07 Jun 2025 07:44:04 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236030969ebsm27626415ad.72.2025.06.07.07.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 07:44:03 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250605-hal_reo_cmd_status-kdoc-v1-1-e59f4b814b88@oss.qualcomm.com>
References: <20250605-hal_reo_cmd_status-kdoc-v1-1-e59f4b814b88@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix hal_reo_cmd_status
 kernel-doc
Message-Id: <174930744300.154748.1746628903090398734.b4-ty@oss.qualcomm.com>
Date: Sat, 07 Jun 2025 07:44:03 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: qRGoQO1y8hBe36liYca4kyKMcO2MBVwj
X-Authority-Analysis: v=2.4 cv=HMbDFptv c=1 sm=1 tr=0 ts=68445035 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=DsNapGL-N8PPGx-XoycA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: qRGoQO1y8hBe36liYca4kyKMcO2MBVwj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA3MDEwNiBTYWx0ZWRfXzL4J3UMtJ6dD
 YnOmxYHCpw1zbFpqv/5iSviDpXN/kof6MjHhOv8G4dBhn7OymiWX1fJZ7XnEu9Dy/6D1sKfLruv
 +tK+P7LUSvjJrwZCEiPBN/NnXsKm+Z8oKjniCkp2iqhoMzAqeKLuzi52hM98gdGyqUPzBzNCnmT
 GbGVSAeg5ozopB/lCMUX1nsUDaEIFPSIxv1FOMvFZA4XiIw8dRvhJsTeb8peW3UJWNcqrFHFCaj
 gviaeovYBnQ2kuJIqo6Ipr5h16gxaLCFQtDc1BOOUU2hY417/FGPiNeYziAkzXnN3XLdrjvtPyl
 ejydrPKpIrIsSUsnhyYEA9oiGBYhh7k6CqD63x9xuHGNp+Uxtwz+aCCaxV4N9Ordsm+2KSRoMXO
 BmU6ksFT7YQyh5PTNOniID6PKVzCgjhsd2TtnFzZGcIEsVHEFaPOyKMWwVXEIaCEx2/ca2aI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-07_06,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=688 priorityscore=1501 impostorscore=0
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506070106


On Thu, 05 Jun 2025 10:27:22 -0700, Jeff Johnson wrote:
> Currently a warning is reported when running:
> 
> % scripts/kernel-doc -Wall -Werror -none drivers/net/wireless/ath/ath12k/hal.h
> Warning: drivers/net/wireless/ath/ath12k/hal.h:596 Enum value 'HAL_REO_CMD_RESOURCE_BLOCKED' not described in enum 'hal_reo_cmd_status'
> 
> Add the missing description of HAL_REO_CMD_RESOURCE_BLOCKED.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Fix hal_reo_cmd_status kernel-doc
      commit: b6bca6d7149e0bc1a56e831af0296d45688945ec

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


