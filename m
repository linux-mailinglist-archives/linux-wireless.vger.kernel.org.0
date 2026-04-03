Return-Path: <linux-wireless+bounces-34340-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDZQJioW0GmV3AYAu9opvQ
	(envelope-from <linux-wireless+bounces-34340-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Apr 2026 21:34:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 840DD397B08
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Apr 2026 21:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB65B300D4E9
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Apr 2026 19:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FB43D647B;
	Fri,  3 Apr 2026 19:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UGrO3P2r";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GMPEYHoi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3BB3D6CD3
	for <linux-wireless@vger.kernel.org>; Fri,  3 Apr 2026 19:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775244825; cv=none; b=i0b5Bnfch3IKPzta4D8E7rBIbxmPMrk0SkbL6jrY/jLlHxoIbdgripBBoEirjhEdoHvlUCv58/Z1GCmqhjboqXGTz3QqL1yRzAvh0kOE9oBhcRe5Px456U/XGOU3IUmQ2GCi7t+EpKfgYODBp9/bs926Hw7EEwaRW7+59G5fDDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775244825; c=relaxed/simple;
	bh=IYipVv7qJiP2BZHkGsUK0L4UYMsBOF1i0tnR9r1ULJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCH81QmAHe8pNLlZ31fAGffrHFrik8+dNhCAOjeXDbB4lR5i3RW3q3pQt3W+jyO64gcv3U/8Zcqd/qAbBQZIsxjDCLbWWRTxju4/hXAtcxHjeGgGwAjtLBsqFGTtJ095Ak2denoA5inGFpCxCmf0zo7OnTQpq5H5gcwoSaj9cy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UGrO3P2r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GMPEYHoi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 633EVMVc142249
	for <linux-wireless@vger.kernel.org>; Fri, 3 Apr 2026 19:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kZPUYs+b0mIU/ZhiroF9fq7z
	487yqQRqJHomPd4ooAg=; b=UGrO3P2r+r6lREb9nTHGY86LsAJi2v4vtUNIMr+P
	B83GBLnqnrEcPWhG8Xcjsxrs4u8qfhnziqy11jB7RZz+JnjhojA6HNaUriShUPi6
	pdpSnIF/NkXyzVRhNZ6YKCuFwT8fxy8JaUmUW3UUBjLvQdfdWY6OiS+wd1pmK/8H
	hhE98VOTkyPMSB2DZRdxQx5LX68pUOMOHAzL2YyOZmktBE7AGoog/hs2Ft+jsULi
	fGO2KxrAuhmJf4p45rvOA/Gm1zl6lHehaBfVK09D1mD3jDhexKB9erLJ2EpeMvN8
	iPFQxeB2Mdlmx1Dj7MwkxpFW63yzAaEgCq4q8dfoTZqQkw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4da83y25cw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 03 Apr 2026 19:33:43 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50b4b81c632so39548161cf.1
        for <linux-wireless@vger.kernel.org>; Fri, 03 Apr 2026 12:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775244823; x=1775849623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kZPUYs+b0mIU/ZhiroF9fq7z487yqQRqJHomPd4ooAg=;
        b=GMPEYHoiwl0XyGd9B47Ar7lB4lM8jLXKpR4tEo3USdcCJxiUpIZC/Vu0sGB5R7bQlv
         wranQwq9nw5CxHgFz1Pn3gdyCYr0ZcRq5J36srUIQ17TKXv13VIB+H/mgFRHf1yqJ+XV
         GPHhO9djAfUFA4TyplucupepKAQ6mdG7fMq+JTD7EJ1TM5lBzIJER2f9L54vOvGTttWb
         QyXdm7iHeC2gGOsxUsSPaNNcHCAV8YaLRxso9zCcD9lSz6Yy+KFwSJvON93gIWDCT9mH
         MqHnd8nqsUEC8FuAQI4i8J5QDSN8d/ohtjBhkmUswRoKf0V0Vjl5XyOVDi/pq9gsxetG
         dr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775244823; x=1775849623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZPUYs+b0mIU/ZhiroF9fq7z487yqQRqJHomPd4ooAg=;
        b=PyNiBRsqPScPaQx916DeaPq4PtIlC/IR/r8h2SfBDmGX2LkslL9SBNbDen9JKajoDY
         1rEkiqbCSg7XccN3v6MWr7cDJAWmei8ksDCRyOMb13KOCY7LenOKsJ31U9JJjEPcJOly
         X07sOIeIYC98sQYa0Z2JT6zAZXeh0HCCg2wCVlXZl8SIOKyrNkNaDHXlBx5VehqGBFol
         U1Jv9NghYGm9ac8z25yhGiLqWG31o3AiPu5bldpGZzmCNxzlXcyefhjbGJCvVl3n1Ctm
         xHJ+O/YbChNR86c5jg9AsW55B50QOejjndEWGvqOF0IwBFM4oSIspU0cBpzCggKTt1MB
         Mj0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfoAhR5dIgbheXUAXBwXdHlTuPsjDV4fO/5911MeeacnSidxghC5fYspLB3m44gnb2yWar8CHJ8lp7RY9TQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyI/ljAyY/V7FsTtbOM/E+YApKH0Xz+6ho/ZOSzQxClbViFU/37
	0aKJEqjmNLhou9mAtYuetw9sA1Nf9cK0VSqbUY7HpSn3jWnqUgAWVyij2G9JHM8WWhVB+M2ta2l
	th8tEves9o1lZHq9vBE9TKNecX9Bd55GdHL2m7rRsZQFVcK+WWJxuagWMQgQBoZV+6P0JWg==
X-Gm-Gg: ATEYQzx+o40uzd/PFrKM9/9YWKmU7keE+qKBAgEnG+N8Yeuku95JH8n74p888G0cERh
	EgTAa5cInO3PXxnrnVcI3bvs4AdykNoj70yabiWpxcCggaxpNoP8Z7Yv8jOVDA0qC+Osgxb4pRC
	leFGVWuYuHnTH/F//mKCqE3/jA86tZTkYqEE32WS98PwF3jczpY/pVsI8QL0q9jdSgHkDJAs6BE
	2jLINEx2g9sk9/ygSUv6X1F5YY0Jh+XgyN6o1GOuzrV7blP7SfXsb1zGbdcMK0TNTgm/9+Zzep2
	hAfQnu8SMyz1OPAQT32H4gX35jThJGe5VHZLst0L7Huo6O1kHgaeOp88/hT5nABTMTQywtBAjy5
	M31yhszHUV2tvE4x6X3On/pVGVdmVh1T7lLA+FsRI3FymLQEXuOR3lDPKW+dpkNq/LxFmO0kWsQ
	necZiRdXCLGGvyj7g1qNYLPPnb/I28O79d7go=
X-Received: by 2002:ac8:7d94:0:b0:509:1766:2f4f with SMTP id d75a77b69052e-50d62b24652mr60694431cf.54.1775244822823;
        Fri, 03 Apr 2026 12:33:42 -0700 (PDT)
X-Received: by 2002:ac8:7d94:0:b0:509:1766:2f4f with SMTP id d75a77b69052e-50d62b24652mr60694071cf.54.1775244822363;
        Fri, 03 Apr 2026 12:33:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6cd37b3sm1627417e87.78.2026.04.03.12.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 12:33:41 -0700 (PDT)
Date: Fri, 3 Apr 2026 22:33:39 +0300
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
Subject: Re: [PATCH v2 6/7] arm64: dts: qcom: milos-fairphone-fp6: Enable
 Bluetooth
Message-ID: <cwhd2tcs3asdxqcjspq6sqefx4srixgkje37hf4fylc24glqey@nkxctkq32hwn>
References: <20260403-milos-fp6-bt-wifi-v2-0-393322b27c5f@fairphone.com>
 <20260403-milos-fp6-bt-wifi-v2-6-393322b27c5f@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-milos-fp6-bt-wifi-v2-6-393322b27c5f@fairphone.com>
X-Authority-Analysis: v=2.4 cv=ar6/yCZV c=1 sm=1 tr=0 ts=69d01617 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=6H0WHjuAAAAA:8
 a=EUspDBNiAAAA:8 a=NEyQqhXCQXLKNWlO9YcA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: -1wBusEbxl5tJz_aGBXaTXGTk4Ceb9wp
X-Proofpoint-GUID: -1wBusEbxl5tJz_aGBXaTXGTk4Ceb9wp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDE3NCBTYWx0ZWRfXy5gSxq8fcsxg
 8ZOpLVQKA7XK2nmBCfCWjOOThQyEwn/wO6+I3Uo7o81/wG16wtfNtaUVjqVdGBBQSxLyPfNnvEn
 9AmGYXhjRPmTfJ9XW/VhmHH8l2N2Fxy6Bt0ML2FVyTqXw+5QcCdd6UvgD2ATizX3ddo/83Wie2/
 zakn953XFPvbEZLXUdn/Rbg8Uc3MA4YU6DzqMRhEK/o6GkAXF+737+8VGDrl4YxvgQeBi1uGlOD
 DWkZedsA6Jr9GD9WQpBh88gf5OdPBGO7+qiEleQxhJ7+Oe41YZyOX/GLCgvThke8zicAXlUEXT7
 DvRnfc7JIBEpuxUspvFQMoKn9RAwft8PTRqKRY9643NzzrPNQtDthkKKXAFM8mCGJe5MMSeNFDv
 VCQiwEDiL9ELTx2ZTw7OhDD1VzJGhxmhLCoCwFkB5bYeCkoAnJDEGgAKvz/H7Ys2iRa9YY7wpqk
 LB4hIoMrEhL14IBYTUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030174
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34340-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,pm.me,gmail.com,holtmann.org,quicinc.com,sipsolutions.net,lists.sr.ht,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fairphone.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:dkim,qualcomm.com:dkim,qualcomm.com:email];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 840DD397B08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 03:52:52PM +0200, Luca Weiss wrote:
> Add the nodes to describe the WCN6755 chip with its PMU and Bluetooth
> parts.
> 
> Thanks to Alexander Koskovich for helping with the bringup, adding
> 'clocks' to the PMU node to make Bluetooth work.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts | 174 +++++++++++++++++++++++
>  1 file changed, 174 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

