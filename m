Return-Path: <linux-wireless+bounces-35733-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IFsKUrK82ma7AEAu9opvQ
	(envelope-from <linux-wireless+bounces-35733-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 23:31:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD474A83A0
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 23:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3BE893019D87
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 21:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82A23CF66E;
	Thu, 30 Apr 2026 21:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KFm6SUCb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DU2sY6B1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C0A3A3830
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777584656; cv=none; b=Y40CM7BnReWVgp9eDUmlDXTKbtYI4wzl8X7FV/EkQ+0uTpvw6ENrWBGb9NheUp+FZr4k8a6MKX7ruqNjRMo/fSysTb/urqvxmVMexKAbro6YqE9BShf1+89KKjuz/4Sb4l6V8ZTsj55m+w9KH8+xGDIBMHSV/pjafLbAUc7qF/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777584656; c=relaxed/simple;
	bh=3IcaJT6mkX7QkVycz7xFr1NKcK++bokRc6AZ3r+UnJs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nhbDWbOyHuehSGrUmP5krEnxdtwdVtuztBQB5DOR7Ee8umkybYx8o8bnkfJC/dn6tdqreoarjfJ6pX12TXlYBDALD/G91R+R6xCrS03Gr1fRx3EmWAiIBbAO59KaB1rjdkq2rGXaIX0YSvQiUMYXHzv/mP3l1P6+h2NWcIY0TYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KFm6SUCb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DU2sY6B1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UIdXZO2480915
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:30:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	InsVCBPORlQfTW6m5W7aVsFfC1QypOVQF5HjnKV6DZs=; b=KFm6SUCbyYcjLss5
	ytBPh81DJBk9UwskIEwwbqSsloK9s6WhqzeDQ9QCD5HL6+Qk0lY24hR9IWm9NLsl
	qXnz+aje/+bDIlAApOhkm8CvkQ3M/n+ZOjNK3/UpsVpkS7XMOgAVtSVSCWfMcoNE
	nAFVIfd1K1uyrOnJPaApvtoEigP9LFyWNtiNMTHXMVj54FkzzUIEXr0djj84pTtJ
	YqVeZOvj4EoO5hC+0N0bNO8VAE19YgA/NbjhMsVLK2TBJfZYZ3QRNcSHd81b6GA9
	Yk7Ikz+YGMT51TMqLTTWL+WDbAnl5XGsavMj8gXM/cDs8EGcGuF8QoEgrAB2ejQe
	CNM8ug==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dv7x6j830-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:30:54 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2ddd8ef5343so1448648eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 14:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777584653; x=1778189453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InsVCBPORlQfTW6m5W7aVsFfC1QypOVQF5HjnKV6DZs=;
        b=DU2sY6B1sdqVQYUNyGXFq67v3YcghzbApItTAgy7WLsKaiECxbRUpoOFSWkK8HyyyA
         6fo8fF2riqqxsZeMEIda1iKGQHpvH9nccrH6t1HVKQRm8Tu0b7/ae/b3DuoyGj2LHzxr
         OJFYRi4w1Um26CAMjwaxcJ0bh59bP2zbzXXml6XpS64RKvg8FR87Nh/WSxUlivhJ1oT0
         BmmdsNriJ65mgC6cPgASh7XARce/sXUoZgE8BeCIcrHxr7mbSNnMrryEC6QDTREmdOYy
         ntEmjKPH1rJ9QnKo//HGB/oFnPzZW3OSpdAq0lhGjHiGCl3TtTz7jPeDjCwvY0McA83y
         acAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777584653; x=1778189453;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=InsVCBPORlQfTW6m5W7aVsFfC1QypOVQF5HjnKV6DZs=;
        b=Vo3PgiU2yiKz00d/Zddgp2xeVDzZWUSJSPo/xPSg/32Y7joid5TY9RBJaY6yqaoYb0
         67toNdBNgOViUxb0zVXmQolp73lFoVDJrDjVfeV0aarPLDDon6idrWhixEhPjdUhZnfp
         LeUzszx2GM32ykYwNMNtXNhRv1XLJGI5ctP4KBjmmPuXuteYe6Kgaiy8R3CRzZbkxzpT
         8OY/3OaDDCcg9zPtzskl1BNNQpCbdd2XbNYAXpMEfxaiHmrzXBEqbbPwnxbIRnUYk/mE
         T+afWOwy5vrkRXiKu3Css8ZCpzqJOv9dw0DBIPt7KR7oGKtinCFNgKP/4H1N4kzBOq5T
         ZR1A==
X-Gm-Message-State: AOJu0YzNY8ES2O4Vucf+cX1YjHcMtZ628KkDaM62aNFpfg+CBRJZCdCH
	NZAwb5LGECUw7E/eitgyZLjFtI5sDyw9j7Hi5FAz2H6TR1xh4T/u+MS6hGiHuPpdLntoZLkPkOM
	Z3yS7Vm64AtodT2noaRjGXFLK3oRIZK5FJ8wFDG/GZ5U4ylCrWAzNw0bJ3g7YcWx6WiFtI2Tu5y
	rLTA==
X-Gm-Gg: AeBDieuj8DzNfDq0Ts9jG5jYGJgmHleUPoVNkbV4ZH2InvY0of/FGT7A9byfVDnZPcB
	EFy28kzC6U4nUreRRR5gsYm/g7eew4qdaApeNFTHZ1i7e/plpeJuZ157J6f/JJZwg2bnJ2TSmya
	fXtyENqNbfaepOHaKwK60Sva0c6i7JsqCL3WuVmhgWzm8FxaHwOmgF+46dD1cfqrTTkdCt+Slm6
	xq9Gtve7h8N905CK4EOu/ixhXRWH/J4NfBfX6CejoFzW5nZwDj/O785xvo9u1Xp6FOMsSb8kwF7
	oN0rlJX34z+rqNvv1tiy2uq2ERJMTg5kUiOp90XLcD2BpYnwJp2wpJspP7TaeF0ph6DODGeaudG
	SIKsbaj+mgmRZkI6X1Apn9St8+wa53rp7tNWmLXf+JW6fN6sHK51QnFNSmwD4NgqHdRfZDoD3fd
	nm9VUVObpflcw=
X-Received: by 2002:a05:693c:37c5:b0:2ed:e14:42ea with SMTP id 5a478bee46e88-2ed4026af5bmr1984563eec.35.1777584652964;
        Thu, 30 Apr 2026 14:30:52 -0700 (PDT)
X-Received: by 2002:a05:693c:37c5:b0:2ed:e14:42ea with SMTP id 5a478bee46e88-2ed4026af5bmr1984545eec.35.1777584652441;
        Thu, 30 Apr 2026 14:30:52 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38d79eb9sm2504861eec.8.2026.04.30.14.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:30:51 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Nicolas Escande <nico.escande@gmail.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260422163208.3013496-1-nico.escande@gmail.com>
References: <20260422163208.3013496-1-nico.escande@gmail.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: unify error handling in some
 ath12k_wmi_xxx() functions
Message-Id: <177758465153.1848985.18035614068901267062.b4-ty@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 14:30:51 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: 5Oq9vx27JqXmMm0RpqQY1KDGh-lAaRFU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIyMiBTYWx0ZWRfX9Ih8rYvDuiv0
 0kQ63+8U74BQYvH8nTvIVjIvtJeK7GbReAYyPkGoLPbD0M2s/gAhuneTbWzL6CBlIsMwJc+I8Nh
 Lgbngn1Wn7GWM7ImD/txAnNNCaWUVrSBOXnbgcUy4sjq2N3idlkcwImF9VLDK5m1lNgIQnqddF0
 Jv/Q2W+dfrTer9wiVpa04lUXLf8a9uDNPEE88FgsfTcvvhT4LVbZ6ZIT4GH5rIewQ5pazae5fg5
 9dxGhGuyAewwjt5zC9cjFoFw4uwm0+FyLyjIU3L1k38SEx4FvsuhrF3eNTgf07ILxrcq502QlNj
 JejI451rTQ6pMx65pCwPM6LtaTzwP9xV4OLSe9KX/e6wDMk7YPAhP9xhqp6CwTUll93UIdcic/5
 1iF0TQxR4f34xsvP69yXLBOqk3uZ4FD5ynx2VhcZIhne1fUs2okysdA6RJXLf7KUhDJ/bNRgqEa
 Bk18SQ2B+bcukfzVjpw==
X-Authority-Analysis: v=2.4 cv=XoTK/1F9 c=1 sm=1 tr=0 ts=69f3ca0e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KE8VTcUQ_TpmJMKzUYYA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: 5Oq9vx27JqXmMm0RpqQY1KDGh-lAaRFU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300222
X-Rspamd-Queue-Id: 2BD474A83A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35733-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lists.infradead.org,gmail.com];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]


On Wed, 22 Apr 2026 18:32:07 +0200, Nicolas Escande wrote:
> This is purely cosmetic changes that simplifies & standardizes error
> handling for functions that ends with a ath12k_wmi_cmd_send() followed
> by trivial error handling. Saves a few lines of code too.
> 
> Compile tested only.
> 
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: unify error handling in some ath12k_wmi_xxx() functions
      commit: 31d4f8d427f2b9e423d7e177fb15f934cf0e37dd

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


