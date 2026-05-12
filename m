Return-Path: <linux-wireless+bounces-36284-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEjgHquZAmpyuwEAu9opvQ
	(envelope-from <linux-wireless+bounces-36284-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 05:08:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7375192B1
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 05:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6EEE303CC3C
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 03:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255481FC101;
	Tue, 12 May 2026 03:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cocKDdfc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YCkZ7W21"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC013016FC
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 03:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778555167; cv=none; b=jt6KcrgACHSwFhcR8TueOLHYyJi950jgp2ucHW+ngVv+K2DsVijhrZ3WuJBb8yNxyqXyXVmEh5ntBWYgiQLch7fqhEl5VnZ6q07Ua+458E0y+FnXw+L334w3oEb2RHzD0tF9TNd79bkiBd9KIzY8XOIaS6ehk69cKsqbCXdVRno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778555167; c=relaxed/simple;
	bh=T+jUrj3UmzoKo2y8qFCAjgZO4+nKMRDT9xq1V7ZQjvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gDfJSkhTp+2xD4us3/UBFF3yTIZvZXYWQBF7MPWhJmWOtOJj3HGZD4vAuDIyOvONaTF0Z9Iiv0dppqmZS6pQmO8/1mxRKylGEbT73/07AYmXHKVmtw1JSEKEVMmwZ9F5NFQH8daI9/z/9q2EGPjiOON4cz/ASYb37RUnPeiJE1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cocKDdfc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YCkZ7W21; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK6fPG2519063
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 03:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Oh3nvFiz423tHsaXjpNyatcW4vupHb/Nckh8n2Gl3sg=; b=cocKDdfcPRa3jj4H
	G9vsRupw4ZWEhq/Su7THwWfapVJTBeBI2+wZIoBFNZ8mx6aJJMHq05dRWI1MRPNG
	9ytTv4yRMX5BaxVZZznVmuyc9xdwntUkIlPXwov6fx6e8dzQdxP3DuN5fTy0exSz
	0YyzEjBsWYjXYf9Au04YCVrqOhD9bTv+1v39IcUpzvOxD4xI5YsMT+7C5m24TK7y
	s9ZQdtraVHhTfBShQRWsxHKrOb8AlBMcDlEQvxzb3ln/aflw68CrDlCb73KOJnFe
	uG6bq0T8HW5ywSFy2yfmprqu16vrFmwQ5SNiA5bS4a/nDPHwpzXuWs4TfrV7ae7X
	YVdmow==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv1h72b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 03:06:03 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c827ee34adbso997346a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 20:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778555163; x=1779159963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oh3nvFiz423tHsaXjpNyatcW4vupHb/Nckh8n2Gl3sg=;
        b=YCkZ7W21zKQ5CifzhybciU70F+isVeZ8ajzmhoLG5YCU0zrJcXQoY3HpC87LXG7MRS
         2COAG+8BcbYoCJHye2/uoczlTPPBQIowCt0ZpO0hLS7IhXmf+W3yHGzTksKU4ColGUp4
         H3POY9EKZLCsot1UM6ssR0rK+Y4Q6hZsnFz6pxg1DeM8voYv1boo9EZq5egpFUxUdiIo
         1gjxp1oTFRlLRdIHUe1SP3xxs4xjv6iVA127cRnjC2qnqbEMkOghkwJVT8jPeOBP+l3U
         HI43e/vdwb5L1Yt54pRd0V3iF7/fEkIpKq2ZQaCO8zuNtWcLA+/vrBQycRwLgzMzVBOA
         AVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778555163; x=1779159963;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oh3nvFiz423tHsaXjpNyatcW4vupHb/Nckh8n2Gl3sg=;
        b=QPK1KTz58ony8IF+paERoknRHkEQXaHpt+AfslsPCc9pfw4qn2uOlCeKTkhWZkkdMw
         Shkw4/DNu1nMhN2Kj0D8pH0qmJOd1s88JzeNuNFo906wdn95RyaV1UHSJ8LD923Gvr4y
         +HyoK11LDcktkP6G8x5wAKOkCr/WQTbw83Io3i0XHDb7pp7vKkM+ldavSSH6HzbUlq0z
         TkJ7J+toyl1dMHCEB4cDn5zXod4rI6PI921BJ8xy4V3aaxeAupIV96weFA6YVuXIbflW
         LPoqd8LSWuOyq/PYzTyjme6zY9NaMZ6DO8dZbekj0UG8GhodH5lxGm1UaUYuMt9WOa6h
         HRWA==
X-Gm-Message-State: AOJu0YxgQDXIo58QbH5NSh+aP6p0cqTcuf1ddEneplPFFu8VfwyD+JyI
	M0r2HNSiTcBprswS1r3j5mFXiCNoydLQ1HUsVSi1eRSbClufYrbKeqOqmb3luGkUy4Z9Z9VCGwa
	4zmvBAwquRuShVJQw7Jc+STQLzdqPy69QggTjl6zyI/8v7kM8LlkXHnhGzo7ZSWEiIO1aFA==
X-Gm-Gg: Acq92OEyp79z5VRorszrsBUMStG0BQcLgUK+/ysKk3ZAv3ZeK66KJeVSaT/8K4y81L1
	p7eQQu2ybG5t+06HUy5FBvzo78cjZDThFMK9Xye8me6tmof+6SlzlLCr3A/WspepcCK9Qh1oY0W
	C8jkZP4K28Wq590zijsYUIC9Y4JC+98s5A1qbkzvK5MqG3tVffYhtSpkYB5tGdGotrozewYoQ4F
	9zttnSRn5GzaCpcmhAN5B0hWU3O3bNNU9aQuADn95ZKD4J12Ig7OJTT+KZdIfqOXnmU32WYdiV7
	SN4mXUn/o/a3wr5mRQG7iU0BRBXmrtHNWtRcWNBRGRn2Z/Y6N1z53CLDnEhKHXSrUtAajtxj798
	xORF8gwNshp/k1J0ojbk6rchpeiozWG6kmn6TY3xEEjH/mD899wFfp5Ed6yHsxCbBK+xT9fvbxZ
	krHHZBQcQrCNq0EfmEDZA=
X-Received: by 2002:a05:6a00:3d01:b0:82d:556b:7a01 with SMTP id d2e1a72fcca58-83cf5846bf7mr17634954b3a.16.1778555162796;
        Mon, 11 May 2026 20:06:02 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d01:b0:82d:556b:7a01 with SMTP id d2e1a72fcca58-83cf5846bf7mr17634622b3a.16.1778555157387;
        Mon, 11 May 2026 20:05:57 -0700 (PDT)
Received: from [10.133.33.178] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbee14sm29115974b3a.48.2026.05.11.20.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 20:05:57 -0700 (PDT)
Message-ID: <a4247f76-4724-4c35-926d-5b03e756d8d4@oss.qualcomm.com>
Date: Tue, 12 May 2026 11:05:53 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: fix use after free in
 ath11k_dp_rx_msdu_coalesce.
To: Willmar Knikker <willmar@met-dubbel-l.nl>, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <20260505171709.547274-1-willmar@met-dubbel-l.nl>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260505171709.547274-1-willmar@met-dubbel-l.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: mMvXdnXamlyI6YKoEXtJlyjJ0OVkaGKv
X-Proofpoint-ORIG-GUID: mMvXdnXamlyI6YKoEXtJlyjJ0OVkaGKv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAyNiBTYWx0ZWRfX72TnsXlbsLZw
 9+2kmj/LoQWaGrzh7myYV/jK6CdNrxyJgJCHu1fO+GJxe5uNMoMmDBFNpWuzwNY2zXLb03mHbPc
 A3Amzn6S+I1364VOgTWpYwWBArB5UZJLtVNgwv3/kV/I2mCAPDTM4lH9aAc9Q7xQCoSukFx4wxW
 q3SnHvxr0BYR84vjLsqNr+iKKG/840igy6kt1+JLGa+pss2c448PP9iWDnR6WhDSpXf7IhUYEJe
 P3Uo9wJfwpbx7SUa/Jo1dXjY8ttzlilk0/0Eb2RxY/kFRrcrAjSNy/D4E6O82QopCzgs/6N61ES
 Uv/NX8VweuGS8UzV9yS0b09dnaPwsEMzHRmlsZQOUtrdQpgiM+EV4hWHWE0/16XH90wYO2GlOfu
 I5TG6OJ/JBOJoxZof8qGg8oUGHQ24vn6hKk4eySskZJDCsRFXgsNpmSaugfItfU0PzocWXkt4cK
 o3JHlDaSOsrWC9pVshg==
X-Authority-Analysis: v=2.4 cv=c6ebhx9l c=1 sm=1 tr=0 ts=6a02991b cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=9B1uR9gGAAAA:8 a=EUspDBNiAAAA:8 a=ljBxYmjjx4en0H8xEuoA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=8R3p93Tjo66ouot214C2:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120026
X-Rspamd-Queue-Id: CC7375192B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36284-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On 5/6/2026 1:17 AM, Willmar Knikker wrote:
> In ath11k_dp_rx_msdu_coalesce the loop uses ->is_continuation after
> the dev_kfree_skb_any. This can cause a use after free kfence.
> 
> Use flag for caching is_continuation for use after the
> dev_kfree_skb_any.
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Willmar Knikker <willmar@met-dubbel-l.nl>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


