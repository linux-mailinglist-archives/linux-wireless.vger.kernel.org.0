Return-Path: <linux-wireless+bounces-27825-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02979BBEBE6
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Oct 2025 18:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0FD93BE5D7
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Oct 2025 16:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1D42D94B3;
	Mon,  6 Oct 2025 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PAmEkhCI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F95D2236F2
	for <linux-wireless@vger.kernel.org>; Mon,  6 Oct 2025 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769517; cv=none; b=G6oILdNXlL4udjTh6qnRL9KhBvLuqm6XRf8BXXepnyAplWEkDxiQkiSMOZRQlm4Lz+Inas6iywdlWeM6TTt6bNWRWMKmutzUGvzwawQdwIp5XXDr1AkRZCRXUUo3wID8k2LpI4l7YgHhGWfat4r8u1G3qUQii5C5fTEOSZTnMtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769517; c=relaxed/simple;
	bh=Pfu0WUB6w2SYX2/9pzU8lkc49kEocIm8ENtchYP3wXM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=G1B8FsYhVfGThBoKvnk/S3WGztoRupNwxJ5HA2jS3BBEex7RhAj5zwgQ3MgGeF7oat39ZD2gnFo0wjlhg3t3J8lGP/AWw60rWok0lBMjZEWvdVeztyGM3IL0tJNysi6WpdYZc6cMaCMNXjRDsVxusQy8UeaMCJ52MdLBoFAjpz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PAmEkhCI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596FNpns025473
	for <linux-wireless@vger.kernel.org>; Mon, 6 Oct 2025 16:51:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J5Y0dy/F8Pz45kdYzohc/CFHT9Z/aYMWJpsquGb0Ud8=; b=PAmEkhCIUQFK4dYv
	IkEHkZZJliZ+6A4Lf0oKeGWrJmfDrBGsc/MGNiWPFYycRw/S0/qRchm3lpASiUrJ
	IwBGts0l4JnsXkAU/D0VPPagWG5XjQ+qVHyydDtlyG9+1bJOAVmlVTYsDdu5EJFz
	jIwhMVkpcDGMKJpGkzhBi0VKq5s85uvn8MIc42WWuL3Aw5UdFCHzdq5rOFDXvF3G
	s0NMGoCjPgUfN9f2fdOXAB4iVChrWHkyMelbZvTQBMlxj3ob23Puk2f8Ra66HyeO
	F8TM6pwPdh8iD2k9/cKv/0mtBQICYTcXn4aHFKYoT6GYE3B8//F6MbRaAfilWFFE
	MRjT2g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jthpvneg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 06 Oct 2025 16:51:55 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7811e063dceso4098380b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 06 Oct 2025 09:51:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759769514; x=1760374314;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5Y0dy/F8Pz45kdYzohc/CFHT9Z/aYMWJpsquGb0Ud8=;
        b=cf47icY6Xg8wz2TdGbFFmnLZTzrev/1+exhKm7RgsmfgKq+o97QQ5DyDf/9GNgic7R
         7C+LFiOL4ZF1td7PhYpvpfmdpj2GNEe/oLYuzba/Q2sGOqwR61U1Ho/d25x+RKFCPr+Z
         d5RHfHxgWZp9mDCmQEx9y2JDGyX2yT7FQrfTfAA2OL9v7Hyw+MjJ3KLHoLFcKzkTs+cv
         hacWZ8XIICys3714Dk3OpcTHdgPUJ6c/s2CX/4a5aLxaPCD879afHf6Chpk1klioH8QN
         RoRRKrh0fNUDaIEZdtLknm5oW5C6Ku6bgdRb/IzY9Z3ukYe0zTQPvcDPIwNEvpR57mb2
         ie6w==
X-Gm-Message-State: AOJu0YwvjCp1PGkP23xIXpVVrjW/vH9b5QVXE2WPHTx1NW9H8b2jLMO5
	ZjzLdki+dVRzRqfrgfJK4yqlzuCcBJ6armuZ1cLjIhbVNzmXuwQh0HMvsdcnWlLu6ifaFx4HrHV
	mHl8EX20TaRqMOryWPoBbW+kd93lm9Ni7S/fz7gfekY8ricijl5TTtlZ7vmfZyekAPwgjKoDi+Q
	Ohhg==
X-Gm-Gg: ASbGncv3RPri0K/gTq/kiS/Yh7hP3jN3oBhhjWckO2Oj0PM5w1HGRVmVJKiSuNgBD1/
	Ny0t4p+I3yvgLW4nupNmt1ewatfxUnhNI1P/1XuNTI3UHnQ/v7GvmnUjg0MCwK4kFTp1aw2nJ11
	GS3/8UuNIXIOFsi0VQQg/t0bFMl0E+j2x17Gfhh+WNxEhLfQ7r6/7oC9kttW7g/UfqWtq+vyVKV
	6fcntJZdxObBsendmXIjB31VR8Qi/8R4/N2bLhBoczL6nnaariKVtgC0hd2nC9xMUqLTZcjBwYX
	13X8nZDb9eYYgtyQc67/U9EP78DULWRb6ILy52F2WFGnkaV2M0Ijt4msBIPZ6JF1O7FCCj3btpR
	xYkXMGw==
X-Received: by 2002:a05:6a21:99a8:b0:2bf:183c:ac86 with SMTP id adf61e73a8af0-32b61faa91cmr17495519637.25.1759769514300;
        Mon, 06 Oct 2025 09:51:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvGS2+2bERqXDVvsSZ6rUGgEMnvB3AZRH2DdaieSwuHIHS/UvGTmiII/vKFnMeBdBH2V3S8g==
X-Received: by 2002:a05:6a21:99a8:b0:2bf:183c:ac86 with SMTP id adf61e73a8af0-32b61faa91cmr17495493637.25.1759769513828;
        Mon, 06 Oct 2025 09:51:53 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0205336csm13293176b3a.45.2025.10.06.09.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 09:51:53 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Muna Sinada <muna.sinada@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, Karthik M <quic_karm@quicinc.com>
In-Reply-To: <20250923220316.1595758-1-muna.sinada@oss.qualcomm.com>
References: <20250923220316.1595758-1-muna.sinada@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: free skb during idr cleanup
 callback
Message-Id: <175976951317.3451922.3808648885786905191.b4-ty@oss.qualcomm.com>
Date: Mon, 06 Oct 2025 09:51:53 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: QkJXnEZri07aLWZPIdqMN9hNKZA6X7sV
X-Authority-Analysis: v=2.4 cv=N5gk1m9B c=1 sm=1 tr=0 ts=68e3f3ab cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=m_DE0tSJwjRw9Kafi5QA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxNiBTYWx0ZWRfX4vWyV2t/rOnx
 vhkHPuv2QqgNF3lUE9+cHQUcSVxjlkSBiapDL7bId4QrCgmoUPR8pe85EsGx+KJUTLkfZXqJw8V
 2xvTfv6FVJF3wSZkfPODRUhbSJn6S+VwK0W/MVZQWZGFItRV+n/slkW8dVSvJIfaKpqXxU0WLRD
 e7jh8g6CJ+e+Pu7XJPqbc+Uqkv3em3qkze4cKdYWL7G0ay01Cb5haukBaZdvIHfovSRR86p8sm2
 9+hUmx4Pmk4OTVqGBoFHsRrJC1prjVtKDk7gWhYm+FBLQnstTf2Qtu5JIFX0rG9sFY6dsnew4PQ
 r4oZLeR0fC+CRG3ccPvfr81RfjiX2PnXinVRneU2AJZL6KM96HazqCC7JD86xcrkLHnnadrJkHp
 esTYkSGTFQnAM+msS0HxTP9+283SXw==
X-Proofpoint-ORIG-GUID: QkJXnEZri07aLWZPIdqMN9hNKZA6X7sV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040016


On Tue, 23 Sep 2025 15:03:16 -0700, Muna Sinada wrote:
> ath12k just like ath11k [1] did not handle skb cleanup during idr
> cleanup callback. Both ath12k_mac_vif_txmgmt_idr_remove() and
> ath12k_mac_tx_mgmt_pending_free() performed idr cleanup and DMA
> unmapping for skb but only ath12k_mac_tx_mgmt_pending_free() freed
> skb. As a result, during vdev deletion a memory leak occurs.
> 
> Refactor all clean up steps into a new function. New function
> ath12k_mac_tx_mgmt_free() creates a centralized area where idr
> cleanup, DMA unmapping for skb and freeing skb is performed. Utilize
> skb pointer given by idr_remove(), instead of passed as a function
> argument because IDR will be protected by locking. This will prevent
> concurrent modification of the same IDR.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: free skb during idr cleanup callback
      commit: 92282074e1d2e7b6da5c05fe38a7cc974187fe14

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


