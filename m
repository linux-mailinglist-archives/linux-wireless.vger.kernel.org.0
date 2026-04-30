Return-Path: <linux-wireless+bounces-35724-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFb+Hy7K82ma7AEAu9opvQ
	(envelope-from <linux-wireless+bounces-35724-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 23:31:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F153D4A8375
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 23:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7A623021B31
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 21:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD463BA25B;
	Thu, 30 Apr 2026 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Br10/nNQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K0jDtX4O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408313AA1A7
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777584645; cv=none; b=Rz8xTXVFkr4mTB1CJus9ZHxolHhcc8NQwZT06SfLiqOOcqFtc2JzhT2SowS0FJkuKErTkJqr1tPAoY6zEhP7+vrYnhwPT7myccl923KK0UjNl8cGVR47z1mqy7SGO+KDCC6Z94QIachrf52XRRRAvSw/96QAHZdjaornnfXqKIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777584645; c=relaxed/simple;
	bh=XTYXQrycvlGSQEFgPKuJDhiDMkJPLkJ8MrmhmhJa7Sc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=phGL4KIGlR1rAxQE+ykCqqs7a3/bI9CYbJFiLVvBelJHNDQJL7QnNYAPOeqdzXyihKXKHHdZ1kI2f8vbVQQ295DgVApCjg/yd7pQ/eikgYObVVTi6jZfcp8JSgvDLJ3q0xogEIT2BNNdEB7Bs6BmaNxgi7d5QKdbrlO0V4b34ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Br10/nNQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K0jDtX4O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UFZAxE2099769
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iCsZpWXFTKyTARHQQrDkK7pGjzNne+OLkALnbfbm4jQ=; b=Br10/nNQ9amfY2VG
	/TLgGC+2EM6Z9zVsP5fNCKsms4vfnCKywykYrGN8ghIFulJuza07V80COU2LGE99
	GFB5xi1Xti/NyWzHhQ0dbeYZCDSXKlk9k09dpwuGGniT9swUVnmCllpK/XlPr7fC
	D3yCnReakBATzX07XHl7zLFWboVjCh2n9So81+CRpsmn7LB/mhBofsz2KkeXNWDT
	/lBQ1eGqtwyPCexU9Vj1bc384lOV+KMsHxbY2wWfHcQ//VDiVUKPTw8g9eKLFRjm
	DZu6K9Vaydt++35a5m2nlUm2PYhnjJK2LPoa/H2Af5GXFcHiuzGaRDPCwgcgJ+MV
	QctVEg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duyr44dsg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:30:43 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2d93379001eso4901922eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 14:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777584642; x=1778189442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCsZpWXFTKyTARHQQrDkK7pGjzNne+OLkALnbfbm4jQ=;
        b=K0jDtX4OUbTWHFpoJIAxON6Nmp+7shX9NLfEiekv8RCoCA++WCs6KuNK5VtIbMQLh8
         bDxKmi+qtO2gm8ZX6MxZVuJaWd41pSAE+BfZ7S71oiw5Yz1yxZLW0ilz/XZuJB0kIp6X
         P1hlrcqKaVRICbf3uZ2xxid4KIu6z7nF/jjLSmGhSKI5G+0Ya5DCN0HfEMHRJvb5YlFN
         /JCvcByXvzqOV3KxTweo13xGdmjxmWaU/UK6JAu/ZC0trZKpaLBgrLHm/efOnAEVZbLX
         dY+7R3rmzxvCDHPOdUwgt5Cb1vVadJw6WKrqvZlbKrzEsGX1OhahI22n8xBaB5jqbUWL
         t4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777584642; x=1778189442;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iCsZpWXFTKyTARHQQrDkK7pGjzNne+OLkALnbfbm4jQ=;
        b=ftu0C1D9KLAWOnUA6HffEcAJyQ0msqhtGkkOQgAtQ4gm6FIRXg5ozRoNffjgsIWKOK
         SV6HuuDLSHPIKEPqpEm9X8Q6o+vtcCzolLJnTDkRb6IMWv3NguOFVhO/7vYA8LIeC9dZ
         diXP9/XGW4WkIqmUUOfK6SYGglVRY+d6WxjALsSU4A++Bu1xyEXxgdbNhs/3bOq3iZzf
         lQTu8H+5PGHgSgecv4pf2tkQyh9TBH3tiUEKLdrqB61nYGoe5GuzROgxLxWWD/smnGqS
         nmhGK0Qax0v/KEiA305HhmpLoJklWv/afouL3+tDc4osoAO/gNQ2jaU/yka3l6u+R6Hn
         pahQ==
X-Gm-Message-State: AOJu0YzU2bE+pMnSgloiehFsntY9RZrS4xs6mfp7BJtOonD8HDnj5Qze
	FJT/xVxTJcXQz0k4BPAj0LabCgv/OXZKhxrwedFEGjX24mTcwaE389V7o/SvY15BvqkRFU4D/JC
	BkgNWmtZWO7UNlsHa1KnsGsRSyvp9TBrLln2A8yTbAj8PGWKdg95PqqW+p5MYi2eWKICFNw==
X-Gm-Gg: AeBDievo/jzq4P4YkMiyb/iwYFpfEXboCN5MD5HdxhWl93bUwbdzpyTeupbuzwbBAVP
	CDwCUPFrqcXivLLjMT+P7fPdtxWm3ebd6HcyG8UP02ghfJGkk5Lmm64+lFxj1KGzIxBaPNEl5BQ
	AlhbKXdS8kcYG40TVQ+/LNS28fD2CQ/WqEgWmc3j0dFOranQqh+XhxhcUiKkWCTZJNBmxVBr0go
	3At9bBVAgU7Sas80MfTqj8UwF1g0MNS9A+NKGvciFX7Uj1M3JyKxFSpTHyu1BdY/tiu3t2Yqvek
	WD6UGixA4E9M5aJV8Va3ZjLbTgi0CJSr/qUHrSbifwRl1vrrsMq6otnF3IR1B/IjPbKudG3CPQl
	2s9PbTLbWiPxQUsZ11qjUhyMy/0QzAX6hBRrO/Z/g64TIoTmAUoJKvD88B08gJ2/ObVFFnHeF2d
	J8y55NZtq2JIg=
X-Received: by 2002:a05:7301:6009:b0:2e7:af57:3b72 with SMTP id 5a478bee46e88-2ed3fe5add0mr2377151eec.29.1777584642213;
        Thu, 30 Apr 2026 14:30:42 -0700 (PDT)
X-Received: by 2002:a05:7301:6009:b0:2e7:af57:3b72 with SMTP id 5a478bee46e88-2ed3fe5add0mr2377128eec.29.1777584641588;
        Thu, 30 Apr 2026 14:30:41 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38d79eb9sm2504861eec.8.2026.04.30.14.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:30:40 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: linux-wireless@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260223025021.19008-1-rosenp@gmail.com>
References: <20260223025021.19008-1-rosenp@gmail.com>
Subject: Re: [PATCH ath-next] wifi: ath9k: use non devm for nvmem_cell_get
Message-Id: <177758464080.1848985.13728687211995146192.b4-ty@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 14:30:40 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=bJcm5v+Z c=1 sm=1 tr=0 ts=69f3ca03 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=_ARdV5QQoUNj3MVHHOQA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIyMiBTYWx0ZWRfX8Qrshn3HW72o
 OM38auJ2jEO8wq66N5eGAQ54vFaIuuiiUchQ34uNubw9pMYIV7CEnGOsBVNLBavANYbyY1L3iNN
 BC1K9sSzAXwuhsu5KFKckGUV8f9iis8BXAJodMuh/oU/GQUOxIxL0TXP1JgL0bdu4J4lgyiAsba
 d6Bp7feLGDszpb/ENBmGLzoubm1su3kVFSeIXOuBdXMsKFswAo+IPkqU20giQNr1E6c4iat6Q+k
 ssHjYP8apVtzVYNb6gSoMtKyjkPXYe7DNDycpxZyLPSCTMSr5FkM/MPwdKiGTPw5VJuW7UGsBcU
 FpN6A01KValw2un8gA7THVx1zRsWw1WNJ4wZQfz1VUAF7k5IQnpAuOTzCfyEzWoKwazlg2AHJTt
 seAZhTkcQtE3l3y7AgJoIV0KzM25wyifTL4vboQwBGzVFo9h9gPexTyFvnleujOWXzmBjpXE834
 gIKGaJX+csI98wDj8AQ==
X-Proofpoint-GUID: gL2Zkmi_xRcDxY8Ez5uIFId6wDAKew-U
X-Proofpoint-ORIG-GUID: gL2Zkmi_xRcDxY8Ez5uIFId6wDAKew-U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300222
X-Rspamd-Queue-Id: F153D4A8375
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35724-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]


On Sun, 22 Feb 2026 18:50:20 -0800, Rosen Penev wrote:
> There's absolutely no need to extend the lifetime of cell to post
> removal of the driver. It's only used in this function.
> 
> 

Applied, thanks!

[1/1] wifi: ath9k: use non devm for nvmem_cell_get
      commit: 22e8b91d18972f5e1de13af7f55555e550ad1818

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


