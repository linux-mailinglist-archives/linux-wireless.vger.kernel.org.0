Return-Path: <linux-wireless+bounces-21309-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E131A81E48
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 09:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8801BA4163
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 07:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C69F259CB8;
	Wed,  9 Apr 2025 07:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ghlbDTdq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAF71A7262
	for <linux-wireless@vger.kernel.org>; Wed,  9 Apr 2025 07:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744183719; cv=none; b=aKDeI2bIgXVWrMlyD0ZhglnIS0opWJwn1mpbaqhFA7XOF7oxftVkAeMTvBARBlMuonwzLXT+UsR6JBC+nG8JRtwjrFES/KePBLCcrZTr51fKMXPu9yq9G264Wq2QkzUob1v1UH2NIwUIHFGAy25eOYUNtMS0CUgSRD0FHEnnyaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744183719; c=relaxed/simple;
	bh=2p+qs1z+7tfEGBPMZY5hUx885u9ghcxKw72eoqj7xzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZvNgDNcvKTwg84rRYSgakhnTj2F2JLy87ZBb5lXHoIqVcdH+xyOazfyBl2GBcglKiF5zR08EE1VvCFYZr2g1k8eNQGHsr/PArKUTJqFG9LlKAc05/h+dd6pHJqeGLR5W6XTCSxCWI80TNDs99OuscmdI/6NPZVb3DulwVnlBomY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ghlbDTdq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538JYuSs028177
	for <linux-wireless@vger.kernel.org>; Wed, 9 Apr 2025 07:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SeUraEBMOIJ36Sin0Xx9xrG4RCGl3l2XSiFR39cgfk0=; b=ghlbDTdqpDfTvwSi
	coB5f6Ks9KF7ci+P7AlgN7CRGtQE63tAsU1HFEfw5v2hu57GnCt4B+CDF/Ib6obK
	KZSrB6Mz+7xv5hLbDyDmqhbYMM/VvzCcz7iiw7Lec3M1e1CTuncEdJuIhaIScC5x
	1lhlofGn6hY4cwJ95BvbUuMTegDfIH8rosmNM3+/mQOI96ZFcofunuuh4TYQX9Mv
	KLTsYvPIcuPoNAJlHSAqp74JzzJhSELLCzuCGNltTJYKJ3mRf/Wwi22S1kLEgN2V
	hGn8HpzaxGq4usjXtp+txf5KqJgYfgwUsFlBbMyZXQfqwh5d+FAP8eyXf3sJ2jW9
	5zCdbQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twcrjhg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 09 Apr 2025 07:28:36 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7377139d8b1so4729276b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 09 Apr 2025 00:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744183715; x=1744788515;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SeUraEBMOIJ36Sin0Xx9xrG4RCGl3l2XSiFR39cgfk0=;
        b=e3BO22iFr/XnCESyGoKVrfxLy9MI7/l7p8P753nlO5RDWQLPYNUr4m0mv8Lix2CJrY
         E7x2xUzpABaUeXhq1dQEZMcNDIMMM05Wig7ldPu5kLYuhETT/DpVOhf1/P/dyn5MdbNf
         g8xZljUuoFilnb9iuPDAuyVJRngk5COwR6dwUXsR4J3xkHydmgqJ5UR2hQBlOIKYm6qn
         /8nYHm0Q6ZdiLwzfPE4o7bamyyuH2JcYMqHiH9cjWd1cxnR6ReDhuPP33SP3Ewmzascq
         tsOlaVUeGknhCoDJRAHgj5mBTpotnFkm2kGeFwrkb7SNkY5b58y8ZUaCyIUmmF13qVk1
         gOtA==
X-Gm-Message-State: AOJu0YyfKgIXlgm1LGCwYvzQAx05UMfP0YHg2+7prK/rY7O1Btp3Hvdc
	s3Y0vIpqPcXO3/imIC2uBSxCPdZ6LabsKlnOCGIBkWELe2NuxtSiTyGf93fu97b1yJHzP3suYiu
	MkoknqJi2CKwBg+T4xWjiagMyKVj14del/v+Odf01rYcc9wm+8MlCq97Q9msdSzoQMQ==
X-Gm-Gg: ASbGnctIIEG1a1ppEhNAGfp91LWOl2chTkWi7lHhHu8nx/QJE0LR9JhCynJeKb/oApR
	lSCo2lktmYhY3a0NJq+vIhITySv9oBOBifjyYWD4QWat/PP1tr9bnbQmNsxceh4Al8dXgsm7u1/
	NBoOQ//ca0q+CZH6v5dkcdmkStKgOibgwWRVYK2WR1CM7Ctf1InG7opQLSusRAkp8EAolq83+WC
	Ht0KXqFa3NdRhsS3CsyyGGjUfBBxC11rUUmpF8CFEpg9S6IkoqEgjUdoG3CmBpAOqkWIP7fKqBq
	uveE+JZ2WbDI4gTe3XbfZyXfIdjxhVwqyYasYF/WGUvcVQ0ZKQt92w==
X-Received: by 2002:a05:6a00:2443:b0:728:e2cc:bfd6 with SMTP id d2e1a72fcca58-73bae527699mr3093090b3a.18.1744183715180;
        Wed, 09 Apr 2025 00:28:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESg2B5Bgf18C053iwwb0g5HFnwB/pafIw2r0sRvy2X7sP818cIRamnoEWrGeL5ap2y7LWEiA==
X-Received: by 2002:a05:6a00:2443:b0:728:e2cc:bfd6 with SMTP id d2e1a72fcca58-73bae527699mr3093063b3a.18.1744183714791;
        Wed, 09 Apr 2025 00:28:34 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1e4f797sm613435b3a.137.2025.04.09.00.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 00:28:34 -0700 (PDT)
Message-ID: <25fc01c0-f5cb-ff31-7b03-af51dc2a27c4@oss.qualcomm.com>
Date: Wed, 9 Apr 2025 12:58:31 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next 2/2] wifi: ath12k: Introduce check against zero
 for ahvif->key_cipher in ath12k_mac_op_tx()
Content-Language: en-US
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250403082207.3323938-1-aaradhana.sahu@oss.qualcomm.com>
 <20250403082207.3323938-3-aaradhana.sahu@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250403082207.3323938-3-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: YV-wgpGR2YDVEGV9ckrkJJPhbQMl-8Dg
X-Authority-Analysis: v=2.4 cv=QuVe3Uyd c=1 sm=1 tr=0 ts=67f621a4 cx=c_pps a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=wZnWngPLgcQuxuQgH9MA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: YV-wgpGR2YDVEGV9ckrkJJPhbQMl-8Dg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 mlxlogscore=766 bulkscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090033



On 4/3/2025 1:52 PM, Aaradhana Sahu wrote:
> Currently, ahvif->key_cipher is compared with the enum value
> (WMI_CIPHER_NONE) inside ath12k_mac_op_tx(). However, ahvif->key_cipher is
> set using the macro value WLAN_CIPHER_SUITE_XXXX which seems inconsistent.
> 
> To improve code consistency and readability, introduce check against zero
> for ahvif->key_cipher instead of comparing it with the enum
> (WMI_CIPHER_NONE).
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00209-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

