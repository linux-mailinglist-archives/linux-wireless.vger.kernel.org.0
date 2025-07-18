Return-Path: <linux-wireless+bounces-25665-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4F8B0A5DE
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 16:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A013D7A88BE
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 14:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197D5221287;
	Fri, 18 Jul 2025 14:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iXQBTeny"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80700189905
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 14:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752847772; cv=none; b=jQ50QGR1mZhTSsHgU7CGwq2RnWP4x3mSzwDvxr725cv2h27wBQsf0asxwvLsmpiNb1Q1cEt99TMWYxq67EDWlwi8WAml2w/6wJ1ix85pMrYiIue5asgJFPBTaFdxAPlqAC0h1IpBtlmfRJ+exmP7XnSClelXwxe5gVEP2QHGyDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752847772; c=relaxed/simple;
	bh=t2PDForSp9Y8FbMfF9FHF1IxF4/Eq0AMBwq1aNus2oQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bJM/3gfFgC7Do6BMqpZ9IfnvMnlM9AiVROaiUDN7DupH6TZEYRsrTe6nYXMrLM+YHlBAjhvpmYda0M8V54EcAjTfeLaSMLcmXa5xB+WFzrHr4ekRViZIs1rphksvpTKpflQ/ZAfrKko/BNtfnRw9wtFUb0ACbTlt5rdi6Ha/6vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iXQBTeny; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I7UUvG025369
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 14:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YBpmOBmmbAUomiwCuJynioIMsYx/BYWfY+f6v0i216g=; b=iXQBTenyQxBmfgib
	a8UvEyM3DvOe/xPbYFeugQQ9fsJBK+aIA6lZv+J/XNE8He12v21X52yl78eVYRKu
	bxB1QevfOOQQVSli2XChoDl6zPFsb3a7BkYvzmd8yE+C/oUj8vMZ65LMJ/KwI76R
	af4HpWfoptFu0rIOxSG2CMb2pFQOxS22i7sWdteXpYDdjE0CRZRRAn4R0SYEqRdm
	G15vX2DCXkHtb8c0yBxi89h/mbmTE2F9XsDg/5a5n9mURim0nFq6SFdVusSoG3ur
	w9maP0bRFHJMPUknIZ2hZ89XhK1vnc4z4Uh2H5c+dKp0CO6FkRLnR5GZ1XsUmcyE
	zdWhAg==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47xbsqg0uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 14:09:29 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-6139d0d3d7eso1249127eaf.1
        for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 07:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752847768; x=1753452568;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBpmOBmmbAUomiwCuJynioIMsYx/BYWfY+f6v0i216g=;
        b=aay0b4mEzIKA+R49tBW3WddadPEGVd50ao73M+RiI9ZYdUvXI7CHLReWvwOU7x+7mB
         +MY/rHBPNhnY4b05VIlYcvJjNbp6FirKyQax9DbWyNM4YLWlHjhyXsOmJK8gFkla7pDc
         E5if79VtWNODowtHMpCPW7k2crqazCFQVESuXayyVRbkKSKUU1lzX4+RmEh1he4VGmz2
         a1kASNH9Gya2HlfgF5BGwefMbARbs3UbTAp093/cST5/sHR7vb3DBGyq7YTqoLs5oqb2
         VkCOIiuQVdL9DT3/UWUMA/y7Z5d4jUEfj7WMvd4osGYH5JNcos4wThpf2faefA0HoqYi
         R4Fw==
X-Gm-Message-State: AOJu0Ywh+fJOAmg0bJ1lATKRpg1YGHORJA/JHTrKPDFWLP9rHJ2hAu6X
	wz9Jrf7W1PQk3cR4uJU8U12QKu5W6WNzncHU5YpbJkmDZtMyPXR6G5E0tRhPPz5eKVnJdm9dSJD
	JE2Ewb+R28ACn7RtCmclqaYacRMluvMYpvfgmD6BG5ZqMmhBBwranmwK0/9UAtS7Bzn21+g==
X-Gm-Gg: ASbGnctk9TtXDTfImfzH4dxN1JzcDduStOg7QXN2bqunGQBumdJHx5Q24zmPY+92rDu
	SAROp6wBsuDue252N5/vpDQNxAFA0MpTTlct8/Y7goIygXR5ItOOsQMPbOffCbRmfF1A5b6jGtG
	VCHoCti+GAkwtxiB245Z4dz+H88WnoW6xh/4C/GJxL1iUEC/zD8RdidENc3lyRTpVWojna45j9J
	kdnQ1cevaeRVonzmsUfhvwX6TKVs6JvsdIOpZfYAf7vPTx4hhQf13MhDb5RPgHW0IrhqXLTgOfm
	bMaMXWaAIUSObTzkb5XaiSqRXhbHjq9eOAzmIaJY2RZOK+xSEEq3ItJOKZphKciIVbpB6Pqsf0s
	A
X-Received: by 2002:a05:6830:2b23:b0:731:cac7:3634 with SMTP id 46e09a7af769-73e661145a2mr9719144a34.3.1752847768161;
        Fri, 18 Jul 2025 07:09:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwj67i55aVLzgWJZ2+fcS5oK+PpQ3DXdonq/HcYZJesrbI56S4nvsHNWoyb7g7w/MD2uBJrw==
X-Received: by 2002:a05:6830:2b23:b0:731:cac7:3634 with SMTP id 46e09a7af769-73e661145a2mr9719074a34.3.1752847767386;
        Fri, 18 Jul 2025 07:09:27 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e83bf667fsm605849a34.65.2025.07.18.07.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 07:09:26 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250717173539.2523396-1-tamizh.raja@oss.qualcomm.com>
References: <20250717173539.2523396-1-tamizh.raja@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v2 0/2] wifi: ath12k: Extend support to parse
 wmi service bit
Message-Id: <175284776640.2444629.31650595169743731.b4-ty@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 07:09:26 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=ad1hnQot c=1 sm=1 tr=0 ts=687a5599 cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=mHD6CMQeyVfguiJTsNcA:9
 a=QEXdDO2ut3YA:10 a=rBiNkAWo9uy_4UTK5NWh:22
X-Proofpoint-ORIG-GUID: gRPGB1iM6Bu4Kv-9t-Qm_fv5GELyX_mC
X-Proofpoint-GUID: gRPGB1iM6Bu4Kv-9t-Qm_fv5GELyX_mC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEwOCBTYWx0ZWRfX5L6uxaZchwW4
 sFc6uZx7f4o1vazQFGgr5GC6Iaw7mYoUFRB18i2e26tFIKNpCEz6XoOvMnjUyFdW0ObkgZGJqIb
 w7/KMnLr24BBahkXVnPEdbcqaHlprGzOop6pz9pink3h9ZGMJWgcZ0HqSifGf6CbSgpKNfe65fd
 woxtCLSed0LWgxo+NHmNuS4dmgkL5PBohRaQdmC0L8pjgJImUmYAfIjOAv4Xod5AeAQhB3XertW
 trdH4JnmF4thdfb8y+Fk+Oic7wOPuspPdUp3W+2gHN+kbysg3Riby6WyWxG0x36hMEzA/ugvkzl
 4XJti2tMjhIohtUeAV4s6n2km2UKCfsiQZWOIS54JX2RwpYeXgBid4vGEhjWv7Nn2ziYkYMsQJ4
 QpXEca2cUgLllmyePeRmQYuNl8zC5NR9/Y2GfoY+jH9wkNRUpSG6Fz6QEg9aZjNj9S15uHlj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180108


On Thu, 17 Jul 2025 23:05:37 +0530, Tamizh Chelvam Raja wrote:
> Extend support to parse wmi service bit till the last value firmware
> is advertising and use endian conversion while accessing the
> wmi_ext2_service_bitmap value in ath12k_wmi_tlv_services_parser().
> 
> Tamizh Chelvam Raja (2):
>   wifi: ath12k: fix endianness handling while accessing wmi service bit
>   wifi: ath12k: Add support to parse max ext2 wmi service bit
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: fix endianness handling while accessing wmi service bit
      commit: 8f1a078842d4af4877fb686f3907788024d0d1b7
[2/2] wifi: ath12k: Add support to parse max ext2 wmi service bit
      commit: 1a50c5ca394ab1b3a30094eda2354bcfc00f9909

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


