Return-Path: <linux-wireless+bounces-33716-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oG14GuY0wWm7RQQAu9opvQ
	(envelope-from <linux-wireless+bounces-33716-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 13:41:10 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D21E2F20F4
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 13:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 55503300337C
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 12:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C48B3A3E70;
	Mon, 23 Mar 2026 12:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AFLjDSCs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OEMGrHcn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95A3388E78
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 12:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774269667; cv=none; b=Jn25l6JVT1lbUqAEJrSLUSkLlV8Eo6fsV3gY3G9+iIVCFNDK6h1oLJjAMXNB759+1xr62tZVjkv+lPXUw64VwaZbSP4i9yDJQ6+LDDbrm4YE2EE4r9UuT0/lWNyLNUc1zmlkSarLjkL8klF19YFSfEUSRaldgrnpmnn3VucQ02Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774269667; c=relaxed/simple;
	bh=MWYgDIZ9Wq0tQzzpdZmQcwxxTj1fXQpsvnahqGDCSAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MLKxyPIBb0dSxb/ORUh6m/0sz4oYBlcOe5QlUBqLlTPVjdN5aJbrS2lM4dTGc7VhYjSo45Q9k6lZSb07AxcMOXnTj6SMBx2ULBzfrUF6/1rN4HfJUZ2Mywj28EmGlXtEeq3Pf0O93e2f7SpKBwHjn4qVAzlsN0BNEvHWGzsjBaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AFLjDSCs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OEMGrHcn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N83oXS1364146
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 12:41:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7W4tXDWS7eU/qHOIUTM+5yUH7PgzBQxpVMleROeekeE=; b=AFLjDSCsJG10XCnK
	N8bXXBhNfPnKestPSnL/ZcICI2FtPu5/G7t/Hpdj+/qbZWw0tskf8pnurfu9Yvke
	tEdzX7G5TICO1vIEaAZOlFJQGEUHALaNe4zkQGUHUygfAztkWkNdOaXXlocbp2LI
	jJqnBT3de49tYeem7bJYrpy4QOgKLOxebm5Z4kEQ3cbPbKTZquGHer0YB33iM0Jc
	NSYgmzGOi06VAQ216YSeIpeaVUgr8S8qu7SBNzpNV7silU6BiYsIS5T4zO9e9WBa
	wlvhTnTMahvTvSCLAsjdwn/wa+Qfs0Avl9JBvae4kxt6TGvhEv0uStCKZ1I2vzEX
	3npeNQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d31p78ye0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 12:41:04 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82a68acce26so80311b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 05:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774269664; x=1774874464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7W4tXDWS7eU/qHOIUTM+5yUH7PgzBQxpVMleROeekeE=;
        b=OEMGrHcnrOgZXMQ9vFyvRBBlFBM39WXCEL87gVPTni18SADKwL34aSH3VKhaOWX9H6
         rFWOLzBj2qeOIxh0WVqeYn1uhINMM85Ns1zOiY+yCla2UgLC2ktQv2nB3V4mvS8VkweE
         VfoITxEH1WXpJxix7giZaTa+9A36z+x/6bZABOSNK+vdJjWxzYhiUDQhX1BJFDVESQKz
         Fg23HOzHay0RqlXnN+TWmHjQlydE+adeumRswbMBFI0c/UJaJktt3WbsBube90q+Tlc3
         dNkAB6WGKl89mgHM4P79KKvwx/+QBeUe99jebjg+1t2CbdOp/jzIXUpHJY05mLtYdPU6
         3ptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774269664; x=1774874464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7W4tXDWS7eU/qHOIUTM+5yUH7PgzBQxpVMleROeekeE=;
        b=M6e3gQ1qbpWs6o1p07fRjhG9IjlbHgZSUKk1xYBOgd6s8u0BGAIVAiMUOz3HBEwu3i
         c/YYWnI/zDHkvajSPvlnFFZQbBp3sY+qbQIi+62vShhUA69gE9Jphlu79PZugRc6yhMO
         9TRB8BboYv2hp67uo2dEGjSFQWwYkRVLvbk79Ocx5HpBDCpKDltz3jT5ePWiON/N4BCw
         byg3Zylt3QRCwWVUS3zjKPETaujr2OI9MWXRzngXeZgGGsXbK8f9qfu3EPSvgP1kxL1l
         X24HX8oa4R1IQcRtCV34NltNtNLLBgCTLC5zWfSxgtZCfNLQbXd7vGevUuuJ3feIaigd
         nBBA==
X-Gm-Message-State: AOJu0YxHAcfdGjestvUmAw1F2JGG1mwug3wtBZvZerUf53L0E3FR5UQ1
	DB8MzMJPmAnTXG6bhYTnNG+gaKcHoHZ7MAJuhIDazuyGvsTGi2DvEaOr4CStEU993ZrjH0H2YvD
	8gwvZykSxlyLenXTwmBC+996qSvvwAUnJMMQEd9cPV7DhlVa6+9oz0uMPn3+uIPw8HHBeSQ==
X-Gm-Gg: ATEYQzw9NG/uDOtPalOy5HzsHDtZ5D8JCqCAif2W2O6Zajt+G8gt3ywYkF+Ry1kJyeg
	PcCSnUVbxgoO3u+L6Gy5o5wsoyuDd1wanMkJkz5DIJiKMLo1QAxmld5iuJqz2Sku/dxVGfRuJXE
	FNRo94ZGfimlKgM9UHmBMB/H8qaGM5eURfI7hPnCNuYRI+9+0xy8mbH76lydJ5IPiBWGlvib4Ki
	UY/cxnkMGTiPYcplv8zOo9LVusJsNMkIZpQOQyOcjZ71UWweyYu/wrU/SSRAULu3XVTqMAC2OqO
	xgmI3icJXTfEIpwyt50GJSZOjtwGnUyBwxGGePWPA9vnsTT8Kegj8y03dujUQp7llrlLv+szobp
	IwQDgh3/KpGOi/Vm4lSC7czG1M3OYkudNekztb1ivB2qZNPkoBZvYngZmR6p2eHdc4Q==
X-Received: by 2002:a05:6a00:2d96:b0:81f:40e5:34c2 with SMTP id d2e1a72fcca58-82a8c3469f6mr9661676b3a.32.1774269663753;
        Mon, 23 Mar 2026 05:41:03 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d96:b0:81f:40e5:34c2 with SMTP id d2e1a72fcca58-82a8c3469f6mr9661649b3a.32.1774269663209;
        Mon, 23 Mar 2026 05:41:03 -0700 (PDT)
Received: from [192.168.11.101] ([124.123.81.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03bbf0c2sm10946997b3a.15.2026.03.23.05.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 05:41:02 -0700 (PDT)
Message-ID: <ec266bec-c371-4ec8-a60f-21ebb810d38e@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 18:10:58 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v4] wifi: ath12k: avoid dynamic alloc when
 parsing wmi tb
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260317084740.3756880-1-nico.escande@gmail.com>
 <36c1cae8-d6c0-4432-bc8e-57216c5ea3fd@oss.qualcomm.com>
 <DH6U1JMUQXVM.287BFERLLK9KK@gmail.com>
 <40756be1-6a9a-4821-8c90-34f37db01e8b@oss.qualcomm.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <40756be1-6a9a-4821-8c90-34f37db01e8b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RMC+3oi+ c=1 sm=1 tr=0 ts=69c134e0 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=R7zuFBDiW8lgADV909h7jA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=o7wDkDyKmALEIcUQXCkA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: NdgPTjpDFARAKTpvTVgDJYay8gIsLitT
X-Proofpoint-GUID: NdgPTjpDFARAKTpvTVgDJYay8gIsLitT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA5OCBTYWx0ZWRfX2ZOIhWKTGysL
 obZ34O1G9zQ36EPVK5B2Ony1ZcpaomPDbNHheXNxZt62Hb9BOhBmNZCjke49oz64cRt2TTVvUb2
 AdrsCtDRpOwJWlChdqY6ptiqCxBJZDqng/lVUnEspssad2t/nOJLsN/lWzqlJX1J0jPn1nv/lRZ
 9rYAPpzhMNMRF+/ynzVn2m+2y6TIzoH3w4HfvSdkIJ6vLvmyMA8a2pYVFCQoLEYX3+c/rbcpK6Q
 pB7ixH3mUQBWqVrdwF8j3akgxieZcHANZXEjbjUbb3E2fRuNSpAh72FUSLCj/WKG4AcdhI/lsOG
 Yg8DxlXl7k5MVEvYVKW6J32bPUI+gFunVPh3GDjaCzvMEQW0XWH6Zk8l5q2LrnwJrlwiFr7V4y0
 TP5uCQSSpDjLHr563+6Nenf+jAnl45bwd7qjfQOq1c2oeW/ykNL7NDZXrvYnsk1XPitmhsfvDMi
 kAb66Tp8IdNJWBi7r/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230098
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33716-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1D21E2F20F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/19/2026 9:29 PM, Jeff Johnson wrote:
> On 3/19/2026 7:35 AM, Nicolas Escande wrote:
>> On Thu Mar 19, 2026 at 12:08 PM CET, Rameshkumar Sundaram wrote:
>>>
>>> Since CONFIG_ATH12K is tristate, a built-in boot can continue past a
>>> failed ath12k_init() and still run ath12k_wifi7_init().
>>>
>> I genuinely thought the kernel prevented this. I was wrong.
>>
>>> Please ensure that later initialization path is guarded against
>>> allocation failure.
>>>
>> I can add a flag like so to be able to check from ath12k_wifi7_init() if the
>> init finished ok. Something in the lines of
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
>> index 6c034071cc6d..742fb33f41ff 100644
>> --- a/drivers/net/wireless/ath/ath12k/core.c
>> +++ b/drivers/net/wireless/ath/ath12k/core.c
>> @@ -34,6 +34,9 @@ module_param_named(ftm_mode, ath12k_ftm_mode, bool, 0444);
>>   MODULE_PARM_DESC(ftm_mode, "Boots up in factory test mode");
>>   EXPORT_SYMBOL(ath12k_ftm_mode);
>>   
>> +bool ath12k_init_ok = false;
>> +EXPORT_SYMBOL(ath12k_init_ok);
>> +
>>   /* protected with ath12k_hw_group_mutex */
>>   static struct list_head ath12k_hw_group_list = LIST_HEAD_INIT(ath12k_hw_group_list);
>>   
>> @@ -2323,7 +2326,14 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
>>   
>>   static int ath12k_init(void)
>>   {
>> -	return ath12k_wmi_alloc();
>> +	int ret;
>> +
>> +	ret = ath12k_wmi_alloc();
>> +	if (ret)
>> +		return -ENOMEM;
>> +
>> +	ath12k_init_ok = true;
>> +	return 0;
>>   }
>>   
>>   static void ath12k_exit(void)
>> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
>> index 59c193b24764..f35571b1a541 100644
>> --- a/drivers/net/wireless/ath/ath12k/core.h
>> +++ b/drivers/net/wireless/ath/ath12k/core.h
>> @@ -101,6 +101,8 @@ enum ath12k_crypt_mode {
>>   	ATH12K_CRYPT_MODE_SW,
>>   };
>>   
>> +extern bool ath12k_init_ok;
>> +
>>   static inline enum wme_ac ath12k_tid_to_ac(u32 tid)
>>   {
>>   	return (((tid == 0) || (tid == 3)) ? WME_AC_BE :
>> diff --git a/drivers/net/wireless/ath/ath12k/wifi7/core.c b/drivers/net/wireless/ath/ath12k/wifi7/core.c
>> index a02c57acf137..542ec10fabf1 100644
>> --- a/drivers/net/wireless/ath/ath12k/wifi7/core.c
>> +++ b/drivers/net/wireless/ath/ath12k/wifi7/core.c
>> @@ -38,6 +38,9 @@ void ath12k_wifi7_arch_deinit(struct ath12k_base *ab)
>>   
>>   static int ath12k_wifi7_init(void)
>>   {
>> +	if (!ath12k_init_ok)
>> +		return -ENOTSUPP;
>> +
>>   	ahb_err = ath12k_wifi7_ahb_init();
>>   	if (ahb_err)
>>   		pr_warn("Failed to initialize ath12k Wi-Fi 7 AHB device: %d\n",
>>
>>
>> I don't like it much but it is easy enough.
>> But I don't know if there is a more idiomatic way of doing things
> 
> I'd prefer to expose a function rather than a global variable.
> In other words keep the flag static, and expose a function that returns the
> value of the flag, i.e.:
> 
> bool ath12k_core_initialized(void)
> {
> 	return ath12k_init_ok;
> }
> EXPORT_SYMBOL(ath12k_core_initialized);
> 
>>
>>> Or may be have this allocated on first device probe and free it on last
>>> device deinit ?
>>
>> That seems even more involved. It would be easier to go back to the previous
>> version and simply, alloc it once per ath12k_base
>>
>> What do you guys think ?
>>
> 
> Going back to that may be the better solution. It isn't nice that this current
> solution may allocate memory when the driver isn't actually used. But I'll let
> others on the team weigh in as well.
> 

Yeah, allocating once per ath12k_base is definitely the simpler 
ownership model.
I was only wondering whether sharing it across devices might be worth a 
look, since this is per-CPU scratch space and the table itself is fairly 
large.

--
Ramesh


