Return-Path: <linux-wireless+bounces-22669-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF88AAC859
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 16:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A5EA3BF977
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 14:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B76E1DDA2D;
	Tue,  6 May 2025 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jm+aKk81"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6879280CD5
	for <linux-wireless@vger.kernel.org>; Tue,  6 May 2025 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746542570; cv=none; b=cZL33LAaQnRAnySyRml7ZK/MnZX0N3bVAQ5zQZv2r0rJfTXScPYRH/DxEF1ilNbVgz86WNdc8MPP1Hn3pkpb6Dmk7SUOaMpf/8lpW0GFtOa3vZKCKEYG8x5xFd1juRf3aeDmCJSywSiJ4rYcD9cvFuVrGs+kFdg/Cj0clnXuMq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746542570; c=relaxed/simple;
	bh=NVuxPtmNgFRLLO/QEEuCdsEnIPhYSYgqnwTKkSkHlB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G9cpVwgsSorMpK3m/Bl6Y8pUbdtCDyabvIskmuegnxBPb81wm47cCerlP08X6LsCw3F8OUQAwJzftaU6fBSaABzoZqpyRkiMsMfyq2pp/zzSifJ3Jm4akvbKxPwLlsA+PDiT/jPeQdos2HryJ8yMMAmlwymMf1DqNoX+e4Fh6zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jm+aKk81; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54689MVQ016421
	for <linux-wireless@vger.kernel.org>; Tue, 6 May 2025 14:42:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3VjgACMnGXxy3UlT5YxgJrb2cSeHYPLeC1Xee4gzTH8=; b=jm+aKk81D9yzSpwd
	P+4aDZBe+cSFF1NF3Zx7gJM3FR6Cs9rjarzoTcGmjaRWYStMzUTYIoKnj2kmTZHs
	vV+R0te18Pw37vbGoYoHP2SmAN9WXe82s+aFqL8mc1y9phhTfl2hBXUMTBWvNxyl
	/aqwGbxEay0HI/BLPNYR5bB6YD0joIQV0FInFDwBaCBpolrEiWaSnqKqiRcVaigI
	xfi9WCxzltMntgZcZyWo6dYBroSVeKkEaWnBR5HLvK4wPc3MsPyREHBUIgm9i3Qs
	Cb3iD6WeBuAvPJpFbza3Svk5/+dHS0u/UtyS2rfMeTd0sPNf22hU9/kvbXob7pYD
	EzVgTw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46e0xsxfgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 06 May 2025 14:42:47 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-73dcce02a5cso3387790b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 06 May 2025 07:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746542553; x=1747147353;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3VjgACMnGXxy3UlT5YxgJrb2cSeHYPLeC1Xee4gzTH8=;
        b=o3fz6RlIdsVv1yDiJbksek0sbQ1ZHzQCUz9VgvOJF7P2U0EYgeIBXq3K6t4Hxs6xzO
         ItGtKawnVa+o3mHhFc2eloAMJEnI/cSSPUrLPMMXTKhMWZsqECrxuwiQt0WnOfE2Uw4x
         DDz/1tgd8Q+SkR8c3nVCgl57pj3fE9DKb0Tz8fRCKoSGJy0pu7mtCMg3tsHeLPG3lFBS
         +3K+9njsXETly2Xu0RGUIEJTVXSrOQMrP22v+HETdiJSaLzhppXT6Cj1tfga7O4ylyQ/
         PJXpXymbkMbVatPHEZpse+nhXHpuhu7q4qB1d4zWXCsrVmJbOp27WjB77PR0CP0Gk8XA
         kyjg==
X-Forwarded-Encrypted: i=1; AJvYcCWyHotYSaATqpGvTjpL2zScm1b/MKBGbo0GomLoJjzWuNKyyEwYL1EenWOObuLeC0V+vHdSgXOC92eny/fThA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAYsvTV7E37+UqQpFbhlRa2qE0z7Y1Chi6efNwsPXrWMyeH2rh
	Bf+Kh18F4jKSeWwr6qJe0RpmzEQnFByv7zspxJ/VqZPoi5e2NlxPdEB0/XpEGc0Jl6xjmpJykOU
	SdUJnk3Pixmvqhwha8HUoHTHoeqsEWQ6AFKyzMh0ymlASTJKmg2wMGGD/UjW7OESlrw==
X-Gm-Gg: ASbGnctw9PCojCUvk3hbf5qCUIQkPdU2qfPLrnqre2kduNQ4YoIROwXZ4Xa2bEw2YBu
	IzQMDXSPd70ouJR3wR5EszpjvabxQduJyyjFAK24bYN1Sgi2uhUxot2HpKkmk2lLzKF3GNvs+QU
	cFXfejO6xFRnsghxC695LaCmb+/NscoxBIW4KXbSp54Wx7vOuCQRfn0r06t3cIbpT6Mgjq5Wpt7
	STbaTm0TRk9X2+OEv699EXQXML5auIHMiRGsTcyY+J9aPkn3GSplN8VmYZouPDMCM046DYzu3wm
	8BiZNCeEco+oLvL0hzkg1o6Q+Ju67aGafbl+B/tc1iqghYQRWz+OdZ+G9iswKHA2LKY=
X-Received: by 2002:a05:6a00:2a07:b0:740:6615:33c7 with SMTP id d2e1a72fcca58-74091a937b2mr4842340b3a.23.1746542553028;
        Tue, 06 May 2025 07:42:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGENE7YHnc3ggGxLX9mbaGNGvNws07uOv9xUg5kw47zlhrUsZlSNkxEzxWCz8ioV3P51rTswQ==
X-Received: by 2002:a05:6a00:2a07:b0:740:6615:33c7 with SMTP id d2e1a72fcca58-74091a937b2mr4842304b3a.23.1746542552655;
        Tue, 06 May 2025 07:42:32 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058dedcc4sm8989298b3a.79.2025.05.06.07.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 07:42:32 -0700 (PDT)
Message-ID: <2b85ccce-70c5-44c2-b598-d148358843c8@oss.qualcomm.com>
Date: Tue, 6 May 2025 07:42:31 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] wifi: ath11k: Fix memory reuse logic
To: Baochen Qiang <quic_bqiang@quicinc.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: kernel@collabora.com, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250428080242.466901-1-usama.anjum@collabora.com>
 <f58075f7-f643-4e47-b774-dc529aaa01e5@oss.qualcomm.com>
 <3732e542-5b8c-4351-8e41-f9f0cdeb4643@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <3732e542-5b8c-4351-8e41-f9f0cdeb4643@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: BGKO00Z-akbMYXkuj2BkSPULf1AXjJUr
X-Proofpoint-ORIG-GUID: BGKO00Z-akbMYXkuj2BkSPULf1AXjJUr
X-Authority-Analysis: v=2.4 cv=bdprUPPB c=1 sm=1 tr=0 ts=681a1fe7 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=X3YIGVxls8OrOZudXCwA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDE0MiBTYWx0ZWRfXwkkfsXoJ0X3x
 ALNrHKGS4q3FDtgpA6wZMid3iL2tg/Wjizn3K3yTysH+p39Vr5kCCUyONTBYfL+I3L4aQsHDJHu
 2+wp3RQqB0rvyNK/OIAZURN4pP3rnZtcUllUZlIr9AOcUS5WtuRCay+48qf/iA0StRcIA9EjS8M
 zwaQcrQGhceTzAbK56wavCG+seWtxCUF/XLtpUuAlMRmD1qrDDx1Os2C8tKhM/UV3D4Iv6cV7VK
 Z9xpoao7G3Qy1ZCrzjSVoGtXlV3Y8JZeiEcKq+exy3RBFBUYs2MsCCEY1Iihlbr7mzaC5bvQHJz
 vjixnfSw56ntRtAZFA99zCD22OSRUBtU8Yon7IDmXfTihrqnjCEfcHUZYpad63jjhrnjuDuX3d4
 /0raMp2EZPTFR7oBzwvU80awTQWBvO5WqpFOruFZb2NruJKJaScEXl3QFbVY8SQY8ipoPEeW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_06,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505060142

On 5/5/2025 11:43 PM, Baochen Qiang wrote:
> 
> 
> On 5/6/2025 3:17 AM, Jeff Johnson wrote:
>> v2 feedback was not incorporated:
>> For starters, can we make the subject a bit more specific, i.e.
>> Fix MHI target memory reuse logic
>>
> 
> Ideally I prefer below subject
> 
> wifi: ath12k: Fix QMI target memory reuse logic

Done:
https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=ec570013de60b8b0bfa3cafd516ba323e6e29a8d


