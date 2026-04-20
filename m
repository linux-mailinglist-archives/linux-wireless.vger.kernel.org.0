Return-Path: <linux-wireless+bounces-35087-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKamMDda5mnGvAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35087-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 18:54:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8774430322
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 18:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 493FF339BB76
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 15:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDE631A80E;
	Mon, 20 Apr 2026 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VjDxrrDH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T8eRUrzP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74642E2F1F
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 15:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776698823; cv=none; b=sJ0c5FnDJLMYJgbBwwmh2tmSouGKnvULkbQEFJ613AuhWErvt/xG1bXMlA2ptVuoad/3h+dsABYOPn7LhROtBxyC7XE4PATvGFJYbRv90rXbeyEnKGctFU4IMABfO6TMBXglrhfp2FBNTJHQg3o9pZSEH1RR+Mh31GXi+9z9jdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776698823; c=relaxed/simple;
	bh=2xHJeBpRhl4dos1DDhLikWCcxAR8BOfUaouhTDCqB4k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LsbCFl8fBIJqpzPiTO/4RNYthsJvIXZEkwFRvq6PzWGTlwXuk6iWxwWePy20rtodrZKtA7GJ5glnL2ldKs5wAOy1Aq7GqZPJU220hliyodU5+QAcYfznX1lYzRUCo3vg1hKE2TBmR1hdeBPBEjVvyvQ4SK0Q2DmLlYoOZqhaHiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VjDxrrDH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T8eRUrzP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63KA4Ld82981436
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 15:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jVkE30hQ08LQ7R5FThqKLE6Uk75qf/KBDIHUXGckQOk=; b=VjDxrrDHpm8xRm/g
	aHz09UTuUfvgz6CzP0YR/A4f7uQeDJE3GIBjY9AUl6nfzxVQK8wSGvNSjIMP0XEK
	/qqKRBRLuORcS5LrneGnEgv95O9DWiyMbyI+xjujABS8yhGc0HQu2F5D+19qztLj
	j5I2teaRCFz963vrSlgGHKdKBobbUUzdq+oqmeyB0wmQjpDmpga/BtwbXpfdyBi0
	MuUE2ZhCYzaMzL34Ja6Ye6GNYQHU5ti93ZE65v6CRIgW/LEnAfOaBimpaV7zPQDh
	FpGGAaJ0k86VEz94CTLKH8QQIa0vy4tksr7WFb2G/LWnXEe8dmUxf9QZT4Uun+XQ
	aFWknQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnj2ps4v7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 15:27:01 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-12c726f4019so3551211c88.1
        for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 08:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776698820; x=1777303620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVkE30hQ08LQ7R5FThqKLE6Uk75qf/KBDIHUXGckQOk=;
        b=T8eRUrzP/cn5VW2lCD5t5vCa2sg8a6nyWVDisF9K5qkFu+485Jnw8tO1ag3cHPmObV
         bbSrYACLxaUMA4bNK51AgRouCBsCOvfyJBwyAKxuGdybMWyFBWY72wRhaBOSPMoVzR6x
         O61R7aoB7vX6UAFl9QCIgeWLzBA0e9KPgNewwEfa0cNDhY5ZdyvvcORFn/SF6QbAaMl2
         ykW5p8eX80mPAllseQyKCTnqRYkudXIMUM1w0hykXESVn3rwgrW5XUc93zkdSRHX5lLM
         g5ID1r8nXUKrqZsqzJUopfncdFztnyUxwKM0W4NCQFSt7foOCU2e/JCzVInlqivQT1lN
         tYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776698820; x=1777303620;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jVkE30hQ08LQ7R5FThqKLE6Uk75qf/KBDIHUXGckQOk=;
        b=g4Gf4inys4V/gSG7CTepbY3gHsk1Vsg1bzjOUouYT3geQGM4M3qU5YzqwPVwJfGl2E
         d+agProsomgdJ6atDMWr7T//V3AJWTA953MSJpP/txHD7gZK0ZKGHDHXy5RIAQNF3M9U
         zQrO2VnL5I2KOfciQz4QNgVbyYwg9XxzL8awF5YelbIuuKTWCH+8Ewv01ufbdZhUumzw
         dwXmtC3h9RfMPD3+7ciXCY5wRk2yiBczoSCT6zw+7ljkhLmhu9p6bq5hytFvRcXPEJNe
         ilGCrUCWYK/wOPpxl14qvKtAhD+saMSGdvJw9E5EVk5aU7TkGe1u90zsIMwmhAZGX4Fp
         JbOA==
X-Gm-Message-State: AOJu0YyQAhLGML4fldFYjtNITkIS7DiXe+OHQI/0LcsEUKWcNJb4lZEn
	ThtQqrqFyL4k5C46JzNvfai7KeFy38mUZBUuZScAFpM0RRN/6onEsnqH3jMKm6Wmj+kPjSLYRg6
	FM7WWx8iMpTwrHDOn9vhJ6UfpzDuZRvmJk/g93tdrxMf0h0tBwTg6uUR2zA5tx2ng/v9tC+5J09
	Ookw==
X-Gm-Gg: AeBDiesiVrBOlTKkAsm0vpbeODGx0XsVHczOCMchQoRR8bM1CfVQrTn0ScnsGA1PMKN
	BDS7CaqDHc0TPOx+6zY3WZt1XleP+AhqtV9EczogP2P0et/I+rdMFOTaQFlElycrlI8H0rDRN91
	otIL2PixJomVdXwjJ+4lmlIRv9MFcw/NPSybYmThwiivk9gmLan5f2epa/9tVV+C+nKGl5nlGqb
	BeLIwM3Kmu1Ai0S2+cm4FuuQhiyOnbe83rp/xVRCxvstcxSQsuu8J9I6XMcDSRWZeKUlALqcuJA
	LMzJWyc6TfOX5zVME7CeMTl/q/iK20mvyoxbJ6OdVh0MM74QgvJ0vNv3XWDhCMRLUjZrW/VNiBu
	S5gY046X/198UbTw9HuJ0W4OcPeSDyaFieiXEfr5LkHFFOlsX0xODyBkvnM2esqCTrF1+wLxgdq
	9MhQ8MAc2OVJ0=
X-Received: by 2002:a05:7022:2602:b0:128:d23d:81a2 with SMTP id a92af1059eb24-12c73f9ae5cmr6881008c88.29.1776698820243;
        Mon, 20 Apr 2026 08:27:00 -0700 (PDT)
X-Received: by 2002:a05:7022:2602:b0:128:d23d:81a2 with SMTP id a92af1059eb24-12c73f9ae5cmr6880978c88.29.1776698819448;
        Mon, 20 Apr 2026 08:26:59 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c770516f1sm13775671c88.7.2026.04.20.08.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 08:26:58 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260409-ath12k-htc-proto-v1-0-cda86d6355f1@oss.qualcomm.com>
References: <20260409-ath12k-htc-proto-v1-0-cda86d6355f1@oss.qualcomm.com>
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: Consistently name struct
 ath12k_base pointers
Message-Id: <177669881838.2486446.3805599461059578232.b4-ty@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 08:26:58 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: Xa3ozVZxsqD97u1bhPFQ9KxKhR3-nUnk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE1MSBTYWx0ZWRfX8ps/cygBsq5u
 ZymWp1PueVdSrDsk4gZG/CpuKCi39GJ9CydfMWm5Rd6sskpSDpJlgYY/I35wPNABVlGadCqvj+Z
 cbTnq4WL9480OnlE8Tx9f/ie4/LXWuuK0nO6r//u6Xv5ZNdCeEmLswM72sBKcHqZvTyeIjmP6WE
 /5P7f3KoYnojkj3RCny/RG3ralwi3zHsxnCjHk5SisE1Wh6/k6FCw5Hk0GqxDkimijn1MPFaQnM
 L9r8flec4ksrCuA7MaKUAAhrd2ZrwozzZeCw3isC0aMu6p2NOSuq9XaKEpol9GBz0A9Yjl2oOxd
 7uSPH8e4QTJUvhZccPMGV99G5eso/sv1wLq2H5hcWGo5e95+BAcJRrnjStO2VI9RvicZ8Xu8Oge
 Xt0559PSR7+D6WKIVArjW8BNtLPV5+XJ6/fNXlRzXfTQEpzgfImct1/rXWldLDpyvgFHIcZtRg1
 Qsy0/Gm7hTrn2+NmGbg==
X-Authority-Analysis: v=2.4 cv=XMoAjwhE c=1 sm=1 tr=0 ts=69e645c6 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=bC-a23v3AAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=UDxKe0bwUzp4W916UMsA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: Xa3ozVZxsqD97u1bhPFQ9KxKhR3-nUnk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200151
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
	TAGGED_FROM(0.00)[bounces-35087-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
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
X-Rspamd-Queue-Id: C8774430322
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Thu, 09 Apr 2026 11:44:22 -0700, Jeff Johnson wrote:
> Per ath12k convention, a pointer to struct ath12k_base should be named
> 'ab', but there are a few places it is named 'ar', so fix them.
> 
> Note that one instance in ath12k_wmi_tlv_parse() is not modified since
> that instance is being removed as part of:
> 
> https://patch.msgid.link/20260407095426.3285574-1-nico.escande@gmail.com/
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: Fix HTC prototype ath12k_base parameters
      commit: a49300ad9796e59f2eb740c608ccaf6b1621a6bd
[2/2] wifi: ath12k: Fix ath12k_dp_htt_tlv_iter()'s iter() signature
      commit: 90ef329e73c673e4e3ea66226bb1d8fe3acf45a5

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


