Return-Path: <linux-wireless+bounces-34969-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNH1OLvd42lrLwEAu9opvQ
	(envelope-from <linux-wireless+bounces-34969-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2026 21:38:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E22824221E1
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2026 21:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DABBF3007232
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2026 19:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D6133A6F7;
	Sat, 18 Apr 2026 19:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iPZXIwGw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GvFRYeH2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E4130E828
	for <linux-wireless@vger.kernel.org>; Sat, 18 Apr 2026 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776541108; cv=none; b=U7ZAjbMXC/ib+F4OAcV59dz5Z4Vs4KUhvJ/aYJLXIcMg/Y17z2t1dzILZA9ZqmZqdzMM7fdTTAYQq1NoFP/6UIQn13BFXgxNkFQ1b2CsQgEjSgMYv2naiYRHOrV2jNMBZuV6RQRa1FeEj7Bt7uYK52kf1mUkl2iQZZFFCKHaSZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776541108; c=relaxed/simple;
	bh=D9bDtXxW3hYg3zOewGGHaPyX3bjoSoMDKPBs+JVD+jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRqG14zfGpQfCpM2r5sz61XrT4kLo9g3UGtcV3K3JE0/8t9heFx4SlpsL79tCyKmtOBQ3QLmPEAgkBtdH/jzxWSavOiVhdtZZ89gZ6zcV5rnNWfMTvjhcw2RlvhZBSc3I19rw0E15YK6K1nV9Cy4W1T9Q958llokyNe5sQsvv+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iPZXIwGw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GvFRYeH2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63I4UU17296894
	for <linux-wireless@vger.kernel.org>; Sat, 18 Apr 2026 19:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kbwvqRx22EuSdW1o5avcOXEZ
	l4XvhLf+30K9TnHpX7o=; b=iPZXIwGw/DRx+Zt91iZVqqLZHLhQfaqwatR2rPg1
	i8q/oA20HMpxH46pXKnyynNMPPH3db0oFL2PK63Bs7E27TI5ymG5qeIbZF5BvULk
	fRL+sK6vkRG52aO4231tZMZp6/iiQg6i5CfN59YvFzpx/VShtp1gXg1vrhaOqV+d
	sFE0aHqta25IQs3krIY5t1bY8CMV3neSQM9FM4XkgLm9RecZM35805nez8FbngXI
	oSi3ULWHzpk6HGHHBH/6wUwPVCfWam5B1MN7PYZg5E1pyeEM7b7ymoyHzfk2d+Mo
	pacK+MXqrVp5Yz+tWcCcwbV9AGMreEJX2ukMqJDehzcNAA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm0wr1gd2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 18 Apr 2026 19:38:26 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50d826ed6f9so67528541cf.1
        for <linux-wireless@vger.kernel.org>; Sat, 18 Apr 2026 12:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776541105; x=1777145905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kbwvqRx22EuSdW1o5avcOXEZl4XvhLf+30K9TnHpX7o=;
        b=GvFRYeH2nJbXQnVmTxae0cy5BJ8CC7+i6hHTuJzCbz2DZFQuqsp6h9lsSypaJ+R+cI
         jah43EYBSdWQPkMBJjUnHE3D3EJz4oShRVHehZgZmrdRI/vh6JqMfaY3/CAUzsagDUif
         odZGQ6ir9XhXkXSZX0iC6WBSmaCpVKaIiO2H59+3lW2cE/HmZl3WtLyBFpiok1/7vgHy
         l65wNvqR2nMICFVuR1Ly0GKJkTSrCUBtAW8nkQLStdyGAp/xHr45qG8f3S12jxNDg0W3
         mknq8FT85rCigmT+2sj++Ytf0n7KH6U+JgqhVR8g0473fOUeLVokq9RNKiQ6jEpdvRYz
         M61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776541105; x=1777145905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbwvqRx22EuSdW1o5avcOXEZl4XvhLf+30K9TnHpX7o=;
        b=kCslq0gdAt6PB+qfgg4uyj9z+wMZtLd3FUD6+eIeZF+NuYRHWVrCW34PYNQiRfoqfL
         ETP/KFmv1e10l82erXXL8pQ3Gk6mQcOIKW7XAK+ZSrVHuc1yQxUwHzRH/ou8wYBtg1Ka
         2NnDPBauDpiU1DYI/meK4I+BOaVielCku9KU2JUv1NuIDaAiRjVg8dlH+hNB3goqyyn9
         nVEEFklXrbhwGcJPjkzEE41jOQHP1Sk+3uIY2uRkEUQtxEEcCR905Ot7yShSP8CXWKVq
         TrDlg+oC+pVp46vfvR5ibOppCWUJ7FE4nnVwvMe6m3erRdZ9SZdUZ1cCsuKXJ8wx9jME
         J13g==
X-Forwarded-Encrypted: i=1; AFNElJ+MN8+hwRvGyi5gvoqjloSziPqjxTJazeCSl16cyx7tl6mEaVMsxVEmauPP2IV9m7YNFqJs0FhuGFmH7eGv2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqNfoEljlwAfrUF/tXdlXSo8wj+DAZI7WuIiK8GQogMaUkInYq
	NF5zZa/cHRWkmXcP4eX/EjFGeg53wZVPsEivoR9MA3JM7yb7D/f/tvA6VkjIJROw94rWqNmchMj
	yiUSpmzDNLIBaAVrulgWxp++iAZmK00ItVEgTQ6TWpMMgRQVIJ86XtXWWLUjMnTisXlSgBw==
X-Gm-Gg: AeBDietzBZl0Fa4XrPaF9y/X9L2/NFKl6E/FcLPGByrm5y5xoJZibpcO2CEPuVaD4yC
	d0ME/HjwiOhLACt+lG0Msp/Hbhi1jVuG3Yfh7/keBOvdy2k0SO7cPzDss2GGS8ZyCXTKJte625t
	C4gCWy8XcfM2AOzLnWys8pb/zLEXRPzezVCPIO++mLkj5tOejxtYFoatBVAzlsT9k4mHrE3L8fq
	1bqQkxdvW7V/dDPy6ymVitwRT4zGlPcIPRPbAOgUL0EC9m8OkYJRr7+03XH7ytFOwY8VmHx7omZ
	y+iWVX2XBtXkUA21atM9T0yzSbPOzrsu6RWCVl2OnwipfyxJiQTOveft6XGfIOuUECxrSmDn3wj
	7Wy4Il+Dll50xWKiK0wW+RieuB90EBgDApxb4EIE6yR8q9g3pbOFU43aeDTj2igC4jqo7/p3FoN
	W3afzaXJQ7+1CRYWESqLiWMxp73bFiM4ZEZ+hmvdXdrjny2A==
X-Received: by 2002:a05:622a:48c:b0:50d:9c1b:941f with SMTP id d75a77b69052e-50e3661b147mr97389941cf.8.1776541105492;
        Sat, 18 Apr 2026 12:38:25 -0700 (PDT)
X-Received: by 2002:a05:622a:48c:b0:50d:9c1b:941f with SMTP id d75a77b69052e-50e3661b147mr97389461cf.8.1776541105035;
        Sat, 18 Apr 2026 12:38:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4187e7dd0sm1553387e87.69.2026.04.18.12.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 12:38:22 -0700 (PDT)
Date: Sat, 18 Apr 2026 22:38:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v3 3/8] wifi: ath10k: snoc: support powering on the
 device via pwrseq
Message-ID: <hdypom3nioc6tk26gh647imy5ykhcjqvknideilnbc2b5p7eo7@hm7fsscleutf>
References: <20260119-wcn3990-pwrctl-v3-0-948df19f5ec2@oss.qualcomm.com>
 <20260119-wcn3990-pwrctl-v3-3-948df19f5ec2@oss.qualcomm.com>
 <DHUHU7UIT487.139L3KIVRVREU@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHUHU7UIT487.139L3KIVRVREU@fairphone.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDE5NiBTYWx0ZWRfX4E+CR/3saNZR
 BCMIJeAfIpRQv5lHZBhLSNu+ebRnxwzafFvBy2mLnAtZdp7EYeY88pkeDk9TYrWJ8IFnppyH72H
 Qd5Y6Dx1LRX9vUguyUlqLJUrnkV4pbakehoPLD4DxDBmmzTjOXyA+RT9LBKfdA7KDuQJ+NbE6/h
 awNyw+q0r92ivF38kWv9UqT7QSxNVBMf/nkJiowmHS7n06CccDm0ytH9eMe1k62BUETwhbqHasj
 gFgZxEEC2gDMUNILdzBg9eW7+ccDNGmHDoiRUT+NPiVaX8OMiK8TrImQN0d9qdEFN1jZ992zhjk
 XPKMetlFu6tIY6BPFmr2Vbv00oplxeiAtpF7pJ0lVpiFfxE3fDjmBrH9FExleLPpEyQwPluj8Gm
 ljXMgxYZWCc0QWQeDzPacz97c3WPJlkosKam0EA87UveD8iB8WvQbsk4b+Qcu5BbEkQFj/Qmshj
 UtBHuu/xfqsF8QvHWiQ==
X-Authority-Analysis: v=2.4 cv=G9Ys1dk5 c=1 sm=1 tr=0 ts=69e3ddb2 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=Rs7pINfTDodmtXVth3IA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: UxrEXDkCuaSorXpr_bz4Nq4hqyeqCnxF
X-Proofpoint-GUID: UxrEXDkCuaSorXpr_bz4Nq4hqyeqCnxF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_05,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604180196
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34969-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,holtmann.org,quicinc.com,chromium.org,vger.kernel.org,lists.infradead.org,oss.qualcomm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:dkim,qualcomm.com:dkim,qualcomm.com:email];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E22824221E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 12:06:09PM +0200, Luca Weiss wrote:
> Hi Dmitry,
> 
> On Mon Jan 19, 2026 at 6:07 PM CET, Dmitry Baryshkov wrote:
> > The WCN39xx family of WiFi/BT chips incorporates a simple PMU, spreading
> > voltages over internal rails. Implement support for using powersequencer
> > for this family of ATH10k devices in addition to using regulators.
> >
> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  drivers/net/wireless/ath/ath10k/snoc.c | 53 ++++++++++++++++++++++++++++++++--
> >  drivers/net/wireless/ath/ath10k/snoc.h |  3 ++
> >  2 files changed, 53 insertions(+), 3 deletions(-)
> >
> > +	ar_snoc->pwrseq = devm_pwrseq_get(&pdev->dev, "wlan");
> > +	if (IS_ERR(ar_snoc->pwrseq)) {
> > +		ret = PTR_ERR(ar_snoc->pwrseq);
> > +		ar_snoc->pwrseq = NULL;
> > +		if (ret != -EPROBE_DEFER)
> > +			goto err_free_irq;
> 
> I'm fairly sure this is now broken with CONFIG_POWER_SEQUENCING=n since
> then pwrseq_get() is returning ERR_PTR(-ENOSYS) which is not handled
> here.
> 
> I'm observing my ath10k_snoc is now failing to probe "with error -38"
> which definitely seems to be related, but I haven't debugged it further
> yet.

Posted https://patch.msgid.link/20260418-ath10k-snoc-pwrseq-v1-1-832594ba3294@oss.qualcomm.com

-- 
With best wishes
Dmitry

