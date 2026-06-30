Return-Path: <linux-wireless+bounces-38418-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Wa6UG7k0RGoiqgoAu9opvQ
	(envelope-from <linux-wireless+bounces-38418-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:27:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E36C06E8246
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:27:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=H4fBN0ML;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=C42tr7t+;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38418-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38418-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D91D83034A37
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 21:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4122DCF74;
	Tue, 30 Jun 2026 21:26:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796AE19C553
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854809; cv=none; b=uyb1MIEc6gQ4dVbYVe3Hea+pP3xeBfcUD8fBxnpCv37VrDFyBpPLa+fGax3jbaSHETo9IaxnZmcluBUAgVbtHCt9QZWUlUeD2ENjvzjbhiWG1pqqivE3rH8n1zpWnqFiMlp2/kzDgBVu2uNtoDg9PpN14UIPwVlSUUUJMOTxMFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854809; c=relaxed/simple;
	bh=mV/KCvi07bfzX0h3LpdVhrOeGMOpzuNGWKm8/7S4fDQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NL+ucG8rWR9zkVIChr13nlOG4glt3QphiXPMDCEiL/NtGy0XQV76Z1dAPpx4P9vTLFKN7S+MNewB6NgOvVIOVTBYQ8+MYGYIUeeC14ta4eUsl1zqzX3mW5WwniDWxsO5BsnVLX59MSnfWwVqht6+ms4u49vJn1tO3+gh1BjqU7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H4fBN0ML; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C42tr7t+; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJDq9d2838618
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fhhkZmKx754FpQG3LSpxtJ8DbK3S6BsACSSh6KRavYE=; b=H4fBN0MLk7PBSUmO
	NQwxZcBKDGBMPyf/gV3cscCX8kVjTuV12FtlC8wPrXl3Rqxeq4FusWz1fwOtO/8/
	WnKVE836oKP4Tqu2sNkEaCJ8/QwB/dnNuBixrn0Y2GPnqmRvS4kecu99HGfqlr4j
	SfChbIgkSCOn/CKJBMRyYdri3o3bY5mN45Z4ZSZzRpTPPc/2KcJwzUOaQAO67eZ0
	lahKsHkG0lbl0DCkB2mMnE6241d5/3+VkWHm4wuDMDVyrvYQ4MM8gkQEAd4oKGfz
	YQ9u5Qq8x/UgfADezhbpBjp3dZuJwTfBDZwEnv0qdUHY5C9OvnK/YEfVcb4NbvOk
	+mgUSw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4hbd1bnx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:47 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c011c7cb9so14065430eec.1
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 14:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782854807; x=1783459607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhhkZmKx754FpQG3LSpxtJ8DbK3S6BsACSSh6KRavYE=;
        b=C42tr7t+U6NY7uoVoOta9n+b/pMdCVCzsUcr3Wf+TmQe9m9fra9bN+TAsqeWV8VNf7
         Ur/FQ6wY7aIPqSB1OrvNCplsvg4/NMop1Itnv/zCgV9hnXXFh9DPWGNPThapDwhe3bxZ
         NwuRWh9KTwC/1CHf4Lq5hXoHSjIrIupy7Che4iW3uNKtGWHP6Wucg2or+7mCk8Ew/ume
         8gUU858KssZCelwqWvcieIbTJU6bK71dAZU48Pqa5Q3ghSRtee8u9tB6xI/MTHlhL99X
         joYtSwlVI3GKule62eqkYFCTXViS730TxuY+eOD/qFW0qGa1Yu+wuowbbBoMLSVMuaN4
         7bpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782854807; x=1783459607;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fhhkZmKx754FpQG3LSpxtJ8DbK3S6BsACSSh6KRavYE=;
        b=VgYHzl0TpZlbSO41xcEdMHKid1OdLVGd9+Z7ysr6U1+OpOgm4+YPOXrh5dDIsRQlLo
         TKiaxblx6QjjF+Sp3z29wL8z+bEW2YSWJTnwgsNGjFdIjtGEe/g4UoNbdU4Sx0c4liAO
         K+RGC8gcZEzZLzdgv29q8RBPu02ENb5BKys9nYt2aYxi/FausTQ6jGm0j3RNwr2Dp3JE
         JAJSbBPdMFxiKDN1vNuLk8+OkttbhkgxTv5onrgsz5hvKJi4y0pTs9Xx3BlNzHjOOo6q
         EU+W4rWKCdxYXwjYtFhUKYcRIWAqzO0PUuMxanrNfH5piJI/NfwAdsQzSWq/xOe19srl
         3Kaw==
X-Gm-Message-State: AOJu0YwCyttumf1UM3VoweVzOOB35yQvnR51JOgpd4fYzOC+vvAjcF3g
	FzLvUmNVggE/XxC7dVH+WGhAiELTOXyS6PrL+SPktwWwJbUe4yqf0f3JFghnzqj/Yd4eGIQWNg9
	d4ZrFlOQYD6P/qAU1N4siqOJRGljlO53SBvpqfu/EFKPBv3P2IE8+M8O7PpRE2vUo1jM1CA==
X-Gm-Gg: AfdE7clbumQMIkaKjNJN7q/9NOs5QeaQG23NblpwCDQfEYG8sRGDeKDJiyRqDxnm9tX
	+RtpBfsrc8U6aDh8S6lnnJnM2dTueA2QMjq0y7zJ/oa3NeWUtCFplxt4ns7z+noFFMIn7NmilTE
	2Po+qOWO4Fyc28kmodhW7lI5A6tC3+WGN8maHIDdZPTNCkjZhYleAtrBZb6SdDLhalCXX1tRi56
	FWea3tQpzFFJsn6hR6G0D84TpZjjtctE8iUtttftqL2mlUAVCLj3DHOKuSDWXIDUVtGv/Ns9wGW
	HlCcBKQZXf1LvP6v95qJ4Iph246Sr2AP9bH1VsKWwqzWKh9v4zaKERtFcB4RC7mbRfCB5xTzRaR
	9mB5Am4Mbuksbw6wl4w6qs3GTKpXFKvoi7TJ6eRcOPdzBSKkz6lObgxJqcx/Ps3KGuQ==
X-Received: by 2002:a05:7300:508:b0:30c:5ebf:63c9 with SMTP id 5a478bee46e88-30ee12c2c20mr4448526eec.5.1782854807191;
        Tue, 30 Jun 2026 14:26:47 -0700 (PDT)
X-Received: by 2002:a05:7300:508:b0:30c:5ebf:63c9 with SMTP id 5a478bee46e88-30ee12c2c20mr4448491eec.5.1782854806639;
        Tue, 30 Jun 2026 14:26:46 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee300b286sm11604046eec.12.2026.06.30.14.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 14:26:43 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260616062342.4079796-1-aaradhana.sahu@oss.qualcomm.com>
References: <20260616062342.4079796-1-aaradhana.sahu@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v2] wifi: ath12k: correct monitor destination
 ring size
Message-Id: <178285480373.1590147.11222841690664583671.b4-ty@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:26:43 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIwOCBTYWx0ZWRfX/RyR2Nk+ep6c
 xsevEMdNqUKN3wHlQpkBK9Q8OgpSDBLNDTxE367aHRgRMT9NuGKJFu+liwc7tyhLlZax6byF8uu
 VdNh6WeQF93mM0q16As+LKOnsPmL3t4=
X-Authority-Analysis: v=2.4 cv=MpJiLWae c=1 sm=1 tr=0 ts=6a443497 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=WD2RVSGR4ZOmZR8fVjQA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: QhGmtke6-hhO2jTdkQSWW_j8R4MRTpAM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIwOCBTYWx0ZWRfX4t7Ikv/J9u+z
 cj02EpGVWAJnxaAcZM0nfBOqmQNEpHEwQGRQa42W3wSSokSX0X5Gh4Wd5UG5PQVrW8HqJssyzLq
 1qehZm4b+JPEeLV250uTN3d3WIYp2z8P73pCoA7ztiwt4N0EsiQQIHIngSjBuBGhJDv5fDL8O7i
 shOcmYo6BjPi0IBeUzAd94OHAvRmh1dykIb2at4UmKoBfLspHsqh2acnrcA1SqKQwx/y94JUDEw
 P8n+zdV7VHcXVjwUZqyv6t7YfP4PXsOetaPRPpHzEuf7PbIIRsqo5oBIaGODhHssOJs4bmateS1
 VvR6TG/sf/sRJWu9DiCjmFSGkCNMt6pK5jj3ywh/mhd8McwCzy+RRcg4usyQ4b+qKdm9STZw/AZ
 irZWCO+9TtDW3QOuIn/5o5XgwGUBjKvem6G5d70e2jciWP3CFx5i0mZ9Q7XmJfzKx0vo8GIycBF
 pSXDZSCqk6knq7rHITw==
X-Proofpoint-GUID: QhGmtke6-hhO2jTdkQSWW_j8R4MRTpAM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300208
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38418-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:aaradhana.sahu@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E36C06E8246


On Tue, 16 Jun 2026 11:53:42 +0530, Aaradhana Sahu wrote:
> The default memory profile configures rxdma_monitor_dst_ring_size as 8092,
> which is a typo. The intended value is 8192, consistent with all other ring
> sizes in the table being powers of two.
> 
> Correct the monitor destination ring size to 8192.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: correct monitor destination ring size
      commit: 913998f903fb1432c0046c33003db38a9e8bedb1

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


