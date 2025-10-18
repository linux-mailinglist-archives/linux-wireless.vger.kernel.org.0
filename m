Return-Path: <linux-wireless+bounces-28042-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D202BED2B4
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Oct 2025 17:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 231F342016F
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Oct 2025 15:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CFA21CFEF;
	Sat, 18 Oct 2025 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ALFHQtyO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABC2147C9B
	for <linux-wireless@vger.kernel.org>; Sat, 18 Oct 2025 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760801911; cv=none; b=PgENIEA8FTBDnCU4N8MVa2kih581t+WdRf/m2EKbOJWIJygfC8u5tR8h46HRJsJhSNPSR5zqTYWkqEgoMpMevH78A7yI3ZgnsaS+wll6QbXxwnCYz0auMuGtdRo9fRw/1NQNZo3dlyr66+Btd/oL7cVBxyW4F9sajOtHhlvepag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760801911; c=relaxed/simple;
	bh=WK62ob4AeK+YG/Lzd0HTAcgVyqGd0czUP29w8h+GAgo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BnbP4T7nnVKPq7LswJLA2b8mDjnB5NFNxATJFVnkb1DgKhBSZfb5dUnmBB+BJva9ltfFZqZ0Od1NQwyRnTwDFLVCp6NERPucamJEZfNALfam138FoSo9s3mKINiHngcPPyN0be8pccUDNtJY1kQtsVFXaR+DhGQSu4XkWWZE0Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ALFHQtyO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59ICpx1V001363
	for <linux-wireless@vger.kernel.org>; Sat, 18 Oct 2025 15:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tTJZQzKPDxO/ZOg051psoNPOywl2B+7guIEa9xKApMw=; b=ALFHQtyO9QLI3zZf
	C4jR9dlz4bk5ppVM6lteSsO0ml2VbzLNHs1Vxrn7VDKKYIOjCOhyP350iV1dUbTc
	Qr8sb9mcI7gn7H8SvmWtNHGskSPvgL8kdLcBjWWKsYBsRJXHvLGm46Y8zneDvSOF
	jc2EVwnPDD2LVLyD3eSXUnRP367+j3JyWO9++BuC3B6nWgtzF7sk1SeJtrRr2/dh
	2LE7kckEg3+xVbQnN8y4C/+h7txQhKwZJwSwc6Go4/WozKUaC3H0WX99Zkgtig/l
	KQ2Jqhib3BfkgiY58o40hAh904rQTfvq0vZz3zsiO/EDppFYyA1Mma94dxp1gjT1
	Jda0PQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v1w7s0wk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 18 Oct 2025 15:38:29 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-28eb14e3cafso54268635ad.1
        for <linux-wireless@vger.kernel.org>; Sat, 18 Oct 2025 08:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760801907; x=1761406707;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTJZQzKPDxO/ZOg051psoNPOywl2B+7guIEa9xKApMw=;
        b=eAJm3leMgeS7FTPyzF0mQqP2/qe1MLV4ulv8wT0QfvwrbkbIedbjxRJIxRHGuGZ7h7
         Z3ezJeR6Xcn++/MJzw4PO1iclJ4WXmM0VGJO6z5dESjwhSlqayoIyTMA4oItDpTikHQ9
         gKDIGJFqTKORH1V9B8ywqwSkImloo8Bdm24Y2No+oeENC4ih7QiPvBUTXRiVMxRZac/V
         12TD8SnTR/Yp07pPB+KBn5TYGkfNI6q4wzGEhha8XJgqS8LbjVaqlMbif5QHkSDW1MUe
         Ui6GBT/69e5j/SNO9+VU2vruifP/GvNEdFhWeUf0+jJx2Wp0Apg61umvPVRpmUxtKnR3
         yimg==
X-Gm-Message-State: AOJu0Yz/rLXDbRewhq/samBBkBHvir7GxnPY5zloSgrRQ7ycamQspVzx
	jddiSab+5PWv+dB/iqKx9rFCe1HSm2blYzqmpo2tiNqEas9tL6lz9usK+o+CcE5CplQz3uCC7RV
	qU1nFdS80MsYcf1C7M7Fp1M4tHTZg6YuYtQ8UqvG26pzaGlmWZTKp1peO7ziNDZSxgn/Dj3AXFb
	B2eg==
X-Gm-Gg: ASbGncvyeB4Ziitf1KQANu8vYkmFAXhcVrnEjfvNRb15tPxJcmXvC2P1ACvFrb4s2tq
	2U2OHwybub8Z2u31/jD247z58sdemjUNxk6SB133d4F8YNiYsiFtFOIlxraDAOXN5/8Ibd7Q7dd
	VrXdg3LWT+gSlAnjCKKaLLCyXua+tPMDgezyov0gqodbuhq1BosHU3t2y+ALhoXAa3l2HY4DDOf
	0271o7UEFj0rOaWIn52Oe9mk7P1NkR1f2B9TEW0joauO7aQ6uT6Ud4NU4tnA2errx/n9dtAKjvm
	CZbeofsUXlUYGWq6zCVIJsSBT565r6oa8Eun+raml/0rxkJMcmVTvLIE9Q/phWhqY2MLBPEzWh+
	c+UJU6H/sOBq0g3ndiQQ4qYQrhW7WaUhuFFg=
X-Received: by 2002:a17:902:c943:b0:290:ac36:2ed6 with SMTP id d9443c01a7336-290c9d1b907mr106269995ad.14.1760801907604;
        Sat, 18 Oct 2025 08:38:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB3O19xCI68MiNuktLQKUvkcvzqeLpea4bfKPkKFnzOz1BRXIF6Sf2snzCwqAohNlPYTUtzg==
X-Received: by 2002:a17:902:c943:b0:290:ac36:2ed6 with SMTP id d9443c01a7336-290c9d1b907mr106269675ad.14.1760801907170;
        Sat, 18 Oct 2025 08:38:27 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a7664a228sm2999109a12.4.2025.10.18.08.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 08:38:26 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
In-Reply-To: <20251003082955.11436-1-tiwai@suse.de>
References: <20251003082955.11436-1-tiwai@suse.de>
Subject: Re: [PATCH] wifi: ath12k: Add MODULE_FIRMWARE() entries
Message-Id: <176080190653.1665595.13835656196130660579.b4-ty@oss.qualcomm.com>
Date: Sat, 18 Oct 2025 08:38:26 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxNSBTYWx0ZWRfX44D1DXur72Ui
 6M94FEHsmhhM4vrkWIXMVoi49ta/envJh0KWEstkPxluMMyJMq6/nGkEsV1+YUh/zMuaTb7IIkK
 TELi0qOzAgDXT5OY7W1l2lIvhZzRJ2Cbo1cm6Ugwo969h+A/hCxTG/+25RQ39Tt3tes69wOn0mb
 sHmZfziTB4vCKRj2C54sNn0oRiFHDVC39hsRiF0o9gZQd36Fd6yS6CM7Om3AiW4Fw26cfk8Wtj7
 wtr5ARo+OPOhSlLYjvz9puaC8mzmskzEA94Jsjjr5GgB5uo7lUyZGVwkqP/LSfnRCR3s8CcfIkk
 NftBxkqAGwNdSxL9zRIx7+6SxvH8i/7YzUafsd8ovszC7aIQfEe9rdn7T01ThxGTJrW/ojOLbq+
 wBsAyL6wKLSwpwDDaPINPAAGDNZM0A==
X-Authority-Analysis: v=2.4 cv=bNUb4f+Z c=1 sm=1 tr=0 ts=68f3b475 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=eBwvleRBC9WfgbDsz4IA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: RNjQoZIzzTW_vgU7s3TaDczu5RCRqdMr
X-Proofpoint-ORIG-GUID: RNjQoZIzzTW_vgU7s3TaDczu5RCRqdMr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180015


On Fri, 03 Oct 2025 10:29:19 +0200, Takashi Iwai wrote:
> Some systems such as live-image or installer require the firmware
> information for each module declared by MODULE_FIRMWARE(), which is
> currently missing in ath12k driver.
> 
> For addressing it, this patch adds the MODULE_FIRMWARE() entries.
> Like ath11k driver, we can just put the currently used firmware
> entries for QCN9274 and WCN7850 with wildcards.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Add MODULE_FIRMWARE() entries
      commit: 38e3a9408496540f3a1dbbfc2ea7e495e14e03d7

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


