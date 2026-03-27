Return-Path: <linux-wireless+bounces-34022-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJ/XJdjOxWm5BwUAu9opvQ
	(envelope-from <linux-wireless+bounces-34022-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 01:27:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF2433D8A6
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 01:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF08E300E243
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 00:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AAF188596;
	Fri, 27 Mar 2026 00:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GsMxGtp4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dC4jsNdW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2BD242D76
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 00:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774571220; cv=none; b=joPc3nuyIFAYwoDq2uiw0N4dUgN+l2XFd7JxR04gbONmb/7KM6INU1j9JIbMmuDY03GN9RaV4LACSLpI96PLYVx3Pg4H7QrRkgF/SOW5rdWywWn/eFyzL+UrzFTS9hqiY1xDAetlRxRSFG2Nh1byGmTelf/bkmRbb+Bbym+F3O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774571220; c=relaxed/simple;
	bh=ShWiHqRGPPPIWGMBC3H4ALRjoh9GyuzZo23tHknM3x4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UiQbbIJBQHitMQHpjMulM//X/a3h6ADEcA2/eYTFI/y3huFTtn77DYsJFVdzh06nXtiTIUDcxkHC5jsS2z0RfbPiCdiVR6l6dycvsbDqsFNgeXSX2YzlwBvaM0s3lucUpXpdAN9zEheP1UkBfyTogcDBbqbaSjl2mgCH0sKx64c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GsMxGtp4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dC4jsNdW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QKXt0Y518135
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 00:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uRp5E5Cqj6XS3IIXbI02AzzrssjpWSEql11vhvr6ENc=; b=GsMxGtp4JTUdiUrI
	gIQPX7iCBEaJV2J8utFeygXKyCUD3sC6ubu9JO3xTea8rvUUYqvOfBnf/I1NkrJ2
	l0XkZnhpuDPt4pUTpdhi/u5LWLAOnHEqy1Q7vL00NgJrBNaRsZel06/bISmIHoOV
	10LeT3AYxwzQHn+n1QU3KNHXfPUtb38qLaqOsZEPK9UIthqoCuphv4dYP+GdBakG
	bLtZHqZBXY9QpKpcGVIiSc5VaA/YfeGPIDwmlt7mSW9o0uaH18Xj+vbQP++sHPV7
	d+MZDVDSVcN4dCt7Ccj5W+ZZ3vb7Vchm+au21TYBPah8O17PMNcOhtLoKwua7YCL
	X0Xyvg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5bxv0j1r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 00:26:58 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2c18175fc54so2106490eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 17:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774571218; x=1775176018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uRp5E5Cqj6XS3IIXbI02AzzrssjpWSEql11vhvr6ENc=;
        b=dC4jsNdWTN71oDA+8tgvnBImcY/cqTUDJ/YcLNszXNxza6bDRLtEFXyXZAf+H0EGTO
         Z7vtFax7h8f3YUJ3kGCVxHFxWju6bt893/qc+dlc11qxnCSumPhi+rGFecqk6xQY2VnJ
         ZuJZ1MMMB5tTrQFB0TiZG64f4uhk4E/FURZTdh4Ggc1NrqEalbU5RKiJTFFsVHSNdrnS
         7XdBlHzOZqaNOVWC285JWGaGVhVtlEToBmnJyh723dXzkljBLQRnuJIIaYUYEYVdFok7
         KRgz7bi+g8X9Ka+/ctiq1Ur1dL2d2I7OIj/PnqZgp6ptEMf6IXMF0JX8mTYy/e+X4442
         xaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774571218; x=1775176018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uRp5E5Cqj6XS3IIXbI02AzzrssjpWSEql11vhvr6ENc=;
        b=tSHSPQK4jZsR1LQfILgELp+lMT83VroTi7o13WxRtgW2DJcgA7kSkBv4AAIMbgNkke
         IkVw6fo8KGFzpzmHMeMPVfgC8o9aNjE0GKHDouvTIkmwoMiSoIT/vVcBX4zpQ3tS8LFB
         Oy3IsCNX8Ouhdbh73GcfpDC3Z5QMX/HFFnwxRRS+Ryv+1mLeFtyUNoty35IzhTUUwBvJ
         graVDgyak/EIfbW1Hb3/qq2qxnJ+JWb25b4+KAOkG7g4JQ8X5VGS/5oGn6FtEIqz4j7J
         /xA4+WOYuT9EMJq0eANjtlPtYDbHQRe7pLD49gyoO6KyZ5SdtVl4rEustJqcaMzFnf+8
         X5Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWiysPVEtcLQF3gwZ8XugctQ3L9OYE3f5F1D4OywbW5FSA+xYFuBdrWNjgyXVt0RKGkvOl+gOGoBn+qR/kCaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxH0UXvzruMayDBVK8r6030UdMBLvfwSFEZACKaBayxeyYPB68B
	4IdxmfrhDoiZXS1Vh0ZuT0mtDwEHaS3vAuyi1itKKLO1T0nHVbT1imDbM2vWFDVZl9TvL8veiRe
	9h9tN4T2TL630oJJnBNxRq3qg/eXu9tceQEDMyuIqaVCk9Sm7UaGyt+uFK/k6RmdlEfqq7A==
X-Gm-Gg: ATEYQzyFA4dE2eblEPTgc5kQnRKzbA3OZszxBtmvsT1m8/oHLJzMOW3/dnxMVb8n2uf
	zRjnbmSkR0f7MUof7wrKWvxNBqSBWYZmti8AhVfYiUlWq7fgAlk/XEOv06xa+GkI53E7tynyd/w
	mbrTlBAmvYRMWCCl/NwTscUf2NRkvk1cx18QQ2hWMCWM2LzzmroifWU6EFbj05NcREYkHqwiA4Y
	8O3kfU/gV9XBpctU7alC0RyuQAZRmdPNoMHFX44W4e4AezsGNnRUfYI5larZO1wjHAR9IAsMM66
	jYuYEjtN3GVn4dQgAGPUKTr3yOEjx9Ceqp7pX5SQ0VhkOe7E59nfC17TtBNCoPkh89MklqCpvhe
	JteuCvebhgUx9w0dfLbEXiM0SijinJv5WL3+PcooPDePrGgW39AwmWd6PlRmPYtkoS6xaW0erDB
	r1T3buEruyqbVBlQ==
X-Received: by 2002:a05:7300:2316:b0:2be:171c:5047 with SMTP id 5a478bee46e88-2c185e074e7mr354420eec.14.1774571217735;
        Thu, 26 Mar 2026 17:26:57 -0700 (PDT)
X-Received: by 2002:a05:7300:2316:b0:2be:171c:5047 with SMTP id 5a478bee46e88-2c185e074e7mr354394eec.14.1774571217187;
        Thu, 26 Mar 2026 17:26:57 -0700 (PDT)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16ec2690bsm4581516eec.5.2026.03.26.17.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 17:26:56 -0700 (PDT)
Message-ID: <2c90c306-f285-4ea7-b795-37a0f14ec27b@oss.qualcomm.com>
Date: Thu, 26 Mar 2026 17:26:55 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next v2] wifi: rtw88: Fill fw_version member of struct
 wiphy
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <3701cce1-42c4-4382-9120-cd21012c1b21@gmail.com>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <3701cce1-42c4-4382-9120-cd21012c1b21@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=A99h/qWG c=1 sm=1 tr=0 ts=69c5ced2 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=HveQkozfOfK74m-52VMA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: oyYufl7Hgf2USpjmnYqcZTuW0wvvHesS
X-Proofpoint-GUID: oyYufl7Hgf2USpjmnYqcZTuW0wvvHesS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDAwMiBTYWx0ZWRfX+Icltqs/HFG+
 iNlXTFOg5ldxjS7aqWNLiH7FhxJrbcRYkOPbXb+hgRBju26fg1p88x7eOR8f+qMnFz5g5Fu1MEZ
 of57L9ae6MK0C64vltgGv4Io3epMM2j4w4OLyEdtR37mf4ZG5HDRPW5su+7Z/TQxOljZOQ/JPl3
 cpo8ewlk9mHAzp5xlr4eJvF+0rTwEmmHwMxrv2pz7nX4zpis7bDNoDqTH8cH9SFenY6dZEzmj1I
 irau/lEgqS608xFRdTOy5i17QD65s6XXdLwp6x0FDp8HNhZLs6sdXC/2v5pTC1mZdpQQRRhAGZM
 EZ6AqnUpSCmlTN1obvb17lCbP0DyHfyjGK2TISestpEYwC+ZvCyz/DP/Qt5JFJDhXpYhjCbk3/S
 ULmxdEm9Av0Ns2G4UJI4jddla8WJA2XvHDh17UTvxtNCTjarjZsyRkvjUupZC2y1JrmIl0Ss+Pn
 fL5OtWxBCUER11WDweA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270002
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34022-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0FF2433D8A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/26/2026 8:21 AM, Bitterblue Smith wrote:
> Let userspace tools like lshw show the firmware version by filling the
> fw_version member of struct wiphy.
> 
> Before:
> 
> configuration: broadcast=yes driver=rtw88_8814au
> driverversion=6.19.6-arch1-1 firmware=N/A link=no multicast=yes
> wireless=IEEE 802.11
> 
> After:
> 
> configuration: broadcast=yes driver=rtw88_8814au
> driverversion=6.19.6-arch1-1 firmware=33.6.0 link=no multicast=yes
> wireless=IEEE 802.11
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> ---
> v2:
>  - Use local wiphy variable.
> ---
>  drivers/net/wireless/realtek/rtw88/main.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
> index c4f9758b4e96..cd9254370fcc 100644
> --- a/drivers/net/wireless/realtek/rtw88/main.c
> +++ b/drivers/net/wireless/realtek/rtw88/main.c
> @@ -1805,6 +1805,7 @@ static void rtw_load_firmware_cb(const struct firmware *firmware, void *context)
>  {
>  	struct rtw_fw_state *fw = context;
>  	struct rtw_dev *rtwdev = fw->rtwdev;
> +	struct wiphy *wiphy = rtwdev->hw->wiphy;
>  
>  	if (!firmware || !firmware->data) {
>  		rtw_err(rtwdev, "failed to request firmware\n");
> @@ -1819,6 +1820,11 @@ static void rtw_load_firmware_cb(const struct firmware *firmware, void *context)
>  	rtw_info(rtwdev, "%sFirmware version %u.%u.%u, H2C version %u\n",
>  		 fw->type == RTW_WOWLAN_FW ? "WOW " : "",
>  		 fw->version, fw->sub_version, fw->sub_index, fw->h2c_version);
> +
> +	if (fw->type == RTW_NORMAL_FW)
> +		snprintf(wiphy->fw_version, sizeof(wiphy->fw_version),
> +			 "%u.%u.%u",
> +			 fw->version, fw->sub_version, fw->sub_index);
>  }
>  
>  static int rtw_load_firmware(struct rtw_dev *rtwdev, enum rtw_fw_type type)

generically speaking how useful is this?
with MLO and multi-radio wiphy there can be multiple underlying hardware with
different firmware versions. in recent ath drivers we are not filling this.

/jeff

