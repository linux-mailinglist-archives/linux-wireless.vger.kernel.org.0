Return-Path: <linux-wireless+bounces-37275-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMKmHVO8HWo/dQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37275-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 19:07:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE30623069
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 19:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DA9830AB734
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 17:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEFA3DBD63;
	Mon,  1 Jun 2026 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nh35qXoL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jcZ8Gm8L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294F53DC4D9
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 17:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780333240; cv=none; b=Kn0u0F5aKouaY5+GAIDT8ClsF08FFkcr+OG+Jt8H29XdfWNFho2knKolpzIGf14hcGWG63+LFuBtr+KzwhmfoH5iDEn4uWAUNOlD8e+SMq8YSXdtkwP4aY5pl3zAVIq/voPFkvPkmZqWUoRFL17tTXIC4nXbxl29t+Oa02ByZ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780333240; c=relaxed/simple;
	bh=agPLr+pMkRueaYDal253diAbHAVOOD/YLUw8aUXjXy8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=imj3gKQMRdhsmIRnhKn2JvNYplLWifvyg7sMOwZjMN2rsEtS1k9hhPyoY6cVbJ69yHr1haFKgyqK+xYvnUlbH6to+sg5b4yCqoea421a0TeI03ZhbY0PfkznT9TTdMgzY5Ml2W1AEEBrzE20YMTOUVZM1Y9JHrXpuFXFM3kH4vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nh35qXoL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jcZ8Gm8L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651F2E5w144956
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 17:00:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8RRsCzDAhUlLG8Muqh83L7tWWVDFU94FMZM+R5qrMjQ=; b=Nh35qXoLEeGRRo5W
	g6xJZ6e2tKBlDmWUXUDSgqyQJOxDoMMV80lmD6v5gm1j8hh45VLPw4c6nd+5hroD
	YJ+Do2me+soHVwdwxPb/69jVOoHkV6v/GEhHuuy9e+beGZnJLVDQiB9UAOfIAJzu
	vFBwDxOKF2sx5UvOTtckG2tKYloYh4+YsXRJCR50ZbRtMVKYLIQ1oWb4eSp2nc/y
	i2H3vFkm6dhLI0SlrWQBcW6jzfuhHAWd7SKJ4ouFbyTzX1a7Tiic56lGkGhVOI0t
	gA92dEiBC3r0HUEYIxWT0a45nraU16/vNASVSAKuGRBAWDug+ShcU225DslRUR1R
	wPnmnQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6stt1ep-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 17:00:35 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-304c652be4eso3395074eec.1
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 10:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780333235; x=1780938035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RRsCzDAhUlLG8Muqh83L7tWWVDFU94FMZM+R5qrMjQ=;
        b=jcZ8Gm8Ln10tKppXSoTNoIxk/erhtT4/d419pra/xx7q76ZxVJsIFMt/Ot5ppWcy8c
         YYTCBeF/0itQhkX/XCji2BUEttRgqdyGnNFtFnsmZJ1QwCVNwwEgiUy0RI5i1ryu961D
         TMyVU/GpucIcGpolVIVJ48nnz7ZWEFSwH8rpdNB86kil42Ec/V7YoeGOCPGB6wSsgOE2
         gvtisobGGRNPRpvSM4U6lzlHSz4TDrbAKi4/sz0v+E2uqn0sqQ/4qyqe9eujxzczNJ/Y
         oxzW6e+2ig5JW+4hw6dP/Cymfna1eVa92uLT5rcOXyO4WLelxo1CM2JLRUGwnqfGNxC3
         hMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780333235; x=1780938035;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8RRsCzDAhUlLG8Muqh83L7tWWVDFU94FMZM+R5qrMjQ=;
        b=smi0zqu7AjRDaWeQl5xDzd1dgP/NAzb+qYi+YSfA61KtzruBClZwqFfvRHPs/IYcB3
         iSAKl7MxbKi6w1nffxe0V8gTZpa+hBNyKevsXe9lLZUbjO510eRRkZX1SiJK395pTXWe
         Epi2Rq/2dtG9xL5NleGV6kugbG/QZoNWvGMFnBUVoWdZyNd2dUnkEQTmJwPbE4CmmlHw
         AXR7J2Exvkyzr4K10cb3Gi/CUlKcqnfE1p8dqCGvjpy9zHAtvYaoG4VAcGRyaxMxqLmz
         9lJcgXKLgwmMzoz/jNAasEOirhCTS60Hwe5Odr+nW+49ZT6cJUQwsp+9fJRjx7Vsoqb9
         RuPw==
X-Forwarded-Encrypted: i=1; AFNElJ+IN/chmpM+2dds1Kw/DkfSPrUBhqwJUtlrShRS+kebLOAGV6LDys0mMmIPLdr7rlQaKeMwWw1tYzOZtCzLRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxijhc1MT1aT5ESgSBCRb139JlnYq4F2R3d1pCvplI7JOxF6L0x
	Vkke64qWjyMFCg6G6DQDlo1zf37rZXak/zLy06cwyuG942d1jOncV4DajCbO7JUJ5NJ/eY9rZVC
	bdHZzB/4dV39PXoHh+OGCej8BxhnUC8u8yM058UuYBgpe6dIuUg/YlB/IBXB+wM4Di07O1A==
X-Gm-Gg: Acq92OFnmeX5WU9xLGSRpTPQADdXpicLxLhiTmkql2NjeHK1PYI6UXOdNqsy2BFJa4u
	SJXWJQPGzKGnNIbpAI9JcvC1iDXLKKGP22OGCsixx5NBsf4Ndy6X1Mx40ylScle4u0iIMnAWqIy
	PEFU9wLXuzV6w/OHNHcCbtIoi/Lq0JJ2L0RE+RHdx94F1xgAtn/P6qUSZ5ZW+HI9DdINZ75tNqj
	vtBrlBPsR1m5bdJkq3qJXDNQYuv0m2RxXiBGhN2n1HcLO5kuqyZ0N42qvOofp5+bCAuVGB9G8/P
	JyBUrpngW1T3+OdvEBhv3fMaGviFhqUvwEzSJxZgr2wZWhw7acguy2rTpkvPGsJmjsA9zxYRHO8
	Uotvdjs1C3EFKh0lVJ9Lq+Y6gNPpSUqjy81WV9X+YCxpQ5tDaC28rbouc6DeJL1uOvW/8cNJU/M
	wSv7nOyr044ok=
X-Received: by 2002:a05:7022:1002:b0:135:e8f4:2926 with SMTP id a92af1059eb24-137ee08ab8amr151501c88.3.1780333234503;
        Mon, 01 Jun 2026 10:00:34 -0700 (PDT)
X-Received: by 2002:a05:7022:1002:b0:135:e8f4:2926 with SMTP id a92af1059eb24-137ee08ab8amr151486c88.3.1780333233786;
        Mon, 01 Jun 2026 10:00:33 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b3c69bdfsm7151625c88.9.2026.06.01.10.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 10:00:33 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: jjohnson@kernel.org, Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260512021108.2031651-1-miaoqing.pan@oss.qualcomm.com>
References: <20260512021108.2031651-1-miaoqing.pan@oss.qualcomm.com>
Subject: Re: [PATCH ath-current] wifi: ath12k: fix memory leak in
 ath12k_wifi7_dp_rx_h_verify_tkip_mic()
Message-Id: <178033323299.2045173.11452905816868996849.b4-ty@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 10:00:32 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE2OCBTYWx0ZWRfXyfT4yc4/KCge
 s/z1DhXcucZFPnaL8oJufRjo0meU7gbuTg6sLyVuThhmSLYpbJdDvllfJtM1wH7YBykgxXnw9IX
 zWUD+SY1UzYAvf5krBqW+UP0sZHk4bCxGrCRq2x1qEGrnMTVzq3/Dg8FG6YDLKYucuxjpLGiU4P
 7YYZHs9qxeyHiZ3vnPaKNRLs9VEOoQxnxfqiAg0WSOifu+Cl4D5FPh6ThzsgfEuMF9B+LrVf5U/
 HXVu4kX33BWYzlLB3qzitt02ewrFZb1dHxeWwEfxWVzJ3VsQF+QynJNOyBjNLuTyr0VfYksx3LB
 VOH8EGZCVL29+5BriVXcaBSkxs7Cb5AbdIg2gOA1tKkIxkxdAeTaSwTVOfIP77eHo7C9R86Grh4
 AnbqG7dfOyTgr/aMd8Yk2yQv98M+fRn+8BKD/Nr5CsgLQeYBfavRNzGBJjolTm7RkZ+Gph2O65Z
 Yy/JxOPip5xdfaR/vag==
X-Proofpoint-ORIG-GUID: 1ugApL2q9yOf88hxu5pYRqW8lxUwlxnn
X-Authority-Analysis: v=2.4 cv=HrNG3UTS c=1 sm=1 tr=0 ts=6a1dbab3 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=VbIn720rbYaXAQPOSzsA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: 1ugApL2q9yOf88hxu5pYRqW8lxUwlxnn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606010168
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37275-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CAE30623069
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, 12 May 2026 10:11:08 +0800, Miaoqing Pan wrote:
> In ath12k_wifi7_dp_rx_h_verify_tkip_mic(), the call to
> ath12k_dp_rx_check_nwifi_hdr_len_valid() may return false when the
> NWIFI header length is invalid, causing the function to abort early with
> -EINVAL.
> 
> When this happens, the error propagates to
> ath12k_wifi7_dp_rx_h_defrag(), which clears first_frag by setting it
> to NULL. As a result, the corresponding MSDU is no longer referenced
> by the defragmentation path and is never freed.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fix memory leak in ath12k_wifi7_dp_rx_h_verify_tkip_mic()
      commit: 98d4f92ab6a1af2ea2ab590d7e2801b203110981

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


