Return-Path: <linux-wireless+bounces-30606-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E65D0B0C9
	for <lists+linux-wireless@lfdr.de>; Fri, 09 Jan 2026 16:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1532B306723B
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jan 2026 15:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC77D363C6C;
	Fri,  9 Jan 2026 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H7N1DP6n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K+ekOz0C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B1435CB85
	for <linux-wireless@vger.kernel.org>; Fri,  9 Jan 2026 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767973525; cv=none; b=k/DOhVdTT9NcqKPiCdS95rJukO4U/e7RbDY8tabkN/espty2W4l1yj79iSCiDblnC0jZy73dniLkrvnW7Fg5yjE7Qm3BFIoXbjO46bGxK6HrLFpoMKo6a2bkCm+lbDOpiHA6oL6HVFGrQqGXHjsB10B3fFvPaUt4QrpsPCOOOHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767973525; c=relaxed/simple;
	bh=v2WsfPQNKW10sXdzq7OgGm0CTC40+5UOeHp4l9WO8lA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pNHE9rYtgqGbp0NKuTMRrKmh+Io6ogJFxX1QsrWEYNgAOUgh9N+D16hQqNHHadjxX6goTtrie/CWT84NkmNgP3DcSCqjbgDCrs3Wkm0FVvmwQJmKNsFco0uUdTbkttxs4NPsozLldanT0i6iR/vQTHQ4C8iPEztLIlHNpoGiCyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H7N1DP6n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K+ekOz0C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 609DWGkF3142710
	for <linux-wireless@vger.kernel.org>; Fri, 9 Jan 2026 15:45:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pBObDvpD7xoguADs/F05XvaSpMVqqpb7Vf8EU4wwwCk=; b=H7N1DP6n7tNuWRLw
	yXDvqe/PSH8t+0Yu+zZD+yhamRa7JeIK9if9qg7fHHp3CGaFITkQvk4sx2VC2hrE
	rKeRIVAi0+kWMKOIBxlKxLKIJn2IRv/ZXs355yn+72J/xePTeJeyIoUzYZT6UCIT
	QGPWw/tQpJBVxgYWiMGNRqY3lB5wLBzc1U+2iXJBOeH2VFPQI+TypXB8YxgSZsuM
	khgcveHFv5SVEt3BZLCy496iFERulLC4HZOoY1kHTQBpb16tO+4di+Zwzhp2e034
	uh01/kcq+BY+FPh1TNKL7XGEiiIdDgIgsk+aUVl7gvXrXidf3TIOezyWpy+/ElIX
	8X3kwg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjj8j35rs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 09 Jan 2026 15:45:23 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b0530846d3so3720599eec.0
        for <linux-wireless@vger.kernel.org>; Fri, 09 Jan 2026 07:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767973522; x=1768578322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBObDvpD7xoguADs/F05XvaSpMVqqpb7Vf8EU4wwwCk=;
        b=K+ekOz0Codn2lCDjRgVgXuLXFBw6tl8HsQUQxacWw1aR3EvOaFwubcKw8FhchfdOv/
         OlRVTMDf6YmKIJaPQHiC76SS3mtDg0iQkrys6xIGfjmbEES7H1DxO1rPAs6tU7E5qEwS
         JVD5+CBjLAUQUwpkSY+KfjRD/XwbqJHOCiY3bzBVnku7iglQEZUI/diM5bVIhG3cslyo
         Xt1mcYfTvt4PnmimwpijiSjL6haOo8H5FV0y+uH4w18aDflF9Rk8UkQYUNXl/Q5lm6hL
         6oQYcVbV8qwH2nkUlHe1sUUlr7vlm7h4PXV8W//rt1yuRpx30Oir/YzjjO7Rs4i5zIYZ
         yH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767973522; x=1768578322;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pBObDvpD7xoguADs/F05XvaSpMVqqpb7Vf8EU4wwwCk=;
        b=STsd6lDX7TXtCkse/hbd772RIm7ShUI3oqvv2K9pEXKGE6xplzcbi1rf5f40zbkOJG
         A1EtcAmrXXG5DkvluXBSEudHM3Vzm004chpBbyHQf987n7rTIGop8n/9ZKXNj3t2+mv3
         2YGZuRnpFV7AftLsYj+7+XG//L7ZXiQIsEeqkXMKp515BXJwrX7n3fEBZveqPf4OVLy1
         9hQLZ0H1A9H9f1WedPp3ZBDlDVZrq+Dt6+PNcqFbqIkqtl3x1HICC1aoBACTI9SeAQws
         3huZLtPV8NZgWcDKBUF6ycB3F4THd0dAllFRnt8/Dz1dbP6CaTaDNTT/29vp/4N8Ao5b
         SloA==
X-Gm-Message-State: AOJu0Ywps6zlS3QV9jef1cYvT0VrOBbavqvlrE6A6L2MK2LlaElz2TZH
	tmwn0kfRbDrRk+kTdQV3piiM8Fb5l9szfrFTAemjc/bPEH+z+WNSmK6bOFsZdK6yA5KeqOd5tb9
	Hz08wHA1mYaN5EBimKK4BM9FKrSiINCj5wBa83hLbK4ieyO5ZQAeadSDa0sTQP2bBkGAS7A==
X-Gm-Gg: AY/fxX5pPX1ba+Ibu1a3oj+9c88GNu/pkX9t4z7p+BZh9oBPCs2n3VNH7kWZ9AqJt4h
	YuDUvGSRx2kzpwww2RvPfXFB424f3Q/3DXKWTlYqqEG3s5/eQeR+HUNw2hFnwOGmQkfJNLpKypm
	VlrzO7rDNAlJ+V+/MFTt9cb7K53X6yxpINGX/ogiKwL9mL268VuOD3Oa5Yt/7Hx42xUPgee9hQg
	2rxScUyf5UcOzYAV8Ym/lckPQf5htC9lKh+DebWV/RZUf7W15AZo3iWocIKNf4UODVrYo1+g+aU
	G7+KEKXWnt0HnftEPXSMofUe80qsGKJ5hcWqJnbCgXsaf4kaeGu9SdoxCZaWGVMd0Bn7eDFXxbn
	ZFWmHtMW1MWELTuR8gillnOkbi2s9ynlcczi9KPGn/WvYEjEtWIqa/a+i/gjfTvo+
X-Received: by 2002:a05:7022:390:b0:119:fb9c:4ebb with SMTP id a92af1059eb24-121f8b79686mr8559675c88.30.1767973522078;
        Fri, 09 Jan 2026 07:45:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQAw56QFLH6GdhAipAkIvcalyVNFn4UvlGVNoGh83Ec8aR9jGRk1QOBEr/C6Ot7iHgaYm1+A==
X-Received: by 2002:a05:7022:390:b0:119:fb9c:4ebb with SMTP id a92af1059eb24-121f8b79686mr8559640c88.30.1767973521476;
        Fri, 09 Jan 2026 07:45:21 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b17078dd8fsm13212585eec.20.2026.01.09.07.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 07:45:21 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260108-ath12k-fix-freq-to-idx-v1-1-b2458cf7aa0d@oss.qualcomm.com>
References: <20260108-ath12k-fix-freq-to-idx-v1-1-b2458cf7aa0d@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: don't force radio frequency
 check in freq_to_idx()
Message-Id: <176797352103.2503774.15868075512188538185.b4-ty@oss.qualcomm.com>
Date: Fri, 09 Jan 2026 07:45:21 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDExOCBTYWx0ZWRfX3w70jehduG+4
 3DTluxLEiuPA6AF31d73nzrkO836abKaMJj3W3dK8GbPM+0jCLisxnWHpAqfrOf2u2FhuMaz2Kz
 XysKjLJUQEc7WPZ3/nOabfzDLwcy/4xfIsxAJAAHy8uVquucWYK1BxX2WIgcudMIx7JrpTV7ZxE
 EFlZSEi5Ez0hUxtQARdFbxZl7f4jeWlwcQR15CEMMshxmHt+2YZSShl7N+gEkCb2+AGcoqnshRf
 RuK0ehoRIlhID2+kdppJoe0i3N/VsIoi0YNwlh/a/Pa+SUh/Rf/qlD/Wh4/AYglVTB2KbbkvzYB
 3o3y0k+Y4IqhQdZ+vTJGFVm5CKPa3mNGByFLN3gSgGnzkhL/cUXNpU5T+00yQooqkOeXaBFCDwh
 JANXVdso2eKdiX562RyygvcINMHrjK3AxL7hbXrfmy2tIC3lD5OibT9i9GY9LWc1UnAiFiOKcjC
 cBVI4ZBSVnI6NE482nw==
X-Authority-Analysis: v=2.4 cv=JIs2csKb c=1 sm=1 tr=0 ts=69612293 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=m1Fd6hlChVUmc2GNY24A:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: F0ou6eNEbarqiuCwVJfJ5wtiN4o0upRQ
X-Proofpoint-ORIG-GUID: F0ou6eNEbarqiuCwVJfJ5wtiN4o0upRQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_04,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601090118


On Thu, 08 Jan 2026 11:21:46 +0800, Baochen Qiang wrote:
> freq_to_idx() is used to map a channel to a survey index. Commit
> acc152f9be20 ("wifi: ath12k: combine channel list for split-phy devices in
> single-wiphy") adds radio specific frequency range check in this helper to
> make sure an invalid index is returned if the channel falls outside that
> range. However, this check introduces a race, resulting in below warnings
> as reported in [1].
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: don't force radio frequency check in freq_to_idx()
      commit: 1fed08c5519d2f929457f354d3c06c6a8c33829c

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


