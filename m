Return-Path: <linux-wireless+bounces-32660-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BEeFNdEq2nJbgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32660-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 22:19:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 754C4227E2F
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 22:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0783304B397
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 21:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA1033F8CE;
	Fri,  6 Mar 2026 21:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RYT0VOrV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iqXRio6Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540F732B981
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 21:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772831941; cv=none; b=YZIkVSFxfN/ZExfxSQbSUV3EoiMlFqzz5CG/fizoa/xSM6OdCboZEWjy4eaKc/v4U1/NU3I58lymCnoEawwIEljHLCp+KSg98W7QO7V3mVGG3Rd99PsnD/tWQHLVLCx4W1lvAuPwmae6o9ywyfKNVeS29KQ85ESowkHU9m+07ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772831941; c=relaxed/simple;
	bh=v/tXboH719HpqOqBuidL/9JJLJM4lPDwVc7s7dG13os=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hqUNqR+vs/cQJF9Ebvbta9VCyjOr7yh6km2rg/HRSvTn2x5LI+4rOh/QGDoWtMATHD2ZenIGU8vgE5g8VZvnw55oqaPftgLMzhN77Kjk0ovtE5TKgRS/+ni9rVpDx5ipHjJJF0wt4/r6VBQIgkeguB6CpH/gcvJXJLau/JhvE0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RYT0VOrV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iqXRio6Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626KWwdJ1176856
	for <linux-wireless@vger.kernel.org>; Fri, 6 Mar 2026 21:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YvMIy0dvO3HJeWXw/pV3WkTF3T5ZwMQ1VTTV7Em5SVk=; b=RYT0VOrVcKkIyORB
	slYQrdljV+LPg0SXdfZV7oOwEwrGfPAWc1c1G57QQrezo456GAKNfHFLWdYjzzY7
	Nkrc+Ar69ojWPe2lVVIjyG7MbgJL8dQXTAb59no8O6aYtxaVuemHoTiUj/JdOjcT
	oNQfcf5IF+2yuFq/vrEAqduVIp4nmKGYpTE4lb8FfMmfi+XpJ2711Up3tqvbyCMa
	LMxIL92jrTDXGQAoOzL+2vYOuBOUS6kbgjxEXGm22RWEHXc2KA01yK/EWZmhHubn
	n8MLlKiKOWGcowxLnTybXMTfBv2wbuLkKWuVolH4/7DLDUzji4g9AkXeesRMaWHe
	fss6iw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqrukb1dj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 21:18:59 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2be21f89332so4726792eec.0
        for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 13:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772831938; x=1773436738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvMIy0dvO3HJeWXw/pV3WkTF3T5ZwMQ1VTTV7Em5SVk=;
        b=iqXRio6QQJZ61ro3egH0GVsgCOjt/WDWAOoX8wqg5TQYEqZtgGQU5ju38iRVlfD8VV
         ixw8I1iX7Gsq0OO+JWneqWbf4LgqstijKaduOpMLqC6x2ie6UfewFv4EmUZqqpg4pWXW
         VKMcpRY/vh/6Z3g7SzchX/+XE0o8LUjse6UqQj3a62SvSIo9zEQN8gUjPlVIzihAUmcj
         dqk7mN8KRPXnunB9pgHizQKm8CO+98ZXhL3uMydvp6Edc1iMzrNZ4M0JIXfRbAksJcjy
         042RrjEGqIU+P9qFCgZqaQQZU7kUcyj2Z02ezpUzuccoETBlhX2bynWHGivXM98Mbxzq
         l9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772831938; x=1773436738;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YvMIy0dvO3HJeWXw/pV3WkTF3T5ZwMQ1VTTV7Em5SVk=;
        b=VMxx3lOZLsLTH3IGVRTqPHSGKlnH8AKuM32qmsJDC1fJqF3tvADFhUf7AFR29J+2Qx
         zBfp5XcsCKNV0Afmk6CO6F8di+zTG2ghtCOhAcTSCT0JzHTMj/vGDxtJOpNX8A0V9eqW
         qsJaxQqOxDm0W7YbvKWq+MZJqoTeMXgkVPY8czWOzpfx8TB+g270UQgOTxNSLhVvwhOG
         NkI9Q16ugA3wFnODqTvED4PsFblHkOkalXmknbxkNpSQzSRTbYFZGKjS6FXJUlTsESRa
         d+UrUyO8tMR8H2PFnxvc1QTSUHnaLlQftNZt4XU/GGww4gU8w7SeJ0jQPSQR/p3YzNRL
         ax7w==
X-Gm-Message-State: AOJu0Yyll5zx9geRrs8HLU0ZdIIDFDgsu+AM8PkvEz01x3NsrNEI2XqR
	OI7U3Nr5jCzU7F8fWHjUZtHBtH0N0xNMEkDu0bGqIOuxL3ThMkRBuCZTggAXEMiO3InBJuF6f/3
	b3IXXkcY5aDkRro4dpAS862K+P+7UL5rcn6Xhaa/U4zdKmFoxSXTr4GeRv1eOqUxuAuflT0Pd3s
	YoTQ==
X-Gm-Gg: ATEYQzyyU1rYYjKKlJbfT926f/lif7QU9XpD7tasw1HGOTdzZr3F85kMvlI2s7Ae4j7
	/Kjxznfzus693Vu0rPZhxMx+QjPcteAa1F9lk26JGp84pBKuUcyuk3YFMydZ5j4WaulJca65l3t
	Z29ktfV43tCvmUQUoDE0U/M/ZrwajomXgIv3e7UcovWexoBtXfbUKzeBGhjadJ6H0HR5Ms4NQGm
	jB4b9Cp3goxzsP5E+Slw2mcPDsQ0r9nRipQBEHhcufZCZVAAk40qYFQuciFxxZwDPG8HE4f/rbx
	7nhtQ2ucgZKdPN4K0cOpaybDhStfLpDwB254IZu59DZdx8aLoYsXNhIcU+UTbrMyr3E1Gy1ypWL
	ySlk79oN2f0Ba/olhAjvgtj9zIPD47cHlGQqBGeEemxDzp8K3DKZQ1oRGxfv1cuZA2t8SdIY59M
	2F
X-Received: by 2002:a05:7300:6c28:b0:2be:8da:321c with SMTP id 5a478bee46e88-2be4dfd08c8mr1229524eec.2.1772831937848;
        Fri, 06 Mar 2026 13:18:57 -0800 (PST)
X-Received: by 2002:a05:7300:6c28:b0:2be:8da:321c with SMTP id 5a478bee46e88-2be4dfd08c8mr1229510eec.2.1772831937259;
        Fri, 06 Mar 2026 13:18:57 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f948324sm2325124eec.17.2026.03.06.13.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 13:18:56 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, P Praneesh <praneesh.p@oss.qualcomm.com>
In-Reply-To: <20260209054924.2713072-1-thiraviyam.mariyappan@oss.qualcomm.com>
References: <20260209054924.2713072-1-thiraviyam.mariyappan@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix legacy rate mapping for
 monitor mode capture
Message-Id: <177283193653.1373939.8377720073455537723.b4-ty@oss.qualcomm.com>
Date: Fri, 06 Mar 2026 13:18:56 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE5OSBTYWx0ZWRfX9ru4hncu6JyV
 HSeThB9YPBhsRDiKwbLON+og5hzn/w+Otuj+nkGAv+Ekm7rG49Ac1xMZPVUyqznQoa+UqXQ427n
 ICGiwUSSUpzlPGmIiJewHcMf8VzwmcT7kD9HeX2sIjMNGgF+6Ra/a7sb4O0AayJDa6ZBEgLQ4tD
 v52E0Juc9elELilB4us6RzxXcoM+jPERy7Ba1bQXk4WRbSVTHt4j1+hjBTJpFTR1IaAsN5PpRuS
 mGEIh1MwCyQDGdqFgGjI1QYD08gyw3g1PK9Z68rXO84rJeb6S0XSOaX+AyBhUx6L6nZP839i/U3
 sIelgpuHlgmJCY5xirrJasOvAxWMcf/o2N7h/DhRBz3bkLxBrz2zjRjy34jJQYU/wQypLnsvqJU
 PWHZGsja5a1WjneV844YT85Dg5fUIrztts48M8ROTx2j8IwLHc2cyQu87vEOLbtZWHIClMD8Yfg
 yH5Cpus5brp/5FhdFKg==
X-Proofpoint-ORIG-GUID: M39ltBULKfwzOz0yr5CZQJ1TkXSNbr5u
X-Authority-Analysis: v=2.4 cv=DvZbOW/+ c=1 sm=1 tr=0 ts=69ab44c3 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=k7F-nlr3SNkpLXcf3wgA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: M39ltBULKfwzOz0yr5CZQJ1TkXSNbr5u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060199
X-Rspamd-Queue-Id: 754C4227E2F
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
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32660-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.959];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On Mon, 09 Feb 2026 11:19:24 +0530, Thiraviyam Mariyappan wrote:
> The current implementation incorrectly reports legacy CCK and OFDM rates
> in monitor mode radiotap headers. The rate field displays wrong values,
> for example showing 11 Mbps when the actual rate is 1 Mbps. This occurs
> because the HAL layer uses a unified enum for both CCK and OFDM rates
> without distinguishing between long/short preamble variants and proper
> rate mapping to hardware rate indices.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Fix legacy rate mapping for monitor mode capture
      commit: 616217a989e09c55398db8555e5ef0c64504cb66

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


