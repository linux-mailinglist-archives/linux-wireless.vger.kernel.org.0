Return-Path: <linux-wireless+bounces-38937-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZhsBGUmCVGoWmwMAu9opvQ
	(envelope-from <linux-wireless+bounces-38937-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 08:14:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B40D4747762
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 08:14:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=PFxEaQYl;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=gGvL4BZE;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38937-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38937-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8350330067B5
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 06:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE67337646A;
	Mon, 13 Jul 2026 06:14:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA7786334
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 06:14:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783923270; cv=none; b=hOVYoibJCoRp3SzWgUz6wtT0sDANpxoxtvmWKhLs1kV+nMwKjZlLNZNUBQ3MXNKeWOcei30aGTtsTQYb4nwnaAB8J81o5dlgc0SwtEe/p8SKyzYnTxAAl6JJ/vv4iZlO2H4b+Q9ZqbaykFDMY1e9grmaYcYm69D9GCU9cWfjzmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783923270; c=relaxed/simple;
	bh=nUSIjdXYHaHC2JkfnOH5evespHoSK/nu4d08VWpGE5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gBOuMl7E2Bu7fJYmZLhfBo24a9MhTkcY/yKthfBjrcK38XpKU39gfeYf+D/0ozOp7rIwfufQAJAP1MuTZPL+UMonbrmsJ6evECacH5Nt2CmZMQkqGyUU/QG/BUxRkN3SMCns/0QyUbJ+Xu1lZuf47ahwSR1Jbc6xt90oitkDPc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PFxEaQYl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gGvL4BZE; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D3AHd9136779
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 06:14:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aL8fQaBr5pkH/x+K54EqWRL10v6bvtWBm9i1HH4dNZ8=; b=PFxEaQYlTkUjUAQg
	3JPDJtw5fNEodhtHU+IDYJGNsKSznfHTgrknz7WjTLveynv2o/jReEmtZpvx7J7c
	dFFiRBoRhb97XbY+m2ysigsrYFoyGroK+8oavZJFlQM2V/dYMDKZ6L9ZpzeSkeVm
	zvrHm07rcA0ZyfLQ5wzu7E2VVDHLIGash+MLnyFbRr0Biq+fXGtfSPRms36PGaKt
	SNSimFC+w+u0idPwSPpawccXE9oFRhhnAAY7TT2pShcvtlG9k/8mE/CtT+vR5iUK
	Da8UnyE0QGaCZmlPT6EzJAUbZKpV7ZMHtbVH0uY+MShTKDjKRAMjZV6cQaUwk14M
	P/8yKg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbe914kec-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 06:14:28 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc5faecf01so55741415ad.1
        for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 23:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783923267; x=1784528067; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aL8fQaBr5pkH/x+K54EqWRL10v6bvtWBm9i1HH4dNZ8=;
        b=gGvL4BZEjnCilJG2JQhxcDI4b0xBE2jYm5WxnuMfdFiy11fxEviNCO+fYoXk9uGRGM
         XgzI8pKX0w3ICfIZzfo/dJQ2ec6utHgHg8PKUrz0DeniEoRSnrZgo/oQys7ZoIMS6wiU
         CYBK54Piw+YfkCrKZCgDFyXbWl4QCwoPvR4+1QrqLP/+tFtm56uczwELZDS7ETUzfDeP
         n/adkXuOd4wWHfvzswybaZ/+gA/4JdrPeTKuV2V1yX/oaQxyBqLDe7zJXM0XZvdQxvev
         XGpLxoS4DguxtSlAqz8SRGxK6ppCVVpL1/9XRJc7vpOfSOmCSXAzXwuktOmFHpgMnULY
         hTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783923267; x=1784528067;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aL8fQaBr5pkH/x+K54EqWRL10v6bvtWBm9i1HH4dNZ8=;
        b=d+86EGW+Sb/oZl+BFVQIEdr6GcpSZGuvnUEJjCdlb/1faZZiYCqvAxBTJSyUnepvMz
         c8cppCLDY/Jtkm/7NfN8ShrWRHURCmoyJyuqJw9Gsq5dzPSwCdG/rqPajPLktFdder7A
         ePXdCfJ3QS5Yu5qCQ4mnH0DOwrXb5Nnt3bbW1x5aPQYXxYl6E2mCFnWwaaROhWYRXL8L
         wrJxLK7FPBmlqc1eSpA2HyBAsLlZ964gAIWgyJq6nOhXT36vUL/XRk814nZcll65rZ/M
         xhOVEbZuGzHFuT7mh5utpByiIBJ4ybAq0KGgoqX5nHIWRrV4fun5rmmbmPHCFqHL8CIC
         yyNg==
X-Gm-Message-State: AOJu0Yw4pWBHAqYIZqSgUCbzXeuAEtgV+O9IpO187Tdks1RrAYNUdqIN
	uyHy6j4vPpCOUrXhmK5lnZIJaQQvbuEaqOVq6tT3ngc6qIZU7eUiEbW0YFhG7BKCSHeLh1jw4TI
	YBHI63V4oTbgmkt2l2Jr9lBmtDv2p6He5BIVt6XFKwuNaXccKBRm/IjCMPf1mZwsAACnDDw==
X-Gm-Gg: AfdE7cmPS8ipT8rQVOEJqK449YhUUqp1lGFI+t3YZo53PjpPdsu+rnfRQGzfpercuf1
	TZ2dZGNDAXnoMy+EzZIohWFeFXqxjWUPaCQNmWo5NZ+UP5m4xJkTPa41dvI8M8NPamIKFq2fXzf
	xcBe7RC1rxVHKBvV0E+TvAYVQEn4OIwqdTmd8kY4bFdTn1bDSpO4VeVl3Zvik+gFU7wvVUr3Rov
	7+83BTS3hrPWN+sAjFONxwM1vyGceZeHb59PRMxNoXIM6mJ8i9t03ZpAFaNq3Awm0hgB9IwEMg9
	2ICBuaJfVHOGrX6kN4J4Au7rUy0RkP83ikG3bOrINW7AgCpO89QHS+IKx3F/Q7Q9ebDTwftOlzb
	m9W6CFdqztjkQz9idyP8qPLVTSBtVBnsa8DM26aBZidRXWEFQr5RMOeIJ5cyZMrmqWQD6bBeb3F
	p6uOlpIeA=
X-Received: by 2002:a17:902:f687:b0:2ca:caa5:9c04 with SMTP id d9443c01a7336-2ce9ef186e0mr74358335ad.23.1783923267589;
        Sun, 12 Jul 2026 23:14:27 -0700 (PDT)
X-Received: by 2002:a17:902:f687:b0:2ca:caa5:9c04 with SMTP id d9443c01a7336-2ce9ef186e0mr74358045ad.23.1783923267158;
        Sun, 12 Jul 2026 23:14:27 -0700 (PDT)
Received: from [10.133.33.33] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3da55sm94247995ad.71.2026.07.12.23.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 23:14:26 -0700 (PDT)
Message-ID: <98f32ddc-49d1-4b1b-9c5b-3c180f284ef9@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 14:14:23 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ath-next] wifi: ath10k: trigger hardware recovery upon rx
 failures
To: Manikanta Pubbisetty <manikanta.pubbisetty@oss.qualcomm.com>,
        ath10k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260710060406.3323260-1-manikanta.pubbisetty@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260710060406.3323260-1-manikanta.pubbisetty@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TbymcxQh c=1 sm=1 tr=0 ts=6a548244 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=D6bBqopfn0aMulu9HN0A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA2MSBTYWx0ZWRfXzx5rUEbiSvoE
 J6uOJbdlvQz/RXSrcSLn9LfdF1XJ9kmVfJg1dD1yE/Hx9ccfKiMYwBbM1pvmovgI6hJdBq/7nAG
 j0M0HCdSz6YRAPMvUKXbQm+0bbL8a3U=
X-Proofpoint-GUID: HDrISFWr5loaIgKOHj0iIeaJvRGO41gp
X-Proofpoint-ORIG-GUID: HDrISFWr5loaIgKOHj0iIeaJvRGO41gp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA2MSBTYWx0ZWRfX13GdNZoD9/bl
 6xya4WyWbAsAe7ePxAv+WSyOqE7TJifgfJwK4RSzrfm60wvcwCs0tGtQXs+u9wMz4KCkxmFaniZ
 SWDOIl1SnhdMRN5u/0IRzg27WLdXJZ1N/VjK0LZ5X89/DHKTbut9/eYnIOGtPm/Wu1qJOImiIhU
 054tX54GwSrKfu0W2fohRqUkoUeQYtKjKH7iF0cJfrfoHtopM4H7Gg2POb6JkLjdmRYtXR7191q
 Pl2ANFLXxY61tKGIR1ZnFw2JqYVxZRYW2iu6auIeLaPgWcTUgAJ5ZcztqO3oAx3WYumCJ45Kp0J
 9yYwrOzoAoUNzKn1w7yhHnOF4dPZLPCawhKE5vyXlbyR9mDjatBQMQ9fVr1SE7aMCdjHkn7Xjs7
 Qj89oq3xlokql0TYARnd2lgms4iBinVWhJnWSTvWp7qYtHvAlXbYEsXV4LHOWIgCyj38I2J4Ph4
 coVqbbyblhBy+SZxNqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130061
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
	TAGGED_FROM(0.00)[bounces-38937-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:manikanta.pubbisetty@oss.qualcomm.com,m:ath10k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B40D4747762



On 7/10/2026 2:04 PM, Manikanta Pubbisetty wrote:
> When an error occurs during RX packet processing (e.g., MSDU done
> failure), the driver sets rx_confused and drops all subsequent RX
> packets until a Wi-Fi ON/OFF cycle clears the flag. This can leave
> the device in a bad state where it cannot process RX data traffic.
> 
> Instead of leaving the device in such a state, trigger hardware
> recovery so that such an error state can be reset and the device
> can function again normally.
> 
> Tested-on: WCN3990 hw1.0 WLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00288-QCARMSWPZ-1
> Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00189
> 
> Signed-off-by: Manikanta Pubbisetty <manikanta.pubbisetty@oss.qualcomm.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

