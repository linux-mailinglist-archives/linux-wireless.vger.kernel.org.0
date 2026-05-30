Return-Path: <linux-wireless+bounces-37178-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHCfHP0gG2qu/QgAu9opvQ
	(envelope-from <linux-wireless+bounces-37178-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 19:40:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA4C61027B
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 19:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C7AC302AEE9
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 17:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9893BF676;
	Sat, 30 May 2026 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i5ipaRNY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i2nwN07w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AE23BE175
	for <linux-wireless@vger.kernel.org>; Sat, 30 May 2026 17:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780162671; cv=none; b=m/7+Xox/wqubqgwqYE6bNDinLzcm/7OFweIscFSuda2NEdIIK9T+7P3/QaHRkkhR/VHczExy+G3Ja2ZlB41tQPyc+v8j5gdEY785xIehC4lSjDIccZ3qYEQYXpJDAFvCJi7Ty2rAvDLvnnUsi4vNwCcSEvgW/+QmYYabEwQWeds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780162671; c=relaxed/simple;
	bh=CClcWYWefXJz1TGr8gJYERltJnjvvEJlgyxAfvko/xQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BYlpT88Df7LDVnCEIrCZoVpjCI/pxBqa0j5QDu0E3o3Af8Ri/sepMEmsFUuRt+sGN0U20BkOsFs4XOY2jovlvgudUU2D2HyHeeN6a0apYL1DTouUTnKVmcSXhO9mZLUzP6PtykCOkrjgZLglE4lPHYDsSJUPTlX0OCjS3R8Ungk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i5ipaRNY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i2nwN07w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64UEOQK13468227
	for <linux-wireless@vger.kernel.org>; Sat, 30 May 2026 17:37:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1uRD66FKDWLNiktBxoDeBLGm6tf0fhPc9ZoqTh6hw3A=; b=i5ipaRNYH/QvV2Oj
	2DLEIFDVVm0KAyTGUhBYSy8ORGG/iTnbDk2+U5+ksK+wPL8je+6kdR98DiLOK5Ws
	lr1l7J0+FLsWvyvcPyQWgeh3VnnnWgLcNy2kjLD6WLa6aFahd/5Bsndko/Wo+0/Y
	KTTPNst23YKeBmHbWLMf4b/5jABqU6vlO1b2oln4Tk80I592N/25egtBNYJ2Zl/w
	nNjHFUnb3GZtGiB7nGE2jIQFHDcB550YnbAnffejTnDPn3H+pd4Z+0a4JjbDwkmM
	DK0GM5HN27xKVWZg2AaWo+zKt0tZAcvBDfishEcsOK1BXriC+2/B/oAPdbQY4abW
	1baPiQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efr989gdj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 30 May 2026 17:37:49 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0c32f4b1bso435455ad.2
        for <linux-wireless@vger.kernel.org>; Sat, 30 May 2026 10:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780162668; x=1780767468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1uRD66FKDWLNiktBxoDeBLGm6tf0fhPc9ZoqTh6hw3A=;
        b=i2nwN07wJY+ycLUf89f3ILRNdcQDtXArWKCSgNn0hFGoPnB9cAtU94yzi7ysiD24hu
         kL5PUWvUnJHtaQek3YDfFekjP/zIaG4IXEnKEP0J+TwGwiVWMCWvtUjdhVom6ap8/E2g
         9Gp63+eK/e/vqyc1Mk4fhvfHhNU/OFhJPIUsxh9S3evVRC1VcmVvMsYzAG+43SBk3eRi
         Ki5yPFTfjQ3qCqXdo/LlNo1sjCpd6RU+3HjlHTXhv/E8oMpHC1QO8sI4wdzkPucDeILN
         hXNMiXJZPWdEWvJ3Yx2v9qq5snGBTvORXqrqNqyctHwleVqIRSU/+0F5U1XbRS4LluG/
         mqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780162668; x=1780767468;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1uRD66FKDWLNiktBxoDeBLGm6tf0fhPc9ZoqTh6hw3A=;
        b=a1U0omkxPfBqNDKL9o2nWrNxlRA3ABbKmBEneeBwS4ISDx0TSh/y2vpGV8Y+4xknhg
         3gJY6n28jDlxW4SzSNpweNcXa1QVpI+afBDzwar8YlswqY2ZEuWepHpv8QzOF5JoJ3YH
         liN6zjdgogInmsBnuZbbebJthoy57M02Qf39dC/mc+jBK9mi7S93IhYIP0F/GfDGzN5B
         arLcR9EvpARfodnAyU0DBRi8nX6YGOQm6uDUfCMJpzCUTgKAXc69wGageWomN5FQ8a/Z
         x/QDOGy9tbkOYFt90buyDYVbmxK+QTEZrNPzXL1P0wWtr0H5FlezbdvFCvE7waryzkiM
         2tcQ==
X-Forwarded-Encrypted: i=1; AFNElJ+yjBQCzdBG3zGM8KC/0ijYOsZeYeulqB9mxbMTjDksFDzYwHs0o7pYJG6DffWmHuJUaFMftKSNTTM9YmG7qA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBTJiRP9On1B0fiU8G9plvWJp9QxG58HimJsFC8sCxdu69j8BF
	jpX7EC9HHpLv+uQvLIrkZMPxkUYUg6MKOxr9y1WsEN7tQ3YsiF0NvDyAa3UNvU84DlQT4PTDpRT
	WoNhJFvRUYSOH7w071dwWTC4EoxZ9UO+nUlGUI7UZtLs8/ldCFYdnbZ4BbiZ5qDptZ2ccsgJ+fc
	5iNg==
X-Gm-Gg: Acq92OHQ1hHEIXYzUHW0C/1ya7bQTl5x9MGpq7mAJFPoVl5zOq0drzRxzkDrgl8F9xq
	eQryVO/ogQvmvZeNMSdqogWkCYWa1z3ihSnf9hDjQZ2WJWuk7VtF8DXMmXGW922/D6NNFiHkitl
	a3aEREEjiHdlz8r7cen9G73QQEscNJeGs3Kq+RB+0BgrI5Z69tIji/M8Lo/0QuCuuCjU3nrE+ND
	k5M3GtEHgscZ+4FLnLtfuT9dcnB9QSnfUrFjrIj8kdsJ+ayGnZlgHyZdsvPHWCQS12i/3rPFVCy
	log9ha2zAVAxecsMxLI3OqHZGyT4yVGrRTO1HpfTHtBT+BY5nglW6b5rjSKX1vUsvUKQOk1316T
	JWUBA8hwBMk4mbuRsaMdF7+WeYEW384/yFmLTYJSCGWk08IWGCnsRZpY6pxQMS7YqFEXQML0G1s
	mu
X-Received: by 2002:a17:903:244d:b0:2bd:c310:f7c9 with SMTP id d9443c01a7336-2bf367b2353mr56429835ad.2.1780162668049;
        Sat, 30 May 2026 10:37:48 -0700 (PDT)
X-Received: by 2002:a17:903:244d:b0:2bd:c310:f7c9 with SMTP id d9443c01a7336-2bf367b2353mr56429675ad.2.1780162667589;
        Sat, 30 May 2026 10:37:47 -0700 (PDT)
Received: from [192.168.11.104] ([124.123.82.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239fd7bfsm53050615ad.19.2026.05.30.10.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2026 10:37:47 -0700 (PDT)
Message-ID: <6904229c-0de5-4e91-a532-80d9d0336793@oss.qualcomm.com>
Date: Sat, 30 May 2026 23:07:43 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: fix NULL deref when MLO link
 activation fails
To: Wei Zhang <wei.zhang@oss.qualcomm.com>, jeff.johnson@oss.qualcomm.com
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260512044906.1735821-1-wei.zhang@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260512044906.1735821-1-wei.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BaDoFLt2 c=1 sm=1 tr=0 ts=6a1b206d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZCREz13nqshT/on6E9YcPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Bf6z4bKntrc-jtSRWE8A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: yfxDIaRcOAxIUd0RlYASHJYB4o90pv-i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMwMDE5MCBTYWx0ZWRfXxbBqhZ34HEPo
 QnG4Bdvd3PgWIPIbR9btFqR5ffjticCfPH0FMbILlfRSxYzbuI3L5dZb6u4ucTo4dGYa2lE35/R
 fPvLR+ihQz1MesNkL+SZI6A4PHMcqDCJs/K8nGoPjB9HdSytoCaw5YvtPfhDzfcCHjg2G4GY98a
 LIRWkqyIyVynkWbOaZ93fuI9xWdf+easEuSVB9moOiNj7AMrkPM9rl+D990ZJp02ITIHdI9i6qC
 uA+Tw1WE/lrF7voSrniRZxpJe+bGFtufx1b/QoCGGt01GXdNDnUKPiUEta5Y3LLDaniB3FizLhC
 Gf9O2t0EoTJqYEluCuANTXQTI2BTjIsJN2Pdxvti/XCmt9CBLmRbCCCbMSIHOoQRqIbgmUIlekm
 RUDbTYjMlnKWEt6OLqSmRpMu2UMyNcU1BzmCleWsk472P01hWgKflqTkZmZZpE2F4H/ggphs0kr
 +lPeFdgaUYnVnXjwYzg==
X-Proofpoint-ORIG-GUID: yfxDIaRcOAxIUd0RlYASHJYB4o90pv-i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-30_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605300190
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37178-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8FA4C61027B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/12/2026 10:19 AM, Wei Zhang wrote:
> ath12k_mac_op_change_sta_links() adds a link to ahsta->links_map
> before verifying that the link's vdev is ready, allowing broken links
> to be processed by subsequent operations and causing NULL dereferences.
> 
> Patch 1 fixes three error path inconsistencies in ath12k_mac_vdev_create()
> that leave arvif state or vdev resources inconsistent: a direct return on
> wmi_vdev_create failure bypasses err: which clears arvif->ar; and both
> failure paths in err_peer_del skip the DP peer cleanup and vdev rollback.
> 
> Patch 2 uses arvif->is_created (made reliable by patch 1) to guard
> against links with no vdev before allocating a link station, preventing
> broken links from entering links_map.
> 
> Wei Zhang (2):
>    wifi: ath12k: fix inconsistent arvif state in vdev_create error paths
>    wifi: ath12k: fix NULL deref in change_sta_links for unready link
> 
>   drivers/net/wireless/ath/ath12k/mac.c | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)
> 
> base-commit: 7b25796f571fc09a7aa6fe7efb23edccd326917d

Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

