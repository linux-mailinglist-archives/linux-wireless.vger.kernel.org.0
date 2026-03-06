Return-Path: <linux-wireless+bounces-32661-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAI8K85Eq2nJbgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32661-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 22:19:10 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9D6227E20
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 22:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B204302F142
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 21:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E53033AD88;
	Fri,  6 Mar 2026 21:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RQoh0haD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NB2wNOZP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9291A33F8C1
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 21:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772831942; cv=none; b=qcTDu/CAwEmHh+rqfnQRNG+ZLcVwb8MUGX1eGrSIFjQv0X0Or4+EHqWQIN08jjgz9t9pJAnCjjFj+bDLxntvuasQxKd5nJWgO/PISRmg9XgIQpG95ij9lLQSWEDumGzVG6Bcxa9cWNi8EtRhal1YrYxVd66DWas12SC/pfcdMBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772831942; c=relaxed/simple;
	bh=Lo+dXkVoRCQ9V2kc4/EFipIZm0qHajIudIfIYPCgTIQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Wmlml7STU2sE19xwsMzZ9p5JTCTDPxymqaTAHG3CphSRG3utNxYg3zInbscydWvklMy5OgLvxvHIzS7eAFdCBoI7EvutAuIsfUEieB7bct5+XN/vu9+Rx8tz/45TVAw8JlNLNaOdtwwf443J+7ySHBi1vbByhJMTu15tR2WYZcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RQoh0haD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NB2wNOZP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626KWYYn2041580
	for <linux-wireless@vger.kernel.org>; Fri, 6 Mar 2026 21:19:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iBrDtPGjQkXXNabe2uu0Xn4yj8xK4G6bLD03csL6H7g=; b=RQoh0haDKfareQKt
	U1bIo1pTITtYkmSDPFqHVxELCtSP/CLjKhCCsYAKDnJO2LrpAx2ZfwPFE4Ktc3uT
	U/kW+qGjW7zyaJDYn9ju/ufWCCMXWabsLBcADMQtzOrjwQLiGT1vFKHL1/ldMkxg
	UpfNV/gEwqmj6NzLy+r+MbvlTcQA8ymXQMeKycezeJjTH9V2pZ5IoQYHEhDx+dPp
	uArT7WhkaBtECC+2gm+8OJ9AlVTwRlCJEGywtTWGVfkbjdxZ/TnpsS8/zmxdqQ1V
	JS/3HJU08zb2mJ+RJI9QyyIsv/sIxaJLFS0T9qYv8hWdWzimkR2Zrm9bVRc5Y4W3
	o/YbVg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqrf5u34j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 21:19:00 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2be21f89332so4726809eec.0
        for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 13:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772831939; x=1773436739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBrDtPGjQkXXNabe2uu0Xn4yj8xK4G6bLD03csL6H7g=;
        b=NB2wNOZPq6ExzQel/tJgmljRmV3uR7qC8KnEy1z4hC9QqM7x0dW63bEapcGlVTNnTx
         1udm26vxO/NavM60PLg0IyLmo/C28BuhKPAasil2nmnkTD5NRiJUepZVkLEAJTCXrdmv
         WhUG7p/BXW5hVPk9toRYOfGGKEBaUvdyhLPO0j6gWVJX5HGaoFaeELloAHWV1NX/JwkM
         oJzIl6lJv9oNuily/P+3OWVFbT/10ROI9/gBXU4tA7G/9SR7dxb8jdfaXu3f9WrteqBB
         vwMMMyWlpEx/HUBQbUYl89rJjiPjQbg7lQl+bjLajdHz1ZAtDVlHUTSW3xJk1CPqFBb7
         uQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772831939; x=1773436739;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iBrDtPGjQkXXNabe2uu0Xn4yj8xK4G6bLD03csL6H7g=;
        b=sxlMHGGZgB/Wm5y7ml1JypSiLphiI8rcwGtZs0Z8KrGC1RTB8GZwmrlAjrdjJwQMD8
         MPsLjLQTV9kBIKu6/AePN6YCwBELQRJxqVP+dWYb2mRa+lkpQFOHqaQnV7cAKN8wp25W
         AyJWEtPXWpLY/bTrfmu3fCMwPrLCiZ6Sx9CmKCvmfQi+OQbrpdLnsFPQJ73zvzbB2UZ9
         5Yw02lHX18eSX5bEKv1QPaVBUTx6S/9hD2fwSO225AdIsFRz1z2l0mwcj08ve2BgWyj8
         ArkBxXRQiaFSuIHbOoXKpr0ZqKPkglYOXnXyYmpurCl+WzKzlIj8NrFOaNLDLujVXuTh
         QDqQ==
X-Gm-Message-State: AOJu0YzvwAY09QFBP7JxWhl12zzp3u34wujA+E2YXFws/r/Hn7l3ybCt
	whQ7P7jY2n8Box1bzOBXVSwrqplAAwhnseHa2lWD8Z4Ni2Iq/123m1AV8fDf9P7/UUJU7Ml1nc6
	53sjM84dyfskTM7EmS8c6Z56hDVJiAKRsjT+22BYtIVNKoYg3ScpK5HWVX1koJ0Q7FQP4bw==
X-Gm-Gg: ATEYQzy0JKXW25WvKMSxtV6Ysu3m8QNlMU0037/iUt36uhD8PNHSnXPjBGvBkCW3sWH
	GME6aS4DCSAmN10V7dvczOEk+xQC4ODSPsqEt3eIHQA5QYKwb8b5TkOFLTSOdkcDBsE/9Pc3IEb
	4QwUeB0m+qXySdGbZpLjfPkvIBFtZFWMqfYaCKhg/EB9vmbu51pRkGgQloHFVYFXdT2nUjwVEJa
	UchqZTNJNFki8tJ4bttxy+ewdQ5tXn7IMT9aiL+u8iCf5O7UPMkUBr6thn9dZTdx8qlH8K0c2Nn
	R/GPDP6GPiBQL0s1o9pSpbww0AXtkZmsosFKFSmdDqTknlkbDz/HqeJyE8xOKipg0eo4ewHtXID
	mYHHHle3x9sxPtiYxsWPi5vIo5Gr9aemA2l6rrJ5quKlDKs6tJE+fUU/2iACxsLdXaV0dXG+anw
	/s
X-Received: by 2002:a05:7301:1004:b0:2be:fe8:8b0d with SMTP id 5a478bee46e88-2be4e08e222mr1296764eec.22.1772831938788;
        Fri, 06 Mar 2026 13:18:58 -0800 (PST)
X-Received: by 2002:a05:7301:1004:b0:2be:fe8:8b0d with SMTP id 5a478bee46e88-2be4e08e222mr1296751eec.22.1772831938147;
        Fri, 06 Mar 2026 13:18:58 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f948324sm2325124eec.17.2026.03.06.13.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 13:18:57 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
In-Reply-To: <aZ0tGZnmtGckKJzY@kspp>
References: <aZ0tGZnmtGckKJzY@kspp>
Subject: Re: [PATCH v3][next] wifi: ath6kl: wmi: Avoid
 -Wflex-array-member-not-at-end warning
Message-Id: <177283193743.1373939.4596850697529267078.b4-ty@oss.qualcomm.com>
Date: Fri, 06 Mar 2026 13:18:57 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: 9BOxlfRxdSRv21ug6N6Xx0aZvd0DUqGr
X-Proofpoint-GUID: 9BOxlfRxdSRv21ug6N6Xx0aZvd0DUqGr
X-Authority-Analysis: v=2.4 cv=L+oQguT8 c=1 sm=1 tr=0 ts=69ab44c4 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=bO_SRPZOoruQ8eAkNgkA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE5OSBTYWx0ZWRfXwWKi0EXtCYV3
 LPl2PPOvBTIHuVPbix8yyoi2HvH5E3MvGycKIwIVS0e9ASIo3YJaHWmXr2GuWVeA/sxXoFS9Q4K
 RPIF6ERNJLzO+gKO6Fgzhqo33STven0tWcBvSJe9HUlSJ6Ie0+x0PLX/thhOcepQBMl1+fARawJ
 RHXzf8fjysQ7P8vwcEbavy/CEL2CXcJCDXkB9KQbl0xPKZ7bgHlbPjGSa2D7STbf8sLlA8pQwSX
 2lzoXFTz1hX7LufMUet9JvIlpI1sdE6t5/vG+IvO478zLjfnxPEQ0EKvnry29ITuqQtFfNDwXjQ
 13ERSGxMFl2TABh8e6+XzzCBC7BHjLyM6EUvEFV0DxobfA5f+2bSiQiwNN0Lt8X7FjXGB1gjOmS
 mlveN1EfCgdxnUyoEoe6D4s3V+ja1Wi6/38DxQ4tHTbN3x/hRUShGu4CjqpGsRVlGHcHKCmdAdl
 EcjmuKTDZjiJMf917XA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060199
X-Rspamd-Queue-Id: 7C9D6227E20
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32661-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.956];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On Tue, 24 Feb 2026 13:46:17 +0900, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Remove unused structures bss_bias_info and bss_bias, and member
> bss in struct roam_ctrl_cmd.
> 
> After these changes, the size of struct roam_ctrl_cmd, along
> with its member's offsets remain the same, hence the memory layout
> doesn't change:
> 
> [...]

Applied, thanks!

[1/1] wifi: ath6kl: wmi: Avoid -Wflex-array-member-not-at-end warning
      commit: 8e0ab5b9adb7fec3149441621df1cf15325b7215

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


