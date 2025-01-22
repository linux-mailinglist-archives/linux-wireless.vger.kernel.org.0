Return-Path: <linux-wireless+bounces-17827-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE260A18F86
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 11:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15F83A5788
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 10:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB7B1ADFFE;
	Wed, 22 Jan 2025 10:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RkbjwSwA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B36145FE0
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 10:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737541001; cv=none; b=sWPuPgY+v9J7prWaO3o5b0lE1gwxf4gXyz96MPh8fMBiWvt/3KXK8YPVHTBKSMhj5Gs7ucx5JEn9pQB5YOc67ozwpOQog2CaW1/NYTQK21UAjQSPbnYrTJmS7TgHZm4/BBfUZFRiaVusaaZf+QBWRIICiFmGv+ag4VSxY5ubIUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737541001; c=relaxed/simple;
	bh=r9E1VWo9oDtSTuBq9GJmrt1UcR567/YkYXUaO90Mxjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IFwE4eWMosqnLEH/VMiuZVhTJnYOvuI/mrm+vomnQgGnvlkXROaVXmeHU49skpys5ZmbMCg3YNr7WMLIdlBWxHj5CRnzBuwr63rvfymQnaeQ7r+4boLvFRkcTaES8yGn0Wxd0j2vX5zZGo4oMfV8AbkG4MWLjOyFkrTPqmmjx24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RkbjwSwA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50M45KhO027024
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 10:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q12StN78GmGHMNrsW44lEi88E9jEvFJprY3+7loId4Y=; b=RkbjwSwA4glAoTw3
	d31CqakrZjRu2BqHZLquLkL7OnjEugsTNMQGCfyRPdRsycraasS02XYuiHPy/HE8
	wfyGHqvndTSDEV0Z3RplY5nX6+tXSymUSh41zH65HAADkO+4qYCkil980GkhPb11
	iuN9YlSJ2tk0EtSepbwMm4Cf76J08gS8txq99Rmew+Lp4m9AcjGb0ou7UGVgjQZ5
	qZEDIL4yCDIp3492WtMfdGlusTyClPrmoEiwTg8qMT2G4rl/d3aTQCc5bIxPpUVo
	Ni11v0o7Av4LbzlBKCiihFhWfu1BpXfy15SHFKhuTUQnP2GIRBA8N4XhYjbYvLQf
	Vpd41g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44asbf8tck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 10:16:38 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-21648ddd461so138444145ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 02:16:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737540997; x=1738145797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q12StN78GmGHMNrsW44lEi88E9jEvFJprY3+7loId4Y=;
        b=AD4wjbUmvdDweyLZkyXxckwnsDVGSW0ASgdP8qQYEXLxJqsdTb1IOd8GJM/NWQbUhY
         ilASB+OU0FZO4gZYfcMS3Mfeh2jCKLj5A6VWyOsy5BWKCzqQpokEw73Vv3Z/sG3mNi/p
         GCyoAIeUSaLPQ2WM1CmpumdmqKqavroNi0HGpwuYkMlFpAWUOem3FmwvPOCqE+XvuBjX
         udLTpscfRfW0PPs2npnPLn4fDoYYO5ROydHUS5CRjJsKCmK0b8/SUCJzAftNOdSbqTCu
         +8o4Okm3G8Fx2IkTCy4E6ady2dlN6ccncLbnylVJgeMQVPpTlwu90dtH8v051CrOz5xh
         zEig==
X-Gm-Message-State: AOJu0Yxo4DP9kuclVz7YIWOqEPzRjUGgo2+hDsxNrYUWGHJelMQf3Nvv
	kjY4uYXDZ5lwnhmLkMZJOuw6PRmoeZNX9dDa8Oj06kVQ60zgGKzReLCVP8LKscUwOs/5JAjLwmJ
	Bs2jObLsIn+2cVJEKvh6sVx63N7QvlzPKrNom+njdZldBVjvYVJv07kG8RK9k37hqvFE+wfRY6Q
	==
X-Gm-Gg: ASbGncuySR8SPMn9Xp/qlFQ01mabym44H1FrDFzYlqN+iciczn5C3sShC1J0DKsX5xg
	WO03uDfd4hJVcyBZQdw1w/dfH++VCLs1XVG5I6kw3ruV10hy4Ud/NQxCc4ZwYDrvJKQWe2Nc5zW
	Q6XarAUjQgKIsBu0zIk48CObTpMcF+ycHnZ2c0saqVQ/xEsjZCPZoMvhBaCtgKtPhySB9gtc6DO
	5X0x+OyleOj+pldN1lxeqRorULm9zB/gbZxrxVQyN0CoUBODGM0jPhG5WtEc2B3nwWw2Fl+hxE2
	sysxb6BeFIZ1Vkd6XZSEn13iSZIV
X-Received: by 2002:a05:6a21:6d88:b0:1e3:e77d:1460 with SMTP id adf61e73a8af0-1eb214e00eamr34568958637.22.1737540997246;
        Wed, 22 Jan 2025 02:16:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdXQyQDJOd4KIf4kCfGbhyeyHVO+S5SYOSqTwbt6zDSl82yTK4HaLifpRPxu//43HDND7kcw==
X-Received: by 2002:a05:6a21:6d88:b0:1e3:e77d:1460 with SMTP id adf61e73a8af0-1eb214e00eamr34568921637.22.1737540996864;
        Wed, 22 Jan 2025 02:16:36 -0800 (PST)
Received: from [10.152.202.18] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bcaa3a5a4sm8897163a12.16.2025.01.22.02.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 02:16:36 -0800 (PST)
Message-ID: <93913627-35fe-4ca7-9af6-75bc8c4ad9a7@oss.qualcomm.com>
Date: Wed, 22 Jan 2025 15:46:33 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/4] wifi: ath12k: add 11d scan offload support
To: Kang Yang <quic_kangyang@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250121104543.2053-1-quic_kangyang@quicinc.com>
 <20250121104543.2053-3-quic_kangyang@quicinc.com>
Content-Language: en-US
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <20250121104543.2053-3-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: sha-gA3OXysTx0FsRrYrZXs1DIdvireL
X-Proofpoint-GUID: sha-gA3OXysTx0FsRrYrZXs1DIdvireL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_04,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 clxscore=1011 adultscore=0 malwarescore=0 mlxlogscore=981
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220075

On 1/21/25 16:15, Kang Yang wrote:
> From: Wen Gong<quic_wgong@quicinc.com>
> 
> The flow of 11d scan is:
> 1. trigger 11d scan.
> 2. receive, parse, and update 11d scan result.
> 3. stop 11d scan.
> 
> So need to add handler for WMI_11D_SCAN_START_CMDID and
> WMI_11D_SCAN_STOP_CMDID to trigger/stop 11d scan. Add process of WMI
> event WMI_11D_NEW_COUNTRY_EVENTID for 11d scan result.
> 
> There are two points that need to be noted:
> 1. The 11d scan priority is 'MEDIUM' in firmware, the hw scan priority
> is 'LOW'. When 11d scan is running, hw scan will be canceled.
> To avoid this, change the hw scan priority to 'MEDIUM' when 11d scan
> is running.
> 
> 2. Need to add wait_for_completion_timeout() for scan.complete in
> ath12k_reg_update_chan_list() because 11d scan will cost more than 5
> seconds. Due to another existing wait in ath12k_scan_stop(), there will
> be two scan.complete in different threads. Therefore use complete_all()
> instead of complete() for scan.complete. complete_all() can work well
> when it is only one thread wait for scan.complete.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Wen Gong<quic_wgong@quicinc.com>
> Signed-off-by: Kang Yang<quic_kangyang@quicinc.com>

Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

-- 
Aditya


