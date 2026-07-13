Return-Path: <linux-wireless+bounces-38966-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xY5qJiawVGoApgMAu9opvQ
	(envelope-from <linux-wireless+bounces-38966-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 11:30:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A43F7494EA
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 11:30:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=mUA9kqd+;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=aieBANvI;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38966-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38966-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 805FE3012B3D
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCB83E3D90;
	Mon, 13 Jul 2026 09:29:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A5B3E171E
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 09:29:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783934970; cv=none; b=K1DEuI4PZ2c6eFfavllaf3DvJb0F72v0WrcPV9Ri2NRE0enk0yymQtLfJbWENPCsTnh9EaevUWlP/54L5R60TxBrixNrfdKluTGEe4TeTywgUn+DBVr9A3va6GvDK/zKpNlYblnWJyu5zi4G1axLMSXMPzXzLlr3zboPe7pwxVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783934970; c=relaxed/simple;
	bh=PN0V+slaQoip4wgpHQ8tusi05kMvRVLj1XC/vnUKj9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HTS+EbMWbsFby6ZjcPML35FDDaCT/IV/blSiyI//vIsfNJ7R791rOKpkCZebYjq9vqTH1/HAC8mkaWuMhoivv4NUEFzaivgoHhUWn0oDDs+4Ei7ohPq4KtMcz3hjqOC3130aro0yYLNBNBUuQWmHr34/wPml9dynNpNek5DoA3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mUA9kqd+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aieBANvI; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6O1Hf507448
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 09:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5yNNGv3UC9KF6RYEoemdEOCJ06sbG6AZs3NCxBW8eIo=; b=mUA9kqd+2nLcrNNX
	3pqa1ncvCZSY79TJ/S2WaWEiBp4weBEYpu1Xo2lWorUGmTYUspoZYo4+vk1y/3zF
	mZn/Y8a5VddTpFRGDPAczJsxLUCLzSD1/JHB9NAzgi/V1VsUcryJmoqLDIeBIfML
	pMoJFsurtkF86giYIK5Up9CMm1EyKC2ojeuKSy2zSYsvdbr5LvkhS2M67qUK20J1
	rsVW+SygGTKzP5NlYMhzfS9VrdPMqsZeFxTf3iPa/b3ugE9SKAvQaE/EhzwKZX71
	xvHuUnpwa3AujmXh8RlOVVr0YD0SeN4WYXbPdmlvHB8PH0b0Odf4qvv2UTOX9LLp
	SjxlYQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fctc8gu8f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 09:29:28 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c88fc985a65so2893156a12.2
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 02:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783934968; x=1784539768; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5yNNGv3UC9KF6RYEoemdEOCJ06sbG6AZs3NCxBW8eIo=;
        b=aieBANvIE31D7PGUkx/0Q7ZTihyNqKiml1oO5jMHSl6XyfAQXl4jqqlSi6RJDwdMgD
         U/ki7jb5Q6NF5F6yNjg61g58H4VAaQvn/ga/nqWb0IR6JBiCR62AFoHrpGlDJqXyTemu
         exwlyFVSJ8mrtOeWHvuXYjtqj1J13yGrsq9gDNKWkoxvhCF81MmY2hgTABgF4HbA3esS
         QRavTn9HwUdvTsqK+xdUqRnjKPRQoToRVZW9va4GYHaZ5HE2NQzvUSkh3p/6YoMjKnzH
         tVZk7MkntskE2qUsxebguZYpjCV8LL1cyKrITp0qFMY67nRYmqf5dRH2/6OhRP+oqDb8
         u/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783934968; x=1784539768;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5yNNGv3UC9KF6RYEoemdEOCJ06sbG6AZs3NCxBW8eIo=;
        b=sr4reg9qkEk3Fvq09SlBRp+iVM2SpE++JgeOm4d7ldeaw3Ziu1eWwFXFbZQwWFkgRi
         qyN4tC5RHO83c5Nbh3Qd/BpzQQWLJC9I/AFmhg5ZRrxyjfKa/w8M6gMy//tG6wn23C3x
         swAlg4XwZ62VD3QkUD8pDmGBpWea+81cSNMRsmamQPGN3s6C9z/3RKMdTTAkoSXkvvOa
         oocg2Dp8B8+9lwWQ6cpvTv9P2FkmAu2yTzWDKaPDYRD4FnAEmOFZmORBEmZi4kGBiCQY
         C0D403LnoP+08n3d/A1KFoeagHuEj4osng3JL8Ei6bk2YNTUKk4LQ5IY2CiKPGWKY2ow
         l8Kg==
X-Gm-Message-State: AOJu0YwE48MTeqo99Mm8LVVZ2iSvtWjkco0u2SII49Q6YnVxhRB2fXPq
	Oa3qPDOA/wuqof1IjHYjPFhdS2TgzDjYJpQ7FzRLm2wBR8AZt3SrR0/kkLOWC84xpdbPXVPiL2z
	rTOE/ptHK78QT2YI+l0OQFvq0erdUVpa6Mo4Sx+s25Vzhsed2f1b7j+Yq+dutvJK7W4syaQ==
X-Gm-Gg: AfdE7clCH8Hs7+9tpiugJ1jk/2b71IUS757/uyrXVEcyvXTcmzuUbKL0bzGeN8zbRHf
	TfoG/vGcb8VDwa8tDpdaSZzxIjHraGJRRcZ1tNh9VGlnWZV9QPl9sQbDcpeEqoeydjenCWZf4DZ
	UQPHEB6KYYviLK8vSWferJNRv7baVEERTI7sWNtSnsAMtaow+XZQfyZqYIxai+5jrJU5iM+Y3Hs
	o990izKE0hB17um4bemtCGIQB70GNI0EHRAScKivZPYcFx8q305oUsw6OKYEGi3Afg/pmfZM7yY
	+DkUcUsCTmEG6G0S/waZzqn9FTaV0MfOmZcfxynjKZHl7u1klRrWoeEIh86D+TcjuFhz+ETuOQK
	AqMZiJRjFzhA56PlLP+aA21Ulag1zjLv4bqAwWXBkfHS42WFfnZo=
X-Received: by 2002:a05:6a20:3d06:b0:3c1:b9c:4890 with SMTP id adf61e73a8af0-3c11018d8camr10981087637.22.1783934967820;
        Mon, 13 Jul 2026 02:29:27 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d06:b0:3c1:b9c:4890 with SMTP id adf61e73a8af0-3c11018d8camr10981064637.22.1783934967414;
        Mon, 13 Jul 2026 02:29:27 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b8fc7c088sm20140006c88.2.2026.07.13.02.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 02:29:27 -0700 (PDT)
Message-ID: <bf3f982d-7d5a-4573-ae34-6e972ddbac8e@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 14:59:22 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: validate regulatory capability phy_id
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260704011040.26233-1-pengpeng@iscas.ac.cn>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260704011040.26233-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: gYu4a6cwXZHCTAkVI3M_tvIW_juKW1VX
X-Proofpoint-ORIG-GUID: gYu4a6cwXZHCTAkVI3M_tvIW_juKW1VX
X-Authority-Analysis: v=2.4 cv=UtRT8ewB c=1 sm=1 tr=0 ts=6a54aff8 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=TIgdfdpnsFF7rSLKS_gA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA5OCBTYWx0ZWRfX2BJ1PO1eTE8d
 yQQYG4E/jmMuBdDCfIycrIJMcQnl/oapMdAx6ZgReV+s8Fopa92PVWyK9ZqDOmmaecFkDpF7jOt
 m7j26Kec+QglIt0O2wtZNieGpuA7P/M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA5OCBTYWx0ZWRfX+ZaBlbpDZQem
 iXVXANrueqdRUYazCUtnruMMT/jK0rOYeranIP4HzYPb2PgMGwENC/QFnBjdLPjadNM7K7A8zjS
 HBaB1/J40y4duYQjPwHheZYQwJzUbdDnwXnhZsFxhgRgludueyTk24Mg4d04jQM+1oxTbOYMf5N
 hv8kGAEa+jwIdpm2zLCcSCnZn0+JhDf86v2TxFmwojgkCjgvEpHUxseN/YYJULtHZGJFuprft8I
 HyQhNW4UIFybH4ouBAyWZ4ENSywbmEE7HH+tW4jk8M8PigBQ19wrQvyBd8rLXQtu9FPQJePX/zZ
 pNJkU6uIWUkow0vT4vrmP7F5hFcssjN2M+EQMOHtiK8NaUEn2WQW1/ueRXerLzsXDeeOz3tTEL1
 TaqQ3cTPMvIiRdw28FHNKQlAe60hYVgWh4SORQJwF6VgNmGqUMQvRftAaif/RW26fzwpfhKIGh2
 yruMApYPyZ8W0TUP6PQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130098
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38966-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pengpeng@iscas.ac.cn,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A43F7494EA

On 7/4/2026 6:40 AM, Pengpeng Hou wrote:
> ath11k_wmi_tlv_ext_hal_reg_caps() copies firmware regulatory
> capability records into soc->hal_reg_cap[] using reg_cap.phy_id as
> the destination index.  The loop count is bounded by num_phy, but the
> phy_id embedded in each record is not checked against the fixed
> MAX_RADIOS-sized destination array.
> 
> Reject firmware records whose phy_id does not fit soc->hal_reg_cap[]
> before copying the parsed capability.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

