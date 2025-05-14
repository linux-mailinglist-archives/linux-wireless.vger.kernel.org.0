Return-Path: <linux-wireless+bounces-22943-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 534A6AB6EE5
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 17:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F7D23BA51B
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 15:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99141A23B0;
	Wed, 14 May 2025 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SnyjUgcM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7262188A3B
	for <linux-wireless@vger.kernel.org>; Wed, 14 May 2025 15:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747235068; cv=none; b=mT1tYqn1/L6Hp0JeG0njNPGDqQbOAkqNLBzhI6IN1ED3yFQhvIoymcSc0QVyfE8MdUVu0WLqaU2GoQ0oriw8uxV29Tn0mFqE6ewngi0pnZ/rpniy18Bz0p2np0ARUvXDu+xjcTb9REIbeacdM/8XQFbYm1cJHtI3ukk04VQqXjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747235068; c=relaxed/simple;
	bh=enAAgcAkRRPDtMbAlVwvjsUjqsabflmhwH1favUCliE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eAXX0t4nuPuargbiFeDgAYcqzY6b+GSXzH0z7JMOtSuPHP+/lPwkKTbTSsqGT0xKH52C4pyJT3w05ZE+MJompkl4fqGr9Hf8uSOg5AfcR02OeWboweBZ3oal81wYlhXzBqpPYar0ni/4CF4hkDMWXJj2f7WvzSkDebH6Ud3RXY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SnyjUgcM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EAuw80003073
	for <linux-wireless@vger.kernel.org>; Wed, 14 May 2025 15:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ABl9jKANhqzzr/vAZe4CDKc9veauV3B8kvEEP2dIxNw=; b=SnyjUgcMMaPiVgCD
	oFEjYkHpDqi8YGI0JNGoBU4cXUMO+e3cN0NJt0WsFLVFc50Kp4bkekl6dleX9Ojx
	VDwpsGFprlflJ7p8p6Wsd9/isRitdV0spJXIgrbgctRdvkeyyAf7cf8JV2QsmO87
	mHgHf1uqoc5DwreAneJ+fCEFHDr9Xt0I/tTUYznSklSOzznR+ZBBh0+/5+V3VR8p
	6Fs/llfQFyzQ1OOjDpK2V5y6K/JtVCqSKtA0KqAthspWC/PR7mmkeafOGBl0z6J0
	UMG8Gl8kYDaunRcAOUgrmnd2lINQZ+sHtRgwUsP/sAWlJEFkB4en82FWxPy6gufp
	Jjo2lw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcrb1y1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 14 May 2025 15:04:25 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22e540fa2d0so56097975ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 14 May 2025 08:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747235064; x=1747839864;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ABl9jKANhqzzr/vAZe4CDKc9veauV3B8kvEEP2dIxNw=;
        b=XUOoJi/+NsjHlbO8pNa/fITND6vizivWixStFU3aHlFhbgCmaVqo4XNd5Gq4xQUtuC
         aETMgyj8wWHnVullJpYjzC5dGG5QzRPXO+Efch9SXtsHrUtjdprTzUiexd7fLkyIjyd+
         VQnS5g0KJ84PBMJ4WP1hy2ZJPStrPNXuPIqLYkegqyYYWOWceMcF9cwsJTFYSCdhIbrt
         eNB+am3fyxjqFHosuWml/j58eMAQiYcYvibiAjhtSrNHRwuJ+kw2DvNla1ASj39OJcmb
         k8+D02dE9gRYji4H7qD71dsseHYMnGHY5VAofyDvfzeGw2dEJHr+/4gChc3yRKrxm16E
         SJKw==
X-Gm-Message-State: AOJu0YzWy9S8/6iGIxQ/Dj0swBqw8DbW4NLsa0bOpL9axzM8O0Lo4kO4
	NZ01Z8VuPU0IU6EXbtjElM4NtWrvjoJcdGAZUA3FyttLUp4hGjvRsAgvAWR/efWRMo2JbyBhAX5
	FzXd+vlak/SHUw5OcTDc3y7a8jfNc+mLiuf26Ebf17OboMuDwvwMVSM4raaN+4tnWEg==
X-Gm-Gg: ASbGncsAYEWxudlzcyF4L1XqSeL/qintU7FYwfATjv+0PBop5RCXrzAtdAfWKWIY6Bo
	1YeQXqyxlBQj51J+6SVbkUJzWowXg/DUn58ZGuVR2M8XdcPf/MbLOBUlMcqoeZ9vNhE2tD2XWnD
	BNopuOeMyPIiwmmc6M8sxFVbDhdmtdzS5huwHm+l6BEcKPAlCzY8vaJWH1xEloOkPyIR09X8/+7
	y42KK8EEo18rKJE8BR628ePtMVv19ENX6N2znY+2Uk7qcQwoNtjrB2i1XET422E5B18vyM23V9b
	wjURTcbjoVVbXDKdKsfhsjevhEJes3Iv3EIsQtRLy4mLp1I9x/4I2FX5idjSFNvWxQM=
X-Received: by 2002:a17:903:1b06:b0:22f:a4aa:b82b with SMTP id d9443c01a7336-2319813b0f2mr46446905ad.21.1747235063606;
        Wed, 14 May 2025 08:04:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjQ7t9o70lrzuaqlLt1wRe0tTalCwo5HCmLlKoR6bfnHAzYaJQ9Ag3++6SUvGsVhD0BfQ3VQ==
X-Received: by 2002:a17:903:1b06:b0:22f:a4aa:b82b with SMTP id d9443c01a7336-2319813b0f2mr46446475ad.21.1747235063117;
        Wed, 14 May 2025 08:04:23 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc829dbb7sm101127735ad.211.2025.05.14.08.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 08:04:22 -0700 (PDT)
Message-ID: <84238fd9-8270-487a-8709-c5d492e81cef@oss.qualcomm.com>
Date: Wed, 14 May 2025 08:04:20 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL linux-firmware] ath11k and ath12k firmware 20250424
To: Mario Limonciello <superm1@kernel.org>, linux-firmware@kernel.org
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org,
        "Pananchikkal, Renjith" <Renjith.Pananchikkal@amd.com>,
        Christian Heusel <christian@heusel.eu>
References: <96b43d18-72e1-44a8-bf06-6a22fd012b07@oss.qualcomm.com>
 <62cba955-0f4a-4b25-8ec9-065ccfa9e26e@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <62cba955-0f4a-4b25-8ec9-065ccfa9e26e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 5DryRn4fgzdhCMrN8XeXinL27Xos_Mld
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDEzNCBTYWx0ZWRfX6En0s42hcjAc
 cdOtSCzARKzssYGGvt+XqcDP9rwnvJrvD8SqLvsqUxwtWVPgY7FVdy8PV2eqz0dnRpKp3IW6V8W
 GlzbsYwIWHC6DtRDmuAwsy9TP4pcl4RPEJS0yI2Fz1LZHbtUW4RpcKDMGoYPGEQNVfXvrvyCUE7
 CpKXOzqkSFnPtvYlNdk/ltoEq1AohcpdsmQldqpFuUOwQc8xsaxr6fppzriSoF/nVtSzW4d+bFV
 dFQBh8AtwRs6Z//Wy3fzsLvgM84J5mdo1D2bLmpoEJpegmTqHSpAXoaTVrWwFblZQ7A6X7+yhiS
 kkFr2Jf9Ho26nOCq5sOrX8ye+fwmRt8nlWyMK53bmtEg4ictzZjb/gYUEJRIoEf6Debpo5pIoLV
 lVXOFr2qxhyrq4SrlWHp9mnxrJu9LoTZGu87M+2aB5TQO+0+B5cgdU29cYdcyg2C6CxM5Ad4
X-Authority-Analysis: v=2.4 cv=K7UiHzWI c=1 sm=1 tr=0 ts=6824b0f9 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=mehdgkVfAAAA:8 a=KSb9T-wMAAAA:8
 a=PjuYqXk4AAAA:8 a=VwQbUJbxAAAA:8 a=y1C2Jo8pdxxprBwrj4UA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=J1pP9gvGZaT0y92QayzM:22 a=KF4VuIdXkMyp4E_ug72i:22
X-Proofpoint-GUID: 5DryRn4fgzdhCMrN8XeXinL27Xos_Mld
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140134

On 5/14/2025 7:33 AM, Mario Limonciello wrote:
> On 4/24/2025 3:38 PM, Jeff Johnson wrote:
>> Hi,
>> Here's a new pull request for ath11k and ath12k.
>>
>> For ath11k, update the firmware for IPQ5018 and update the board file
>> for WCN6855. For ath12k, update the firmware for WCN7850 and update
>> the board file for QCN9274.
>>
>> Please let me know if there are any problems.
>>
>> /jeff
>>
>> The following changes since commit 490c0af1d6b9ffca0523edcfad27ba483b9d6da3:
>>
>>    Merge branch 'robot/pr-0-1745490027' into 'main' (2025-04-24 13:46:05 +0000)
>>
>> are available in the Git repository at:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git ath-20250424
>>
>> for you to fetch changes up to ce13d29c3933f77674cf45855668485c48d3eba0:
>>
>>    ath11k: WCN6855 hw2.0: update board-2.bin (2025-04-24 13:04:20 -0700)
>>
>> ----------------------------------------------------------------
>> Jeff Johnson (4):
>>        ath12k: QCN9274 hw2.0: update board-2.bin
>>        ath12k: WCN7850 hw2.0: update to WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>        ath11k: IPQ5018 hw1.0: update to WLAN.HK.2.6.0.1-01300-QCAHKSWPL_SILICONZ-1
>>        ath11k: WCN6855 hw2.0: update board-2.bin
>>
>>   WHENCE                           |    4 +-
>>   ath11k/IPQ5018/hw1.0/Notice.txt  | 3918 +++-----------------------------------
>>   ath11k/IPQ5018/hw1.0/q6_fw.b00   |  Bin 532 -> 532 bytes
>>   ath11k/IPQ5018/hw1.0/q6_fw.b01   |  Bin 520 -> 520 bytes
>>   ath11k/IPQ5018/hw1.0/q6_fw.b04   |  Bin 86788 -> 86788 bytes
>>   ath11k/IPQ5018/hw1.0/q6_fw.b08   |  Bin 4096 -> 4096 bytes
>>   ath11k/IPQ5018/hw1.0/q6_fw.b09   |  Bin 2334720 -> 2334720 bytes
>>   ath11k/IPQ5018/hw1.0/q6_fw.b10   |  Bin 269220 -> 269252 bytes
>>   ath11k/IPQ5018/hw1.0/q6_fw.b11   |  Bin 99456 -> 99456 bytes
>>   ath11k/IPQ5018/hw1.0/q6_fw.b13   |  Bin 7072 -> 7080 bytes
>>   ath11k/IPQ5018/hw1.0/q6_fw.mdt   |  Bin 1052 -> 1052 bytes
>>   ath11k/WCN6855/hw2.0/board-2.bin |  Bin 6429240 -> 6429240 bytes
>>   ath12k/QCN9274/hw2.0/board-2.bin |  Bin 1308544 -> 2626240 bytes
>>   ath12k/WCN7850/hw2.0/amss.bin    |  Bin 6000704 -> 6082624 bytes
>>   ath12k/WCN7850/hw2.0/m3.bin      |  Bin 299660 -> 299660 bytes
>>   15 files changed, 315 insertions(+), 3607 deletions(-)
>>
> 
> FWIW - this appears to have broken Wifi for a bunch of people.
> 
> https://discuss.cachyos.org/t/wifi-interface-fails-to-initialize-after-linux-firmware-upgrade-qualcomm-wcn7850-ath12k/8765
> 
> https://bugzilla.opensuse.org/show_bug.cgi?id=1241986
> 
> https://www.reddit.com/r/archlinux/comments/1kja6f9/ath12k_regression_on_latest_linuxfirmware_upgrade/


yes, the underlying issue has been found and a new firmware will be available
soon. (internal POCs BCC'ed)

/jeff

