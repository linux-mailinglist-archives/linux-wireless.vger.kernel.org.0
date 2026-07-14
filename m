Return-Path: <linux-wireless+bounces-39102-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KaiPAAV7VmpS6wAAu9opvQ
	(envelope-from <linux-wireless+bounces-39102-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 20:08:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 786A6757B97
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 20:08:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="HHSDr/U4";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=ESxxWOIo;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39102-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39102-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C2DF303647B
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 18:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A9F3CAA53;
	Tue, 14 Jul 2026 18:08:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46743D25A6
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:07:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052480; cv=none; b=B0h63fyg2xPExBnegTJ+N/F55jOtw+k9ZCR/Q/7ltsUVMvtWr6LB9UkS9kYhVKIOBt2o/6EFbneT16GGCpjJYMuDiLEDpKFXPwwlXUnS7exYKp+22vsCeEtkkz90QHoVVmzsCyskPNN2CY6GqJFeor/cR1DfqMYLEaMZZSE/B5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052480; c=relaxed/simple;
	bh=Id7I5yTRoea1W/RaGV4ixx3AGktlt9xICZdwkcgBg4M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=u5wGGcGjvOrQnuprLc0K3Zkqi+5XKLhuW0VYEhYOQh0U/kLWmx6OvggZu3864vS6NCETjboA2f1lX+14skO3WA7fWRGsJxwT3qXpYyuX378BTGfrwzNP5wAQBkBVfTq1ir2vjqC/RvUnRJmoFpZZWKFTXs6A/haNMfQf0CGN6IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HHSDr/U4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ESxxWOIo; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EG6rMp1097205
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:07:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lKUoUOG83HnISxbGitZOWdqzLkiT3rZOC6DygM4z298=; b=HHSDr/U4ZCfNa2/R
	r3ExHKf9uJUQ1TmHAwTzHojrAUQWrAS/Iab1OOLeZkO4krHBdS3wGdkVzi3bO63C
	uiQtb7Y1+I3vMa7j38Si41k+tJ/UgKCFVXUnoOwzuWFFrbFwR+q9w6un0jrmN7vy
	wXkVEdWoLybUs8B1pwIJ5bmiXRJgbQtvOTXY5u9gcOER5Et9RYecc7AUK9lRCDE6
	4kwdR3kvXl93+RdjUuxoMGiArOGGzmBZh6WizVmmhTa79/Wn/Hvm/1Anqbk0LqHR
	ndtbGO57eoYTxuaevJaRpOoYoyTYq50YyTpc2lj0lpEjcZv6zgMhAAeM8NsYXyDX
	tipkBQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnnqs9jv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:07:54 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e55f0613cso530108185a.3
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 11:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784052474; x=1784657274; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lKUoUOG83HnISxbGitZOWdqzLkiT3rZOC6DygM4z298=;
        b=ESxxWOIoSVsLiJ5C73USega45/r9n0RMS3FnndqXJXvRmgrFUIArUHCsTKfYrxvOa9
         /+nSvHVCt1BStZ5fKIZiwDpH4CpUOOUyur3iv/obKL8AdzPWz+vEaO4wTdumdAyBlj1d
         UgJvZZUnjRLhQex5c075sjhEmPLGOGThx2BH0BSxz7VNSBz03yBLVZWpj+NcilI3d+16
         ei/t0LC7pODV2JAX6zD41jz8VQ5gp4yZ38g0atZQPx1+L/tIIIbvyYEx4jxTVXpTirYA
         uGg9JHgFJ+vqgvKnE+GQLO+68j/32TtTZfQ8I8kjWa6izkL4FP9qSgddo1Nmg3IsYz4A
         jIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784052474; x=1784657274;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lKUoUOG83HnISxbGitZOWdqzLkiT3rZOC6DygM4z298=;
        b=cHz7h+eM/mBnBLXo0Who7RmN1CWSXcIcFyg1/+oK0tKTw7tLMKDMGitN0eK3goqZb3
         7dDfAQU06dxXWOwN8hxEPThg6vy++0mo8yUi9N7Q8chPCnBAgfA1Fn3WOq6QDGaJfqll
         gEQrE8o2/K1YE+/51iSuasIVossBdtjkkH8jxwIAYOwul8d8eCrRn1NaQvG76RyQ0qTR
         3zcXitMt27Vemk2oQIjSDG/dwb3N+lMgrJABatUx2LVMPYiurplG3+M2j6jYiYsFAL++
         l6rUoveKvVzxQhcaFuBuE2Hnp229bCcHLCi+SlVjxaTpEkRjv8kLx3B/FiRZX4975blI
         x7hw==
X-Gm-Message-State: AOJu0YxWbv2phOgFbBNwzAjUpDUslVL6Rw0sglmz89GXPFc/TXxrSloc
	JcClJNS7CXtsE8iyXP506qNy7vgM7d+khRtzfNx3ZvHVHu4YmE4D6jQ0hmVg1ZsymmAkw4vCeJ0
	L6fRpYdqMKIlZDF3goVxZlPUgqriRny2R7XTqZjg5lwRK4yLkE36ALnHAEr0wegTmfFlKcpLpB7
	HGZA==
X-Gm-Gg: AfdE7ck6JpKbLpAuCcHHa73wk348ciwD7boXb+ivw0xq8V6Bh4Z06TQTnptggmQpGF8
	oSZDqiteYi4oXQCw2U2cFcL7rwBwPJEcmDjVD/iD5G39k5/QeC9qXQagiPKMw+XBsHD387lwVES
	4jlmN2mgqiO9RvakG1J/UbNiI5Rlk3/qUCHdzEYaARfom1bgs1IePDfjngKaR/JKyxqT3yW44cZ
	T/NcCvEXv3rfDXk6jv+HPK8U1kqoelBOcnef0IHi+AIpvx0lgB8Bjahe3eObedPMKYuDSpAE32p
	ZJGUbbOxl+4F8Eewrc9LAmXGB0kOt34DSs1djcBjE4iBeQ8NQRyo9p0P3kEgpvD33C8v+5XhS3r
	Erh5YS9YmyXWRPYLYL3xD8h+o7EoAI0yQ4zsbzIx9gX1UxaQig2SUuoxouu6qC1wjXA==
X-Received: by 2002:a05:620a:2a04:b0:92e:dbbc:3992 with SMTP id af79cd13be357-93086bea7acmr309130385a.52.1784052473935;
        Tue, 14 Jul 2026 11:07:53 -0700 (PDT)
X-Received: by 2002:a05:620a:2a04:b0:92e:dbbc:3992 with SMTP id af79cd13be357-93086bea7acmr309127085a.52.1784052473445;
        Tue, 14 Jul 2026 11:07:53 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930759c63fbsm465448885a.22.2026.07.14.11.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:07:50 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260622062324.758533-1-thiraviyam.mariyappan@oss.qualcomm.com>
References: <20260622062324.758533-1-thiraviyam.mariyappan@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Reduce RX SRNG interrupt timer
 threshold to 200us
Message-Id: <178405247016.4102418.4581007365191961426.b4-ty@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 11:07:50 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE4NyBTYWx0ZWRfXyB4t+wuD3JFN
 mF0j61k8qmaXgvaVR2VM9ZqJwqKmH3cjH/Ag6B3nEmjqLxCVeQ3e9CAqbDD4Fpb0Tzl0C/8G+96
 tIL8ohY1n6s67S68Ccx5JwjwMuc4pV5FSwW93/WX4RcTsGUWOpT6CGn4/oQNbWUACvCnpPYr41l
 2rvjQmJF/VArcdayIAkP+rBVGWmQ7L6MmoBIWVgDwGqsyL9uXXo7kcYNLqe6V6tFlplIScQiCSv
 PSeDQXe/Wyz11dBWryc6CaX1Kq2RnjDXj06E6ockcCEJBsy4Sj+V/zqEj4BmDReS8qqO2V4718g
 5vDgRqfFJGvUPg14Fd+u2CO9B6fxF9xZYW/M0HOQr08zX+42AZQDUlAuydEUXwwYX+RWU88YtO7
 LLfr4VuqKvAGoG786SSzRGgfHkVWBZ/GPGc6hPi43XMPS+tvfCHcGuoXX4twWs+aBx5C1b7IXGw
 g/cSuYdfYXxPDCiVMEw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE4NyBTYWx0ZWRfX0YVoU3Ss8dHS
 RkaTZZqmSb/HCp2A0Ay0bJh5zz+/hbGq+aW4LnTBuVUaiY+CBPN4IThAd953qtVDK1q3oso7SZL
 8ps+klCeYq66FpyCyK+cpVvqCogu4X8=
X-Authority-Analysis: v=2.4 cv=U+Oiy+ru c=1 sm=1 tr=0 ts=6a567afa cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=yhwW3CUv4AqFQEUyz7wA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: _JzKiVttrrsudc6cJVRd3wKye-KREVD6
X-Proofpoint-ORIG-GUID: _JzKiVttrrsudc6cJVRd3wKye-KREVD6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140187
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
	TAGGED_FROM(0.00)[bounces-39102-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:thiraviyam.mariyappan@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: 786A6757B97


On Mon, 22 Jun 2026 11:53:24 +0530, Thiraviyam Mariyappan wrote:
> Currently when RX traffic is low or intermittent, the RX SRNG interrupt
> mitigation logic defers packet processing for up to 500us via
> HAL_SRNG_INT_TIMER_THRESHOLD_RX.
> 
> This causes excessive RX servicing delay, leading to increased end-to-end
> latency and degraded TCP performance in low-concurrency scenarios.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Reduce RX SRNG interrupt timer threshold to 200us
      commit: 6b31c3451b12cfc5e86a41898014cb62d2a377b1

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


