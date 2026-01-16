Return-Path: <linux-wireless+bounces-30890-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AC3D29999
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7DD3830124EE
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C99333729;
	Fri, 16 Jan 2026 01:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K54VTYsL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y8A+gHEa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2D832720C
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768526829; cv=none; b=bhS+E0TUpUuJgmxBnnx44CMLfc7rkoJTW5M2++jda6yCh2Igai9eqzTBAe8920PI1HHGD8Ic6K5ozUYicHUH9sdILpV2aGRarfarvUlWAhDTi1N6HUek107XC9TmlJmPZk6AJIqwZVZI5trpbjlUWdyVL5wE0IP7vrQgYOvv7f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768526829; c=relaxed/simple;
	bh=BHd9r/1Lj+G2DiQb0ezRYaSoGe7Ek2N/T5HH1B1+moQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rM7p2BALmjX6mRBZRg1fQlLmT37LSEZ49xquZ/SIdNtkWDOvHw4qJjZtYMXCXyQzuFb/fOfzjTRD0Nh2bqf07pzRLnVfkWu0u1npWcoXnhhnCM2olIb8x+KeAZUpJnMYWZShehzxJpsxr8S2aVa+CFTlJbuZve6szewZKM2yOBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K54VTYsL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y8A+gHEa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FMbiYG3596966
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5sacRkm3uELFuIRaM7IQCM7vn2zP/LGcG5+YS6Kv3CQ=; b=K54VTYsL1A4n4KuP
	YqhLzwzMdT2pzbufJeseRgfO1xj4EpWn8nmAbRkIqnU954KpNIwKouUc8iYgnsN4
	zjjfCECLYZsUsnwql/qqGyEoqtFNLU3PNF3EUdQnRfBVG4KZKG2JGoxjTdCHlHVZ
	wEg/qMqAWU/w5yXY7gOJjreP0129KQbQGZ4t0KNijChhF2zzOJ7KZM5TYFhFYtOa
	0JzE7s1XYq+epFKgrj181nxAXmO3VLFSmAavNWVakQw2Ju7redXOOJukdz0gq/sy
	2qEf5NUrigCdhQTCqqtBsdSX9v4YPU3Qu6pLnmSGvihK5mJzvHykkOHtOmIGuUBa
	JeR8qQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq96rrb6d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:48 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2ae29a21e7eso1710944eec.0
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768526808; x=1769131608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sacRkm3uELFuIRaM7IQCM7vn2zP/LGcG5+YS6Kv3CQ=;
        b=Y8A+gHEaIC/UCurbyhoM7Ulc8uk25Mb5DJLwFeMvfvz+FAb6kEik0ktNI3kgj8LMCP
         H1OdZ7oeUGtIVnFrxCsgvFa96Ikt/c8nrrRC8KinrtIk1gPr2HHXYy2rUEzDm3s7WNXF
         OJKmC3S6slYLee/e8mC7MpUEd9ABzvnMOHCBJuT4BvF2SrGtQcU8hvZ3sIQN7+NQq3Xo
         706VASMWkRTz0J3tOiXaRWcAVlklhmP9LM+JaK//jvl3f1Bf07/I8x/HLKrafAcwodT9
         mgIQNDHpolVreaKXqHjGQuxrojnMtKgtRM9ExSYh2ru3LiD9FokeMQYOCpVF+hX8hnx6
         jY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768526808; x=1769131608;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5sacRkm3uELFuIRaM7IQCM7vn2zP/LGcG5+YS6Kv3CQ=;
        b=mvA5Hysr0pXL34iUoWxsxA69xyLRVGWpCYlBpZLY8Ep37CPMkScHmPNOEwDejS3PNA
         DjYa+koW+UtzIHv03Hshx2vDrbAiFc4CPahd/0BKW/x93wjaxLH/u2TU3rnDk0Ea1UST
         B3ilhEr4REjZGcVNwxDR+ZuhwY+/TKIT8PLL+hpM2M/i+k+vjR40NvBt9L90tLBRPn3T
         UUf08R45QlpagFLMULNN+ltjfqDB6hXgff9pd9WzCQb0LAq3wYZMlPMRUFvk4xa+YTgc
         OXDJ38DeSuso4gjCDuGajALMQDX23Wu9oNiQajCo+F7b49PimKmpnRdDUSVE2UCch5JM
         1Jlg==
X-Gm-Message-State: AOJu0Ywo4wpKOWFQIc01L0JYNJ5pSFsLZUCa2CMQg4cprzWVOw13LsYa
	rEQqlVNSQ49q8s18E8ki7P7WM8s172LWm2W/FT5V+ajlc/pp9sTA2NtIhslkDpm0IUJabtpOMEc
	Xyj/+akhAbsdG+wARCrFFO+wrFO49ELBEDPFsSSvtaOsnvM4o44eQWcQmVmE/llAj15mtFg==
X-Gm-Gg: AY/fxX6legMubmXX9B9jN4bvaQL0Abc9jlq79lF/mheyK0y5OLMboJg9+k3oSXHRP2h
	ax4hs2zZKLXjzCW8Ctlg67rr2BpI/6iYEnBCnWM+gG7DL57Nc7cfFuizCYiJgFWcNVV2EAsNkoX
	Ag9NIiQ8Fp/ekkGhqGOiLvq+oVM+8AuPXzM9EmQGAy0m918IqH8xTiJCtsxnhk1M33aph47iTWv
	0cqG6GJiqmtj1tjB4d7YZjqPjC8krqVAbdc8mO+JVKnTGyOEY54TJdeQMHP11z2Jr1uHApPPRNY
	oSAZOuDVg/56nv+dALvzvkihbK/5Bx+sQMBHpUAID3atH7D/tqsSVp3rL1sCcTt0ZRR6qsulA3T
	xFJAzV+q1uexQ/4ClfGkFS9dJDP9SQf6Ig+0JNgi74F8wb8+os0ujtNKyusUCiiSv
X-Received: by 2002:a05:7300:ec08:b0:2ae:5b9b:c060 with SMTP id 5a478bee46e88-2b6b349a9a8mr1303154eec.6.1768526807441;
        Thu, 15 Jan 2026 17:26:47 -0800 (PST)
X-Received: by 2002:a05:7300:ec08:b0:2ae:5b9b:c060 with SMTP id 5a478bee46e88-2b6b349a9a8mr1303141eec.6.1768526806718;
        Thu, 15 Jan 2026 17:26:46 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm884104eec.9.2026.01.15.17.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:26:46 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath11k@lists.infradead.org, Qian Zhang <qian.zhang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260108034607.812885-1-qian.zhang@oss.qualcomm.com>
References: <20260108034607.812885-1-qian.zhang@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v2] wifi: ath11k: Fix failure to connect to a
 6 GHz AP
Message-Id: <176852680628.1143034.11034029049745155989.b4-ty@oss.qualcomm.com>
Date: Thu, 15 Jan 2026 17:26:46 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDAxMCBTYWx0ZWRfXzEXxP8N2Rimu
 7iGPnwMUkhDTyzMUJvIfOblkS0MKbAxabkU2mRIYwIxyZX0Jarooaa4LAtynzbn36k5jVo7XS3M
 PrkU4suoVpz+kJ0Pw8kkAWXJJtZKd3n1NLE1IRmFR9jq4UtIQTvn7szoz8f8UgY14slsEWk8n/p
 t9QnSUVbwaG9r6+wLjJ8AZBhIrHwdrQ+NgPQkG/eulcyoyuP3UNMd1SfWEigRMYV2vwOyOHHqxm
 /QSjFJysz2rznjoUOyypJASxYS5pO/mX+qZ4SH/F1KGegeAMkGUNU/10zURswOLQNIkP69YmVdO
 a21MnE4YE5hUifz0P2lBERpjRgyoFYa9wbNB2o7JiZ7JTXWc46vVgG9DqVLw+uk07Xp8xbW7SuK
 dmtBw/X967U8NuoExYnsA5MHBQBCMbpW/xkaYcmwUCge7mVtrg7RtJZZcoCVinfO3uVBM9sK3mw
 MP5/6XvK6Fq7HqovJTw==
X-Proofpoint-ORIG-GUID: jm1SlCzFWwtrQOGXSsiE3Qq4CJGK-2S4
X-Proofpoint-GUID: jm1SlCzFWwtrQOGXSsiE3Qq4CJGK-2S4
X-Authority-Analysis: v=2.4 cv=TsTrRTXh c=1 sm=1 tr=0 ts=696993d8 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=uHwbLgxxtvURWPBYDoAA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_01,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601160010


On Thu, 08 Jan 2026 11:46:07 +0800, Qian Zhang wrote:
> STA fails to connect to a 6 GHz AP with the following errors:
>  ath11k_pci 0000:01:00.0: failed to handle chan list with power type 1
>  wlp1s0: deauthenticating from c8:a3:e8:dd:41:e3 by local choice (Reason: 3=DEAUTH_LEAVING)
> 
> ath11k_reg_handle_chan_list() treats the update as redundant and
> returns -EINVAL. That causes the connection attempt to fail.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: Fix failure to connect to a 6 GHz AP
      commit: 0bc8c48de6f06c0cac52dde024ffda4433de6234

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


