Return-Path: <linux-wireless+bounces-35729-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHBrMtrK82mL7AEAu9opvQ
	(envelope-from <linux-wireless+bounces-35729-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 23:34:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 497664A8403
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 23:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 166653081A1B
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 21:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389B23C6A51;
	Thu, 30 Apr 2026 21:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kKwkiZEK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gsPpI1bb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92473A4F2C
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777584651; cv=none; b=Db3zbiRh4Ee591i4XkemARUf8s9HSA3U72GH4wGDmHEX5TNmfKeovF65KmLAMthGlyuwN/KJED0JGovMEcs2LudtCdJ+7zkfBx3ju/ChzB6NYDoSI3ikLzfYXfPHjhxZRfa/flgrZ5cTQ/zuS6NJGm1EGiA4oAkEtoGF8rgqLac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777584651; c=relaxed/simple;
	bh=/pApNrI313opcCNwIVW3kri77G2TnadQlj5I7MaPn+0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dkGLMFKQoz0AhcUz7gZQbCDY4pY1d9D1NKAMXReL9nprKQw6u9OhtX3csOk5LBEyfg6ukzU2axyPgYzabIB2Ph1G1ExM8J636i+/sYoj0jCLH/xViLyL/Bgf+COqbSSzpXPBSBx4lP7rFK2RB62zySB4zDkqNDxAziLCsaKRND8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kKwkiZEK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gsPpI1bb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UHfEBW440695
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7ORbwj1deeV9w7+GF7fhmUVzGC2pR+Jjv+JopQhPjcs=; b=kKwkiZEKvwM7Fm0C
	GYBkEu+VLUWSTWy/8hbRaIhk0M9p9i3OG5XvQBKSIUhSF5t3l5ESPRmIiScdUVZc
	R46F1jY6TaQtVn0RkMjreRJGf/zaNIk9+njZYxeoeD7Ak2cQ/I4gPt5ARnvInVpl
	wt+FnwEwOaHSkcyEjNxvJM3R8LKQhWPfhipOirUJDuYqx5bterrj6cnWqavbRWuZ
	0GxWN5e7tfYWcwMtinUw3vG+uSfQTS272IEyYB8WfWQ0VFSjh2506CuHVYakf7yH
	chO9sLl/4KdwaT1SFgB2iVZ4SI1KHUvI2PY5z/0QzCh/HR5YgTDEHyanvxabNI7v
	N4gleA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dvbpw90et-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:30:49 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2bdf6fe90a9so2955069eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 14:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777584648; x=1778189448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ORbwj1deeV9w7+GF7fhmUVzGC2pR+Jjv+JopQhPjcs=;
        b=gsPpI1bbwmFC1jwmelzQP3Fg8lL2/GlSdxSdn9gYZ2frlxEO4gwdeQ7P17sfZqPTVl
         8mmtzQN7V/d9opZQ49ddAKOMjbbdo00DOw35ws2E5Is08QMm/ct+Ik5/8V3/xpoRtq74
         ibn0CkcXUqewyu32gh245/UcXcDS/8Ika5ssM1fwgE75lkAo7MlxSLtL7jhN0a4jePrr
         ETWumXrwGJnCqyewEQyZC2we/AxfyP7fUFjfyKHZduDqNnCAxq6eV5uaQgBZohFg1n2c
         EsuTH4nUfPB14deLkJ1t/xbLfWWieazFbPsVbzLvGXKezfHXeNCScLwUuu/63zGUKEKY
         26Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777584648; x=1778189448;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7ORbwj1deeV9w7+GF7fhmUVzGC2pR+Jjv+JopQhPjcs=;
        b=B5PtUZyJL77xKMGezkVDhDGkR1r+uACDIxsUSqqUwUmMSaxqzqqwNmtYg2DXoBqyNX
         KfCDwZeXXLrRPpFLN4MamahERJkEGKWldskdBQrpfoxDEw9EgJsxtvW9F+gPGIjqzlu6
         lehn7DJF6uZAWiswCnkP4id8OLq8Zll6TiB2z3V8xpRaiLZouFYIXsgu23gnPGBDTYq6
         ug5d0lLaDN978g7TGquJoiuObdVQoNtX541KIfJtlvb06zwWz3DXndhQumUE9WmvZ/0x
         2uRSP2ZWBS51tlr0Ly+rWVJzm8cfNvY9OnnjrPe4rSutMwyj5keNFTwdg3XTkVntyNje
         DBzQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ypZ8HVKMHiQ/U4cVO2Wai55BYONxhHQQMsIhIb0qpV8YKWVDZRk3FmtGeC720z9HHAzRAwyjEpnp0zzvcSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxctHTOnDn9cjMoFhcGuY8DtUbzHKrkwHNtxg36hKVtTWpkcnx7
	IB3VIcEXx6Tb/MDxUjgHNqnB3FRv3okkg3F7e8kDXXZXfBYXWryHyjRhy2KWFp9mgziECSWDLs/
	W3R3cQkdJtUkjebn47TerEPGSgD2pj9lPi8/j30O6J2gEx3rYapn6vIcqbzHVSSUQEUA6jg==
X-Gm-Gg: AeBDietUxiUKF9Eev9098KYOAmyJXJVX4iYj/WFpMoyTTrCOy8TAxMzuuMBGf8BcJ4G
	rjR9IEeU1SzQARR0T2dKgGtwA9vA1Q/Sarihcqbo1f8so6KsPgLmjjmz5xGgDH/Ar6JEawnAnjd
	EYj+KiYUokDroer5+U6hoE77ogV8mc7OWu8iOf+Cf6RLD236lTvOsooIaylgWeIURdqfU+Yhn82
	lCFBhXOO7cpu7qk8rwpvqWdaa+wI44GAfMj7DYbLZCAJne8EcepSkLmamUo+LJzLVX8cQCY4nFp
	XY9ShZ9k32+dY+Ogi536lQVlHKm5+z5On1hnIU8TK2r6AZ1hX+peLDX0GPT6ymPRRjKjZzgPNcc
	Gxwk376tF/wL+QT5Q/ORlcXJCxc+D5Al9S/9CmSVsABDhkSD/JZsmxenKu0QQpScB5lngeDtbu0
	jf8I586YqDsHM=
X-Received: by 2002:a05:7301:168f:b0:2d9:cfa6:3d34 with SMTP id 5a478bee46e88-2ed3e9749d9mr2269192eec.23.1777584648402;
        Thu, 30 Apr 2026 14:30:48 -0700 (PDT)
X-Received: by 2002:a05:7301:168f:b0:2d9:cfa6:3d34 with SMTP id 5a478bee46e88-2ed3e9749d9mr2269158eec.23.1777584647794;
        Thu, 30 Apr 2026 14:30:47 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38d79eb9sm2504861eec.8.2026.04.30.14.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:30:47 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
        ath12k@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: =Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org
In-Reply-To: <20260427070040.17928-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260427070040.17928-2-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH] wifi: ath: Unify user-visible "Qualcomm" name
Message-Id: <177758464704.1848985.17511825714813027637.b4-ty@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 14:30:47 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=dozrzVg4 c=1 sm=1 tr=0 ts=69f3ca09 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=haabeQbpXhb7lDqDI2kA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIyMiBTYWx0ZWRfXyVHo3skJSYTi
 cAvUI0i34OweEJtMdS40W8QT04xonsBPpjJRLNM3HlCKNupLThMM+M3EQLPnF+m2JM0zOwK8/Yh
 4bo1EedUg9REWj/lqvwC+mqbNnK0dRtlFeXEr6P4roiSkyKkNKcvI9Jhfhc0PPeyQ7sHR39KFVw
 5T4IKxI9KSs/8pR01J2LzO2QfEB0n8M0O0DaGztmDCx48H+INXRxaE+xE5qhpmG6BFCfhNDiUDm
 oFfdlMkFsEGNhcCWZf3Gw6ZRTqyRhdn8Itwg5MEukQRvg5Qof7/mUf2/kB7YokbJtgEzcgNftad
 5rmtFXFTuGf9NE+HTXou5WFCa/I/t3mucjKZJQDO47x61ymLhl5nr883IS6f0/l65kQMjyG7uPQ
 lenmmXXsrsTwxtfCWjgOeL5aNgEhJpNca5Y38RsCppvXuZiT3dQhQRbwKNpBpTCQlo8fYytf/25
 Md/NpNLFyHPOlzwCa0w==
X-Proofpoint-ORIG-GUID: HTcsYoDMfeQ3mT_e5SpwfjUeAVIqlSrA
X-Proofpoint-GUID: HTcsYoDMfeQ3mT_e5SpwfjUeAVIqlSrA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 bulkscore=0
 phishscore=0 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300222
X-Rspamd-Queue-Id: 497664A8403
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35729-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]


On Mon, 27 Apr 2026 09:00:41 +0200, Krzysztof Kozlowski wrote:
> Various names for Qualcomm as a company are used in user-visible config
> options: QCOM, Qualcomm and Qualcomm Technologies.  Switch to unified
> "Qualcomm" so it will be easier for users to identify the options when
> for example running menuconfig.
> 
> 

Applied, thanks!

[1/1] wifi: ath: Unify user-visible "Qualcomm" name
      commit: 2419d92ad387ff34376e7c3afc300cff651038da

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


