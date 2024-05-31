Return-Path: <linux-wireless+bounces-8341-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 633D78D5B65
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 09:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 175B228283C
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 07:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9216381726;
	Fri, 31 May 2024 07:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qzWENORo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sonic315-22.consmr.mail.ne1.yahoo.com (sonic315-22.consmr.mail.ne1.yahoo.com [66.163.190.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A4080C07
	for <linux-wireless@vger.kernel.org>; Fri, 31 May 2024 07:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717140423; cv=none; b=al3U0YfUyZCN4LNFuGLUxm1qF+ajrC1IZ5LyoL5fRHUHJR7VrsNeR3nKtA+GXXjTNMDJgz3HznwPGQbxOlx33TOF57NBB2h8dK/p1z07wMQV74k3IEo3EmEzFz5hDFmCE0SmCpl/5jhoHD61Gj75UkWOkcyAzXuGoBsPr2bmv+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717140423; c=relaxed/simple;
	bh=HkvXnmN6TdKz1BjNXnZsNQt59qUPLMY2AD3D7PP0DeA=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type:
	 References; b=rMdeF6vbjlSgW7QCzbYnDuhqPG3gNCioXv103gM3fGeu90HZZqbZZvUkKCaBz3CeJhh55yCL0cJCWPABoW5HAFn5+PPr4rh+RupurSmhL9RY1lHyV8GxWS9yajbEofrK+ALZvBVtbfFnQBzN1/RgBYg3qvrss3fb6KY1FvBntfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=qzWENORo; arc=none smtp.client-ip=66.163.190.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1717140420; bh=HkvXnmN6TdKz1BjNXnZsNQt59qUPLMY2AD3D7PP0DeA=; h=Date:From:To:Subject:References:From:Subject:Reply-To; b=qzWENORoYaGZy8hcxhrJ1BQhoW2WeXhEq0ALLcrlCoUNQL7untfVVh19NHiGQ54W0WCkKQGOyaA/7HSajHBs6MUPrq9MKSJYaOevHhSUS4s1g5GMcl7tS6GYu8jBxGesThTeIymUHJAupL6VV1Bx9Kmct/00vFCrkgORkCs+CmqZVpz0+2IGlWMDi9f/JtnpjSC5FK5fOfPwnoGa+Jjkg0NlQQglLs72dWG+WNbmfQyxYzotdqeKQ/MqivscOE0CJyuK03IslznOq11e9RXmrBya0evw9uQIdJGSVdO5aHeCLUIfhq93ldCVzyCBpIrvPOPoDvnKjsntGIG/SHi8zg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1717140420; bh=OnfOJriPGInSYPYdfWAQRBYw+gQI2tgHQMVlkZA7gBV=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=UgyTslfwz+jK9iLagj2RVAl+GevGwOqoHxxLhixfNtROZ1185FiceRbwKx+/8un3p7jKRZdMUVKPdaaMHVlpxb87kP77caH6U8e2JzbaaszmX2X4V2Tdzv/6uu7kF6ixpIZ3o23Z3D2eooK5H6WD+DILJIpcZa/WxnijrPxrPai6KYsZ/INWcnXv/mO2grPCfcb7HC94G78nM/MOBubZa9z98B1m1lQaJlXK/5o6m9Q+EyoIVT686QCjD+2e3T91Z60IWXG/Oogte8xV1idVTvLDQcdzVQoMxn1TfyoL8p8PNJgh/FcbecyajVAdRQkcH3UJLQNC8j7LfnABO+puCQ==
X-YMail-OSG: 9_92mvAVM1mAVSeYRtna81N33Ce8JQnUvNW9eqWhd1Cyly1eFLbckCy9.8FB1i3
 dSFlPh7tbtN26E8wqD8_BEJp1FsOW.ufFvTur9XG89P5VN5w9U9qyZXhe65iO7u7aEO.sRsccVqu
 NltrAxCKNRzb_q1J7fJJHNV4NrwpSZf7ZPnahm6..AJw0VnPdR1xwh8wBFCPEQuSTzz7WcYZp.4k
 yJ8fMoe8w_gGGF6eSQL0_cPRXe9fDRLEJV_y5LUkfvG794cU6jtb3E5kiU17lzQKJ9wOhhArZ2_S
 wR8n1rn2sicEYv.rLtVseIv2sXLN9tL04SeBuWJkdawzuM1rt2V6cTsMstpP8t0sn5SKmvwr7Qh2
 AGwG4ZOPcnam36X4znaS1Hk7tMUDDgDdpbTzuNDRaOrFs97LzchzC96dzmnQZV0GiQHftfX1YUZM
 VNq0pKStA4152P7RoMUf6HLWneY8ST4V.bpBi9pqnivIQ2_UAJmsTf4RSf7PAGWQ_leKZC_C0pjv
 obTiD.WQHPDeCtrGYEuifw8aW3qMRe2hoA2S508XoAbgPzqv_qn__zHZ.FlwuXo.CgPU0mweiKou
 pSCWOR5pmjCc6mw91KF8WAtcHbI5mFyOOtQCakWFvm7p5J_r3xqYXnpXc8yyJ_4BXEr4cLlxC9l1
 3S3mOjV6hZdKGJx4KClsRFMwdMZBAW86J1AlnZ0v2GHzp6r.mG6IbdpE3LzirY65yAMdkVFRikAr
 3JsUut4UxbvoqOBBhNPmMRYf7JVrTC0rW4UG75JpT_C9L6tgSUczfA0OTbbUkCWTgx376McbiJSe
 sKtM2Y8qZUUpfdXE37Ovggnvec_N66tcEGntTmsdDPPbV66GFhwFaSUnWYw3ANU27dzU4MbOTaIp
 1yrcZiUbIvzsFMjd5vH6q_OQhN8c3tgCv9pepGklfmDAzn_wn5J3t07qXCYaznxF8FVtuk0.DbOD
 Qce9DusjUWKL.IK3jmv8Q7oxGGIkXYZzl0ayBjg0YLZxkNi9ytmlK.gJwnVowarar7K8_AXzsdCb
 v97d5b4bO3y9ZGVnnVnTD19VzuHULrGPoqdq1Ze3OuATHLasLH.iK_.dGSVpQKHznjGBrFfL7gR2
 Zj8mXZr6yianyKoj.Fx3GUGfMpIPeWqTwzh5QZh6aJtB30FXLVZWRj3JY4CQqMAZZX8cIr3RV_KT
 kPzRvlH3Nj_gCwdMsgbgxRvKTq20giMMKQ2KyGcVhvc5MYMIkGdmCzagvV4pSy4qKCoAWsz4ZO0t
 MVEHFnL2TEqe5hmBL1iLRC2x4BhlEwVtOdEhN7eVRZw8qcr6L6vlVwjr5f_G.1WwtEvPYp89C2cw
 QSCTWidmF903sfVQlFhPAEDb1xy0J9lL23lp6TRK35_PNM2aRmrCTddG59QXpmKhTr3oKM3yGJTY
 qwqeC9p.IwVhi_5UgmCxLoh4iBnFevSVR7nYXO8J9WorfQ_i7daIONNCwn4fc1ah8K1_CtkwrofH
 vq2u7Spn4rfp1SHN2S4zvAOCubUSEitWyui9Vfd3j2qGkWcL8aN.JutzbSJkOlEfDEO4rEnkedNV
 tvja2D3fl3TkT.XLTeDIu_jvz72CUjvjgEuG0QLIXLAhq2TTHDm1A6t9vHDJy88oGhBXcGEzodFC
 FPesmUXFjEftT4gqJKQfmzidFzMZEU2lfV0XSRDIRNOLemq2wJYe7lQgtghNOv.QdlqKozXwke8K
 B.wxtqDL4rg0MtMm85qqRdsj8O8lJTwkMf4.uE6I3PZsATG6iocEdwzN7N3c3bw8BAAJKItMqGic
 Y1FZ7OVreCE.fZZu7U6NXmsZDFswOuJzS_mJVCMUfmw.h.oeJ6mSDcCnBooKIjvxAQqz4ZXUxw3Z
 9Dj4tQDZ3SF3y.8kIReXyD9fWN4czFx4dfxjzmkMDL5fb0JNF0Yer8hgS7hNTFvAMbosMYv9gYth
 KbVMD5DvIc5ySIqhDfvMIFXfBgBsEj6DvTbZRhvo1Upv_bFa_HeTE9q4B.jS09IZ6RbP.7lnChc3
 X4n7tFFHtQZqSnYiB7ENQB9ZdjASVOs.dzESpZbo2NTdHqHITtwat.nn8kfGd9i3NKpv4iIYMdjF
 QtRIF9YTLxpmxoZ6PY_kwfcGRGEgpDAUPcJ7dbvk_h1ub82uS1HCYbOnii_KkwheCVH7TN1l08QF
 6itzWUbpmXdvHgowdrzw4lhNKjMbrimpuT2dDosSTUFGs5e.KLZFpxOIIDroG.WyiTFRByH3J7ZI
 -
X-Sonic-MF: <mh3marefat@yahoo.com>
X-Sonic-ID: 5a996117-7449-4b89-9c15-6eb33b7fa55f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Fri, 31 May 2024 07:27:00 +0000
Date: Fri, 31 May 2024 07:26:56 +0000 (UTC)
From: Mohammad Hosain <mh3marefat@yahoo.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Message-ID: <127632694.119769.1717140416159@mail.yahoo.com>
Subject: Bug report: AM5 big performance reduction if BIOS Wi-Fi disabled
 and CSM mode enabled
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <127632694.119769.1717140416159.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.22407 YMailNorrin

Hello
Forgive me if this is not the right place to report bugs. I first reported this to stable@vger.kernel.org but they said I should report this to Wi-Fi mailing list...

There is a big performance bug (affecting only gaming performance) on Linux with AM5 boards (at least for my MSI MAG b650 Tomahawk) if these BIOS settings are both applied:

CSM -> Enabled
Wi-Fi -> Disabled (or set to Bluetooth only)

This does not happen even on Win 7 and does not happen if UEFI mode is chosen. Also does not happen if Wi-Fi is disabled through OS and not through BIOS. I've tested with many different BIOS versions all showing the same result.

I have tried troubleshooting with MSI with some benchmarks posted (https://forum-en.msi.com/index.php?threads/b650-tomahawk-bios-bug-disabling-wi-fi-massively-reduces-system-performance.396910/) and after a week we realized this only happens on Linux (tested on Arch/Fedora/Ubuntu with 6.9, 6.8 and 6.5 kernels respectively).

