Return-Path: <linux-wireless+bounces-38238-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v+cfG3TVQWqsuwkAu9opvQ
	(envelope-from <linux-wireless+bounces-38238-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 04:16:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C996D57C2
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 04:16:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Zs3nrd9I;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=JVGKnzc2;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38238-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38238-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72DB530041C0
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 02:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8001898FB;
	Mon, 29 Jun 2026 02:16:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA11175A73
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 02:16:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782699377; cv=none; b=hXJ7oJ76LX1FNDS8pM598JB3K6WEsQOc5O2IrZa+UePNnNQeXeBlzXroKoQa6vFT2R0IftmGZ7BZDsCw9qp2O12wfxyuTYBXp7i/34MpZSfK8EsBb1964wvw7TsWodizY6aCoJAC+ccbGeSMtFmqygLLmA+7QuU6mcxXoTzJVfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782699377; c=relaxed/simple;
	bh=2wV97k0EbcXGa04ASzTNWqLRrQA1jGZQ1LGBuHgsd1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KwyWvwLsZPqDHU0JMkpmB+RKiS+WT01e6r3YbsvcV9LaPMctrB6tIgZjrx/x0NSTYunLQUt0jxnS+rjCX9tC07B9HlG1OPSftfghpsY1PWVLyudJr7vL9PvZthiJblZNzgek79EGnKdtWFarj2RFTAS8BjFBDjk2q2AfmPRP40I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zs3nrd9I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JVGKnzc2; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65SM9Jnx942016
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 02:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O/WcKCXSif0OmavnvlrDGhjnNI9xe5H6vxO7cV3gu4A=; b=Zs3nrd9IjV/iScr4
	QJLf3b0PLmjGf9zDehBWydfbMe1o2+jnQkg01Vr1M1zvfTjdLDEtx2BpT41hhrZd
	EZ0may/RrL9MbCKQt7as8PMFt0K1/IWBrqJsNsaF/JGN13cZ9fqH1oJ2NRlbhY1p
	NlGOkQl8L/2xHRi8mY6Jf6YEn4Bw65OJErGkKXiCD5GYzNRELMvqKBcc7ZEwNmuQ
	KowN6/apOLOp8y7P1u0YdfW8D6nWT1dtRBNZrUG7+XXlW2jV8lC4fLoqW+9eC4py
	ZaaKAjeXlKKeYVwcZLbcjvqTxxK79dbVqDCaLe1/KmPQpfgC1HyU8/+4ZSxdnfz+
	rBjAcA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26w6m4ar-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 02:16:14 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c89704da8c7so3979830a12.0
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 19:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782699374; x=1783304174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O/WcKCXSif0OmavnvlrDGhjnNI9xe5H6vxO7cV3gu4A=;
        b=JVGKnzc2tZL9DFEYqj4JLXwG8CXrajm5HOIKPlrNGWvtuCWRxkbx6nSuuHXjfjxHWG
         yzhAcoj/ityBDeUelq3FzNjn83pIL+jsTjAwidXx6y+92/sHyU0hlJV2tcO9Fj9pE0aL
         fBaUATV9uooknFzzZkoUiTtYwPhy0PJ1heMTJUX5iuIANrDdhuIfcN/xpnqaNs58sv2p
         IXF1mqe2fJS9UvJHUOwSohRhy8ZkDDW7z50365FMgbqt6+ZzuI0PnhEcmt9ryaVEdYRx
         +WOKdIlKrvY0rL/VYcuZCpqAmKPF7gbF06hX24m7zULSjHqJujOMSNYBv2dR8vfrZQRc
         6icg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782699374; x=1783304174;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/WcKCXSif0OmavnvlrDGhjnNI9xe5H6vxO7cV3gu4A=;
        b=tW+15I7c1HNlkX24YZR9SFLVPQEh0yu2AHrnNHmGX0/kzLKJ/F6BDlPeAfwWWgo7dB
         zxByD8dfmPNAZIubJJKezDoHqxF8e+7k6rfWVS0Hhsqd2w+CBwXbLCPsBrY6fZDPQo4w
         1jGOMm2lxkoNL8Oq/UMYkSdx8PX9vhmoo0SBJ17g5egPuGg4b4lvsim82C1vlqYm/Bm6
         Rsk1EMw5uSxwmgH+BuiynpzOaKDdIZ+J8i/NhXiOkFyiojjOfwwhf7UD4Zkz+QOdTJHz
         yFy8RLYCcll5Oa7YVr/29XHJLX5bccyptm+vze8eKkkQejBUNNMMNQ553OGvykvpOCWS
         Gwdg==
X-Gm-Message-State: AOJu0YxSBhxIWYa5zJmGxXLzz3ye3oKpK2aLQCbQqWJyWMg1bK2Sf2dm
	pdfWe8cq7JpILDm2EFsqzIZ8rY1NUV2pGyGzPF3IQjA09p0eRq7+YbfRBw9QZa/V18VZAeBWeqj
	vLxVdJGPMgxeucaR7yjsl9hLwcxpG4FP2RhFCD2vqynCj6Z36v3fzttdU59dihoE8rL3OqQ==
X-Gm-Gg: AfdE7clqfVH7nE915xM9VmOrPs+xTyBE4D6vY6gPyL4uDydwIxWXgm6S0ZuUNgSG4La
	ZLdJ3DCShflznpGQCZwz7JtNPuv+OakHa76qN9Pl9lBEWFXKNnl+WFjX5IZ1X4AbBlhoqKE204k
	GhcTFxxMNr88OZsaOUVglg/GIozivvlfsUdlihD1S2PawPUD2tJ9wOidCHonQEWBrJzKU0xOnVt
	HSfEbQTqXRQe5jGGY4GnxrPEvIq+ybpjR3vwj8w2Vxyc+fr7rAwA03vMry4XCCh/lgrYzMQFdll
	GL71CDNDNq9ia21WgLKWHZss/hcpFfFpfpzDkdjCzpzMtXiqDL2W/LIrEtHzojjyxWaC3V/oGxr
	rhxCB8gWzCaPix43W4NI8LA08nQJtW4vxLebUp/mllkN280JJ5kvj6orDfdi7La/WUf6gM8hx1S
	SBuLYaDA==
X-Received: by 2002:a17:903:298e:b0:2c9:97a8:8c1b with SMTP id d9443c01a7336-2c997a892a2mr66008935ad.46.1782699373901;
        Sun, 28 Jun 2026 19:16:13 -0700 (PDT)
X-Received: by 2002:a17:903:298e:b0:2c9:97a8:8c1b with SMTP id d9443c01a7336-2c997a892a2mr66008755ad.46.1782699373433;
        Sun, 28 Jun 2026 19:16:13 -0700 (PDT)
Received: from [10.133.33.8] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5ac7c9asm82317545ad.4.2026.06.28.19.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 19:16:13 -0700 (PDT)
Message-ID: <f265457d-a876-4e5d-8cac-25b5fe2180d0@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 10:16:10 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: change MAC buffer ring size to
 4096
To: Yingying Tang <yingying.tang@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, yintang@qti.qualcomm.com
References: <20260610031358.2043716-1-yingying.tang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260610031358.2043716-1-yingying.tang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: eYX7l3Pk5riSY9LGOP8Lvka-F0SeeplU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAxNyBTYWx0ZWRfX/glnS04f96L+
 kgdl18RUmG6A7vIoCAmk+MDaedzI8b9Ax68l8l3Wsvq4/CkpxYIRkV/99jlUf6YfRASCrOaVwu9
 z/Qdk35WVeQMHOSNCKVtDTgf3nUxYeE=
X-Proofpoint-GUID: eYX7l3Pk5riSY9LGOP8Lvka-F0SeeplU
X-Authority-Analysis: v=2.4 cv=SuugLvO0 c=1 sm=1 tr=0 ts=6a41d56e cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=7Sa7iVnaTNRCtE9djW8A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAxNyBTYWx0ZWRfX6ni6Ot2UUMtT
 rlvkHcmMGYpOAgMpjtf0JXnViL9rZcPvljJaajOJ02zpVvOIxQ81j7F6hEvi6XAFdrOkyLWRPRy
 YgizG1SBWZRzTeaIFVfpEjU78zhzshNq11LJhV4p2Ioy48waWsMj9APb7r3aaGoJ5fQjUbAe1kx
 B+fWcC1PDeZdZck1Gj7gd4lkD8PP9r9IgOTuukI6ULlV/6cnkjoBtEVso2QIgi0/rGkV0DfdllH
 BHSMBAWa+9YNf9PCEknMJgHpRduK26Lug7JquT6DpWrLAp2TMhDhP0sSotzdmjCt3K1aAYzKKCz
 R2mkO9zXtDbcSs5LGMG9H4KWGOPMyaxHL13RBDGAe/bF+A3wxHZVob8GIBuDQ/vY+mBU04Ih5G/
 vyHjXRf7iXwnh79nJVLUarKtwAMSLp7eivtMKqlPjQsYE9EFugHj6x10IUCOXgswJBjL0SPFKie
 /PPkIhmRYHhNKLCPo6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290017
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38238-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:yingying.tang@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:yintang@qti.qualcomm.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 04C996D57C2



On 6/10/2026 11:13 AM, Yingying Tang wrote:
> For WCN7850, MAC buffer ring size is updated to 2048 in
> 955df16f2a4c3 ("wifi: ath12k: change MAC buffer ring size to 2048")
> to increase peak throughput.
> 
> But during the RX process, a phenomenon can still be observed where
> the throughput drops by about 30% from its peak value and then recovers,
> and this behavior repeats during RX.
> 
> After increasing MAC buffer ring size to 4096, the data rate drop has
> gone.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
> 
> Signed-off-by: Yingying Tang <yingying.tang@oss.qualcomm.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


