Return-Path: <linux-wireless+bounces-38397-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UzqDNGnoQ2qOlQoAu9opvQ
	(envelope-from <linux-wireless+bounces-38397-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 18:01:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4456E6355
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 18:01:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=SOltiwqS;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=dws5QCAo;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38397-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38397-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FAA830D4221
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 15:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE111349CCF;
	Tue, 30 Jun 2026 15:53:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9041436CE19
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 15:53:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834807; cv=none; b=BDdXtpxZs+qiul7cJsGe5Vgfl8PtGJAUeli3or6uD+Kv7w4doFv6M3PTzVrydlzAIPg5ogIgbCXC2nte+vVcn/Jm1Iy4fFd4ct7DIqVoSrlwmoQl68xQFG3vagCCvGuCjDIWSx7vh1OdbEiAwvDpuu8OM0XsBtXjWISraxhJYb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834807; c=relaxed/simple;
	bh=R/sI1gIUew15JcaHBORLHwETNj726R/YfUHkCgS8DVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTkImyZ94wJrrFPHEgYcmqvm8jBabYX+vEqK4WZnwdE3ShgqjH3SqhnAvY/IUYmO66+xr9xEOhSGRjl1L4uKEhR96jjH2hdnxAYdFJ9L8RX8xQer7H+0NiAQXkv8kL9s8oEvLx2q04t/p0VEYbBimucN4dnrGobxuWKHVxMEi6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SOltiwqS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dws5QCAo; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEDIZ02209773
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 15:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r3MfQYdMueMI2V1MlLuKgPKfUZ7shXX+zunl6VeCA8w=; b=SOltiwqSmQCX0IEI
	rTnRRJFGdUhvsp8qkqsXJu0C92Jllou9Emc0n+icoXGklC2LGRw6Rp4vGgRXVW2U
	ABQpTGElXgsJWYi/tVCL2M8ax2Bgmfgn9jdMasVkMRakM1C27O+b3RUtxl4QLS3M
	vbiZDeOR8wOuUF7RGIi6HnZGmSrTC36GJTs3oCkp5PttIX6vN3Cf4tv1/ET14qWM
	vZuSDB3vKaiJTEAXzVt4sUyMrrLbnk06idT14Ie3m7+7KDoR6aB3C980xFTX8xND
	yayojntVsjOX+vYu0dqGK5oaJ0SEFA5w9wohPZthsi0xjVzZzrhPTDp6Eo8lD7+s
	ktO6BA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4avpsrae-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 15:53:25 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30e773699d6so3372650eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 08:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782834804; x=1783439604; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r3MfQYdMueMI2V1MlLuKgPKfUZ7shXX+zunl6VeCA8w=;
        b=dws5QCAotuxYhg1ieugbj63Hz8UmkDeJP9INqpDStA2MMeZZxxB8SlwL9uArjMyfUH
         UcQ82UNFD5iZEtcbNFH1dzahWC5JafRzBo/UUWn9/55QiJ4AvFIpUZC7BlziSz9kfjgU
         5OjzW5E2fW+4zH+HAneyyWtU7t7/I49/dNdugqnneS0zcPf8lbeRyTFwsS1o14fBiNjx
         iKME688xJrLDpec3F5GH1xykNhE7X6FP3pofvHh00IyjtzSxsmxGb/rbRYWJf7BaZR4Y
         2gIixT+2tnL+jc3TehuCDjZJvcSY/bnafDw9G6uiCyGFQnImVxtheXMP5BLzX4YfM667
         mIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782834804; x=1783439604;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r3MfQYdMueMI2V1MlLuKgPKfUZ7shXX+zunl6VeCA8w=;
        b=bjazlqD/sNh/P8z+lSdu7vGGBuoT/8OyoIIfgOnocwknTsUfDhnrJCyg/7iuZ82B1P
         hPXhyHuXHhvE52XQd2aA16IFiRaiCOKse2uKXMOurQdMntZv0C+H4dKda4snxDg1hcf9
         5otYR/hH7T1KwokHRzK7zaTBzRVhs9HqkTAL3SFdr7tD0+z8hWHtbZIfea8U1gvSMLh9
         ZSfUdgHr8kFupqvo2czjj4oA4/aM7CTRfGpjeK3wVB7D9VBi3LB8DbnACRoCmZDDAIUO
         vPEkUa9XssBzlZ2moipaw4RUGz+OyxDgTx1tHd5vjql3BVnoVUJZehSiL/Ae5mNqSp3q
         pgow==
X-Gm-Message-State: AOJu0YyHTzm2jEJ4UBMh+aoFt50s85BAu7PZmb695iK6fxA7B71oyeHq
	fq5dJyCJ67G1/WGLj52syRsCzpjoK7/X3fadvEZy9/d5f5KPOLsIQWq8StY8dZpGtV+8CEEXtrC
	y1CF5nSFPu7bdOL2tEOT0HzXLOzT8XD+8v9jxK+a4IOM1gzOUxV3IC0D1zl5f+r+mSSnecj8qLg
	V8Zg==
X-Gm-Gg: AfdE7ckVzXs5cFM12FWVOhZhaRZNnQIv1tS78cKT3Mu8RkoGXi5RwnONJ5AdfhTXyiJ
	O2veSqQKvmGC3lAxs+njecDd1PM8gVPAQwUGEKfwPpFWxalQ4U/b2cIww41W7t6rjBp2orRXv9b
	Wf9rDZNZTwcy6hOLz8eCk8pHm8ps3PDny+HxIpYGiPEfoOBYl+Sq8My9MbKFgLXCk66F5GJHNTX
	cjrQshL/t0pFTj5zS+C5PvHSasEmYE8gz47lEv9ICNcnkVV1Jgv07Mz1523/OsRLxcWJ1zcia2y
	Xn+QSQ/dRAxy0Lldtr60hUIP9gjNCDtk+HgjNxN4wQCx4gFR9baKGnqdZjJ0V3ThiPHz/F/NgLg
	QL8Z78LmnosVTJi/L1sdpRJtWMyJsbdCXRT68kFYZJ1SRVhzDmXH/En3Nzh32W+j/sGQBfok=
X-Received: by 2002:a05:7300:50c:b0:30e:cb91:659d with SMTP id 5a478bee46e88-30ee146e345mr3369342eec.22.1782834804297;
        Tue, 30 Jun 2026 08:53:24 -0700 (PDT)
X-Received: by 2002:a05:7300:50c:b0:30e:cb91:659d with SMTP id 5a478bee46e88-30ee146e345mr3369302eec.22.1782834803623;
        Tue, 30 Jun 2026 08:53:23 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee3170ef9sm14915810eec.16.2026.06.30.08.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 08:53:23 -0700 (PDT)
Message-ID: <4db87d04-2de6-4521-8da0-d80b036d216a@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 08:53:22 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v3] wifi: ath12k: add QMI capability negotiation
 for dynamic memory mode
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260626084327.2022076-1-aaradhana.sahu@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260626084327.2022076-1-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: YnRYMeJWdiLK6_c2ane5GBPCqt6jOuUB
X-Authority-Analysis: v=2.4 cv=KqJ9H2WN c=1 sm=1 tr=0 ts=6a43e675 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=8gEmGG-DoK4_G8SOyWUA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE1MCBTYWx0ZWRfXxjrDYyFwUeCk
 gd4aeFYmqFPJjfhtnCJi+LUFhgKR3KKiUoCMUz9xHSN8nv6ifSlWqDHqbAsXnhAkSwuYLgyo28q
 M/cyb5KReMYM9LVBHZq7aEqbGAKriTeqD0rnG5VRLur8aaxwgxyo3RIBEqqEaKrnf9sMKH+BHvz
 h8Iiw/rPw+S/pPQxm4csbAV5K2bPluDx1upnW7AZBE75t88N4aQpo21iokTRMgn+/TSiXOY63+R
 nl+uJcBrtJvfiWP6NKv+KxtpPOijOerY4VPPK5Vhh/gx6Wiw2SMQKJj8FlE7PJDQ1jVI4OqLDqx
 7UXmO4bjCmlwCztAIbWW5SLkluvGNh5I854uTAZ37cSOmthbnDA84GDFMzxWvfsJGJn9b1THsWM
 sGmxbokYyol4eD2Q6uMt3i+oFD4W41/TeTOXxWuJoPsNSFXgbS2RWGZpf/PLxlwN3a+hmHDI5NE
 0su/kI+QqLm5hVQmyIA==
X-Proofpoint-ORIG-GUID: YnRYMeJWdiLK6_c2ane5GBPCqt6jOuUB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE1MCBTYWx0ZWRfX0rYt6GjYUHln
 Sw1limxbCwo5o8IsurHB04B3sJk6f18ojBtT9Kqr+ISa9HsZyeibbXML3MqXaaerCQiHSneDE78
 0qiKDFrLyc/JahRhMx9CAysBmFjMYFc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300150
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38397-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:aaradhana.sahu@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E4456E6355

On 6/26/2026 1:43 AM, Aaradhana Sahu wrote:
> @@ -2319,11 +2360,14 @@ static void ath12k_qmi_phy_cap_send(struct ath12k_base *ab)
>  
>  	ab->qmi.num_radios = resp.num_phy;
>  
> +	if (resp.dynamic_ddr_support_valid)
> +		ab->qmi.dynamic_ddr_support = resp.dynamic_ddr_support;
> +
>  	ath12k_dbg(ab, ATH12K_DBG_QMI,
> -		   "phy capability resp valid %d single_chip_mlo_support %d valid %d num_phy %d valid %d board_id %d\n",
> +		   "phy capability resp valid %d single_chip_mlo_support %d valid %d num_phy %d valid %d board_id %d dynamic_ddr_valid %u dynamic_ddr_support %u\n",
>  		   resp.single_chip_mlo_support_valid, resp.single_chip_mlo_support,
> -		   resp.num_phy_valid, resp.num_phy,
> -		   resp.board_id_valid, resp.board_id);
> +		   resp.num_phy_valid, resp.num_phy, resp.board_id_valid, resp.board_id,
> +		   resp.dynamic_ddr_support_valid, resp.dynamic_ddr_support);

Your logging change conflicts with the one in:
wifi: ath12k: use %u for unsigned variables in QMI debug logs

That one is already in my pending queue, so I'll have you rebase once that one
lands in ath-next.

/jeff


