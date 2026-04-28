Return-Path: <linux-wireless+bounces-35434-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBRaDL0g8GkyOwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35434-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 04:51:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F4D47CEDD
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 04:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40AA3301B701
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 02:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44BC2FFDD5;
	Tue, 28 Apr 2026 02:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nYg+Cr8g";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TmB7N3Dp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE27396B79
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 02:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777344698; cv=none; b=ZKPSrfSrjcK1n7ljC8zxAcO4wUGVcMTaRWURRiaKfldtAscfgon0hLM1eHbAeEUVCRRe7SBRtTojpcniUKpobiTBptSYkm9UzrfCQriL9zRj7xSyS5gFvXlSzeiCgwQcsMwYk58DlbDEYCQaan+piTZBPD/U/+lBXj3cBUiONF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777344698; c=relaxed/simple;
	bh=d0AlYLc5HT6qkdXv3KJL+EgplyN2TbxXPKcG7GmMAnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q+LM1KSw3H5By0nEE2AKLyx00ovLzXcz5DhkAr6AU2dkRLRvMYPZ/m/D7EMffYJR0Tx6jXr2kZ3pXaL1wc5BD3SU2XqdLJsvYAFHkUdbCCIYLQuuIChULcFxSRA7fJLRPk5PvJMboqcdAJ1k716ovbH6B34JHg0VWEaW1krzeeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nYg+Cr8g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TmB7N3Dp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S2H6kp663416
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 02:51:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rlNsQKrg2zvTTqEVgbQedG6D268H0WcV1COU8jMMdUU=; b=nYg+Cr8gxEJmNN98
	kgw87+HjzX9doTHt4aYHau2S403Q1dhCa/DNCfO2JZT8b3q/lGmftEPMw31niW9O
	sYin55YqsjmMEi9M0zZ/mTSk8hy2FlevZCT4eGl/JKSE6LfFf+gXPUlbeh9/8RKk
	S631/dWtKN0BmAuBzrT3tB9kdF0XB73OiunQu/hLlDVGdhMUgGCPqOg08ltG3B3a
	vaA7OHRDOuilnuz0WP9TuKU44VO/KJTR0lRMZuMB+gjuR0LMwZYcI13Q8NNVMh9M
	yCBkhQVNicgX4cAQxntQfWOpnn9PwBSe5Af41TrlT8dDzHoWaRgW0T9pfX0HMov7
	6a1kSQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtc5n1twf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 02:51:34 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c7985752be1so4265533a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 19:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777344694; x=1777949494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rlNsQKrg2zvTTqEVgbQedG6D268H0WcV1COU8jMMdUU=;
        b=TmB7N3DpMj76ivJ7J7NUyWB7zalEKLyFXGvfyaGBQhF+cNNLc8X7dDoOooK53tX+b4
         38sl+xCKy0Wk3sHcg9VEwCw/fD/Cq7DV8fd+miK9yR1jUZQMPvSpoQP6fe4vahPAJVk9
         KhYi1jvZYJsOBXyMe0Y2jUAVevGpsDbvnHwg8/L4NW87XF9aEcH5NbRpo+EIBU83s7Z2
         buGN0Q40wvwPMpUIjvCl09ikVK1bR67eZ/6RLnMrrbU9lbOaE0EUTft4OAyBLkMsM3WV
         TcN14hzcF5mc6isIAweEE2p6aEZA8h64OZ2XA+SeXD1oiQPQ7ifaZkGG73YaQM7uCL58
         1opQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777344694; x=1777949494;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rlNsQKrg2zvTTqEVgbQedG6D268H0WcV1COU8jMMdUU=;
        b=nsiUt4WPynlpR1SY5KqcB8gU/0y6r0m/24xdaCjmrq6d044w5f81hmA5fDaYl53rz4
         B5lbxcTAmYhGVBNL6HzG/UhsxUgrS4YcT2I8z6UxEqt8ZeYuJ6aQKLerCjElbN8gInEA
         +Wf7ob8tq5nif76vvVN9pNTjKoelvulh5iTQpcaYOtov3PHyd/9EImWTqTDrYlTZA4pr
         0X32jLxTHmH2+zHFOMuigoZ8N7rIHvJfCXH0CtwRCAJFza1laYO4sBZNL7htyeHiRlgX
         QsBPDH9GtG5h7jvqoGx8DJftFWAVo4dJaxcx3GiKJn1XM7hZ9nhzXtuVJn23n1Deti1l
         t0fw==
X-Gm-Message-State: AOJu0YyMk30lRtKueBQz0av/VJrCHRnnsXIZIcErdOB7XgSpZO0vAEo1
	s+0KpmDZiCWywa6c5ieFxFG9Kgmym5Ae+Z8dGgibxyFwKz0vibr3ecL+AT/djASseeZTU3PcJh3
	hugDKJu5ZEcJqvLkkLH0gkgdmHWyjJuXkQlxkB4IBxbL8SFu4J76l1gRKDrz3keF9ACU9YA==
X-Gm-Gg: AeBDieuIQtR/I/bFcV3CxJxkzPU1EDeGoO0Y+1acWt80cqu94SopVF5D9MHrw6X4DNW
	8pZ4N1E3HQIa8r9dweaSLDEGMEaMNORWSiFu77mJ0HPz1h3s6fvL/tS1m2w5682OKT2PH4TwrKy
	68al57MJPheNpPUYN8Si5Sxw3TSAf+IrmSULZ/Hkf7/iSV4VTaZe2can8xghAEa/Ac4QxXhD5uR
	I5GHyelEcMDhMF0qg23AypGz7Mg73xzTgiHwXgzvU2W9meEMvIIj7eNpLlBGXA21nNPq9A25TXm
	mlHUIsVgCs4mXRQY7ggUdejOSdAJKqtZOUrRDU6MPFN6VCAMD8LMwyIIvekyYWKzgJZkeQok4V0
	irs4Bfde+9ZMV0rmfjHF18gDRmvAcPFQbTM5o+9Kw5ovqAQ4tu8SdBw5CtYk/tsyKDhh/YGMgto
	K/HVxX/bexeYD71bmwzU79Zf5OcG4Pow==
X-Received: by 2002:a05:6a20:a121:b0:398:a934:9be6 with SMTP id adf61e73a8af0-3a39c28330amr1565062637.43.1777344693828;
        Mon, 27 Apr 2026 19:51:33 -0700 (PDT)
X-Received: by 2002:a05:6a20:a121:b0:398:a934:9be6 with SMTP id adf61e73a8af0-3a39c28330amr1565030637.43.1777344693387;
        Mon, 27 Apr 2026 19:51:33 -0700 (PDT)
Received: from [10.133.33.153] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834daf69240sm857096b3a.48.2026.04.27.19.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 19:51:33 -0700 (PDT)
Message-ID: <18a453c1-87b2-4cd6-9e52-e7a1a0611ebe@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 10:51:30 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath] wifi: ath12k: fix leak in some ath12k_wmi_xxx()
 functions
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260422163258.3013872-1-nico.escande@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260422163258.3013872-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDAyNSBTYWx0ZWRfX+71XZ+WhZeUD
 QSogmZODrZqgf81MM/DXCTshnPzajfEEm3SVV21O9PfZYi/6eYDATSwToDIPqzE6ZBG4xCwFIiT
 BeaPzj79+Ur5oI0vPqMzIo3lGrKEFDQXoZCW+37VOQ7KRSJ+iteDIN7dM3K06hOHuzc5+qTkmo+
 HgvyAE+xf4xzjNvrwtFTV36ytHXnM18J7knmc5YkyNZiZxRAVlKLRkRlXq5+TDk+7hv7tCl+lua
 /LAkqhtz/ehkTa7jzNWW2e1JcYdLV6LnrixpePxsE1Igm0B5TXfBpN7Cch/iBxMiFOsGy+OAvKE
 UufmiG+N+Mwq7ilt4jjMwr5OJ0EGMXZzw9EmeL0AMyemrw8t1j7N6TuYbBYgJeV5ynIbenCkjqC
 10jzIGKwGOxMpjIUhx4eDhqjKPiMG4f+So3Jw0MV3tSFCgOX8RPcLB2HtJ7RJ2ZdMxmVTH4XRA0
 F44UUGRbdTsdVM+RRMA==
X-Proofpoint-GUID: QNT5NxGr-A4INbR4qd0gUu7-F5vOrsco
X-Proofpoint-ORIG-GUID: QNT5NxGr-A4INbR4qd0gUu7-F5vOrsco
X-Authority-Analysis: v=2.4 cv=ZMfnX37b c=1 sm=1 tr=0 ts=69f020b6 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=tJU9ox1lp4qBWCJDgPMA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280025
X-Rspamd-Queue-Id: 88F4D47CEDD
X-Rspamd-Action: no action
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35434-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
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



On 4/23/2026 12:32 AM, Nicolas Escande wrote:
> Some wmi functions were using plain 'return ath12k_wmi_cmd_send(...)'
> without explicitly handling the error code. This leads to leaking the skb
> in case of error.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00218-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 66a9448b1b89 ("wifi: ath12k: implement hardware data filter")
> Fixes: 593174170919 ("wifi: ath12k: implement WoW enable and wakeup commands")
> Fixes: 4a3c212eee0e ("wifi: ath12k: add basic WoW functionalities")
> Fixes: 16f474d6d49d ("wifi: ath12k: add WoW net-detect functionality")
> Fixes: 1666108c74c4 ("wifi: ath12k: support ARP and NS offload")
> Fixes: aab4ae566fa1 ("wifi: ath12k: support GTK rekey offload")
> Fixes: 7af01e569529 ("wifi: ath12k: handle keepalive during WoWLAN suspend and resume")
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

