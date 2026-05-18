Return-Path: <linux-wireless+bounces-36607-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIPTHQodC2o2DgUAu9opvQ
	(envelope-from <linux-wireless+bounces-36607-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 16:07:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B05756E508
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 16:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A20E302A569
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 13:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CCD4968ED;
	Mon, 18 May 2026 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tewq/jTY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jxrV1qbn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B321D492180
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112460; cv=none; b=nCS0pBdflpD3QrsffMQVtsuoCn/X9dftykfEZ/EkX+Wj5lHlNkwBN+FvknY9X4O4zoLYsK4+u+esDA52NnF91WevMeINzmUsuoHobxks6isQE1kJzSkE3/3vmPNGsYeaYRxUpTY687jKfUKf2Y9uDMaQxQcl5flJJjiBN4+f/XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112460; c=relaxed/simple;
	bh=69JIpMaQp/rBClGIQupI+aFcZIqt6/VCNdRSt9rh+LI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N3By9ipprTL7hI+7PEqQEumdNc0KJARtJOl+u4wzJoehzlmQznofBAJvfycLKMLj/L+EPgCGUNfoDNMYb7pVk6YSxDRLUU6n2uCSRDF875bAV3xQc8RFh2WP3b9SbimX+lb+aa/ZzyHWLoOfMBlOqhu7qQi9fzrCuxZ4VC5MgYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tewq/jTY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jxrV1qbn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ICJF6E483452
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 13:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NBiw6w/Bl1SGBsyyxj194UhIBjNkUE0ezPyMhXtCx1g=; b=Tewq/jTYbdfC8IYC
	c8KqLEr+XDSrjVWKNFNfOqVMmGg3JyTF+BcwM94fl2+Fmgh+k0T1Lfy5Z6mPtkXr
	P6Yp6KhuLWyKac9YktoR99axAKIhTz0kUxTm0xG95iFaWDi66hh2rjdv7XnJWtEw
	lM8m14quth2rbUuuiy+Uw2gLCBqnJZqzwJwaxf/oec5vtYY86gWISiLEMyzLERSD
	aLdtdAO1StNNIY06JVv9fYvHO7k5Smo/vD39FdfINOl0WpbqBsU7e2PNKazgbMio
	aiAx6Ofxg+W+GAwyQvm4CS0uY+CMTUKgnG4mTzF4YxvpqCZ+0tNd7nIp0VP0t0n6
	UBnEIg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6tvcnkq4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 13:54:19 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-132d631edaaso11578861c88.0
        for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 06:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779112458; x=1779717258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBiw6w/Bl1SGBsyyxj194UhIBjNkUE0ezPyMhXtCx1g=;
        b=jxrV1qbn7omS3PcUTj9hMZ8bajadU5+Evl5ZhtmE6K08xUTINDH70A5QlyjJvINkDy
         AtXRmIGpgH9hLneOvqmmhNmTZdNad7jJ+HKzYKVISthMKJKAg6FN8ileDVFZPMIJAENo
         QCQiFJXQoNC4q5m7QnGrNwZj63l3gTa/WYRI63M0xfReeSqSuq1+NhULyeRTChC1ZAe4
         bfkX+THlMX/QADpnozFs/M4XuYJLpYT/21yXuUCnRbyUe/WVn3jB37x2Zk8oA250B63q
         xYk4dFNgtX/XVFRMSii3gmItBdnUBvDsYlqIV1TEweKinCyosxhVd9Rmzv36qXfyvCmT
         FR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779112458; x=1779717258;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NBiw6w/Bl1SGBsyyxj194UhIBjNkUE0ezPyMhXtCx1g=;
        b=rBnXpKtNMTr4vrtFuE3GFInvttO9KEZRps8Wo4UNC695LJkbPxCKfZ8FMcRA8+ZADK
         4xqV5TExIyQ5IKNDL7rN6RBOXqpvXoGG4se9c/pXK1ANFIPIq2e96ydQyXxBi/AVj4QX
         Hn/e4NMbJsBE9XUVjZ8XZs/+mnRvJSVy8LDQhpODehtlYpD0HaXdWQkZ6N8KnFX84ft9
         HGu/Ku2Fdql1GSVnfIkP/qtCoU8IbnFvxf0V2PCyGPyjm/hOGVy99rbgW4nzCgOJhAbc
         GGCzV4goHHQa3h+sYLTuVU2qEzSG1glV33bfzTV/TVIvznOTU+F1fHgtNKKUZTQOJcPu
         76qA==
X-Gm-Message-State: AOJu0YyRdCbkA0Ssci11G3vphX/tjOVsSDSERz8GhWJMGzqm1FFePOmq
	zika2EBBBBAU/UAo6M9H57xhZv5IEWTKeGJM4z/MuxyJVM9EtCt/fA4JFwa7frvxwZbgjcpQemr
	jlN636uIA3En5oOJ/iudBxSLXvAjt9qjswsGcMQOej3zoRBd5mQtgw/Cx8eySQXDgQ9Bu3w==
X-Gm-Gg: Acq92OFYu0PtrXXEycDFhmQ8YF8cI3eYBhFjusvkZKrOTw5WTfQnG2p8Vt4BNnYqB1W
	TvMIi5zZ6FEPiEmThaQgX4+Vuj1MAFVtAJgfSK2KpOPKVcivpHy9WEWSb+Uz6hql9TP5JoJPu1W
	1DnnTKVAi7GHYCKob6Mugu3ktMKJ/TDKcvwZUnbdHl/56oxytAzDZ+6Q+vVGnDhhUtmqhNPiOGo
	ncZiHUoU8fTj6ETeJi/tvMOY3ygzwLlSlLpdk+SIi650Dh5rZwFuM00hX62Yi5uRRJAC/YGP8WV
	YMdJfXSkvgECS22ppg21kWyA9FY9+4QT5PRz7tu3u5KKtLaRCp76XlnLgjN1IluMBn1DSCeu+3h
	Zmz7aV+3GVccBXjg2LqEjAkN/iMN011tsg5G0N195cREXtJdvxQ3Xfk3IB/uM0NerA7ok8AmkjK
	ysApxZNfSlqbE=
X-Received: by 2002:a05:7022:ec7:b0:12f:1f67:e743 with SMTP id a92af1059eb24-13504a57b79mr6538619c88.40.1779112458471;
        Mon, 18 May 2026 06:54:18 -0700 (PDT)
X-Received: by 2002:a05:7022:ec7:b0:12f:1f67:e743 with SMTP id a92af1059eb24-13504a57b79mr6538597c88.40.1779112457870;
        Mon, 18 May 2026 06:54:17 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc33a618sm20870488c88.12.2026.05.18.06.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 06:54:17 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260514-ath12k-fix-20mhz-only-mcs-map-v1-1-a38d4a9b21a2@oss.qualcomm.com>
References: <20260514-ath12k-fix-20mhz-only-mcs-map-v1-1-a38d4a9b21a2@oss.qualcomm.com>
Subject: Re: [PATCH ath-current] wifi: ath12k: fix EHT TX MCS limitation
 due to wrong 20 MHz-only parsing
Message-Id: <177911245724.2671480.16936967026360058275.b4-ty@oss.qualcomm.com>
Date: Mon, 18 May 2026 06:54:17 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: JoPBjvvRh3H_6wqNVWewlramOQLlpHBN
X-Authority-Analysis: v=2.4 cv=UIDt2ify c=1 sm=1 tr=0 ts=6a0b1a0b cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=MLNRGpfyw66JFDu800EA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: JoPBjvvRh3H_6wqNVWewlramOQLlpHBN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDEzNiBTYWx0ZWRfX3whF2Wwq0OJ8
 O2iilwzlyTTnzixmFeqLISY43EgOzM2AfAxuq07c/Hc8sUrE5Fni2ZmgDVaUf6GbRQpsm59Tqt6
 Ym+R9rop6kxkh3MMdyJtmlfCMQjt0zrn7IqQM+JxmMSFlUqwDurFXXIZSGGLHACjpCik/Lxe4Ka
 Qu09I7mfpazKjBRJBIoPKRez3U459aGaRaiGF27+8Qztao/HDY3DRkwoFV4RvXd6NmpLuEWvdwg
 zCr7BaYwgk4tNTWlqNZVWBJYbjcRq5CEQYMhIo8O3YvuM+/IfkXi0ADCN4mMgcoLAxQdbMb4vRh
 9QSpjhoBIQfywwdZ2s9di+LxP2yXCPfvEPdom/PilgEEGS0H25I9qUazTSGrIDb/K2DXTfdOvqD
 oZ5hum/tDpqCOjKtbL512DBt1eikfzAnv6wIaWB+Pzs1A0DVAPizFWhSfXhJXqOdFwmDnHIh7UM
 z4Y5bAud+1nrpkCvuuA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180136
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36607-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9B05756E508
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Thu, 14 May 2026 11:32:51 +0800, Baochen Qiang wrote:
> When connecting to an AP configured for EHT 20 MHz with a full EHT
> MCS/NSS map (supporting MCS 0-13)
> 
> Supported EHT-MCS and NSS Set
>     EHT-MCS Map (BW <= 80MHz): 0x444444
>         .... .... .... .... .... 0100 = Rx Max Nss That Supports EHT-MCS 0-9: 4
>         .... .... .... .... 0100 .... = Tx Max Nss That Supports EHT-MCS 0-9: 4
>         .... .... .... 0100 .... .... = Rx Max Nss That Supports EHT-MCS 10-11: 4
>         .... .... 0100 .... .... .... = Tx Max Nss That Supports EHT-MCS 10-11: 4
>         .... 0100 .... .... .... .... = Rx Max Nss That Supports EHT-MCS 12-13: 4
>         0100 .... .... .... .... .... = Tx Max Nss That Supports EHT-MCS 12-13: 4
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fix EHT TX MCS limitation due to wrong 20 MHz-only parsing
      commit: 60fb2cf51e77bb1c0261160b4be44209d68956b1

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


