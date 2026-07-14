Return-Path: <linux-wireless+bounces-39101-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mBfDAyR7Vmpx6wAAu9opvQ
	(envelope-from <linux-wireless+bounces-39101-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 20:08:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA5C757BC6
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 20:08:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=QrRIBmny;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=OupLOGi0;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39101-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39101-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E6723036D5E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 18:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E5B3FF1DC;
	Tue, 14 Jul 2026 18:07:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3801132ED54
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:07:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052473; cv=none; b=LO1WDnPaVaal5SqKxNK2K27fySLlt6l/2GjwX6r/brMMY+ZyXJRP5bgM2vaU/D9LBjOBFqs0Zn6losLaO/FUVZyhJaAF/ctAlX5WoKrV0cp18zOU7TgOESf9BuBNLZ4BUU00R7DJXR0pEUnreD4wZwN20p9MuRucxO/8dDCx6Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052473; c=relaxed/simple;
	bh=oz8XjhSr/i2+2svDva93Qd1bDph0xW9KiXCcn4BDpSY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JhuRRNhvu7S3dTV2rBb6yAlRsj8EykmmM5ehq1Pcs8v2lJ9CA8hqfsRmp/EOpRoWBNy0b6DmsAHjiqZNqyFsBlOKE8uIVlNbr/rgCR44wIb+ya85njJBTzZGlGG0LfNQmaGXNYB5Q69QKjHXplyA+VhPZrMGwXXeeQlqm8rKSn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QrRIBmny; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OupLOGi0; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EG6pOh1097192
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:07:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g2UhV5ZG27BTbav84ggIuCwnmDvPXOmTrYziV6NoH20=; b=QrRIBmnyfd+QA+dL
	iCs5X6F4vCxINPpok3lWjFHt4js1g3Fu1Llp0O0aJLTk/7ZnOpX+DAUm/ehli91a
	6KJVqFA3M4UN3PQGYWzwBuqgBbwYegCBzL1hbJ7tPQV8Fkaaa3Y6NeeTx55vwl7K
	Sz4kNE2zWBBnFSJOZZ+YhQ9Vji2FoCHEp+pvRvXURTedKfgRDgLIEWmeyMrOLG9q
	wpJA8LnboxxznazXnQl2LGIEaGfVrprnFLqXWwgrDjjr/ZuIF7RcT34x13eDqAVC
	OAn6DhIKKCzRD98n5Z0HvUTQ5SJPxBmT5aduHYKqarcPoCecOJlIIOM6fAr3d0z6
	+AtgKQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnnqs9jp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:07:51 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e538afe65so507622085a.3
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 11:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784052470; x=1784657270; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g2UhV5ZG27BTbav84ggIuCwnmDvPXOmTrYziV6NoH20=;
        b=OupLOGi0xhK43WNO7WPySNvxB5o2zZEBjKnAWVO9cYKTyPSzki1VhX2TTnVu29FgB7
         pWiklOPikZOfzl0KeqLLNgz/BH+ex/MoYXm6302srCWgcWnLTugdpmsiYUmSxrPqHolY
         vzv184khDMmlfJlqHVD3Q0pFMSZRCGEjxktXM6XdBuxVtl+4n1uzy3eiBSW4X4TBUoXl
         juopHTZXxvvQ42U/gUzOa7J6fHMEZiB5ILpcwRD8QlVc0oVeR94wbzkkHq2M45ys53GN
         o6X8Y7hMSpoW0NqGoyZVa49uMDwosN/SjW7fEbUjjaPsamhyNmRUTbxJkAiJ/2NtGkt6
         FH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784052470; x=1784657270;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g2UhV5ZG27BTbav84ggIuCwnmDvPXOmTrYziV6NoH20=;
        b=Ly49byPLlTtw8CIRbsA4mc6e0hZekNhxevJ3Bw2if87FhVySBzOkNqIhJw/RcRsemg
         aGdgk4euL6hxaYEUlpDMJjJoShHjPfmBubbbIu7YOhas/dvKMJJk9BXAenTpkucB1bzl
         nl+dbI5X7F6SpkkkoSeO33UDM1eHzUj9iKS7lXiD+TQlLKyOh6vTMAaGQL7Ef4M2gyS9
         7JgfoDiyIZlCYCrVzA+w2kJ7TG7lOG9SySQWLjhxB6OberQBNkXFeCaFqqmuGxcUK92M
         zXoAaEav/hIEI90/HxDY9Ax+3thnCuOzBpDkXptzyMEodiBuirtpBIFlLt8sCcBSxc91
         CD+Q==
X-Gm-Message-State: AOJu0YwMPzXSv9ZF8b4IcV9Pe8cThwHjBmKbUrSoZikZ7PJBwcphPBh4
	0Ix/esvlG7esqOVCTxcjMT/IZ6HJPpr3efm0r/nW/po+g9XxbjVLYvIPEwtYBmusjsr8pWDS03x
	i2x+ilQfnW8dDgUYuCJHadXj0yq9HQWRkKINbkakxEKaFq/C7cCqo4kVL8WLqimzsuhPLJdemOG
	85qg==
X-Gm-Gg: AfdE7ck4riL4b5CA2Gz9rqm4OmUKYoRYGAias66Ur3uGUJWMeTqpQVsjICDZlDmMxAJ
	bj/9+FUIKkbpri6T4gVhDc7ipndghywqsdAWE6EQDo+JPbmiiWCOOX56k2K6yyQMdw21Zp9jo97
	AuFcFaq7dUrJ13E/q0vIJRWp9EHzb+DCtej5YQseD/hK+q8dxu5poegbQjk7K90bW3mhbsQx4pp
	1N4M9y3p84LURQK2lr92Sb++9qjYebwP8o2WrjlPHZ6c39UI31qZScgDx4HvvfphvoUmkInGatK
	6r2D1gnXtQKWKF7Rov8p4m31UQ45KzgUHS2+/NfEB+CBwsHHnCJDixZzb/wjtT9AJNj1J0zsnDR
	wwBkv9cNrQLlUAgDfu+UEBIDzYcAz7nwLt6/HWebT7s1RH9f8o05JLz9Tbnao7innqw==
X-Received: by 2002:a05:620a:6019:b0:92e:fe59:d619 with SMTP id af79cd13be357-930868321f2mr320335485a.10.1784052470384;
        Tue, 14 Jul 2026 11:07:50 -0700 (PDT)
X-Received: by 2002:a05:620a:6019:b0:92e:fe59:d619 with SMTP id af79cd13be357-930868321f2mr320330285a.10.1784052469882;
        Tue, 14 Jul 2026 11:07:49 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930759c63fbsm465448885a.22.2026.07.14.11.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:07:49 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260711-ath12k_wifi7_mac_op_tx-line-length-v1-1-10e4899b98ef@oss.qualcomm.com>
References: <20260711-ath12k_wifi7_mac_op_tx-line-length-v1-1-10e4899b98ef@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix ath12k_wifi7_mac_op_tx()
 style issues
Message-Id: <178405246855.4102418.571192529778728385.b4-ty@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 11:07:48 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE4NyBTYWx0ZWRfXxeTgcG9fXuHb
 d/4ssWzT4LmaqNkGa62FZWBiaCl7fcl81QjGZJfvjhEkZ4QezXEYsVZcSVM16b3blLl2VHnWru8
 wRzdX8Mw1aXJ5DhEKIp0vo/XOP3nmIP2kBzmR7jNu1sUwb4PIZHnTQkZW/7sm0BHHFY9sFG2BNy
 VsUMqbdqMtMZFCaYQMRBno/9aFlvbMl90UTqJGuQ6InXOWolm0B1zIaARUabkLKNQCHLW9VfJgC
 Y09bPmBJL9dRPCyLTEntf3uxDgYolytaNszVycWu6YLlfm6TyJ44k/HrCh7seiBjLMEj/rIlwDo
 mnVYnaQKDgBFfQovEDg5NFacmtY3vkHn7yMnFXg8lr/2J+L/94hZGWlx+ceaGnPbPsqJT7V95hM
 1H/KB86yaiZejVQ4xh8NvnkXmKgRDA3Ihtg9BEOoP5VxpKPKP5YheMpXGedw8xEHiov7OfreJpA
 ShL92h7zTe3MAS+TUgg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE4NyBTYWx0ZWRfXwaGUIuJ94eEo
 rLPad2jtIsZI/QfK+cMBPeBlAXu6FmfQ+M3SSEyA4zXZDJhNqtSHjjVQ6c1ytFiYAZjphvAoKlX
 SJ95FCZgWJkpOzuYh38Eq2Rm8F/E8aM=
X-Authority-Analysis: v=2.4 cv=U+Oiy+ru c=1 sm=1 tr=0 ts=6a567af7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=ciNmkqmFweInwRYSI6gA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: cvhttWMlXhxhmlI9QEvkeyc_TlgMdUJz
X-Proofpoint-ORIG-GUID: cvhttWMlXhxhmlI9QEvkeyc_TlgMdUJz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140187
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-39101-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:jeff.johnson@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9AA5C757BC6


On Sat, 11 Jul 2026 08:31:10 -0700, Jeff Johnson wrote:
> Commit e47d6c9bb416 ("wifi: ath12k: Advertise multicast Ethernet
> encapsulation offload support") introduced a few style issues.
> 
> ath12k-check reports:
> drivers/net/wireless/ath/ath12k/wifi7/hw.c:1042: line length of 92 exceeds 90 columns
> 
> And automated review did not like one if/else that did not use braces
> for a single statement that also included a block comment.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Fix ath12k_wifi7_mac_op_tx() style issues
      commit: 6385fd09a399805e82e50b228f1af318316aaeb0

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


