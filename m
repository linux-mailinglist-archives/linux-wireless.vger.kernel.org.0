Return-Path: <linux-wireless+bounces-36664-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEhBLc6KDGo1iwUAu9opvQ
	(envelope-from <linux-wireless+bounces-36664-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 18:07:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E26C581F47
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 18:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DA803316335
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 15:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D29633BBAD;
	Tue, 19 May 2026 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nS1c7q4f";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AgOBS08y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075B533B6CB
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779205852; cv=none; b=osSGnaUUCNphwnOAynrT0vHe6Ax3zYtbwx9CzRVQUOArQ5fO0uuhNkAavVRnXWVFbFZMFANBMhaWDZMCQdUXa71wbl73XRi4xCJG1PFJyYhiNzCuea5fOSI3O0kpGVYY6NQFucvgw86SOl40p24eJ4lijYVHRKmjmjgHm588+yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779205852; c=relaxed/simple;
	bh=Z8lKAviqAKoicyqdRLdX3xAGHXdcJy4/V8hP361cdi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oLW4ZMjU9mKAYeXPWkIjXSYPJCAqlI7hK+jnH/DpX1wfMktmC74ew4zQeMKQqPESXYnocT4Rn0QWNH5A8BlZ9aAesQ3Ofz5EStpJ5c9sDj4edJibWA5+QqeSnZVkANQUFOYaR9EyCp1/WDcFKQfqjD+LeCdIMDr5UC2foTgQtqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nS1c7q4f; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AgOBS08y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JEx5QI2868077
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 15:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vjviU8/yki0j3i02YNJGeBy6UlijAfb+iIHsVBrcFtQ=; b=nS1c7q4fRt7fKV41
	iehpP18cemYhC0ipT9ePdDPI/rBNx+JTIq7UK5Xu5YFa06AVEZpJi22wBKRrFEKW
	OadPsHhh0ENd+B0SYd+nRYLZ58/zjHH/QJ+LI0ndOQE8euHgGY8eq2Z3eFeD+7A0
	5SYCtLst/+GHr9xGK+bgGbo9XD+9tAHZYC19eXXTnu98wAKE/iMaAazoisjrURvj
	z7fVgRXTWiLAVbRqXTVmpPwmYIKqStECRAOEXX1ER/YS29ppB/zj62HXE02ffQRK
	Hioouw5dNOaofJwsTDt+aXVNPDlbTTIwyW3qoyeAa2/GEFr0q2iiHQPVlWRaUBWB
	9OdVzw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3w8883-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 15:50:50 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2f485961555so18309614eec.1
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 08:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779205849; x=1779810649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vjviU8/yki0j3i02YNJGeBy6UlijAfb+iIHsVBrcFtQ=;
        b=AgOBS08yE5QziwPuZKXtU3EB2iPoQTSQxVAuTibR2uZvbakJXgUQVpvSPv4DYtDkBw
         AEn5N4GWFe65sUTA9BFMlx2igIzAlBHQd/gS3TnnkqNGDgMHz8MeOvrDoIoXNxqfx4Ed
         0bbzo1yZHbrjd2nYcrHKCqMKeu8Ydi0C7sCzY8IXNgVoSoU/yejceZLoekCx0nm5W0DR
         y2yWk802oicHY0kjCm7DZ4kzRoNGTSOFP8E8ZXzVR8zGN6QmrKObT59RFkLpnmv2lTvn
         FxoHFbXwxhHtahk2572YBxGGWc3bZucTsEZ5YBlGKcaDdWOgQMk1RBtLrX7HifA31c8f
         nOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779205849; x=1779810649;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vjviU8/yki0j3i02YNJGeBy6UlijAfb+iIHsVBrcFtQ=;
        b=DdIEjcM54afHvveZAqC1TFhLZuef0B1pLbVw3vNsoTq/V4rqbikS5OcvmDrLPN1jXW
         J8Gu0R0Sh/dk4DFTTgoF+xGiTPYuH1W8Pd3x7+WXJWLuxDaSa35PBxKCkj4zPf8tMNbG
         q9y9B4IOKvk5zSWYgN8QP3ccGCz//cuALd85PqnixtFn+1o1+3MEPUzERXEdBaY/sZtU
         qBm8QsfILsMPNqVxK2pkvqgE0bVc8NFQVtV4IC/Ep1qPxzRHfD/ddpCdNVWUSWML6Z0F
         vOh37cPfn46TjSkCSrbg8AiChAg2S8i3cDIFoCMHtE3pJ1rqGE6a7yO5ziAHq7DM7JLT
         uuOA==
X-Forwarded-Encrypted: i=1; AFNElJ8BT5WM3HmnME1mgAAwaI+tWXOH5ojeeyUGdnaVcuksxAvN1LZnK3DQ7c7+qjD6jMJMo708o7Ip+vtliFARkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAQxBTSWyngg3ecpbfe9k3Lk9xMGDWecXTBeqvbWMqww9SqFJ7
	we74q3QrUhV/FHnR8JRBgLKbMlzC6QkatRzt9tFdoudgd07bVqKBtTVNnLC6oGmDHZBNurzt/Wk
	4+AEQ1DaXZd5KzeZCcbSFi2qPDNR/pRUujAfqiGU6Rvd0GMWQ4Wiy74bVOkNJM8oIJtng6w==
X-Gm-Gg: Acq92OGK2QbNZiYLESEYMNyijYXPIr2h4tS2jg4V2YHnM9I7p6SDga+Bh+9jIpDkgnu
	+ACGuFqDQyfXPtknyDIOzcucC9LGAZukh2Gn//WpzdaNJF6kWlDpHLd9r7lS8gM6/n/h6NykuYy
	FXt1Ou9+RmJ7VbahVvrg9ks+XAgE1XLJdSi5nFd+IkrKOx+V2bmSjE+aaZzFZfZWi6mgMiLDOSJ
	UdhK/rPbHkUuxWTS93mvLudR0MHNYUoJiClu9ZsKggUIXEgZSVzfuiuLFS7QsWqg8xjwUqPVH14
	cUFN9l1Xl7Mmk+xzoeDPirEchiw3Kb1BUmOMnMIwuG1JtiKeba59tEMeLWQ+4i1B2ASuqfoufno
	jRwrynNhun34WTmR491N5wu98cs3R/cGAwUgYZXQG17Ly2AZuHpyo4zzxr/cekSUJ3fujSsGN+q
	Tdouj21MsW7wYZAg==
X-Received: by 2002:a05:7300:5b88:b0:2d9:b466:5e19 with SMTP id 5a478bee46e88-303986011c1mr10148790eec.21.1779205849449;
        Tue, 19 May 2026 08:50:49 -0700 (PDT)
X-Received: by 2002:a05:7300:5b88:b0:2d9:b466:5e19 with SMTP id 5a478bee46e88-303986011c1mr10148758eec.21.1779205848882;
        Tue, 19 May 2026 08:50:48 -0700 (PDT)
Received: from [192.168.1.38] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30294adddaasm16403484eec.13.2026.05.19.08.50.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 08:50:48 -0700 (PDT)
Message-ID: <f2ad69a2-35da-4611-9466-eda63c264c1f@oss.qualcomm.com>
Date: Tue, 19 May 2026 08:50:47 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_ath12k=3A_QCN9274_hw2=2E0_single-band_cards_on_IPQ9?=
 =?UTF-8?Q?574_=E2=80=94_firmware_RDDM_after_WMI=5FINIT=5FCMD_=28WLAN=2EWBE?=
 =?UTF-8?B?LjEuNi0wMTI0Myk=?=
To: insalata.fresca@gmail.com, jjohnson@kernel.org, quic_rajkbhag@quicinc.com
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        quic_bqiang@quicinc.com
References: <6a0b9e39.87c5160c.1d1e38.353c@mx.google.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <6a0b9e39.87c5160c.1d1e38.353c@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE1NyBTYWx0ZWRfXxh0uQbFA+O89
 xt2bnqWtHREdtOIKox9EFh5XX6/kbqOYA3H8nR5LKNNaKI02vTBfJUg/JDyuJexJcGwvS0EjoR0
 JyU6L0m7szntV0dRgghjLQTCLFEeRZVwuGSLOAQRzVmJd7EUBCDojS5L1FvhcD/kXiWNYt2uOHS
 eHDQ91uvDgmkUvjsWflu2SRKDzh9e7LJGbSRcIezFUazNFnmEouHkxFOVG1ht4zLSQdMdJmhGcS
 WkM7Z0g7w47JjH+yPib85ebdSUhd5LrSdrzAKsNegL9kRO4LcNuMkNeQg/SSvHudWGja3IEKeX7
 dLVSlIgXpSFDsjbnbEpxlFCL17BVBm5CsnWe2QzVXOH9GfunJ8/vBXXMwrhEKh7Hs0eQaCC2VQ+
 1zSxbyr+DyyzJrqz5vQQMX4/Z/2bsd5L7N6rha/v4RtWQINLAEf8E76U6ZqeqhHmmufOqz8IJV1
 QX63h05T78N8eGjpRQQ==
X-Authority-Analysis: v=2.4 cv=Q/viJY2a c=1 sm=1 tr=0 ts=6a0c86da cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=5KLPUuaC_9wA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=bC-a23v3AAAA:8 a=TD6mGIVpAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=5r-N1VMzM78MpTgf-BoA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=V7iCuLqznmuTtf2Pv1nF:22
X-Proofpoint-GUID: aVisHuFRsMjeRCZiN9B11C_lOvcktazc
X-Proofpoint-ORIG-GUID: aVisHuFRsMjeRCZiN9B11C_lOvcktazc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190157
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,quicinc.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36664-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1E26C581F47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/18/2026 4:18 PM, insalata.fresca@gmail.com wrote:
> Fix B -- DMA ring capability parser must tolerate unknown module IDs:
> 
>   Without: "Invalid module id 3" -> "failed to parse tlv -22" -> WMI ready timeout
>   Cause  : WBE.1.6 sends capability entries for module_id 3 (and possibly
>            others) the host enum does not know. ath12k_dp_get_ring_num()
>            returns -EINVAL for unknown IDs, breaking TLV parsing entirely.
>   Fix    : warn-and-skip on unknown module_id instead of returning -EINVAL.

There is already a public patch for this issue:
https://patch.msgid.link/20260505172415.566328-3-nazar@mokrynskyi.com

I've pinged the development team to look at the other issues.

What would be best is if you could create a Bugzilla ticket for tracking.
https://wireless.docs.kernel.org/en/latest/en/users/drivers/ath12k/bugreport.html

/jeff

