Return-Path: <linux-wireless+bounces-37451-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lzVBJZ9CJGpD4gEAu9opvQ
	(envelope-from <linux-wireless+bounces-37451-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Jun 2026 17:54:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C95264DDC6
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Jun 2026 17:54:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=QGbOPq6C;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=GlnOkQUh;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37451-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37451-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18C14300F7B9
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jun 2026 15:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25B43AFCFE;
	Sat,  6 Jun 2026 15:54:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77084158DCF
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jun 2026 15:54:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780761243; cv=none; b=onlEBOa3g4BA7T4M5WWGkMmzo33wN4kxHxfkOjjFh9PD5yBWbcQY3khLpdo0FpOQddVn0MipkE8Y1Uus+YB9Krxp+zpr6m4PTmrWaFegNXgkKHdDnsnSUw3y7IG8FqB2slpN3ZZbRZ0nI4A0iXIULBzlOs++nCNU1dPueGYjA5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780761243; c=relaxed/simple;
	bh=J/+c222+dUfE4hbOJHmrPHN48ts3W2G93dJCWlW2nTI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TOMwXGn0NxghOwtNEfRCVGRO2Mjtqvpp/hK/wCBM5cckvPAHkArIVmkFduzA14sOETDcZIIR8huYxSkc4ioxwubixPau1OhpZQB9H72awhS0+m7+xomXW+73otWGH0BEQP5rIHverKoeqcDlg6dt/elaYBMtyJI/nLrnP1Joj54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QGbOPq6C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GlnOkQUh; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 656Evbxh2160743
	for <linux-wireless@vger.kernel.org>; Sat, 6 Jun 2026 15:54:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VAg8E1F7JMSxZtltHjJ12GUMrvJimnn0e2ZnUHRrCfk=; b=QGbOPq6Cp6SApBwZ
	D1XO6tZjWQGX7rq1xzOW6uYuwbyFAJ9wIhBqm5A6jfeKa2ou0rll/pyM/5z9mHKU
	hlc1YNNNsdQz1kHe8o4XVYQn6F/0COTRl12nzNqmxjIPGEiZW+nUdZmsXcRjjQQf
	tJEvQqZ1kye+Ih8Dn8Ig72O8EvEf5EtF7X/A+dXBlZHXn5KJ7Wkx0GsYNaUPz1CA
	anzwdbBo/mQg6HGHlQzxuRFLTwBjojNLuIZ14oWtW9J/6stRnEoxcghxN4f3pz25
	njytNqtln5qS+whWK8MuaBsy1u6wTTXcFl9ELxSmfLZGC+r+7RNoMeVL6zjS8uRT
	XifnAQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embx69ggj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 06 Jun 2026 15:54:01 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-307625ee07fso498288eec.1
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jun 2026 08:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780761240; x=1781366040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAg8E1F7JMSxZtltHjJ12GUMrvJimnn0e2ZnUHRrCfk=;
        b=GlnOkQUhtEywRQZcPXsl6actEjrawEcnZYsGOvoLgCyP1YkUqwdwasm4FbjcDbfcmo
         NO5fYa69tNBQfuteeOE9ghkHLMBe/z4NbOlNVUAe6zCXqTgXXIPKY8aVSf5l+rfdsRNf
         e8jZkBkzZ2ySvnJyQiTYbGZgwnwSl5fF0Y/haQGbl7oX6e/WQuAja+/SXYnb2sspn0mT
         KHRkC8A4AXtH9pQW8Ml9Xr06u/jY+Z/7wa6Kx9CJwhFnV+VEX5WuUzFjF6+4bxA/ye+q
         tlPRdXJgOJuajwU2apV3Symju2NE0ISQj7xIxEcR4WG7jDDgwHJQedtXFqlex5n9cLQ+
         bKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780761240; x=1781366040;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VAg8E1F7JMSxZtltHjJ12GUMrvJimnn0e2ZnUHRrCfk=;
        b=l2qR2P2apH9fuXlPfNqFqixSdz/iN2M/gnZutasbo/JNDvUDDcka0vEy2/LxW7kAsJ
         P8XgFDUaczTvvAEypfrEKf+oiHEbqHOLmovlP5jcmAmCQH4UMhjNkkbd9OOTadROl6Qf
         CLTHOcy7+5OSZNBUpRe3NUQnc6KQR0Yzgpv5YTXKLaZO/qofYUztr2zSTrjugNnuUtI2
         wWeqLZ5b4Nff5j+G5hGiGIPRuAsrWg9uqnrUYHbkVaEmd4mS/S/N8TveJD/m6jJsphxP
         Qq/VFSMF7l0SIHRYqlnmlV/sCeIub2Ad/JVGPzDTg8aQPZIAECB3+8PufUuKwgrphSLj
         HqTA==
X-Forwarded-Encrypted: i=1; AFNElJ/MnAkvXlGEoYlwz6UpgkGWiDZV7KbWhaWbMYlfPz/apDwBvSZCWDiwQoUgpVGKyYnl5kUXCXzi6MXa4fDmwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAwW+F+WDN+EUk43TnimfK5TjcofrbI3EcGupIHg4ZeUhbEMpp
	A/tQbrNv8SbkSHxbp+cYZJyvvZRilZt+Kf/nKNBdrJycTKspus5oWQKKeIEuUZTJYdX/qrkNVNG
	SPWfeqDFpl3EUcj53rQ1746orA9mmTS/OsEiTpN3ucRTvS7R13DVg7Xysix92P1qANb4cyg==
X-Gm-Gg: Acq92OHgU0dPjfr21uG1ToT/32XIIhFWBJNiz8hV1YhVVnC6niYrKoVaUj9F7hDnXIX
	uL10WIUoq98NKSJdcRmnpcPAIbKhHrWJpAuEE2AaU/v7h9gU0hAvWmAYqXDW4FK2YlVLan/G/PT
	KtHUapYQ4p6E17+gG1YJhwVsNMw0Ap8XvBv0Ya18L28DlIRE2xMO3WVEOZVP/kxqSFxvQpOPmS7
	wxUsDoyujILQWCQ7ijMTg5lSbMV/+e/YMiNG+cz9mqPr8lYMpXDren6YSe7nci/ZTcjAfs05om3
	vbzUcg5f4aVOx5ztA51O/stKoL7uPsbpb2jtJiaHZ7jj2StcVw+uN56HL/jblD8kUzMiL0QrKyE
	Xe4BcrKLY7PrQx77u2VKeqaLjWvFk+7qYfx8ovEd/6dpseurqbBxWgqIjpA182e0QOAULpsM0mn
	lrMEZnLpdM1gE=
X-Received: by 2002:a05:7300:760b:b0:2f5:3641:f126 with SMTP id 5a478bee46e88-3077b1f31c2mr5311914eec.24.1780761240317;
        Sat, 06 Jun 2026 08:54:00 -0700 (PDT)
X-Received: by 2002:a05:7300:760b:b0:2f5:3641:f126 with SMTP id 5a478bee46e88-3077b1f31c2mr5311906eec.24.1780761239797;
        Sat, 06 Jun 2026 08:53:59 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df48671sm11240392eec.24.2026.06.06.08.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 08:53:59 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: loic.poulain@oss.qualcomm.com, Stepan Ionichev <sozdayvek@gmail.com>
Cc: wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260503165832.1675-1-sozdayvek@gmail.com>
References: <20260503165832.1675-1-sozdayvek@gmail.com>
Subject: Re: [PATCH] wifi: wcn36xx: fix spelling mistakes in dxe header
 comment
Message-Id: <178076123907.768205.15915076797846622316.b4-ty@oss.qualcomm.com>
Date: Sat, 06 Jun 2026 08:53:59 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=cvmrVV4i c=1 sm=1 tr=0 ts=6a244299 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=4_5JHEuUvqCg6vuX0xwA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDE2MyBTYWx0ZWRfX2Qt1NT/ijI6L
 +++vit+AAw66Jh8HkL2CfKBUY0M2CDtc/95lsVSF+/dsPJCEl7gFv2WwMNHS3s+LpWgwTZ9WM4f
 neilrw2jkwn2SQMAcyyu48iFlwInQfM0xVTIt3/Fy7lKg8j5qF10xQMlUmlqb3XwE98U29zuR8/
 VZ19iexbqYcWH/VJSgrWPu1+ynxnFhtSFBLDrhQKwowYAMJH2T6OGnqjjm6PEw7+oPXvXolQPLb
 H6jgtpxEJ8e750nO9NA48uvV6c7BT+dsTg5xSCg6W43LzDWdGCfApm5eI8PvrWFSzCunjcZP+Qf
 yqqjkjdOsrvQ6KEWuYa9EvRRxvl2eFRy2pEk6KLBJDCGlDwGSVCdc9OIMIZ9Ho7G/tFUoUji7uj
 P0oLyV8PhUFibpGZSNzDgLtBrdZmxoKl4+VyK+GpKl77DKK8mDgq4LUoSRm6UO1M4/iKdOmLkZS
 Bo2123Uf0giNOfsNroA==
X-Proofpoint-GUID: CSokfEzURVFyEDhYHp_pm7n2qi-V5QuY
X-Proofpoint-ORIG-GUID: CSokfEzURVFyEDhYHp_pm7n2qi-V5QuY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060163
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37451-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:loic.poulain@oss.qualcomm.com,m:sozdayvek@gmail.com,m:wcn36xx@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C95264DDC6


On Sun, 03 May 2026 21:58:32 +0500, Stepan Ionichev wrote:
> Fix three spelling mistakes in the DMA Transfer Engine (DXE)
> description comment at the top of dxe.c.
> 
> No functional change.
> 
> 

Applied, thanks!

[1/1] wifi: wcn36xx: fix spelling mistakes in dxe header comment
      commit: a969232fa359950f7cf2ea415938562263369909

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


