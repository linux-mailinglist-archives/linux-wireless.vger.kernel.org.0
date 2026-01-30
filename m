Return-Path: <linux-wireless+bounces-31376-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBfCLjvLfGnaOgIAu9opvQ
	(envelope-from <linux-wireless+bounces-31376-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 16:16:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3D1BBEF0
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 16:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C11A83043AF4
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 15:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F24376BC3;
	Fri, 30 Jan 2026 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o5WJZxsJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IiX+Wz4Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79889369980
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 15:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769786141; cv=none; b=K5nGzJcCaE2rCPQGb1jsGKHhXEcAQ5a3qU208HlWWLnd+oSpmZLUvFSNqc7IiWI2pOvmgP5C3bCz6eHFex3Kv/VVSVyCDVP/skVpARZXh7YZPdR33UGU/LjaBNPSwBQZUg6InU9VGGmnWazZskb/hTsh0Kp9dh9CceXM6+4qQVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769786141; c=relaxed/simple;
	bh=j5UVG1LjFqpiNcRdFi8UDBMJhKN1hPHn1CH7rkfc1jU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PpfeKRVcKGk0199bye/Dr4lh5dcCls4asIIgTUFTBrS6XrQQeJGhzygv4K0wSI0O7jehnPRRCsk3IZCVQuluKT83/RfpsDyMGvPE3QZEWmvvN5uRB+t6ld2miTA/SZlaVrrL/uT67x4T9afobK1yVALaKnqNmhXU0BHpzfHogH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o5WJZxsJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IiX+Wz4Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UAOuaO485878
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 15:15:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kDBUns8QdVZi+Ok9YKzcXeyCwOvpVb+XbSmFY9coZ58=; b=o5WJZxsJnBZ5o7gr
	OojhQb8v3eMhzwcDWNdtKEEeBwlKHEYik3ByfoDzPFs3pzYwPSb33BBNfzOYZV9i
	FdMvmwOnA8HayUFQU5Ve2paJqLPON5v/U7aPYMZWszuUE36NHXqZcyw1TZsYzBRx
	6LBjuaNBrJU4viY2mNRTe/IHwLHlCfOyZG0EoIc0UWgeAKkBiNGCo+bHSX8p33o6
	DSpWIp/8JOr6BCQYT13X1IHb4rOsyETVYzXHhVcJtU/ZbPNTmheip9xd4tilnVrV
	p3NVwUqQue5LNrlxI70pN9EqVuFgEU1KDGXohDG2UshAbSZ0hHsNPED9IFeSRKpX
	bbYdzA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0gtnjkwv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 15:15:39 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2b70d8095daso253098eec.1
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 07:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769786138; x=1770390938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDBUns8QdVZi+Ok9YKzcXeyCwOvpVb+XbSmFY9coZ58=;
        b=IiX+Wz4Y3sN9pwcGvMCLv/2cfBhxgDEPULBA/HnH4/U97zo78i+Cpi9+FfHBnW6PyB
         v22XCtOLPuA9wX4kgf1etfLZJWhEfhYOWztaSfWyMA5I2YA7r+3sMGFJ0+CzYpGTu/kg
         xGAvLf7Kxa4XnbkZUzSbP0wKhzfeNmxiPxtBTbnzHKc6CRti/3QUavq5L5BJRgIAozNO
         HlEdFIJbEz+7GQKnAGTzD4/Eu+6DRk/tmNXxyyPRksRnojepLBtr5rRp0PoP4FnV6HHA
         /bKnizYct7oAUo8ZwoyJgXPkyit3le3o6HGxRtiQ4lhtvrfX/Jr70GKmqJM3aYvkM91G
         NmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769786138; x=1770390938;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kDBUns8QdVZi+Ok9YKzcXeyCwOvpVb+XbSmFY9coZ58=;
        b=NcJ1m5BLPhu7Zk5j4EItlvTfeevXHHkLZiKteZIwBgriJpboxNnD1UdsDAf5XFT0E+
         qJQ4cE/z3+sNCA2i0VDHnNeSG2T6qyV1yJd/XjMLx0TFrDWjrMP721Vcy//oSl/NezDV
         B7oW+KMmakqB0RTB6S94QoLLxrOpy6Gh33Ql8HPukeK76O5dCye4g51zH92DnMxmB7M0
         pIle4iYUF2wU92STtGg9zlE6WiTFqprJZ/XYXil/RYofcxjjuscxTb6RPUymSSwtBdxe
         x8NfVQxTQ9fd2XbekvsLu3DUXunckFlDm3UzpXn815UDAM9YE06cO+S3AA1uL7ihNo0K
         HIQQ==
X-Gm-Message-State: AOJu0YzBFWOoBYObrA6fSHW4FBXqK1My/94ugLMg89CJbqC7fsPkmi3s
	qHHJmWAud9U9S1Nf8LhIXPGeita4puVuJ8GjC5vFS96OOwo6AF10HLFMiXKsVYlo6+5KaPspDy1
	RL+JDGUotI0Hkxj9xxKC5MBE0ZDhENngblT23ARpbvxTmHiN4RA5PvI08ajk1U/4RjWd27w==
X-Gm-Gg: AZuq6aIYH98t48i93/5RpWo5VknUnUnH3cPxwqbL3encRwQOY0aD9w4/ahZPdv0TE5c
	MgZs3dL1QkqmpXtzEcAUTjAel4JK+wQrN0AK+VqkdwHv5imq0Qn129mdYABghBMTAUFwtY4ha3B
	0FdzuaG2m66MvXMksxMh9CfabZsdzq3a2uN5p6y3ppo7iqbi/vIrEsSDlvqarGnWxJq58lji1XU
	JbI5ogv9LsMzH1nzzu/1JE/ngQK7CRGbkWpuGWzByfyZhwUQ91YgtGyw+0soZdfVp3YVwmpvN/Y
	ABDhOffewWXSjGxojIvJ/MQoQsjvP5Ly5ZcxNIuJ8AUce23iQrqv3OTqwSPa6y/HDVAA0sWsRjV
	OiST5ozWqj62qdutEIaDnrI3zvrC1pCQCK6k7pu27nVVIoehLfmwrX5b8VyGnp/wo
X-Received: by 2002:a05:7300:e825:b0:2b7:38cf:c2fd with SMTP id 5a478bee46e88-2b7c87e1abfmr1540046eec.26.1769786138134;
        Fri, 30 Jan 2026 07:15:38 -0800 (PST)
X-Received: by 2002:a05:7300:e825:b0:2b7:38cf:c2fd with SMTP id 5a478bee46e88-2b7c87e1abfmr1540019eec.26.1769786137396;
        Fri, 30 Jan 2026 07:15:37 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9d7f95asm10252849c88.7.2026.01.30.07.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 07:15:36 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, Ziyi Guo <n7l8m4@u.northwestern.edu>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260123045822.2221549-1-n7l8m4@u.northwestern.edu>
References: <20260123045822.2221549-1-n7l8m4@u.northwestern.edu>
Subject: Re: [PATCH] wifi: ath10k: sdio: add missing lock protection in
 ath10k_sdio_fw_crashed_dump()
Message-Id: <176978613677.3951544.12305626465860433221.b4-ty@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 07:15:36 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: nuFiUAm0XZB3fsew1W29xOtAC-J-flgS
X-Authority-Analysis: v=2.4 cv=FPcWBuos c=1 sm=1 tr=0 ts=697ccb1b cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=GIVhQpxbiHrW4ch03kQA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: nuFiUAm0XZB3fsew1W29xOtAC-J-flgS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEyNSBTYWx0ZWRfXzaGrNsFxF+x3
 ANWnQppROMsawG9w7uj/TRaJ4WJAuNX+UEZ68P49qVDb9QgWx370dSsNcc68DtzwmPQWv810+Fo
 U8y0dyTeLgNdnsrKqfV1m9nz13YMFZIG0mNPUR6+3343dIsogWsyNCVzaAisrjeD81AIDFagIgu
 B1IMpBnnqQZXSvKgKW7Wf3RSTMAO/rAg4ACPcGka5mehVKeGeK3waWmx5eKqWfIDGEnVV1fPyUk
 cPBtIr8kt1fyNQ/Zi6vtAUUfYXfyX8cjMuQAwpR73zobcw8NcqB2I7/pd3lTQLLrWSEVlON5b3i
 lDXk6WHQ9Ri0Hxu9Gloj7mhXN4fVb+Xr0WTy/Jrx5R+zOxlNloKz8xNO0o04CirMZCNDXjE3qht
 BEhqH85Cc+5kjye/riZMP9d87GHVR5cMzc/CIWjB/MVIaG02rUqz2vjX3upUYl4OKkyYS4V93aZ
 JgKHH5aqqEALqQJM2cQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300125
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-31376-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7F3D1BBEF0
X-Rspamd-Action: no action


On Fri, 23 Jan 2026 04:58:22 +0000, Ziyi Guo wrote:
> ath10k_sdio_fw_crashed_dump() calls ath10k_coredump_new() which requires
> ar->dump_mutex to be held, as indicated by lockdep_assert_held() in that
> function. However, the SDIO implementation does not acquire this lock,
> unlike the PCI and SNOC implementations which properly hold the mutex.
> 
> Additionally, ar->stats.fw_crash_counter is documented as protected by
> ar->data_lock in core.h, but the SDIO implementation modifies it without
> holding this spinlock.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath10k: sdio: add missing lock protection in ath10k_sdio_fw_crashed_dump()
      commit: e55ac348089e579fc224569c7bd90340bf2439f9

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


