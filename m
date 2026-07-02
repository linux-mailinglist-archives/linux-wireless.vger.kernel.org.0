Return-Path: <linux-wireless+bounces-38530-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7FJ6EujSRmrieAsAu9opvQ
	(envelope-from <linux-wireless+bounces-38530-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 23:06:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF8B6FCDC8
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 23:06:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Apub9sPJ;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=V10lH0gl;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38530-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38530-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB85F3004D0E
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2026 21:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AC6359A66;
	Thu,  2 Jul 2026 21:06:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEF233F5B3
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jul 2026 21:06:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783026398; cv=none; b=KNAn95W1hGlHpXVyI9js8xATdeMcKaxYjI+Dlf7HWLhRAos3cjU5VeH5MYufzLAfH5u88LH8+uCeeQiW4pREFAzxmbSRQ1SNJUj3jOS48v5lIWFssHYR5Xxql5iFTl4kN0aBlY8a3htMxRF4bS3P5ubCA0xahcyRhRjm1qjGTfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783026398; c=relaxed/simple;
	bh=ZjZJWgA1gs13g33YIFvYTpRnR9QEv7NEfMlEhmwob3A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FUUAtBmsCB80VBWp1+qUhCWvkC93pO52LTbqsxBD54A7zA375Mny4JA6hSYpTJBu3soIqNoTAVbBPoNvDtxq9F1Pa0MRiwxCa2LZTW1ai45FB/7jEBlqrfFSxeYAOjlaizSDomgT5q/PzEVlh/JIruAqD+6Xyy5Th5tegRgpDew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Apub9sPJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V10lH0gl; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662Iv0Pl1258903
	for <linux-wireless@vger.kernel.org>; Thu, 2 Jul 2026 21:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+P2/EmMmsT+6LxSbYwxm3KmHbQmZg/h0+bz41SbDl+c=; b=Apub9sPJRlq/pdUb
	o6HALpOot08k6SfW3XubdpGG8B3nTeIAH9ItviiQ4ZWaKrTWtcYwSVtMYnxCGexJ
	priadfLkRScW4GTanUjUj9e1Z/hbmYEhvS+N2hfkMnA6PMuziFCFQmuxECnHq9b/
	7k/rOT/f+Fbx01quDImQ6nlmWecggwZgBm3mmzBXzwUr8ZOAZtWX1Yo7IQor9D0S
	p2i06ZEhaoDgthiOk6HpRaXe928NCHOVgBeUDZo9hy3+/8pJdQmvLtb35pCBr82G
	clHA5jW7Lz5Va0x5xlzlZR3UgGbD49J+aN6fogpkkckt4jnNk579GjAd0wAYoaba
	ROImAg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h98krk2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 02 Jul 2026 21:06:36 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c88da04b719so1897041a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 02 Jul 2026 14:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783026395; x=1783631195; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+P2/EmMmsT+6LxSbYwxm3KmHbQmZg/h0+bz41SbDl+c=;
        b=V10lH0gl/S66fncpdGLPAtHFm8Y5fe+HmwghYpXDhE2jaOrPm2XXjeBsuDPRSrsa+S
         Tyj27HhcJMx+oeCoAJT99FT8sDqCTI4StOwwUDomXSCEzSSkYxkc2v5Hb6Vt0iNtOZO5
         sfmBTU2DyD39Gj2rihW/I0Kifan2yLVBYElWZ3l2lY3+iQK7s4tUYSSyiTKNXcRpJnSP
         j8Rot6dPW4jFsTYXb2wsxaal+oh4PaX/d7Z+IX45CldNd5tog3obmCg123sTElhA/0/I
         /MLk68JdqiTeZ/xHfAsmDLzCZBMsXJnIvUmKQ3pi4qbwNcwQ9aUoTw83lH1ikpwEa0dH
         +F6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783026395; x=1783631195;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+P2/EmMmsT+6LxSbYwxm3KmHbQmZg/h0+bz41SbDl+c=;
        b=NN1Brpk9dqsuwNhVy+877FJ6GY8IyG38O5RGSEUf80aX0xMv6qcDM8JMHVe7b6B53T
         mmqVUE+8+gkT74Wvov1GxkKFqvNsc1ibjHzaOhYAAyrv1JpJoY9q4xBmscqdfmh93PTo
         E1DuhoqokvYM2OQkni1kD8BUFyPm61iPktElvvLTuw3vwcYyNQ/IK4PWvTCItWVaKuy6
         oBIGPxGdhVjiDN7WYUMjMzXPrilPIYPitpErlZFSr9Js+CO260kn6J8LYPaFiPS8FN3V
         KGuRsB0NcK8DLyceWUE1MmTS56IGmBlIfqGPuBMRdiW65tAY6JbVJhRsw7ahxvaK+kYf
         hELg==
X-Forwarded-Encrypted: i=1; AFNElJ8+aegxRzcCGjcebD997W5y/B9p1gkGK51Z+MmWK2sK6MwYf8I2ifZ/15a/5vk8MqQJHtzqFF+pEyWnAZpGbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCXzEIQZrPshbKqtgxpXFc76A1gareNFt5Kmds+6yfBWTsYcju
	Ph2BsBCBRy7BzEg1lsqxxGm3+g4amjB1ARfI5XQ5KeIz3ql4/j2qnVwMvyGdWOXaq+zxBlxlZaT
	B6BsaupSoJpOEl4ot+uanPk+7I1/OUB35+V8rBOdhVPDJ1eord7Rew2QBjyhEt/DNpL1ZMw==
X-Gm-Gg: AfdE7cm/xG6vKrKR6ApjLJDj7NrDCRtKEBBCkYudaMbXAqT6MIIBeH3oGKaKzjuByH5
	X5a0vfAL9TgkRsHBhN9lLQqCRemlZ/Pciw6XKa/glm87XxrCQbQHuHL82QuK3wuZbMnUIqgBhJe
	ida26fe5tfdu+kcQFUwZiXdBktmE6/dW4f5I9j2ChcjG5++Au2/LYS2EtOwVBaG6FhGJ0KY9IpO
	YwJOm3+ttiPpdQDKMT4JrgjAgzRXomM+dSYq4P0Mq/a6qv3sK3GRBp+gbpuSN3+tI1omvlFlQDf
	8GlXU1ir6y+FhATm/Vl+ykCFyCwSdgxylngMtoJvYu9vD8Pfwh0UPZ42oA7Zil3v6jtN7v9t2nr
	M+riFPlIkT59IXUhuolx3TPdoRzZyu/7NDA2yk1WgNSxsavs68+7BOe1o8/j6ODFKZg==
X-Received: by 2002:a05:6a21:6f12:b0:3bf:6c08:2b27 with SMTP id adf61e73a8af0-3bff42b1e79mr8184695637.47.1783026395387;
        Thu, 02 Jul 2026 14:06:35 -0700 (PDT)
X-Received: by 2002:a05:6a21:6f12:b0:3bf:6c08:2b27 with SMTP id adf61e73a8af0-3bff42b1e79mr8184645637.47.1783026394713;
        Thu, 02 Jul 2026 14:06:34 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b7bb8fasm12300233eec.1.2026.07.02.14.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 14:06:34 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>, xiaoblac <teel4res@gmail.com>
Cc: Oleksij Rempel <linux@rempel-privat.de>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot+50122cbc2874b1eb25b0@syzkaller.appspotmail.com
In-Reply-To: <20260605153210.20471-1-1020691186@qq.com>
References: <20260605153210.20471-1-1020691186@qq.com>
Subject: Re: [PATCH] wifi: ath9k: hif_usb: don't dereference hif_dev after
 re-arming firmware request
Message-Id: <178302639386.4076904.12385255997248099157.b4-ty@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 14:06:33 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: 22-N6fzmWIZIAIJ_4vLX7v6qLxET9SxF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDIyMCBTYWx0ZWRfX/Wl+CCTE21lE
 rtvbp0N0BQi67zOO04KEataEeSjRvxBZI8K4pQQs1Vl/9y5eHXvE2HivDT6vr2y0RnMvd49wiSy
 9QbZMnxBIWH4mbKXpGI//uArsD4TTOPNIVmPUcMUDCByIkszD7NxcYRQ7HoyRcoLm7yP/+UOWnl
 DADnQwwR2JGncBMYNhZjETNcgMz4mFjYBiYX+trCsRiW5OLcQ4HNFxixk8wZ2qiSp0xaBb2Y7bg
 TD7b5Mdc0iaTTVs03+WbEupawG4x17CdQ/hvSbYYIyHT46Cv1qiNA6Z0wE8BMwwibzp02EXU8MZ
 AlwSEkt3O5WUn3pvyWBLfUuSRjOMmb1KyKpJ0sA/EN8Bf0ybx7g06yGwERei0subtA3JLYQ0fq0
 nyS5Qd5NOKe8C8Wjb8kBE01NfkF8Wvqo6/u4BTRh30K5qc5p4rp0h9/Gs67CQ8YDXwTx41kzAWY
 LaRQvGGYw24x44REZ3A==
X-Proofpoint-GUID: 22-N6fzmWIZIAIJ_4vLX7v6qLxET9SxF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDIyMCBTYWx0ZWRfX2lKwfHDZRqen
 8X/dHc1xjhrZQ5JgRUHqd9qwAoyvETddeNY7n1ezFme+G+KQ2Vt6ZfK/88Jhb+BzHybmGpdv//u
 s9oCpT0cwvGe46HhJblutlLxMKKS1/E=
X-Authority-Analysis: v=2.4 cv=bdFbluPB c=1 sm=1 tr=0 ts=6a46d2dc cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=WD2RVSGR4ZOmZR8fVjQA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020220
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38530-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email];
	FORGED_RECIPIENTS(0.00)[m:toke@toke.dk,m:kvalo@kernel.org,m:teel4res@gmail.com,m:linux@rempel-privat.de,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzkaller-bugs@googlegroups.com,m:syzbot+50122cbc2874b1eb25b0@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[toke.dk,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	TAGGED_RCPT(0.00)[linux-wireless,50122cbc2874b1eb25b0];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4AF8B6FCDC8


On Fri, 05 Jun 2026 08:32:10 -0700, xiaoblac wrote:
> ath9k_hif_request_firmware() re-arms an asynchronous firmware load via
> request_firmware_nowait(), passing hif_dev as the completion context, and
> then still dereferences hif_dev:
> 
> 	dev_info(&hif_dev->udev->dev, "ath9k_htc: Firmware %s requested\n",
> 		 hif_dev->fw_name);
> 
> [...]

Applied, thanks!

[1/1] wifi: ath9k: hif_usb: don't dereference hif_dev after re-arming firmware request
      commit: dad9f96945d77ecd4708f730c06ef54dcd8cc057

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


