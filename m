Return-Path: <linux-wireless+bounces-36413-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNrzMvKABWorXwIAu9opvQ
	(envelope-from <linux-wireless+bounces-36413-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 09:59:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1283853F030
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 09:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA08A30151C5
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 07:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459363D648F;
	Thu, 14 May 2026 07:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jRuOl4vz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YJXiaW/a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D932C08AB
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 07:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778745548; cv=none; b=NOVwmqZDp9fYygBsXqMMC2eY701wjSsRPFhG5Z90oXt9wLAarLYGPMB8g9ALDo05m4/WfGhAKlogESXZqPooYJ7i0hrWaCLgIqBCWMnZG88hq7QCqT8O4YyXwvRftQf6KkCJXRMdfwjUXVZVxD972eVLHHxqSfWDan3j9+9CsZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778745548; c=relaxed/simple;
	bh=aObzH2f4kdPP2BIAgYaefWr2ylO1X5xOcQClJODN4Ok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OYOfVR9Kljq+JEV+r74pVuUcjXJCKo+RyBFlXBDzp37EDfyWwRf9S3TdlX8bRU/mOMJu/i8a8OHeKfQCfOw/iqvLFK/NGGyglViT+9fpa3moxSKKUijWe7U78YlI3pcspgOdywtTfwjpDDVwHJbpLeJTitWhcdZTFoLseEIRQnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jRuOl4vz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YJXiaW/a; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E56lWO828343
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 07:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BFa6eDc3LyjJybNG2x9S3fgTiVGx1kxPXQ/ap4VVh7k=; b=jRuOl4vzX09kzvGi
	gD4fSKuv1iBy9OF1M4dCW6IOEBv2dbyIOwmJFe83jZzPsb06B3TKT4WRkizuWJae
	qO7LOoq/MR9lgDmL0vcUx9LmZlphQvSidJCukZkjQ18D7M9OtSZXGZYr9XD4OS7/
	xK8pO5To2tzPtgi8xBm9Vw2rlVi8ORMgnKvfB/EQiJzXVTcRzw5CnWOQ75cavYOw
	BR6aospV0Qn9MP8WfJqrl0U4rk2hBrntK+dkA9VjaC2aSCqobRlctMKlePP5rpr7
	C9nqkY1vdQd7pJaytfuYBoMkQsv3JmrfpYtoSE+5ArPhE3M2/cKi3FcgCIeRpQPi
	kCm2Xw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e57y7ghpk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 07:59:06 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2babbeff9e4so90672555ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 00:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778745545; x=1779350345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BFa6eDc3LyjJybNG2x9S3fgTiVGx1kxPXQ/ap4VVh7k=;
        b=YJXiaW/aSe4vX8qnUaWXfMKLbteRK5O1gU+rxuzEGSmAibFQjdo9gumw5vTKHBfzyP
         al3Wg2iBc+ApmH7MhFUNHa3NCLtN5A68FTDdp7e0Q7U1JgH5RqANS1M8NRtZFLgXdQFG
         u30182yWUM8KTULOyQEFRjzbA8LkRYPLTnRkGLDXEpsyRf1+gdER5XvOqxHqNBTK8i2Q
         UTMIHnsMx68G90cMfJLlsBEI7zGZaNl7TbXnfHzQlvFnnoy/P10D0GeZL/7SOfKG1B6U
         hqBnIX2NECE2OgCSQ62dLeveUuay1eUkQpIOet7e3GWC4h9desXXw+hLoqdbXpZKo3jC
         W7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778745545; x=1779350345;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BFa6eDc3LyjJybNG2x9S3fgTiVGx1kxPXQ/ap4VVh7k=;
        b=nfXB4j2/gk67gXnDcmQ0mbfnFY1q9HzSLEVim/qsZE1pcqMDGRceexBvzxkr3Gp62D
         p1hkmSmnKcd5nzVrphO4CcvVcVbm5XZc/K7kaTezEDPRBInrGgqWK+20ZEeVioB5z/H7
         DKMxHb7iD75ksuZvIvN0buUJr6oqtvfWtWkl9ck3HIuoVfH7DSwczB/14fv3gznDtCwq
         xo/tc3RIZ7PQQKzWOHLX2+JjlecPRoKC6W/AZXAygSPK7dhkYYP2c960BYft5uJhdIyU
         CBpMUmDzw94Ds7ALxyTfcLPHrMBA0Gl9TS0qxdKHuN3j08K1D5bJ58gZ+SfrhatmvJhu
         fJGA==
X-Forwarded-Encrypted: i=1; AFNElJ/sKSnZWKuGFjm2qokg1WsiP/TwyIG0fQkoIFxjykYS3n9WNr3ibkakmNyS5QnII4B7eQ6aWTeYO8NQh/oG8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMjhY/mc6/eY10+PgQfJF0iLttFEyZ9WwzD1bZdLruw5drLSGx
	dApFRCVL0yUjOmmG6q7EKROtSFgT+8l9XdbhLBrZaOkqIhRFXipcGo0YmlsBbyb88YqIt/ypRab
	XUahjpG1ChPnfkpgHmsk7j3GPzwYvsvLPhosgvaeSwZBIVQ/qrTogj+iThJvIaFhTQLBiY7CArL
	QIiQ8B
X-Gm-Gg: Acq92OHXg4YrZORIFtKeE/vZeKTl6geJYxYdKFvHMBdztWQ+Pjqih+FIkehIUZgO/2i
	Ggc8EZ9q1P+//ofs8rn9umk98hFlVKCe7gwR+u0SIb0rMzRAwk+Cjvlh4k/fAwknAysRYjGCfIG
	/lu3BE28uFIRXje+aJ4VB+wlLY4mExUTr8ujGGMNogfDXA/82aORRmWtbEiCAViNlejIOIrfji/
	PsEXq/kuCIktMkba2nShAFC+xnE1E8J3inYAMyg0ZZoEN9dtpLCeBUfbbS4CNi2ROKPptHtr1Yw
	wsMaA9vH3uwPhq25+RdH9TaWy0D2jbDkBIurXY87UjtmJcyrz6mJi3gFWsT/oDkxSGs8kWAhipm
	6nwcFAh9GXFUttwwtt6UOGCrc0k0uD1ABybW99Px+toNDAe6D6T/7WtH+T4ElwMIWhhgkdE+4Kd
	OvKTic+IhBpBat7+Fp7l0=
X-Received: by 2002:a17:902:db12:b0:2bd:606d:b349 with SMTP id d9443c01a7336-2bd606db41fmr12542345ad.9.1778745545236;
        Thu, 14 May 2026 00:59:05 -0700 (PDT)
X-Received: by 2002:a17:902:db12:b0:2bd:606d:b349 with SMTP id d9443c01a7336-2bd606db41fmr12541965ad.9.1778745544708;
        Thu, 14 May 2026 00:59:04 -0700 (PDT)
Received: from [10.133.33.178] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c0605ddsm15089135ad.32.2026.05.14.00.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 00:59:04 -0700 (PDT)
Message-ID: <3ff9ed80-fd6c-4923-a1da-777ae8aac346@oss.qualcomm.com>
Date: Thu, 14 May 2026 15:59:00 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: clear shared SRNG pointer state on restart
To: kfarnung@gmail.com, Jeff Johnson <jjohnson@kernel.org>,
        Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, santiagorr@riseup.net,
        stable@vger.kernel.org
References: <20260513-kfarnung-ath11k-srng-clear-pointer-state-v1-1-bc700dd8b333@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260513-kfarnung-ath11k-srng-clear-pointer-state-v1-1-bc700dd8b333@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: y_nvwIxYjioo8sBN9moGS2CbJ8XI1YTS
X-Authority-Analysis: v=2.4 cv=UY9hjqSN c=1 sm=1 tr=0 ts=6a0580ca cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=CbO934nNXDxLm8dFh94A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: y_nvwIxYjioo8sBN9moGS2CbJ8XI1YTS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA3OCBTYWx0ZWRfX5ho7B8bMHaPn
 j3KZbvf+HdUHMvaRQcsR40ZwFeiLkEaUQ2f4H+ORdjE6VokzMwTHS7R8g0S/Zu5GCnMLmj7KN/4
 4XCvr6nTdkF4DLuUYky6dQusWuZx0MeLEt+IYmUKQQEXOvb7y2R1RtksL7nsJ3qzJmkDZdT2T5F
 7xucy5kEc1WiDatu8KQc4sGySj30ta4os03VnJLMtewRY9v0skJccbYkgu311Uz+oGRqpz34QWw
 oIFtr9/zDydmlwtMglIwKY6viMEf3jQHxL81b2AeS7+emU4sL1//zrnsnB8tVaQZElZSnbvNsey
 0wA2Z/9HetTv9yi5Rw9PFdcRq/a7I3nsyPEqvJMkn8UOJhiwMb7rcmx1UHgZ8B4dhg1h8M/Fbff
 qTtkMfVMbZRXg22tyMfCTPS06eiasfBG+oAlSHtYXwTKvhmM19yfiVBj5cT6G/HWu1tZUz6x+XJ
 logq184Gb2mlOB4jEYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140078
X-Rspamd-Queue-Id: 1283853F030
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-36413-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,arm.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On 5/14/2026 12:52 PM, Kyle Farnung via B4 Relay wrote:
> From: Kyle Farnung <kfarnung@gmail.com>
> 
> LMAC rings reuse the shared rdp/wrp pointer buffers without going
> through the normal SRNG hw-init path that zeros non-LMAC ring
> pointers. After restart, ath11k_hal_srng_clear() can therefore hand
> stale hp/tp state from the previous firmware instance back to the new
> one.
> 
> Clear the shared pointer buffers while keeping the allocations in
> place so restart still avoids reallocating SRNG DMA memory, but starts
> with fresh ring-pointer state.
> 
> Fixes: 32be3ca4cf78b ("wifi: ath11k: HAL SRNG: don't deinitialize and re-initialize again")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/CAOPSVF04q6uvVdq8GTRLHBrVMdpt9=o9wVcFMc6f-yhmSBcZqQ@mail.gmail.com/
> Signed-off-by: Kyle Farnung <kfarnung@gmail.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


