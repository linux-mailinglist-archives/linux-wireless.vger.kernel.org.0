Return-Path: <linux-wireless+bounces-38561-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MD3sCaRaR2ofWwAAu9opvQ
	(envelope-from <linux-wireless+bounces-38561-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 08:45:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5AE6FF2CD
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 08:45:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=hiSvtWqm;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=LbPy4i11;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38561-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38561-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 859FB3020AAD
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 06:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B890332FA2C;
	Fri,  3 Jul 2026 06:45:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153CE386440
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 06:45:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783061129; cv=none; b=oI19LYf9yXDhPU2UFl4/hYcSMOVlhDc7SsZmZkBKyIOf7aje8b3bLzAPiSgs4PEpdvi/GA2KuZIcdsXw0sGBcP8ajp825ftRX55vr4mxwgeqdHyXBygp6pVi2rSw84CBlC1R8o4zAh+kQtByqYWulTh+nWhKPkrQokhXqZl2LEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783061129; c=relaxed/simple;
	bh=z4lCII1ZehUTz9Sz3H0Z4D5t89Ta0fqSUqyBnBq0R54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h5hLnTIRMrZarBVyriXCAAJfhhIVrvR8DiXhnSKUd+XoyAG988eoZVJhf2HTa54Cem67a2Q+NQ+HYARhT9oKmHTEIuJ9sC02PbbMKinXitAoX9EWGe4IiksMwryGhNtZi+EEaV3dHW8p/nKUf9RCqTiiMNTjY+nsCYtIfS5E15A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hiSvtWqm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LbPy4i11; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635reuf2994861
	for <linux-wireless@vger.kernel.org>; Fri, 3 Jul 2026 06:45:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kfCsJor6zr9JsHaxgfb1o+ZCD1IlPkC0zKCAWBS/gS0=; b=hiSvtWqmwcoBj3sD
	tQKWAXmYbaBpniUdOco+jxUBFPFfnfA1KU2X1Gj+q2byMnkhAQmjPGABzhlMMB0U
	1iiqZndY8/9DJECEnS2XQprlGyO5NiWAS59woH22eEsD33aw+RL3njkNRlDI15o1
	JBbFoO6aK18sC43z/EuypdbGTH3QUeT+7LCFxLTzDsyxGzZSTZv4juAeqGEVqObH
	iyXX+56/D88FqYqg1tAgW/KzOY0V7W1MXPKozIleggk0vp16UF0F42srXGTFf02q
	jjYvRK35i+mqueQN7Rj9zDal/GEeJdD135GOUI9EeCDpA1QYwsZE56W2csLkggAo
	sCWJgg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f648n11mv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 06:45:25 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c98136ceff4so460685a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 02 Jul 2026 23:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783061125; x=1783665925; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kfCsJor6zr9JsHaxgfb1o+ZCD1IlPkC0zKCAWBS/gS0=;
        b=LbPy4i11EiGOBd7uQ59Je/9zeAaq8sJPy8Jhg4U8SZoPg8CsctfT1I0U/FOIXfvwzh
         tm1xP/00k0KAUu8PeuZo+pn77j46YD46kVwp8VcGxxhGg+Fr8y07MkWrqF+fma6GLy31
         PfmDx1CsLUbKs18kW5eSkk9yGTX5IkvwAbIMuwhF6O1R0P5WO1/fhArLnbuSey+j9QI2
         yBqhHERWfDj4svNdYpEchKgTNffKLovHoLBf2zgl76rSiTMnZBH3RqN+t+fAAuGTA9Vt
         gXIGczkSjjbk5xRTfy8vdBLQu93UUUGnbD7Fvi7NocG9JaSiTjDYmFmtGZqilrtXR4ii
         +YfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783061125; x=1783665925;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kfCsJor6zr9JsHaxgfb1o+ZCD1IlPkC0zKCAWBS/gS0=;
        b=Bc2HeF9BusA1IiLakgTLFtE4dfFR8wFZKLOABqXTUWxz/jAPsfY3fJIife+bfaRNJ4
         UdUSFpHpgiYKPxS+MSmoxHlnWaJ/L3WutQ6DkIPpVNX8oGnrC69hNlipcUb6gvZAGLU+
         AB+KZHE7dFq8u7O6sShLmQAO9iJKwyeLHI197lDWXV9i57gEd4UKxBtTlEH+ruFx/rQh
         6ANvb0eZFGCQt26K3XGlVk5dL/DAQ3F8qKsZr5bfN4MwAsgP7hUUMKLlKxPhVPzZrWl/
         9fmqjrQxsINAvKWy4KLPMH8EquS8o3evUw8abQL7yM35ITK1s9VXcDrtARY3a3kWX6zk
         qhtg==
X-Gm-Message-State: AOJu0Yy9kVQItWZ9qQ47uVcLVGPXjoa8Av2NUY7JTc40kLCaYPdLeW9l
	Cs7YxiSzJO9QaYpwKj788LQ9piDsYFZvFjxFF/PhSxKqffC54oACtTDFx8MNLCNXMBY47uChyxL
	GrJrPyUBu8uKLbIwiWSyamGm5vTX5oiiOG1nQrueFvZmLvEaVp/N/GlPdBgPxBAqnhTtz+A==
X-Gm-Gg: AfdE7cluhZtY/qf8DW6/oG2MXLuneo6MKLy7nNCpUPgDfXABKBeswaLnyPRExgyxQZy
	prrsg+XS7UBKwYFqrLbMqqOPW2ok/We0ZZKKfuDF39DqN2+ZFTgPokkwq+VAgLXzXqdRN7HeRI5
	QL7Iq7v1BPnu2vGoFXk1UkfGE7zqPlDTypDtMXIIaJyHjPXd5yxWJ7XxUhgkk6qxNY7qI8RmzBf
	Bjx3QuOr2FJKFtCjOzKKqUGKqeyqy+xIPmz0ubtyQLHXkpJp3uOgmfWbys6PvsF18/4ApLkeTph
	xOGetM+fk0dlybCpfU7BFoy7Eibls3smmSEALAqGOEW66jLu58tflmZQLc/iptrFTVTqRbzMV7z
	fLwqhWkcE8opjjJxHwTd2g6um2uSCK6rh5FY2lwr0ksBG7+oqkcDxZtgEyQ8m3QbIPqIrIOVsNW
	yZNoXHs3+v
X-Received: by 2002:a05:6a20:3ca7:b0:3bf:6c08:2843 with SMTP id adf61e73a8af0-3bff42daee4mr11446770637.50.1783061125020;
        Thu, 02 Jul 2026 23:45:25 -0700 (PDT)
X-Received: by 2002:a05:6a20:3ca7:b0:3bf:6c08:2843 with SMTP id adf61e73a8af0-3bff42daee4mr11446741637.50.1783061124596;
        Thu, 02 Jul 2026 23:45:24 -0700 (PDT)
Received: from [10.133.33.211] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8eb0efc8sm2367706a12.5.2026.07.02.23.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 23:45:24 -0700 (PDT)
Message-ID: <f304041f-c570-4db3-b27b-86d85dd41ec5@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 14:45:20 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix potential buffer underflow in
 ath11k_hal_rx_msdu_list_get()
To: Dmitry Morgun <d.morgun@ispras.ru>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        stable@vger.kernel.org
References: <20260530114252.42615-1-d.morgun@ispras.ru>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260530114252.42615-1-d.morgun@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA2MiBTYWx0ZWRfX8FPmsDoVqbjO
 DFCey05ryi9jmOD3vLuy6wqofLmOLsuqMI99tJFzRG4fRqNRyW8hk7WcTMeW8oIvARe6hLhgYom
 OcDep1rZqJ8xfIWxFmjCrTmVuQ6QgO4=
X-Proofpoint-ORIG-GUID: qcpnrWEjclB88ZnCw82ZPwaRrgZSTUbW
X-Authority-Analysis: v=2.4 cv=O4wJeh9W c=1 sm=1 tr=0 ts=6a475a85 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=HH5vDtPzAAAA:8 a=xjQjg--fAAAA:8 a=EUspDBNiAAAA:8 a=zEb-VJRgp1rxa82pEt8A:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=QM_-zKB-Ew0MsOlNKMB5:22 a=L4vkcYpMSA5nFlNZ2tk3:22
X-Proofpoint-GUID: qcpnrWEjclB88ZnCw82ZPwaRrgZSTUbW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA2MiBTYWx0ZWRfXz2fP+pyxPgyC
 RYntXsolCNaBg3xjh2YZW9Wh3MFjZhxmMAPeBsTfaWRzleZGcfPsaDUhgTNBF7G6Ls4pb673cYD
 AtE6Kp+EhWYvquSY45bIJ7jpPpKEe6wQPgq2SSGdqgtVXHaGnxBNEy7GRBxoPh/4yUQ+fqADNpe
 1d6EDCS6Gu/E+9AapgPOqSebICN4vmTVoY26ZE+J6xFaeYfpkpJ9mSmZYfh31JMcCe0IV1yIjb0
 6eHDOvdNzHVHSzSS61pDmydMquo3bgPGfSx3AbPbeTSEdfJMCRHuT8w9ra3MJwLP2j8w3o6YIup
 1o94RgZU/MT9/MYe65njiRh72QRsaH3J1BGLsjcYGhh74T/lzdbVjiDIA0cPzUFRgAOALVLdx/s
 TU5DGvag80FQXg7BJLpRX4ASLl6WsG++xOlBpAGIa4PqHfnedoXfbfYsu0n3qGshxBs/9wJDLkX
 1glc1qTnA7aGq7qR3eg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030062
X-Rspamd-Action: no action
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
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38561-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:d.morgun@ispras.ru,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,linuxtesting.org:url,ispras.ru:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7C5AE6FF2CD



On 5/30/2026 7:42 PM, Dmitry Morgun wrote:
> When the first entry in msdu_details has a zero buffer address,
> the code accesses msdu_details[i - 1] with i == 0, causing a
> buffer underflow.
> 
> Fix similarly to ath12k_wifi7_hal_rx_msdu_list_get() by adding
> a separate check for i == 0 before the main condition to prevent
> the out-of-bounds access.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Dmitry Morgun <d.morgun@ispras.ru>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

