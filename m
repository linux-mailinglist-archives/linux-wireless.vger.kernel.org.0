Return-Path: <linux-wireless+bounces-30982-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B1CD3BCDD
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 02:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F43C302C84E
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 01:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F93F1F8BD6;
	Tue, 20 Jan 2026 01:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RjGECdWY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BkWBW1Eq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7DD14B950
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 01:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768872711; cv=none; b=EoYUMtMkm4RNmjmNBx2dpLuMddRswDtVE9yZHSGftqRz0c0/lOf7xJksx8hvjr4humBf4CxccR45Yi0RQAfE8CWtqagg9sL2u5BxQ/x+V+hbd8O13odbvX4ghckw240+3RS7d7eBgl2YmL34DEtdaiAQAYDxCyGS/sIP4dwA7Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768872711; c=relaxed/simple;
	bh=oMT0iX9wMvcvgzMWAqGs81I4Qs27mZgztxOv3yCd0b0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pbj7tDgLkBf0us4OdP4jXPDVqV4uX1JCTNGZ4Yn1zqvqXXqgPaQNcICl9A1mY5EsJ8Jz85r8HZzbWZujQI8bhiHppgeRLhVSC92hhw4kD4NEQV1yVR5cQ6n9repCYK3JWIJEbDXlfMmUx+dk2kmfk1o41xkKWp0hwKudjFGJ0JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RjGECdWY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BkWBW1Eq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JIV8eG598331
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 01:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EurZDX4j1u1daRQ8YIKhVg9OpQ24kYt1o7VNKtuF/UI=; b=RjGECdWYlwyTkN2g
	6tCN/iGciBQ9Qg5Fw/3jCruvszhgWBc1AWKXtPUc/Cit7FVvnrxiySNf6mzZ6M3v
	v+B78M17RSSq3iyf8Yc7hec9u6Im/OF742sk4TaE7TuyfxtNooOP7rW1EJNbP1Ub
	7jA7JKpCyhMyluDVsA0KBTqZa1owkEyAwXqkgSoqdWxYmUMuBYEjzt1dPOjmJC7A
	B6cdKAs7UOSRGJ3Z7ym51kV8refnS4AIakBsVzCWGH/Gh/ujfD9gN8EzCdsrKZnv
	fj4qID0njP6GdU/Q3FkZ63gxeqP151Bk0VNU8kVmodTntjEA+BfYS5UdtXXXsYr0
	H21OrQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsjk7j37n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 01:31:48 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-81fdfafe6e9so266155b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 17:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768872708; x=1769477508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EurZDX4j1u1daRQ8YIKhVg9OpQ24kYt1o7VNKtuF/UI=;
        b=BkWBW1EqXuqxvK+opbuzw5xNUJXnwZ0DbZB2VsciSARfF8m8fE0+rlP9HT03c6nVXD
         2F7RyWHgydxYxYDu/w1Qvw2dXK3GJlToCRbIQR8lz/LhAhpyIYtr1XPgpPmhNY5Jr4/k
         WjviBTzXwnw2Vgq4uaqAat1InzFtWijLNbZjtshlNUSmMVAYDnyrGPGQM5IrvgoGK5fM
         xEt50m6Usv8vAp8cklIBOQYRiriDZsF4949nunBQK30UDKNscWC0zuty0P34KvT+cG7e
         dfJ7OfPvt8sY1PsRdYilP1JbnMBQwjLgcjqwFJxrROvWwGG3etZrflFHrM1nnp+I0zdy
         IoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768872708; x=1769477508;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EurZDX4j1u1daRQ8YIKhVg9OpQ24kYt1o7VNKtuF/UI=;
        b=kXpTOUnbsbb07qX/m5tXALr9VFMJT6uGBrn2BtORTtgIEQIEsS9haOh3q0skBGuDVl
         Rrd/J1DzAT5NwqsmjN5J6NFcfMJJXcAgIVzieDMg1GH+ZdVhINXpY/wKk0zUnT+tpteJ
         5uwL3qA6y7M8YKCzAmHifc5OXUnLN5ebL5h/zxmEcIM7cFwAvow7IpYPWQp4Xjf5+oKe
         CnPFFJxndEbhwmq7YgXByoD3iLh1lChMjAasBcicVF3xcigXOajTr85X5jE9y9Ms6sgw
         w0SXcK1YgkY+jrd38YvtRDpm8xv9aRRt1xH09Qbfxkck48v80stAfgeZ4uJgeKitnCSC
         8fow==
X-Forwarded-Encrypted: i=1; AJvYcCVvMIOyqDoNGaStp6aeQ592tJPbp4ALcbxefa9z54b2kXd8y7q1K5nZGLzzsKWHwlbZ/WNledYQmKKG7vNirQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEH6N8kc1jqr4lxr5LGiCh3GP7WSaMZ/DGtsjTW3cMUJpVMTxi
	Df1c2/2ckw9fFOF9JblJsgRfWVYbyzY8AbSv4wJ6egt0BT08UjaDVpMY8SOJFmHBczmjKJjA/Vx
	lH8dxtQNaUtIORCRXAY4RIy8o4G467dkuQMyc2B8sco1fJlwmvLbnWZS7X9qiDvK25IKZgA==
X-Gm-Gg: AY/fxX48pQYwrrUI71Rp8xxo2eA23XU+q89D38xlMwFKmOxdoq59BHUaos+gUpZUVma
	ApitKrKi54nZFhm+uYDEbyj1bhHzV9HgcN5mbLr3nipIKCtR6XfeztXel8TQ25HV6W9PtQ0+V7t
	Izn0F8WiiOF+4EQ6L8V4PhvnB8qHtbysLh/39V52mmt8bbzL3QlHKfKEJiwMEeyhC9Y7Jm9Xg38
	gPQzj8muci5rLEOe5vwUn8JAAkVRvd9goPAcvWa79wNKexgFFh6d6oq8hgJFn8eazXXOMkQfKwj
	gwkU/NVGUcsAmDwqRM/myhrTcjrxxbe2qWsAxsZd4kvGMw5w0hdGz/l6TU2B3evxWrj1ZtnglzQ
	B9ah233xzZVv6VP4nltV2g3m/EDVBT60j/CUgk7FLL/7SfuiIX/2f9g1vaEV+HvFlc8H6Y40p5w
	Fc0P/l
X-Received: by 2002:a05:6a00:ac4:b0:81f:7db2:89db with SMTP id d2e1a72fcca58-81fa188208fmr10973299b3a.68.1768872707687;
        Mon, 19 Jan 2026 17:31:47 -0800 (PST)
X-Received: by 2002:a05:6a00:ac4:b0:81f:7db2:89db with SMTP id d2e1a72fcca58-81fa188208fmr10973265b3a.68.1768872707155;
        Mon, 19 Jan 2026 17:31:47 -0800 (PST)
Received: from [10.133.33.36] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa129199dsm10227896b3a.51.2026.01.19.17.31.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 17:31:46 -0800 (PST)
Message-ID: <1e19474c-4b0f-4e68-84af-4ffe9c8c0f8b@oss.qualcomm.com>
Date: Tue, 20 Jan 2026 09:31:43 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 ath-current 1/2] wifi: ath11k: add usecase firmware
 handling based on device compatible
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: jjohnson@kernel.org, johannes@sipsolutions.net, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzk@kernel.org
References: <20260119140238.3360658-1-miaoqing.pan@oss.qualcomm.com>
 <20260119140238.3360658-2-miaoqing.pan@oss.qualcomm.com>
 <CAOiHx=nBLtSFNhuRZrHn5z8bCrA5nyuS9G8B0nh-WTiFU_HUMw@mail.gmail.com>
Content-Language: en-US
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
In-Reply-To: <CAOiHx=nBLtSFNhuRZrHn5z8bCrA5nyuS9G8B0nh-WTiFU_HUMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDAxMSBTYWx0ZWRfX1I5gg7LSZsUh
 JmFp7HpnuCHvXPa3RyVUWyp2gtL05I45wOzcD252YSAy77zznLTWG62r7xmg3Bvqa/1aGsPJVmL
 WwFyJ+E9wKgxFY0uvZ2HCK7s2yWdrdvIaa98Q8zKfsaY47OhPC9uUh5xxzvACNMkTC/rt3Of4U7
 d2+8D2GZa89hlxYqdGyIc/j5TD0I1oKplnDLJyTmRRpMxhb0pgjRFn4iheQVtZmZ3uN2rKyp8US
 o3JMqGaVyuGoSmaXYeGdKzi58G0O+VbAIfPllZ9JhYAMCqpYDk6RvLWe5nIPxO2z7Gp+Dm/YS0l
 lPa8491YAyB6cU6EiKvHZsJkHo+5FHjtbhiqz/wBRE1aBjyIlVUQ5LcelhsTh9zFGuy6q2qDLXu
 BSNJtw9YQYJzmVsfzmkFn82IK+bai+Pr5BqSKW3CI+n4yEayVWA7LKxDkvwORDy1uYlM77ZgxPC
 Fiy20dbdQUFbfvbQeEQ==
X-Proofpoint-ORIG-GUID: Ku_IVx11SRabz0SHgWTaety67fNCUmda
X-Authority-Analysis: v=2.4 cv=WoAm8Nfv c=1 sm=1 tr=0 ts=696edb04 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=D84e7DIKQFjpkovS06oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: Ku_IVx11SRabz0SHgWTaety67fNCUmda
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_01,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200011



On 1/19/2026 11:56 PM, Jonas Gorski wrote:
> Hi,
> 
> On Mon, Jan 19, 2026 at 3:04 PM Miaoqing Pan
> <miaoqing.pan@oss.qualcomm.com> wrote:
>>
>> For M.2 WLAN chips, there is no suitable DTS node to specify the
>> firmware-name property. In addition, assigning firmware for the
>> M.2 PCIe interface causes chips that do not use usecase specific
>> firmware to fail. Therefore, abandoning the approach of specifying
>> firmware in DTS. As an alternative, propose a static lookup table
>> mapping device compatible to firmware names. Currently, only WCN6855
>> HW2.1 requires this.
>>
>> However, support for the firmware-name property is retained to keep
>> the ABI backwards compatible.
>>
>> For details on usecase specific firmware, see:
>> https://lore.kernel.org/all/20250522013444.1301330-3-miaoqing.pan@oss.qualcomm.com/.
>>
>> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04685-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
>>
>> Fixes: edbbc647c4f3 ("wifi: ath11k: support usercase-specific firmware overrides")
>> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
>> ---
>>   drivers/net/wireless/ath/ath11k/core.c | 36 ++++++++++++++++++++++++++
>>   drivers/net/wireless/ath/ath11k/core.h |  4 +++
>>   2 files changed, 40 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
>> index de84906d1b27..1cf7f4e601c3 100644
>> --- a/drivers/net/wireless/ath/ath11k/core.c
>> +++ b/drivers/net/wireless/ath/ath11k/core.c
>> @@ -1044,6 +1044,42 @@ static const struct dmi_system_id ath11k_pm_quirk_table[] = {
>>          {}
>>   };
>>
>> +static const struct __ath11k_core_usecase_firmware_table {
>> +       u32 hw_rev;
>> +       const char *compatible;
>> +       const char *firmware_name;
>> +} ath11k_core_usecase_firmware_table[] = {
>> +       { ATH11K_HW_WCN6855_HW21, "qcom,lemans-evk", "nfa765"},
>> +       { ATH11K_HW_WCN6855_HW21, "qcom,monaco-evk", "nfa765"},
>> +       { ATH11K_HW_WCN6855_HW21, "qcom,hamoa-iot-evk", "nfa765"},
>> +       { /* Sentinel */ }
>> +};
>> +
>> +const char *ath11k_core_get_usecase_firmware(struct ath11k_base *ab)
>> +{
>> +       struct device_node *root __free(device_node) = of_find_node_by_path("/");
>> +       const struct __ath11k_core_usecase_firmware_table *entry = NULL;
>> +       int i, count = of_property_count_strings(root, "compatible");
>> +       const char *compatible = NULL;
>> +
>> +       for (i = 0; i < count; i++) {
>> +               if (of_property_read_string_index(root, "compatible", i,
>> +                                                 &compatible) < 0)
>> +                       continue;
>> +
>> +               entry = ath11k_core_usecase_firmware_table;
>> +               while (entry->compatible) {
>> +                       if (ab->hw_rev == entry->hw_rev &&
>> +                           !strcmp(entry->compatible, compatible))
> 
> You should be able to replace most of this code by using
> of_machine_is_compatible(entry->compatible) instead.
> 

Thanks, will update.

>> +                               return entry->firmware_name;
>> +                       entry++;
>> +               }
>> +       }
>> +
>> +       return NULL;
>> +}
>> +EXPORT_SYMBOL(ath11k_core_get_usecase_firmware);
>> +
>>   void ath11k_fw_stats_pdevs_free(struct list_head *head)
>>   {
> 
> Best regards,
> Jonas


