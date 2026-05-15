Return-Path: <linux-wireless+bounces-36457-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL49OvW/BmqMnQIAu9opvQ
	(envelope-from <linux-wireless+bounces-36457-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 08:40:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AB154A119
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 08:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2073D304DFC3
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 06:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF129382F2B;
	Fri, 15 May 2026 06:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gh5kY4th";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NHMYkBkS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30D6382F17
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 06:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778827221; cv=none; b=Q2y6jET8a4vHR/R0emlAP3gzZnVAz7VLdB3mA2jZsfAI1nRhLTCeaUZVxv4m0tk6iQXS+33OrFSdtml7qs0vdr2LcZ4RkLhm8MeIqo3+vPiv6FgP9C8/MQmr2wHlr6J4mSOCNbYxf5RSxtV49WIjRlaxHl5T4hcpIEudJFEJVVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778827221; c=relaxed/simple;
	bh=Q0fR+h+Ny0trHoJYIyqcs81BVJuRY9SId0Fq0KRsxkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AEMSdn59pV4t6RJ3H4m0ZGSDml7J4XVOJZSwD7dpc53gUXn+sXAMYkq34mbP6wotmON/sPBiaspEUe2VTyw+/HPijbjFJw4Mk6oi1auVR/JJ6bN3iQXNci8GfEokjY8FcCR8R35vYoWNu6UFZhQBBTqdrSv2+MOsAlpVAF7gw24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gh5kY4th; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NHMYkBkS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F5jatJ3512838
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 06:40:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GaiA6uNOJPCPDvEvr38gVo7es41f1RVtqIB66QY5CDQ=; b=Gh5kY4thgyjLnnH5
	u7sikvnlHnCPBmEf9Dzyskw9qwVVuDlL956K/pD6UBldN3c2UMhw46RrshvPqLkJ
	iNQbPhF+q4HZDOs3hUljWAXpTdnb1lcxW+1Sj3UdB8JUHrrKWLl8RDvUWJZRR+Z5
	xfX+IQnXHH7k58LvIbvnuhGjjeKkMLQVawn7eFm8pOGtABKIBc43C0F7FDp0K1cd
	AddqmGdJwJpWh17TlpgvnN3j/m0fsrGTE6lucJx+W0dp4+jwIUbsSQt1yW1rRjnq
	l5O+3wO4IcFOcwsRzZxT+N6fBhU/g2Zw+HWZJezY//dQ5IRfFEhhn1NMdwhqyPUm
	VPD5Vw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1v9ybe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 06:40:19 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-837d0d71c61so5323801b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 23:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778827219; x=1779432019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GaiA6uNOJPCPDvEvr38gVo7es41f1RVtqIB66QY5CDQ=;
        b=NHMYkBkSY4dp4AxaDxLC1jVwwYluzpGGO4w2hLWRlZ0lhnmYiG2CaLjYgozRnr9lbP
         2SMvVj7CSqkJNX/DZF+HORM7DFCv8yGDPXw3TvlNXSjx7whZk1/F8NM1iRlTW2vDQ8vj
         JFTBZ4ooFYKouwn4Bj/oactZ38XwP2YkH1A663NLY5C+dUnt5CXlAi+oXHzIcuakxZZg
         IYrhSWJ0w9z4g0ySqYihCf5WxKHPryPGwe4TB+jhFcd3AV6DW7FWHlWlVvpFQhWFnOtv
         S4nrS5r2GB8rBv2haZL6Z0GkSBmdrI222CcL68nuvLVFtsWjSmFpI/TshCDKdN7vIkOT
         qX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778827219; x=1779432019;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GaiA6uNOJPCPDvEvr38gVo7es41f1RVtqIB66QY5CDQ=;
        b=luPgiUNutmpUTXt3dyBQArSybwnxhONPdNANuWIKMXw8RqOekBgMxz5XTw2OEZD3oD
         QmXGJtdFZQiF9MTeyiStlPOg1cMQr/WedflLPd0Fep2s52v+y2gYYNFMJ3KONONdrUAj
         RDGPaaaA1VRX830y+9asmzbDHIH68VQZEqGFjy6INQMCLjLnVQlURArPk8aSH+V4v3KY
         6ii3L/pF5FQA5SUHVHcFWdy0jkVM780fz1ucbkVO1WX0quZsg5pQcZf0Q+dHb0veGKsb
         mfUGP+axh+urTVcHez8zg9sBwWbnfLyHVEfQ/iKA2eY/tGsgd/wQatbotrXCKEpdqYs4
         QjUA==
X-Gm-Message-State: AOJu0YxLqk+YoPo7IG1OG/8+86jeVtgv3O+hQy61VhMJTzMwOOwD3yJI
	qWc9sd/z0HF/JAs3Nly1LoqCJfsytGwllawe7QSDTrSGwW47JWpYnHTWi2h+rM3SYgfwM8AhqT8
	pOj62az7yqU7ePS6kLLKBxbX9w+keu1iZdvYQLKvy/gSTUgQ8k4vN7oWpOBXQWfZI7B9IEA==
X-Gm-Gg: Acq92OE4BThUFtiO2EEnQlowR1uos+qycd8Tq/3v6MfPtVznxFdpM99D1B7WcWTXZyG
	VDomG2QazgM+4svF8/ISSYo+Il+mKMqbTspAsXEPNmfRHbLW6VcOj84IHzoYL/JyTm1SHtSI0cM
	NFYmirY6ToARlsTIT7znzYPAzHIqpxg2nwpBwZay5EnAo5sbDvUNKagMwdOtbanNfWosbCGoSvQ
	6RkE33oZVaCxIR1spgEkX0iJWQMF5ZBADemjqFP8C/dn+jfAQpJV4PE1An9AOxSjB0FV1cEHDN2
	Cw+HPwUVwPZ/oIwyAQgJ33dgbcEYM8XkE/aZq9fTos2myfCET83CwDnj3E/J676Z6VP+37fd0ab
	m+Bq/eYsEEinErArHOHpPT/gI8KbRQiRc67Yvpa4ZkQhOWbg6EhS5VdZowbnnq8ZnT7WcCtlsmC
	RJ0iR+RXveB/mkzrMNlA==
X-Received: by 2002:a05:6a00:32cd:b0:83f:250d:5ab with SMTP id d2e1a72fcca58-83f33bc8888mr3191652b3a.7.1778827218605;
        Thu, 14 May 2026 23:40:18 -0700 (PDT)
X-Received: by 2002:a05:6a00:32cd:b0:83f:250d:5ab with SMTP id d2e1a72fcca58-83f33bc8888mr3191629b3a.7.1778827218116;
        Thu, 14 May 2026 23:40:18 -0700 (PDT)
Received: from [10.133.33.33] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f1979a0b2sm4965276b3a.26.2026.05.14.23.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 23:40:17 -0700 (PDT)
Message-ID: <a587a83a-8b72-4e93-8050-654932cdffea@oss.qualcomm.com>
Date: Fri, 15 May 2026 14:40:14 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix warning when unbinding
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260420110130.509670-1-jtornosm@redhat.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260420110130.509670-1-jtornosm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDA2NCBTYWx0ZWRfX0TfaerZdBDfG
 SwTnNuzgps4DjeoWUUfe2BOY3RpyJNFN9IIaQVjqsY9dngpk4TwOVYeQP5TPcPjgHZYJtRKrR/x
 iLGWeG17nDuCPXFgDzC30LyQD6YiHh/Iwg3+b2riMh/gFzGjpmKbejd79WReet1zj3moQZTqNyu
 It5Cp0pAUObdUZIwoLPsB7k2PF+9Soblz/FCu7UPmES8Ze/S8S7Pe0/l3CYm4gCtLKju2W6M00X
 RMRP9rqUCzMw8gaV81Rqn5r6nyD96e81bUYxI/jivtfv+GGj+do5kNeT6rqmwgXQ0wN/H9LQacC
 XhAe9KLKQlQ9lz3vYtNr2aquEa5dqIr5wpULTmOluf6n2QyA6UGT+4lH2/i18IDJ05hYsA1S5It
 CrP4EY2puez847kfgOXLxXAD3JmAOIO031YbrIRyuVgz8B/tH3KV8GQ9MF7tWqLxfIK8XOuGb0z
 OtlpRRKcHJ7y3CV+bTw==
X-Proofpoint-GUID: 847xoONo1ulPTpzXxG_QdB_JtvPA4tTu
X-Proofpoint-ORIG-GUID: 847xoONo1ulPTpzXxG_QdB_JtvPA4tTu
X-Authority-Analysis: v=2.4 cv=BvqtB4X5 c=1 sm=1 tr=0 ts=6a06bfd3 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=qhnAyV4-s4WfS2nNwg8A:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150064
X-Rspamd-Queue-Id: 63AB154A119
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36457-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On 4/20/2026 7:01 PM, Jose Ignacio Tornos Martinez wrote:
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

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


