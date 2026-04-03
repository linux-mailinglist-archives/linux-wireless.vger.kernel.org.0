Return-Path: <linux-wireless+bounces-34338-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNTbAQEW0GmV3AYAu9opvQ
	(envelope-from <linux-wireless+bounces-34338-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Apr 2026 21:33:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BE5397AA5
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Apr 2026 21:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 331AB3042FC0
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Apr 2026 19:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396FF3D647B;
	Fri,  3 Apr 2026 19:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SFXHOl18";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="is3Y8BAc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139A33D5677
	for <linux-wireless@vger.kernel.org>; Fri,  3 Apr 2026 19:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775244794; cv=none; b=of88DM8/ZhDVmPAgg1+BiI0EQ0mKNBL6lSj8igD1ujNzi2kzITnm17oZJDP8WWkC2MwY9uT3pcZTHMrCZxPPUnW4459uRxhtIeWrj0WQtUXJb0AEsYMQ/dQPK1DLP55y09G4mvTlw1A3Tkd5VaT8LJv2tgWKxxvX+/qrGdXGQl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775244794; c=relaxed/simple;
	bh=Nm8bVhXwnXi2Nj/UAQqeoQnFymro7OZDrrWhb6FQxok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GliJyZQVNajosxspVro6CvB7vRl2DDT8RK27T4Se8yZk/Z9gSRvOE7sTw0uHcEqO4/lRKBNVnxhCU+KmVYzxtSqQlQrgjIzFOUSYBGjAsYgLL2Fzgh/hslc096w/wiRY2rwyxPb2Xr97P594gX9bPYa3PdjxSFmDzgQoOGB7lGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SFXHOl18; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=is3Y8BAc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 633AxCAG3803282
	for <linux-wireless@vger.kernel.org>; Fri, 3 Apr 2026 19:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hYnQcnhGrNgV/eoN2v/2MbLY
	nIbeQOs3Yrb0qovNiyA=; b=SFXHOl18ZrNpJYsxzN0alNvOumMDCNM30qEr/82I
	PJbpGr61yKTxM0Ht+vfdgHQSS2ODMl4CQky3KuOEgsguhcW4Km2MHi+7ZfeGHCxa
	dKpua3ge4HBlz85i+tZGv5RfTHQCsPTxgSSKm44+pn6FdFyCpQFnzY6W9Yoh09Y/
	hmTWqqhtVosQ5po5LI6q3xPp6p0KpdqSpv/yDNICpnVXYIcp06rC3wC+WWfLdJ15
	pGeyH3O6nbSRHIkySc+L6Negk+qMi3rhyOfxdHK0fuQYpOyKWnWH5X+WiI+zicaS
	JZretIRWjpOFR4hzxFjHhRC9fxX3nR5kh0M/bU5r6MpYeQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dac9f9dg9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 03 Apr 2026 19:33:12 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50b6f869676so50621061cf.2
        for <linux-wireless@vger.kernel.org>; Fri, 03 Apr 2026 12:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775244791; x=1775849591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hYnQcnhGrNgV/eoN2v/2MbLYnIbeQOs3Yrb0qovNiyA=;
        b=is3Y8BAcfRynBV4Nu4AKdq/aw8T1bXMd9sJ2d/7KuXUdiXhT78V+B49bw0ilH7E2fq
         3f7xmgwuYZddm36Sg7VTN7zRhz180X/N1PVpo6ahVBFrrlNn7P9pYU+laiZDJhd/0UkF
         /QhL0vL8exMrwh49aPEaxAZXybsL4Xmc4iko475AYdkJiV7GuulMNlqf3ikCRvOvosej
         lBCVSxaWCqEXgeAeOw3fyTR+lPhwNwJq24tcg40d29qN5v/du19hA/xfLCbQkQ0yu8sx
         KPQzGDtrb/z6VLn5BQGJ+rvVRyUFZHDDdjJJU/6FMBpHIQiS5w1sfifQL+dkK26OyaSd
         rY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775244791; x=1775849591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYnQcnhGrNgV/eoN2v/2MbLYnIbeQOs3Yrb0qovNiyA=;
        b=QIm2LTAyfLncie0z9Sb2hwKGtZa3xDUzXo9IKddu5r9AThrzksKOboZ+I9q7Fr7V2D
         ZVRpVM8bgtPaqAC/2XcuxdKwlIqnOsj2zpWHWeQRqsTBCwVQI4ptvro+HFPah+v8e/C6
         YtnoRJh7QukUHqydIZcjeMSCchMzEVbgls8nWTMzuQpKTvCaRPi3FBwNhZSls/qF9lPZ
         8kJ9c+c16IeWdTTjUaneHAoqy5a2pLAB+RNTEMmINuQPqJxwUtC7KJFhiSWUCVl772kt
         RjjkzXcEwo9XF0TICG6fXC2du6O2JQ6SPFwKkFP+CEfV79u3IVPqBp68v0ShWoDDAYl1
         0rrA==
X-Forwarded-Encrypted: i=1; AJvYcCUwd6p+azI1z91m+ZRufG9cG3+mqecLPwyvBjqExEjKGH0ZjlSUlcmt+6tzSywg+9B31xeIih840VkHuqyyCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxC50WU/DMQdLDw+QHjrCT3dzW57L3NjubSAxh7xicZWw04vX2D
	54S74aT+QxiH1b+Q6/X4KyCrE8evCTGYA+zXyUHTOVSgXwMM2LqwROyfg2OV7vOnTj5EvaVRVtn
	kioj6tE5VukJUkqs35VpxSlgiHeESczGA9s18XRH320IWKmhSGON6R/4K1wLa3I1M2jn2+g==
X-Gm-Gg: ATEYQzzA5LQeQ5Gw8m6GLr9IB/42hu3qWOC4AM4czylozkELzrbNymem4k6EDKW2s9K
	1jq3OmhaSgL2suILj7MRwHMGBVA+ic+4haNEISvKBxOYulP9+ldmuinwqu+OE3ZL0pDnMNoAXuC
	3176sH/NfuHV/ugyRnCiwdDsmZ25+uIQxAJhcXYRDRsCpx4FNillHcPp14Unl7Ctq555Elc7KHh
	9G04s4ln+1ltfLyMoIikFWZHEL7koszDxsmySIyUP5K98ksJbZzzAER9iQ2OL4p0CLHYJMieWh7
	1iWfRX4j62RCJESsRrAqdBp3g+KQWslq7Te5BvYYkjBdNWbqiqE/KIaZjr0jOiK6RcyIvmG6Vim
	/+YtHZsd9ZgD/FOxASkrZvXXwIIZRnw5/zD0LVxznp5iQCVtdQwRlhBMYKkfZ+Qt75Qu4nBxNsJ
	faGJ5bnOp3KAm/Zo65OT0qOyQbhnLdjBE9YsA=
X-Received: by 2002:a05:622a:6850:10b0:509:481:5365 with SMTP id d75a77b69052e-50d62b02630mr48690931cf.50.1775244791141;
        Fri, 03 Apr 2026 12:33:11 -0700 (PDT)
X-Received: by 2002:a05:622a:6850:10b0:509:481:5365 with SMTP id d75a77b69052e-50d62b02630mr48690431cf.50.1775244790654;
        Fri, 03 Apr 2026 12:33:10 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6c9cbcesm1654085e87.21.2026.04.03.12.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 12:33:09 -0700 (PDT)
Date: Fri, 3 Apr 2026 22:33:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Koskovich <AKoskovich@pm.me>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH v2 5/7] arm64: dts: qcom: milos: Add WCN6755 WiFi node
Message-ID: <7edl5o4lc2jk5exozyxomxjzooqqhek5zyvmp6e3p4ndxweulg@h2dwmk2zizgj>
References: <20260403-milos-fp6-bt-wifi-v2-0-393322b27c5f@fairphone.com>
 <20260403-milos-fp6-bt-wifi-v2-5-393322b27c5f@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-milos-fp6-bt-wifi-v2-5-393322b27c5f@fairphone.com>
X-Proofpoint-GUID: d4xPIxK0VD0c5qeCg5P3xd9L4ZFevy-3
X-Proofpoint-ORIG-GUID: d4xPIxK0VD0c5qeCg5P3xd9L4ZFevy-3
X-Authority-Analysis: v=2.4 cv=BO++bVQG c=1 sm=1 tr=0 ts=69d015f8 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=6H0WHjuAAAAA:8
 a=EUspDBNiAAAA:8 a=nnh3LCdgXL55amKsc48A:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDE3NCBTYWx0ZWRfX8om8hfsqlNTu
 g2drPnrbxvaTpP0M7RA2E9vPxi6goGNFcLw7EoNuj04Hi//SZmvsrmpCCAaC3gUiWKhvDxFalSQ
 9Fogzu8F7Zonxhc11cQWj4k7FeQcsLVYTd8Y0GT1MNWITCvpy0cb++7jEWVT5QYxYt5qUpaqaPo
 sKT2stzuktEryfgYsvUckuduWJejsCHgHChd880BoD3UVsGd7CLKkooyyHOvqqfg1HghxgZw2vx
 soUFHvGCqNZkkJxC/osxb0W/RsIgiwnCFwbZtxHs03cV+VYyGNCkLPxt7ofD/fhBq5tYZiWtjDU
 T70UAN5C5ePaub8Cig4fy9St6UlbN4jx3bsnaBbTLM4vY4SWZzo/AOua8DGzWJy52M07DdIV1BU
 JQmibeDvT6MYUgsQyil3PHh87LVUL9qoMwNRxyBzqQ8F74us42cM4PzK2fKvyV/DcMFpm3thk1j
 xPV7+QpKcO90Eg+i6Bw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604030174
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34338-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,pm.me,gmail.com,holtmann.org,quicinc.com,sipsolutions.net,lists.sr.ht,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fairphone.com:email,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 75BE5397AA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 03:52:51PM +0200, Luca Weiss wrote:
> Add a node for the WCN6755 WiFi found with the Milos SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/milos.dtsi | 46 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

