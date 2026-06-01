Return-Path: <linux-wireless+bounces-37272-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJUDBf27HWo/dQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37272-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 19:06:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A28162301F
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 19:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE853308678E
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 17:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804F33DCD81;
	Mon,  1 Jun 2026 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e9xurB/R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b7O9FsSk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA913DBD72
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780333234; cv=none; b=J+M1Qkx9pghRG1NVjySSBF54Da2m5dKPyapnRXAkeanItLnvXnsPf5E/dzn4RYlEEK/hGXCZAAXV8JvM5zgKsCY6UF10cOgNZL9xmgu9Hp3oYjrFxjKvddgZPW9cXzo97wUYef55sylAx0PCrEy47H1IlAA25dXCr1cP5eo0b7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780333234; c=relaxed/simple;
	bh=eg1UU1KEh8t7kDMy5vM/QAHILoSKEsKqMsLiDeAbP6E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FizI8unH4tDkbdJNvGN68jaiOoKR40FwFSGHTL0Y3s5sD4Y2ggqfM275X2kd17YtXrw9AbuGZEC/KHc8M03fwxBeKYoR+ShCGoXil9C1eLjiBHcrFxvP0MYCr2MlGQcyU2N94v0cFXpHN6IS3K3wNk8tmsc33YpNEADQRNa9q/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e9xurB/R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b7O9FsSk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651AxKuP334745
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 17:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5dk2+hefe94O+p0bhIxq1q58iVSITjTtWcV4dDmn5XA=; b=e9xurB/Rr1XHzdIm
	IC/uvZJfFW0pFtFb1/hN3si1ieMr6A/h1DO4tWOFFKjvj3AT2woJkS4rXG/iWAKv
	rIyiM0IVbn9pKVeCxRCFN1ILo99H0JAWFsyvBfD1al3Hf5D/Dmci0sQaAzuvYK86
	cz6191SSIhu1eKKiILOce6i7rgkjiaHgpZ6ltvuSFyIifym/3UMxqTeYvFboL1uA
	vqFCO6lDWCd4t0ybjM6adW7VZ2sl0EnAN5WDly3fRKRzlz0dP0jp4D7DZ3kqSgkF
	vCn6j3tDIdofohWbJpzZE6BikUb/51U7dy+IU1viawB5MGy5hUiRLMpOTo1hbry5
	E/WqUw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh8tfsjgn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 17:00:32 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-13709ab38a8so10458216c88.0
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 10:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780333231; x=1780938031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dk2+hefe94O+p0bhIxq1q58iVSITjTtWcV4dDmn5XA=;
        b=b7O9FsSkGlxTbRSu6JoTvuL9YAMBdshbXUlnBVkZipJulyXhkiHzYSe31gJV3XSzZT
         905l5exfTw0K2ZQbbfeav3dgn7OAAKq9cHUtw7xZ6WMd+LJMurIiZaV6JbNaWzWGxnen
         POqHUNAdABVhafUsM+W+hUxXV0U5LbKLodgjRMmhqLPpzhLMkd3FFH7P1wydDkbb8puD
         fZNpsxbrengDcNSN2nbbp4xXM1gwoDJ7jJcT6YQgBbN0KPtV5znHg9wAwXiAhTiabv2V
         iUv90oHnkf2STJe4DClI8jsbl77FGunTocKko6XxfmovJD4953xtQR6VaYx2C7b2/fiK
         xQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780333231; x=1780938031;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5dk2+hefe94O+p0bhIxq1q58iVSITjTtWcV4dDmn5XA=;
        b=As3eOvq61eRozLCW3Zb8BurR1QI0Ovbt6q1zV0yqBy9BvDCP6nxTmbentN12Ozl13I
         Ki7yrZeJ55stJDYZqP/Bu21sP1ymI5pqploXUXxvVXigya0H3i/eCmqzAqrRqHbBEavi
         zcxnIFRbrrGpRwU4QxCQ5qFMieEGW7sa2PUL//xkW1vmkq06nPpYQ8kzMZBGNAdWUhxh
         7d+YX8avAvrDZe4k6x28bOMK1zo2e+3ONivptuW3CyC7WXuEGgD3lyUynDlLS2qs1IcT
         /nioLjRdl87fP6CpGpmrK1t9vkZXBBh/HVtc4cg0Fi+aroelZdKveJFo+D1FrOfH5g0j
         DbSw==
X-Gm-Message-State: AOJu0YyL8kIMYlb17chVDHvBKxxnrEoxrs6G+ac//u3fVkZHdoo2mWol
	845IEShwkvYWig6wJdmhmP/sILMPQ7YyyO8Ov36yrfBVDHn3RFz1K03OoYtVWvQBXVF5V+SWf3M
	RKxlg5tb3o8YnVhH0QwQ4gT8Wo7sibLR1mfexBRvxu2M5sK1ddGyfH7w8JplTXlISkVVtJA==
X-Gm-Gg: Acq92OG12wRhXWJ4EFy/nEIuCitYc1j4078eUneRJ+cpPaWOrZj1FD95afG+CoddlVZ
	8uBYeDb49Sa/dl2rP/8MMI83Ynm/ditE/ZeY7V1Bmrzkz6TKa8EyMy59wOjsfdby4eSHuO/nj92
	WirFWxq7x8fzP6HUAHXcQQcoKcCulp4IFD2ll1ztD7Xa0DfWdk2t+XS1yBKgX1jL664vhUStXZH
	zUHRcv6lOqqA1yBGZmjYFRk7wFGa9atLkS9tXkn5YJgAlp68ptQUssuxuooIMK6oDl56U+Lh7dp
	h0+e4wKjJSK7hw5NXhv1XkPMYng+VDmBSrN0HjeiP5rEuvO/bW4UbJO9S52md41cVUwraXCN3c0
	gd6Hu8ICgeOsERPp7Se9tPk/PZQjQm9sSFVsnHCgqdtj4kfh8oUKcvC/gpW9Nn6XEF4TsMA3XCJ
	3cEtDCZY5hxmU=
X-Received: by 2002:a05:7022:ec88:b0:132:5d96:3e48 with SMTP id a92af1059eb24-137d42beeb9mr4823627c88.38.1780333230063;
        Mon, 01 Jun 2026 10:00:30 -0700 (PDT)
X-Received: by 2002:a05:7022:ec88:b0:132:5d96:3e48 with SMTP id a92af1059eb24-137d42beeb9mr4823602c88.38.1780333229302;
        Mon, 01 Jun 2026 10:00:29 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b3c69bdfsm7151625c88.9.2026.06.01.10.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 10:00:28 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: linux-wireless@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
In-Reply-To: <20260428205017.26288-1-rosenp@gmail.com>
References: <20260428205017.26288-1-rosenp@gmail.com>
Subject: Re: [PATCHv3 ath-next] wifi: ath11k: use kzalloc_flex
Message-Id: <178033322855.2045173.15165164858522474928.b4-ty@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 10:00:28 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: d5XVgOJVZX2Qk4kWdYTBQbQ7UniWiJsB
X-Proofpoint-ORIG-GUID: d5XVgOJVZX2Qk4kWdYTBQbQ7UniWiJsB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE2OCBTYWx0ZWRfX1YUUbZt6esma
 A9g1V3PkUksIJckBLCQsjtYKaneoFC+qco/fhuR6eCQ1Li7+D2SuCfvVe4+R/wf7oHNQhahcSwF
 uuIA4zlF8QKhcTvHviSZ6RubnAvrpQNYekw5E1VPbWr2W7m4ZrPY1+l0y+R15qqJBHkFHvZmXFk
 8gDfllsrOamSagjKw/X2f1dipuxyXuYlpAEueb513PlfTjVahZhUnTTN6IXFkiVa+qtsOwFf+Ja
 5mWdu2J++v60jUeCJvJR8TzZj3+34/F64j05G92OvrWtfdvzDcwSooXQhq5q1Y24fU+vq1uJ4Vy
 LXGrKKgg8LkybLsg56jWKcmwmzJQANnn2MX/twr3FCv1+h8zA34fbly5fjhweRgTFGwLKUhsX2/
 wNOJBDjlf4uAAsRME3E0jVo4UjEZiwylQ5eQm7oQQQeXunrSK4y/XfqtC+Gzgnym8q9wp+2krdO
 HIPIhyHvwO1NjKiDj6A==
X-Authority-Analysis: v=2.4 cv=P4YKQCAu c=1 sm=1 tr=0 ts=6a1dbab0 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=rJ_IYOnZYG8bJ-BjWygA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606010168
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37272-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6A28162301F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, 28 Apr 2026 13:50:17 -0700, Rosen Penev wrote:
> Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.
> 
> Add __counted_by to get extra runtime analysis. Move counting variable
> assignment immediately after allocation before any potential accesses.
> kzalloc_flex does this anyway for GCC >= 15.
> 
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: use kzalloc_flex
      commit: c7427f297ddb01f593217c21b2416f1093b80194

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


