Return-Path: <linux-wireless+bounces-36235-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AO9MBX/zAWqymgEAu9opvQ
	(envelope-from <linux-wireless+bounces-36235-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 17:19:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 17603511057
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 17:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 51CDE3046AE2
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 15:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D60327FB35;
	Mon, 11 May 2026 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ze0s+xIA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aG0HsFIU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74C526FD97
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511788; cv=none; b=cZxaL1u07oNjR+PHsaqe+rUgmy/dAF4/pf3kw56dUct1IJM+VQ38xxK+dOdUfAKrOZKjiUR0UCo6kfx4Ep7WkmLJqtlsdrL7UInipGw7ZR2qaTsCEFhYCAjtLa6JO/rsC+QCM1tDUFnhD35GK5MMm8EF74V9xwxmE/U2gDt8c3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511788; c=relaxed/simple;
	bh=j/fExSzOvy88KVCnVfxA09P0tYAe+ae8JiEnCMWbrss=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Bret7GyV1hYT7Hc4CGIowSs9mIGT9MbTetJACk7UwczlvEGtRqlZi/h7A3lAuWfQaC1SHyw52c2HQedX5ylkjVtW2dArhGjSY7YBFPtMc3pvShJn5u8w5ToLdT1RmcXAOZo1hKSXnRZytwP36yz7XBpIckg3ZApoiej6M0wvwZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ze0s+xIA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aG0HsFIU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BA53wU2039464
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 15:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aDht6lpg/PXAnT4uuyAceBk9WJ9Xz2MSpMHjEkRwDs8=; b=Ze0s+xIAkVn/dSwR
	21gDBhDcBYo7rwdotupkhEYWRS1WaiIe6MvILIFt0eGZKjEJnh0Lr/a2xxRVstuh
	Jc6gf/P67jBiqAwMIwVYz/qYCJ8Ms7sdlHgOWqxmu/ZwZQl4ECZZH9BD+MVm+J7v
	gUnbBNXLCyGrOYcANvRLWWJN5JgnQr6OE4rhlLJlFfVruWIVZNcnrisqONZZS3Ir
	Ejdd5ofqliN1nfbMPcAAHxcJo58a4+j1/jWeKMP8E4cnex2U5MsFplTMx02iJSAJ
	Ehjntvtr2L0ZP+/hTjg3XZG4opWCK1d7gnQctk8tSKezt6GqF5OGClFiaxBwNNZ7
	P1AUJQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3d22s549-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 15:03:07 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2fded513994so2813475eec.1
        for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 08:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778511787; x=1779116587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDht6lpg/PXAnT4uuyAceBk9WJ9Xz2MSpMHjEkRwDs8=;
        b=aG0HsFIUyqA9AR2QDh71rbkQS8AE4JEA+t+3umIwraxteMANAKlYIVanIpNVwCF+vq
         K8ARzNsRrSsuvh85p63NdnzS1dNH1mw2iJpL+a73CVqGsdXB60P1R+xPhWLbN170U6hn
         ZD2A0QFDijt3EG76jwALo5HAQZ+sFXRxqpie1xp9d8uTUK4DJm/B8ciuxVoJuf4pkygQ
         7sVETEiVO8N34t1GEPNFF48fpdcKUkvCEPFwUuU2dmo09zNxddOQqpthRGqPZfWmADz2
         h3G0r5s1wMSO9RXLo+I4eVVKVZePY50DX7YvwUmplOgEbxS+YDxIrDxAToWOQTvhxRXf
         jx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778511787; x=1779116587;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aDht6lpg/PXAnT4uuyAceBk9WJ9Xz2MSpMHjEkRwDs8=;
        b=qLQjV1X10cNIpu//cNDaP18KNZJI583t394Bq1QuFjsH42UqTzHn2jBqMBQXBqmsL/
         JHhW9EuEVS0+F5MRPObYFgaA9pFR6033ARSjPHVfHOVh21y6JPjLYjHaPWGdmlNBI3cP
         bY3vfOB+uqmD9waHl2Pgylh9BeSIsmg4Sif5CaD6UxtG3yPa73Z3f4er2RsGk9AzNrda
         eez8zuGmf7o0ETvlafZ7n3OfjJRgMEsebe4IFizs2cfymboFT8z6SiSNBssClOGgRkaO
         Y4nUEDg1I5xYFNZnq6FDKzfcZQ/rD+Z3uhq1aX2rnAm5QAUv6zmgVwIzWXQHktiIdREx
         zj1g==
X-Forwarded-Encrypted: i=1; AFNElJ9aZG/g964YAEfgzDpHA8YAlqggVVeds8dcRogYf739acM/XxPm5IFNVNqrJf5jGV9Q/MMqrJUW2BNSQmp9/g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz26dg8qczoWXOBJyy9VIp+6FP9pvAadbcigiMmKP2fjVvBKJpR
	Q7+H8gkxlRJffFO1SNh2ZRIsxduhB0AQeS2JATI6Muu8EC2j6BmD2AqPQW10rhCNWapI+kDZPE1
	RDPEJZz1XkJTmbHD6KJ6c4F3GOZXJZNldNSX9F+XZl1bhrZSN/4JQm5Xe7MLdIOOWA+hArw==
X-Gm-Gg: Acq92OGSYhXzC53d0oe2S388fFSVKXFxqSULFfQfAJeB/kUTmlkp7sCYla7lAU4zZ7c
	pBVimJm8SP7aWj+aLQdEmLJ5JVA4ncp1dc0gYEVLjKQ07TUqvsOCZVvd6YFomuhxN3QwV2cPqL3
	Wr+NbSfrbkJ4ECP44QsSNcHnKLnIstGtTD/aMn3ViZ5yv4nOky7u3Cy5Q9DQdlmavDmw5QZYNfu
	omzWZhmc/JgcTa3ndmNPyoLNStFHp0M8hh1Q7YUAuz6oDmItUCcQkjFzR0nd33ewd5SRdtCNktK
	nmYEUCykBSwVQ/GsqSKuEDpDc2E2JU3AFDdgIcCkYJN3+39vCa7NUI2Z1tw9W7V7mtSKipG9GZx
	Jjz/h3hjVpFIt1J5nJK1qKaOyln0rR4yelDcGMEBmguepWYKeeY+Vd21gzvS7QhZTq6ejBj6eBZ
	TI
X-Received: by 2002:a05:7300:6da5:b0:2ea:ed3e:13b7 with SMTP id 5a478bee46e88-2f54ad72068mr12004316eec.7.1778511786478;
        Mon, 11 May 2026 08:03:06 -0700 (PDT)
X-Received: by 2002:a05:7300:6da5:b0:2ea:ed3e:13b7 with SMTP id 5a478bee46e88-2f54ad72068mr12004228eec.7.1778511785819;
        Mon, 11 May 2026 08:03:05 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eafcdsm17330453eec.6.2026.05.11.08.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 08:03:05 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Kang Yang <kang.yang@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Sumanth Gavini <sumanth.gavini@yahoo.com>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260428162955.614739-1-arnd@kernel.org>
References: <20260428162955.614739-1-arnd@kernel.org>
Subject: Re: [PATCH] wifi: ath10k: drop gpio_led reference
Message-Id: <177851178488.1372190.18056204850884674986.b4-ty@oss.qualcomm.com>
Date: Mon, 11 May 2026 08:03:04 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=EaT4hvmC c=1 sm=1 tr=0 ts=6a01efab cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=WD2RVSGR4ZOmZR8fVjQA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: ItApCMMBRBvG30zD5IO8FR3Ew6HCL-NZ
X-Proofpoint-ORIG-GUID: ItApCMMBRBvG30zD5IO8FR3Ew6HCL-NZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE2NSBTYWx0ZWRfX8iAzDZN+xcBZ
 y8mUhmYI7KE/38ZZJw4bAeHN/XaBL0ICFft8qHhhmnKcWwxt7gUzkOHlf6cZ6UofDW9P/oOKGA1
 l+XRz4i+2dZetWEWTt7Tkg6R2w8dljlU6xldBaiceFBAXyZSFfS3oe0prhkqYeMbyU88perF0Dc
 34AYdYDOXtKAr78YgF/CVqW4p/LF0lc5BPC3Z6cloQndJxNIE+g7sZ+9+DP6K+0aaSVIYtHu6qS
 RKYzPJebok0Rs9X/+v3qy/7w8EW/qYixZF+zhnvhFjXGZt7xufwRXmyp2GoJdolGGsF6r8rR3oS
 o54cBfz4gDcQ41U3G/lNYuteJqne2tVc2UfgjLI6iFPEWVcF5aLGnTXa+oW3qE5qtQTq0MbcHmG
 ALnwIo0CJnxtz5E5J5WJvyCcgEvlPrynnjiVv0Hxg5O/P1pHi7SL3bxP2NVoaJ1QFP+MMTTPhcc
 D6YVAIWu2GZZNP2NunA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110165
X-Rspamd-Queue-Id: 17603511057
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FREEMAIL_CC(0.00)[arndb.de,oss.qualcomm.com,yahoo.com,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36235-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On Tue, 28 Apr 2026 18:29:49 +0200, Arnd Bergmann wrote:
> The driver uses a 'struct gpio_led' internally, but does not actually interact
> with the gpio_led driver, in particular it does not actually use gpiolib here.
> 
> 

Applied, thanks!

[1/1] wifi: ath10k: drop gpio_led reference
      commit: f8b7c2f1a45bb70eac754b2bd438168bbeafb499

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


