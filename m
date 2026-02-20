Return-Path: <linux-wireless+bounces-32043-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBfXCNO3l2mR6wIAu9opvQ
	(envelope-from <linux-wireless+bounces-32043-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 02:24:35 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8918E164206
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 02:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35D6F300EC85
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 01:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59C71DD877;
	Fri, 20 Feb 2026 01:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i5UfVVQG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OtDxcCI9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9220B1E5B7A
	for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 01:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771550670; cv=none; b=u5dFw99CO89vrQuchSOTrmza20ECMoznSj/hds2kfaawmyKqZyLhuPppLObeCd+LSnNbFF1rPUcKAEwB57FFAozstzvOMEUJlFS4ZGumqI/ajtn5SgQFp/SIVWqX6ienJGDS4C8SbH/zwxJMU0lTUKtAb9vHzAkSExjoEBaRsG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771550670; c=relaxed/simple;
	bh=yF/cT/s7d5bX2AFulhmwOuEy5xu9OjvTEm/CmjPwFtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NRA6sqrWFhx4MIhGbVkeF4C5T58M5J2FVOmsONv7MIMBW9sZRl/OscoGczJBQ14q4/yF/VuhJjKbSqSLRls/lRkafUP0SqNxltdkgi68107gN8wzwGYcnBHAkhQo3N9oBbnHg4TepmDKuN5MQim+9Ky8D5MyfbeZoZqNuif7lBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i5UfVVQG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OtDxcCI9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JLB4m1408555
	for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 01:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3DzT5YXormPHjA5zGOhmFLNMKlPojeh3/2ltCza6nN8=; b=i5UfVVQGxLwKrrD6
	jn7HNlUDY6EDo3QcFX5m8I8lVDwCr2brbw0JslEZy+aWoVpXFUZdYIqn7/enDvIE
	wCzFf072YFp23okeH7i8iDqLPixa7OQWoDAdo7iYNcGcINM0nrEOIQbX6MzdWZgx
	dYZn0VBDA571oGTMFd43tD5XvJ8S2rLYKBF6hidcFBsGRqyRYEdxR7PVtZqrlWNR
	BzGDvC74ITub1soyC86MHDTnafGH6T1ZxZiPl0tk9SFDeWoSXSIKF3Xhv0S47h3D
	VKRzKu8XuvzpSW1sfGcfnzH12N6vQtnTDeJpq9/hh1r9hIZVR9TQLLFZ2oWRELYD
	e2hP8w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ce2gej753-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 01:24:28 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2ba7e98178fso1324216eec.0
        for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 17:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771550667; x=1772155467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3DzT5YXormPHjA5zGOhmFLNMKlPojeh3/2ltCza6nN8=;
        b=OtDxcCI9VQkVwSKG0L+4PfTwwhzNjkBj/Z08VvR6s98SPM1CYdkkZkKO1ETKjPfWDK
         eqneZYbXY3V0/kj262j+Gdh5VrVfl6RUt8H0/v2RpdX+0LM9F4ajigDRa4mGoiyFLFqH
         m27Byz9V2/vcKzGWH8Dk6qAgNHAT6DkPFsY9JWYGvXL+6GVgujmq5MeMd1olrKqHBA8P
         ALqBt3Dkfr9roCEhduQGy6Bn14ntGxLjxntq6p8eiLm9Lln13UVJeWAGkkBU4Tnrnm4D
         HBSzS5RfbXZ9Vdo/zoyLzrPfzgQz15Kqat+xBUpDbIcL6wybEEZ5UFz/+62rRir27qE9
         SWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771550667; x=1772155467;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3DzT5YXormPHjA5zGOhmFLNMKlPojeh3/2ltCza6nN8=;
        b=lfo0LymBXZxEpTswUOl8XXidwAe+9dP2TNWKn1aFXgoB3gDzcINZX0zU0tB53Uelqt
         Ry+beq8VcjOZPPZaQ7KWTTOC0pH2HjXX04KNttt1JvHNC+ZYjuWWdcUFo2G9X+aVUlUh
         +ZRyxLT6exiqPpRJaONsG1s5iIF+Oh6w78J5nAgwfaMbKYG4d02mHSxSaw/Lu8KB7rYm
         89u2yE784x5Xm/U66xd1BNa25Js8dJ9XQxRkpqtEQQjNQvCo0yrudrOp9EnSdZTvFg36
         0O4zGI55BYjtf/ISm98wfq9dxOlGmGo8CXnq6pVs0MzxGeDw9n+nJ8U+fhRm0P/qg+UX
         rk9w==
X-Forwarded-Encrypted: i=1; AJvYcCVvYM1AwYwsAl+cByUrzsi08caIVaIh8Cp3UIy/C54RSh1Lc3YmNeyF4dA/uPLwewnBJrlxUsFXHK77yeOnvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yymusy+K4P5k7lwamLd+bgW+Wk+L0+xAI3wq2mOA9H1LwZ0wRVr
	Nq8pGsr4FxVOVFDwzXBzncItRdEOOPU+4C6ppZbDoe1yqu4ivFPd+qL6jAmb8sjZVp5diHetU3F
	G3UnYvt83LxPRcUAu1oKU6T/4KM7dkFLezQK4YU1p0FZG4i/5NjcfLRN6ld2LnfGLafEJpEp9Ob
	NN8w==
X-Gm-Gg: AZuq6aIoVw3wbA+qujlrztiw/vwdKi1/kg+vsjYJxZ4n+H5VpGeLynDEpFS3P+xnPyU
	z+LKwcPels75T+2IWYYVcT+jg1JRPHep6/EEHXS0Eq8XEKpDIXgWUILotV4Cv+peVGNGwUFEbzI
	BMThRmSCmMVSIXEyteoiFfkalxmEDWHySHE5ukR/SqyKxzSi9iyHpBxiS2a1DoMesRaSt7CGcIF
	BsjlqEYVgZiC8qGU5hsq1vwvWuCrR2EjHG1nEFygktCpcuxCTpdCYkn9/vLkInWflG33HrLvmRK
	NtMGgtAD7wVtx4r6vpSLsRflikeTX6bnma9G2iL6gmPI/SgaJ50APjyxmAe9B5aCDIO5RnMFVYQ
	73kUeD5gCweYtfoM11lxU0gc/IJ9J8xx5Gm5AH0qDX0Xvz6N86puPf1Kzxzag5iAiVDZURPojKR
	SNithCqkSfBF6fUA==
X-Received: by 2002:a05:7301:d1b:b0:2b8:64ad:ad4b with SMTP id 5a478bee46e88-2bac97a0b4bmr8062427eec.24.1771550667303;
        Thu, 19 Feb 2026 17:24:27 -0800 (PST)
X-Received: by 2002:a05:7301:d1b:b0:2b8:64ad:ad4b with SMTP id 5a478bee46e88-2bac97a0b4bmr8062421eec.24.1771550666609;
        Thu, 19 Feb 2026 17:24:26 -0800 (PST)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb66addcsm22471004eec.24.2026.02.19.17.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 17:24:26 -0800 (PST)
Message-ID: <68db44c5-0a81-4451-bbb4-1e211d6b7cde@oss.qualcomm.com>
Date: Thu, 19 Feb 2026 17:24:25 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 wireless-next 03/15] wifi: nl80211/cfg80211: support
 stations of non-netdev interfaces
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        linux-wireless@vger.kernel.org
References: <20260219094725.3846371-1-miriam.rachel.korenblit@intel.com>
 <20260219114327.65c9cc96f814.Ic02066b88bb8ad6b21e15cbea8d720280008c83b@changeid>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260219114327.65c9cc96f814.Ic02066b88bb8ad6b21e15cbea8d720280008c83b@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Z5/h3XRA c=1 sm=1 tr=0 ts=6997b7cc cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=ul4lmLhDCFP4F_npgNwA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: sdLpNrmc9qpdnapBQNpo5cEpqtVHEJRZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDAwOSBTYWx0ZWRfX/fsVZruqIXxe
 GjA3mGL3C1XD5VDVG04sImQSOBMjRin9EYB+1vl72M/yIFr+WJGGm9qH2X8Tvx+Q5BVvQqQVxlS
 26thvhF0nfAa0EiGo8ZYQKq7qxQYTGWBe0zMBimAGL/GxAdaD50EvOiSwj0a1RMnvtJlRuUdEKA
 0g/D3Pm2ont650BildfXBBx/CPe9YSXig0YfcZwG2oCar+Dxho1D24JbRCU/GvrOJXdIyxx4xD3
 QewosrrzTwpwUgIfShNgogR+Fow2QK8ulHQHjFHGRsZty6EI9KEogJfEoW3GAelgW9z06pj6ArO
 KJQQkxWl//T2sHj0rcCpllE0PFmvgpXhJzm3iki/vf8dTn3V4rlQWPAFykkEsUjwSFPadtzrQon
 outDxyLSBClGqogjm4ii/VEqHBO6VCVRNfBbm2X3WlihnSWe9wp8H+sAvSmerMm8MdImlxQDG1h
 HaG3AS0JfpVJaTySb+w==
X-Proofpoint-ORIG-GUID: sdLpNrmc9qpdnapBQNpo5cEpqtVHEJRZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_06,2026-02-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200009
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32043-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8918E164206
X-Rspamd-Action: no action

On 2/19/2026 1:47 AM, Miri Korenblit wrote:
> diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
> index 88f0197fc041..eecba2201b10 100644
> --- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
> +++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
> @@ -1775,9 +1775,10 @@ static bool is_rate_ht40(s32 rate, u8 *mcs, bool *sgi)
>  	return false;
>  }
>  
> -static int ath6kl_get_station(struct wiphy *wiphy, struct net_device *dev,
> +static int ath6kl_get_station(struct wiphy *wiphy, struct wireless_dev *wdev,
>  			      const u8 *mac, struct station_info *sinfo)
>  {
> +	struct net_device *dev = wdev->netdev;

with the upcoming logic will it ever be possible that wdev->netdev is NULL?
just want to make sure everything is still safe

>  	struct ath6kl *ar = ath6kl_priv(dev);
>  	struct ath6kl_vif *vif = netdev_priv(dev);
>  	long left;

