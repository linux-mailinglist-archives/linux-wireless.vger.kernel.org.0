Return-Path: <linux-wireless+bounces-30266-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96748CED44F
	for <lists+linux-wireless@lfdr.de>; Thu, 01 Jan 2026 19:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 166B130081A3
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jan 2026 18:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D28419CC0C;
	Thu,  1 Jan 2026 18:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E4JOakQb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fyR7APuz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBA01C84D7
	for <linux-wireless@vger.kernel.org>; Thu,  1 Jan 2026 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767293593; cv=none; b=qEfvLrRFaIO28Yl/ToHsfEcK5Z2FuQXndxShrIGInHW5eOafz56jN24iR/KnyqMavIFB1O3yYzinMSMK9S0zlIQCb00K1HYvKehrlktwTpxUtv1aMNI+1Io4kJlhu8jnssDMhZu6L4Xo21j26dmqmyCBiCKBwa1VKiyvYMbpx00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767293593; c=relaxed/simple;
	bh=o2JI36SbLL1QX+AoiSt/Ze/Gyqi1QoSKvIbZmPR4/5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQCYSEO/8af5Hb281NKNKEc5TDY9rEwTqJfGZA+BkCzZLeJA9ammjcrVXlQ3jKhm1lKrOLTjyOZbGDYNfQs4N/cFpP3+qjb0D0Z9kCKanUe+56uYJKrEEjSS5MrxrVGbOi78qS0D7HV1T5HYvuSnzPTydfi6WVo3TQBtRXT1wr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E4JOakQb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fyR7APuz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6019t1Wk1729799
	for <linux-wireless@vger.kernel.org>; Thu, 1 Jan 2026 18:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ik6hlVXeTmBKrAB0aF6mx5+u
	5ON4Nq+bNmY4Sp4BCBg=; b=E4JOakQbeHUd6cX0TJKs3SQDrGS3pN2GXE+/B77s
	INRK2xConOMgsCZKtMw8/fZXSNHbErDJWHW4Kbo60eBISTJCQ9lIDk28sOEZTRDy
	XVzeWLOybrD5nIZ4g2HAnzlujiKgLff4gMQgcQ6w56CooqFQXgPybL7gxO8s1m1h
	1VO/+c37m4ObAWcnTpVT/gg9QgA611Lr4ebrGOxbU3MdR+NLv5Ve2mkXK5OCjB+2
	W3d3/b8NaEx7oRJzXPxramL2NbhUk/m2bJ0vEAMTCHM3UF6gjX/SaQC5qCVPLjjR
	k2juBGo8D3SaarlLyE6ASbPvMHRwcBjhUHoCA5US8AI4pQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bcy6ajtps-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 01 Jan 2026 18:53:10 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4edb6a94873so226273991cf.0
        for <linux-wireless@vger.kernel.org>; Thu, 01 Jan 2026 10:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767293590; x=1767898390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ik6hlVXeTmBKrAB0aF6mx5+u5ON4Nq+bNmY4Sp4BCBg=;
        b=fyR7APuz8BImezbf15bqpUARVdmhTHJMmBmO11+cmAkQTcEBlnU/A5i1ZybOkwEUK3
         x2CRi2QMJ+bSt6hGZAagGUyb/6cT8pXSypCPYaeAVQvaHLulC6odKy0edr8ahr8yB675
         jjpBReIsK9NCfqCuCR+k3XqLHlS0hGFjroLGN09fkXXqiLxnwROwQiJV+RkVNOhhuvuO
         2iLKATnulYBVJI1YSRBKX+/cenV+pElKoffxi/7rJ+ewMYC/X/CcOA/H2QsqnQCuWgBQ
         hn7hrhcunGSvWI/6u/1pZn71tjNHK128c/wOTGAZ2EYpE/SdECUNRwjnGmMkUGYFSkQT
         vMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767293590; x=1767898390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ik6hlVXeTmBKrAB0aF6mx5+u5ON4Nq+bNmY4Sp4BCBg=;
        b=wnWpM8oKBB3wSvC9DDJ8rKWV0Qw/85EfTTxM6CGFNU2c5st9cQNfKB5pRUahqmpYpB
         SBD8F4CV1a9z25gvdIHQ0eTq576a0vuCcRvz/RBMBuPtmDfVFUdwNy4l/jopRozIsn19
         LRGft4di/JsYJv0icmiazDXPzmZ50yd/M48aMv+0biWjRXslHx/KCrLpdhrkTfC1MX1Z
         JJPoIc5A+HdWCk5reUt1Ufspn7n7EN5UOuQ+kkWRFTJHzEnuqt+Ii42IJIsS+atClcRY
         D/hkF3nAHsp5SWmGQzpZUr4KTI1Ikt7XZi7P0ssBndoxnMY4HLzTm/7gmNy/Y1tSqQTS
         e1Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVcyHCIKrcX/PR75S/lVJDbGlHP6ue2xx3tPtcYz4TunBl/MKderI6L5YJC2+oFRkfM5iZ8LDuRiNvlugWnQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXgaKopP5u4bbebVr3qimqSCmZ0IsSViWd3Xfm9CL0GzAepKZz
	7ZiLyDzcndG00u6/66Ben0vIa4xp6zHY4N70f0pMG2k1m6DbRMdCUBSCvpktd7jCvm+cYk1Ejol
	fJQESZ4KmR+S086SG7IFpmzPLjmrTBAnHKy1aJadokovh3uS0V//sj/M6JkYGPdERFBXPnw==
X-Gm-Gg: AY/fxX5Fd2rKJTg5My3xalsiM82BLXuIE2/gUz+O/vHU0KIn/omjoB/wRT0IVmiq5lH
	s/Z+tKLbEHyDiYmN9HM6dWKW4GvR62hMawT4nRUpDi7UR19YPS6AIYdMJQWyaZgEWmDAX9OzmXu
	7b0U3RggmP/u9vvyN90SnVUCVK9dHDv6hyVTFIoR0YUatUj2k1VuqD/c7mlq+fDplwWVnItcpkE
	4yAV7QhkXb+3a+Ds+LwCg5AswDD8nL4fheJv2w477frJkomMgIyC70CU23rKI7tRMqG/XG8RLPl
	QV0Ehubb2M5W89O0m2qrGi5xNRs0VVqR/q1AnLtxn87CdQ4I9UHUoiDFrBjN0mdcM2YGdPWuv3B
	JHGY8TA0vZVeFLW8AzUoV
X-Received: by 2002:a05:622a:1f06:b0:4f1:e0c7:7892 with SMTP id d75a77b69052e-4f4abceebbcmr599601121cf.21.1767293589939;
        Thu, 01 Jan 2026 10:53:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqWg0OwJN7WPv/Z6zzoCKj3pxTkw7ICxhLJa4qdOrQj71LJo+OUfAsFJ3QIwlHL9BMYoFVPw==
X-Received: by 2002:a05:622a:1f06:b0:4f1:e0c7:7892 with SMTP id d75a77b69052e-4f4abceebbcmr599600801cf.21.1767293589362;
        Thu, 01 Jan 2026 10:53:09 -0800 (PST)
Received: from oss.qualcomm.com ([86.121.7.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b836b9b08c2sm1537526166b.58.2026.01.01.10.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 10:53:08 -0800 (PST)
Date: Thu, 1 Jan 2026 20:53:06 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Maxim Kochetkov <fido_max@inbox.ru>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        mhi@lists.linux.dev, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        netdev@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan@kernel.org>, Chris Lew <quic_clew@quicinc.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] net: qrtr: Drop the MHI auto_queue feature for
 IPCR DL channels
Message-ID: <bah766ajefvfoiqgbgjwwlbbr4ech4yupo2wjogejxcd5tmq4p@q5powzzdfbbf>
References: <20251218-qrtr-fix-v2-0-c7499bfcfbe0@oss.qualcomm.com>
 <20251218-qrtr-fix-v2-1-c7499bfcfbe0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218-qrtr-fix-v2-1-c7499bfcfbe0@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: ITsIPnwBGBMMFF-JtvVK1Q-ha6h3qLWs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAxMDE3MSBTYWx0ZWRfX7yN0MTuSpYhO
 uwE3D/rzlhXQgGRK5rt3Xr0c2Nq2muKJhBp6vU2bnQZG5/5Xv1MEwIl75ZPV/3VVRQOvjkvVD1L
 lfpAjnNc1tGSPmHr3uv+AjcBCRs2aZQgwuU9PsqIZ9Uo+4NwLsNjJwjmM1bpilEtBwdj+axSGcr
 rZ6gr9KMe5DbeB1xS/2TqIpMwQxOvrtst1GPbXBFoC02vtjlZqtPnFi/EuUxFwBTx+4d2fOL57R
 TKDsT7Dv+PsQOpOgeJ8wpG4RnXTCJo9wlQJlwTFSfHgJAi6EDJJr79aMY29jiERfcguLRLCWHzg
 iYzEG8WZQjL6R8bvVJNhW2MsfEuShxU5gqOcUqt0goCDMtWXSKJLvOhrXRLjJRNDzM0fRltGJ61
 5yrlXDM/gkbJKQH7iyBn0iFtsAkHYS8BBYmt0GR74JNT2uDDQtm+jHAeSRGMnpv0nEqmmgt2e+p
 IrQykhYuBRnJLQp7YDw==
X-Proofpoint-GUID: ITsIPnwBGBMMFF-JtvVK1Q-ha6h3qLWs
X-Authority-Analysis: v=2.4 cv=J9GnLQnS c=1 sm=1 tr=0 ts=6956c297 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=hZ5Vz02otkLiOpJ15TJmsQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=zitRP-D0AAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=isMaZ9OHK7bkWVW8W2QA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=xwnAI6pc5liRhupp6brZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-01_07,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601010171

On 25-12-18 22:21:44, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> MHI stack offers the 'auto_queue' feature, which allows the MHI stack to
> auto queue the buffers for the RX path (DL channel). Though this feature
> simplifies the client driver design, it introduces race between the client
> drivers and the MHI stack. For instance, with auto_queue, the 'dl_callback'
> for the DL channel may get called before the client driver is fully probed.
> This means, by the time the dl_callback gets called, the client driver's
> structures might not be initialized, leading to NULL ptr dereference.
> 
> Currently, the drivers have to workaround this issue by initializing the
> internal structures before calling mhi_prepare_for_transfer_autoqueue().
> But even so, there is a chance that the client driver's internal code path
> may call the MHI queue APIs before mhi_prepare_for_transfer_autoqueue() is
> called, leading to similar NULL ptr dereference. This issue has been
> reported on the Qcom X1E80100 CRD machines affecting boot.
> 
> So to properly fix all these races, drop the MHI 'auto_queue' feature
> altogether and let the client driver (QRTR) manage the RX buffers manually.
> In the QRTR driver, queue the RX buffers based on the ring length during
> probe and recycle the buffers in 'dl_callback' once they are consumed. This
> also warrants removing the setting of 'auto_queue' flag from controller
> drivers.
> 
> Currently, this 'auto_queue' feature is only enabled for IPCR DL channel.
> So only the QRTR client driver requires the modification.
> 
> Fixes: 227fee5fc99e ("bus: mhi: core: Add an API for auto queueing buffers for DL channel")
> Fixes: 68a838b84eff ("net: qrtr: start MHI channel after endpoit creation")
> Reported-by: Johan Hovold <johan@kernel.org>
> Closes: https://lore.kernel.org/linux-arm-msm/ZyTtVdkCCES0lkl4@hovoldconsulting.com
> Suggested-by: Chris Lew <quic_clew@quicinc.com>
> Acked-by: Jeff Johnson <jjohnson@kernel.org> # drivers/net/wireless/ath/...
> Cc: stable@vger.kernel.org
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Tested on Dell XPS13 9345, so:

Tested-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

