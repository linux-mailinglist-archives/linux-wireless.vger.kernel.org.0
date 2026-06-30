Return-Path: <linux-wireless+bounces-38417-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PbKRKLY0RGohqgoAu9opvQ
	(envelope-from <linux-wireless+bounces-38417-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:27:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A5F6E8242
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:27:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Hc7NPkJN;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=ZZFaU4w4;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38417-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38417-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53EE0304D9EB
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 21:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2062EEE9B;
	Tue, 30 Jun 2026 21:26:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD07130FC23
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854806; cv=none; b=rA3ggbNvTNfcW3POCD7aAkebx1WqKizOA5t5Au8trRm5LQP06nlw8JMRSk/jgmQfotu8RdIlTxdI2YU4/ZzCUxIklpLHi7AEYKy2DRlBhe3WnKSCkOwM/F7en7X30NAjYFr9neGnD7TvDZM0tbgfZjkur///i2nRQ0JvZ5WrZbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854806; c=relaxed/simple;
	bh=bDO6v6kBBjVfhYyNfeyFw7Bmq2jkn3Etba30tUeC3J4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kQngHZ6vuUlXfIUHma2JYHjorebAI5DQuiPBtutuY6RX7bz/gZpCgisiug3/hs40ehP8qmE1TeyEWKpDoH+6dW9CNJEqTsV++GJyLq7g46nrsjEGNGqVqo9qzm+QUclfjmUP6R3xOVzcJNhBogZ7d5A0EcbTU8VMzdPafHcs7Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hc7NPkJN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZZFaU4w4; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJDgN82960018
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z+mwtC1L5sg6q+kGYSALMcZvqv0AV+JnPkL9QpIhxjE=; b=Hc7NPkJNW/2U/6J6
	EjXBgA1FYkTJttsFdzZbZgmJMdSQfklaQZYlfK7rpDzT9j0U0tXXMDIa6+M0YZ/M
	eSYL2k+yGYeItWrCX4U2t++HGvmzwK3d6P7rBnbp4RpV0q4e0UkNdQVW5eUxM0Yw
	cN41oDP8faINJZnZ2c4LyfQ7r40FWhlQIuIKtghHdMFot9Nn6LC+vVqV+ZbutrbM
	UFNqinoxJJf/A9yYb9D+v0o3SFNWFBOa5HAT+g532m+YJ3M+hybZcTyqvx5PLScL
	sJv/ymSQAHJOwu4er5hoFx8YmlMUtverBkN/UIq34vlP60JfT7VAKmrKkIwJqfa+
	ud8EEg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4j911021-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:44 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c1f6c5559so244902eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 14:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782854804; x=1783459604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+mwtC1L5sg6q+kGYSALMcZvqv0AV+JnPkL9QpIhxjE=;
        b=ZZFaU4w4DfsC1RUsXe2/dHlXq6AWQHgD36nDBNr2xSLeQ8ZoBObHyIeZDeGhWzO4LY
         +7PGvT5+seuGXfmOMyx3Y0bE7GZRxR6q5O7VzLrzZ/VWmccrNpxqWdCPglaCSgpgn6Lo
         Jeq9kyi3or0g1ycJHET8NyzCdSxqdxabaG0JJxpm+2Ad81/ZYKMZq2rMvd2uUaKWLz8f
         Ksx7zVE86BatTAlUStouJ06XxAeLCX5cIVpXrPe6TnHGZJtHmW3hsOoJjkmxnnkVhq87
         zVfKh7l+qnwntOerlDB1JAlGnImTOln1qrTSmQEuadm0WAUmlTBzJ6sj8mlicOv/hHY1
         AOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782854804; x=1783459604;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z+mwtC1L5sg6q+kGYSALMcZvqv0AV+JnPkL9QpIhxjE=;
        b=QO614PVOtuAahLu3pcIIsHJQuBJ+LjsxLZARvsHX8MrcM3KgO3J+Dl9fkXTYT4y1Kc
         Zi4rRfnpL87+cGms/HsTbDslGVk0Gnvj4VvDEXO6DbUDtWT+R+ltQ8CnBotoCdVBMnNc
         arqgOunRqyhjuBvULRuJZRx0wfyRuSg0SkpgihOtUKo1L19eNW/p7IPaPGcE/OVVbQUN
         KSeWRzmyI8nZ2XOOt2nf8YKIsBzt3X4KEsl6tFtRgEWG7z4s0LC9RDd3QBv0jIIFwGNS
         GDYvHtwJGB55qGlSaGTApe21wlpK60JaZDZDgvQaq9OQH+yQT4L66t+GqSvhUD3VnlQm
         A9bg==
X-Gm-Message-State: AOJu0Yzm/mjQ+tiafpcV6nJsLDBUyIISAC61c3I80rIKZxPdHnMKq6+b
	P4P/j/kdAeU+Q6VGBNXK3H6Af9OxFElGabQKb7x80FU0HsHcBXZK818bv4YzPRzFb01vuuEXZem
	1qokl/iuZAha6atgHzjrM3YRMtovRfWVEGCMMTXLrVMpKFxdfI3MXVIJmUkdEmcuRonScTg==
X-Gm-Gg: AfdE7clFr7Y7nYNF1BypeMu229mR1MYnGhLoHuVCkO9Q0AXtce9XEdrutoaRGvn2G6b
	3aQHQ9Xp2fdws2sUOzSWDDYfQw2l4coSCR6DD4D9vJxT1eEgG5/8EQpHJdV/hFTGZESfSsh8+T2
	Dj7PO3m9L8x8KZz4usc8Yv8A+jM/zB9sJ2el9Bg5kZrGqlh+ITGzWtbbGMfNZNGvRpbaVvYhWEU
	iUPE95CA/8YgQVNyFGUPMz4Srbyh/lfExb7D9ZkA+L+EmG4LbgOL8ggsS/VO+ntVEt62GK+Wr+E
	wvUik0VT0C69tOIDJsH2WhJYlsVKuhyxh/BLToN/0u5uFKedL1F256Ifyw9IRrxVXbRvkSRO+/e
	jZrGYEdMmrxDWEv5eNVAc0tD/EbL7W8U/Kxaa3VIfzI806ML2Z/H2aWAqBJVsI3njaQ==
X-Received: by 2002:a05:7300:6405:b0:30e:ec9b:7c52 with SMTP id 5a478bee46e88-30ef0a3f2f8mr1789508eec.40.1782854804099;
        Tue, 30 Jun 2026 14:26:44 -0700 (PDT)
X-Received: by 2002:a05:7300:6405:b0:30e:ec9b:7c52 with SMTP id 5a478bee46e88-30ef0a3f2f8mr1789483eec.40.1782854803563;
        Tue, 30 Jun 2026 14:26:43 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee300b286sm11604046eec.12.2026.06.30.14.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 14:26:42 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Yingying Tang <yingying.tang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, yintang@qti.qualcomm.com
In-Reply-To: <20260610031358.2043716-1-yingying.tang@oss.qualcomm.com>
References: <20260610031358.2043716-1-yingying.tang@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: change MAC buffer ring size to
 4096
Message-Id: <178285480233.1590147.16424453054668146902.b4-ty@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:26:42 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: 04bRQdNCti9a3XRwsoA7nMsnN7DpuCn5
X-Authority-Analysis: v=2.4 cv=ftfsol4f c=1 sm=1 tr=0 ts=6a443494 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=7Sa7iVnaTNRCtE9djW8A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: 04bRQdNCti9a3XRwsoA7nMsnN7DpuCn5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIwOCBTYWx0ZWRfX/0QPEJ/OuAsQ
 c7Igxe097L5mWbk/fvzJbuQ2mJr4RaBR+ZoPT4y+ixIN485RedFc2kNmUs2k9dPORU35owbIOsh
 lv5gX0N6vxb8TFYOqwlcg1vcacFu/+QI0WtX/LphRin7eVPvR/poeynRzURMEGL/wV1BR1bRIH3
 QUuknMXe2ADFflLIH3OaJPwgN6PTHGGR1eINnR0QPyGsyYwmd7YzQptvxCwJUfUAqz6GjlcWiao
 8RMjdssgjDTCSFsY9S+6FyWG2RJ3K8MUsuIugMn6Cwb7hLvB43PeImrcc3AZRH6UEc3z6a2G0iX
 TulBVw9wCTtvyPOdsyMHY5zHfoJj+NTzv6XDSXRClOM5ozd8W34JTQcMjCnnX4dNTtlj2fkxiXN
 NEpPdwRAwTjGph9OBnuADBNl/GPULE/xuVQsfdcaZyoA0pjrDJ6Oo/Hekj42cUkLzWz8IU+yVwK
 8OQmZq2sipDlPybD/uw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIwOCBTYWx0ZWRfX90CeRLcNGNZZ
 fZaO35/j5TYQpsD3fbbkOYgBbJNpy9T6I65AhgNnllBaNNCcFqrNCC/VkBrx6gVlaO0y8NA2vnm
 L5+IfY+shuenWgTkbn9s+8FRP3aC44U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300208
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
	TAGGED_FROM(0.00)[bounces-38417-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:yingying.tang@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:yintang@qti.qualcomm.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp];
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
X-Rspamd-Queue-Id: 10A5F6E8242


On Tue, 09 Jun 2026 20:13:58 -0700, Yingying Tang wrote:
> For WCN7850, MAC buffer ring size is updated to 2048 in
> 955df16f2a4c3 ("wifi: ath12k: change MAC buffer ring size to 2048")
> to increase peak throughput.
> 
> But during the RX process, a phenomenon can still be observed where
> the throughput drops by about 30% from its peak value and then recovers,
> and this behavior repeats during RX.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: change MAC buffer ring size to 4096
      commit: 58aeb412495ada7fe5495c7805504d7cf1d45453

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


