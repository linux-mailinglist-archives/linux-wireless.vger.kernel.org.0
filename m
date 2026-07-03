Return-Path: <linux-wireless+bounces-38562-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ho8QHMNeR2qrXAAAu9opvQ
	(envelope-from <linux-wireless+bounces-38562-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 09:03:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE106FF575
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 09:03:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=LAg++SWT;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=G7G8x3Jw;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38562-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38562-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7F07301D300
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 07:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930BA3890FB;
	Fri,  3 Jul 2026 07:03:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A45385D64
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 07:03:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062195; cv=none; b=p350RGXBaOgMbgQE+ixQhYHZXnlingB/6+sTveUZFNcqvU0TO9jARNTIkRnQVOhWk3CbRr/LFK0U/Fub0eo8TpzNs6NIOFik7pSxAAHW2R5vrWNBmXaIgr7t+hAqmGxRxNuMfvNIF+DYExBBlkSztl7GG47ecWxIwpqJMRliRKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062195; c=relaxed/simple;
	bh=TgWDMBA8wBid/5uj81n/1acJBxdNRmfF5A/muGuxN78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qHaqLWjRxE8jl1XZvRJ1VMMDdKuks+1CB3GZT3KM4FSQM/BQC+GXk8NtsVQ1ROby8iVNCuwPdFG5X8tbEXnM+hwhPIDLxycPl4zuqnUHkwgZWxgavE85Zv+PyrZitZB+dFuJaqTh2Z76JqDUkq/1ZaUxT61zycrlX1SFWv7OOLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LAg++SWT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G7G8x3Jw; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635rbPd3129038
	for <linux-wireless@vger.kernel.org>; Fri, 3 Jul 2026 07:03:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xLjqNjE91E9tE38yfvP00apwIjFuHuQeDSgtrb+rTTw=; b=LAg++SWTpblLbrBA
	SIcv8/z77S0AxnOGptOBEiUPuGfIxkfJ8sJRHSlc1zfxf3vYh1U0oFZDAWaKnUAQ
	sTTdLXPTlFYnDAdGdH9qG0u+oJXsy6YL9q4OfyEqyvJoPpdJiTr9zBGA6JyY1gAH
	v8Jx/x6OoeI8mxWUu3P8C4TriGxaf9HYuWtCT/Km1Bwrnp1mIHDwALB0iARtZd7+
	LQ0/E6H/Gw+LDK30Tl9MHMDUTUaxEr+0I8Lv8Tffmy2r9Pa5fihyuF4hqjyUZDlx
	IVDZpJIAQd30jsViErpuQZYizSNI8yo6NkhJEQUeg6wv6UVBFobPDY0uVGaPSOFl
	3ErZfA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5qfc4b6w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 07:03:13 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c8952346bb9so289649a12.2
        for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 00:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783062193; x=1783666993; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xLjqNjE91E9tE38yfvP00apwIjFuHuQeDSgtrb+rTTw=;
        b=G7G8x3JwFL44zDkwJB/h65D7bBTb+FwCCSmpx4xMN6yexva6LuLWIN3+pux6KT8nP3
         75DABUnZheiOfPHef4bKRq/4dqd2pNKgK+QH/CTam/zyxGSAVGdxngRxvkKagy0sYIB+
         9Hzfh6nmXPsLvGgvIV4wejGs5JKZw4p/ttI+cE4LLkjsONiZunRK+8fhyITIpn+LWRyQ
         9CJEifPd79yYRhhsOuV3SW8Y/VAVUjyqW702PMPw+mrAGFauyD8r6awGjzU8Tsv+8hx2
         NbsrAp/f85k+a8mD8OuD4ITyXctbJVTARGg1jMbaalPR3djFyqe7BrretMSJMAeEEGEl
         luZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783062193; x=1783666993;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xLjqNjE91E9tE38yfvP00apwIjFuHuQeDSgtrb+rTTw=;
        b=StzZeEHdOBRGztb0ks/DP4rL/tDa2vjf0ezvlo8yPzSPgLdy+kn4ijUtwLPx6nF3R5
         yWuju5x8/ov3OaPcGuqWlznittq88VDA2khnuWlavO7s/0iVadEYm0bOMLd6pmHLAZ31
         PueGxD4YY7SB1rg4jzK6CklKlezHmz64ZTgYlZi2h+VVymo30iJ7cInryqtb3IOrq4Ay
         iDp9liebE9Ifc3hJqcoOMAQpiEwcg44QJZnWz/7aEvuZ17AIV5raffA4wOcushfnZ80W
         VjUUq/5qyPYbwuf5UvKXiLCIltVFW5ZZJOU8BKuE1eQDVAZeOXYWQAq6yk3u1G/1Mp3p
         MecA==
X-Gm-Message-State: AOJu0YyhRukiOp7G6s9dBLadcFo8Fb3JK2gtJHe6aDKGygPgjp52U3IT
	xGzBbQVbmN1G1Kfl0qHAtt8AHCJ0OO1kGUeO0O6iDHlWxABcsmi8EslERr2rP9MYMp2obUQxnNN
	TqmfiJHfRf5DtudWde4GFTdpYHi/mMFg+2DaZVboIM+Jtc+8Od8yFbTowDCXdLi6H/FsF/w==
X-Gm-Gg: AfdE7cnwDTNMeP1Mto9ZNG90s873A9Zma/zSDrVBXeGfX7MdDzOkXMm1b7HkfdR88lf
	1wJc48MRQRoE4huYczkUiH72MQnIrINzRrL7fRcv6NCp0hZzbfxBx9xON1AWtxEttipOUAPp9Fx
	JjjUMpLWCDhp7M32/9ARs2vzyCH4W3WLuhTmDOYBpoTWczPLcuY9HNI24Wo55zeTEpdrzQJOTeD
	qfzlf1pybJ5CG03etEd7gqoRDgdXOeJM5RnO6+zKb6o+VzeGiL3mipF23/ltr1pIo3LskQ9dAzA
	ugweOHo8o7ngdkBGKD+Mkxhz4EbJ6FzrnSDHhkGBira9hkCykuZGYErWP8qSGHRS89gErNxXE3u
	Z2e8D6OhLX13su1Ibk3KT3cs5c8ZNA8J0ZzABkVYVpI9MoaWTGaJCb8tTWVMBu/UQ7Ga74mb0xG
	jySHQR9Quw
X-Received: by 2002:a05:6a20:9187:b0:3bf:c126:bb02 with SMTP id adf61e73a8af0-3bfed4818b7mr10616383637.47.1783062192667;
        Fri, 03 Jul 2026 00:03:12 -0700 (PDT)
X-Received: by 2002:a05:6a20:9187:b0:3bf:c126:bb02 with SMTP id adf61e73a8af0-3bfed4818b7mr10616339637.47.1783062192136;
        Fri, 03 Jul 2026 00:03:12 -0700 (PDT)
Received: from [10.133.33.211] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e921d28d9sm2139230a12.24.2026.07.03.00.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 00:03:11 -0700 (PDT)
Message-ID: <d492b10a-7445-48df-b752-726e5c02f5be@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 15:03:08 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath11k: Flush the posted write after writing to
 PCIE_SOC_GLOBAL_RESET
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
        mani@kernel.org, Alex Williamson <alex@shazbot.org>
References: <20260623141649.41087-1-manivannan.sadhasivam@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260623141649.41087-1-manivannan.sadhasivam@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: d-uYxYvCjnCLC_eWR5D2LP1xdgW9TioS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA2NSBTYWx0ZWRfX5f+dufUYPxOd
 baqvSwIBRSTTiTxb8DOjyEj3VMhk16a2wyjm2JcXkREqRizzlzzNBJa+SiggKRTGZW4S7E8rU9w
 fblkCVj1cVPe+52DDyK8ceeTSXBpjVrplq4aGUm3G4unZJD4+EFT3rwviNtJh+m8rSBTAnQVxxq
 ujEepWmzc3g/qnsOVfDdH65zU6fGeQgfG684zm+4seRfd54eE9NlOKVdrdlmHsuHILuUqtokTVp
 2iVwO/by3neoSxZlT9H4Og1B5mloyYczHJafXg4esNLEm07sQvT+7OP6h0E6MSCAoyZN21U5Fpq
 DtIiVu+eFiWqZZp4ZJ6K+6Ragoa6UOp/yF85+/Sq2Pfzy4xKggNnVZwng8j9Twa1gX9aCk/i6nB
 EdZMAFlkFc/Q+cGw8fvvnXlYLSIVRCwimhfDIfvRsMQl58T3LvgNKfUVVS2kdHyockmeNO+4Qb9
 bCOZdBfQsg3CuidIMcA==
X-Authority-Analysis: v=2.4 cv=dvXrzVg4 c=1 sm=1 tr=0 ts=6a475eb1 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=r1p2_3pzAAAA:8 a=EUspDBNiAAAA:8 a=fjTVS2QutaehiSyZ5pEA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-GUID: d-uYxYvCjnCLC_eWR5D2LP1xdgW9TioS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA2NSBTYWx0ZWRfXwgPzQ5ZqIIrB
 987/pI5GQ3ErS+0SbCLrz6Egflxyhst1mOMYAsgDt805EfA9EtoJ0jpeq7z1w/CYulmJUABZsTM
 Z8u/5+m257p3rzg3EH1AlNdQpo24++o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030065
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38562-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:manivannan.sadhasivam@oss.qualcomm.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:ath11k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:mani@kernel.org,m:alex@shazbot.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,shazbot.org:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CBE106FF575



On 6/23/2026 10:16 PM, Manivannan Sadhasivam wrote:
> ath11k_pci_soc_global_reset() tries to reset the device by writing to the
> PCIE_SOC_GLOBAL_RESET register. But it doesn't do a read-back to ensure
> that the write gets flushed to the device before the delay.
> 
> This may lead to the delay on the host to be insufficient, if the posted
> write doesn't reach the device before the delay.
> 
> So add a read-back after writing to the PCIE_SOC_GLOBAL_RESET register and
> before the delay.
> 
> Compile tested only.
> 
> Fixes: f3c603d412b3 ("ath11k: reset MHI during power down and power up")
> Reported-by: Alex Williamson <alex@shazbot.org>
> Closes: https://lore.kernel.org/linux-pci/20260622160822.09350246@shazbot.org
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

