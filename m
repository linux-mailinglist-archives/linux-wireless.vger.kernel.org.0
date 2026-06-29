Return-Path: <linux-wireless+bounces-38250-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZWK+KHwFQmpeywkAu9opvQ
	(envelope-from <linux-wireless+bounces-38250-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 07:41:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E09D46D613A
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 07:41:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=cBvODaEc;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=PdzBpem9;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38250-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38250-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADCB03006B43
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 05:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0901D45E8;
	Mon, 29 Jun 2026 05:41:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701621BD9D0
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 05:41:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782711663; cv=none; b=gavxZC7GjhMaPFaq9gNhsyUyb21ab+m3sLQDmoJLffzsNt7Izlh2mjwNt87SbNjV+PHbLQqT+H2v6DvIdBid8pjnXb9ww7ClsYjM9fQONWlJAKjohcb/uuoFKBEtyXBxUzo2KmIEPmzsg7K9C9TPZll0nNjndj8jRejAMx/8uq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782711663; c=relaxed/simple;
	bh=eh3Lq3QtYmOuTvjJGAk4MsOuswJxLX8Ho7Znpib/QCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=st0asG1Hb5hKWdw3UaXTvCDpSLH5qcF3lAHdpRu4VdjXuFZUVF6zO6/UYtmcRm6mYvPTMwOs+ogcTxuyby6qV0OvV4Ib1yXfVJLQF4yax4ETs+1SSpy5KOMPSjmzf2gNjtx/tESnXt2Xn3lNInVIhawCHMA5qhroCO5b152uqzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cBvODaEc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PdzBpem9; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T4NHtQ1771391
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 05:41:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IcVcWrR7aCa6ySMOiP3L3rwW/JeO8RSSIPVmJG7s168=; b=cBvODaEcl8ByUyZK
	cccmrxzXTHNJ8xyWgoG0UAUamnc/xP8gUyXASQ47CRiP/MtygmDStGXBsBsuuFxc
	9qQM/9a/EY2Yyp2hGqNz5RLnKbQWMcZ4r/aEjtxVQvC17LCvHZ1ytqcFUhWNqd3E
	edLKZTRL2k9FSuNlIjvnRvbsHsWuwFSOx3i+XKrvR6y+mcQTWLesnCVThvSBD38X
	8jL4bETscHcDLDDkb20CkoJdbS2iS9bDxCcJKWEpx558mjcPGY5vuOMw0grI6h9Z
	oqCl1S5pgRaWbXadcai2c7bu3GbC65n2kUh03HY4F/bole3uYmOBqKvy7dazl5vJ
	uq4k/w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26tumnbc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 05:41:01 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30c011c7cb9so7364087eec.1
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 22:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782711661; x=1783316461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IcVcWrR7aCa6ySMOiP3L3rwW/JeO8RSSIPVmJG7s168=;
        b=PdzBpem9e/doeyOwOcJQD96vzdk34Pm0LFrMdV/yDwXPN8Cthy++K5v42pS/Ebo62C
         QqFVGhTy62B7rrS7SB5bgZXouIEAQxxSDVZOSEd70AQgl4b5anQBJcYlGPRH9dN8MlZU
         GRvK9s4XmcMykyWkmrUV+H7z/uLsWABC/d9MqE1F7gQ4mFRG2fDR7a3JqgtNUpvYWH10
         om7gTyOQQLLNtP5FTKx69GfPODcbDcxOgsZrcUGHNmnUPhnnYjzZkIWcXz0em+ets3Wa
         NZNhZ0697zdjK3Z+/07Ar62KRc+Zgo3PGkOfnNomcvCNIFEjkBlX1Jko2e45HAhiuIk4
         NmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782711661; x=1783316461;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IcVcWrR7aCa6ySMOiP3L3rwW/JeO8RSSIPVmJG7s168=;
        b=CcZGpWEYoGdnFRzJvLrr9nCb45UhjDxd5gvatEtMgwwxTVLAmeL8AV3ADkzQrqP+S1
         iGTZNEVyjHFaJEoVAHlVYCRsjOqctuZNWcFtvQWzetPe+kpY3tvHRM7w32ZHuWQiZAat
         OPhQlOcDjvLcNSTdAIOBWWdC00eQs51PAO1OgKUIXX5lMp1/4+f1sT/NmE9sPRGYxsnM
         Z0aZcSnaIVS49Fwb4q9OCZNXLhd+RHMkOVSVDBWvIc/xuWpZ9RRGZ9+V8fKXyqbUnKRY
         Zvxtj7GQ2AliVXCJB2t5naIziDFdr4pVXm+b2hiaCj2ErdpufKYLY/69cnsV2CuUB64c
         ntMw==
X-Gm-Message-State: AOJu0YzWOQ6motRVaIQ6yeJn3zHDE8B5U9MzWi8zfLy12r3i1180xNK7
	Zl3Yiv6My+PXxgj4MFH7+Qlbox7pQFDUYA2ril9ydpPRt6ayDoti5OWfWnQWUd6wrZAvKOuPFPS
	fTQIkg5RLaMS/dcE4hqlSy4peTMU6u8JlfqAv43FjIirQvPuPvAqS46O/TVhY028c96dkHQ==
X-Gm-Gg: AfdE7ckXrJ8BfD8vU5uZhrD0DSemHd/302r2nszZyN2dqP8KzfGSLax5ZuAGblluieB
	TA2X0M7kL2hzvGoDU1VhQgxq4533vSQ9Wko87k6Q7rpwC4ak2l7Q8Gz23p2GaqZERUKum/BI6xG
	tW1WD6+pnGh+LYgapR1lV1R1UAbbDVYiM1XIxfDkSybWbi951WVn7Gxwcrp2NVLWtAieLZuEUK1
	XdS8fLiT1InKHp54Lfmnrxj00d6tLi+FllR9eGH+ryz9qahTAMHCvYviPU/fp2wvJZp0srO9GYS
	wir6jI7LPrYYaLdS5UUwfQ/SPr+xk1/wM3O4o6FkPaPcjZZ2SKtdYCP2VEUhOKa/xPoF4C7rqxs
	DkZkQ7DKRdTckw3+TXYf5SJiLkBREoeoLRr74ouoKM5eu9JkxCGo=
X-Received: by 2002:a05:7301:60c:b0:30a:e52f:9bcf with SMTP id 5a478bee46e88-30c84e05682mr14141796eec.10.1782711660581;
        Sun, 28 Jun 2026 22:41:00 -0700 (PDT)
X-Received: by 2002:a05:7301:60c:b0:30a:e52f:9bcf with SMTP id 5a478bee46e88-30c84e05682mr14141779eec.10.1782711659999;
        Sun, 28 Jun 2026 22:40:59 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c4ca240sm44306860eec.4.2026.06.28.22.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 22:40:59 -0700 (PDT)
Message-ID: <50459ea6-e23a-4ab8-8409-6ddb3430f5ab@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:10:55 +0530
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
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260610031358.2043716-1-yingying.tang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4OyNjGXWxMCFz-I8T__KxC8Mk0youHAO
X-Authority-Analysis: v=2.4 cv=A8Rc+aWG c=1 sm=1 tr=0 ts=6a42056d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=w9BFTkqvzr3O3xFJ_nYA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: 4OyNjGXWxMCFz-I8T__KxC8Mk0youHAO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA0NiBTYWx0ZWRfXyApfXe2K6bu1
 cUgzHq2gNM3kVxuLhOtSVb5kw29nOxIiIgwV4XkCGf1sE4sGeE7P3EeaGNt3lBZqpAMsRVqGkqz
 bX9+esb7wUv4DmUh6UwE0t4eq8gMyvjxr0f4nEZyMEv+EmjKske/mK/hh8/YsmWHa8nnIznYwOX
 yGkNRzr5fOYHfX9n/GEXsKcsBsaLVcXYtHuweGkF0ixGOHHrMZrRuTbYV7bKo/vyN1ktmHvbBCc
 0IimV6iq7thDljUEjcZHqtuYIO0zq7h45vqR9/1bAqkuVeFAu75iEKT2pcXs/uhKoWS+iNpTe2b
 K99edpgEUDTnU4+RzABM4rchQVg8lg2FNrnoN9yxeaHkM4zTJ3kK77sTIrgoHQUan1Nsa1vVSF5
 4Wl7C94cBVsrGGyuBQlm6upgMzB2EFfsnzqy9CJoLO5GUbLdevKFdKmWeCntiZoIQoqEmlLnSN/
 b15gFSG+KPjgIUt5Tkg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA0NiBTYWx0ZWRfX1J42DIShRRRv
 m36kWefEq4NF75zPHS6pfe7qcc8EOQbzFiap8RWIhhtHGIgjIqGsUuu6U2ICB0AvRwN95tSg3Yw
 Tr64BgqJoOKwP3v0v2q8rxWL+QEUIrs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290046
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38250-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:yingying.tang@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:yintang@qti.qualcomm.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E09D46D613A

On 6/10/2026 8:43 AM, Yingying Tang wrote:
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
> ---
>   drivers/net/wireless/ath/ath12k/dp.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
> index f8cfc7bb29dd..6596089d4168 100644
> --- a/drivers/net/wireless/ath/ath12k/dp.h
> +++ b/drivers/net/wireless/ath/ath12k/dp.h
> @@ -205,7 +205,7 @@ struct ath12k_pdev_dp {
>   #define DP_REO_CMD_RING_SIZE		256
>   #define DP_REO_STATUS_RING_SIZE		2048
>   #define DP_RXDMA_BUF_RING_SIZE		4096
> -#define DP_RX_MAC_BUF_RING_SIZE		2048
> +#define DP_RX_MAC_BUF_RING_SIZE		4096
>   #define DP_RXDMA_REFILL_RING_SIZE	2048
>   #define DP_RXDMA_ERR_DST_RING_SIZE	1024
>   #define DP_RXDMA_MON_STATUS_RING_SIZE	1024

Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

