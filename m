Return-Path: <linux-wireless+bounces-32102-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBbWOhw7nGlCBgQAu9opvQ
	(envelope-from <linux-wireless+bounces-32102-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 12:33:48 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E9C175917
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 12:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0190C3020D4E
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 11:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8163234DB44;
	Mon, 23 Feb 2026 11:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a1qRh330";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AxWPPZz8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6750D361644
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 11:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771846344; cv=none; b=f/9NMMxnYWH6iitO66/1V1wX+Anr/jpwZFtohryGsQffEV6NncpInJ3axziY/EwjuJYpeqiw8shdVpebV/bdWKY9ujN7lyzNRoXvCoxf+nUCBuOwQyF9Gze8xuCkDe7t7gHIdd4Dr6LWXl391K5GuDFORHwCNBDDZMliV+ZgaXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771846344; c=relaxed/simple;
	bh=f1pbR8sgLtn6oZgcINCLucEN4MMj7qPzbBmG07v889w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FdWIv87M1jK6mPM98goROoxDjT/qbUsa24liUpOEHOSHTCl1PQCegq5L/y2QImi9fmvShrDj/3q45z2Q/kCEwruw0nzTxzf/lY0doK0ODu8953x2AVbAhXMcQUUqTTm5vXWyYrKYi0SHy4z6FYxkl56yP8LrMwCKqsojf29jeC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a1qRh330; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AxWPPZz8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N9Lm1P1198815
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 11:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B33hvBVuiqvJymQjx8XSBmxoEXXvA+DPmyhNbHsTjdQ=; b=a1qRh330qXEwRULx
	jAiKhLwZV5nxJnWvoxpw3o7KhynMrDYSbCY3ovJBH4oqeTinKcAe8nYBR0xWYqf9
	U8T0m80T2CJAAlA1uXrgXe/Xd3kE3oZIMAmgqe2cZLKymPrSzO+4wYDDsXCEv27z
	0lSjFCnkafFn1JWSVQ+Le7dMgKi2Tfaa2TS7PQlsZCImg59p1DmqvTD9G5QIUbWj
	ShQWK7dy3T/9gBtRWcG56aEucmpWtpnAISPD8BkVIvLlZ7rPbTSfYU2qnTu7JYfE
	kXF9rzpGr6yMEDvj1U82pf7EGkYRLqw39UNyzYSDgURqu3c+6Tu8kKlfKatnjQtd
	0qEWTQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf603mk5y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 11:32:22 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c6de06e6c08so2892056a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 03:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771846342; x=1772451142; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B33hvBVuiqvJymQjx8XSBmxoEXXvA+DPmyhNbHsTjdQ=;
        b=AxWPPZz8mFdB7D+YDkIrmcdirigCrBgb3dktQtJuFu7Szb82RUTt1/1Z6iPrnI58Jm
         FMFmcxFNJ5Orgce3+IK8R4PwQ7pQFSFtuqTXdsrfCgHMUAH10UQZXUn2HMzvszgaQtn6
         nbl32AqsekjNUivB5ZkPuG6IIgM33uD+FNPdBakSLUTGLxfZfL7OG9ipThJtNxVZqVTH
         30ELpQ0ImjpQAdCrARbye3st7Zl5gBr14/MIHjZwQbp0wpVjySmFC7dL8McuZVQma7Fa
         kOSFPAjeJOwCMremnQvULGIr8LR8DxUJFtmQLzG/vr+auu8e9TQ5LViHhL9FHpI31rTM
         eHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771846342; x=1772451142;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B33hvBVuiqvJymQjx8XSBmxoEXXvA+DPmyhNbHsTjdQ=;
        b=jlQN1UywB8gmpCfYzFH14KFcVPy0F1CJEbQeTj1ZVQ0iPbfbc/xafogA37RT9fUh2v
         R8/v8xq5Tgh0lBlQov5CX4fOu0Bxzn8A7giE9B0bE+OqwZ72EtQzl52z8IIG3RiLR2hB
         Cs7bC15zw+w+r27gWrdUzHz2NPnEF2bTrrz+6J/2Yw//ZrMylbYwFIBhaUigsB+1mP7o
         6LsgCBww814IKGK8pWZWf8SGAyzkD1s+JOuuZq0mFINVNRjvj12Tp0H/OfMcWaB7l3sU
         SOKeVMICJP9XN+dhrD97dnU/LQr4MiuM3Vpnn10y2/n+QnNP/MnDmHfBq/J5XuJUdjyh
         MQgg==
X-Gm-Message-State: AOJu0YxHhQI/ruxL6oAgVpubmq6blC/6c30wjcThuuISaJ8k1B8hyx/H
	sekCo173uC/hcF0SQwqznxTj5M0nkUa5fPyNKAmIPpeABkQ1c9r8YDxh91bzRkcaWJETHuNwcDh
	/TEwX5PiK/psgXPXOifmG2T6YQZLZQlpy8QHnRLEDHpr8NXGVXByyZsQgZmPJO7yL8PSOyA==
X-Gm-Gg: AZuq6aL2cRk0BQIrlpQICQV49RH3170NEIhmY6qyI9pGyzzTs4xczXwpyGdi5CExK2m
	KcSroUZPLTDXr6AyQ7xKD4POkW4/6vkfC6wYDJQyNFRocpLIosjZ+Z7UCuWocs3C9+NCI0TgYi+
	L1xWSWd2j6iPzmg7ekNa+4eW79f7CoaIPm1Bc7mwYthZBH5Vb34dNmjbItwAQJo/8xLseXnt2Fm
	zONQ4vRuj3KeOpS+r91/EAbDmQW6vTUnisDNGEeW3PPBUpmYCKXwMqcvkyDcC9wHN4kMRfhfmWF
	2HYebZhG3BqftmpAor2AcB2MOWYngQcRKUI6J9bcqJP4wbEbSAJNE6nl4ISYpM72T6kKHO0JuJf
	q22OGtYcAiJkXCajuHp0XmYCtSRhnwodZonYABZ5/w0nxMii0zGE/BL03lRevi3pc
X-Received: by 2002:a05:6300:4083:b0:35d:53dc:cb57 with SMTP id adf61e73a8af0-39545f7b037mr6672567637.49.1771846341877;
        Mon, 23 Feb 2026 03:32:21 -0800 (PST)
X-Received: by 2002:a05:6300:4083:b0:35d:53dc:cb57 with SMTP id adf61e73a8af0-39545f7b037mr6672549637.49.1771846341312;
        Mon, 23 Feb 2026 03:32:21 -0800 (PST)
Received: from [10.152.205.141] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b724321esm6997066a12.16.2026.02.23.03.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 03:32:20 -0800 (PST)
Message-ID: <b07328cf-c2cf-4786-ac12-06ea9ae3d266@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 17:02:17 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v3] wifi: ath12k: add basic hwmon temperature
 reporting
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Aishwarya R <aishwarya.r@oss.qualcomm.com>
References: <20260223060238.7038-1-maharaja.kennadyrajan@oss.qualcomm.com>
 <DGM9946HTER7.2HAN0CPP3R2ZZ@gmail.com>
Content-Language: en-US
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
In-Reply-To: <DGM9946HTER7.2HAN0CPP3R2ZZ@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XbWEDY55 c=1 sm=1 tr=0 ts=699c3ac6 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=xDP2Xacuzhm5-ruWbqoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA5OCBTYWx0ZWRfXxhGIPaLv8S0W
 ooWL/+bAoeNELTWT76indLkeEdlNYEBAa5lN3wu8xJ278zo+229DsSPsigXAQ7c5kl4sW2D7X6v
 F2bKK/J9oAFMNT1WcMZWF2EEP/jmFZBMRkv0AAEMxjZE3esSwSemqQN97dopzdx+xXSr2lZF+5h
 GRBn1+ByGZs0+azVXeI0CNp4IyDOMMOuAuy/LMAxy3bMxc+Meb/ATcA6Q451D+c8f4meozUYjBi
 9B2HQZsdWyi6RfLizoM/DaZuLuBK5cKhfoybXZWpdkYEWSSuBYZeTRTCwvvIMUS9X/cxarRlp1z
 TAwNAh6vivfzWvqFiMlpeJx5rOdjpt5hD2AI11bh2R+xC2Bu04/tretKAmate3TtzpG2btz5KC7
 2+QikSQJIKlqxowdaODJqg5EQKD3rK7GkxHS5jDTrLaJjO2sNtSCFiyJ1afrX9Z7gOCkhlSMWVC
 WcLULWuOedh+pulTZkw==
X-Proofpoint-ORIG-GUID: JzwTW_B0wrJ1PxuZmGnNlBKbnHuwlA4j
X-Proofpoint-GUID: JzwTW_B0wrJ1PxuZmGnNlBKbnHuwlA4j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602230098
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32102-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maharaja.kennadyrajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 51E9C175917
X-Rspamd-Action: no action


On 2/23/2026 3:35 PM, Nicolas Escande wrote:
> On Mon Feb 23, 2026 at 7:02 AM CET, Maharaja Kennadyrajan wrote:
> [...]
>> +static ssize_t ath12k_thermal_temp_show(struct device *dev,
>> +					struct device_attribute *attr,
>> +					char *buf)
>> +{
>> +	struct ath12k *ar = dev_get_drvdata(dev);
>> +	unsigned long time_left;
>> +	int ret, temperature;
>> +
>> +	guard(wiphy)(ath12k_ar_to_hw(ar)->wiphy);
>> +	guard(mutex)(&ar->thermal.lock);
> Hello,
>
> Is this mutex really needed ? It is used in conjuction with the wiphy_lock but
> it's never used elsewhere. So even though there can be multiple ar for a single
> wiphy, there is no code path that that would lock this ar->thermal.lock without
> locking first the wiphy. And the wiphy lock already protect for reconfiguration
> and recovery right ?


Thanks for the review. ar->thermal.lock is redundant here since the path is already serialized by wiphy_lock .

I’ll drop the extra mutex and its init in the next version.


>
>> +
>> +	if (ar->ah->state != ATH12K_HW_STATE_ON)
>> +		return -ENETDOWN;
>> +
>> +	reinit_completion(&ar->thermal.wmi_sync);
>> +	ret = ath12k_wmi_send_pdev_temperature_cmd(ar);
>> +	if (ret) {
>> +		ath12k_warn(ar->ab, "failed to read temperature %d\n", ret);
>> +		return ret;
>> +	}

