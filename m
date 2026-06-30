Return-Path: <linux-wireless+bounces-38372-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kyhGNN20Q2olfgoAu9opvQ
	(envelope-from <linux-wireless+bounces-38372-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 14:21:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 470EA6E41E9
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 14:21:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=IQK1lL4o;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=ODmWO7k5;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38372-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38372-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 046C23030D63
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 12:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4313240B389;
	Tue, 30 Jun 2026 12:21:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06063EDE57
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 12:21:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782822105; cv=none; b=I/oEVaSQnapOHxaH8B7QCeMUDtvkUHlkuINnSqS2uK+7eQf7JmQ9LmKQvoUjqgB+WoJRDc2tqfvleDPMKLpIYK5QjLvbNs8rJuDr/GovLYsIZoHwWat/IdvGW2QgLiFvvfHaRosig0azTkV3WDp7XLjqWcYrYndBqxoCLdYoclk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782822105; c=relaxed/simple;
	bh=ZBhs34ZISK9bRi/rf/JPGKWEECowkqkQOjuTBR4fNCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Go2L1MUGGYNmVvB7EXIJ2cGgJC0ua+Qu8G8du/bL9uTfIqZy6VX4iZ6JwB7G4RJjdCILFwrxnBeRA4GY2VGgrjjSTg1HAXhXNHWHM3z0osZF+NC8NJ8xlK3Nb0/ZnZdX5cPLXJzZKAR3NkOzS+ocJlXLMXHB/WpgRROgz+LNkoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IQK1lL4o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ODmWO7k5; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9mt3P1602688
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 12:21:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OKA9ni/VKYiyOGZbetdw2GUFM0Wy/xcP3QxXwwJdhrk=; b=IQK1lL4oceipm8Q4
	wpDe0abCYCvbADeNXWX3gj3hyHy7jURTho8WgTcNP0wxHt9iM42a5wd1u/4ra8hi
	slQfbSxApQbzQkn8/8rw/U5Aie8gnKbUeQo73GyfSHmrz/dWJU0L41C2pCOKK+Ux
	eQKjyqY08FHK7bPN2E46E1JCFGqBqISg00TgsLFx+NiEjiPYYH01FCuafv6/DTcr
	zI2JXzR4UsSaslUZH89nqjJ+CIcWpYI258CT3uYhXgutcWX1OsKtcX3nMdwRsr1c
	6alJGvFylNA96g1H5P+qcJH/bFmFX/4BL4uCgiQv9zSHsVRPKJgbUp3dwNymm30A
	1zcuIQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4avprufa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 12:21:42 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-9692c7b2054so92197241.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 05:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782822102; x=1783426902; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OKA9ni/VKYiyOGZbetdw2GUFM0Wy/xcP3QxXwwJdhrk=;
        b=ODmWO7k5d35aQmY+TNpaXyJPMoIQtPsOLkR4UQCAidVsK+plGEyVZEn7yz2Je7nDcj
         GNVuaQ7hMovEktvOXFO+twpb/yMkfkBWeRNs4iNSxKv4oyUkQZhTQ9HSJji1Xt7LrfxF
         ZQvVbitc55+tKdVEPOuoxG+9D7VtcHn+fgtIjFG4qh12fDJA/DUAyWMC0YpngDFIQ7yi
         ohKaeJNu4qhum9fsXvMiWTG294u9ziGQSUderrF3uiU5AArUWMb4wEvhb4Bnq46jEPLc
         TLdIMK8xDY3dYPblrYf0TdeMvsNGWSl9RhizjpvY1Y6qylvJFhw7+Y2Uk7PEa/5jj1ZK
         qk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782822102; x=1783426902;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OKA9ni/VKYiyOGZbetdw2GUFM0Wy/xcP3QxXwwJdhrk=;
        b=B/UZIP9nBum14RMiHf0CLO3QRqzh7Wz/0p9/IIPNztl9NYUbVcl9Cl+IBx24xBq6hc
         kmVoP7T4EXgjYjIAFmrjo1LhMn6WnVmF3eSo8eKpbICDGuAKmTDpG7lmRwHacodURsI7
         E4bEOTighSLUUxq5zjbWAaqi+fOE8DGD5wDFeIBdtjhvHGKm8AbMcko5X1sZJ3Dha28V
         5M/kz07TI3aNzngwa7GBSxvbPwkKPmj5Ezi7cZy6N6kUtfm9IydwBAYOAyEa5qwY6lZ2
         jLiIYnJtITU1mT32JO8cLEavM2SUUDYj/nLgTM5BBL1d0bfIlnMXAe9oJb1sI9sSslfe
         lQFA==
X-Forwarded-Encrypted: i=1; AHgh+RqrqgdgT3sQf9gg/hRnl2MdxltFQOKAvlpFrm6wJSvUVysavX65y1COPO2OejPhg95gKwcLgLKMPnShAzJQhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzayCl44lehqElI2bId3lhkC+dBby/J86VjW2tKCw3Y0y5oOQon
	O0YQxgEBcTTlne50IKv0FGJVUXH/e4PHOxF0BO9/qEKhiMGPXjmFHXiAh0zcZH591EMRSSNI92j
	W0+nf1cnZiY0d3Q79IrqLYkt3hIoop7j6qgGidfK3zwcvW6Mc8oPb7736nZUzV7jsGOyuEw==
X-Gm-Gg: AfdE7ck8U9zVhfj6L3CXzqcwzyc+igsd3BOX4n7QjVDCKeLO9KMJM1kipg2f8uDtdBZ
	ug0zRnzHB/DqRed+zKdyIapdoayXsi/UD6xS5uHBmdgYbiIzrcJajHUSOqa+djpIMjqJmN9FXrR
	bh9DYlpel+m3Optep7KI7RS4e3tmUGzGxAHLz9hHk1ksOkF8kD4f293b/AdG23iaoUBFMUZJmDi
	VJiPyXI4En3pmzwf7IMwo+Q8+SfINpfNUbrhlq0HKMML6V1ty1ZfRWUO5qpM197NjIRjKILfhcu
	ng+h5kUOEMw6qDN01e8oovEvkJFM48Xl9sZuK4LBAIsINeolwczJR3LXfr12pZ8b6UUGT+K7FNK
	LtPcSBPcCmcSCf5t/hDeuCNjymsRfz9we558=
X-Received: by 2002:a05:6102:5986:b0:739:b7cc:3ce7 with SMTP id ada2fe7eead31-73a3934de72mr535085137.7.1782822101838;
        Tue, 30 Jun 2026 05:21:41 -0700 (PDT)
X-Received: by 2002:a05:6102:5986:b0:739:b7cc:3ce7 with SMTP id ada2fe7eead31-73a3934de72mr535050137.7.1782822101431;
        Tue, 30 Jun 2026 05:21:41 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6987c9503f5sm1104309a12.20.2026.06.30.05.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 05:21:40 -0700 (PDT)
Message-ID: <bd4080da-0c15-4142-aca0-21bdeaf9eb33@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:21:36 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/14] firmware: qcom: Add a generic PAS service
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
        akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jesszhan0024@gmail.com, marijn.suijten@somainline.org,
        airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
        bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
        mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com,
        mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
        jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
        vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-2-sumit.garg@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260626133440.692849-2-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7HGwn33vcVifviCdeG710nv_RsJnWUgy
X-Authority-Analysis: v=2.4 cv=KqJ9H2WN c=1 sm=1 tr=0 ts=6a43b4d6 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=DWWpLck2SfFL7czMIZ0A:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExNCBTYWx0ZWRfXxKEw8TZlHnQp
 9tTx6vLS5uIFhLzkUdfEF+EwnpevUw/4p+GlV70GIC1vw5ymMUVUjHLWnKE3K1DCEwOxI+SFuKV
 tAeW31NOO32y9PFDGAdllUHcuNEsvKnYoq//lQXDs0eC1HD9JWdIykRKweKOZZTxeK84G8u12se
 NhHHuH37Z95b2xA4YJIQIadWjEZSfUYdCneXD++0rkVbYCDpbl6I8xCWhZZB5r0p7aA4/MH9ilc
 zFBbz8GuY5TRfof5ZiqGWhN6YNE+ZiwWcT9TbSJ0QNo5zOUGTb5vsb2W+FshB1KPuc3irx/nrQ6
 OtP2fXrYKtH+gtG+rfrJcUt92KOQ4ZR2jHkrGjrdEYr5dh3ChY2S6F5G/5+h2OEmqBDPJjCrUna
 CtATfZM9fP9WkfDS35vh/cUbOXKH7DroF1hbG9ot9DypmmxAX6tuO2QrAyhfGlZUvRh9d00eKK2
 H9PPXIhJgatk7mFNZ3A==
X-Proofpoint-ORIG-GUID: 7HGwn33vcVifviCdeG710nv_RsJnWUgy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExNCBTYWx0ZWRfX6ovqSGrEAKlL
 3OgR5DI1zFYOK6ZuP9k0Q8VYfTVMgNqEVx9xAhHF8ilkYFIC4IoRJtyqTYd8yIRdhFAgZkmqMTz
 FBdJw4elHUVs0m6buWu0XdtPzOY/5Lw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300114
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[49];
	TAGGED_FROM(0.00)[bounces-38372-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sumit.garg@kernel.org,m:andersson@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:freedreno@lists.freedesktop.org,m:linux-media@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-remoteproc@vger.kernel.org,m:konradybcio@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robin.clark@oss.qualcomm.com,m:sean@poorly.run,m:akhilpo@oss.qualcomm.com,m:lumag@kernel.org,m:abhinav.kumar@linux.dev,m:jesszhan0024@gmail.com,m:marijn.suijten@somainline.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:vikash.garodia@oss.qualcomm.com,m:bod@kernel.org,m:mchehab@kernel.org,m:elder@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jjohnson@kernel.org,m:mathieu.poirier@linaro.org,m:trilokkumar.soni@oss.qualcomm.com,m:mukesh.ojha@oss.qualcomm.com,m:pavan.kondeti@oss.qualcomm.com,m:jorge.ramirez@oss.qual
 comm.com,m:tonyh@qti.qualcomm.com,m:vignesh.viswanathan@oss.qualcomm.com,m:srinivas.kandagatla@oss.qualcomm.com,m:amirreza.zarrabi@oss.qualcomm.com,m:jens.wiklander@linaro.org,m:op-tee@lists.trustedfirmware.org,m:apurupa@qti.qualcomm.com,m:skare@qti.qualcomm.com,m:linux-kernel@vger.kernel.org,m:sumit.garg@oss.qualcomm.com,m:harshal.dev@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 470EA6E41E9

On 6/26/26 3:34 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Qcom platforms has the legacy of using non-standard SCM calls
> splintered over the various kernel drivers. These SCM calls aren't
> compliant with the standard SMC calling conventions which is a
> prerequisite to enable migration to the FF-A specifications from Arm.
> 
> OP-TEE as an alternative trusted OS to Qualcomm TEE (QTEE) can't
> support these non-standard SCM calls. And even for newer architectures
> using S-EL2 with Hafnium support, QTEE won't be able to support SCM
> calls either with FF-A requirements coming in. And with both OP-TEE
> and QTEE drivers well integrated in the TEE subsystem, it makes further
> sense to reuse the TEE bus client drivers infrastructure.
> 
> The added benefit of TEE bus infrastructure is that there is support
> for discoverable/enumerable services. With that client drivers don't
> have to manually invoke a special SCM call to know the service status.
> 
> So enable the generic Peripheral Authentication Service (PAS) provided
> by the firmware. It acts as the common layer with different TZ
> backends plugged in whether it's an SCM implementation or a proper
> TEE bus based PAS service implementation.
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> Tested-by: Vignesh Viswanathan <vignesh.viswanathan@oss.qualcomm.com> # IPQ9650
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---

[...]

> +struct qcom_pas_context {
> +	struct device *dev;
> +	u32 pas_id;
> +	phys_addr_t mem_phys;
> +	size_t mem_size;
> +	void *ptr;
> +	dma_addr_t phys;
> +	ssize_t size;
> +	bool use_tzmem;
> +};

Redefining this instead of moving the definition (this is a cross-
subsystem merge anyway) makes things more difficult, as there are
patches from another team touching this struct.. hopefully no kaboom..

Konrad

