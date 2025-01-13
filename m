Return-Path: <linux-wireless+bounces-17441-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E8EA0C14A
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 20:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B98A87A205E
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 19:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B011C5F28;
	Mon, 13 Jan 2025 19:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y7Bz+49i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71E81C5F1B
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796200; cv=none; b=IDox7SLBD2nBR3QQGVIjLCNm3njVIAZiLWwQju0vbuyayIbeZDm8Rx/gJO7IPtsR3G9kveFyR3ruiafWSH81iv+z2vz7vzVLqU/MEWv94rIY3xXU4nPgQ/296cfjPtVca+g62AIgya3kcisGeeof7RjK7b+V6VPjjKfyLvb/6tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796200; c=relaxed/simple;
	bh=ioCmS8njMkyX0e58/rs7GvdQSegjZRe7GCoZzgunyY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HGvi6bY6mDx2uGKPl7Hkp/qrapXVL6icjI7oDhs+E7srMObsUaLAUXdk7HRhRmdI9ujlu0SPzEETyDCrZS4HlQJA6YvH51kA+Zt1fbwklkCOkhtOTVCmow71Z7CN/DK6s1NrAKbBZmMq1LYjK01dpsMH6y8JJaoTD8LfZ3CaL+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y7Bz+49i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DE5iQY030297
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MFV3aWNNS+t43F5uwTgcNEgS2obH2Bxb2qDmFQO3CYE=; b=Y7Bz+49ii3WJMBW9
	qgjk1kc/D+3bkwkSYJl482XuzAHPOauUZv8rKjUuvcC199I0aUQkmJ+vnJceobDU
	rh6dCM/1//bXoME0cOSjhRtcqRIhRZ96OSmdrv/IqueT9FaqPEsNNLpvdSGvz88u
	l73x5MrQVqkJL34mbkv3oBIBYCs2sL3eYn1sIKBXKvFviKozzyajPatmnuTJGclP
	Xnx/RX3JYy/IZm8TsuYiGdLQE8Vh2nTRcLRyBzJJFVTnAElRwpomXEervL3aeEvi
	1Lw/LbuQ/ETV8pZxuS3l0P44hLrY8sBp/Z/v7ew/kTeX4yekE+daPIwIWNuzq13K
	Ux/xqA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44549w8s9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:23:17 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21661949f23so136423415ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 11:23:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736796196; x=1737400996;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MFV3aWNNS+t43F5uwTgcNEgS2obH2Bxb2qDmFQO3CYE=;
        b=tJRhalK7FLXPfeJvMPDYbDR06gqbwGXjZN8UFLEQTs5DFXf2dV8htbQh32ip3BmX9D
         IZOb1EXi/7uNU/RfqjaUSTGRWgmogvQPi8dPRof/ioyeykxUPx6p3c7Cn0zvKiLKUAqd
         ne1Fl0++ky3xxjD6XqSzkcmKSGs3nfAcGuMjAwVjPJ+PgNpSPSI+MCpAWsulIqdGbRdH
         ZjNDbUbhPPhm25leATjVia1byHu4841ZgwdERA4kyyA0NuQ1XtrxLUjqM1bPn2pgoT0A
         gvw04pmzumfSLn2I63AGKEw9ERlzz7s9t9fiCCwtuoLx/wWDXQNSBJXDv8a6XiYIn5J0
         xQQw==
X-Forwarded-Encrypted: i=1; AJvYcCU363pVuQF9Oqolt+c+XUlJHkV+HJFz1LDWipGK9ZRgnHiupyYgUNI/i0Jrv7kog50XboGDLEGXCrccSoW+rQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdUbDv+S1+Ip8sRjJ1HJQ+q+XkWb1+VXE/GEK7dgFcpg5S7JIJ
	sCd2NIjX6bwKYtOYLxBPmfRXqxQGZj77UwU9aV7oYn+3nJMkcmqWlQnd2/wRfVhI32r+B6qVgLB
	6Ux/Ez3dyjMpri2xrDcRPYt6EEH/EtRy5Inbt52Lpzpkj4aL6CofBHobl+3aXWjMJdw==
X-Gm-Gg: ASbGnctD2IZvkrefVELJOhp9gsGfVKq+pie6logjS/q3b896GA0esonVhs314Jst9hG
	ie1QdYBn19YUP50j5NbCPgulfpAW/23lsaRlZ2QCgWAqOBtGz0/Y9d1/hNG1aJdz7zam9Y/FbRL
	ieVZn/FBVpggibnWzT7FVgi5G81U5oFnhZ9AMz7NDvI0oPRFlfrwEREvSgqQH7m2owOvXvGat45
	rsHgCyZq6jd1KV2JdwgIhVG0XUyFGkEEf+gSP5AF47pgFIIW7ktCjxmCk+O6MZ34/iPkQ5CqL4e
	GL4q44v4qJ/xcePenDNcNOFALyqGf65jO+QQLDFLbhnSCIPRoA==
X-Received: by 2002:a17:902:f54d:b0:216:5af7:5a8e with SMTP id d9443c01a7336-21a83f65878mr319923065ad.26.1736796196387;
        Mon, 13 Jan 2025 11:23:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+hkVFHMduF9zujMICY19YD28FULovU7wGDvUztcC3lTrH9ftOX4fFFpXyDrtI6NVzk4ROMg==
X-Received: by 2002:a17:902:f54d:b0:216:5af7:5a8e with SMTP id d9443c01a7336-21a83f65878mr319922775ad.26.1736796196028;
        Mon, 13 Jan 2025 11:23:16 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f23499csm56196645ad.193.2025.01.13.11.23.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 11:23:15 -0800 (PST)
Message-ID: <1f4d5894-c04f-476e-83f6-71e3c5aff231@oss.qualcomm.com>
Date: Mon, 13 Jan 2025 11:23:14 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] wifi: ath12k: fix ATH12K_FLAG_REGISTERED flag
 handling
To: Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Kalle Valo
 <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Harshitha Prem <quic_hprem@quicinc.com>
Cc: Kalle Valo <quic_kvalo@quicinc.com>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250109-fix_reboot_issues_with_hw_grouping-v1-0-fb39ec03451e@quicinc.com>
 <20250109-fix_reboot_issues_with_hw_grouping-v1-7-fb39ec03451e@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250109-fix_reboot_issues_with_hw_grouping-v1-7-fb39ec03451e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: mEh3b7MPAfCISQRwJap4rMM0SGYkRdOS
X-Proofpoint-GUID: mEh3b7MPAfCISQRwJap4rMM0SGYkRdOS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501130155

On 1/8/2025 8:25 PM, Aditya Kumar Singh wrote:
> Commit a5686ae820fa ("wifi: ath12k: move ATH12K_FLAG_REGISTERED handling to
> ath12k_mac_register()") relocated the setting of the ATH12K_FLAG_REGISTERED
> flag to the ath12k_mac_register() function. However, this function only
> accesses the first device (ab) via ag->ab[0], resulting in the flag being
> set only for the first device in the group. Similarly,
> ath12k_mac_unregister() only unsets the flag for the first device. The flag
> should actually be set for all devices in the group to avoid issues during
> recovery.
> 
> Hence, move setting and clearing of this flag in the function
> ath12k_core_hw_group_start() and ath12k_core_hw_group_stop() respectively.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Fixes: a5686ae820fa ("wifi: ath12k: move ATH12K_FLAG_REGISTERED handling to ath12k_mac_register()")
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>



