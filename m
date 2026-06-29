Return-Path: <linux-wireless+bounces-38284-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4TJJIVw3Qmr71wkAu9opvQ
	(envelope-from <linux-wireless+bounces-38284-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 11:14:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 824956D7F21
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 11:14:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=ND+Te2ud;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="WRA/EyHU";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38284-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38284-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 45B513015187
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 09:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A1E3F0747;
	Mon, 29 Jun 2026 09:12:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EB53F8705
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 09:12:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724346; cv=none; b=HN1mxVxI7NOpx0JHtBJVHk/FZJ9DGxdwTzhWZQTVI/SJWVvUZCp4PRJFlw2/XqoStQpf5PHxyocE+1A99OF4PI/V95RWpsJI27r38f6XLh/BECBBJ5oQ5P1ptfqrDSMKn6jbgJnTjJmAGcz3aZYjOUVUzdWNiG6toNpXEJs59q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724346; c=relaxed/simple;
	bh=iSeZ61BTtuUpHh2wDxN7RoI5h3AfFt2/4zlGj9YT6Gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O8IYcotZgSNNu0+c0DRsm0+dTjJVi1dZwgp6Cfjv37PNhX2lDje0DK5YHa2oCT/Ja/EweYD7L4NgC9rvoQ64n3xMJGxFxKxyWGZEhUL06zFmAYpJKwH+zG2oUYhfxQvu6OtRqpsrymqTH0or4BJeB0Gt6XWugJY0HtlHktv01MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ND+Te2ud; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WRA/EyHU; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T8aQe52368171
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 09:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QRSODFNNb3O4IsBQSkX4j5L2lfEyxWjDjiEsVelPssA=; b=ND+Te2udEV6f4ZNt
	Ubd4ex+xDsa+I8PTX34S3UGajzVGIMeqsphYuhlKy3oWEkKJvQ/iIJP0E9QirFkG
	6vlZrF4M9YMqyVCJ68X6Qbp2W/J4KVxM9Bry95W3yvE0AZowFmotxPLSq1qyS5r6
	NaUhSFBTzTAJ806XGQf32xRHRUSrmbF6jE3h+lNakgyj4CJRS6rwuvd3GmPa7sSU
	APPNM3AhlDSnz5x1PGRfPu0SITzByvCBDP68F/eNKQmXkYqa2SEdeZ3aokYddj0L
	a0eX7pt8qiqSk2NgBAKjvfGkFuLsfsI3CmIvjXOvMaBbKrjxoMJYCz/KtcdaOX+I
	jI+MKQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nbgr4tx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 09:12:24 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-139af2bd2c8so5264573c88.0
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 02:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782724343; x=1783329143; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QRSODFNNb3O4IsBQSkX4j5L2lfEyxWjDjiEsVelPssA=;
        b=WRA/EyHUIqRuR28VefZX+Fhwxp1mzxSdG5IDvJoJdylHiWrXY9jgXsj3jVrhj03/A8
         8UXT4osKDreNzkkhwgc0GOrx6fqGml1Lb8qIkd2tBaJEqo1xPR2AGjM/Fsc687Jd0yvG
         BCvHW8uVHOqyqmHK7Bv9p4gghl/EdYfTyKCWrkXCogKz/VkHJJTmyQRH+SzAo1yzGvIx
         xDsVatAwfc6VwFkwwUI+Rbtw5aRLmFJJOhVGid5kiWZnIV+pPJI5czxF+00rPih7PmJK
         hi3k8EAvuUT5VvkdazPZIPCxBRqvmhpAdOZUkUXG+sGLiEEPBBEK3hD2svnMivZ2VOmK
         Wj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724343; x=1783329143;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QRSODFNNb3O4IsBQSkX4j5L2lfEyxWjDjiEsVelPssA=;
        b=GYF1O94+cUdYG6xmUh6uPLP9dKxKlqV2317UaH6p3ORY5ZyVhvCiI04XBQrv3QpjIN
         BfaSxiuwalaONeyfPxh5ZrHDTCRpLO18wbTuSSnQ1o1mvTZUthR5vTnBEi/WLhnY9IUH
         VUdtR7frtK5GME4StettcSDBogCdRuz3jk0YE/SmNlR630GbcqsXhoOsHG1vo660a2g+
         OsVKKCU1VPjztAl/8Fc2i3i5CuVbik5QeNnKiOmH8NuKrmnzFjAt4dJI4s4DHHxqMt6A
         lY4+1JtRYyhVf+1V5RRkcFR3knIPgvZN3JUD8e7Agciprx3u8KlKBrXsiWyoPLG0G5Pu
         Uhlg==
X-Gm-Message-State: AOJu0YwnyyKW7xDKHarcaOCifdRxcwlsHTbz64VUZYJzKDGafYNG6M40
	p9ktkPbEzAvw6rSJHjbNpLUBkK/s9+cutu07D+dochb1r2rIRZOPcCH+6MRicqOHEI+7pWy4lvn
	XoTm8ftR4qGW78iY/LjZIzex9/5MsBjMSvoeGbjPM9YSEemUB0iR5kwvRA4DlzOBTcorQjzSS2J
	7++Q==
X-Gm-Gg: AfdE7clvDCeYnyXywajEMeLJ3JTzL9m/Iz5HDAA5rfEylXRZ/5pd1v9DZ8Jn5ROaNv0
	Or3eBoAtrP0NhuNmwbIMzV5jR7BSuuubWLCCSLxhIiPqRLdD/KWJwtyPaZpknk09TDh2d01GwP4
	6g99ssamYQ4D2SrMbvLznDHLsBRk5r2MrKE/jZZ2AtgyEqdCVVhmTsIkSBYtihvgTq41SjfhYTb
	7vgcUOnYPM5jp+AXEv98obOGckz/ctlxP14G7ppcJzJpdHsOq249goS/mFzRu9bcwzWACMqKoEh
	VQk12D0UuX9U7R41Xs7NqrWkSZSP2EpDXJKvIA0ERPtLHP0XEq9JRSZn/oylHlAoLc0rqt2rdLb
	CabHGE+WIzqdQUofPlCZGJpGajXORegKOj6FscCRa5CwS6NzDFIY=
X-Received: by 2002:a05:7022:fa1:b0:137:977e:628a with SMTP id a92af1059eb24-139dbac2e17mr12991144c88.24.1782724343297;
        Mon, 29 Jun 2026 02:12:23 -0700 (PDT)
X-Received: by 2002:a05:7022:fa1:b0:137:977e:628a with SMTP id a92af1059eb24-139dbac2e17mr12991131c88.24.1782724342765;
        Mon, 29 Jun 2026 02:12:22 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d91006afsm55172406c88.12.2026.06.29.02.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 02:12:22 -0700 (PDT)
Message-ID: <d50eb3f7-fe8d-440b-9ba3-8baf4ab62e3a@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 14:42:18 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Advertise multicast Ethernet
 encapsulation offload support
To: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260623100501.2100119-1-tamizh.raja@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260623100501.2100119-1-tamizh.raja@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: TqDjuNBaKcwS7kFYFbJwmfyjAnVfiIF4
X-Authority-Analysis: v=2.4 cv=Z4Hc2nRA c=1 sm=1 tr=0 ts=6a4236f8 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=ON_mxGkP88hWkZQB5WAA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3MyBTYWx0ZWRfXz0j5GsYhrcHm
 WSyzBKHdKjZhe4d9DyTwn7gH5ZI+eq7mpUHFjsS13i2EkgmBcv01FcsX3ak4Vrj1OdZEsywKI93
 RbDj5OknI4lhBjHQXM/WEGbBMY0Wuic=
X-Proofpoint-GUID: TqDjuNBaKcwS7kFYFbJwmfyjAnVfiIF4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3MyBTYWx0ZWRfX3pC+nG35TMOC
 KpDgzJEPc7JoWctUWtj8hVOrDEBHSMiFCeMDBVFYwXL7/KdTJF6JV3UysFvUaKdLOfmt5X0CchZ
 co9KkTpWs6QnsrGxx4cuN3Fhg43EiOZJO1NHd08bLDRHrprwagflLG2RFzsePu/WKT440/SV+tF
 HuHjqpS3gQbHuvwKXEWYcrpTHOXUm0J2XgvoqWB07KFFMKxmkT30Zir6QqB2hVKpO4XyHddZ/u/
 JZT1BoLj41zcXvIim7vajvpedAe0xuw+FWhnKaZWSX2Dbn94p0KNJKg1dIAh7o+y6yzYIunSWyE
 8yLsgbJtW+gHwogi04CzjRn/LJyva/6GBOITyu33S+U0AcXiTg5oCRt6vo+85mIOrjz89ByUUgN
 n8c0TRZKDYjbV0wtk5NRUQP0i8LtfltJEX7fWpSaNpKjslle7xGmJbzhl598W3tL4YMQIpn3xg3
 TpayBzIYEvBqNrhQq9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290073
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38284-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:tamizh.raja@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 824956D7F21

On 6/23/2026 3:35 PM, Tamizh Chelvam Raja wrote:
> Advertise IEEE80211_OFFLOAD_ENCAP_MCAST to inform mac80211 that
> multicast frame encapsulation is handled in hardware. This allows
> mac80211 to pass Ethernet-formatted multicast frames directly to
> the driver.
> 
> In ath12k_wifi7_mac_op_tx(), refine the logic that selects the MLO
> multicast replication path. Add a sta pointer check so that only unicast
> Hardware-encap frames use the direct transmit path, while multicast
> Hardware-encap frames fall through to the MLO replication loop and are
> transmitted on each active link.
> 
> In the MLO replication loop, use skb_clone() for Hardware-encap frames.
> These frames are already in Ethernet format and do not require
> 802.11 link address rewriting by ath12k_mlo_mcast_update_tx_link_address().
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>

Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>


