Return-Path: <linux-wireless+bounces-32044-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKGPDiu4l2mz6wIAu9opvQ
	(envelope-from <linux-wireless+bounces-32044-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 02:26:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76563164217
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 02:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE0FF3013684
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 01:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1984421B905;
	Fri, 20 Feb 2026 01:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kopCXzby";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q7W2BspB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77791E5B7A
	for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 01:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771550760; cv=none; b=ekQadP0e3+gKKLEPmQN0oPxUVt2kgHOoP9EdhiEu/qQkcD/3dPl4Q54a51ShBRcDqfR2F+LNT5HOImNMEHOadHmMu+NbpQeE17vH6E5o4Re14cipm369CzTOMjLhWaMUuWOiMefwUHcM+X//TeB3IYkKB6sFQ42SKzfIgMAXpac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771550760; c=relaxed/simple;
	bh=yRxPwnesqb6NI70ZMwoyVP/N/7fCtYd33Mqh8Dj6Lj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Rwp1p/m5Gg+EbvPmEwUgwtElLV8c6SXyMZnmG1TPkmh1x2ULiWbDK25sBT+ULq6k6bkWjrnZgM8zKoNS9mtEo+cPU5sokQ4eU7K0FfBc3lFod1El7jbjSZrNSl27DhnfV41qGHA0V7gzm3mr5LGaWySMEKOUPvY/FXBxndXI9mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kopCXzby; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q7W2BspB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JNUbBw4070789
	for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 01:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u1absac9yYcTUzQH7YcAsZdqeopVHELdU3NoypYjfXU=; b=kopCXzbyCh08e5Xy
	QYDz6QXKdwRTgTiPjw1KZeL/K4a9HZ+QWOYTZV1Xs8PxO1dPB/GT6fR4UOI1iqPb
	gXiITWTAnrKqQrKKIqc3d0NU7NHSdqJdPpNxrWw8/cN8C5htFghjvtshP2EqZs63
	oL+lpbmDToNwql2OT93yH87eaE8g1nv2T95xhYAH12uBKq4dst92CVtkTcX+9s+w
	82+rsFg2lI/zBepZo1S45sZux61vrlBtnZLhKv1MNmk63f91Ni8vxSqqITAyAhAn
	5p/ARr6w8FkAxvrGCEXkvy2hrNhMoxMdvP8cCOIWY55xqoB6jYAG7cjeQt+YrxqZ
	XS8zug==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cdtjy3a1t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 01:25:57 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b7ef896edcso50213731eec.0
        for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 17:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771550757; x=1772155557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u1absac9yYcTUzQH7YcAsZdqeopVHELdU3NoypYjfXU=;
        b=Q7W2BspBF5yKSAGVMLF7cTuXf7V+u0VQutf25KCwJDNv2OyeKhbit0YXJt1Gltiti8
         3eM0gTRjidqV48BYeLiAkAiFof8iVpBuR/1VJjZmI4RvIAx9tw8yvGs0sXLu/QfRx44R
         zcgTWlxD/Oj4/8VsLuA1R9vNd+WAc+2hhtxwvIDKUzgP22GX92lN8CQjo6GKheeRZ2AL
         Gh0VvAhaeMUv42v+Nn+RkwOo7y30gXTr4tVbj3LOg0JTNI4Ri+JAaPHmc7QUATNpIXMD
         GXIsZKjyIQyX8g2OvxRD2kkizPR9pq+0EImh2OvekZBk+BAJmJ930/ye+hPG2zmEFGNU
         cKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771550757; x=1772155557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u1absac9yYcTUzQH7YcAsZdqeopVHELdU3NoypYjfXU=;
        b=cz2b+WpFTLfkf/gR/rnA1ipRS2XXrCsP4BPYkCmeS3ys4jmTWF+cUdwMQdeckkP51p
         pVy6id5NykR32s+tTg5+VbC/DQiwbcGn76QVmnx7ba6V//FEbstvNeCPgJYE7sEYULOL
         m3ovP8wnZZUnS4i6q2uQjasLvk2JmE5gBVOZ6OP9L07E5Qlo0cBd2O6c7azHZvbCRjVu
         a2AALxO7XQsLkKjevrLVVNzeRoVlGndQmk1bnBGt8KDNXFL9UR6ibKghqyJQm0w7ABWc
         at4D47iuO84NYZ+VvpKOg4QJR6YM6JzVLgkHPRWw1xXgn49jSfbMc6iE5seuhyEHksc2
         UNMg==
X-Forwarded-Encrypted: i=1; AJvYcCVOVl36Z5glPnZjjmBl9nYbUeJ33DWpVAMhxpgh0T6L8JqcB2IhhmdQOLjV4YGL0i7J6VLnJ1yG4Tvv4/jUwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcWod4PAmESFzqCTLkAYnLzL5YphsEgh1xrUvgDxXeE1N/QxPF
	1UwchtZ3kniOg8OsDdNbHVTAEsyC7ehmNYFZ8jYGa/zMqKs6FsUc8lMEU2GHxMdRGECAdXd1S4e
	Z9SfM+hPLmwNT7SgQMM+7AT2IvebVyOmstZ2qY4/4rA33gOb+ggN7/f3NyzoeohDVaxVIRA==
X-Gm-Gg: AZuq6aJUflFcjLnd0WukQt6ty4drMCBlNlrm7vNf1cr6X7mhGLDQPkC0KdNOAx7iBkc
	fHlxMsYNMhAxvEG0cARZ5Z7ePyA6QD7Ly1SH2cVCnP5Ns2+9/CbMR9p29EOtVouoTdOEYn/3iJc
	96EW2bFmkPj8MpqlYbwXR89gmXSID9o/kZMSgmMsQ1GDiqvp2+WJcT+nieKdnAsArwyx6aCHA/d
	mJhqUScNYLcrGE2+/HR/Ojq7gjau1b5bvV1Ki0q/Uz0QMJiJHL60PiDgNlnBFpoQYVnfo/5reVG
	i6/Ua6BCiQQCMKWcgvnsncQa1UJ9lFmzshdRV+IkJjMhaIZK5LL1u3ubidrqikUV1wlDKSsPpGK
	PsiZvgELO1A1E75FxniNh1SRWY5gvPZPW3Jf4yI+Ji8IwqUaYpnmG+xhFwquAF3Vuy1ELXe/fTS
	TY+v5Z1aMMK362ZQ==
X-Received: by 2002:a05:7301:1f12:b0:2ba:7dfa:c81c with SMTP id 5a478bee46e88-2bd5b3ee221mr2415080eec.30.1771550756674;
        Thu, 19 Feb 2026 17:25:56 -0800 (PST)
X-Received: by 2002:a05:7301:1f12:b0:2ba:7dfa:c81c with SMTP id 5a478bee46e88-2bd5b3ee221mr2415066eec.30.1771550756008;
        Thu, 19 Feb 2026 17:25:56 -0800 (PST)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb658509sm21289307eec.19.2026.02.19.17.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 17:25:55 -0800 (PST)
Message-ID: <3a5c7a07-71d7-4592-8623-ac8862a3ae51@oss.qualcomm.com>
Date: Thu, 19 Feb 2026 17:25:54 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 wireless-next 04/15] wifi: cfg80211: refactor
 wiphy_suspend
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        linux-wireless@vger.kernel.org
References: <20260219094725.3846371-1-miriam.rachel.korenblit@intel.com>
 <20260219094725.3846371-2-miriam.rachel.korenblit@intel.com>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <20260219094725.3846371-2-miriam.rachel.korenblit@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDAwOSBTYWx0ZWRfX9D+oeoPSJlod
 RKPLayUs8euhTu3k3T3rk9fN4BySgmMq2VEJ2zgw6VJ16MJsU7Hd4TQDs/W8OE5zC6W5H5RJUJ7
 OFtasBDhIRke3ZRrC3bjdGHPMXeHTIeoE3wLPq4G0G8wUYcAPGKYe5uscWWKm0Mw6DDWq0bNloR
 3PjMmSNl51lq+1mbPsBSm33qDaIs96qIHNFjTjyIk+YJ32YMa1E8hZdsf0KCbpnSlQiqkuFlcz2
 gkw1vqtsF28wnFnOoKS8zqTQXqFNQSiLZUC11NpnHt3najIzOgmYh38Yxr2RUlYpWAZoedqNcIN
 kp4Y3fbQpunZq7Weuw530yHa2e+rlLxRQ34sEjmXBGHF+a9fXZagvHNrDAhBPRxE68+O1guca8x
 JiSZSEDec9ymWZuuphzv2xhdRbnai6dRidF6ogjl9wHNjrjIFT4j6oP+aTa6g6jrKd0UlgE2/9l
 +1ClLhwHzkCm6+7R+Ew==
X-Proofpoint-GUID: OQ42nmStxD7uNn7QXnTAjoUZ9Q6PynE4
X-Authority-Analysis: v=2.4 cv=FoUIPmrq c=1 sm=1 tr=0 ts=6997b825 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=bC-a23v3AAAA:8 a=QyXUC8HyAAAA:8 a=5Q3nGkifVQgSITRQq7EA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: OQ42nmStxD7uNn7QXnTAjoUZ9Q6PynE4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_06,2026-02-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200009
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32044-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 76563164217
X-Rspamd-Action: no action

On 2/19/2026 1:47 AM, Miri Korenblit wrote:
> The sequence of operations that needs to be done in wiphy_suspend is
> identical for the case where there is no wowlan configured, and for the
> case that it is but the driver refused to do wowlan (by returning 1 from
> rdev_suspend).
> 
> The current code duplicates this set of operations for each one of the
> cases.
> 
> In particular, next patch will change the locking of cfg80211_leave_all to
> not hold the wiphy lock, which will be easier to do if it is not called
> twice.
> 
> Change the code to handle first the case that wowlan is configured, and
> then handle both cases (driver refused to do wowlan and no wowlan
> configured) in one place.
> 
> Note that this changes the behaviour to set suspended=true also when
> we were not registered yet, but that makes sense anyway, as wiphy works
> can be queued also before registration.
> 
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> Link: https://patch.msgid.link/20260108102921.00336669ac32.Id76f272662e1315cd93a628808cc2d1625036b00@changeid
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>

FYI my tooling says:
WARNING:BAD_SIGN_OFF: Duplicate signature

Note sure if Johannes cares...


