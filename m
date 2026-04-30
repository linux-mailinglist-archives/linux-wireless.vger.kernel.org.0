Return-Path: <linux-wireless+bounces-35726-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCZ1BxPK82ma7AEAu9opvQ
	(envelope-from <linux-wireless+bounces-35726-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 23:30:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE744A8336
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 23:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF247300613C
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 21:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7383BE154;
	Thu, 30 Apr 2026 21:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OA5SEPWb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FZeeDIrz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFBF3BADAE
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777584647; cv=none; b=AnMs1JINCju4J2OC65C1n5SzE/JRUgTythKr6F1pGCzUDr+GPIn+P4fEv5UODjopexWGtSBN7zFQQ4qXFQAlDb/9dRNtskGkpDyUjGDc2CsrnKsgYQKkIxZlZ8xtXWb2gpm3thTgdSCXvRh8/9Y2ieelHGfzn5RVN8Qm00JFhCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777584647; c=relaxed/simple;
	bh=nzte96wk4teHIuayiEhXEim0N/5+sr0XKAKE4U4CFiE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r5gvsqJaAm4QmKiFQgSsr2p0IQd1U5DosH4F6s7acPhtdNX2rdEl4tU8HuS3sQH8xntQ24R68OIuUR7GsUvWzAuUbWStfXEaHdcXk4X5UP8M4oNib4XUEFrmrCoVvhBo6Ns9KXYN3cISomYTSgI60K1EENX2eGsUZkvNMv6/FV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OA5SEPWb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FZeeDIrz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UKID3x1854109
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HG8D6a2T3u0+HVMkZpdMCZu1986sscM5VFT9m2ygIT8=; b=OA5SEPWbca5HKzmm
	YNaQTbL3UhkPL+HYpE0fTy5VElOM1QJ0x6hXGxZ/wK0XmuqfsGFwnTxL47tqNqN2
	PfblByZfmvPUtYOvn0RdT7+dRuf0QUIrlZKBbnpyvo5VlKdMzUBotepG3qjYf99U
	JNEHF1cNsitd597bqp6mSLvWcuEMHGi0BrrU1fgFd+1yYwxmumEzk3cH85c4+EL/
	ojJj6aRCUyAgzg/V3BIxavcNShDFos/eqpB4eLQyY4L0MUR9VlefX38LlF7U9vbX
	xZwzL6L4tNawVKU1gg8fGhZTd9odb/NtlDGhwMLM31WxL0i4q64H1228rwEkxCss
	ljOAmQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dve0g07m5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:30:45 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so2227663eec.0
        for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 14:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777584645; x=1778189445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HG8D6a2T3u0+HVMkZpdMCZu1986sscM5VFT9m2ygIT8=;
        b=FZeeDIrzgX+M28IV6DVXyh/5jIlmRxvMWfxSCpl4hhWRj96aTFn+XAqlwIY5YJBTxD
         +ze7cxJvLzcVGV9DGOH7Ru6TMxwBmPzQA7ShQwg28ZvDjWUdGbrMlb9o59k7/LqdZW+h
         rSmkxu+qeLoS/M2tgcvmvXvFtdxTkOfewaVgPYS6W7ms7YGfQkzhJpk7N2Jh1mG70iHu
         1GOktUo1O/4kMeoMasTtQM/CSfP6V+DlCCYmWoq2HnyOtj676Yj1kX3qYupWh9LHUL/F
         0iGykGkPUrH7BUMrbnWtZ3xAHktX6LJDCKrUtWChb2ifj++e/glODMKpqaeYrnV45Xpe
         xjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777584645; x=1778189445;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HG8D6a2T3u0+HVMkZpdMCZu1986sscM5VFT9m2ygIT8=;
        b=RGgSIiWZvswQGfKftGP0Iw6vY3+xOOqkYofmQtk/BSidFTI2fInJnKUoDKIoAWHjvo
         FB/LGMP+/wwssRsy/wQFDeFjvQRcIl+Yxb2a8FxUIMgy7BHSY31ctogvq+XuiUkM0Dd5
         2RPywcnYae9CFm4N9+uHAk1b37q1vSpJn+SakFqWIU2uifivjcDkQQWVaLAlNAJQm+Pc
         3MOzTKB1KtbEIl4cCKzmnNsXZ8GIfaMaZgCwT+I4SWlR73WcsbGngDvb9s/trGmOsh64
         s/ZrkPapAa6x9AAJ3nVYgjhAdaDGHrmGccxF9haxcY/rIASJHDXkGpfEcafP/IeKZSWl
         pw/w==
X-Gm-Message-State: AOJu0YzPpLXRUC/faTOjtaEm5XkzYPDUqb3Nb7z5sgAGlQxBh4BIc9kM
	1QBY1zsfxJisbYosr2ExzrH19sVPlIbsSKqYUgXECmYp112yqHdVXLxeObqVVQl0HGauTdFI4Hp
	yJp9lXDb1c0GuR/IurIidLtpntS2ghuU++CtFDo+mcxW7IJ4y0YRwao7Th1ivs7k57Hzbpw==
X-Gm-Gg: AeBDietnVqgaUhqu9L4M3KKE1SIziO53Xm0T658/a/ly8oI4yF9PaltjXep/wt3qx1I
	nyBx5i/3JpdtIJ3m3YRawRKJ3/Aq/FkwdRon9Fjt1MVWJR6qM2UHnxMRgMMxgFWtlz2YpLtFmqN
	/rxYoXVuUUnGZVRaAORGdk1O3C1KyoDfrS5fl4l/bq63Tf6SWqw/f8cjYvFlFh/OSnaA2UZjlBV
	1ZzLpVJTOFHoWvqh88jJNCMptwZ7ewoiQcwvsh2h4hNSj8CoSDa9dghRP/ZLR5ou1LUS9YDhCtE
	Vsf8Lc6yiOj+Z1yGKFjoXyu7N1NJKLULLa1amCJM5MHY94vw2qLpVeYuOVWf1oKt2VnviRmuQrJ
	xqEagToIdgAqk1OzwTJE9p5phkauZc+vTvnPqM3DvkCLLoUB9sjT+WNgBAKVD/W+r94lzcbMaGk
	LmKTzWKF73xmM=
X-Received: by 2002:a05:7300:e805:b0:2e2:27bb:a4a2 with SMTP id 5a478bee46e88-2ed3cecf835mr2253365eec.13.1777584644581;
        Thu, 30 Apr 2026 14:30:44 -0700 (PDT)
X-Received: by 2002:a05:7300:e805:b0:2e2:27bb:a4a2 with SMTP id 5a478bee46e88-2ed3cecf835mr2253346eec.13.1777584644026;
        Thu, 30 Apr 2026 14:30:44 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38d79eb9sm2504861eec.8.2026.04.30.14.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:30:43 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: linux-wireless@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260223224445.27352-1-rosenp@gmail.com>
References: <20260223224445.27352-1-rosenp@gmail.com>
Subject: Re: [PATCH ath-next] wifi: ath9k: use kmemdup and kcalloc
Message-Id: <177758464314.1848985.13166098512291400364.b4-ty@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 14:30:43 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=EpHiaycA c=1 sm=1 tr=0 ts=69f3ca05 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=WD2RVSGR4ZOmZR8fVjQA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: VawbymK5wYnkMwLYbDt9HEo2jQwxAU7h
X-Proofpoint-ORIG-GUID: VawbymK5wYnkMwLYbDt9HEo2jQwxAU7h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIyMiBTYWx0ZWRfX5mXyO2znVOYA
 GlIqwbb78hTNvz1PYfS7rcUHk6+RhrF8my/6IkofECdZVNjYhBTkH5bl+/aIcV3iUkozT116K4q
 LraE6sAcAtt8P01W5oQEtcjoHGqGlU7eohP4TpPTjkDmZQkAtlZoErBGS58OV8fZZX8/g/lkmZd
 ygbadvgz+4I1ArrNIim0xo67RuA0fSt+WzQydPde3hAov2mhuy/HVE/oRk0XPW2kVvA3s+9w5l8
 3xyl32QieYc/iieRQgZq2KeE0OMF07ne3bP5SS7OvcJRXG3qDdHOx4qrlckXo2aKXe2/BFlRarS
 d9YcdHuqZDKSwOFktuXGakmscuOyI2NADU+fnIoDFcO766dT+L3OLe7vQg2dg9y7ownP/GrKlbF
 /d6fB9h+Ps9xiZkKHlbR3jmqRqJD4uA5CgzdcO49Lapiugb4X8vKx1ofoHYE6MfOURQsnCoMrMd
 8bhprAEogoaknkjNGDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300222
X-Rspamd-Queue-Id: ADE744A8336
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
	TAGGED_FROM(0.00)[bounces-35726-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
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


On Mon, 23 Feb 2026 14:44:45 -0800, Rosen Penev wrote:
> Simplifies the code slightly by removing temporary variables.
> multiplication overflow is also gained for free.
> 
> 

Applied, thanks!

[1/1] wifi: ath9k: use kmemdup and kcalloc
      commit: 3042a9d403b9ead7c35b55e697eeae7974e04653

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


