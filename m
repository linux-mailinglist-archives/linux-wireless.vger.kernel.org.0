Return-Path: <linux-wireless+bounces-32233-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AG9+HEq8oGnrmAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32233-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 22:34:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF4F1AFDB9
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 22:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57A5831898E0
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 21:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA1943CEC1;
	Thu, 26 Feb 2026 21:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="erm0YZ01";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MQRxgdEz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADEC44BC9D
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 21:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772141358; cv=none; b=X8Hm3wi5E+o/x88aEmSn8g96E9MHt704uecRxd7Q9uHB89SCl5mVneQDKF2lavNyOm64Ld/EpGbPBSosPYon9NToxqIMjH6s9VhQ4skZqwXgIOP0ocOPOZdjOxjidNqvapNLxKxe2XHOQKYzoGy0dx/CoQWMSIGt2vykhm0JhS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772141358; c=relaxed/simple;
	bh=PxPiOdXY2MUK32UJxSg3MC45/0DXYbjm6EZME5x1qM8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qn+Ey2rOAFQ+fBzFCvx8tAlnNdfioYDS/vN1z6fDQxMXtuaxoqwqVMuo3s/fCM+KkfcBwq5t5I6tl7eJN62E41yjMSt2dJR9ANYMpXoowpMGr0/TXsuY6c+alMdYg+KIeNuQ8se6dJSIc/LqSKw0nzAl2VMev8uzlTCGKZZ2r4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=erm0YZ01; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MQRxgdEz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QHEpjQ2608934
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 21:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AbiH/+nEZ4GgL26B6uU9cZ1E1UTj1EUd301+yE3peO0=; b=erm0YZ01hqsdVYM0
	2Vu8ygVxEYHyhKexdXSVF75Npzxa4vyPyVQ7y5d9y7vjAbrO/uVNAFfN+T4wY2wz
	Th8tCXnUgk4I9OwSpjjbudDzsR8bVHURN9eal9rOhVs1FqkgbLGF+1O3xZs9U9G9
	4Uqq5r2SJ1QtBvHJ1BnxnKBaybOjUQAzM5HOwMfHUxPakp22t50aL5KEHtoLLbWE
	IA2EB1fKP15igUjxc9X+OkNmauNlqdm7fZwJSHsit8/u/MHBucfZLVnjvuXotbts
	CT/1HzEylBWcPj5B5nnKliLvoKMNxrCxIUMN0CDhYBSlY9SyeyOTZRvs2HgyX7Wl
	ik6oIQ==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjt7y9332-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 21:29:17 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d4ee07e31dso34217970a34.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 13:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772141356; x=1772746156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AbiH/+nEZ4GgL26B6uU9cZ1E1UTj1EUd301+yE3peO0=;
        b=MQRxgdEzMn6RK+WDkmGc/oa9hq11K5pobH9eRAjbU2c5KFHrvFO4fbXsxm0i5r1esS
         Ux28CAjIJ5+NgyKLK4Gj1K0c0nScaWJRSnG2Ex3sShO2Y/sxenuMmWa5vlLMlGkXnIl1
         fzwMOht9828PKCGq8o0+SdV0V9XKgd9cTlEF0F8HrAzrvLXAUqxetVKeiL/Nlp2rc4R2
         9TqRGzwnvw1RMpNqF08+AlkX0XwZXkZZg61rPxV8a3H/dLEZ1gEGQk1QII9965ZO5KcM
         bGimX/ZO9S73Twj1WSb84lqn/3hPY6Ft+D9NuYqkoFnE2uE0vpaxPVrEsT0Ojwm6LWGz
         SW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772141356; x=1772746156;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AbiH/+nEZ4GgL26B6uU9cZ1E1UTj1EUd301+yE3peO0=;
        b=G3QNPRnqrBHn2qgTafvld0M8CL65r2A78oB3akrqQL+OOl3ha4fD5LsGpyGr09Q88m
         yy3YPliE5v1on8SQrh02Cg4vGICBiI5WQBmO9NXimRNBkD8QKmH47a3sLhYAfJh9ZpCh
         8C1bobZ442F4DYYnZ4vqYBgA6N0z2NOAGoPr1pQ5Gnp38oRkIgvnEL8Gi7Is06K7Af84
         C9CZDRQHukfoT7BdiX02i8S1tPIyunUK4OjkbONBZ3D/3717zmHt/4jo4HuT1qonrByo
         yTcS+QtgBnt9mFvMGI8x6fJAJUs5Wce1IaRcbUnjenC9AfhvgERnsYBBsOIanF0IH0cH
         Nb5A==
X-Forwarded-Encrypted: i=1; AJvYcCWt51yy2CqC7cWoBnPe/g13ovs0OiWgvJbp9wi9iymIu1Jkh79WayWlDZUwGbVnUVWQMmpnaEhATJhCtLqeeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9YTolvZtVrXBP+tib5nrjhH5ItaPJuAGOUaglrmvSkBMDy7eY
	oQ/IbJb5Rjo8NBumS+r4PcF2dxF+DKpb0jEGP5CZXjHnSBkRZsFOqU8vOcDxdV4XCh4FksUZwDX
	kgixdg45f4gnJFkkX6QmdYuabvHTBw5k3vWOq/mdOCc1GYJbPVFzEmcT5dybEdFsQVT3+ew==
X-Gm-Gg: ATEYQzxHodZ0elXwDEjdIAtsnM+jfIXbiD4SN2E8OmOuM/dBp3riWUHLlCFKoBcK8oV
	qJMPLekzcXb4wERACWL0FNRxf8VYRP1WIV/s8F7v7nAWUW6Vc/+EuwtpAHwUbPnMs89vPcNHDx6
	ZJ/VoXUsuKjGEe251EPraGF5gSW2JioydJoKtxw0xOiT/jRzHBoUD6+oOdjaMR4b9BON39DWA8Q
	04sBMFtBjHAd+xCuZMtYKJaLzpo6thLGNLQi5UzQHJbpfDgXGl5wKbr8A+ksFiLYoy0eTV0Q9/c
	8+NLyXkvHafcLBKLKxx21KGPBMFuSosC4oT3c9G+qd0ILYAumCSr1ww+oy7+/irbhwRNWWnetAO
	V85byAyxA104NaToskVrTadDGL6PoTWIKefLsNwAndjC6xVHYpo/0ufn9o2KHp4RFDb1I170QPL
	kV
X-Received: by 2002:a05:6830:4528:b0:7cb:1260:155f with SMTP id 46e09a7af769-7d58577615bmr1704004a34.16.1772141356528;
        Thu, 26 Feb 2026 13:29:16 -0800 (PST)
X-Received: by 2002:a05:6830:4528:b0:7cb:1260:155f with SMTP id 46e09a7af769-7d58577615bmr1703993a34.16.1772141356195;
        Thu, 26 Feb 2026 13:29:16 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d58666ed17sm2866703a34.27.2026.02.26.13.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 13:29:15 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: ath11k@lists.infradead.org, baochen.qiang@oss.qualcomm.com,
        jianhao.xu@seu.edu.cn, jjohnson@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
In-Reply-To: <20260130084451.110768-1-zilin@seu.edu.cn>
References: <20260130084451.110768-1-zilin@seu.edu.cn>
Subject: Re: [PATCH v3] wifi: ath11k: fix memory leaks in beacon template
 setup
Message-Id: <177214135501.1298720.7382906918512740944.b4-ty@oss.qualcomm.com>
Date: Thu, 26 Feb 2026 13:29:15 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: 7nRV-hnQ_rWMvabJ0Zx8m_GOMuvdL4kU
X-Authority-Analysis: v=2.4 cv=N7Mk1m9B c=1 sm=1 tr=0 ts=69a0bb2d cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=ej5cekVlhNKtRaV27UwA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-GUID: 7nRV-hnQ_rWMvabJ0Zx8m_GOMuvdL4kU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE5NiBTYWx0ZWRfX8IWogU5WzqNI
 qrpuYXvZBmIR+AWAS8ZtHeVqu+sr52x5eYE04gl1En+aa1euextRi7hkjZTII8SrncEhBWFYFpw
 aBkD5Qx38B2XlX1uYlivX8Jx/L3VZAEoaATI7p7FgF8tnTRqJ4eMXaOjdZ9amvCUpUAuw0T062L
 OkTXqk1t/k0cFWylwnotg7H/fab4XjIhcltpz3Lt81SHe8hzMHcoobS6bVoIlyQgEd5StPKZV7d
 o2I8FWV5mbl5Kj6Fk5TB0M8IbdRXHMz0/LB7rACgfXZbo3TR0onSmS5pSu7+DeyJWFCZEaEfT9W
 3b7y7Uz8VZ2covy4RAFfEwZgRGJEe4I4PUxu/RUVGImo9Q2Dg2FyVqbfpSImH/FXtu1GvXxQOpR
 FcQ24cSpcZspfOu3v+U9XStWvA0i1y1cgVkTJdn6T5hkhQjOyhsQb+6qQzxbdCrwF+fkFFd1a48
 4vVP65DAS5BfVyU3oeg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_03,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 suspectscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260196
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32233-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CBF4F1AFDB9
X-Rspamd-Action: no action


On Fri, 30 Jan 2026 08:44:51 +0000, Zilin Guan wrote:
> The functions ath11k_mac_setup_bcn_tmpl_ema() and
> ath11k_mac_setup_bcn_tmpl_mbssid() allocate memory for beacon templates
> but fail to free it when parameter setup returns an error.
> 
> Since beacon templates must be released during normal execution, they
> must also be released in the error handling paths to prevent memory
> leaks.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: fix memory leaks in beacon template setup
      commit: ff49eba595df500e4ddccc593088c8a4ab5f2c27

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


