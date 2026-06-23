Return-Path: <linux-wireless+bounces-38020-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B6NDEEa1OmoYEggAu9opvQ
	(envelope-from <linux-wireless+bounces-38020-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 18:33:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8630A6B8C01
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 18:33:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=ESUWwHoB;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=ZeCLsBGW;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38020-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38020-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E806306C873
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 16:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7120314B66;
	Tue, 23 Jun 2026 16:32:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C76130F816
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 16:31:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782232320; cv=none; b=cWUrNbR/lzngvq4M2jrJscnZWgLGC6n8XiecuX4l2iiEmkVX7Wpb4rGjPCCHzbSQBxQUvTy9Tf8naKtmyJsm290GcgqR4MCX80ppZPi5dJWqoxIx68QLEqCEkGjOaFbA3djSrXqV6Yc0TDBRPRJPkHKCMHMjRjL8jTTJcUEkCPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782232320; c=relaxed/simple;
	bh=zYwRlwa37Rk2TVjMNmDVdga+Wy3uYUUgKg2SsmHDRN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWN0bgHrtWSUbyJhCojV2Er0ZshNYDoeWBu32XBDHloWrKcwcOkRLYS2oAlCcYXohEjS2421E2TV2/2bLVeMVBLuqkK09+x+mCN56uv3vqyfrtow1/xAz1QI40PM3l3l1I8uKYrrJqNAiVx4U018eprrHlmiK6s8B/pDuBHn6vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ESUWwHoB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZeCLsBGW; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBZpAc4053103
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 16:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bpZit0nzAD1TX3LmUuhtrO8w
	q8/DhirAmsH9yXDIezk=; b=ESUWwHoB/PYrdnzgspHK50aVHFG9HG0SsYqEfjcK
	zy3aoaNgH/czKeAZ0dhYEzvc8zj5J+CgxxbnedXTsuYRgPWHLPc2PFl5NVhl71B5
	RzAZ1QTHSeWoAg0DmOfZuqmnTFoJ98qSXI13pKXGoBq6v22b7zOvt8Tp8WiqEJju
	p9oePXq6Oj8Um594mC8b1BhgZVi78fg1jRXMfsxb3w1ShooV4RrqzM57YviXD7BM
	J8FvAdOBL4AMuiWP0Dh9PCHX85HUP9B4Te7sj9/puAK1R6J42yxzqKsFGGXnfzfV
	5f8fJ05IbJCt/q4yfE+sukmirsLHgEPcUWhEzCioqzK8Zw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyr9yshgq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 16:31:57 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c894c1c4aa9so10077a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 09:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782232316; x=1782837116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bpZit0nzAD1TX3LmUuhtrO8wq8/DhirAmsH9yXDIezk=;
        b=ZeCLsBGWDpTcpqUZ7m+kJoXzdybP9sVnr9uhni7RsPtssRkevUfYkpg0e15VBb6MB+
         4jyM/BRpcrHeD0BceuPNpZyqIqxpGiih5rDX2Dsrw/dz624tm6MiT807qRcx0EadQwTb
         l66+LP16pxRmk3pdkkh1amrrIBHxV2JXTqghozOHz4CQHFAP2wcRdTW4BCuXL5RdvRcU
         dMClolOLBOqMqMXLEzp6NCoIVX9Xju4qBN/TLtQ+5KFzDtVZhcpKn7ltCecRbwchpKfM
         cHZZFOYwtAwBUDNmPAA3a2uhSr7Onc1G2Gj9Uo7QpHkSTKATUdu2rWU3anxAKQuVr0gJ
         ArMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782232316; x=1782837116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpZit0nzAD1TX3LmUuhtrO8wq8/DhirAmsH9yXDIezk=;
        b=eW153o7XxHTfzgijCgFL3b0p+7oJ5r9HiYiioUWghR4k90vrDWKdbVnpcqS1R2ZRj5
         NiKqNBaDYH+A2ODsnA6HsD7dh6++sSXWjZeXkzucadzW7hofWHOPtSH7isVKIRvUmTdj
         EH3TATwkzdQo3sJOAxsBUAGlCQKcql1uLLFprG+C0wVMvstEjXoRkbTFq25W3IH5AQlT
         saR/YL6Lsh4J1c42tN1cOUNeruRN5NF8M3ZmEEcBHsPkLVSXL8xNBk87oGhixkK/hX2T
         HUwTJRHTUckzo6zhX/R9DpzfFdkPNvHLhAaRXhkL4R18VCq04ijPS0M7onzs/dl9ZNkV
         E9Ng==
X-Forwarded-Encrypted: i=1; AFNElJ+qn2oE3Sotyi9nzbK5GiTBqaoUGqGfPredEEB3NVghVB/+VtRegUYLn37ZL/eqy2gL5ZCa8PCcr2VptrS/dQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxks37Ws+MYYolOCHFonypO8+gENTVSpESsnyoQXCVnVZl8Qd2
	S+K/L6QI/Kz/uYpAPT7YKDHVbH67KLEcYfo3ARFs59OPBtQeYcGaD2dNdCAcPiYVEPC4Vxbm998
	FEbYc4cS6mPHwmWwwk60BF67g4qMlybWHwpMVoaYpyim24kYcGoED8ClXecjZpvgvAD+BzQ==
X-Gm-Gg: AfdE7cnqga9PKSsANh6aN11OQ8H9EEHMVMV6J2eVNQl9rfAMhXqVT5uDU02pKX7F0Ja
	4dg38Z2CKbrx5ODIemUZgjehW2YIlk5DjPZR80VWN7Rp82n2XWRhJZ28ncvtSegmKbV0VIkqEro
	h9Cl9bEw0k045HgIKY8mXG9BrZLck4nbU1CqcipLzQvG1gbiniMGz9kN6q+1WEcGkWdtdNBvT+b
	uBXE/TJPn6OhvN/pe+BEwwy2zxgjDaanW3hiexuHG1tup3JmuVlvSnOiusx2m90g73gEPqH6IwV
	8liHUwZbGF30p1lDeqn03W0UnUOMURo+19+CGWEMhDuAB6A04ZpuZKrR1B2ariruQHOF2HlVY0t
	umBRumGEcvPADgp5C74pHD9ybul5TE25T4phVbA==
X-Received: by 2002:a05:6300:68c8:10b0:3b4:870e:6f44 with SMTP id adf61e73a8af0-3bd151fd460mr2827983637.35.1782232316114;
        Tue, 23 Jun 2026 09:31:56 -0700 (PDT)
X-Received: by 2002:a05:6300:68c8:10b0:3b4:870e:6f44 with SMTP id adf61e73a8af0-3bd151fd460mr2827936637.35.1782232315599;
        Tue, 23 Jun 2026 09:31:55 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bc5a1dd9csm9850337a12.22.2026.06.23.09.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 09:31:55 -0700 (PDT)
Date: Tue, 23 Jun 2026 22:01:40 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: andersson@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
        akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jesszhan0024@gmail.com, marijn.suijten@somainline.org,
        airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
        dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
        elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jjohnson@kernel.org, mathieu.poirier@linaro.org,
        trilokkumar.soni@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
        jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
        vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v7 01/15] arm64: dts: qcom: kodiak: Add EL2 overlay
Message-ID: <20260623163140.l7dvkqa5szqkej36@hu-mojha-hyd.qualcomm.com>
References: <20260522115936.201208-1-sumit.garg@kernel.org>
 <20260522115936.201208-2-sumit.garg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522115936.201208-2-sumit.garg@kernel.org>
X-Authority-Analysis: v=2.4 cv=JYSMa0KV c=1 sm=1 tr=0 ts=6a3ab4fd cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=scVuWRnFyv5x-Sid9UUA:9 a=CjuIK1q_8ugA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: FlWCaYx-yGIPOUAlnc6BuwuYtxwbj-H9
X-Proofpoint-ORIG-GUID: FlWCaYx-yGIPOUAlnc6BuwuYtxwbj-H9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEzNSBTYWx0ZWRfX5W9DVnlLj26L
 8RCPaNaFAxI5e7j4+iOi9E1tDNpND1GnpQ+7QqUbnl5CNd8jRLdvt2lXZkQKuzBsCgBaREBDWwB
 vVyyNzu1d8C7lWY0F5KI2/WTWBSsdlsEoAoDa8M6cI3sKKceh3+PKOrJLhtE2igywEIQ9tuW84t
 dpiFxR5y0TgxbOcVMoKXEKt+KLGdLmv0ZYCcVmJxwxa0MWQa1jKAVr2OySQThtd9o09+r5bngdM
 UKAkqZcq57CYMe6P4cN7kOnAUlXljnZBMH6/zWSPXsdLP+XTR4QcUQLQ3snFZ08n3A0rWJX2j1/
 PijlaLUpsAuckmpvt1iUfLcObbu/LKbQMsfW1/2DKnl1rTC4Fz2Nfd0bAZF8OzFCqjFMO/HNRQR
 u+oYgG8sNKVoOWZdrYzSqQDrUTTttETe6xzCZzZq9SzDlV+eCrsjekbQiJR5Vfs0jtGiDahBkyI
 RvEklJEux47mAo9fL/w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEzNSBTYWx0ZWRfX4krqfnaNHeZX
 6bxqKwbchSGWlUu+54/QkmX6H9rGsWCl2bXhM3PKl48BwX+mYbIncsZPmgeM5N/iW4hFoQgI66D
 IG114vKcnBgPWjQ2WVKqds+8Gm1XcKk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230135
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38020-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hu-mojha-hyd.qualcomm.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:url,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:from_mime];
	FORGED_RECIPIENTS(0.00)[m:sumit.garg@kernel.org,m:andersson@kernel.org,m:linux-arm-msm@vger.kernel.org,m:devicetree@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:freedreno@lists.freedesktop.org,m:linux-media@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-remoteproc@vger.kernel.org,m:konradybcio@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robin.clark@oss.qualcomm.com,m:sean@poorly.run,m:akhilpo@oss.qualcomm.com,m:lumag@kernel.org,m:abhinav.kumar@linux.dev,m:jesszhan0024@gmail.com,m:marijn.suijten@somainline.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:vikash.garodia@oss.qualcomm.com,m:dikshita.agarwal@oss.qualcomm.com,m:bod@kernel.org,m:mchehab@kernel.org,m:elder@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jjohnson@kernel.org,m:mathieu.poirier@linaro.org,m:trilokkumar.soni@oss.qualcomm.com,m:pavan.kondeti@oss.qua
 lcomm.com,m:jorge.ramirez@oss.qualcomm.com,m:tonyh@qti.qualcomm.com,m:vignesh.viswanathan@oss.qualcomm.com,m:srinivas.kandagatla@oss.qualcomm.com,m:amirreza.zarrabi@oss.qualcomm.com,m:jens.wiklander@linaro.org,m:op-tee@lists.trustedfirmware.org,m:apurupa@qti.qualcomm.com,m:skare@qti.qualcomm.com,m:linux-kernel@vger.kernel.org,m:sumit.garg@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	FORGED_SENDER(0.00)[mukesh.ojha@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.ojha@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8630A6B8C01

On Fri, May 22, 2026 at 05:29:22PM +0530, Sumit Garg wrote:
> From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> 
> All the existing variants Kodiak boards are using Gunyah hypervisor
> which means that, so far, Linux-based OS could only boot in EL1 on those
> devices.  However, it is possible for us to boot Linux at EL2 on these
> devices [1].
> 
> When running under Gunyah, the remote processor firmware IOMMU
> streams are controlled by Gunyah. However, without Gunyah, the IOMMU is
> managed by the consumer of this DeviceTree. Therefore, describe the
> firmware streams for each remote processor.
> 
> Add a EL2-specific DT overlay and apply it to Kodiak IOT variant
> devices to create -el2.dtb for each of them alongside "normal" dtb.
> 
> Note that modem and media subsystems haven't been supported yet due
> to missing dependencies. For GPU to work, zap shader is disabled and
> in EL2 mode the kernel owns hardware watchdog which is enabled here.
> 
> [1]
> https://docs.qualcomm.com/bundle/publicresource/topics/80-70020-4/boot-developer-touchpoints.html#uefi
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> [SG: watchdog and modem fixup]
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

As discussed internally, I will be taking this patch separately and you
can drop this from series.

-- 
-Mukesh Ojha

