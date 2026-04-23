Return-Path: <linux-wireless+bounces-35249-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DBbLb1e6mmrygIAu9opvQ
	(envelope-from <linux-wireless+bounces-35249-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 20:02:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91442455DCB
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 20:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C96213073C1C
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 18:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DA43502A3;
	Thu, 23 Apr 2026 18:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IKeR1wC7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fhyXN7CZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95183AA4FA
	for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2026 18:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776967264; cv=none; b=lLvrgxc40zKdZ4SSdgTbfcSyFZ6IdYE5jomduTEuaRa0SL7Z8EbgwyttPPlBn0iY/9m5BfC2e/Z7MkeNl5ZSpdoi0zJAQHSsIlYp/Ei+lcaMfXBxgZosaYk/iGca+rvSr6xFLXH1rTbCUGART/zaCvQfnjSLwZ4wQaUh/jpxdVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776967264; c=relaxed/simple;
	bh=X5XicT3e68jD6KJ3rcboEFg9aCwbY4gsjq2ziDksYes=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WOgGcmY0rDkZHky27jPQVlgHx9Ih7IEnvvWwOmpCuf4f/Wyi8Spo06onsgkJU7O1buGJgRtBUdcQoLWqiKC6iwcHe7tBt0jo7A8Tvr04lbjEpaJmZVc1l04mSILrGilpK/uzJOyWLs4aiX2BAbd17htltTgkvu14wj9MiLrepXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IKeR1wC7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fhyXN7CZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NG5gXl1204882
	for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2026 18:01:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s5vE5A5hYUqya9JT43F/8JpKCASx4QJJNcIhw3GSShg=; b=IKeR1wC7thtZuaqJ
	R0IHKAYUShtuM/kDvdm8YS7dTJIlewmnuNKQEtoNGLSj0V9ouwfH04ml1CAW+ld8
	2WJIZkeo8GMfx+4mi2Y2QMWjPdzcx3YJjhESmXulfGKVJsfo9jb7X/kVLpezk49l
	3i62RsUSGjIqdH7lLTkk+kcM0pMedUKg19Gpp+MkzZxeryVQAS9sKKM8AVi32+zA
	mqEaCo4Q3nygzXjvzEY3FRqqLOks6bonR0IGEu8ACuB7y0fMPf4VMlbPGHe2pJDC
	lXAhyrktMr7MsoSSyCbLGEXAE82QZvhuSVUq9F3SLLBzWJ8oSEs/82iA0T6TPkQ4
	uCKnRg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqggna6ru-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2026 18:01:02 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2ddd8ef5343so6667337eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2026 11:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776967261; x=1777572061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5vE5A5hYUqya9JT43F/8JpKCASx4QJJNcIhw3GSShg=;
        b=fhyXN7CZPZ5QrdPgw9gBok9Nno6djveLJSxiWQGJhZdWafRB+rVrVNUxKnkNan/4yv
         UxOodPsyMjfHS1aGgWOoZD8QzXafkykKyDtkKS5vPwMQB7hQBCiGNwlhB6ApzyFSMq2P
         A8a/kQbtvzRRWgIKIfE878bpIVblZLu9bir7OUQ5FHTJN+autNh/RJx7BhY/U+RXFHkI
         t2WAnGmHAhWPChseiyAjLE9x83aKImBmVIfiiOE4OKOnc6+WWPF+OWC0qAQhMgi2R6pc
         moFAQ2LIaydny6Z93mXGS5+iz2tMT7DgUZWogrOz9c4ztNVgKod7MX3x9lcpSw8ywitR
         1ywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776967261; x=1777572061;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s5vE5A5hYUqya9JT43F/8JpKCASx4QJJNcIhw3GSShg=;
        b=POYL4RuHnROMpVbmdGIBqziLB6Mr0Ic1+6bq528IurwXiqTkjxUUYMRe1hZc5uclAe
         G4uBfRrkKAEZkpdcKpIkhMK/X03wav5iQ4z7Nf8f1QEaq8msCSEEQAjfAmudoP5p/voJ
         z3uVIrI37udpcOlruF51gSnicNluk0uUigPeeC0UAtblkvDjdKy7lWeGR8NgIvS3JBlL
         9hENicV+ieQ5zyIr/SSsc6flijcaa9oMLRgeaYpRYp3N/h57g3Om2RVthLG3URXpOzXO
         EChiQNs9z/nr9Rih65GpHRs3exJCInpAZobujimZJ8pRgCVeuSiBjQcGdGogk4S29KbK
         0OsA==
X-Gm-Message-State: AOJu0Yw/GUOjQzBdjT4rDLpogPdzE/X+09F+iMRWlZkcAKAfSBBNSPPA
	Wq97XcZJHPdAXXiiS0jijIlswnAHANxCFsK9F8zOrX+cWYXL91+M0WSNGtuKl0jKk8Wt3nTx16O
	VH5XflAWUrcIUiIUIWAiURxml4CqLL/N/vDdHoXJoTRfnwIrD3p4KpAb2P8aFNaC7YYqTgsTHPA
	E4AQ==
X-Gm-Gg: AeBDiesX/qLGlyejEUk9Un4+gqhDO1HAuYW3GKX7eH/YJ26D+B2qpygeBIetjUdlYna
	qocrHd+ZMw4qTMq95g1LBLQ2TnosTGEVbHUcGjc+EcGyiX2blLop9pFZFVWqL0JqHSeJ9unW4Jq
	ixYgCxvIN+QOfVcjbF9ccboS3XAyqOZI4Sd3SM3NQgZ1Ot5zQOm6wqf/zo4np7rjH+kgxVEQV+m
	CNC6gXiY/zOOZmIqxAjkjliTahwF7J4u6JcUmn6F75Aor/SrzgmuVz26MIhO3DAMuY+iuAo2ajk
	rVO3pv0mla9SuaGR5vPZAF1nbW9nCxVU1/+k6yuC2Vk6xdG8dbcSrViNDF4zXb+VTbAwQxKU8Or
	G36tz7eSEpKYr6wjdzOi2nSVflhxJoEnEXm8fQCjG33mJNJvQKd3S2rLKhW5QCtHzkQZHWA74Uf
	tlJNrhLZ1UO3w=
X-Received: by 2002:a05:693c:3007:b0:2ea:5057:a2f9 with SMTP id 5a478bee46e88-2ea5057b737mr6964265eec.16.1776967260926;
        Thu, 23 Apr 2026 11:01:00 -0700 (PDT)
X-Received: by 2002:a05:693c:3007:b0:2ea:5057:a2f9 with SMTP id 5a478bee46e88-2ea5057b737mr6964230eec.16.1776967259994;
        Thu, 23 Apr 2026 11:00:59 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e539fa244csm27867887eec.2.2026.04.23.11.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 11:00:57 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
In-Reply-To: <20260418-ath10k-snoc-pwrseq-v1-1-832594ba3294@oss.qualcomm.com>
References: <20260418-ath10k-snoc-pwrseq-v1-1-832594ba3294@oss.qualcomm.com>
Subject: Re: [PATCH] wifi: ath10k: snoc: select POWER_SEQUENCING
Message-Id: <177696725731.2493545.1584090736302487540.b4-ty@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 11:00:57 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: a7Y-Ey0XnqpX4HCkEIrGdDvsVB2bKI33
X-Authority-Analysis: v=2.4 cv=YZeNIQRf c=1 sm=1 tr=0 ts=69ea5e5e cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=wcuXUMGJSOV-wyKThOUA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE3NSBTYWx0ZWRfX7WLKsdiaKcBZ
 9fUFLez5VYT9auwO9o8I09U3zVz6OTZdtThpYLt92GtAiTGRG3pR9UTVHrcauZGvXvwKZGaYe9/
 he7c/HOp979YrQ7+WMSz7fFIt0zMIjGBZX08T4ZmXPU/tadzvdh4yhk2U9J4+ShWewIPlyaqNTo
 aoFoO1FAx5jgjzuP+gK9j1rMM1NgY+iJm9Ke+uB8G7rTeU1ZYvvi3tGVsQAT5Ya5QiBAxIaOU2E
 BZPyBGHqkT/tmDcJ/xgc7/EdWe0LZJMNGgGoHtOvBODwPfKd5aaSXIOPZarvHZFuzd9HhDTSmAL
 bC+aW1i3rsHB7TEQcizASIeQspNg8xwDfkcinC52RB7jfxeqNmtEnVMb0SXOFsA69qbXwRuyXYr
 Vb4sB66rEcQTzFZWsCBy//4aL50p8BWxqRYVCYc8CIn9dsbX/uwIMJn17aOjmb3Pw5XjVifbUFk
 i+KLSMN+EyAFKGys98g==
X-Proofpoint-GUID: a7Y-Ey0XnqpX4HCkEIrGdDvsVB2bKI33
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230175
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35249-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 91442455DCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Sat, 18 Apr 2026 22:37:00 +0300, Dmitry Baryshkov wrote:
> The commit afcf3ec615c9 ("wifi: ath10k: snoc: support powering on the
> device via pwrseq") made ath10k SNOC driver use devm_pwrseq_get().
> Select the corresponding Kconfig symbol to make sure that API call is
> always available and doesn't return an error per se.
> 
> 

Applied, thanks!

[1/1] wifi: ath10k: snoc: select POWER_SEQUENCING
      commit: c4b6ad0e14f5df942eed5ebadaff84b468bd2496

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


