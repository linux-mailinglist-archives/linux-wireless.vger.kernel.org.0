Return-Path: <linux-wireless+bounces-10322-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924FA93466D
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 04:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5CB91C2119C
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 02:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4551C36;
	Thu, 18 Jul 2024 02:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HM5NxGDq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A528179A3;
	Thu, 18 Jul 2024 02:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721269906; cv=none; b=oCzOSDzbIj82ua4+zI2s/vO4odDWgE9hvAnGTFJLf8T81scjainR4Dd8nSe9sbMIMGn9DZ+Nm93OrivWS8tkZtodVnXpKbfwGVVjtWg/DbBZv1h0aZBbGhmUCw6CvXvXc9TZsvGGT6ogWVsOV/S1tcY6FIV2zi1Mzvv3/hw+V0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721269906; c=relaxed/simple;
	bh=Nm7tcUhUG222UDzIeW/9eBk3MmFth/BvekdXEY2JLCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=S4lWNCxCn5M4oci3TUn3F6XqvVWrHhHh/lrVP79MFQQF1IoNqbT/Seum8ajei5ryCILyw5ja5wr9hSz7CBHtKl4pwVYMckMAxnIuhq1VlwbV8z4W+EHqMzPxWrM6YkxKv0I8AAbuVhERAccc5D7p0SpvnUiuynZj7o9Ysa5qkgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HM5NxGDq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HE0n6X012817;
	Thu, 18 Jul 2024 02:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QcGt4OP+vMY74J4R/df11eXm9zQJNxe+TwRmWr15BnY=; b=HM5NxGDqhYyk6JcJ
	+zlPoXwGnBw7n55Cn6f+Ra5wZ6iSc4iz2bAFC3xY3RxkYRXT6I3u5+6lgqpmG+nI
	LWyhh1jzr1JEkRZibM1cjlp9LvZCMmwCUrKRI1uCqdydHAPcIPmuvAa1TYo9vWST
	eyPqcaF1e3J59i4axPt0N/jBnIk2GVfeWXU2gTQcmlgsplT5/g9fIGq08jqbYDTK
	7onZqjy3+zeu0Pyaf+R+upBwA315ZlH6ZuSqzt6LgTk4vcdcNSM3NTDv8Im+dm5l
	5yOQseersQpppy2e6zsWo6Oh0wSlHKsYFWkAxsVnKJh9vis5lmK15+jsAOojcQ4/
	hOigDA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfwc40w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 02:31:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46I2Vb00014408
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 02:31:37 GMT
Received: from [10.48.247.102] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Jul
 2024 19:31:37 -0700
Message-ID: <21ec0cb9-e70a-4b73-832c-36621176137a@quicinc.com>
Date: Wed, 17 Jul 2024 19:31:36 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] wifi: ath12k: Add Support for enabling or disabling
 specific features based on ACPI bitflag
Content-Language: en-US
To: Lingbo Kong <quic_lingbok@quicinc.com>, kernel test robot <lkp@intel.com>,
        <ath12k@lists.infradead.org>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-wireless@vger.kernel.org>
References: <20240717111023.78798-3-quic_lingbok@quicinc.com>
 <202407180403.SFqsPj0v-lkp@intel.com>
 <16d70523-dd1c-421c-98bb-8bd6ff319a6f@quicinc.com>
 <cc711aca-acaa-401b-b8ea-40252b1f9207@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <cc711aca-acaa-401b-b8ea-40252b1f9207@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qXsVHNnXGjbQjVmDaEuJw_wtwFQx7y1r
X-Proofpoint-ORIG-GUID: qXsVHNnXGjbQjVmDaEuJw_wtwFQx7y1r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_19,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407180016

On 7/17/2024 7:22 PM, Lingbo Kong wrote:
> 
> 
> On 2024/7/18 5:44, Jeff Johnson wrote:
>> On 7/17/2024 1:36 PM, kernel test robot wrote:
>>> Hi Lingbo,
>>>
>>> kernel test robot noticed the following build errors:
>>>
>>> [auto build test ERROR on db1ce56e6e1d395dd42a3cd6332a871d9be59c45]
>>>
>>> url:    https://github.com/intel-lab-lkp/linux/commits/Lingbo-Kong/wifi-ath12k-Add-support-for-obtaining-the-buffer-type-ACPI-function-bitmap/20240717-211701
>>> base:   db1ce56e6e1d395dd42a3cd6332a871d9be59c45
>>> patch link:    https://lore.kernel.org/r/20240717111023.78798-3-quic_lingbok%40quicinc.com
>>> patch subject: [PATCH 2/4] wifi: ath12k: Add Support for enabling or disabling specific features based on ACPI bitflag
>>> config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240718/202407180403.SFqsPj0v-lkp@intel.com/config)
>>> compiler: alpha-linux-gcc (GCC) 13.3.0
>>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240718/202407180403.SFqsPj0v-lkp@intel.com/reproduce)
>>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202407180403.SFqsPj0v-lkp@intel.com/
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>     drivers/net/wireless/ath/ath12k/core.c: In function 'ath12k_core_rfkill_config':
>>>>> drivers/net/wireless/ath/ath12k/core.c:33:15: error: 'struct ath12k_base' has no member named 'acpi'
>>>        33 |         if (ab->acpi.acpi_disable_rfkill)
>>>           |               ^~
>>> --
>>>     drivers/net/wireless/ath/ath12k/mac.c: In function 'ath12k_mac_copy_eht_cap':
>>>>> drivers/net/wireless/ath/ath12k/mac.c:5488:19: error: 'struct ath12k_base' has no member named 'acpi'
>>>      5488 |             ar->ab->acpi.acpi_disable_11be)
>>>           |                   ^~
>>>
>>
>> Lingbo,
>> looks like you need to have support functions in acpi.c with suitable stub
>> functions in acpi.h for cases where CONFIG_ACPI is disabled.
>>
>> You cannot directly access ab->acpi outside acpi.c
>>
>> Nice catch kernel test robot. Wish I had the resources to run every patch
>> through a large number of build configurations!
>>
>> /jeff
> 
> thanks a lot! jeff,
> 
> i'll change it in next version.
> When i checked these codes using ath12k-check and smatch, these issues 
> did not appear:(
> Out of curiosity, how can i set up a similar kernel test boot locally?
> i can avoid issues like this when sending public reviews.

These aren't boot issues, they are build issues. The only way to recreate is
to build for all supported architectures. Note that this was found when
building config: alpha-allyesconfig, compiler: alpha-linux-gcc (GCC) 13.3.0,
so for ARCH=alpha. So you can recreated by downloading the alpha-linux-gcc
toolchain from crosstools and building the allyesconfig with ARCH=alpha.

/jeff


