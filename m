Return-Path: <linux-wireless+bounces-34373-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AuyOrvW02nUnAcAu9opvQ
	(envelope-from <linux-wireless+bounces-34373-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Apr 2026 17:52:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DDD3A4EC9
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Apr 2026 17:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 312113019821
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2026 15:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFEE325701;
	Mon,  6 Apr 2026 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J93kyziE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IbjsllHE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FE62DB791
	for <linux-wireless@vger.kernel.org>; Mon,  6 Apr 2026 15:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775490703; cv=none; b=UNPC2wDFw2r+u9tVHP6MhxB6ldKXO+uA4Gx6qGxU1dgUF5ffUILxjlLh2dHkk5LgWbG4CXlHIs2LRo3gcyBscWZyOrHkn+uXbo7QWybtt5ouGEvfGrdBKTmeTcjvL9mxIm8Vb9PHg4vMdFgVhiEJqJsdlYOYU/tPjSrVfw76kcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775490703; c=relaxed/simple;
	bh=rzKk5WejB+mbn/yRTIRbxkZzr1bQ4VA/zMee/GV8yyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxGq8MoYSyeYYUDN1w7MiW7GnBdFtOc14lEuXDRa8UFZVauvLouiphSDu/jdBgwKJBgMjtaCMIzxxBtZ+TGEHSMYgLtSogmmhULOvwTfEdJt0f7a0jIshv3sOa9itcnir8QZiD2FI7MFwi+uwI1GE0u7luCgzOs/4arAELp5rfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J93kyziE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IbjsllHE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636ENIIX2897250
	for <linux-wireless@vger.kernel.org>; Mon, 6 Apr 2026 15:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ukQ6Zlht3NZUUsrPWZJsHdIlUjCDU/cg8ksvGrwiy2Q=; b=J93kyziEVXCaDbwt
	ZIT0AYP/Y0+O2Lgk/IKQ0H3W06K6bAYtGRhFzD/XVbuvpZuwpBH6MUqdtNwsDJme
	WouloICu0BfgqnKRoKxAXUdFscYsqt+EzzQAr3mUlPGKWa9Z7g5Vs2bE84XzaaCw
	SOrQzYu5omCBrrW6wKKaa972ZNQllDgt2bpVHBel4Z4m43XHQAmU1EoqibHgajAY
	Q4M2Q6kP21cghTLNdd/R8AVtvijc50TVOf5nh9YowLnhNFLjo8+T2wUK3iYDNgxX
	DGMmbGzJS2N7idyKVqmsQuuOeeXQB216jedwhbFbXct2QhlY5R1P0fM7Sh28eK91
	GYrzjg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcehwga83-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 15:51:41 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso5692850eec.0
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 08:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775490700; x=1776095500; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ukQ6Zlht3NZUUsrPWZJsHdIlUjCDU/cg8ksvGrwiy2Q=;
        b=IbjsllHEUZ/v8E9OXA7/tD/s+FfZWcQcKqrETnI9P5/Tv5KN02nycERtnS12civnWt
         6IOIrCQpf1xGMmXEpPhlOoJaFaVfTRhbaK2jYO0VNRFmYvcbrUoZgXQFOuG2bpKajoHq
         fsoZiULiMUpzWnXltrwKb6BHxIYB31vF8jV1N27OSttLGeOG8PnTvJvIs7OGyD9UhAWz
         iu32/UXhLSLkvh23qJH63KguQgz8Obl5tlGCehiPvepDjovIc4352pDmX1FzRtEfkoiZ
         ZGMY7HeKxkjUT3xU1iW5J1MrHAqwxx7q8DAYHNIe14oYD9Boaon0bLjDaVMQRYqQSQEN
         FrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775490700; x=1776095500;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ukQ6Zlht3NZUUsrPWZJsHdIlUjCDU/cg8ksvGrwiy2Q=;
        b=FQwMEPBM16HRshINrzphkL9n8ii0fpv3rmNiMzRTtjNNQLjQf3KmlsQITP83fyvITe
         Tim3CpaZeuzfnsNwQWaPwHfs2l/4D6SkakEZ+SpviWLhoIFhdFLS9swe/uzxSTdS8b+a
         ARjtZYXkyAkxMkjk8wTgvPGEXGQqsYWk7GWhOQGRdbPTCY1oVPYt6/7qjNNggGi7Jo/w
         w3Ca6C1EpHEZpzeu++OxzWfHFEVbO4URpqKInuhkO2sVa0jQWazUwQ9Qby8mZd3oiOnh
         b4bXXZm6nYFeg3CRfCNO8KMDg1/+rbgRM+lFu2/WSEppjSmAXu8WKGFTq4yELV69hqrc
         DBWw==
X-Forwarded-Encrypted: i=1; AJvYcCXQreXkJxBXidi7PoHwYRW6mslnRSlBZzRChhUH5JDEJVTggvshucoiTaUSFlHMZKnx5ulY2x0xD0wzIhTHRA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz17P4r2rn6Y5Inuv03TH8gEW4TQ5BqK/Y9M+ymRRwj5CaAYl6
	LfyJw4tx7t91ycm16c5IppV8fv3qUXZzztkSKO1jwYi4epPRSR/BjTEsvJvs06L9kRmjh3+zfD9
	DeI8j8MJYxEz3SQSZTYu6H3O9ffhblNDnO5cAH+6I3WyvvV7yBssK5SYC7BswlhRt4qqJlQ==
X-Gm-Gg: AeBDieuIraHzgyGj/k85KBULSap63U6ewEi55K2WRCjb+ISwaIQQ4JUay5cthg9jfo9
	R6yDEzocA5DzTUp30sS514e/0HDKK/yj7AlWBmJMGZl+lzFyC1xGYv1RJFlySiPqhyny3uDEW3W
	l3GfggwTrQkCO4dZ3ZDAy4KUiOrp6mae2bAVjgErgcZuviM7t7vkEcbNE3bywvBriz5KpKvMr6m
	g6QPZhCjmOAjSKIzGes3ai3KRB7O8q/p1gH/imWU0hO9u3+cRqrIywGqmscS+zs5AdjGu/eF4xD
	jWZWpCT5cc/D0vsvhJqgcgQaMyUEhAGoNaBKTx3MhFcb7nHhTHr8O2Sl476cavI6b1JThx1cOLQ
	QbLi22aP0YNvW+xtuL+d6W1kbUovOf7dFBGDhkZ6/UwT80QNVWhJ7UWnpudXpUfejxmN03jJG4X
	jSZq93rmaafPdoIg==
X-Received: by 2002:a05:7022:62aa:b0:128:cc34:35fc with SMTP id a92af1059eb24-12bfb70ef65mr5780057c88.16.1775490700211;
        Mon, 06 Apr 2026 08:51:40 -0700 (PDT)
X-Received: by 2002:a05:7022:62aa:b0:128:cc34:35fc with SMTP id a92af1059eb24-12bfb70ef65mr5780019c88.16.1775490699506;
        Mon, 06 Apr 2026 08:51:39 -0700 (PDT)
Received: from [192.168.1.44] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bede54ba8sm15701803c88.10.2026.04.06.08.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 08:51:38 -0700 (PDT)
Message-ID: <0cf5e285-b5f0-49ef-97ae-6c04504044ac@oss.qualcomm.com>
Date: Mon, 6 Apr 2026 08:51:37 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] dt-bindings: wireless: ath10k: Add quirk to skip
 host cap QMI requests
To: david@ixit.cz, Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Paul Sajna <sajattack@postmarketos.org>
Cc: Amit Pundir <amit.pundir@linaro.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
References: <20260325-skip-host-cam-qmi-req-v4-0-bc08538487aa@ixit.cz>
 <20260325-skip-host-cam-qmi-req-v4-1-bc08538487aa@ixit.cz>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260325-skip-host-cam-qmi-req-v4-1-bc08538487aa@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: qwpgqFXcHCGnC2LSVFea2SC3gNcZvQw_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDE1NiBTYWx0ZWRfX5zFuGNTCSsit
 23y5H/qQs6Z3wgdNnUhBmUM37AlyPEjAgy7J4OnH3N6dVo+7FYE1MfVgFbqUxf+V4ngOJAfqLyX
 akfLU9ANGNqy++oJndfn2K7pPimcK8AXpP4+h0G9m9I+FAIJQuxobm23afnipwowduNgBvMh28E
 /TWcyiBXpEtYF7FWc3XRfUSd/JqaTk7xu8BkyOIq9RazSq/Gbe7czVetbkj+5h2pC5mczWiopEQ
 taD2bwwsf+e3iW7jTuEdkAstVb16QSex746/8UzgZ6K0rVK5p9rreSJTk7tCsHiKVQXrS70zxM4
 t4Qr48Z5Lv+MqaQu/6uKGX5+WEhERXZTqgd7oJqSlBdpxrcHf/QQBgbUMR+dR3che8t4/fJjH3i
 QgWqXsKITHnNLWqX73LueWctut2BNXFY5BM6tY59PUH2tdY70O1byapnAW6TYK9tBRj8vWvb9rl
 uBrVLU4cO/mwdvXjBWQ==
X-Proofpoint-ORIG-GUID: qwpgqFXcHCGnC2LSVFea2SC3gNcZvQw_
X-Authority-Analysis: v=2.4 cv=Nr3cssdJ c=1 sm=1 tr=0 ts=69d3d68d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=Gbw9aFdXAAAA:8 a=KKAkSRfTAAAA:8 a=Jr6ivFuIO4VC9FIHmAQA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=9vIz8raoGPyDa4jBFAYH:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604060156
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34373-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ixit.cz:email,linaro.org:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 52DDD3A4EC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/25/2026 10:57 AM, David Heidelberg via B4 Relay wrote:
> From: Amit Pundir <amit.pundir@linaro.org>
> 
> Some firmware versions do not support the host-capability QMI request.
> Since this request occurs before firmware and board files are loaded,
> the quirk cannot be expressed in the firmware itself and must be described
> in the device tree.
> 
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
> index f2440d39b7ebc..5120b3589ab57 100644
> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
> @@ -171,6 +171,12 @@ properties:
>        Quirk specifying that the firmware expects the 8bit version
>        of the host capability QMI request
>  
> +  qcom,snoc-host-cap-skip-quirk:
> +    type: boolean
> +    description:
> +      Quirk specifying that the firmware wants to skip the host
> +      capability QMI request
> +
>    qcom,xo-cal-data:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description:
> 

DT folks, there is a pending DTS series [1] that would like to reference this
capability. Would like to get an ack so I can get this in the upcoming merge
window.

Thanks,
/jeff

[1] https://lore.kernel.org/all/20260401-judyln-dts-v8-0-7677cfafbc78@postmarketos.org/

