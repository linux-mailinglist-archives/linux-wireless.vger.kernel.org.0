Return-Path: <linux-wireless+bounces-28169-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F285BFABCA
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 10:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14AE74E3B00
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 08:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E132FFFA4;
	Wed, 22 Oct 2025 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nQ+WIKNp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392282FF654
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 08:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120028; cv=none; b=CC8fxACCAdv6ir3chLfVH0PCRKlL7njTQrnth1aFP9/EDE3ngTwu91BF+OVRz0nyNnHcaYM3ibn2IX1nZa8/PZD0/u+UcnD1zCXDHrcDZQRXUFIkoxrp0m/Ycsj84olr2awiody6918jiSjE6EBF5GpH6YoxzaQ4axrxtHL1/x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120028; c=relaxed/simple;
	bh=L6JYs4ivoCFvVciQgaMIR/lmHduqqGaaz0VtISeqwJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQJliuGEK+Z5tvxTkrPMIuymGY5RSg1CWULCk8udauoPlG/zFkaEJLaz+OS//cO7L9jvRQEvQMsZI+ReLNjuVLMfFy/0jlHXt+20KtctjtUnLu6gRQkQCpN9isZy1K3ti3zzjBDvZOwJAo2bqPtzf77tIC/guUObTZJo55Hacp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nQ+WIKNp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M2tMDk005281
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 08:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XYXVFaAaMLwr6fG2n4FdstC9bqlVQImA3Ymx6v8/8mI=; b=nQ+WIKNppkakuGoq
	HNCN57+udiDo9ZKqUV2gpSbuppm2Gs7W6lfqPcebpF21aUqbzMPsxh399Vr7Q/XM
	+u0aLJxhQa68vIJ1qmxla0JukMwXMSzCeKWxTPnWAU8H9khPMG2V7/Skixpdyybc
	NqdB05mXyKXpFkC8eD+BrMiEtXBDueQQkDwnOM6JS8G4OclIQCL+mf+QEwwF+luJ
	//eNrKanvzCpAyKY2bzUhgYg5+T+GFcNuYh4yVRSc2mibI4hvwMVag0wNq+Qwq98
	IZs3U8YVfxfeexExDzk6fIGJYWDdpgNHWs+hkU4G/0ucAYVTOm2kc4k9IpghZlSp
	8y9QCQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3nfkr3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 08:00:26 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-781253de15aso14696681b3a.2
        for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 01:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120025; x=1761724825;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYXVFaAaMLwr6fG2n4FdstC9bqlVQImA3Ymx6v8/8mI=;
        b=r2UDjtm5lQDKjAVKlfGcAJpuOCMSYXlXz0enjIn2D2xYPMooOf0ib/bLWhifjlp6Zp
         rknE9v5WeZw99p+XqYD1KXwsD/vsR3rlbLkb6++A3GBQtaj/rSSsA4YUq7cz5/Bymqc0
         aY87rLvYjFllqZcNCwEyygtayBNr/0Hm/GpwOIcJYrbVcaChpto/i/QJEhlEgV1QjC+c
         MGCfQSgY1KrpJj1+7QJXy9n8IGCUfMGfuq09741KYhiGgYxeKhBudXLyiwoiMspgKTrX
         A1u7iuRygT1AeHCzBjA10gemQXhRfa0baCXNA9WlQHiQYAgzHOryrHqWgblATK+JUR5Y
         Jbig==
X-Gm-Message-State: AOJu0Yz6RTP4137w7gP/hVlPM+ba7xgNegDJEjnx7nFzi0cBbIZkZj7J
	jJfuWTRIwmAS5QIsTlsGMtaIWZaoMD6M9oBjF+JsHlZSVOF79wDWH5PsTHkY+yWT17Zny+nlwN+
	a3+60u18AbvQBRlp88JYxwqQJykilJA0e6+O0R61Sz8QcQSqieFh6RZEOmBCdcx1KK9KRrQ==
X-Gm-Gg: ASbGncuwHOSaw5KuJJ1So8i56SSVgzbNsWfzjaUg39+CvKzOwsNYv2iBWxQ8DfDza7c
	ICdN27vLPIiwV7JzxnABzPbrg1zy4Qbwqn3FOWytCLNJyZQ6ygBwP9bBRrEZ0XZmfsVjQS5noyO
	Tv/3/gpwhGuemfezUO3Old3ZfEhK7ZBaXH4yj8No2++8P0TN+65Z4K7a9Q84ysWAsJ1R5TlEtfA
	6M3mmr5WkFmnqlm1vP4KZ3hCVW4oHBOgvQfDoVfgwXBrjmxr0eDe+bgCC+9a51NAgl2B2+qbwLm
	o/ttaXKJLF9IdulBCLuk7vSrmBmrkaDxHzBPcrEH7DwEylAxxM8192WfqOVtspvIFa7VMrX4YaV
	5yqvGEr/9AHk8j+TY2GmKncuKrreqdOmkKJfpF0xHu8teuJn4nkKpsortgGv700F5zR67gxcW
X-Received: by 2002:a05:6a00:99b:b0:793:1955:2384 with SMTP id d2e1a72fcca58-7a220ada794mr29166877b3a.17.1761120025182;
        Wed, 22 Oct 2025 01:00:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVyRz86S4Hw9/gYeNtzxJUUmTcx16JDUBodGshnXBo7XeH/deuGV1Ia/yK2XgOqxc89Wmg0Q==
X-Received: by 2002:a05:6a00:99b:b0:793:1955:2384 with SMTP id d2e1a72fcca58-7a220ada794mr29166840b3a.17.1761120024635;
        Wed, 22 Oct 2025 01:00:24 -0700 (PDT)
Received: from [10.133.33.147] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a230121ebfsm13617531b3a.70.2025.10.22.01.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 01:00:24 -0700 (PDT)
Message-ID: <5466e122-9143-482e-a9ab-7f956e19bf86@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 16:00:20 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] ath10k fails initialization, bisected to "wifi:
 ath10k: avoid unnecessary wait for service ready message"
To: Klaus Kudielka <klaus.kudielka@gmail.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        regressions@lists.linux.dev
References: <20250811-ath10k-avoid-unnecessary-wait-v1-1-db2deb87c39b@oss.qualcomm.com>
 <175823924851.3217488.17742065327824732992.b4-ty@oss.qualcomm.com>
 <6d41bc00602c33ffbf68781f563ff2e6c6915a3e.camel@gmail.com>
 <76d4235d-db4e-40f4-9ede-8cb536b82fbd@oss.qualcomm.com>
 <10919281648e306fd3f6713437b4793c50bb6692.camel@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <10919281648e306fd3f6713437b4793c50bb6692.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7AjbxzQNiTRuhCvIzJxXmd9OZjbwbtrj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNyBTYWx0ZWRfX4rnYkX/msA0G
 qE4tKBBhW0CX4Z+VYuwSzqiItl27kv+7p5TJqEG/8HNgrosMn9uvvafrgzkQRwPgPvPe98IXpAJ
 jZ9TihAkEitzKWyJmb/d9SYSwPSth+Kr/eef8JtXucbhlsDQ4XyTH+5MljZJOSSy7w2034zJqf2
 buXsLDS1yDH2MkDh5K2Ybg95EMH0m5/9aozFU6jWbtdhYVZwfhbD/YgIvEmrR/POYNvQalzjP8j
 KE5bZqOdsAa6RLdWrQp1Q9s4AenjBG09Sc0fq467T6x+61NShovGic0A7XzM8k9Lt7/7V/v79de
 ebyd77wQebu7O1S8TsISRwxEibde0AOny+HprcL96qzwv6wadsxzXAxENhuFw51SgAA24kU42+n
 kvULGohFfhFKgW9438tpYn9PMgx+aQ==
X-Proofpoint-GUID: 7AjbxzQNiTRuhCvIzJxXmd9OZjbwbtrj
X-Authority-Analysis: v=2.4 cv=EYjFgfmC c=1 sm=1 tr=0 ts=68f88f1a cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=PjCq7wsziC7u3JKYlTIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180027



On 10/18/2025 9:50 PM, Klaus Kudielka wrote:
> On Fri, 2025-10-17 at 08:57 -0700, Jeff Johnson wrote:
>> On 10/17/2025 8:37 AM, Klaus Kudielka wrote:
>>> Unfortunately, this particular commit completely breaks the ath10k driver in my setup.
>>>
>>>
>>> Hardware:
>>> - Turris Omnia (arch/arm/boot/dts/marvell/armada-385-turris-omnia.dts)
>>> - Wifi card (output from lspci): Network controller: Qualcomm Atheros QCA986x/988x 802.11ac Wireless Network Adapter
>>
>> This issue was previously reported with that particular chipset.
>> This is currently being tracked at:
>> https://bugzilla.kernel.org/show_bug.cgi?id=220671
>>
>> It may be useful to supply your information as a separate record to that bug.
>>
>> /jeff
> 
> Some more observations on that topic with the hardware shown above.
> 
> ath10k_core_start() calls ath10k_wmi_wait_for_service_ready(), and later ath10k_wmi_wait_for_unified_ready().
> 
> The now *unconditional* call to ath10k_hif_send_complete_check() inside ath10k_wmi_wait_for_service_ready()
> makes the later call to ath10k_wmi_wait_for_unified_ready() fail.
> 
> If I call and handle wait_for_completion_timeout() first (as it was before the patch),
> ath10k_hif_send_complete_check() is *not* called, and both ath10k_wmi_wait_for_service_ready() and
> ath10k_wmi_wait_for_unified_ready() succeed. Everything is back to normal.
> 
> Side note:
> ath10k_wmi_wait_for_service_ready() succeeds in both cases with time_left == WMI_SERVICE_READY_TIMEOUT_HZ.
> 
> 
> #regzbot monitor: https://bugzilla.kernel.org/show_bug.cgi?id=220671

Thank you Klaus, can you please try if below diff can fix this regression?

diff --git a/drivers/net/wireless/ath/ath10k/ce.c b/drivers/net/wireless/ath/ath10k/ce.c
index 7bbda46cfd93..1a981d333b5c 100644
--- a/drivers/net/wireless/ath/ath10k/ce.c
+++ b/drivers/net/wireless/ath/ath10k/ce.c
@@ -1256,6 +1256,19 @@ void ath10k_ce_per_engine_service(struct ath10k *ar, unsigned int
ce_id)
 }
 EXPORT_SYMBOL(ath10k_ce_per_engine_service);

+void ath10k_ce_per_engine_check(struct ath10k *ar, unsigned int ce_id)
+{
+       struct ath10k_ce *ce = ath10k_ce_priv(ar);
+       struct ath10k_ce_pipe *ce_state = &ce->ce_states[ce_id];
+
+       if (ce_state->recv_cb)
+               ce_state->recv_cb(ce_state);
+
+       if (ce_state->send_cb)
+               ce_state->send_cb(ce_state);
+}
+EXPORT_SYMBOL(ath10k_ce_per_engine_check);
+
 /*
  * Handler for per-engine interrupts on ALL active CEs.
  * This is used in cases where the system is sharing a
diff --git a/drivers/net/wireless/ath/ath10k/ce.h b/drivers/net/wireless/ath/ath10k/ce.h
index 27367bd64e95..9923530e51eb 100644
--- a/drivers/net/wireless/ath/ath10k/ce.h
+++ b/drivers/net/wireless/ath/ath10k/ce.h
@@ -255,6 +255,7 @@ int ath10k_ce_cancel_send_next(struct ath10k_ce_pipe *ce_state,
 /*==================CE Interrupt Handlers====================*/
 void ath10k_ce_per_engine_service_any(struct ath10k *ar);
 void ath10k_ce_per_engine_service(struct ath10k *ar, unsigned int ce_id);
+void ath10k_ce_per_engine_check(struct ath10k *ar, unsigned int ce_id);
 void ath10k_ce_disable_interrupt(struct ath10k *ar, int ce_id);
 void ath10k_ce_disable_interrupts(struct ath10k *ar);
 void ath10k_ce_enable_interrupt(struct ath10k *ar, int ce_id);
diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index 97b49bf4ad80..ce8e0c2fb975 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -1812,7 +1812,7 @@ void ath10k_pci_hif_send_complete_check(struct ath10k *ar, u8 pipe,
                if (resources > (ar_pci->attr[pipe].src_nentries >> 1))
                        return;
        }
-       ath10k_ce_per_engine_service(ar, pipe);
+       ath10k_ce_per_engine_check(ar, pipe);
 }

 static void ath10k_pci_rx_retry_sync(struct ath10k *ar)




