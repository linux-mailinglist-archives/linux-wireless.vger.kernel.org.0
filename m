Return-Path: <linux-wireless+bounces-35731-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKwECDTL82mL7AEAu9opvQ
	(envelope-from <linux-wireless+bounces-35731-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 23:35:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A14F4A8441
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 23:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5314630ABD48
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 21:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3AF3BD648;
	Thu, 30 Apr 2026 21:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZrGxOElO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P0szqsM7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A993BC695
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777584654; cv=none; b=eydSlXRT49eeZVw7IcR2v65M5aNLR8IrxrY9ARBJuq39x1wys/disU7PlUUthL8L1msNQat0ZHvkMEi1DT8pHFMkjCrBIBl43SzpckLaZS+LuvqM/59plPp9ow33LPbk4Ic1ZMilMo13G4Tph2C2ekzCj5VV9oblA2eG6UaNxAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777584654; c=relaxed/simple;
	bh=BBaWX5+0ik9h6+P7M3E4waZsVzwKBPqfhLqiUzRw7Xw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=haBwEH3Ituh56gXftwPKxugEm3gQw3vz04fQNV6brx3te2FaNPZ/b6TM4v1J9hqQKcPt6xNkWdFNxJxe7gLFe4l4ku3Fzviz4lFAgxfoPBCh7Yafo6UqM2AErxwo6QjQf7QRkzdICVaPiNvmgGsvd3k1N6RaeCAEV02eJfTIOBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZrGxOElO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P0szqsM7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UGITv82121519
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:30:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uytwK91gAW1pt7JYIMJ5S2V+aZdw+oowu1MjxGCXUnk=; b=ZrGxOElOtzl8/qMq
	TJ99FpwoeourjNBU0h3OhIJWbr04dQ/YH0SrIl+u3GfdBnU/gMcyY0iQe3J560I/
	ve3VDXlp4uROwkH2dN3rnXOc0cxDhWvHMviSLTv1fp1graYmoSh1y4a3YRuUcAV7
	1cLLfWKWxcTPh+16DpBsxL5z7PRkFMbN2/e9zDSUEDlP74ppMFszZLR7/r6UfdA4
	HtWjBrOlrfpQVx46u00IftzzqzxP2cwOJOfjhvb+kFn36Idh5ut53VcBmmer2ssz
	0qsfPzxb1oJyahEXQN/wDrNFJWeRPO1oXm1LfXs4UEnlH17wRsFCtnCrcXi9bonO
	FVqXng==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dvag4sc60-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:30:52 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2bdd327d970so936985eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 14:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777584651; x=1778189451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uytwK91gAW1pt7JYIMJ5S2V+aZdw+oowu1MjxGCXUnk=;
        b=P0szqsM73UeUCOms6NTutERO6B1vOFGffLqje+gDP0esAjIGOmaAt7fSv0at7GG3Ug
         i8vrKHov8hrgI6DPT8BQ1rccamGMTJtmoNlwGo065/5lrjNcQXpEYKmICRbl6rFQRZ1m
         EagbihKfrqwPpwJ/NcMWmfDB6sUAWkt7IIbgOt+cy/wU+Lfi4Hj5wYO23jAVxmnMMj5T
         wLqRZLNxFTiETCDMHv+YNb7FEQH/oOWaDTLaWiGg+yuOTBlSe4NeOhwZpO3AJIwY8O7I
         gO6HybIt3Nle+ipahB+3bXGVLLXHIiabLN1sL3rFd+NamQPuWLTG8bugy/PA4yBUAtBF
         d/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777584651; x=1778189451;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uytwK91gAW1pt7JYIMJ5S2V+aZdw+oowu1MjxGCXUnk=;
        b=G6CLI5O4pyOGk+o0pALItLpk1ZiNr/ZgW/LQndC6JQSsI/BFN50qOJo89F+49ybkuv
         w77Hmog1JXTt0pk2oN1b3TSna1tHYgLwGjhBOlaH+2TiqEnbX6n0c/Rl4rZMlIRU9+q1
         90DCOylOOU5vMcr9B6cBVeasA/+Ux9DPDcJitueFsijPTsFjBfn+dSXBlaogXCBEHMkn
         enFxWM5dHf97Ev4Z1DLHIVqyVP1gHb8PjdNapiP9OJsENkGj9Q1h3mgCoJGOkC3HxVfc
         SNMTPnjyVArJ/21WMZAbr5EefN/HI3fS4ahtwI9wuVBYVer96fc8rvw2AVExkJjoKQHu
         IW/g==
X-Gm-Message-State: AOJu0Yw7e8FYg7Gd7BVpLGtbN1ct01ncYN3EP2fw7Zk3lpGy60vawPfV
	kz19HlVWudVBT+1AcIqYICkEXGWxLNKwJUjTAZk2z0f5GayOZWLucXmt547/0XblQI0gegjXPy2
	CY+UYvzvdSQZ+0q13lqcTAjxmSTWW0k0u5tctBWIrawczA7zEltE8fbNaaMOIQa3veTyLmSUSdL
	mmow==
X-Gm-Gg: AeBDievVm+RRTYyMtN4qikj8qFuHftpd0VrTYXh8jzaE4eZbFRN446zzr+eMH+Kvic+
	jeHhAevBcGdYPV4AAj3ui5A576LwfyKDTou83k5cFJ38M1pH2JQbWlzgpJofa37zJxcjZ47FxyJ
	ym9qP+m9H3ErMA99C+vFZTmGOj+LcFA532LTxz9t4HuF8gMTzI1DMCh6zhMwdX9S8c5t1r9IoQX
	Fc9EYbJi0qLAW4Jz8OpIR2QZ1DG7q33MvY2foKJ9ICxCGKYm8Mibs8Aco9NwY+x3v27gi0dgmBL
	GQvAd8JJLvHDWkBquivm2+de18gx/DTTBvKkltbZ0TPAAxelYhgDbMObG4ju8vySX2p8maufBPG
	H3abWa5utv7CoGyY72IjL3041M9G8x1int2dmjYc2UM+7UB7oBHFkgmqCzmJfH2GuLFqHbb+jGL
	lwN7nk9EyZtFY=
X-Received: by 2002:a05:7301:1902:b0:2c9:ee15:a0ee with SMTP id 5a478bee46e88-2ed4e7f58e8mr1968586eec.12.1777584650786;
        Thu, 30 Apr 2026 14:30:50 -0700 (PDT)
X-Received: by 2002:a05:7301:1902:b0:2c9:ee15:a0ee with SMTP id 5a478bee46e88-2ed4e7f58e8mr1968563eec.12.1777584650206;
        Thu, 30 Apr 2026 14:30:50 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38d79eb9sm2504861eec.8.2026.04.30.14.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:30:49 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: linux-wireless@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
In-Reply-To: <20260421213544.6238-1-rosenp@gmail.com>
References: <20260421213544.6238-1-rosenp@gmail.com>
Subject: Re: [PATCHv2 ath-next] wifi: ath12k: use kzalloc_flex
Message-Id: <177758464918.1848985.900364470995895282.b4-ty@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 14:30:49 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: 9gBFEdUT3zKkwSqe_aoTro9YWayOYqXh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIyMiBTYWx0ZWRfX6MFMZyLJDOOd
 mFqfsJtWsIAgiFz0pfP7gvOMZabozcwtHhV6yLIywhW5lCZTcbG4SEIxc9jQEthoAA8ydloLE+E
 WXROa3nh8e99jCjXLVTfiYHCH868CkaaQ3+gmghV2vfKOqOYa7QvVmXiZp3I/gb03tmw68gVzK2
 BBQQI6MIlBXowo086GjzYtg4sMSqcsGYc6O09xz50e8is0Wo1ewwASC17FGYxVhdNPPkJehqH2r
 UjOsK6O+ypCzB5RtNis8kudQ8Cq0bk04vEjzU6fm+7MmVLigZ29oRw+08SGIOufFUP82Gw73hmb
 eRNOS1ujjnU54xbsf6hdDr++xTnFNCQbkDbHmdfIzHDSI7Ia97uGDmdimm+0VKtM9RUa4krHrwc
 ILPDhqHcM4bTrUuU+VeqPwLDF/g5QaRxjlvvZLtOGfL//5Kexe3JJYpaA45zlWs3sjS1m6bxg/d
 YRsGBTNEcdu8aG7za8A==
X-Authority-Analysis: v=2.4 cv=UcxhjqSN c=1 sm=1 tr=0 ts=69f3ca0c cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=rJ_IYOnZYG8bJ-BjWygA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: 9gBFEdUT3zKkwSqe_aoTro9YWayOYqXh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 impostorscore=0 adultscore=0 spamscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300222
X-Rspamd-Queue-Id: 9A14F4A8441
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-35731-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]


On Tue, 21 Apr 2026 14:35:44 -0700, Rosen Penev wrote:
> Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.
> 
> Add __counted_by to get extra runtime analysis. Move counting variable
> assignment immediately after allocation before any potential accesses.
> kzalloc_flex does this anyway for GCC >= 15.
> 
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: use kzalloc_flex
      commit: d88c3a5117c58e1d93c20a7c723a6ad23136a430

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


