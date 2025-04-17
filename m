Return-Path: <linux-wireless+bounces-21681-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FB7A92D66
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 00:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AA8D1B64B0C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 22:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B2A1FDA6D;
	Thu, 17 Apr 2025 22:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nDBDPLbb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4B7184E
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744930658; cv=none; b=b/UYNYQTp5+N8AVNV1csY20P4X3C6gF9i3qZC/S14QtBosp7MgYJv9jH/tzoSeMl5kizbKu1+Ykq+cosUuvOrKHrKFn7Uqtu4baKHB/gxrYO/4RUm52q7kMmmNfpJ75cH8TAhBrNZExhG+lHCEQvJfzOxQz27u4GTQidZuKyh6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744930658; c=relaxed/simple;
	bh=tLQnE+Z5TUjWB2ftYRVgtJH5QeiaVH4gHU/ek9x9X1g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qPo9tmnhkkPs2ZLA2x9zLgH3VXTQcgBkl0ZK0W/RXlHfcXHmfzNV53wEyHEtn+KU9OL5TdaW8U/CZ1WBiFMuiVLtL+UA1jCVz1yA8IwDrQMTtx/eiwParzNaLo+5TprXqEXD71Zq6azYE3shfnlbltMs1jmiYZ24G/Moe8B3xbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nDBDPLbb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HClL5Q013014
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	074WXbpd5ThpINW2gnNNUaKculdaj9LLSR1kExFf6ZI=; b=nDBDPLbbumd+4azv
	pbgi6tjfFyZiom2LAryq9wAWeL0FuTy2iW21kleL4hlWFkPqfGRMK9gCU1Y3QSzz
	imGzCw5JjB8GZcoEv9aBpcq2yiv7JCKGEs0Fs5VD7a33xgFxyMuXdgOed0H6AcyE
	rR4hjyHXgxg4354AfrtAon4xL4C468dFj9qBNlgYCtJhwJhUlBXh6nseXqZn+Je+
	oH0/wQfD+JFHVNntzEiDZKr1AP20xI8USNwEpPH1F3X6WSHsjgirQKsFknC1OHrU
	dILsjlGLWhyubms0JEnYvfw54xG+5IV683of5ImIDY7ToBLupSZ1SySoPgEqJZTp
	4TwnNA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yfgjra1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:35 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7394772635dso781018b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 15:57:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744930654; x=1745535454;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=074WXbpd5ThpINW2gnNNUaKculdaj9LLSR1kExFf6ZI=;
        b=fVn2DM+n4estrYka1sHP+UM+L8G7yUetOFrc0Z3HMG+dgEOrxrs6GAeLUP7rTwGKKZ
         TcvjYOTGiifEer+MDYisHcKP21hFGqWmv4RSC4yUjp+F+WnS3W48Y+V4HnoDlQB2l9d/
         Z3duqlMr/Xp1LvuDY/qoeLETerAi7yvH54hOllRetrl0hsHwzfQ4QfZbeCn26bcKc8uC
         0+nBF47fAnud2yYAna671ReuDEOnV2gBx4EQWTaJ/4oKbidDmdtQaN0zCB2xs3YZkgJK
         KsYv5MUvTsn+xY4NZiUrXc9pKP+VOylypB0abqrIbTCmCCV5ol6JfjHcxV6aVGupaX2C
         aYqw==
X-Gm-Message-State: AOJu0Yxhh968Pnw8zKMV6fJTtOF2TMC8L9Jg2KQHn1v9WbE80K9PuO+D
	kYcp017HmfzTM8snn3R7yaUV+bL7UlkkoSFX6lHaPCHehskF8bGGUoHWakoqN1pc3zsILqlvkAu
	yZQRpp2ml+/AEUq062oa+aVZrqOjn4IZYIZsksb651WkUfcWVpJhZit4DaAnoqV4mLydoz3QbUg
	==
X-Gm-Gg: ASbGncuvGfmK432z1TKXTu0C7TTRRCsBruCqrp4zZJoD0Pbl52x2NnGSGW6PEyHOJve
	QGv9l1VgWw7D+i3kBIuPGFWdDYdsXtA+5sEe8fvYaHlj2PWXHYfroXx+sL6bCDTL/A4M1J3+VPJ
	ocoVMHuWjheHRTShSbyJ3eNOE8e/KBdZvm47jr88Ql6hahL8ifHNzMvOJHonk3VHEjClfatd1Hz
	p+b6WfhxVvcpScm1BgsZp15yZ7jOz9TF9Jqm8gczEphiuyyqRmJvDZKF5T+sEjVoTzqtn95VNbg
	aBMTcBf3a+JFyem5Hy3XvU+hZxlvMfpjMFjcBMDMcSRaZ2PI
X-Received: by 2002:a05:6a00:2e1b:b0:725:96f2:9e63 with SMTP id d2e1a72fcca58-73dc1616d31mr741749b3a.24.1744930653617;
        Thu, 17 Apr 2025 15:57:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcA/yAlBjLIAgYZjpL2bpVG8IPuEIYlISSdreAxfLrIsmZazyJSm2hYeaBCWbqALR29xIJbw==
X-Received: by 2002:a05:6a00:2e1b:b0:725:96f2:9e63 with SMTP id d2e1a72fcca58-73dc1616d31mr741722b3a.24.1744930653156;
        Thu, 17 Apr 2025 15:57:33 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf901187sm426468b3a.76.2025.04.17.15.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 15:57:32 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, P Praneesh <praneesh.p@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250411060154.1388159-1-praneesh.p@oss.qualcomm.com>
References: <20250411060154.1388159-1-praneesh.p@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v3 0/4] wifi: ath12k: Fix multicast memory
 leak in tx path
Message-Id: <174493065228.1347382.10308917568690015683.b4-ty@oss.qualcomm.com>
Date: Thu, 17 Apr 2025 15:57:32 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: YB1ox-Q9tzbLhzdVhBo3-UoLbSttUYsx
X-Proofpoint-ORIG-GUID: YB1ox-Q9tzbLhzdVhBo3-UoLbSttUYsx
X-Authority-Analysis: v=2.4 cv=Cve/cm4D c=1 sm=1 tr=0 ts=6801875f cx=c_pps a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=ockaDb-N3DHu-ulF3sEA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_07,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=703 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170169


On Fri, 11 Apr 2025 11:31:50 +0530, P Praneesh wrote:
> Address the memory leak caused by extended skb allocation observed during
> multicast transmission in this series.
> 

Applied, thanks!

[1/4] wifi: ath12k: Handle error cases during extended skb allocation
      commit: 37a068fc9dc4feb8d76e8896bb33883d06c11a6b
[2/4] wifi: ath12k: Refactor tx descriptor handling in tx completion handler
      commit: 10ec3d54df783bc9585b98559a1f556019312462
[3/4] wifi: ath12k: Fix memory leak during extended skb allocation
      commit: 1e326ada3586277faa1f67e9263fbc09311986a6
[4/4] wifi: ath12k: Use skb->len for dma_unmap_single() length parameter
      commit: 65bf4ed2db9ac3590c7f0545b6bbebbacbfd974f

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


