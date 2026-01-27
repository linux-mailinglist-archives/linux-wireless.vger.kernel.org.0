Return-Path: <linux-wireless+bounces-31240-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNOCJpn2eGnYuAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31240-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 18:32:09 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E20C498797
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 18:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DEC13036ED0
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 17:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34B430ACF6;
	Tue, 27 Jan 2026 17:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D9fkkSqV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D320VSyT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509B1221F39
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 17:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769535117; cv=none; b=L8iGiVX6c7GT1vDu1sC2joKLSXHsS4zuHiyGsTidm6oBxItMgGRrsFzS0Ka+HIqGfMltTPL3WvlrcNp6IWcyNTLRcP9B4yey4QOKjWmi4IROBopF+7QhjtvrHyl6WWyGcEDfpHdaf3OPpsgiXRaRyTdfQGu89WMirwXbaXeWWtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769535117; c=relaxed/simple;
	bh=sJM3dQkRhFtYUQBc5hx9GDtuCQPPDc99urCjAvY3avU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ihqQ7sgxRDYjGNQGvNqda5Fq7z+Cah9PkIjpTBn1yblpc/lyt7xcKOAXOrpMsq7fgsE8bWpiv6Dirq1La9jd2BPUM9ZC8L9wFIa3P2XEi79VBT7Wq9KX7eztvRtpOUdPkg/3CZcBa6CTwtjrv1S9CliOKRit8dsdJm2W7gWSX5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D9fkkSqV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D320VSyT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RH1rdV1334211
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 17:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OIoUAWMTJE5rpivtR3W6H7oj3d6jWxH+8YOVX25OZr4=; b=D9fkkSqVE3eV4UlG
	MGHnrILEzSAsWdT3eG0y2kd+fJVmRLOzstpOrq7Y/fE9x3PtLxmImHv40BvwEQ/Q
	jV9gLDs/P8G956dO37G/p49LkgSSnfWcfEhuBWUGk2WAwBFgEZyQg9l0SpWNsQ+n
	iDA2mIGTE0ayZr9T/vz578I2IFp837fbIRyTJRfEAEHcpSwm1bgANKFIlQMZUoMT
	ob7xqBAdKGhl2hn5NLpWIGjsOaEhzocsQ7f/TIT9AhwXI86+gfYpem/RrFNeZTWY
	L9f1yteD6+gq5DbtWbfBmc+NASmpCzGvywS8ERS9QndYOYyxQFbUW2gEMQOHjzkX
	cf14lA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by1dfr3ee-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 17:31:55 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2b74766fae7so4707807eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 09:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769535114; x=1770139914; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OIoUAWMTJE5rpivtR3W6H7oj3d6jWxH+8YOVX25OZr4=;
        b=D320VSyT2X7tGfI0GdwbI8H55uqW090fbubA4yg4n1HXArlixWFIkjWHWpmMR75QCK
         BCSHISMtB1KU63G1OlFZWCdHmRi8XnCUDQByV9i5nwDFylTntDQY5+R5MazhsNwDkSTt
         0+1wo1jmtmyS4AWlY7eVNsXn849ouXCoh7w73bcb4z95m3hV3WbZ7jIQpw+UB8jVEOnj
         JqRDMc1BemUqQ1AvBybBtOfn88+HRxMoMeLjQkLktdE6ZbkQXBZKgAJy/rAY7srjQUG8
         dC4sJnhXRAHTSL2h6hiLFMfeqenBx90vbbVBaIOo36VSeiFyJbVYn+3FFtpkH9DdA/Rc
         lqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769535114; x=1770139914;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OIoUAWMTJE5rpivtR3W6H7oj3d6jWxH+8YOVX25OZr4=;
        b=PqUfpMBU18wRvYJCVgYLVAGCWPK1kk3ADHO1AzVJ9edf1i5WofSNCzoZ5B4EaAllUp
         /NIEUHLzV7e513a690b5pHbpevzY7IwZWjvqILg9z6DN9o/kENt29XqS3DVeI973N1Jh
         grco6XN6rVKo/LmJTwWGG7YzhXbWvYmcZnzHW1Zdq/ZGctF0Y05S4PMzsQ0hrkmISus4
         XtK75vowCwI6HyUFzTEzsyjFB6K8jIhXeNsbSHHLKxjxlT1t3SAuY5gzfffwiTtHXKQH
         Yu5KiL2uKEZvqHyo0x7Uulao6MEICWzx8VpClroxo4/LbjBvqGPHd3aQaBQgvINEc+R7
         p9Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWIMEH5++yWAtQLX+pKHhodILfs5HVLhTN45Rh7DqV82mtvqt+BjIK4frLD/42ukWfLtRiV+IzRIEtdzNIbag==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCQMeU87mivKTGFWvkF9r/3jGpm+qKM6213Ez0XZDBkz1LiZU+
	pl0etFUqouyZ5m8mgZZaNgB/5jsAoY3hfLZ6lpJBukxWWk+cModLhuIA0042KpZ3FL08qLiuKF9
	ypdzXtrYQFqVTDEjueSJx+3IriT+NJxKC+hu6lDG47vMWqiNWn92rXY60Q0yTP8auQCYhUw==
X-Gm-Gg: AZuq6aJcluRGA/3VTLT9Bgn8f+G/6Plp7HVZdlDF9fpYA9q5PvwJI5CZRH6NRNgfYyV
	HAF5wMhmsSn/bVU9tYGSiYVvw7XczMq8KHpms0+vx4z5/luufT1doSTI/eUJyzNGCWLhUweLRQm
	ZCpeZYUSvGLzUqhOKSn3Lyy/Fbvn/+2DLAnOhqTBGDJPZ55N1IDIaLPAO/Hic9X4fudTjnLEpv1
	59ljLs4MXvF0vKUmXEzHmBIgbvFdiF4fH4mekzoe5FJHrJiU+236TDO3YvUbYEHgbIpU492Lu7z
	oPSf0D7qp9IccT3d97VezZga0fjb5ryPLuIBIybfpOBq6ZbDZ2/D4ImOlkD7iTMXPNZdj9z5hTp
	UY0IuliZ/4xCO0zyTAyxtLqJYvqbcFprYfPPmgZEkabz58fFFHcDsMsstJ2AkKE8gGzOujQ==
X-Received: by 2002:a05:7022:6286:b0:11b:9386:a37d with SMTP id a92af1059eb24-124a00e8ae7mr1238394c88.44.1769535113968;
        Tue, 27 Jan 2026 09:31:53 -0800 (PST)
X-Received: by 2002:a05:7022:6286:b0:11b:9386:a37d with SMTP id a92af1059eb24-124a00e8ae7mr1238370c88.44.1769535113332;
        Tue, 27 Jan 2026 09:31:53 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a7c73c7csm287709c88.13.2026.01.27.09.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 09:31:53 -0800 (PST)
Message-ID: <74176aab-03d4-4095-890d-7ef1739b914b@oss.qualcomm.com>
Date: Tue, 27 Jan 2026 09:31:51 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 ath-current 0/2] wifi: ath11k: add usecase firmware
 handling based on device compatible
To: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>, jjohnson@kernel.org,
        johannes@sipsolutions.net, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, krzk@kernel.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jonas.gorski@gmail.com
References: <20260121095055.3683957-1-miaoqing.pan@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <20260121095055.3683957-1-miaoqing.pan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE0MiBTYWx0ZWRfX144cTChXa9Zi
 onr+k/+TXiQ6xPAA0nHz0EOkCM2/5tNiqBu5sep7+foCKaNTEIdfovQaOZ1KMhfJi2TIZ1/LeEE
 pg/AxulBHa831Xnmw9qT7gcx/jwGsEuIcxJGrOMNlXOgtcRPa59JnsgyhZG//avbMEStDRfYne8
 Dyjt50rXPhWBbUzhhLnkBk/HuQ3xmlt+9DTLca04jDY77F32wT81Ltq37FvIVy5W527/D/Rk0Gq
 zwlxEaeCN9/PBQOuVmtp2YxF7HTnH6gkZBkGn08aj3A/TghzMuHJinKi1aGCBTjaReLzAqLliPn
 Gn1Remm2czVvCulxik/iejt3niNrRyFf4D+ZMY26Y0KHObMrhPFq/2crnFtqhd1K8mboboUWQax
 iGAMk6jzycRLJGHM85TrSSMhvI4UyXiI9QV/XcDNYncYNmHSbQzMLL1VLDTjR4iesyAQvamp58s
 0pgG6Nct/36jSFlmZpQ==
X-Proofpoint-GUID: ADq-tRzBSVO4DuuPVgs2RK6PDYzQOi1q
X-Proofpoint-ORIG-GUID: ADq-tRzBSVO4DuuPVgs2RK6PDYzQOi1q
X-Authority-Analysis: v=2.4 cv=YeuwJgRf c=1 sm=1 tr=0 ts=6978f68b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8cwfA4bTiwTnQ3FzGgcA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270142
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
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-31240-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E20C498797
X-Rspamd-Action: no action

On 1/21/2026 1:50 AM, Miaoqing Pan wrote:
> The 'firmware-name' property was introduced to allow end-users and
> integrators to select use-case-specific firmware for the WCN6855.
> But for M.2 WLAN chips, there is no suitable DTS node to specify
> the 'firmware-name' property. In addition, assigning firmware for
> the M.2 PCIe interface causes chips that do not use use-case-specific
> firmware to fail. Therefore, abandoning the approach of specifying
> firmware in DTS. As an alternative, propose a static lookup table
> mapping device compatible to firmware names.
> 
> ---
> v2:
> - Drops `firmware-name` from completely.
> - Updates the commit message to clearly state that the property is
>   obsolete and the change is ABI-breaking but safe for upstream.
> v3:
>  - Deprecate 'firmware-name' property instead of obsolete.
>  - Keep the ABI backwards compatible.
> v4:
>  - Use of_machine_is_compatible() to simplify the code.
>  - Add back Acked-by tag. 
> ---
> 
> Miaoqing Pan (2):
>   wifi: ath11k: add usecase firmware handling based on device compatible
>   dt-bindings: net: wireless: ath11k-pci: deprecate 'firmware-name'
>     property
> 
>  .../net/wireless/qcom,ath11k-pci.yaml         |  1 +
>  drivers/net/wireless/ath/ath11k/core.c        | 27 +++++++++++++++++++
>  drivers/net/wireless/ath/ath11k/core.h        |  4 +++
>  3 files changed, 32 insertions(+)
> 
> 
> base-commit: d8e1f4a193101a72235416f189b01131a57e26e9

Krzysztof,
Since you previously NAKed this series, can you confirm that your review
comments have been addressed?

Thanks!
/jeff


