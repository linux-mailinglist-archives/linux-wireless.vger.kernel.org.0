Return-Path: <linux-wireless+bounces-38409-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nuhpE5M0RGoLqgoAu9opvQ
	(envelope-from <linux-wireless+bounces-38409-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:26:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B53416E8224
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:26:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=pGDP04tS;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Vt51xrWg;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38409-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38409-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60738301C964
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 21:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2542119C553;
	Tue, 30 Jun 2026 21:26:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50943009D4
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854791; cv=none; b=bILMzVIloaJlbZeb27R4piCGan+ne4VVuvyn8cJN/TYcNNlnHE99yRx1P2xWDu9NhpJnHcL61v5VwLtNtyL7YK/w86Ybs3G9kCn8e7FPgJzhnmldQjChVuD4S7Wrw13r3uONFlTggYhFQn8JtX4MUf2Lm8hEY7EJeRCNtDP2phA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854791; c=relaxed/simple;
	bh=ku1xKWWx+ow13TPoZF1Hs6Q+4WTm4SMMOwZTQa9PSe8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mMXlz8x4IrqS1faXA8ZbgVdph+Z6duvsU87wmQtO9qTFN0FLDqpbSx97h9v6aqSUoIXzkmCZbjpRuu3dPf0h9R+Z1Ux55YtwY491ZVQvTuWTknbBXYR/K82UJraiEF2JtVI1qM4RzvCd4fsfeBzWzvILNeqGlf7vKl9RkAOwHHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pGDP04tS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vt51xrWg; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJDcox2948554
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w3HnasqIsSKbikCogHHVowiGs5a/Lkgy7cngUMntdM8=; b=pGDP04tSwQ25tjUw
	WmzN/P8rIV9LO1diP+lx5nYDOQtq/kW19EHAHzi5mOihsWD6saUnnTYspRzzHxFa
	tDBmkct7Kv3Dku6pu2mYjXWQ0dtOfP3HrZU1KfK21n0GOCNe2Yck+JEBpqvsolLv
	xpajK81y3IT3SKJkMrJhT7mCMTXild9fO93G+RlOw/FH+7NFe2KskpHkKtinh+k5
	b9jXdLyiZ3nriO2vDtZGeyqziMbrYOH0DxjCQjsN3QRYjYR+pOyTSC32vI2ubLol
	kQ7Xz3v+6H9f+qDkY2ESTtV/6UT7UEowpUnm4nM2nEagiMyDE1tYZnVdclOL7BRP
	Id4I8w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4kgw0k05-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:27 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30c0a27ad86so1065765eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 14:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782854787; x=1783459587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3HnasqIsSKbikCogHHVowiGs5a/Lkgy7cngUMntdM8=;
        b=Vt51xrWg7/MKnUL+5HKMoSwRtasTzsvxELEdzQFB52N6geWEoUXMpARmnGzAKX1Fxs
         hoEFYsP0J09tKGtoweQI49F9dmxwmsImcB5Km/zt3pwG5OFAeWjl33djfVlrOKvCHYRQ
         WIk3iDu6pOm93/WjFSSVqolFdNX37Ob75Gq+egmedEBpv47Nu4FZ7Fjq6DTqqii6rJVx
         brpEOBMouEiejlT/LKxJmmUZu3001FZehX9ShEmDVaQqJSzNThvR2TSYq9nLUw7MA9rE
         p3EW0RThX/d6ZDSlTORiHQn1xMipHwOM7iOZQmIhtGRmiJs402foz37wo2R9w1NKy74E
         EaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782854787; x=1783459587;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w3HnasqIsSKbikCogHHVowiGs5a/Lkgy7cngUMntdM8=;
        b=DZ6SBOtIxY2kvTJoO3IPF8kpmEUljACQ/R9+qckqIz3FMXq6+7BlYlZLGwgTkc47ww
         EKwn40wRIRnwjYh6z2uGhJdcnwePr3mhSXSnQOF1b3SS0FGgNnvQv2waPL625lf8mGp+
         8qs4/N/Jc6aRMSG/aWm4Wx5CxOIYgm1d4S3iSW5ylNb/RF9FHum33VrF58CaNGJtyEP0
         CzZwH23J9jYDvfWduxjWfB9gXopxFrp+Y7qWZddmRnnOBFxzBH+P+MSb+eGCty7fMpm1
         aY36qIS6vFpH7qi4xE8AnH0QJMr6tQ84Oi2ns28cOCtWhKoS14JNCWFuICeNKV3Hfptb
         X8Xg==
X-Gm-Message-State: AOJu0YwUgoavjkbjCoeIL8sr9/fS/S5x07xh2klkyejSmO4EHSUs40P0
	6rE6jRkBkzmpBezRWvMg1ps18JS/UTPDmFbhdiu41uBt3tD82FdBGtGjuLAPNYedDAKAMNbmgeo
	8MXVk0kUPgif0asqoFf4sO55UJzNGVlYoTOzcMKXIlS3cHp1NxdOKHERQCUusSx6j7P1wxA==
X-Gm-Gg: AfdE7ckZ4i40wjgXIZSIsFA21FCt76hh4LwdjfXDXZf58MlfcGTz+vnrY1c8iK2tp+a
	WPcv2GG4pyLHn/fALhUjUZHfLgpNgSO/w65QiFnHuPWpKOzx1FEmlXk2UUmzFul1zOJhql2lNAO
	Ihz8S/lFZ/YSlSz8QaKYHzRwLS175wd5sQof2Kfo6OM0tKj66s5BJxW4nLhuSLEMCBkjb5Xm5wW
	lYWORXUBDcWoLBL7HlyaE6UyLxbgcW5xayAHLapYXsoq38vWaq5jWJcLM2pnemlt85PrpBFKPsZ
	Q+PYxNLfJuDGOSuhfsGWXqL/j4IActeoetSIh9NFVvL6R7fxciPvUMYQepRmhMrNW9CRr6mH+cK
	kTpWuQJHlsOU1wGfzCyQl2gZID6bXgTujehT9nKTupMQIejy6pQewUXHNPfVApPsSDA==
X-Received: by 2002:a05:7300:190e:b0:30c:6d2c:2aa7 with SMTP id 5a478bee46e88-30ee144e6e4mr4429778eec.20.1782854786542;
        Tue, 30 Jun 2026 14:26:26 -0700 (PDT)
X-Received: by 2002:a05:7300:190e:b0:30c:6d2c:2aa7 with SMTP id 5a478bee46e88-30ee144e6e4mr4429752eec.20.1782854786039;
        Tue, 30 Jun 2026 14:26:26 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee300b286sm11604046eec.12.2026.06.30.14.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 14:26:23 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Nicolas Escande <nico.escande@gmail.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260623151613.72113-1-nico.escande@gmail.com>
References: <20260623151613.72113-1-nico.escande@gmail.com>
Subject: Re: [PATCH ath-next v3] wifi: ath12k: avoid setting 320MHz support
 on non 6GHz band
Message-Id: <178285478349.1590147.1883672407470412706.b4-ty@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:26:23 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=Co2PtH4D c=1 sm=1 tr=0 ts=6a443483 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=nZWXDgwjYB7QwpdpdXoA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: tvFHJp3EHOA1uNdz8z27-dpHi9IefWQq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIwOCBTYWx0ZWRfX5fV75p58KSR4
 s8ytvgxAPqkJE/N7fozeGi0CyxKoF+V1dG9CbmBi7fKlDsgVA7dhR74NYaJqknnXAHGDkJBK+Ew
 dpyNt9ce7mC7Kbku61yDObDSoKQ5Z8Y=
X-Proofpoint-GUID: tvFHJp3EHOA1uNdz8z27-dpHi9IefWQq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIwOCBTYWx0ZWRfX1oDAzQAJaGD0
 FEiEekEzOg2K0dQm3TZ0M4Yx0GA0gjh9LL+oQyVdKs1lrHSz9W4AbJMXxHTXUTuGZTHv0iOYwz6
 i6dWW4tANBQztC4bV2i5c73Me9XKEHbVC9Bj7dpDyvYQ01xxXH0BxBIyIrXfdtIvmaDj9W3JEhS
 yrJVH4peV3nO01uRY3yZkkIyAJ2aqSLq2QqAbvNAnViwcGuUzcFpyezOd9ewPGZFgNLFj5Y0gB7
 CgagInCoOBtdTUWfgv5Ff267jUiEd7GjXeu5HxA3utf+Z1mhp90iCdpvpTlgn6lX4sEefHrNgOD
 daRWiBSNtqHbzhrTVmlJCLBA/RXgWYuV4ahVWW/nMQI0I7o9j6XRSJEv67THdxPmtzCuXs5AK4K
 YEyIMjIWtZiDy37H9gjj1eRPhALT697XQbuK+9hXMb5VympISHWGK2Ifj3FIrlUEzQjeU4SgsWG
 sQQQChZAiww4sHwX+8A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300208
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38409-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[lists.infradead.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:nico.escande@gmail.com,m:linux-wireless@vger.kernel.org,m:nicoescande@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B53416E8224


On Tue, 23 Jun 2026 17:16:13 +0200, Nicolas Escande wrote:
> On a split phy qcn9274 (2.4GHz + 5GHz low), "iw phy" reports 320MHz
> related features on the 5GHz band while it should not:
> 
>     Wiphy phy1
>     [...]
>         Band 2:
>     [...]
>             EHT Iftypes: managed
>     [...]
>                 EHT PHY Capabilities: (0xe2ffdbe018778000):
>                     320MHz in 6GHz Supported
>     [...]
>                     Beamformee SS (320MHz): 7
>     [...]
>                     Number Of Sounding Dimensions (320MHz): 3
>     [...]
>                 EHT MCS/NSS: (0x22222222222222222200000000):
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: avoid setting 320MHz support on non 6GHz band
      commit: eaf478b3ea68e1b5df659acd24c4df5850e12325

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


