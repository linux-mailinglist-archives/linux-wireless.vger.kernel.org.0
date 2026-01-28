Return-Path: <linux-wireless+bounces-31257-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gI7eOkWTeWmOxgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31257-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 05:40:37 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 745819D085
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 05:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31BA03006391
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 04:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD9C26CE1E;
	Wed, 28 Jan 2026 04:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BbbMTq+A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NSRSwdHO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6820AC8CE
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 04:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769575235; cv=none; b=AFi0fI+agF5reYGMkUUMj83PIOKziJATeowPw9g839N2z/Zv/hXOckOSD9paUN9CfRnNRH4MqZgfTnaxoxqrhhWymDWvCo172SvrA/qGyr0Hlb0Wnmf345SdBZIC1MKRRfZoQGMkM7bNoue9y1kN9N7CQYQUCj46xJBZF9/XuhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769575235; c=relaxed/simple;
	bh=2hlFAqO3qB2QC6AhywwHFACKX4BXjgMz6a9qqEbJcDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJSwz8+SHL5462wE5i/sFLKn15tCBDdj6l4MeUPvOfi4eOU0gOBHLuMsDHs/+QtUBNWcZA5SDw8thGcKjg0YLbE/02uSqqPtClwm7afgPUjc4BiklneOOnw/OvqdWLkamr/a0KcGM59bIxYGst7JgHSwAKABVTjMPePSYJBliAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BbbMTq+A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NSRSwdHO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RKS1CI4003922
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 04:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qsI8x1+1AxWlVFIaQi6U91irGWAOKoUGy+gyTSyLEs8=; b=BbbMTq+Ap0srpbMe
	Ep4LFBEIXe//FMwoZ31CpOPwE0ccDfjG4SFzY7/YqdxMaBm116ZXcv/KvCoXcg3l
	3Hmzf+6tCpILut6lbimB8zg1l8ZiXad1hWnVFI3mqrMXn5UOGy6NslUzQk0Grr62
	3X2JQFp/MWyY0UKeQcEE7qt4xNZEE3C3plBlhtWjBPzx2OFVq5awhmvHmUI0IoXF
	z3AekujNMQjaEW2mZh085SK6pIHJr3WrpDGv2DRoEjG2U2/wFsr87Qvr7AN4RYKS
	a/3d+EontMdiQaLil7+dKHRjp+IsgblPX0gcunHiKlxsLA8Oo3Kp+/RY6lIKlGAQ
	oMSdcA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by4dys9ej-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 04:40:33 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b6097ca315bso12168297a12.3
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 20:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769575233; x=1770180033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qsI8x1+1AxWlVFIaQi6U91irGWAOKoUGy+gyTSyLEs8=;
        b=NSRSwdHOOz85GJCX6RX+7jqzVEFPlvozh/UD1oKIIq8Wzv1ljwXj62lW5DH9PR649O
         wbLUaEMDmrC3j4FeMUE8AHCEeUjeA2pQ4/FQWtFsHu7pc+ovMpmjnB6ZGwqRDHAoQY7q
         Ra+l/ULeUZkYSNJq/EtDFc7d03Wjcz9qFjZKa8sDaEpOymwSd/diiQ1a2EaTvjKhP7qn
         R04FfKLaNWe6AoxmvbVnicHQeGjBXVY7cL1HsQ3nA/yYv4nrY/qShFuQ+FYQK2lQKMxn
         S+jc0EvCmSpOHQbBpMUpWmxvpKpQRDESAfgUOEuY45pNOkMqfTgJe5jtWkEPr4qQTVRe
         PVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769575233; x=1770180033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qsI8x1+1AxWlVFIaQi6U91irGWAOKoUGy+gyTSyLEs8=;
        b=lp0pb2KZmMLGIe+f+VIs/KS4CnEaoLObd07VCVa0Zw99vM+yNkDwrPbegXrLdQOWT0
         c6xl45PUHKlooL3f048QXmKDuklsZCeADGtOWC2SCYSaSM408pNlWqkJbcwA+u0vefYi
         bzL0ufujadzYAlZE69UydvaWr38rFkT/BjSp5yvziCx79H075xfLzXnEj0IAmpo2lYOY
         Ec2ruv0fouABqZrfGaD1NdoV+I3GsQ+cawskCuB9VVlW+2nYWvISks5HdYBGOpRfa4T3
         KOAJ1Ropf4jpXnzzbRW73eJp7TShJk96lDmKMHTCzBdE6eXsgYBite3rNmuKILT0OdF8
         XnLw==
X-Gm-Message-State: AOJu0YzW1jQbVcjv92p0HanKzjF4LowE7S/M9zftFSKsmZtaHwhMEi4x
	UhGYnoNl5XmPI5uOJkw0SMhIfN9cOWf4LD1wtUmFSGxPx2QO1qvU+VBMQniZMJ0bHR6lo/0peYY
	STY5VxHJssKAiSGowr2kFhzAVXxzGzlazlFzFvT79glmHNkQR3iKRHuWXHOCEsheoL9pfkg==
X-Gm-Gg: AZuq6aJx7KuD7wBaXjMO/TbxlX8K15w4449yAVV7CWPEmTDCLdlp2KT/+VlWp/thFSP
	aaYwUtYMhOswplNEtZcABUF+jXrl/TiwtQbYlp+DBpAvCKH2uc9HHdj8rcQ+CsvM4GN4cAEmSJI
	gVW6uDFE8PxE67F4bOOfVbgelRmnE6ya7LUe7iSOaGtM/ZKVaVBLp5NddLtzFIEM+OzEyOb+e4F
	BXL0KIH8BNVaXX9Ck5knSJLvdtEJ/dGJjiUOWDLT3k8TWceqHsHYIJR2Cw4rvRTno5DtXZAkhLs
	06zcmvKxkZFpJJDgTe4TLPMvhfDgO9nT1KUezw5tyWF08eKMmiy0zaGYu95MCWPXFsbBHZET0sG
	Bz2yrb49dXGR0HUgB789+sldYt5M+HIWiUYyvxuITd6P0RhxTohkTM2c=
X-Received: by 2002:a05:6a21:1f8a:b0:366:1934:5234 with SMTP id adf61e73a8af0-38ec62ddea1mr3827853637.2.1769575232688;
        Tue, 27 Jan 2026 20:40:32 -0800 (PST)
X-Received: by 2002:a05:6a21:1f8a:b0:366:1934:5234 with SMTP id adf61e73a8af0-38ec62ddea1mr3827831637.2.1769575232187;
        Tue, 27 Jan 2026 20:40:32 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a33607esm885132a12.23.2026.01.27.20.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 20:40:31 -0800 (PST)
Message-ID: <5254be31-6f3c-4a06-a73a-176e930a04a0@oss.qualcomm.com>
Date: Wed, 28 Jan 2026 10:10:28 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: clear stale link mapping of
 ahvif->links_map
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260127033400.1721220-1-aaradhana.sahu@oss.qualcomm.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260127033400.1721220-1-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XqT3+FF9 c=1 sm=1 tr=0 ts=69799341 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=46pzs6SXUnSmaBsRGOsA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: y8Cy7WsfAYWfq18liVe0Ojg42f0XNvGN
X-Proofpoint-ORIG-GUID: y8Cy7WsfAYWfq18liVe0Ojg42f0XNvGN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDAzNCBTYWx0ZWRfXxEqWVzZJBrE0
 GutwZpVupGstUt2YKEhxCyLAR2HK+wIwnTfkhNXWuBL+yXCzNvjIJG7Ve4y2r9DTwgnj98Rz18t
 loMTewXZQfXd8CnaR2i3qTFs1mdMO/akW6zD14ZTFw36QMIKiDlgpWhQMi32mTk7CaPU/hyCUUS
 2IXtTaqyDPIE8odgktwXOpG4jbEvkJyuYd4RRIaHVGTnDXnM6vUM9c8E9VPRxGD8P3AAnSVxAdf
 3Zj36VcJHeyLyNN9PAhiK4vW8rtT7Nc04DH8CuGfrAD3LMk7x7QMHkuLGaNJp4tL7mteh9ximmo
 NdBdL+kTR0sdwCcwuyazgIIPQH6yj5u0GRKP0dRQJOXS6QxD5d/A3tk0HEgpO7eKgjLrIShGzgk
 R+IQkbCMRTrrkg1yiEoLLLERi89SBtkTRiLZCAES6B06A9ymk0eM0AkPw7ky4pPFVlAeOAFKmXL
 Ct7r0jZYspFfltLfpsQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_05,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601280034
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
	TAGGED_FROM(0.00)[bounces-31257-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 745819D085
X-Rspamd-Action: no action



On 1/27/2026 9:04 AM, Aaradhana Sahu wrote:
> When an arvif is initialized in non-AP STA mode but MLO connection
> preparation fails before the arvif is created
> (arvif->is_created remains false), the error path attempts to delete all
> links. However, link deletion only executes when arvif->is_created is true.
> As a result, ahvif retains a stale entry of arvif that is initialized but
> not created.
> 
> When a new arvif is initialized with the same link id, this stale mapping
> triggers the following WARN_ON.
> 
> WARNING: drivers/net/wireless/ath/ath12k/mac.c:4271 at ath12k_mac_op_change_vif_links+0x140/0x180 [ath12k], CPU#3: wpa_supplicant/275
> 
> Call trace:
>   ath12k_mac_op_change_vif_links+0x140/0x180 [ath12k] (P)
>   drv_change_vif_links+0xbc/0x1a4 [mac80211]
>   ieee80211_vif_update_links+0x54c/0x6a0 [mac80211]
>   ieee80211_vif_set_links+0x40/0x70 [mac80211]
>   ieee80211_prep_connection+0x84/0x450 [mac80211]
>   ieee80211_mgd_auth+0x200/0x480 [mac80211]
>   ieee80211_auth+0x14/0x20 [mac80211]
>   cfg80211_mlme_auth+0x90/0xf0 [cfg80211]
>   nl80211_authenticate+0x32c/0x380 [cfg80211]
>   genl_family_rcv_msg_doit+0xc8/0x134
> 
> Fix this issue by unassigning the link vif and clearing ahvif->links_map
> if arvif is only initialized but not created.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 81e4be30544e ("wifi: ath12k: handle link removal in change_vif_links()")
> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

