Return-Path: <linux-wireless+bounces-30750-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB68D19F24
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 16:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6AED1304EFE2
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 15:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02E1392C22;
	Tue, 13 Jan 2026 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oBKv15so";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DSe/xl6C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779E6392B88
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318170; cv=none; b=gRH9IbfkC/cxFrbeGR4y/VNDIaVcb3AYMYPEvkAZLx1KuYgopTNV+tfpT7qTpB/S71nbD+5ShAmhmtOW6JmZPYOjONPvU4GrE9nb/GPgTdjwf0uSic2MhQssWamrqf7D2JeDaFhgaeYnmrwi0IXvBM7UAqugTw8IA8lCvZnTTD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318170; c=relaxed/simple;
	bh=oHuFIhzZZA5m08bU0aVGjUkCxpxlXeWu+x+LCSjhwVY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=S9gcstX7xrgsBA39RHZjA4a4zMsb+LW+Lk8isE4oduVnv5feFOOgq8r1aatfbhDoQAM0BuDuQUYYJqa/tZqE4gdhNNmgJJPM4DpkDy5rvLFVvyqAjG4S6HOaxyEm3sEvzq+cYS9lUJRUW3Ms0W+yTi7tokSOUft6tcWutTCMx90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oBKv15so; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DSe/xl6C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D88Zwl3299970
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 15:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I1YQEJELDgeOBsHf66sb+8lv6+PjEG4gBBzPY5MD9nE=; b=oBKv15so9AWLrpvK
	mWXHidOyFsD9vCaintLpaaECgveVS0oMPzvayi1G5hNODOe4beq9nyrLTEp1hVWx
	4taCJK55v1tpNmmc8hrGjpR9PZXf4tHKDoQwLHfZBdyXgvpD0s/C8zESdfkVroKn
	S8QvkFFIpqlb9LbhAxXPFQjyyOzD6i2vO5CpPjULNI23oQv2TEI4H54S7qbedviL
	aQp6YmAhMN28CwE2foU3PAEd9S0m7LISNsA8tDr+V+BzFMYTkQ2tyKK2qczpTSMo
	Al/hsDWoIfuvrGK6VJd3ug3tz/Ojt8VYI4dhA7BPleSl8GQvq/E7DQqTim2nhPDC
	v02m3w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bn6jmba6j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 15:29:28 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2ae6ef97ac5so28273983eec.1
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 07:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768318167; x=1768922967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1YQEJELDgeOBsHf66sb+8lv6+PjEG4gBBzPY5MD9nE=;
        b=DSe/xl6C4NrIONY8TlLWOjrErWYG50EuGjqYAbBaLrhxmeJgni2KFmIq7AXemFqdQ1
         u6YnSNB4agGbMP2lSrxFTt/HGJY2lYWsEx4+prDvi6Bublk0r7tjCDd5T99Hqx7QDSQC
         U0JScNEDEsewBNCLtt5g4xStOyPjjaMITL20YLbAprI6HCAlk4ZaUERa0aExEJFMcrHn
         RjHpdEnxyOXToX/goz1j8GC4mc05Ixuhw5K5nI5haCInZ7QxX1yJbPJQVR2uKLUxUNkE
         ozcL3792yBnNM6UdxsyFwfO3vIfobQXs9bIye+RFgqEe6KjuZIr9STrz0YocObMGvtOa
         6bHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768318167; x=1768922967;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I1YQEJELDgeOBsHf66sb+8lv6+PjEG4gBBzPY5MD9nE=;
        b=rAmoSNU3QTxR7Z2ahLTQOwj0izmeB8c/uBFlBCX/DimQvEOJdiOL7rj0p1qr8pJkwD
         dB2C26smyt4CCQEjvRQ5LFTSo93y0ELVXSmxJ2W/8CViFiIDqzgbmiMKog8ghMSKOZ4r
         PjMvLJGbAg2f6MOu/BEL9Rz0sXe9v02GHDHr4eEzQ6ygOuXFb6NOxdVIG6X3MelXgbP4
         6iGE4nncFGsqeMGoDq6ll3hvlb0hu1kqbqDf847H1KqQh/3EUScLCSsFk6a1oK40iAxs
         /QAXvV0Acw7xYCOZjFRCpCjrzB1EFz5t+VOrvKzjL7E5wIA8lcXagICtDUZjzp4LabnW
         pCvw==
X-Gm-Message-State: AOJu0YyMkMSLEqJlpaYIti326FWzS4IFf5wzqM/su/CFelJ0vv/Hzdpp
	b/4Zw2k2cAeZ5QXMHSADvGEdt8sPPhglMIxwws2XhQa0pxolIjR5rkYtM7MyOFuVpthDJk7lBUb
	KMG8GUP7fsZP9VdwahyXkY4BlGZEsTVKmp+DyqJ2D7qVupYipfRpsucsMl3+ICq3inqF8/vpnKR
	yxfQ==
X-Gm-Gg: AY/fxX7wY2uAKD33v8OQ4M5/QvTG8MYkq4qnMBq/1aygLAi86Y90KOWQ7ocw/riWIP5
	NAoI5EHxompABsjBIrjdbAR/YDY9XPqYvJTjghxNIK7Wwa/J8d+Mz/LlRaAsO4tyjYYPYiK12IV
	U1PIcubcFMpVsjYdw9rYcr8U/sk7XioiIk1P1zd+0B6r+byqZ7j2ZDx/j2EQ39Bs0XMylYNhOBo
	iLk3A/H+n1xOqytrUuoejodJkMIk2pHO8rr89qwufAYFR6wEf4k4lT1OdO3r+TGpzoDMqn+d2W9
	yvAOvWghmLg/Pn62teI+dmy/NLZM7us3L1zl4ESb4A9nYRuxtwj+38hDZ0uZdWXbKUUgYE1Sl9q
	XK8LM54cD36XcELJ84UBw5HWLtaSr17UBsxX3iNXIh5i0eFVWlv9lAu0FOen9v+6i
X-Received: by 2002:a05:7300:f643:b0:2b0:4902:c0a3 with SMTP id 5a478bee46e88-2b17d2ed8ffmr14028262eec.20.1768318167367;
        Tue, 13 Jan 2026 07:29:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVgPAch4NqipoiWzw/8q3/FOsYxrzLxAILtvq7D2Z7aaan+UTMDZb2Vw/l9cxX7jf50Y/06Q==
X-Received: by 2002:a05:7300:f643:b0:2b0:4902:c0a3 with SMTP id 5a478bee46e88-2b17d2ed8ffmr14028242eec.20.1768318166830;
        Tue, 13 Jan 2026 07:29:26 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1707d76aasm16858049eec.33.2026.01.13.07.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 07:29:26 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Yingying Tang <yingying.tang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, yintang@qti.qualcomm.com
In-Reply-To: <20260112115516.2144219-1-yingying.tang@oss.qualcomm.com>
References: <20260112115516.2144219-1-yingying.tang@oss.qualcomm.com>
Subject: Re: [PATCH ath-current] wifi: ath12k: Fix scan state stuck in
 ABORTING after cancel_remain_on_channel
Message-Id: <176831816625.3453943.16186403876839211866.b4-ty@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 07:29:26 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: 4Ssm-VNSPWBQQ52cjHFLVGZNH_HsT7NL
X-Authority-Analysis: v=2.4 cv=SK1PlevH c=1 sm=1 tr=0 ts=696664d8 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KdEc0S3GmNI-KGd16cMA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: 4Ssm-VNSPWBQQ52cjHFLVGZNH_HsT7NL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDEyOSBTYWx0ZWRfX2LeeWt1bDCqa
 MNgs2RZBeTqwumzDJ0XcPpsg7jZ+b+LzDG7eGZoyLQJPUo+2AIlFK1Dxa5QUy27DzJDWLG5Aywi
 kq14erfWxhG29EMDXKMPnnckk6TxhTn1nKO1OfasTqVZkaxFj/PS38ISBr+U+X1UqDC/vLWUnag
 O4DQ+s5dozaRHnn2LRZry0z8cUjQzbVPer0x//NtE1vGjAal1n0pioF3kGnMcnbrTzAikRkymHo
 JC7o8hKSjLh6DlHdL9CZY0GOHtZXDh2sDI/qcKohyNQ8+GDt+zTli8EsODyHnSfk7oc+3w7R+HT
 fi/kRvwWWzEUa/FwtZ3NPxwysxTL2VceDfSDksHDyBgKYeWfXv9FnezAd2FpbZd80q39wEEDTsw
 jxl+iXVuo970/ppPWuA1dnjorIYR0CamC1PQLkNZFG8uNrO9LpU39jX6wKBrCjAgZ8DMUPav6FN
 xqUb/5L1WUUN9GA11HQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601130129


On Mon, 12 Jan 2026 19:55:16 +0800, Yingying Tang wrote:
> Scan finish workqueue was introduced in __ath12k_mac_scan_finish() by [1].
> 
> During ath12k_mac_op_cancel_remain_on_channel(), scan state is set to
> ABORTING and should be reset to IDLE in the queued work. However,
> wiphy_work_cancel() is called before exiting
> ath12k_mac_op_cancel_remain_on_channel(), which prevents the work
> from running and leaves the state in ABORTING. This blocks all
> subsequent scan requests.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Fix scan state stuck in ABORTING after cancel_remain_on_channel
      commit: 8b8d6ee53dfdee61b0beff66afe3f712456e707a

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


