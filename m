Return-Path: <linux-wireless+bounces-38415-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bV66FKA0RGoWqgoAu9opvQ
	(envelope-from <linux-wireless+bounces-38415-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:26:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 407FF6E822C
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:26:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=MujD+blh;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="NwyG/wyT";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38415-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38415-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A728301425E
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 21:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B070319C553;
	Tue, 30 Jun 2026 21:26:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B88231E828
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854800; cv=none; b=Kqg/ep8nNYgNGDuJeidl9ccxjDJP2nBaYU+PLvKrH/H2w7nKk4Cj49w08pcKbuRiiuZ1A43u9NDJ9NWeltTjD1W7iRooIlc7nnjm8uKWiOzAMnvtZKuqXxeHffz8qh1tp4cDRJuNQRQX4QAM2AjFBpHv6OFGeRNbLR9pbi4DCck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854800; c=relaxed/simple;
	bh=uKExztDrpAHEOlbmVHhgH8Uqqj9dIg7eBZNI+h+7Xs8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V+AUCJNoD+eli9+5mphtxp3oWxpZ01ywnmX26nSP8DA8Qf3fEfU1R6kxZ062MC3GovNoyoWoOhJ8CTEiRa04hTub1pIxoUp5+JqBRTxu9hAh7a7z3I0D5InoLeYlWSnA1msgMKIh3azuqctUh6d3wUOG55GNmv9Zf7/S6qF/Mnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MujD+blh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NwyG/wyT; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJDaPK2959908
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rxdOapeK2oSE6MJEqB86TqeHAJ0J8t/rbn9FyMtb9YY=; b=MujD+blhx5934ck4
	ZbekEeJTgiXIbzVt8MZqkQ0bmoWIaKLTUxGr61Xl6iaa7zMyOYgZI9nDfLkf3ZJU
	ssTgFI/kkZKvngyjddqc92ztOsXleYYADFgMvc0bCDI16aZ8oB12C8osEwdlD8Rl
	KEWp9WaHGwX/VII0xQV8nTmI+LHTxEdzkKZbMcqL1YzGilzTM/KKDARgJyokNQGH
	x79dsCC+ruAbbfvKkUc/Pkqnb5B+rXbLEO+QeqUrs9RBiEjINzOithccDAyb81oU
	srrnYK639qChb0NF6P0Mkj4H8t1okBl19WsMhu6kyuVzq04wSL6Fswy/QXxcfc/v
	R2/7xA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4j911017-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:38 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30ed9113e03so404957eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 14:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782854798; x=1783459598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxdOapeK2oSE6MJEqB86TqeHAJ0J8t/rbn9FyMtb9YY=;
        b=NwyG/wyTHfkLzh8sGraeclk0TPmD86Zl/7tzpDd3W8RMtXWmu5FkezB8N4ODXVX9RY
         SNsaCuaIbLnpP8MY/nDM+eHObgOzSArMh7rxr7vi0cp77kTqI99YS25hSXtoDW8RymhR
         Nl0BGbuB/OZRTWPNRcS1H38oj8ANZmGp+XZAoArlzpOaXFgWD98dVIBfNHGVfiakRP1j
         2yfihjMcVpiYXrtpLAqtzK0m7oixSKt6wf0I+/jhPBCdm68fqO115M2xegPKeX25509P
         2CWEJvtycAnWFjOcQS0j3XAMV1CWqaISpk81e+yIA7trLrlADoaSzkbWpGQlwUoCEpbj
         l+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782854798; x=1783459598;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rxdOapeK2oSE6MJEqB86TqeHAJ0J8t/rbn9FyMtb9YY=;
        b=oCetWbTcKrgX5vHY8TZCT22jG6Lov6tj/d15Kz4k5ni63re5b1BUclVfibsMdgMdTl
         41+ABWMsihyh8qedbgtAwnB4DDdIcMYwtJbUiBZJpOhmd/fwvZuaSfYevSynu7iOqL3O
         uiA5viQorOZ4Kq0kEfL8J9VWmOLSH5S5f5rUmEGuKG+fLbQbTokcuO3kmInM5XALyHuA
         wtKUrZnRGTGysz6xJCB8p9pVzv0XbRmcYRmRXqDsg4kJyDH9gbRh07XQJFeakdCM0PBf
         nxjSwP6aF7Z6RVk+8UWkkbd+WtKRRlatOMlDf0SPP+PuSTt0PEO51UMO9hgMbkjQuNJl
         VyZg==
X-Gm-Message-State: AOJu0YwWOQyVDTrfSYkEG28ZIvbbzETBUl8eOB7wF5AKBE/GcgRMAgYU
	rhxV/IrrU6pC4o2T1vGlIJD88QQMvv9lJltdWCXn6KurZ+keePqq7mrtfm2e8S9WkxDr7/ZqHKI
	vteRstU832dF/ep1aQQJfDrq/WIjm9z4E2/nhHoIIsPCJ20QS4wrMDo+lHxSRZgs/2Ws/jQ==
X-Gm-Gg: AfdE7cm1n2czhsumJtgylqQ7jmFPdzc67eu83U2SA0IgzhEcnfYJe1yZ7vhs6dZxvJi
	crVtN7js+P/3S+3fB13zI6KQSkMmyQ6k+6179BDlhhEK69cjgaR6gvTb8plMDPXQw979mC4D/KW
	ScAFl5zk6gJvyeF+qglDft1emAIelbjNinXXqEUqfFvL3x5CtgEaGQnhMpo5uAh/nmx8XlYlsNK
	W4nmjwKJal22TQ8bCVbf2dCUxLRrFUP1eVyhsrqgVG27oQ+kiej/Sk6D3lzJQJrTRR7VMkalfe9
	9z+s25csvVll33od/wF73V0qr7yIXuOpMEYgU81mRkFKCedOHF4noYVW8JUy92DXV07o+wQDC4L
	mETtsj4R0zZFhM2OGfaIBmVMosO18k5ytoJ9BA0Y4OV8uKlgxumdRUSAy4HDwgfD8aA==
X-Received: by 2002:a05:693c:3b04:b0:30e:d66a:3faa with SMTP id 5a478bee46e88-30eea052cdfmr2955741eec.15.1782854798210;
        Tue, 30 Jun 2026 14:26:38 -0700 (PDT)
X-Received: by 2002:a05:693c:3b04:b0:30e:d66a:3faa with SMTP id 5a478bee46e88-30eea052cdfmr2955707eec.15.1782854797631;
        Tue, 30 Jun 2026 14:26:37 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee300b286sm11604046eec.12.2026.06.30.14.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 14:26:36 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Sreeramya Soratkal <sreeramya.soratkal@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260626085253.3927269-1-sreeramya.soratkal@oss.qualcomm.com>
References: <20260626085253.3927269-1-sreeramya.soratkal@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v2 0/3] wifi: ath12k: Improve dp stats
Message-Id: <178285479654.1590147.18252994064135945641.b4-ty@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:26:36 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: UfyX4YQZbgiVhE-G1UL2CuphIR7WrU22
X-Authority-Analysis: v=2.4 cv=ftfsol4f c=1 sm=1 tr=0 ts=6a44348e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=f7Uf0HdN2HKWEhv83DoA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: UfyX4YQZbgiVhE-G1UL2CuphIR7WrU22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIwOCBTYWx0ZWRfX0hAlApLaekHY
 KP6CtCWoa2x3+6mafhcaJWX1YaIiCJf3/dqGseAVx2XGN4uhOShZvI8OtkF7ieXApGghHhBLFno
 9wx7fvP7jvA69fpGw++ZVSowmrWK58F7ybZwMbmISjTa7ZM1ep8UGFwLVq6xJgI+zA1dJ+h60ft
 WzxilkQv/JDnOtHmWEeL++lT0uFFQMmmxCiKVQlX8BTqiLrtXZx/CnwSyqHRMaEWa+OHCakEYuT
 RW5PSLkKE70Aby1gKPK75BmjVzSK5uFlG4qqnCn+yB2wlke3iCPjrB8J59FPYd6Ip0mFnXA+B9F
 GBmbfWDB1V9h8WZni5zFX5HNeS7y/qas0MjusDWoPbYSvTcXikgKoqMmuALS1vpY49QMwjipzCb
 AR6zcGJi4jg7S1bb6CKJnL3t38gIQXwAFs3HsHuxF4JuccOtH7nYUhFoPsMwquFQ4pM81sjlQHW
 I9n+Lvh0zA810SoBKFQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIwOCBTYWx0ZWRfX1BSpVnizhMRY
 DBXqrZhznGWQtICqyy2u33OUFiWJBLSgKALz4qzmSMx90L7yCwiPBGPykHTid/4XDg4qwKKTsOA
 hzNo+VQbuvk4BlRuezQidNwCdg+YuYk=
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38415-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:sreeramya.soratkal@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 407FF6E822C


On Fri, 26 Jun 2026 14:22:50 +0530, Sreeramya Soratkal wrote:
> This short series improves the device_dp_stats debugfs interface in
> ath12k to produce more useful and accurate diagnostic output in MLO
> configurations.
> 
> Patch 1 fixes a latent correctness issue where the REO Rx and WBM
> release error tables were unconditionally printed for
> ATH12K_MAX_DEVICES columns showing zero-filled entries for device
> slots that have no hardware. Replacing the compile-time constant
> with the runtime device count keeps the output compact and correct.
> 
> [...]

Applied, thanks!

[1/3] wifi: ath12k: Use runtime device count in dp stats display
      commit: 34620d1890cc1fcf87a95219d6781d7f7b9d8cbd
[2/3] wifi: ath12k: Add timestamp to dp stats display
      commit: 6cc84fce7b999b0c6c8aaccdfa8669f0a55e8586
[3/3] wifi: ath12k: Show per-radio center freq in dp stats
      commit: b1d8d626e206a757b745af2adcbc7127ec593a20

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


