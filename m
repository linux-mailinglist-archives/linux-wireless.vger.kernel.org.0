Return-Path: <linux-wireless+bounces-28190-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 832C3C019E6
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Oct 2025 16:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 090BF3445E4
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Oct 2025 14:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EAF3101D8;
	Thu, 23 Oct 2025 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VSJjwT7d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745CE200BA1
	for <linux-wireless@vger.kernel.org>; Thu, 23 Oct 2025 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761228216; cv=none; b=jU6Oi+LztgIC7i0Y9bSqv785/8yHmUtFiVsOdmqqK9NljFLijti2xENlvpfQav3FjS1gee7KNULio42YrPFtukrA3/T+v/fhjIrYwyrTNiZLa1OhPT/OLcx8uWxS5G8UsyQiUv4/HXOn9mIwuWNmlqzD2pQ/5DsSRjqXZTG5uP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761228216; c=relaxed/simple;
	bh=QFW28FqVlNGO6aBZx7srJ/xBaDOUzxc4mqNLq6uUAY0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KzV06CH8m1JXHq/zooooa4aDdEN1/mFDbudPgDikJgDqbg2ttmmNhIbOlz1WxUV1Q+ji4zvEKj23C2Sie8iV0woPIAwbnS8rv17hOzdMMYYE/7d4kPAg3Di+fzLV1TH15zqe1jwrzWVTHtCm6NeAKwqyoTQ7b27BUcDle3vZTYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VSJjwT7d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N8AXuO019179
	for <linux-wireless@vger.kernel.org>; Thu, 23 Oct 2025 14:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Srx4yT3LHdOkFspwOn/4G+W2+bIvoleolhCAPoGpUaI=; b=VSJjwT7dEF7jI4bX
	nun/gxBpYV6ETdySo40yH1qO6hTkUSOCHc2RdI3Wr1zSefGNpbSkLWw1GQv7WtPu
	Gjn1VU5Mvt0+ZrcoXeed15h8KpJ/uwnPMCMiXduTcnpwr/lZLepct4O3GhLhJQBG
	PP3jAUehrixB0TX5VYOvqfRVp8VBxSYmF0FqguLwrYKPjprpi9KescIRZeOzOac6
	CcLeyW8SrckQ3FgG0/Mwnk/L9EZ8esnFGqW6YP0h6F7uyH8JoMxerrFeQZWzXi+i
	rVHIelqVC4Apj945kQoYfeCUpK9Vx7mbCN18fRm+2mfXryqGUT2U+aeYhMZjm0Z7
	mNS7Xg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y67qjm3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 23 Oct 2025 14:03:33 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7a267606fe8so749948b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 23 Oct 2025 07:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761228213; x=1761833013;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Srx4yT3LHdOkFspwOn/4G+W2+bIvoleolhCAPoGpUaI=;
        b=AsjhWkG3wgh2gA5Dgk5szO4Q0ps2HRZjkTCkM38AjiooLipRroZuJQTZ/BzR/RttPn
         5CeOW08RxCRisaLgx7EBQzJOsGuW6uisnpYsJnB9aCVgCqGcc7Fc+npDU2El9EUEwYWT
         jjbacuzET6VuxM7tvzl0AsCEWMXGGOL5Nv6mq4aX/JrlHOrp+Ta8KVg7lGHginjK2gVC
         +3ND5VRjslaEPJMtwklpuLPcEvS/FnlOoliiu0TcEkez65XXZGaDpINM6bSFDMjSUz1h
         gXGnoJCm78APjDzK42udbFyttm0tGFv97xWtNTN6oZb0zu6zo1jjzTRQ19mCxjNY9wBD
         H9dQ==
X-Gm-Message-State: AOJu0YzaQh84XCZu3i/1apfJe7Rl73XW8pOA9W94XTaWEqJYzJk1kAw1
	2xZsp1MoGR3HtzpKXfsVbag/OEUbTXVhc61yK/4h0lqc5dQboseVU6/oUrqpAlwAm/UzOHcMsSM
	QjQuY4gHXfUakK6P+Ijs2+uTOYgP0JBAcYkjSbbRCkk3BaqD5SeT2iqmrwC20WH430zrPUA==
X-Gm-Gg: ASbGncsey7G/0fhSGzYyMS0vO+TFUxrH8hVlQiDNSDfEEXjTswEt3lSux62FC6hJqrQ
	H6zOzWvIpsHFe8XrQSwnKYsgEoMpwp+25VnKbPSY9QamOiykZBuGdF/tpK/MFtPLvUO2SwkAeeg
	KkydHqEw638eR0OWsaKozphSvew/ERhYF5pWafg4VB8H2ziOems9qEFZBorV7vFE0X+cRNa53FJ
	jE3kpZZxcV8rKMpVykQiVamAGqHdQj+Y2gFv39aK4pvIWuKJcgsBUf4NH/oJI/orV/C7YKletz0
	ZAD2XqALR4sIwCSkf8BBDXRe9N2RnPHnuzXE8Fxcv+aY8Om4o8+gkLm/9NyX1COy0Q3PJtAqw+I
	izEIQ85Ej2M70UWnUnB8L5LsGzvVyKxvo6iA=
X-Received: by 2002:a05:6a20:7491:b0:301:26ad:9143 with SMTP id adf61e73a8af0-334a8536f59mr32200899637.20.1761228212775;
        Thu, 23 Oct 2025 07:03:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4uYRrWqPwiQpNmcD5jwY7nMjABixCJHrxwny3DTqmT7ssH+bXFvpVy2uBx/NdN05+D+Bomw==
X-Received: by 2002:a05:6a20:7491:b0:301:26ad:9143 with SMTP id adf61e73a8af0-334a8536f59mr32200731637.20.1761228211382;
        Thu, 23 Oct 2025 07:03:31 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dff3c1f8csm4250708a91.4.2025.10.23.07.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 07:03:30 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
In-Reply-To: <20251017-ath11k-mcs-assignment-v1-0-da40825c1783@oss.qualcomm.com>
References: <20251017-ath11k-mcs-assignment-v1-0-da40825c1783@oss.qualcomm.com>
Subject: Re: [PATCH ath-next 0/2] wifi: ath11k: fix MCS assignment
Message-Id: <176122821047.3033388.4520099279763878669.b4-ty@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 07:03:30 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE2OCBTYWx0ZWRfX3xHkf6k98wrQ
 SN1sIWhKV3nAcVv3hCJsPS0fp4RtpXAMCI7jJPAHR0FB+xwGZt716VM2UdIenpAfCRll0ZoVh2v
 VEt5tBUFyKXA6q+nMf9EeLd5FYdJQc92lNJjTS0vVOC52NidV4SIYxIKe1m6cGbnbi+t8v4tvus
 H7PeVUky+U/1/MK5znaUsP09bD4InF7JwtyDl+nLx5X0UHqGZNDU8Ot3HjtBahowvCL49UGesaC
 UBoe2oMZO4L95eyyx2UmQxEGZcJVrcZ2vszQ3r4+Lrlp9ft8ysSK/eG34aSIOkh6G/n8BI8y7fD
 oUVjnoJ5pppswbYoF16pcnPLHX0FgK6G+hs0pVZrkvyCOCbWlvTqA5dpf7N8TgCItuQT0QBUvHX
 /zgz+U4a8FVJH0gA+1jUqPcnhb/Asw==
X-Authority-Analysis: v=2.4 cv=LMRrgZW9 c=1 sm=1 tr=0 ts=68fa35b5 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=_wWWunvOjmwCgP-UNE4A:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: DWL-m1Cn44dvqpwV3zLbI1weDmU2o5yT
X-Proofpoint-ORIG-GUID: DWL-m1Cn44dvqpwV3zLbI1weDmU2o5yT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220168


On Fri, 17 Oct 2025 09:48:58 +0800, Baochen Qiang wrote:
> VHT and HE MCS handling are wrong, fix them.
> 
> 

Applied, thanks!

[1/2] wifi: ath11k: fix VHT MCS assignment
      commit: 47d0cd6bccb4604192633cc8d29511e85d811fc0
[2/2] wifi: ath11k: fix peer HE MCS assignment
      commit: 4a013ca2d490c73c40588d62712ffaa432046a04

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


