Return-Path: <linux-wireless+bounces-24891-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A7BAFBE4D
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 00:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CAA21AA45AA
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 22:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8196928D849;
	Mon,  7 Jul 2025 22:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GVdQw7W+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA4528A3F8
	for <linux-wireless@vger.kernel.org>; Mon,  7 Jul 2025 22:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751927788; cv=none; b=dZHm0iq/LBu1EgxSQqo1CusccLXhLUOQUZaLeV0zeCEBRH10siF0p4vUpZsQO7pskMFow14BUc4H74GkD0/n0kVY8drvRt3IQ8CquhXnDQiQgBzs0NAmM5e8f3eodYvGalKELnwyBru0gS0MiLrVMU4Ub7arXaJCYtFJ+nCVay8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751927788; c=relaxed/simple;
	bh=oSCAQyO44W3G8Ziz26eTl1VJxcqIAIPjOBRVA+Afj+I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ez2EXhLxa08MIgTjoxVAjnA/qojZKOzzI0uAt2ZJjRvH3P6eIaZ/UPdZcluCQhgxZHQ8vrwloWKy94mxarKq3BYgtb23HjAH9byI5G7kF9wUwSKmU07dYRaWSpQoo182ogKjHF+RgqQDrZlvSarx5JM7fcClwdA+tIDZ8fzue80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GVdQw7W+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567LYCBH028001
	for <linux-wireless@vger.kernel.org>; Mon, 7 Jul 2025 22:36:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YApgcEfLhCvcv/oL20l3XARkGnqSjmZOVD1/d8EkdQk=; b=GVdQw7W+vm6CBM51
	+4+2ADPoh99kDKX7CiNs7o2L+Q8axnH+RG5NXPwdA6+NaiYybNTaKmwBG7U81Qnj
	URbguy7SCHK9TFjsXDlTUj750fUho6lr5oc4q4ZVvJ1MT8/URcxhSYORRNW42l/s
	FwpLPCD4GwXa7IuatT2ZKplXDrNRhz37G5JHmzt/x46/ODxM+Q+EokC1wzW4xmdY
	kmgv/v2Ytiw76K8xD8hZ0UfkgLcMkHEZS32zBfVVS3qkem1jCdCofQPL/Gk/aA5P
	Z6H+yAWYxGvOS3jp3J8lunGKHfsJ9a75ZSF017BBaB1YKmgSj8HUsBXj7w1Ks8yL
	+3cnrQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pu2b138x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 07 Jul 2025 22:36:25 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b38ffb62492so3258176a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 07 Jul 2025 15:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751927784; x=1752532584;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YApgcEfLhCvcv/oL20l3XARkGnqSjmZOVD1/d8EkdQk=;
        b=JSsbM705nacC1uxn1KehBS12CEPdm/10QzJGdXkQkaohUws4YJlZNX88PrgUV5ZYtM
         M2iHGOp533iPnRSktZiZuh6fWSzmDZH2FGHGA3ITZJblm98YDcgQ1ZyZjtFMGtKml9xY
         KHRdi7UKt+dU4xifmo+P8DHLN+V/A7s6MxvdtTqQ7zjGFIZbW54a4kKdMXYpqnkJ2dYF
         YZ2GIc4RSUUW7HW87rD43h9uPrduYTatikRqrtjd/KFoclhmfUlJsby0rXA91lngQ+dk
         hvcKHzmxa9B3YzSF6NFkBCqnbbZAUfuQGyDRcaAZG7O6RcHvyTjMaeQWvhyC10xgYft1
         eyxA==
X-Gm-Message-State: AOJu0YwiF7zz4M+Xo+585NVoLDS8ySOBrYV2VRQg+V8VSGVwacmPRjZv
	xJVSDTaZBj+luzvX2qxxIaTmCcciPGcq26eX8zv6lP8z2EIqR/2SCQgEWeAakxq1wu0OhWWx9qc
	8QJmz6NzeflxwsQRuLp3Dc0+ERygrAwxudtEBSydtSDr6q5NdEsSIYA3Pg7/33VF6zMpuPA==
X-Gm-Gg: ASbGncu22JCnjxS8LfWFDHR/PhcJD9qCpCt7pzdya00SEgnqdcKFSjrYwVGjzsIqoGM
	6FccuWt0dM+9uZpxNbAu1aiSd+W48BaFo4i7//YbFK9bv/HcXULOra50TjAxkRNaNtREE5EGk97
	RqD0mTvS4zBHNvzjpZty3b3kv/UPzu3Cvia0pq1wfEN9WZ4yEjKuUDGEPFdSb0yyYIAlhH1GWvh
	Jga3usjOaWKIf4Mr0p5clZqo7ye/CYrnqocjqlHXWBa6vBGy+k5ihNU9nQpWm6REZESDaFPTDk/
	ycpshvCs+xQ9jJxPPVaPXkVisOcD2AZGTxjh7g9w4/VAXtackE9JuG+FGDI=
X-Received: by 2002:a05:6a21:6da1:b0:21f:53e4:1930 with SMTP id adf61e73a8af0-22b439d14c5mr1232068637.22.1751927784553;
        Mon, 07 Jul 2025 15:36:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT+sWByQ2MdrJ8iMs6QfVZt5E56GE3YfUbHnEbFwa7fOfWuomg2Zr9UHmbiugrJtnr/ylgZA==
X-Received: by 2002:a05:6a21:6da1:b0:21f:53e4:1930 with SMTP id adf61e73a8af0-22b439d14c5mr1232042637.22.1751927784105;
        Mon, 07 Jul 2025 15:36:24 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee6358edsm9668064a12.58.2025.07.07.15.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 15:36:23 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250630064431.3446333-1-quic_sarishar@quicinc.com>
References: <20250630064431.3446333-1-quic_sarishar@quicinc.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: properly set bit for pdev mask
 for firmware PPDU_STATS request
Message-Id: <175192778338.314276.2561875360399955703.b4-ty@oss.qualcomm.com>
Date: Mon, 07 Jul 2025 15:36:23 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDE1NiBTYWx0ZWRfX/v0sAea72B1j
 xD5vPG0QlzmXNCE1D2IIVoa2beigGuEgO+p8RdYZvDIEz0LYe3WvkC0f+DRcgyAB+gcOYnAGJk2
 gan5OcoksbRP3hdy+nvmQXj2wkxO/Dmd+HxXfn/nvRnUaPpUkfm8cYfOsPwOFXvC5qRvgYwiqVx
 m2CLkYADLgL7Xvd8VdEcbZKXHiWVxbOhcpxMDMgQc6oek7PXIBYxTdbsTUruE5pa7NVct3en1XY
 ffCa4bxcxvpOcIqSJZH1qj1kCsAiR/3TxM0CdKULgErZugsmzClF34p3D0NXMMyJQIGCSTJTgXB
 PBGvbzCiHDFJ2a7+v7CWUlMb0FtjDWL3y4Ly3NrnJnjjQC6xUXCboYKaP8jaWwvKvYsJWc1KmTY
 x8R+BGCrXWciowYs7LzRPWWXfoIhNsjSTxsaEK2SBIXbgWlkcm0hV2Kr0suBa26+SOBqBOeu
X-Proofpoint-ORIG-GUID: epzqhx_KN6RA-ANRrkhpINno14J53U_U
X-Proofpoint-GUID: epzqhx_KN6RA-ANRrkhpINno14J53U_U
X-Authority-Analysis: v=2.4 cv=erTfzppX c=1 sm=1 tr=0 ts=686c4be9 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=baoXswmsWw0oUJaBrHEA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_06,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=984 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507070156


On Mon, 30 Jun 2025 12:14:31 +0530, Sarika Sharma wrote:
> Currently, the HTT_H2T_MSG_TYPE_PPDU_STATS_CFG request uses bits
> 8 to 15 as the bitmask for HTT_PPDU_STATS_CFG_PDEV_ID for firmware
> PPDU_STATS. However, bit 8 is reserved for SOC stats, and the actual
> PDEV ID should be encoded using bits 9 to 15. This leads to incorrect
> PDEV ID encoding in the request, causing it to either ignore the
> request or apply it to the wrong PDEV.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: properly set bit for pdev mask for firmware PPDU_STATS request
      commit: acab697c32f7a38ec0e9721ac02febd295e8df74

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


