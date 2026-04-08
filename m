Return-Path: <linux-wireless+bounces-34499-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CG65EWCm1WnE8QcAu9opvQ
	(envelope-from <linux-wireless+bounces-34499-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 02:50:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABEF3B5C5D
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 02:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1E5CA300E6B4
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2026 00:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53C72EBBA9;
	Wed,  8 Apr 2026 00:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LsZzGZrQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kS83dRoy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5022EB5A6
	for <linux-wireless@vger.kernel.org>; Wed,  8 Apr 2026 00:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775609433; cv=none; b=Ze2LWnnWaPBP77E8uskZZMrvjSC8uTO6fnvda4fD4uUksBdhQzMVlVQg4uqGj4hl/E9jZGgeIcg0NFCAOBCvpybJfIR0JJMheFheX95HPPQkIHlQmZhIAf0McKAl1y7KAFBmxQkIdsKQfvZYKkzMDdpTJF7vfe+TUmvDIMhhJdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775609433; c=relaxed/simple;
	bh=C+r9OBx5Nd7h/G3CS3HN2RfWlh3xqisiTB5m1PH3HII=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gcUCmcMYboa5ssOSONSfCP1tsecSi6GRBF6YQg+Uq5fy6MLAU4egK7A48U24UVWe4eCvnzDqVvoxdN5gniTrrfGTd225Xmtz/4f4dTv999rOnGuKfMr0k6LCf/+27i03uTS6UKkr8q2+kWnLG+1DzLodmfBzLZ+m9MFsyA9Wblo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LsZzGZrQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kS83dRoy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637H76k12411813
	for <linux-wireless@vger.kernel.org>; Wed, 8 Apr 2026 00:50:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QgwQoKCcu71xquXtrzxtoltKDW2nzAc7fytrdZXTv1o=; b=LsZzGZrQxGfj1V6h
	/Koi0VPOgeb3uiMkE1jPTkOe3ep4uSLPvv/jlP8yYfOzh1axeMNvRrOwHqFCB8BN
	mirzPtnJUlJxhmfqRl4+S1IGZ5xHlpwv3Vr5kKAOi5yrSmP9vtoMi0ni8QHqzVBD
	g1GyGNw3sihmilxNbiU9ZRWnsD459/cPFTUGKPRPniog+z+gSngVF7AYuEqvHIvq
	PGLkkF3EfnkkXQybDTDeQHOy/+MNIcgZdZew6Cj5Ds2deqzJOxt0Mx8smuyh65RP
	5XTbiJ/zMnsIJdx3QHaKjmk/uJkGl3Lkz/7Rt8vznzka9gcVsW3HJivr6llgPHKB
	s7hejg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd61v9buf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 08 Apr 2026 00:50:31 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2d054421d19so11073177eec.1
        for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 17:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775609430; x=1776214230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgwQoKCcu71xquXtrzxtoltKDW2nzAc7fytrdZXTv1o=;
        b=kS83dRoy8l2fs3iqmfHr0Ze/k92BTUKI+Dlmk4pPEPlSTXR8x9pdGMGJXu3oYCB5xH
         H+cskldkDzzjBefiOLjaPVt8GjLXfIFzFIukMMxJEEFj7lZCijevbGhJDaHPnx3VFlJi
         4/95RZZIBhKLYw3dKOLw10PrISWaLsEuobUDYvVp6xjzZu9a+wtvZ9ZIwO+cruiy/zfn
         +DLohyVdJ8ta1XvD4bl+cURd8bHqjkWIZj8dt7Wh7+dBP6Fq7sM4Fy3wteqBMcPfZFxn
         U04QJn3J8DLUeHr0gLQvk1aVCnkffsR7aw4E/IAUYY9gz77qu+BrwNGd1orn1l1fdyks
         TFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775609430; x=1776214230;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QgwQoKCcu71xquXtrzxtoltKDW2nzAc7fytrdZXTv1o=;
        b=Jerf9SIzUhIcPQ0rl+gdyjkf5D5f+KfPGLpUWatLD9+lT3OF2urfOUzt+ADQcArCaO
         qz4+YLg8e67cdnAAnWWjfA/nxKe7t81iMQ/a7ybufyf7KC/AbFU+R2ywAyEbdBI40LT+
         9hob+neZyngWRfc3ZN8Nk+q6aFjgBvAMDu3Fr393rb+XzXUCSOSMJnzHuSrYumAcweb3
         W24Ozci7K0qmJzmdeiHJzW1bky/cmjhCFvFdNllx6YQyMdxuktu308Z+GxmOoFvmZCPY
         MKXsydq90aMCd9TyIZa9AyAXk2kPEKVWKt6aGsm5Vz8dktQVQiTnGJ3W5bpdLIM73Y2B
         Csew==
X-Gm-Message-State: AOJu0YxVRSyDSq8/dUbpH5AiWbXMQFkJByIltV4rfcBP9DvdxhcawvGK
	6/sLEkhEsFhHzpHbjJ9fucg0AJ0KPTf3/OCBMRI1GlmHIPcP7uWPfXc/QervR0MB4wJz66bmKeV
	t3QEbcB2RQxkXR8yL9tLQJh75Kvqiv5Q2d5mIHcfcHB5oijKQSybrL4V/iQZtWbFyhsW/YQ==
X-Gm-Gg: AeBDietdLiEgoYQkbsUo9rCAppIKj49SEDFOcmUFQ/vLAesV8aMfgeC3uEUkNGntKiq
	JCEVcol1XqCbvWgka6FV5/xlhRMZeN/Ky0cBdknI1duWvUWlUZETfsBhwCbl/GDhgNCG4P8vYDq
	kwvhA7C2JPrmccz/u28iACbNXm2pj8Q87usAjbVX1pTyQFznpEIB/NcZQSn1wYLc4rgIe1bqfOO
	z8k8CvuWYIpAfwhDwxMMVOwGAO3ipr8wcs+738sahL9gFWYQcNGdTKbcLKKvN6vggHsGyhAWSH5
	JM8aV0wuXQs/yboFR+duXVCrhD7C0sz8qjLe9cVSX1QnE9PsuYM8zp+3Ap0YGNMxzBboEt/CgDs
	cVH3nUa32sO8TuuIQ5TNOvxwhvmVzB7WHs83249brISrF0/rsoCWjamr36RZ2U1xnjsjHpKUYEu
	bD
X-Received: by 2002:a05:7300:2153:b0:2c7:287:6740 with SMTP id 5a478bee46e88-2cbfc45b1cemr10111668eec.28.1775609430284;
        Tue, 07 Apr 2026 17:50:30 -0700 (PDT)
X-Received: by 2002:a05:7300:2153:b0:2c7:287:6740 with SMTP id 5a478bee46e88-2cbfc45b1cemr10111656eec.28.1775609429791;
        Tue, 07 Apr 2026 17:50:29 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d2d5409fd1sm1257301eec.13.2026.04.07.17.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 17:50:29 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        pmenzel@molgen.mpg.de
In-Reply-To: <20260325-ath10k-station-lookup-failure-v1-1-2e0c970f25d5@oss.qualcomm.com>
References: <20260325-ath10k-station-lookup-failure-v1-1-2e0c970f25d5@oss.qualcomm.com>
Subject: Re: [PATCH ath-current] wifi: ath10k: fix station lookup failure
 during disconnect
Message-Id: <177560942876.2878209.17440433567306755660.b4-ty@oss.qualcomm.com>
Date: Tue, 07 Apr 2026 17:50:28 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAwMyBTYWx0ZWRfX6HeTPlufdWIL
 OEdsDUrAr6TqmcxC7AHs8YF1q646oPncvQx0FXpCgic6DY1vB+6X0QnwvWlSnkaNSPR6h38Jihz
 SD6uNrapSTq2eiL7Z7vjuVcGXo+drxNq9A9jDaPQQgEJxFzviXMYJ4uYGfaTSgPjw68auDP0TB8
 ifF3rUzARBpEkkqMA2LBVBHc4vXBlCXOV7mIxsnGsKm14bWBs+5hDg0OKezPShL09nH8w7M4XQW
 UlsegCC/6+nunLG1kejWxq29D3xC4yKpiMRtz3ST5j+SkTmnaxn7oecsbSIrjKoBjsb7KPIt5d2
 2J3tqOoBeTmjdN8Pyf4knar2ChL0BNWVJWYUlqqofGvGzEaBRtD3GKPTQ/n/u98gmkhR3l/9Yjo
 1StsBzoZT8gX2MdD2b/F8l3LPsyjRO6JwPb0Sk6Ozxbh/0VDfjThiBd/EWzZihzfSxXErbgW88M
 pynr5FLV0QUoBUiXkNQ==
X-Authority-Analysis: v=2.4 cv=FecHAp+6 c=1 sm=1 tr=0 ts=69d5a657 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=sV67j34BMPHGzpXQRmIA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: mmvPLbwvrCMND8fsLjX6S59gQEf2eSBd
X-Proofpoint-GUID: mmvPLbwvrCMND8fsLjX6S59gQEf2eSBd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_05,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080003
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-34499-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4ABEF3B5C5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Wed, 25 Mar 2026 11:05:01 +0800, Baochen Qiang wrote:
> Recent commit [1] moved station statistics collection to an earlier stage
> of the disconnect flow. With this change in place, ath10k fails to resolve
> the station entry when handling a peer stats event triggered during
> disconnect, resulting in log messages such as:
> 
> wlp58s0: deauthenticating from 74:1a:e0:e7:b4:c8 by local choice (Reason: 3=DEAUTH_LEAVING)
> ath10k_pci 0000:3a:00.0: not found station for peer stats
> ath10k_pci 0000:3a:00.0: failed to parse stats info tlv: -22
> 
> [...]

Applied, thanks!

[1/1] wifi: ath10k: fix station lookup failure during disconnect
      commit: 9a34a59c6086ae731a06b3e61b0951feef758648

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


