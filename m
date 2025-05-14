Return-Path: <linux-wireless+bounces-22942-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B02DAB6E93
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 16:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB34617CEA0
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 14:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FDD2A1C9;
	Wed, 14 May 2025 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gVZraC9f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D405819BBC
	for <linux-wireless@vger.kernel.org>; Wed, 14 May 2025 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747234455; cv=none; b=Nuri+mgminv2qsxQ8J+ZzE3WWEGrls/YHQIh6sHc/jUzcIHyHlbxctNfHZ03u6XfvNLntDAHlUEY5IXUapV5SKox4YL3d/88PFMUNuwFiQ8eN5FZecWzU2z/nUgjMXNHx2RrDK1Cl6iBjCnRHtQ4Gkmuy2Bh1P3NRu+zAbjMg+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747234455; c=relaxed/simple;
	bh=LfUEPnKXW1RFdP82ODzN3r8lJ8pkF+QsEe7POCkW+eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e7NUZewVJIAf+tCUKguZom7ntnjjsc7ts1r4B9nmCul1knSsElXqSv3YqzJwqutC0qaswx9c0Z1Gzq2Jr5AjiVQ+YiUZk9tYNf6AAiTl/rMvYeC7iiNtgzJ8ZVyfkahmJHfGh7BpHpzkw5pd95OD8g8HzS7rYX9QuMK/uBeCoWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gVZraC9f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EAuvgq015137
	for <linux-wireless@vger.kernel.org>; Wed, 14 May 2025 14:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ubla14EFZ75kAo6reUTBKgpqY8L7jrsDmwk3M6LY9Qw=; b=gVZraC9fkrMNsYwv
	XB+C+SrbMJm62vcw0DIIMWZVHZMWnSnYoSuM8mq9DhQDfm11vUdx8jRbh4glulOO
	NBO3WBFo95xiMruE+dWSApUZrfw3LUVsSgGOBBG8SmF+riuBv78PiftfBBQvD/d5
	uLTsj5nkRK2rHPW58Z4ZdtEMry2T9RPdPfEdpzWSrivJFcKXyF3RC40cq2uUPSeQ
	GAOnVfAtBzFmerJZCNaYMGU5GCOXqKk32mMJrpGMwJM9HKYT5vh6sc/cC5Zb9CGc
	oACUAlLdR0hN6aWEWvxq5cC9HPoUFvKs4f0UKZzeXMMaFw4aNiT+MkqTIZnSVe6V
	nzXBEQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcr2yyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 14 May 2025 14:54:12 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22c31b55ac6so88967285ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 14 May 2025 07:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747234451; x=1747839251;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ubla14EFZ75kAo6reUTBKgpqY8L7jrsDmwk3M6LY9Qw=;
        b=HlOFn4QySNlk27/yPrFLvGes+nuMDJe2LHagev4xhvjdx+8htnlXadSMn1AUsy5Dwh
         GXkMSaeNncgkT9qhq8U3lWDvWG8Fi/PD4SfceN/09gkZN4Aa0eM2lTBIslDyeTcSI2pH
         S/t58ilCdy7ptrXly1ppFCetvfSb0fNTCQkQP1SVfmSIYjj2NztvgNEHeckUulakVnsK
         F+tlhX+7UlwqScHQySGSXiK66QwZXF/xJi5n4GiCSpzddthYyCbPjwxzTYel4ySfUcPI
         OCa2gXebjNiSjTBASdpCH09eRA1A+PKWZ4qWHh7gco9pWuf8eny49BZ6WLhlxJ8g+9lc
         x/8Q==
X-Gm-Message-State: AOJu0YxBd9oZuwvxI9CcGPXUJNRZls8PycbBODt0x6U5mZ0DOz/cBA+d
	RBhpTlFa8av4iieWkIscajsrrAIFbzT8m6wzO9PTUZJHWhMLN9P/d4afhkmusr/vU9Oq6w64dRX
	AHgHzQWmorP0ue5AYhDSKvustEMqPFGe+DQVT7OllVYt3dWoRO8rFS4oX0qDFJ5dpYg==
X-Gm-Gg: ASbGncv45A99rSeOpJXEzs0HuKcl+Y6AjYqLzD5s5SZd7geyek76LbL9OUqvwsGfxNm
	ko2yngIjPtP8DFlDcpjGlx9mKLMVRd4DQiotvvZsLFn0Km1ZJUbKfpUqcqWobWytDiWxzP7+wyX
	v/JRR85HevuvylVD0oUYIgHBHar/BtNIXdoiavVCp8W/Kx7RbshWfidBqYVXX4mfFuJxxiq/6xQ
	HTyxQjBxp4DrCV2jWAgcB9/fkAURnvYIVW/51rram7AP6ohhflTsJX/DMIWR2lCoez5TNAF3RHQ
	0qwRFadvUm4Vn+9CmsvhQ9I5tSmDFKW2id5E6fBea7MaRzY3Nd80yxMbu2uWw2ZYgrI=
X-Received: by 2002:a17:903:249:b0:22f:b6cc:421e with SMTP id d9443c01a7336-231980e9ee0mr46371305ad.26.1747234451128;
        Wed, 14 May 2025 07:54:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf51n5xxel4Kkz+hXWn3/vNgrHbBHm9zcFw/64vGwwR6SqqOIfA2MvUphdORO3KOUUfVWlrg==
X-Received: by 2002:a17:903:249:b0:22f:b6cc:421e with SMTP id d9443c01a7336-231980e9ee0mr46370985ad.26.1747234450708;
        Wed, 14 May 2025 07:54:10 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7540c8csm101163475ad.5.2025.05.14.07.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 07:54:10 -0700 (PDT)
Message-ID: <5d61a6b8-e259-4683-94a8-911dcf2b9e81@oss.qualcomm.com>
Date: Wed, 14 May 2025 07:54:09 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V13 6/9] wifi: ath12k: add support for setting fixed HE
 rate/GI/LTF
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Muna Sinada <quic_msinada@quicinc.com>
References: <20250418174818.3336510-1-quic_pradeepc@quicinc.com>
 <20250418174818.3336510-7-quic_pradeepc@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250418174818.3336510-7-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 80R1Q8valhy9-LaB8Juje7c_XfO_84aH
X-Authority-Analysis: v=2.4 cv=Auju3P9P c=1 sm=1 tr=0 ts=6824ae94 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=l8VUrehaPOb5hxZ9740A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 80R1Q8valhy9-LaB8Juje7c_XfO_84aH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDEzMyBTYWx0ZWRfX6FOdnFCOVVlb
 Amc7h/zEOEJEwlBF+Uy8+6IaCB6xSsPJOxkV1+skrcIRVH0X7SzYiMC8rMg8LLrMCHnVrybXkYh
 pHK9/9EdMgNXKK/vwzEgkO2ufQ1MAgry5zNktRbBwb8dgkXXa42D0fIiBGUrg622aeV8R5C/fd8
 3VcMX7jNICtCHPFs9S+N6QzDUdq4spthz+7WJK7VGdEjBibMHXAD2AjlM88aO88XpigdVZTHYgt
 7Kvhc37/RtMrtMeIiIqiclR2YYxTXT6xkHInDMvO4Cb5Zt9R4XMSrN7zeLB+G0pxNp8c5/P0U6D
 JiYTeMSrqp2Ml0ayOvR+HOb8XEioCT3Ks7SLOGXJ2uYvXmmuos3I+rGr2Lbtkb6CLBxDhQhJcJn
 HPsItC4mIoiDjXe2SOcwjxvhLktzi2ungsFbzhNw8B9kEnBvwvdCVmBd3jviwHHI82Ha2+mX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 adultscore=0 priorityscore=1501 mlxlogscore=935
 phishscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140133

On 4/18/2025 10:48 AM, Pradeep Kumar Chitrapu wrote:
> Add support to set fixed HE rate/GI/LTF values using nl80211.
> Reuse parts of the existing code path already used for HT/VHT
> to implement the new helpers symmetrically, similar to how
> HT/VHT is handled.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Co-developed-by: Muna Sinada <quic_msinada@quicinc.com>
> Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>

Internal testing revealed interop issues with this patch, so this series is
being dropped for now.


