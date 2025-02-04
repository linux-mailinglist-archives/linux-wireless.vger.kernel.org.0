Return-Path: <linux-wireless+bounces-18372-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F406A26B1F
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 05:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34084188783A
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 04:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C9917C219;
	Tue,  4 Feb 2025 04:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MxjKLJ/r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D13114A095
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 04:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738644035; cv=none; b=noADbWh1a3/5mamFNOkn5i2lCR6u2XzU7dzsKxWIdBy7YPDW6YfmPWAyEST1S1Yr7L8d0TDLlkxVONU1VSgF4VQaDWoePglFxMDZr1fMKZNP5Ifb5IUlrW5bArKxjZoWPpq2IvSSC86NsPwH9cqYxQrCKLKn93JXhmKpgE4Lr6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738644035; c=relaxed/simple;
	bh=hk7HXyyZz5xf5qJH22r78sv5EaG3ryOiMur+Jpxcmso=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EgCg1yPxkIYUZD25ydo4pRNQKsRwn3KJRPLhaqzhxHwhCnqcnJs2xuLhRu09fCG2CeEpr8h3Ya8cDOXUvSBvx37wzs3SqYWhfRL370flZEqmJU8AQzu59gtqtwayVbL2ihZfH6O5wahn4XBfVnmqpTpyf+McNxL9i/hhz8+/lXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MxjKLJ/r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5141BdEM021166
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 04:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EyEigm+d9Uorqg90VZ3oWzmIVHvWdBi3sutRRozdTgw=; b=MxjKLJ/rI1V8AwV6
	cZ0eWVW64qKY+kL7/ttX4IV/wCT6Atnq/iedIg3KMvCU0mXSmv3zrBQo6qW9+i2Q
	/cS4mL1X5T/P93icMX/022lFx2cls8mVgGHMC45thg7mjICHnTpXX/z66c3cTEnE
	7x0TVPpjscWHH5rYKkmwpkx9O3JmFxCbQBqlLrH9B7TPRruIM1bKZAG4lZ12PqD1
	j0s2Cijk8i6ywzPtbbiZsDCb8XyWkT8A8zuWBBRsHqEdSBVWD8Jf6PROQnAQ8OFM
	NbBrXETsL0+SgN6qrcBv5o+CFwqBdRiWfCcvx4nlpZk2q5YLtV8l0tEeEMF6Y2Wf
	rk8Kew==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k911gbdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 04:40:32 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ee86953aeaso9497008a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 20:40:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738644031; x=1739248831;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EyEigm+d9Uorqg90VZ3oWzmIVHvWdBi3sutRRozdTgw=;
        b=dMI7iDHtW9GNDMyPTcC8WEpbmTuM1RfD4VRWEfkCujhKt+sAwDWkejVYovn5Cf8NnP
         vxvr2IxpbgWknkGOxQWaXcbs0nqFHUJeAVB+rpBww+aOwJPn3IKbI6vpQwTzvc6AaVVT
         k3evsSosLDZAh/yfD+NapnzNHvbMUrroMVQ4NIGVrGmzRQBNwKRIFy/LLWnxBbdiKoym
         GcpC7HSGUBD67n8r+VD4+vmBRFbG86UBjFusKRizNeM8VcnOHtBbiVE7+FMPPA8Z9+hs
         V7REBkPChOvcV6Rk8qJTsj6Ba7Rl8KBGctTUzvVat854SQOqePbLj/8u87GdZ4E9vURb
         MZfg==
X-Forwarded-Encrypted: i=1; AJvYcCWNmSNgauynwpT2v6W6tDSovJEFwrns6hYCUrrbFrL/SkwcTeETcOfjGDeWpywC3S1EY0Lq/uFESpIFcNMgIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq6b6SD+yUQ+kjxjEHe6cIJ+q0vvDWdf6b06PsblPUt5J51kkW
	QdzTjXe4c0iagaI08bpI5cz7QSdP4o/Rz/FnbFqgNCCM22oYuHnzcmkDKY1S4K2HpRKm5eTrg6U
	Vjx5lWhV3kyA1zDVteCMf3x8Q5kcihM4C42f0s/9jqxY0nc/qi4Ri0yl56QrXIbkLm3OVlttubw
	==
X-Gm-Gg: ASbGncsJNbDMf9QyP03c73T8wAEOwkWnmfUFTPIOLq+w9RneOZaWahU1xWJJdZLpx2g
	PsB9yy2FhqhMMj5ZkPvtCt8CPdMlgnoRXUYbh9Dr8j7+17gZIHgb0Er1EUGGdV8p7QuoEs7VIhC
	M+IeijGokcZXeo1TbEAjFPPjKLmjvFqqmOL7MdLnFyt6MBjWLQEgGephaQ9peO2PTG7iHQZQgfh
	wTVIPkFUESPGRWGcVCwD2F3z1hlWTYjEUHoQjzataRIbTzlRulR9TLMXu/k4ltfgbuZTZGmMc18
	7DnPBHgVSawYr8HaEikgX3c3SnqFfRr7JWM/XT4=
X-Received: by 2002:a05:6a00:2908:b0:726:64a5:5f67 with SMTP id d2e1a72fcca58-72fd0c03db4mr34477868b3a.12.1738644030841;
        Mon, 03 Feb 2025 20:40:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmjnxcTQy2/c6ZDU36visnorw1StO/iEunWwfk+QnXtFh2a47nGXWUIUstvIU2lC6Vh3r6Kw==
X-Received: by 2002:a05:6a00:2908:b0:726:64a5:5f67 with SMTP id d2e1a72fcca58-72fd0c03db4mr34477836b3a.12.1738644030406;
        Mon, 03 Feb 2025 20:40:30 -0800 (PST)
Received: from [10.152.202.18] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acebddbb1easm8951052a12.8.2025.02.03.20.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 20:40:30 -0800 (PST)
Message-ID: <ed23d3c1-7136-43b2-90ee-b46d43d27b2d@oss.qualcomm.com>
Date: Tue, 4 Feb 2025 10:10:26 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] wifi: ath11k: refactor transmitted arvif retrieval
To: Aloka Dixit <aloka.dixit@oss.qualcomm.com>, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
References: <20250203214448.1978156-1-aloka.dixit@oss.qualcomm.com>
 <20250203214448.1978156-2-aloka.dixit@oss.qualcomm.com>
Content-Language: en-US
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <20250203214448.1978156-2-aloka.dixit@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: CzVoRQtGpTysr8QosZdsJvqW2phJyqrX
X-Proofpoint-ORIG-GUID: CzVoRQtGpTysr8QosZdsJvqW2phJyqrX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_02,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=624
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040035

On 2/4/25 03:14, Aloka Dixit wrote:
> Create a new function ath11k_mac_get_tx_arvif() to retrieve 'arvif'
> for the transmitted interface of the MBSSID set. This will help
> modifying the same code path to reflect mac80211 data structure
> changes to support MLO. This also fixes an issue in
> ath11k_mac_update_vif_chan() where tx_arvif is not reset to NULL
> inside for loop during each iteration.
> 

Is this tested? Perhaps you forgot to add "Tested-on:" tag?

> Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
> ---



-- 
Aditya

