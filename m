Return-Path: <linux-wireless+bounces-38532-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g0bPJ/zSRmrweAsAu9opvQ
	(envelope-from <linux-wireless+bounces-38532-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 23:07:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A606FCDD5
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 23:07:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=T9bNQpFL;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="e/ZCZTbf";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38532-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38532-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C481B30034B1
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2026 21:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C28372EC2;
	Thu,  2 Jul 2026 21:07:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74073317173
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jul 2026 21:07:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783026423; cv=none; b=rrYY0ekLNCS8iST1C1+xdNCITacMiWj4VPXjIxLi4plPkuYB00lyNExGSajcTyTlTMmV8dmaBNHGdlTaLGFuGsOkPaaqxqSGb5hVxKru/++76GIGG4kR49JO/iSDakgBXq2Arcapua0JoRWKclKi/V2xvTm0KFOwqk+UDB3RIzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783026423; c=relaxed/simple;
	bh=CtLT/MXrFOTlYF7q7GL/WXk5CMpuk0fJbx321TFdwfQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BVzzaN2x80q+7/95ALtfLIOf+5GkEateYo3uTpktxXQzTUZkT4Un1/Xgr4/WTVMkPxNa0wMeMg3GhMdcGUniBKg417iDWI77nguvy1Jo8HaXTQLWyHVrSf5ehR3oAfzneUhmZETHQCN2pthcyP4ymL1vj7n1swU0mBhMfZLaFbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T9bNQpFL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e/ZCZTbf; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662Iusqi1361030
	for <linux-wireless@vger.kernel.org>; Thu, 2 Jul 2026 21:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p/1NGIPaCdcLKXQm5TogjGYwY+n0zVHtZoyJXhDy83o=; b=T9bNQpFLZG4avL94
	jFbkJzhyV5qwNz90dr/qEFkLLiXj4IvLfdLXurJd+cI7ZrfKRV3z3wnON2UYHfN6
	nXKR4f8kKQ+St2XeKmKcgzUeEln6EsRrg9FGX2KCb1pM4h9M+SW9cnFBto/1OMbl
	+C3ybjrJJSfOs3fJASW0giNZ/cx0JB86bCEUaM0lTmIjL5HPzdxQdEoFPR8b4A9D
	XLNTkw9fZt21+uhx7vQu3ibnlCpkdM8MpqZkkIyIHXDqtuCHgO+GRpPw+O391V1i
	4d6hRKK32EFsvdFCDBI5cxK6OE9+c0YRT162oJdVmPhg/Ef9DZNcykzlbYYXkziW
	/SxzsA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5gmb3xrb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 02 Jul 2026 21:07:01 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c88ab059052so1227584a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 02 Jul 2026 14:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783026420; x=1783631220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/1NGIPaCdcLKXQm5TogjGYwY+n0zVHtZoyJXhDy83o=;
        b=e/ZCZTbfXbNMR4Zyzc9rhua+alaHTJVNnvu9jehUdlV7ileg2WWyubvOZAkv6QQzj8
         PtGb8SMdf5NkkNlsP2sJbEhssoBT827c8Fbsd9g4BHieaGDb1BYA+qV5umWFI59Xve2u
         Gws/utQSp6Pa4I2rq0fHkmL/EciGqxdLKEIQc9VkyM/IUPgyhPzhpOICeuezanDs4TZ+
         cWvotEu3bGS/iDNhmXzn7yzxRnIiTb8ohrj4GZpDtk6uiVOg9Ttf9qICMlxIf0oM7XtI
         U3T0U1EQKnaV2GnIJIYUugvT45S8yiAbn/W2V3j7SGKE+rR8PI55eICLuC7p8N5+Vgr9
         oyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783026420; x=1783631220;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p/1NGIPaCdcLKXQm5TogjGYwY+n0zVHtZoyJXhDy83o=;
        b=FQf9gmv1ENrP1tqRYzMPmBBt/SZSu18ssaQGj6O9JNKRMugNvX7xLP3rL9/youbpRw
         wffF47QfPZu3m3uwdjEP+b330ENYkoV7yV4u8d2akTgG42a6ObKsdMrpnydYelce5Ycn
         /ijSyUUQLNXZYL9sRHuK1zXKrlGAcVFDlJ1DJuCQ6rFg0ub2AaaoYk5IFjVYhManJygg
         /HEfbAi+rO46KY0+yp/wlydGh5s9nKkqxaxefI8PS+zv2w7eomD3e8UFmUHVnHHP5Yrg
         ejbgncIZl744scvh7EiZ6Jo1PM0EbBftSnhdmeiVIhjmqGWKe8QZeD+UQXK7kjQEBaYH
         9F4A==
X-Forwarded-Encrypted: i=1; AFNElJ+WiYd6wAAwHA6Gw87R2C/h4/n9RFq6fE+6xEA3Bp7N/uwJpOI/WBDbw8ynwDeEuWFKyb93Hh3rE3Z/+x/Jew==@vger.kernel.org
X-Gm-Message-State: AOJu0YzynehAZnDOARdLxMmZshgJ/9TItGvHqEdca1MKL2ENpQe+25or
	SZgh6OCTKyMGLjT1Vs3FA9FNmMfCB7JbZVO77n9rad1NRPf3bfYIaTMIxBC8O1lU6ZzfT6CsnB2
	JzwORfReN0I3wg+TZA4LrOk47K70oFvQYyaDFoSCctL/nU3TbOaLXTZXxatXhNza3dJ78RoxSGW
	nmzA==
X-Gm-Gg: AfdE7ckzJGFsA9odZbJe3mvQ0FWec35PVHkrOacjKOBJX3ajcMbET9KAuxY5IUyqX7s
	i62jHSyTzbiaMr28at02nmhrlFS3MQoQYRtB7t3a6DD6ISHnmkgGZ7TZ2DmIlGhI/LhB/PcVKcY
	Jo+f7nCvkjjjihxsIlr/DAG3idQ2OjD+pgTcO1ghRB5D2/e5cpBaTkzVSR4/Let08DjZCNmKQYY
	MjB8NpbbkrVtdCo0YE1p24k4Wf53DzUeB1H0vGyJgHhkuyyIk09MZvPj0PxIhY6Lll2RuP7z4QB
	s2PhL2Psya1MByF+qapEnlDmLrIDG6pd6ErlsVFMg3u4xx4MDGLJGq0L+/hfaKaXBNXm2fcftZg
	7opQwfu29haXp9QAWbpbOro2+CB9b+5UFVPTOBeM65Y1MSVohODUPXRNdVOvN99awhA==
X-Received: by 2002:a05:6a20:e211:b0:3bf:990d:3fc7 with SMTP id adf61e73a8af0-3c01caacd28mr1555422637.20.1783026420332;
        Thu, 02 Jul 2026 14:07:00 -0700 (PDT)
X-Received: by 2002:a05:6a20:e211:b0:3bf:990d:3fc7 with SMTP id adf61e73a8af0-3c01caacd28mr1555379637.20.1783026419712;
        Thu, 02 Jul 2026 14:06:59 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b7bb8fasm12300233eec.1.2026.07.02.14.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 14:06:40 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Gaole Zhang <gaole.zhang@oss.qualcomm.com>
Cc: miaoqing.pan@oss.qualcomm.com, hangtian.zhu@oss.qualcomm.com
In-Reply-To: <20260609090609.4041009-1-gaole.zhang@oss.qualcomm.com>
References: <20260609090609.4041009-1-gaole.zhang@oss.qualcomm.com>
Subject: Re: [ath-current] wifi: ath11k: fix NULL pointer dereference in
 ath11k_hal_srng_access_begin
Message-Id: <178302639997.4076904.10675261367629725510.b4-ty@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 14:06:39 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: ZJVLchpBgpnBEGPKLwX8M8-vEuODSfKv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDIyMCBTYWx0ZWRfX1r48D/Z9kzaQ
 bDDQUS+HO1mE+LajHwPS4ZL+tXZt8vguR5RGWJEdfZFfq7DO0Jd+jNR/xHICv5Kf1jyh3Cq4q0q
 HWKRBpqWKIpU+tpiICOY48ptGg3e2XA=
X-Authority-Analysis: v=2.4 cv=aJ7Ab79m c=1 sm=1 tr=0 ts=6a46d2f5 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=C-AIHKxbatL2aXLaNDIA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDIyMCBTYWx0ZWRfXxuv2jm9pzafn
 KpACMrVr5urz6HSIP+EUYig30A6wu20rCCVGxl9hID0SbJIY0wKfBn1sQNvxNzdbp589KjOdfw6
 lpGzn8vOyrVwc2Rxo5HW5Snu6qt1nKIQqt7v7Z8H8Jiz7Wl0SWXIlFvqutihig5aZKVY7wV4A3n
 D2AQjQoghNoSBUvB2MW7CUnwacuEhynIEox3dW8bH4nNMgK4KFtUVvpbeq/OCNoyetz80fUlJEq
 xVZfsC5m/D9Z4yX+7yF/YTUtPM8gTtK/XwRNO+1KUELRsvHlPbjLd+webenX55jiKktlvSdaBMy
 r1mtQhBMeT5qmbtJHD+DQdJZtY5w26GUX0W6BaqQ8XV0uQxc4H9YUvIN7F/olVwT7l1PaQfoF4c
 emSaMSqeGMljHuawHfJDi/euIxUoWRPaI1PMXWGxDZp/JNwwQOay8JrWli1tS/5UjOT0k/Un3Ht
 bNZsCDkpz3IQ7S8iISg==
X-Proofpoint-ORIG-GUID: ZJVLchpBgpnBEGPKLwX8M8-vEuODSfKv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020220
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-38532-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ath11k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:gaole.zhang@oss.qualcomm.com,m:miaoqing.pan@oss.qualcomm.com,m:hangtian.zhu@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A9A606FCDD5


On Tue, 09 Jun 2026 17:06:09 +0800, Gaole Zhang wrote:
> In ATH11K_QMI_EVENT_FW_READY, ATH11K_FLAG_REGISTERED is set
> unconditionally even when ath11k_core_qmi_firmware_ready() fails.
> This leaves the driver in an inconsistent state where
> initialization is considered complete although the firmware ready
> handling did not finish successfully. During the subsequent SSR,
> the driver enters the restart path based on this incorrect state
> and dereferences uninitialized srng members, resulting in a NULL
> pointer dereference.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: fix NULL pointer dereference in ath11k_hal_srng_access_begin
      commit: e8d85672dd7e2523f774caafba8f858384e18df7

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


