Return-Path: <linux-wireless+bounces-33868-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sK3oGPs5xGlsxgQAu9opvQ
	(envelope-from <linux-wireless+bounces-33868-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 20:39:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD7632B57E
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 20:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B8AF301BC1E
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 19:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6332731F983;
	Wed, 25 Mar 2026 19:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jke5vlqL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XUwb13Ck"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442462D97B8
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 19:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774467551; cv=none; b=FDhLfUuCaOFTfEkAe3YdoZI9om5EH/AnYCl9Ohz1b1fJJ+T+KZ2fwn0JpRChMeGATc4+lrpm7Ixywm8tJReH3GAQcJmpRpSZKAEAvQaWDK7XcfQ6cSJ/cn+TnSN3bJqI3+ioakDGZyZ0gLN0X2zzRn5dnsbVJMeBRBEX/LrFS3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774467551; c=relaxed/simple;
	bh=mARsqTbZxbkeBHP4zgmLOL+PjHsYiG8qZxdV66rvrfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3lpVASSStpA2laekxGpvxx1LN2Um2TGUNH4r/7360JokUcE/K/47S7BfJO27ZEwwkcRlum77TU+qQFLaHBAg6e+5btkUspHe9GmVXdk/XUetzgJvi0WUBRJsdxQQb5wBEdY7+g968eogdy2yDKe6FIw6WYeLQsRGbGzl3s8UX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jke5vlqL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XUwb13Ck; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PFH3QZ1257960
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 19:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=VRX2TeJnAfqK61YrX26wKqVI
	j6I4aVlTC7JyT6LMrPE=; b=Jke5vlqLOymrsMkJIXGnGSKhUONpLkcA6PDaM0B6
	AWwh5Z9j9fz351ENI0ktAtJl9KNzS3r0sgSMlxlTMFnKsJyfimnyzbC87+2R7g1X
	YWqmDUOr3mQKoG9dUUGB2uXOunzALcWuQHF0wKSPtFtaXuzqkTlE96AWUVX6d12G
	cG+fBupcCN2s3QRBJEs11/xzCKxRT5edwla9jJZkTAhJf7pBdreCsiZ8RZ48Zb+R
	tcLx/TwMuT+WEYtIQFOoapxCo3CoV1gCpjbvBmxMnWqqyrczPcWvWxbZQI4mAx7A
	0mqGfuwWBd4XZGC/okK2znzqDlbwaQbnGt6QyslMRxsfnA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4dm2t3k6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 19:39:09 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5093b92f327so13893171cf.1
        for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 12:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774467548; x=1775072348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VRX2TeJnAfqK61YrX26wKqVIj6I4aVlTC7JyT6LMrPE=;
        b=XUwb13Ck+DZfq+gLo7vZb97Krg8QTlfQGTKEpCHv6YZGl8Ms9hfIr1W2T2fYD8TjOv
         3Uu3dSKpWvcYrfVuAT+d2QMJSVhFYtHe8ZkR4XaK4iCup+8kJ/isUQcSK96vxrgtg423
         yl56j0Q+zvq+LAzKpHzR08UOPXMx12QvxvkH5poOc9nFo7TXpv720xMm0atODaQRsggs
         /7Y0AulsV4fLBtfFYUpdiYD1ykoRBVET69xUrQ2oaH0atwV1gc7o4LKnfgZBi/+mz3tu
         AdLeo6oRtHSQRFBVRcC6pFZ5Xir/HL6YlwQR8cAXy+l9wcqeFEIsZyzMLy9fyx2onk90
         RiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774467548; x=1775072348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRX2TeJnAfqK61YrX26wKqVIj6I4aVlTC7JyT6LMrPE=;
        b=STdYBRtToP/x72aIEv70OqTEreWzlKsSe2vPRy7mSfOUCP/snmYkGQuru53C5aZvlu
         Z1KrTbBKPkePBu6Ea0jkF9krk/F6BZ9DCC1V3OrNc0peubxSdqBYEynuCd31SmxrRhuO
         +pMnch96+IaPE+T9DroX3bxc6FOAn4jO01vUVL8SyC2vwOQiKTvOJDL8WdMxrnb7+cD+
         IXt74mo9IIkICuCt2oSCd4SS24PioTTksL4s89oADv9oOvam3vkT3L+rHo0ROgl+9TO3
         fDQpf4SaWHMhmRQNt7EnnUw8CDnDGM0oKVsVWxY4O8ct1Ch0xfHJYDwcmEZNAqjKfZRy
         vTDg==
X-Forwarded-Encrypted: i=1; AJvYcCWGUBr7j9Vn8xdeD3vvpyhbXNAVy1uiUz8H0iZ2WzqUu48wd0v6kF/rF+p2Fy5cBvx/3hCmdhfoFXRi43mC6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoFfm24hhB2XoGnDuw1BFLpR2cYS2QSOLRB6ng4DlXmHzhUXBe
	Ek57VmGUFqyCroN+Jk9RbV4AnvKIoZsS1tEU66LNS2RW+CvlQCE/UsxK88r+s3YB5L0y9d/p8Fp
	DHecPp62zrClwLRrcp7LoNB6xfYF0rRaBxljgATVvY0OlrpDPBmzr0aRTSaVPf8ijU+JbvA==
X-Gm-Gg: ATEYQzyaGUydrJZRIpbJC/SG5UYuiH6ZPAREWa2IBYDZaOR/7H7kPVWuEVmxVNTODqI
	+pCsLvXmWCppG6tsQmLaKJS9mEBpn3yEinKh9DFaZoc/4tII8RpySrm3yUNkxqMP56ZAhsPPC2F
	fCOZXdFRaq+WDQgYJ1xkouJuwLvL4DeE3XPvTpjyDeVpeVP7Nzerqqw0BhFyybGvMYJWBHB2+uv
	+d4JkJVTn/HtJnl9KWmdL+Y+ZYHNNZnLerX1LZ24BrKFmdMrjlIt9FWK6l1S8d7fHwW4KK51yZi
	4jmEEUeRoC2Nk62tz5Qxt1NCxr9oYF7aC09m3iEvzIDvN9SVQJyGXungwKCRPiqV5Xsp1rIvy7K
	FU7eq4tKq4fdlnWVtwaihH8LR/wzKnVqvmXf4FUqO1YvyLOjX31Ncbx3GdRS18hVwExFFtTzLYD
	ZhPsG93L2aOgjWF7wUxeEJfccMPaR7rzlbczI=
X-Received: by 2002:a05:622a:1f9a:b0:509:120d:4311 with SMTP id d75a77b69052e-50b80e66563mr73669851cf.60.1774467548228;
        Wed, 25 Mar 2026 12:39:08 -0700 (PDT)
X-Received: by 2002:a05:622a:1f9a:b0:509:120d:4311 with SMTP id d75a77b69052e-50b80e66563mr73669501cf.60.1774467547795;
        Wed, 25 Mar 2026 12:39:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2a068f8c7sm91843e87.65.2026.03.25.12.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 12:39:06 -0700 (PDT)
Date: Wed, 25 Mar 2026 21:39:04 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-firmware@kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, jjohnson@kernel.org
Subject: Re: [PULL linux-firmware] ath10k, ath11k and ath12k firmware
 ath-20260325
Message-ID: <4zrp3tlsqytyuxau5qk4hnlsht24f6vlgv7pyhb5y5cswgn4c3@4imh6ktclmfd>
References: <32af006e-265f-4239-9b5f-be3d52996e10@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32af006e-265f-4239-9b5f-be3d52996e10@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE0MyBTYWx0ZWRfX/5n+lffGwewk
 6WeoH3XwotMy6KM07yGaltsmefWm7y2fqnWU2cAb8TUHHSnDeGRcmJEuUB8EInL9OliTyB5lx4K
 cK5anE7CO/Q7oyKMABwixWz18AWUsW69YgyChXDSmfb7zzwHvHEh9844NFsx++NwSNtm8SlvVue
 bhi/ozOaIYyJ2Fdl1Vk98FUbpW7qhKZo00TwGBwvXYv0WxDwVEqrOrgTorIGQo8Qfm+uZm0aiIT
 s+7MmkaPpCZX9yRGWpHv3NpicwsQeWI2EJbVRX7a4GUOuSipgpEC/u8QpBGZqu/AlCnSvScdDXa
 nIk+OE7mkalN04ch9C1Q3qD0siVrhGbkmzLWdcXKL/q4rQVia8ayZ5VLfo2qelpKG7qGqjDSdvK
 WgxDyPJc4l58rGYPhTXXZNGQrk1GnSVaVEZhDtKeYDSsgkBbJi2GoBMHGZiopEAMZ1yxA8HrPX8
 N+qzn97DRlOGfGdveag==
X-Proofpoint-GUID: WqB9JvmzDetiJj4KryX-zDOeErCLgE0V
X-Authority-Analysis: v=2.4 cv=Fo0IPmrq c=1 sm=1 tr=0 ts=69c439dd cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=p0WdMEafAAAA:8
 a=FOHEAjDUwq7NbCT47RAA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: WqB9JvmzDetiJj4KryX-zDOeErCLgE0V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250143
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33868-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BDD7632B57E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 11:00:04AM -0700, Jeff Johnson wrote:
> Hi,
> Here's a new pull request for ath10k, ath11k and ath12k.
> 
> No updates for ath10k or ath12k
> 
> For ath11k:
> Update QCA6698AQ and WCN6855 firmware to address a WoW page fault issue.
> 
> Please let me know if there are any problems.

Thanks, merged and pushed out:
https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/974

> 
> Thanks,
> /jeff
> 

-- 
With best wishes
Dmitry

