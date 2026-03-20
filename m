Return-Path: <linux-wireless+bounces-33612-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aM14ON2PvWnY+wIAu9opvQ
	(envelope-from <linux-wireless+bounces-33612-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:20:13 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4FD2DF4EC
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D2C5430022C6
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 18:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F0E3E6DCD;
	Fri, 20 Mar 2026 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oyBMtfd9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WnY6V17q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F252D8399
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774030811; cv=none; b=U53LXzR6aBGy5HARPYJxok1Nf2kQwYAs34WHjNIx/eKFI8K/JHEKrC4VNMdDdPMbEzzByRrSpfIAijRhn54osqm21ID652EHNgcUiUEJXraNrejON/dwNpoeoer21ejdFareTBZm7kIiiOtU4HvdCBXpu31vp9p8UZiZ8ghpWcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774030811; c=relaxed/simple;
	bh=7N0nZaqqYOdmLPScLb/0tVBIz2IgqGKwAL0Hy4f5muo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwC/I/zjv4B7q4d0mesvj8HtJljobaocs4UEhBEia0+82LhQJ8cTHjoljhz8owLal08klFirYCWDq3d9mmpDV0/Sb3Ns9td5/abQt3zr0AEEgZUuqBiZ7vXUcYozcWcp+3QJ7PQixqNtomprneV7xZuZ8GW2Pbwz39OPtG91sWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oyBMtfd9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WnY6V17q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K94dPN701169
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:20:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ReARjn66uMlxQUsstGetJLP0hUp9Ztaj2HxDiiWHdaU=; b=oyBMtfd9A3rD/+eS
	4FzmBbDysH/0mcOT0Pnwx8xbkiOwd/vaPhI6Z68EHMlFZNEmH+Ec5CgHFIylpwnz
	m1u8h9sjU/gJbjxuIoPZIdmjR5RIOWXBhX6R2uHPOsKcLWdKNwMLFd3mFmQlT4cD
	Yd+nnOBYu7J82fwXYjHzgoQQakDeG26xRHFUZYix6AuSP+weoD4zC3msK33N6PYN
	hcqTIz5YVjs9fFIkv9z42fIW7AiCCSAUhVbBN1SmwjxcftcE1Mosau5mMyUT0sfK
	sJ/8IcgrO/TnLMFDHPdPHIdQQfZKAwTIHDTuM0GBPQUk78xq2q6LqXEqFsU718dd
	u9Qm3A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d139q1ah7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:20:09 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b04db6c138so29492405ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 11:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774030808; x=1774635608; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ReARjn66uMlxQUsstGetJLP0hUp9Ztaj2HxDiiWHdaU=;
        b=WnY6V17qrQWE6/llHhubv0JTWce+gywFLfdGozN0YYryT2xbJSdtV4QIxFgOLQI/Ww
         5Nf8sle7zeh++ZKc/vVmHHmgkvzUIXfnjrgqXcb5Viy3NGo9j4+OQGcGSmGoKbJ5Ai2C
         QOH5uOp/flw2wRqGUoHJzsCHbOxk3aYEWr40mO5lbLGJIdcpCJ4atHk4yhIvXz2iNTKn
         j+PDdVUmayhEHcCUY/8GuQZXp1S+B0c04+ZaOCA1TrjPPBsRDXu0z2NoDntjTLit9Nu2
         0vXOTv35Shx/qqmvgOEJ4lC1UB+bSFP2BF6IBFtwbxIpcCV9XAHWTOCuDw9knpfQtRH6
         xnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774030808; x=1774635608;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ReARjn66uMlxQUsstGetJLP0hUp9Ztaj2HxDiiWHdaU=;
        b=gzrURe9bujkYpG6jeb9GNrts2PBo0Q5SeX37d+HnNmIbJmgDBG8zZS6lPWIbGOBiXa
         hASAq6A4T6B0sPLLM/2CI+5lNBt8eHCkA1fKVoaWG0/T/ZstA4hIaUDAITgF59flK0n4
         YdYWiwMqq/3wYcte0mrp/c1YRKMx+nJ4rLlul7Rtk56DobCD1bL0DMwYBw9+XOV01wST
         sDk6h3Bm/fvjz52HuhziLjiTX4yolvYYUCrNgqgFmhgApdEI5Fu3NO/jxl8AvQXPvBSn
         mUhI8Pl+XkRHaauEtivfw/mdoK7c+yRgpzYu/DpZbYdmpOhJG28Bu/kS5t+nOMQyLlWP
         QrGQ==
X-Gm-Message-State: AOJu0Yy4zyfy0K2ELPuCGg9YxCM6QQs2B9TghRpULVMV0JMmpFJtLmFI
	hHzg55/wmZoXAaRndl1RNnB61J3WSAIEh+sJlgtV4WVg1nHRVkBxJ7yJCDh/US8g40+TOtpRLVS
	HU//bhpGYO7ok+4AibdvdtLla6cIL+QvofV+022LcpjPh/IfZadpGHx+GHXn3Vj8CyF16
X-Gm-Gg: ATEYQzzwlwXYCUKHOcjiIozoexfOSLe3jKuzbl18RFrjQLnnLzwOchtoGkCFbgia14g
	IwBB6n5erCvFs1femiGIooiMPA3bSdCV71rXPqJD9PztF9QDFFQ85lhZv462UG31ScQdai/SzPE
	arRUapY+vJoJZF7JfZx7gvMUdTufik7+vTnOhw1boYqIyX9taKOpg78i2ZxnDG0SWfi645OGNUd
	v81iDdi+SGVTVCEHnfm46aAjjJASjj4qDn1UU8Qyo0+h9v7VDVmCSjJa4qCNN5BFIQ/LARjtLJX
	Q18VAMW3ittoesciEr6VyLywTL16H71KhjoPdr3zu1iUUFM+bJ7bnnUWV+vVe1EKHhUUq6/C/wh
	dT7pe/Lo/6QtdSv5DH248bDnVZlOBsuBv6xhq6k+0fhRVhk/9zZzEcRU=
X-Received: by 2002:a17:902:f605:b0:2b0:49e6:9622 with SMTP id d9443c01a7336-2b0827db766mr35139745ad.37.1774030808219;
        Fri, 20 Mar 2026 11:20:08 -0700 (PDT)
X-Received: by 2002:a17:902:f605:b0:2b0:49e6:9622 with SMTP id d9443c01a7336-2b0827db766mr35139455ad.37.1774030807682;
        Fri, 20 Mar 2026 11:20:07 -0700 (PDT)
Received: from [192.168.0.109] ([103.88.239.213])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836a3370sm28990315ad.78.2026.03.20.11.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 11:20:07 -0700 (PDT)
Message-ID: <66f536d4-77c0-40a8-93d2-dc7f4aeff5f5@oss.qualcomm.com>
Date: Fri, 20 Mar 2026 23:50:04 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v3 02/15] wifi: cfg80211: cancel
 pmsr_free_wk in cfg80211_pmsr_wdev_down
To: "Stern, Avraham" <avraham.stern@intel.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kavita.kavita@oss.qualcomm.com" <kavita.kavita@oss.qualcomm.com>
References: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
 <20260305160712.1263829-3-peddolla.reddy@oss.qualcomm.com>
 <CH3PR11MB83834872AA2767B19587549DFF44A@CH3PR11MB8383.namprd11.prod.outlook.com>
Content-Language: en-US
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
In-Reply-To: <CH3PR11MB83834872AA2767B19587549DFF44A@CH3PR11MB8383.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE0OCBTYWx0ZWRfXwqjdo7hkHQ1M
 IY6wxxkXp4vc9REkRV/C9zOzl5c2baByea3Zq1P8zZV2EUSuiHiBbzZ4lZRqFh9IQCAvmw1pwmu
 FAYOzSNU7pqhHFmqM9QfYfCHKlRscxF16t42rQLNvu0bWDc5JDKM/dODWcncua3tDzbqjUuDqpC
 gThcOPTZYUcZRtMUjmq9irMfJ+4qRTWj3KNO8SxrrNdqQA46lAsh9rGDC3NvJxrkWoTxVwRY+54
 bZ69edzkffbVxhPoWzd0dY4riS0j3VkpxQNw7UWsPqb/9jMYYDUh+A3QjJOPHx3H6TPksrGCsUG
 ywzf7wpA0/6BkeNsvPO++u/j2JFgCJs+zZxMZrYS0eEevdBUh7HIPj43vHdWrTzxuXN3v0/X453
 PtAc4o6Tb+dlImFypH061/VszVXi1y/vgoxqoatQ5MQLRXAM9OYM79QGYfen/Wnao6bzj0xQIWz
 UALcwUnqXXZz9JNYsYg==
X-Authority-Analysis: v=2.4 cv=FOAWBuos c=1 sm=1 tr=0 ts=69bd8fd9 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=YekYzGz3bqI42vIqjoHHTA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=stkexhm8AAAA:8 a=VwQbUJbxAAAA:8 a=Qx5JVUkXni01xubdHvAA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=pIW3pCRaVxJDc-hWtpF8:22
X-Proofpoint-GUID: nxQljhD7b1tnKmFt7XtFzJznA1Of0HKr
X-Proofpoint-ORIG-GUID: nxQljhD7b1tnKmFt7XtFzJznA1Of0HKr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200148
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33612-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sipsolutions.net:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6A4FD2DF4EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 13-Mar-26 2:34 AM, Stern, Avraham wrote:
>
>> From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com> 
>> Sent: Thursday, March 5, 2026 6:07 PM
>> To: johannes@sipsolutions.net
>> Cc: linux-wireless@vger.kernel.org; kavita.kavita@oss.qualcomm.com
>> Subject: [PATCH wireless-next v3 02/15] wifi: cfg80211: cancel pmsr_free_wk in cfg80211_pmsr_wdev_down
>> When the nl80211 socket that originated a PMSR request is closed, cfg80211_release_pmsr() sets the request's nl_portid to zero and schedules pmsr_free_wk to process the abort asynchronously. If the interface is concurrently torn down before that work runs, cfg80211_pmsr_wdev_down() calls
>> cfg80211_pmsr_process_abort() directly. However, the already- scheduled pmsr_free_wk work item remains pending and may run after the interface has been removed from the driver. This could cause the driver's abort_pmsr callback to operate on a torn-down interface, leading to undefined behavior and potential crashes.
> pmsr_free_wk work is cancelled on NETDEV_GOING_DOWN, so this makes sure wdev is still valid when it runs.
> Why isn't it sufficient?


The work can be queued after NETDEV_GOING_DOWN has already run (e.g., due to nl80211 socket close).
In that case, the pending work may still run after the interface is torn down and invoke abort_pmsr on an invalid context.
Hence the pending work must also be canceled on wdev teardown. This is a genuine issue in the existing code and needs to fixed.

>
>
> ---------------------------------------------------------------------
> A member of the Intel Corporation group of companies
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
>

