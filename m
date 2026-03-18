Return-Path: <linux-wireless+bounces-33365-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLnOAW/2uWnnPwIAu9opvQ
	(envelope-from <linux-wireless+bounces-33365-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 01:48:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7050E2B4B3E
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 01:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B2DE3025C41
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 00:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBD9288D2;
	Wed, 18 Mar 2026 00:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k+66UqJf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fLihyr9s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D690663CB
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 00:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773794923; cv=none; b=cFZUe8smht71HmqmJmhBUBZ20pxeGTmfaWjnzwcBkhswsdCOFiH86WcU9QaTBjdOD7rcUgLYOI3hbuJs04gOSzx/MhPKOdhUWsj4wg8/zEldJ8Fn46xToOBChjsT+PkpsMQ2/2/AtRUv+G11VB8O89IpYCSOESObvK9BuKVYESY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773794923; c=relaxed/simple;
	bh=10g//uEXfGYs9w1yEBqy4LPfs/249x8IBQOQbBlVE2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYeQvbcjnpsyzdvmVewlOPgBBdNkjLeDUeM0/TsEk7eCoD43iRGQdToPoeUbxws3A6RMaxK79SQBfZ7SLvn5t26gTz3G4xFgDAyMgXDrxykb8KV+ToXgovL56kF2RM928TolH5SYq2aMElQjQ1jrNAV3v5h7cAuaAbiY3eEg/mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k+66UqJf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fLihyr9s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HIJL1m1370756
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 00:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=k3lWVrTijV4oJdEx135NMWqA
	INmXCXipQyZ8o+HtwWw=; b=k+66UqJf0Xq/TSnrx6t+AjwuEdUAQvypezrVb/gA
	U2Sn6RsbJfHSKN8zeaj3R4QA74nVxsYgP8NcfgQOeZjSxmnPshxOdiBD4DdfaNey
	nPWA6s/zOUcy1BE5f7Y1mYiOKkggPDtfuMnUb+6PFRkwPgwpuG1nCyxY1Y9Ye+DN
	qX/IlTg2YBhOi3xjrVS2mUcdh5WX8JzEHUvvjnWXfVA9IZfFRb+8PRIFAiFmMP0k
	yCDfQplJoRv8CeQPDFk1GfCCJFBcJVL/v7rDu4ezEWcvTD+90fm0qOwbk4ikHIWw
	ibLNhPjVSuK91+PEdEJt3Q+9zx5dgVZfJXUf3sjsR3MaOA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cy7he2k15-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 00:48:40 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd80bea54dso3848755885a.3
        for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 17:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773794920; x=1774399720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k3lWVrTijV4oJdEx135NMWqAINmXCXipQyZ8o+HtwWw=;
        b=fLihyr9svJD2ttlTYB6adiFtkvfRy4bEaSW5gCn10zZvti/gfUQhKUQgfEOAxV7yCL
         DjFKSbJS7J26WGRFwVQhoN3fOBFzWefdK/OkIQGR/fUVTdu/rekRwvMWKAM/lmrQUn3n
         OAkTM16nUZTn6kdvkQvIWl/+mL5V/uSrjlY+USH7BnPeA596JSquOK7foU5WTGGK/Abi
         z0izuvI41oIhycYT/S/9KByAxD2axDHzFLtsP5jH8o73WlZ9A/Pic1cRZLdHm/3TDBfR
         08ht/mTWgqF4xOjz8dJaJlO35XAjxdQ2ZWtb2guXxjj7sUR6jz37mgOIh1FAmAWlu0ax
         ocyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773794920; x=1774399720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3lWVrTijV4oJdEx135NMWqAINmXCXipQyZ8o+HtwWw=;
        b=hJx70kiMVwnVYK89kiD6wfwzPtK8ulFMvOrh4NbCXrdyG8dg5UCI+UBTI2LUaXqtqX
         10gmZOXelruyTWY/zHmeGYONsMumpKvcBQLrnRyNnf7tO2W+kWn6xVk7trYU/O5lgNqv
         7PnSQbQspy87D8SDuEdBXCVncBLJrpXq6iLsrkp9AJDSCS/ytoDoacAvA4cRCzj+a/zu
         7qrh5/MdWyMYXqCnpfQFPEoOYchh0ZIrLkbPGFOFEFvzpaIspgFa/L2QmWL/YYbs5Q6x
         6TmgkTQVZQox7G2W4s/HcZjo9Y7kgrDYITbMFRU3oGxjZuNJJFmBqEJI54Q0INpJLJMX
         EAfw==
X-Forwarded-Encrypted: i=1; AJvYcCXdOcqOmR5jHb6K34ffxJLjmO5GBKGlofjrp6+hPqmROuLs4+u1AmSJoHTTT9dmN6Lu5VdcGor6uIZx7pYzBg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq8KAcxO0lUjBP6VyR50EEMH5wVSexdFUzR7RWqjUpd/Y86mUX
	fpCAtCnr3GFrwnHrl+x3PB93EMYGMYryLNL8VIgY4bbr35TmyrKn11bq4TDutu0ayPMeLtlHZu4
	Gbrz2jabeIxIoKUer0l/HWRkoaDSJDfMQ4QLxU/UPRgwf9ThzfH8oCtVeVOeGsQWgOZAe/w==
X-Gm-Gg: ATEYQzwszcHG4oBI6IiGUSljlHZDoSL8puBMjc3Vxp5fq8v4raa8pqn4T6l/F6x61id
	jgpy45DlOYXi5MbKLR7W6DBjMJQBz/BkF0Q5ILpwBuY+728llKGtvbGqkjKSoCmBlMP6celKviR
	3TKbxRpM/rNq2aR2MjldkOkdnKNJDAp4ND2VKmP/WERHqwXcbA2aTcVlIPNYfvQQJPm+OLcTzrD
	/VNwkhht+HtVtEyMwuAm2DN/dDW5vznt1c5p+JmqUmRHzFFOe1sJIqU49B3JWr3sjpyTnhNtHwm
	fH03739iRkL9LJ6xGMa3KjdT8VwMEAp2YhgJpHAKeQf1mj7MjdJRAm0HcccRtNk2c9QOrQGlEM2
	X1FhAgLjVeVYV7YDvGcX0Osf85JpxEqAmg9xQnL/0xTN5MI8df2NJ1up642MRVWVE365+Eqogrn
	/Gl/6k6lsJkBNODzeHe3IMoV4OxJyNU3xo124=
X-Received: by 2002:a05:620a:1788:b0:8cb:baea:89cd with SMTP id af79cd13be357-8cfad1fe3famr246652385a.8.1773794920081;
        Tue, 17 Mar 2026 17:48:40 -0700 (PDT)
X-Received: by 2002:a05:620a:1788:b0:8cb:baea:89cd with SMTP id af79cd13be357-8cfad1fe3famr246649585a.8.1773794919600;
        Tue, 17 Mar 2026 17:48:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a27a987d19sm75687e87.73.2026.03.17.17.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 17:48:37 -0700 (PDT)
Date: Wed, 18 Mar 2026 02:48:35 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "kyle@infradead.org" <kyle@infradead.org>,
        Josh Boyer <jwboyer@kernel.org>,
        "Hutchings, Ben" <ben@decadent.org.uk>,
        "Dreyfuss, Haim" <haim.dreyfuss@intel.com>,
        "Yang, You-Sheng" <vicamo.yang@canonical.com>,
        Linux Wireless <linux-wireless@vger.kernel.org>
Subject: Re: pull request: iwlwifi firmware update 2026-03-17
Message-ID: <6dvmhm3g4nt3b2s3ecy2p5tbnbo467w7curmzorrkooaz5tait@b55n5sh4o3nt>
References: <DM3PPF63A6024A96E4ADFF6BC9FB4AAB041A341A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM3PPF63A6024A96E4ADFF6BC9FB4AAB041A341A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
X-Proofpoint-GUID: tRalACiEDwI440lFAgb0HnuSs3_nHm0C
X-Proofpoint-ORIG-GUID: tRalACiEDwI440lFAgb0HnuSs3_nHm0C
X-Authority-Analysis: v=2.4 cv=QsVTHFyd c=1 sm=1 tr=0 ts=69b9f668 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=1fbsq9cPcyC_cF291j4A:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDAwNCBTYWx0ZWRfX4JEMyqcCUclg
 j70o56sU+fK++oM9A29rJecLshL9BDZlI3tDBU5USRtjYJWu8M2knhuxzawnX2YU6ICVHYKJgDH
 imx3fMbuY9PLLv83THkprxXDUa77/bJBe8KF4FqLCF8opBqbNuslkP8SqTFT+lsW70LVrJUXGEi
 fQo5xAbar1HBt0GlhavTXdcY6b4JzAtShp5yD4EoFXCCf+5a4pArzPkTd7XadKB+FnNcWxtThPW
 emifYoF0h9zmo0v4rCfW+N0ljq/NrTMVIQncWBzW/r235hI7iFu4YgIRjq8SMGrutK0BRU/CFXc
 F7zbK/RSWzdJIhiwQufZQ7AImkpNRbVY1tE4xilYJiIzUglDDx7Bi5vpFqhpdEJwFMhsup4d7bJ
 qr9OARveBZIRigGiqhXcM9p8LtzHyLXDDi37pGettCoHN8NDJgE49lWfQUbRKlWUvSlD6jyWawJ
 LacDMSj1y/tcb0Qn6qQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180004
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33365-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,gitlab.com:url,oss.qualcomm.com:dkim];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7050E2B4B3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 09:21:11PM +0000, Korenblit, Miriam Rachel wrote:
> Hi,
> 
> This contains the firmware of core102 for Bz/Wh.
> This was missing in the core102 release.
> 
> Please pull or let me know if there are any issues.

Merged, thank you!
https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/963

> 
> Thanks,
> Miri
> ---
> 
> The following changes since commit 81f761d1b5fd51469d87d1633a959dbff4785f58:
> 
>   Merge branch 'mt792x-bt' into 'main' (2026-03-17 17:33:37 +0000)
> 
> are available in the Git repository at:
> 
>   http://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git tags/iwlwifi-fw-2026-03-17
> 
> for you to fetch changes up to abcbad3cc9588bc6e2f410b5984642c9cd46520b:
> 
>   iwlwifi: add Bz/Wh FW for core102-56 release (2026-03-17 23:14:14 +0200)
> 
> ----------------------------------------------------------------
> Release Bz/Wh of Core102
> 
> jenkins-Core_manual_signed_core102-56
> 
> ----------------------------------------------------------------
> Miri Korenblit (1):
>       iwlwifi: add Bz/Wh FW for core102-56 release
> 
>  WHENCE                                       |   4 ++++
>  intel/iwlwifi/iwlwifi-bz-b0-wh-b0-c102.ucode | Bin 0 -> 2116884 bytes
>  2 files changed, 4 insertions(+)
>  create mode 100644 intel/iwlwifi/iwlwifi-bz-b0-wh-b0-c102.ucode

-- 
With best wishes
Dmitry

