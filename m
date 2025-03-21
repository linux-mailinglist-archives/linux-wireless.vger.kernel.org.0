Return-Path: <linux-wireless+bounces-20665-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EB5A6B9A9
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 12:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2BE18883C0
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 11:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA751F4199;
	Fri, 21 Mar 2025 11:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UTB6H2zO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB1B22157B
	for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 11:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742555678; cv=none; b=cYlbKCE2GBtaSPvU/CyvOqNXWLQazrKwbpszjXDMBNwOqEymkYvUUsnBVVtxnaafCYwASbv+4eDoiBWMJYXdlCuNQkfi7K2x0dEmIlvfkxcn01OCbtDzwsN45pLhz6GM4MMgca9h4x4azgeJJlDKaMOAMY01X3lXzJW9MahywCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742555678; c=relaxed/simple;
	bh=/enLnxsADJxKZ5JN6lJ6w05+HIGNYMbjlr5HYl8fGjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZwUiJPnYGFG5W4nrSZ3x+8g1e01Oa0Nh3fWQMfYzSS9JLq75MaU+aiQDZA+DNr/wsgqtTs9fnw823HGFj5nQx0hP3zW3XTIRNygbltHfRd1oFH6TmpOsimz2QQYlPDZnG3t+uYSvx7AvrsGwazFX04oI3Mc0qY2z2bByWLiSsyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UTB6H2zO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LATEw7022440;
	Fri, 21 Mar 2025 11:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K9wvdIfeF6JTEl3SxM4XKsLrGDlt1SUd5JPCbyGFtqg=; b=UTB6H2zOPl1Ttqbp
	zdr/bvzAT5dsqbjr21hg17xBsNxupJ3WE7VKpe7kXxed6fJdum11ALx6e1orxX0r
	ZD+02fHgzWWkj4sgwIrCUuoHUV1bgDh33iVXXi9qvnANeb8hUJ7m4sFi7dzkGDmf
	oQsaD+Icj4+DDbrk0Al5wfS2tU3GH0p6JsqP0qHCLHXLZFzG3J93xZcEPYxYzwsX
	xKRo+u4dDQncFnYjVzQopvt1QtOII4kiBuZS0CQrpGnnLCX1Z5LqShf/n9EBucur
	PYHjB693SUKMucv4YhmtdDe04/xTrvr4mxNApsn6USGdwnHf8XMPyIMzEZmVHXBA
	Z6tyMg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45fd1dshsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 11:14:29 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52LBESwj006124
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 11:14:28 GMT
Received: from [10.133.33.89] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 21 Mar
 2025 04:14:27 -0700
Message-ID: <0741d771-50e4-49fd-b9fd-1cfa02d34b37@quicinc.com>
Date: Fri, 21 Mar 2025 19:14:24 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v3] wifi: ath12k: read country code from SMBIOS
 for WCN7850
To: Zong-Zhe Yang <kevin_yang@realtek.com>,
        "ath12k@lists.infradead.org"
	<ath12k@lists.infradead.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20250321090307.1397-1-quic_kangyang@quicinc.com>
 <66db20d096a347d0b832baad3c5061a7@realtek.com>
Content-Language: en-US
From: Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <66db20d096a347d0b832baad3c5061a7@realtek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uUElXcVubIBlGUJqMhqmummCFBAQ3JnD
X-Proofpoint-GUID: uUElXcVubIBlGUJqMhqmummCFBAQ3JnD
X-Authority-Analysis: v=2.4 cv=T52MT+KQ c=1 sm=1 tr=0 ts=67dd4a15 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=DFMmyN678vVbZ6SdO-kA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_04,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 clxscore=1011
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210083



On 3/21/2025 7:06 PM, Zong-Zhe Yang wrote:
> Kang Yang <quic_kangyang@quicinc.com> wrote:
>>
>> Read the country code from SMBIOS and send it to the firmware. The firmware will then
>> indicate the regulatory domain information for the country code, which ath12k will use.
>>
>> [...]
>>
>> static void ath12k_core_check_bdfext(const struct dmi_header *hdr, void *data)
>>                  return;
>>          }
>>
>> +       spin_lock_bh(&ab->base_lock);
>> +
>> +       switch (smbios->country_code_flag) {
>> +       case ATH12K_SMBIOS_CC_ISO:
>> +               ab->new_alpha2[0] = u16_get_bits(smbios->cc_code, 0xff);
>> +               ab->new_alpha2[1] = u16_get_bits(smbios->cc_code, 0xff);
> 
> It seems that one of the masks is wrong.
> 

Oh, yes.

>> +               ath12k_dbg(ab, ATH12K_DBG_BOOT, "boot smbios cc_code %c%c\n",
>> +                          ab->new_alpha2[0], ab->new_alpha2[1]);
>> +               break;
>> +       case ATH12K_SMBIOS_CC_WW:
>> +               ab->new_alpha2[0] = '0';
>> +               ab->new_alpha2[1] = '0';
>> +               ath12k_dbg(ab, ATH12K_DBG_BOOT, "boot smbios worldwide
>> regdomain\n");
>> +               break;
>> +       default:
>> +               ath12k_dbg(ab, ATH12K_DBG_BOOT, "boot ignore smbios country code
>> setting %d\n",
>> +                          smbios->country_code_flag);
>> +               break;
>> +       }
>> +
>> +       spin_unlock_bh(&ab->base_lock);
>> +
>>          if (!smbios->bdf_enabled) {
>>                  ath12k_dbg(ab, ATH12K_DBG_BOOT, "bdf variant name not found.\n");
>>                  return;
>> @@ -690,7 +712,7 @@ static void ath12k_core_check_bdfext(const struct dmi_header *hdr,
>> void *data)  int ath12k_core_check_smbios(struct ath12k_base *ab)  {
>>          ab->qmi.target.bdf_ext[0] = '\0';
>> -       dmi_walk(ath12k_core_check_bdfext, ab);
>> +       dmi_walk(ath12k_core_check_cc_code_bdfext, ab);
>>
>>          if (ab->qmi.target.bdf_ext[0] == '\0')
>>                  return -ENODATA;
>> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
>> index 116cf530621f..e2d300bd5972 100644
>> --- a/drivers/net/wireless/ath/ath12k/core.h
>> +++ b/drivers/net/wireless/ath/ath12k/core.h
>> @@ -172,9 +172,34 @@ struct ath12k_ext_irq_grp {
>>          struct net_device *napi_ndev;
>>   };
>>
>> +enum ath12k_smbios_cc_type {
>> +       /* disable country code setting from SMBIOS */
>> +       ATH12K_SMBIOS_CC_DISABLE = 0,
>> +
>> +       /* set country code by ANSI country name, based on ISO3166-1 alpha2 */
>> +       ATH12K_SMBIOS_CC_ISO = 1,
>> +
>> +       /* worldwide regdomain */
>> +       ATH12K_SMBIOS_CC_WW = 2,
>> +};
>> +
>>   struct ath12k_smbios_bdf {
>>          struct dmi_header hdr;
>> -       u32 padding;
>> +       u8 features_disabled;
>> +
>> +       /* enum ath12k_smbios_cc_type */
>> +       u8 country_code_flag;
>> +
>> +       /* To set specific country, you need to set country code
>> +        * flag=ATH12K_SMBIOS_CC_ISO first, then if country is United
>> +        * States, then country code value = 0x5553 ("US",'U' = 0x55, 'S'=
>> +        * 0x53). To set country to INDONESIA, then country code value =
>> +        * 0x4944 ("IN", 'I'=0x49, 'D'=0x44). If country code flag =
>> +        * ATH12K_SMBIOS_CC_WW, then you can use worldwide regulatory
>> +        * setting.
>> +        */
>> +       u16 cc_code;
>> +
>>          u8 bdf_enabled;
>>          u8 bdf_ext[];
>>   } __packed;
>>
>> [...]
>>
> 


