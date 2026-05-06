Return-Path: <linux-wireless+bounces-36038-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOFuOVmG+2lScQMAu9opvQ
	(envelope-from <linux-wireless+bounces-36038-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 20:20:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8F74DF3D1
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 20:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19998300A618
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 18:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF51299931;
	Wed,  6 May 2026 18:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Brj8A/Zb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KqSeVHBs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECA44B8DF7
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 18:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778091592; cv=none; b=bYqHx4h33bEToKKsbkkPiv17d1nCBAEmQhk4Pb7nSBGG2KQ3cW55RewJB/IEGEJ/OJhQvSk4ifUukXHOpTkqgWmQKmWr7rKJCFt9i5PMZbJKxX4wPA1xURBBD60JqlWXFfGVisnej7cL6SD51JU60cDtw5MCHDa7KnCBX1uyY7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778091592; c=relaxed/simple;
	bh=7aiu2JUFoolSsX24+en1TLO4jHhLy4ztH/j+S3dnKmU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XZ7qBHte5hMMTMKQ9PNdO/UnRU4/GPBRu6j9vINo/F/RycP5KSNPhew69959oA+5gQLcyb/3CvO1vbFdf78KXK/OMQdahGs6dH/pn3WM48BP31iS76XuEdXqR7Ec878+MzXchfLIHyATCoqKabTPuOC2Vn4Hu6qmQQfRGI0TdBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Brj8A/Zb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KqSeVHBs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646H4Kd21953101
	for <linux-wireless@vger.kernel.org>; Wed, 6 May 2026 18:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fW7+cAaB9tFYadSH4iU2QxnEOPZYkbnvDwiqGGx9hdw=; b=Brj8A/Zb65emycac
	3xJRMK4BCeAN+LdEAaWbPQMYPEBe5q8uyeizOGzX6DRYj4OHH8BiNdJ63U0NDtTx
	/oFQzG5Y2gm+cdTRQ6gb16EuD2zyg67CAraf1umrds9vnhLY8DwvOLAoeMQf/sj8
	QBdnnN+WLmIlan7uJurTmsrAhiXLx544xLzVXBcZy+NYSe1SYKAOxCwXChQT3uJS
	JinWIQAz2m5cELZZkxA8n41TdSAKjv60TyM4XvTcX7WKppmNWY1QKFZENrYl+5CH
	9RJafTx3bwp4UQNy1ujM256AZz3O+vVQsMnQTwmJDHiOH04FdQRhwjmXwyyyz67W
	Feuucg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e03jc1vdh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 06 May 2026 18:19:44 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c8247b55775so1020873a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 06 May 2026 11:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778091584; x=1778696384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fW7+cAaB9tFYadSH4iU2QxnEOPZYkbnvDwiqGGx9hdw=;
        b=KqSeVHBsijfBsWIKu7/rieMJBPMeHnmA9GcYPzvwAOY3htFjq+LFmRQCBrqNQNOnS7
         66b2rRmGlZSgHRhGSKyEFJvkTFLZkaXl1ndweVV+qGxEmAeXsrJr1X+FgrOeBt68KMYW
         vd5m/VD2hzq/hl8shrcEb/XjcggNfGopgV430WXe9jzt6ZFn07Z7RvMpBOG4sczCltj7
         yYy8AbBcxoPeihVoNZsPYlmZ+Yj1eyQvKw11+mMx21AU2wrabxqstWCCj0ktrePsBwcB
         MyA1c/tV1GfTCPXHDlF6b0GcBRn5bL+OrW6pWZo1xXT2jKQXNtAbj9L283AGdiJWnjmj
         2TXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778091584; x=1778696384;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fW7+cAaB9tFYadSH4iU2QxnEOPZYkbnvDwiqGGx9hdw=;
        b=QZEQ4rdnUWGFUmoq1QI/BTORMm8jwTeCJBB1bJDFPazemmMelBDWfAWwm6Jv34x10T
         Mi/TrO+cVmVvjAe9J4kcZWC9ak5QORSnXGk99rtgnqGKaTv5hPZaadC25rauikx+tDh4
         KDFKFclRnLSmbAlQAsmdD+QglD7asjYAEptjBqyj2nLHZ4Vv7nLlKpDfdSNTg0gDZ2cT
         UYkd4SjqloBmxjixo68Ztajp+FPqjOsaHg1VrK9oslfNPhkrTmBWovY7UfBUKCDa8e1Z
         81A0KmQQXggUbpqQradoDDlQuY5CnczbwRy/A/WNWubL4OpOC0mzG/Zx1NCnKbycxuVJ
         UXjQ==
X-Gm-Message-State: AOJu0YzykYxYMbNk5+MdHFLa74BMDeNypXWULUEKgwsDbR37uNYko9pN
	/mzgsaUX/hiPBmXAPe1kvlCw5NgYmYHPO/ES3scuLbQc3A1l0NbRMMzM2FBW12ObrIdeK68+1XW
	/B49hml4VtjI56dZku6JdcETdD8zV3PidaaBqF+7H59aB9ewHLRm/C7N9ebIxeBZBoAQ5Hg==
X-Gm-Gg: AeBDiesCBqo2pvqI50yz/Ysjt7sD5/cQrmlgHKlk8Dcc2XyO6K4zYdgr7FWnLwD99bt
	OzlhCHNFxQBMMykclvvOCY4MLc1qQdZ3lpuI706JylbEQ4xzgTi9s28s8KbhbDf36OeuvFhQRe6
	QEhl5G5l5ol+oInCR/5NKBNSX8AbarryKlJA7heoWO6kWYquvTpd5GySguXveRuCqbYiC14Ote2
	IspIeJQn9Th7qtZydHyyjIfQukA6WquQaKYLG2F8Cv1WTL2eei6URpccQE5gkhQxBQ3CsZ1hk1L
	e1/YsUP0TKCYV735XwCApfqPXfBQk9SZb3wyfYNP6V1R7L6EUhW2kYgFki7mQIPorbYG6OVMrjo
	Xx6kk76sX1EplsiJiJK+KiMbegC5u0Y6KuHYrOqyrdbj2Q7hS0a8dy5ue3AcH/zcxT5Yz5+JfgP
	BY
X-Received: by 2002:a05:6a00:4517:b0:827:3d52:5d1a with SMTP id d2e1a72fcca58-83a58a2afc1mr3812502b3a.0.1778091583955;
        Wed, 06 May 2026 11:19:43 -0700 (PDT)
X-Received: by 2002:a05:6a00:4517:b0:827:3d52:5d1a with SMTP id d2e1a72fcca58-83a58a2afc1mr3812477b3a.0.1778091583464;
        Wed, 06 May 2026 11:19:43 -0700 (PDT)
Received: from [192.168.11.104] ([124.123.82.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839659487afsm5831890b3a.18.2026.05.06.11.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 11:19:43 -0700 (PDT)
Message-ID: <005af843-da19-4df9-af67-2cd148b24d62@oss.qualcomm.com>
Date: Wed, 6 May 2026 23:49:38 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Subject: Re: [PATCH] wifi: ath11k: fix warning when unbinding
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260420110130.509670-1-jtornosm@redhat.com>
Content-Language: en-US
In-Reply-To: <20260420110130.509670-1-jtornosm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE3OSBTYWx0ZWRfX/9IM47f2AJoT
 w5cr3qdsJXUsT+jBfwEmV58LoTiTCYK8MH2d8cXF5hX2ewVFP8rTgF95cNaZiv0FdXXvLF6rA/6
 E70sROf+HC8jRMgz+hhNhJCstn6Vq5Z0HiB5exQbXeV3xho6xWW1sWyDwIeysT7Ks1M0UIo8+RZ
 /pKKzNkJoy5VdiJthtCWIFHAtkPETuqe0+SHYMr773PN2x88YNTyJ9gRcot6t1z1JoYIlpWbxI2
 gju3k8ldKGfqfRo0vz6h0UErW4XpeE53FtlvkUe6lZ1YHphkEKdwYUbkJnQXjY0c3torQAY8YIV
 1GDGihQ97y9WsvAJGs5hFHius8adeNiwtuO/jAaGKkn2FqP1GjZLeqfhYJXu+vMTVfyEBW+8yEp
 eRNOQLGaIW2Exs246u92DDWq5PvT4HK/ynpjfnMbrScRd6RGhTwI5mkIcLYIGTogydPv+i4ApQz
 /BTpBoZ7PnLVsS1Losw==
X-Proofpoint-ORIG-GUID: NVKP8Z-mSPCfEHNQ73vY9l3yrfsWGoKd
X-Proofpoint-GUID: NVKP8Z-mSPCfEHNQ73vY9l3yrfsWGoKd
X-Authority-Analysis: v=2.4 cv=EpHiaycA c=1 sm=1 tr=0 ts=69fb8640 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZCREz13nqshT/on6E9YcPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=20KFwNOVAAAA:8 a=vrVOvOPcliifg5cE6R0A:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060179
X-Rspamd-Queue-Id: 4B8F74DF3D1
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
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36038-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 4/20/2026 4:31 PM, Jose Ignacio Tornos Martinez wrote:
> If there is an error during some initialization related to firmware,
> the buffers dp->tx_ring[i].tx_status are released.
> However this is released again when the device is unbinded (ath11k_pci),
> and we get:
> WARNING: CPU: 0 PID: 6231 at mm/slub.c:4368 free_large_kmalloc+0x57/0x90
> Call Trace:
> free_large_kmalloc
> ath11k_dp_free
> ath11k_core_deinit
> ath11k_pci_remove
> ...
> 
> The issue is always reproducible from a VM because the MSI addressing
> initialization is failing.
> 
> In order to fix the issue, just set the buffers to NULL after releasing in
> order to avoid the double free.
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
>   drivers/net/wireless/ath/ath11k/dp.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
> index bbb86f165141..5a50b623bd07 100644
> --- a/drivers/net/wireless/ath/ath11k/dp.c
> +++ b/drivers/net/wireless/ath/ath11k/dp.c
> @@ -1040,6 +1040,7 @@ void ath11k_dp_free(struct ath11k_base *ab)
>   		idr_destroy(&dp->tx_ring[i].txbuf_idr);
>   		spin_unlock_bh(&dp->tx_ring[i].tx_idr_lock);
>   		kfree(dp->tx_ring[i].tx_status);
> +		dp->tx_ring[i].tx_status = NULL;
>   	}
>   
>   	/* Deinit any SOC level resource */

On which hardware did you observe this issue? is it QCA6390, WCN6855, 
QCA2066 or QCA6698AQ ? Also, where do you see the initial failure ? Is 
it somewhere in ath11k_core_qmi_firmware_ready() ?

I am asking because this looks like it may be exposed by commit 
6fe62a8cec51 ("wifi: ath11k: Add cold boot calibration support on 
WCN6750") [1]. That commit added the ATH11K_QMI_EVENT_FW_READY path, but 
the return value from ath11k_core_qmi_firmware_ready() is not handled 
there. If that call fails after ath11k_dp_free() has already run on the 
error path, ATH11K_FLAG_QMI_FAIL is not set. Later, ath11k_pci_remove() 
does not take the QMI-fail cleanup path and calls ath11k_core_deinit(), 
which calls ath11k_dp_free() and other cleanup functions again.

This is similar to the failure case fixed earlier by a19c0e104db9
("ath11k: Handle failure in qmi firmware ready") [2], where failure from
ath11k_core_qmi_firmware_ready() needed to be handled.


[1] 
https://lore.kernel.org/r/20220720134909.15626-3-quic_mpubbise@quicinc.com
[2] 
https://lore.kernel.org/r/1645079195-13564-1-git-send-email-quic_seevalam@quicinc.com



--
Ramesh

