Return-Path: <linux-wireless+bounces-35022-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPE2Jorr5WnxpAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35022-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:02:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 100AD4289B1
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8248E3003414
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 09:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE94D38B124;
	Mon, 20 Apr 2026 09:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lOZbiwp+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KwWHijnB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E18530EF97
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776675715; cv=none; b=YflbBxS9UEezTwh/wgWup3gTvysxln6VpQafa67C/VqaSiR8M9EFlCeSUkmdxbRvDjK0iSudImyfHwITJy0m/jr0im3XyCZuQ7w8UgjeS1iWqcX606dhQ/swGyGF2UKi/rZRQVL0IMxYuRJ8XiWOsTdvMlmNSs9uLbuU6TvljF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776675715; c=relaxed/simple;
	bh=XjBlx0/3NGoZycxFw/nJoNp3wdG4uJWtWFq74ko0Bbw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cyZKWCxBA2Q9FcGwmFI0eXiseDPYepgE9JquMdQ4qPMv8iHymLSNFkCf5FeTX79mvRo5rFF+nS3KOVUe8m4vXO0+XtK74HVtSPWlC9sRIuNfMGBet0h4Ofg8u2lrNLXykYwmhbxX2DRUbl3vjLp7mAyjPjQMpbh58xojRHlMboE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lOZbiwp+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KwWHijnB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K79FFo1598277
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jXpWfQC/3nlIa0PY3CCKA0Zqb+tdtC+j4QsBzFxCjTM=; b=lOZbiwp+bD8IHR3R
	ge1xhYD4wT6O1TUc/LkI0y/dDjKM1oUWq38SWl7DAsGztIGYWx3XWA2XpblPRWbZ
	2Vh+Iy0z1ul/AAJzzhIWWb6A0OhVTfElOn1e94HCR9E2zFlcRTZ26Ol8kKYXels1
	Bt/UQ6GOy2NNNcbNRKV4pKiQjGSmAoevbdXA25zHPrVmQ3IxpV1ACEER7LY5Y3p5
	EO3gN4VHnCCply0lzoi9PXs7JfzCL/Y2dLnru6plM9Ndt9GVYkSrWI0PnXKmCuVw
	yVvt3B/mtEPNPal0E+2cawMXsB4Ot/kY6jubG0h9YDGPQ1M/Dcxphu5efKom4xpg
	TIX5pQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnfgngpjh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:01:53 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35da97f6a6dso2605387a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 02:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776675713; x=1777280513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jXpWfQC/3nlIa0PY3CCKA0Zqb+tdtC+j4QsBzFxCjTM=;
        b=KwWHijnBL5HY6Jht3N54W0U8jcXzwgD5I5FGzk7ZN0I9wDoScEY9jcSMhKp519O74z
         KnPZbwt6Evf23G8f0rMvpxv77Xpy0rm5l4hwrSmKN+GWF9Xx+glHu3ndGKkIjptzx1JT
         CiByj04ZB2PVc6i5CguLh99fYVtTDO4Zac616vt86+RjTYEV2JfjM4MZ8r8UGCISYoGl
         oIpHuXs2ZlvKm/c8jbKqdR4Z9BquTJhm+eyHmeAnPjOIfkISmohdTN41D9Kw1k34gFDV
         d2JkwpBRsA4ppVSySGoA41ZYKaXAWiB1UGshm0ITOI4vRlAt0qDtAvnyePeEnI8G9DZB
         HUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776675713; x=1777280513;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jXpWfQC/3nlIa0PY3CCKA0Zqb+tdtC+j4QsBzFxCjTM=;
        b=RpvFsjRLItdDQS62oiWmKs0eEtkMTEcu8X1t7WTfMJt05GH8UoUV1J1nsAKy1aPTW4
         siGJZmNSbeYMeX1WyTEDJ+SFbR4/HmW/1TgQpJr4HZLQqCeT0Si5CS08pI7V5HLJ9kE+
         h7WPTLlPQ8GtQb+lH0KC2sN4N5XPkxJkED3p15Pq5X5AXh6B6O5p/HRH+51Hoa/npqV7
         JtL+Q6v6UBAn8AkvdA+f/dNf5us+kE6uQbX6ufdLXrA6nOevc6kuQDDnK3AyHTs0IljQ
         niwfzbCNnTZLAEySJMy69qUmLZenSANgy7ylESNSzddmV4PzYZ1LrHqLZOGJs5XJzhKr
         uLdg==
X-Forwarded-Encrypted: i=1; AFNElJ+wbjRVf37E9UcVSk/IfBY9moqNNMKbrRn0NFiwmU2IT3S3X2cXZrf+NRxoOsXs79JNSBpSdJGtFp5wm4yGFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyYFmxfzrBrto4yqvMw1F+0ZUJ+hcIwn28gjBHpMJLl72v08XH
	A//fRNxjApAzF43IS8p1PNjzNVuGZfDa0WN766ODby4m4hlQuf+LGjIqkr2B4Xfq3OhCy1b4IXI
	FlMc/w34cv42VwHRwqJ0WIqwGntW0UFVB5MvfsV+9U+OXU3w5LfYdWr77zIBYCwFmNZ8cMYsjoi
	kX
X-Gm-Gg: AeBDieswBUE+tHUCVT8Gl52EPGuh2Ap2VtRbmKqFne0ooRUAVaKPrs3C93j3P3dRGDj
	Le/c0X6nZGotMu9HfMCf+Ys5NLgmQIu06Gr4VYeUbwWmftPE9Mfa1q55YEL65wimzba6zWA8yli
	oe7IJEziWDeXNBn3rK7c9BXH7zC2CVzuXN6gvXlqOwIPcXqD8xKozVF1ms7V+N5DjTqHKqb/j1I
	l4TGZmiLQvtF2b0WhIx7ZmqCqtMPcwVR2YQiVSsd3x1dZ+8NBC9/tYD1kZUUmiUr6UIUYkI+Opj
	5qzKjZpefoBg3fMtygCl1D9bM+ZNEZfYZaoJF4dzTt+/KulK1dN9bYmzR3n/2mNZRpxxOTijX7u
	0Fwyrv59z6mZbs8b6K6xCi/Bcv7sCxJyXa61yToEOHPhyHRfj1EDFmvF7X3Y64tQ=
X-Received: by 2002:a17:90b:2891:b0:359:fd9a:c50c with SMTP id 98e67ed59e1d1-361404ae963mr11879522a91.22.1776675712804;
        Mon, 20 Apr 2026 02:01:52 -0700 (PDT)
X-Received: by 2002:a17:90b:2891:b0:359:fd9a:c50c with SMTP id 98e67ed59e1d1-361404ae963mr11879495a91.22.1776675712348;
        Mon, 20 Apr 2026 02:01:52 -0700 (PDT)
Received: from [10.206.98.136] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36146ae9cd8sm7856710a91.11.2026.04.20.02.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 02:01:52 -0700 (PDT)
Message-ID: <140e6a96-1448-4a2d-98d5-8e6473dc4041@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 14:31:48 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
Subject: Re: [PATCH wireless-next v4 10/14] wifi: cfg80211: add ingress/egress
 distance thresholds for FTM
To: "Stern, Avraham" <avraham.stern@intel.com>
Cc: "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "kavita.kavita@oss.qualcomm.com" <kavita.kavita@oss.qualcomm.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <CH3PR11MB8383BE4757B5B0CA7C3AA114FF252@CH3PR11MB8383.namprd11.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <CH3PR11MB8383BE4757B5B0CA7C3AA114FF252@CH3PR11MB8383.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: dwF6STJby73TxVE6txFuRCJJROBQBA1S
X-Proofpoint-GUID: dwF6STJby73TxVE6txFuRCJJROBQBA1S
X-Authority-Analysis: v=2.4 cv=TK11jVla c=1 sm=1 tr=0 ts=69e5eb81 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=bo91ypyQ8lSpxHug4BAA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA4NiBTYWx0ZWRfXy7HxZh4GRXbN
 oFFczmtIWvslmmvSafelavYgkcAxhn6I7LEefp9rKPyThXbpgw45kA+0lPA6y/jutPsLaHxC4wS
 kGUldAjfjlWxw8xOpwAsMBOUeYdy1QfIFJmXXB/ZVBHzoa7R+3DvvxaMpHU3FoPlZbArzqvCVdZ
 c2PyxGtI7snyqDd8Fg8lCLpxQOAKFQt6+eFMfhx0DYVIULu8nEBDzo66QSBv+gl5svvIBkWdciR
 K/tMBBGAgRS6Hpnn0R/2KzG6VN0QQWIB1d7QCRMg/mQBmC3SsQQy+krRfuxxod8NpfOIxptNunW
 P1MtfwgVvCvrjd0GeUX3YG/Ysx/ipQJ3nDa05ETw58S/CZAup+LcNZnPhzeKpV0KuuGe8iC8DBp
 chDYe8IYAZQThjwzw8ke2VfS659PlXBytAyEPgpWB0rbmiLDRAUmqvMprhX0dZ6yM+OAb2rbIlG
 rfL8t0TUdz+AkhJGPfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200086
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35022-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 100AD4289B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 14-Apr-26 1:42 PM, Stern, Avraham wrote:
> + * @  <NL80211_PMSR_FTM_REQ_ATTR_INGRESS: the measurement result of the peer
> + * <	needs to be indicated in case the device moves into this range.
> + * <	(units mm, u64).
> + * @ <NL80211_PMSR_FTM_REQ_ATTR_EGRESS: the measurement result of the peer
> + * <	needs to be indicated in case the device moves out of this range.
>> + *	(units mm, u64).
> Please specify that these are optional, and what is the expected behavior if none/only one is specified.
Updated the Documentation.
> ---------------------------------------------------------------------
> A member of the Intel Corporation group of companies
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
>

