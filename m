Return-Path: <linux-wireless+bounces-39107-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NrxIDQ17Vmpd6wAAu9opvQ
	(envelope-from <linux-wireless+bounces-39107-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 20:08:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C2A757BB1
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 20:08:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=HAXImbDc;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=RgDGfH+o;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39107-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39107-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E3B5E303906F
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 18:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9CC32ED54;
	Tue, 14 Jul 2026 18:08:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413353128AB
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:08:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052486; cv=none; b=HghoHZzCfce/o32FJHNwXBA7SNFzmaJB04JyxJ/IAAzPIUlK1SuAnPmMgR8AkxlNXQSIcEjoIVYqdPXKFA4gDYakneY4HLETyuMYj9uJEE7/cvzjkEWjIwIAZvPl3qMfgdqP23UOteU4ADb1OD/Ph/bV7Mc39UPie6kMIxLqF70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052486; c=relaxed/simple;
	bh=HeTk94uwHCEzVKcH9LMNbLNbOrxA9PznkfUgFQobbfc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JNzPcVp/8jjfYotB72DZ9Fv7nrIv3vDqxcb2cnXxZZChgqyAiq43VyCj+xs44iEI33XPit1CQg//w9BET6kPDa327Ox8inULMHRWSfQoU0yqSKZdOJgxrEjBtaN4oiGUs2syiZr90r0cL5AVwrzuybvefqesoLEth57gT5z/p+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HAXImbDc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RgDGfH+o; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EG6pNq1003053
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:08:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PdHNN/+NVJdFSnlG4WATmfl0i1xgtBf3W3af+KkRuOw=; b=HAXImbDce0BPaW11
	NbW0yL/adewYd9/9qEbHUec3/3unyi7kDA4MyIj7mvSDU2Lcq/Dw5ESO5S/dZjpM
	ruBh/cbSbuj9VyolIu3eRQWsqwcBeomO4iGRJHTl26ZYNnKA2GOycw6zCiDyEmGI
	OUqIAOiJ02U0+LGDru/Dpj9xt27I08B8820T3kq5ofI65zusRUp/yciMHWkl906W
	pijnCA4FhZUfG+DIigflhrRqpos0JIfjU9cWZO3Expa8j3+7jJXpZZp8HX3v+BnQ
	BMy4PijaieLO4U03e6TGVI8v/q1EXtUUZvGtcW9xfZFZkMGORSksYB06CstYcCtd
	U7QGPA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnnr192e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:08:04 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e59b0e0f4so117735385a.1
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 11:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784052483; x=1784657283; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PdHNN/+NVJdFSnlG4WATmfl0i1xgtBf3W3af+KkRuOw=;
        b=RgDGfH+oQ6uN9pzoxJMDWUHtKlP/wetPTn0XPyI2j0xpp2ZWsE8P9yK/2ddUKv5Fs1
         ZwdBP646iotqniy5vCj5eQtMAHDKpEoq2Xhze67+g7B0SoIsG8fibTgJEzf/KUBTGG27
         aPRHRMW4VZPE0TRxqSe8qJ3X772qkVS76Z7mGvBInH0b/ETB6wAdv4kBewMM1/ZAStVU
         9bw/KbSbqHm1e0O88z/EFR/hHutv332R0NNfyXqjulgZ54XLhJh8RKqFO0W0bNa8bYBi
         87QaeFU7jIfOacv2baCerSJe9yRwIjRPEtkqCkAGxObzKK555ZxQD/VCC7Fnmc5GSWuj
         qtIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784052483; x=1784657283;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PdHNN/+NVJdFSnlG4WATmfl0i1xgtBf3W3af+KkRuOw=;
        b=ZgsOaWMxcvK5xovnZlVUiyPG8npBBeqEw1yZFGc/SgP2BbcCWjl+ToEildym3ba9hS
         6CmsyO6ZWa3SadZwC5S5ni9ZBTHVNekiHnbBOg7GCCdNC7yrjcHsIkPxUsL+P8CYsXvZ
         dKZXc1p/F4UxmRZivm52AcpjlVDIBu/dODWOwc9Ygxu/ceuQrKhVLyxdTw3pQpWh+nKj
         nRYGY4KOO+GAbXaDPw6Pws0DEBK1DNqvDMO/6+pJOuFEflYWnPZrC+EshPsH5ljIeqPA
         s/mIr2XHKA8bl+Dl6VqpN8f6KyvzaaFl44L+6b/TEvItinQriyT6cCUKB4aj9BGM4qam
         xWEg==
X-Gm-Message-State: AOJu0Yy9h3vtjB+XbB+JNwXizeVDJbBhLKaZutYWl6O+3MDuOiSnsTZJ
	nN3m7+lNM4eRt1EiyJR3yvo87YFFpOobBn4pMkrh1FcKG7ZVUyZ7fYyY4OmiBQtB8Roa2YHFpIN
	tAhAuckay/slEgwATNfDzDneUUU5Bgo/FpUB0h9gj0mWOBNL7W6xGvr0oeiCZfPR6U3O+LpB6EY
	+AhQ==
X-Gm-Gg: AfdE7cmXg7A0Mmdnof0fStY/ALLUvZw+dKgg8bW+E5WxbdPoAzZZqqDh/vcHIMA+5r/
	8cJ2HcsB8UheMZMJHKACcmiDaBVbgZQAn6WUJHm5HEm2ByAvnvNwXeu7l6M4aGb5/QumiqttfJ3
	4riDOL+WWuFLDF5nufw4qReo6Vw8cpKUoDFEfEIqreFbP8QrwuOGuuXYcX530cd4/NptuaSklA8
	lSZ3Ev4HyN09tCY+ul6f4FJH4TQvHZK26IC/AJGaNQnQzzvc09quPSK9LpZnGdqGowHY8sn89pU
	VWWXgzaQHeuJlmloctlD4IeIQyiulZ5YM0lg44ouqaO4U8jC4RZ1l3K7CGS4Ul24HHTRzZGbTH7
	GqsMluAPg+W7ZLp/q3u4jhPaPkLIdQLfZfOQ+envDpxWMZ5yhXnTVEYeWLSCTp8tuXg==
X-Received: by 2002:a05:620a:4141:b0:92e:e250:f15e with SMTP id af79cd13be357-92ef2f675c4mr1438082985a.85.1784052483447;
        Tue, 14 Jul 2026 11:08:03 -0700 (PDT)
X-Received: by 2002:a05:620a:4141:b0:92e:e250:f15e with SMTP id af79cd13be357-92ef2f675c4mr1438079685a.85.1784052482962;
        Tue, 14 Jul 2026 11:08:02 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930759c63fbsm465448885a.22.2026.07.14.11.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:08:02 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath10k@lists.infradead.org,
        Manikanta Pubbisetty <manikanta.pubbisetty@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260710060406.3323260-1-manikanta.pubbisetty@oss.qualcomm.com>
References: <20260710060406.3323260-1-manikanta.pubbisetty@oss.qualcomm.com>
Subject: Re: [ath-next] wifi: ath10k: trigger hardware recovery upon rx
 failures
Message-Id: <178405248163.4102418.1966503659201070953.b4-ty@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 11:08:01 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE4OCBTYWx0ZWRfX2GpIVJ7i7zUf
 VikURwm02SpG7yqQJzngknf6zNc8KUmrACCOa8NCrillzu//efGBEBo3YuU71l7goT8GB9MhrR4
 O5GCvQuzFbMuoYhY2nqJVBNkAYDQjCo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE4OCBTYWx0ZWRfX4nj3TP0s3f09
 95Xw/8As13M5A6SvumWmSaTW2HlFYz0EuleHFFol1oEP2A4CIgbpDOP4Z7mVg12hjTeBkyAhSN/
 BAsRnLGhHTzauUtWSSTY9yiZciAA1q7M3RhrozQOxugc/LKNQFv7GpNCAVsB+FHrPqIkllvb2Re
 DtYHUzJ31UcPe6EsFgE+ssBIN3AHtg3L2BGhW+3bghg26nYHcgfm/n1/+fOdxbVmWwUF3A49NKO
 vP5EKdwXFfQBXYCTP7KrHIgCdM06GOOjJlRYUBy54TcarsyMhOmdp2jpLtnwKSC2lqrOBqDD6e8
 ZQtXVwbjBGTZSOOSRkkUxSC95pYq++l8ZTenVEfzMKnuM6rJZLjcH2rRBKYdxD/Bzwu3xHZAkUi
 YCOWvX8Yg5H2SwajYSE7OPt0Sej5pOo5DrpyKShUzNh/upBUHg4R9E8nTqJtpOVva4LEBfbBTzj
 6C40TYB4BDnLkCsntkA==
X-Proofpoint-ORIG-GUID: yqNWkvcdrVSmIn4S5QePJobqL3O4UF38
X-Authority-Analysis: v=2.4 cv=NfPWEWD4 c=1 sm=1 tr=0 ts=6a567b04 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=D6bBqopfn0aMulu9HN0A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: yqNWkvcdrVSmIn4S5QePJobqL3O4UF38
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140188
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-39107-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:ath10k@lists.infradead.org,m:manikanta.pubbisetty@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D2C2A757BB1


On Fri, 10 Jul 2026 11:34:06 +0530, Manikanta Pubbisetty wrote:
> When an error occurs during RX packet processing (e.g., MSDU done
> failure), the driver sets rx_confused and drops all subsequent RX
> packets until a Wi-Fi ON/OFF cycle clears the flag. This can leave
> the device in a bad state where it cannot process RX data traffic.
> 
> Instead of leaving the device in such a state, trigger hardware
> recovery so that such an error state can be reset and the device
> can function again normally.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath10k: trigger hardware recovery upon rx failures
      commit: da5d73e12af2bc517d5972186a87e7d297d6d0c1

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


