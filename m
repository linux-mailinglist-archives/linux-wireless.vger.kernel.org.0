Return-Path: <linux-wireless+bounces-21685-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2BEA92D69
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 00:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1690467ADB
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 22:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B666D21C9F3;
	Thu, 17 Apr 2025 22:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B2KoRiFF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2991E215063
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744930660; cv=none; b=hk41b0PTz0tqnA7Vo/AWUFH10ohJfZC2Kn3yAP+NveI4TkU5MJzLFpQjFXk0DNU63lN2bFtUB8mljAuotIlS81ka+B0GuNikaWFZqv3kKUzF/wvjPaccTeCsHBX8skShqhMZVbIRur/ncq6XY9yz1dQ3XVblkX5XP55BfmNduGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744930660; c=relaxed/simple;
	bh=Uu3ydKuhkdCEVIe1AdmIwYmTAroa/xLECZLHHWmMCE4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JKdzxv5c6/TvE/fdDCYCS9mQQIO+iDHCzH2ThYGHGohm068x7DIwj3wbq4GBMVg9Tj5r+5061peSTiHUiDFuBHjKBLyArq5rppRhTRMgQ6COc9DdrBxWiWztkjziG7X1JCL6wNE1+7Zbf1xpbx0cvO5QfWYfpDuNCvDoudIW/Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B2KoRiFF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HCld9A013364
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6mseXXsT2rvj78UcdMHrlXZNdcLTz9XtO2FLR3j+uBE=; b=B2KoRiFFbw9VL1Xs
	oj4rwp9Ki9QuZ5F9cSRaTkMiYcci5wRq5PivlzypP/mQyQAGprcus3FQcwXipdXu
	W7yfWEK5JVE1taoth8/ivI4WIv6E4S+coDMiZbTL31yxREofHkIXHf769YqXtrk0
	ZInRN1qUsmHzHe8tqVKpy58avZocmOyecjfeacLqA7O1HIXCMrw8jV6u2Izs+9S9
	xgpDZL6yZZeCTZz+oqs/9L41S0CCb0ZwT6clJFC1dXZpfpt4GOAcAhcWJEyQ4NSD
	MlFrUJFqYIMlscjI7qL+FENUW9sWXph6wxjU1rbwDbY6UWCtBrsrCDU4jRbgn3kB
	7FCPRw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4628rvdqqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:37 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-736c7d0d35aso1715420b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 15:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744930657; x=1745535457;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mseXXsT2rvj78UcdMHrlXZNdcLTz9XtO2FLR3j+uBE=;
        b=WTIKjc2z24Hhnid4L36btE0E0YMsAeLu3cLalfpabgZ8VPIcsYBvM2zr4eZncsPpkh
         TzhxfhkWHdtESGFyr+5tyauek8g1J6QhdUS0m/vjjdqp4h9CH7Ki9HBnoCBLugFyNEPU
         qoJcer2NZlEiK1pc3TZUA5lJJdQQKCfO+xs7AmAtNETSHfK7cNkt/UvdiVbkkNnyQvNM
         VEdu3yoPDJ/bjYRxUVhUqBrtTbdG4LuOhYyxAiOrFJPwAKHAnKVYxk8fsrGukuLZrOTz
         uRlsl5GccVU6oOOzcMTXWUGMkf0Igb/jpCySEU6ZOTr3eQ0wg+pBqNEjhRAXP3AgZbvQ
         K+RA==
X-Gm-Message-State: AOJu0Yw65BEOzXN9XVN1Xe7Y4bfLY3YV6TqpN2iMV0V4ZYnT91oemq0j
	+jrdp1CzlPBzTFxxX7hy5JDjFYPF0cBP+1Nvd+R2zXXSY2mVVd48hs74Uy1Xf5kiRXfkZ79v5kZ
	gHEuqYAUSzlFHtMhQigWmFk7vVUk5a7M5C6JZp8x9LUtYCEAtug9HKLCtypCNWGr28w==
X-Gm-Gg: ASbGncssBTprDWfVyy+cy7G7GGqd0Y0nrqku5m/N/o2L00VG6Sp60VYSry8VUfECPZj
	aLGnTOV5+q2EhRruE45QYw/Ge9BFr3m2RkYfosN73dlhdnxgGRr76EO+0IHFH2LCo/2cTuBg2Ke
	KYEU7IvsuIeX9kBIuW4jn5Z1hSd9ltRudKfjMb5sXtEn3zfEE5BJk0FzJ8hAJOkySjjgRl0SIVg
	S2LuUGAQiSVd+6yf3T3Aa17tIn+tNS9AHZE3ezNaef7XGkvZtu/XCC/0eLy/Zh/1M2UYBsTvqFV
	65DeHJSQ9JFF9QXMVvvjlfOwPJNAgaHcNSBIfPUIY0CSC/95
X-Received: by 2002:a05:6a00:2e14:b0:736:bfc4:ef2c with SMTP id d2e1a72fcca58-73dc1190a44mr711430b3a.0.1744930656929;
        Thu, 17 Apr 2025 15:57:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr+3fQPj6racX/qlv2osFlwwq5M298/9HDA0FCIhMVsFMlx+2+lKchQEI5gEDY3VAqYY1hDA==
X-Received: by 2002:a05:6a00:2e14:b0:736:bfc4:ef2c with SMTP id d2e1a72fcca58-73dc1190a44mr711411b3a.0.1744930656450;
        Thu, 17 Apr 2025 15:57:36 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf901187sm426468b3a.76.2025.04.17.15.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 15:57:36 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, P Praneesh <quic_ppranees@quicinc.com>
In-Reply-To: <20250416021903.3178962-1-nithyanantham.paramasivam@oss.qualcomm.com>
References: <20250416021903.3178962-1-nithyanantham.paramasivam@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v2] wifi: ath12k: Add MSDU length validation
 for tkip mic error error
Message-Id: <174493065577.1347382.15140238727557332609.b4-ty@oss.qualcomm.com>
Date: Thu, 17 Apr 2025 15:57:35 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: zA6fAHS0hB-xJmED4gNnYR_rcqBGQ7QT
X-Authority-Analysis: v=2.4 cv=RbSQC0tv c=1 sm=1 tr=0 ts=68018762 cx=c_pps a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=fAuNF8LVcKM9mBkeKYMA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: zA6fAHS0hB-xJmED4gNnYR_rcqBGQ7QT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_07,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=822
 suspectscore=0 adultscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170169


On Wed, 16 Apr 2025 07:49:03 +0530, Nithyanantham Paramasivam wrote:
> In the WBM error path, while processing TKIP MIC errors, MSDU length
> is fetched from the hal_rx_desc's msdu_end. This MSDU length is
> directly passed to skb_put without validation. In stress test
> scenarios, the WBM error ring may receive invalid descriptors, which
> could lead to an invalid MSDU length.
> 
> To fix this, add a check to drop the skb when the calculated MSDU
> length is greater than the skb size.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Add MSDU length validation for tkip mic error error
      commit: 763216fe6c5df95d122c71ef34c342427c987820

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


