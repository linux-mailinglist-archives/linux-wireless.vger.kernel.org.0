Return-Path: <linux-wireless+bounces-39106-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LanIHwp7Vmpa6wAAu9opvQ
	(envelope-from <linux-wireless+bounces-39106-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 20:08:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED6A757BA9
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 20:08:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=bSUET4e+;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=MZf552Dc;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39106-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39106-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D6A2303547C
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 18:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3B73CC33F;
	Tue, 14 Jul 2026 18:08:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B613CDBA5
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:08:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052484; cv=none; b=ZQhFfCf7nTfcaelhPpknsElbdz1OG1c8iccZForhriwYVkTXzsyIe7XDGqa1yvZ3hNxuoHjaF1gCu7sGJ1OUxgnFod96FxJ+7Hc63ytFT0ZcMaMPvwYw8cwT9QaBWsvHnwgjLG/X+Zm8GZ3sF1H+dFlxULHt1YvBix4Xur9G510=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052484; c=relaxed/simple;
	bh=Gu8RG5LNzNCkaxyelpxrU7R2krSbg/9OI/JU2F1KDAQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A+4djifM0zxh4yHfYbUYM3HrLYaL8uq6NJ08vmSr3ndpVW/LegvQ8C6F+3XICKUf6pBY7Dl6u8iUejJdqsJmtnPbCzQUvrYeQS5ja5N7DaUmRwvOSmXXDf2+mdCKUQ6M68CqtgQHT/3p5IM8kd/Bo4L1yva454H5H2wt9q4qD6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bSUET4e+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MZf552Dc; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EG6ruQ1003200
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:08:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5ZMUNvcBCyxke0yxKFU8VZ37EGJlqlcJjNDq1EWEOm0=; b=bSUET4e+YAG/IMSz
	AnzvN0I6RZ2Rq8YpTBhzuncKjc28JaSKDPOgWMwM/7jdaI5lZukDOQZ7/g/emMgj
	AkHGhxLU0+/exZSbCOyQvt3mAYwcZ94p22eoHOd6k6n2JPBuZkVhGXRm3VzfxCG9
	sOpxm7sNKnH7PbyFpAF7avE64+0q16rJiVq+ze6BRxhOH1W0STvnP7m0L/QuQojl
	4XcZFJq5gNmL5CclnwX9fJkcDI+GoqwiDf7WODnWtgL3XAizEuHt0rWWgH2ew3Iv
	f6ZkZ8je2eVf2JXsc17wR8qeX1GP6lcTPZWp+CDM/bYEmnPZl4bK1pabZL8Pp/0M
	vWoh6w==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnnr1929-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:08:02 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8f0867a75ecso112600496d6.3
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 11:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784052482; x=1784657282; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5ZMUNvcBCyxke0yxKFU8VZ37EGJlqlcJjNDq1EWEOm0=;
        b=MZf552DcxrQumm3NWAlplDPsvQ8pf0hagGrDxVA7+1z5wjtmnbtgtBbnLhDkNJSnFW
         3lAFL0jm/t/PLwCHmvt5KJXR+eNg6H8zj7AucrzzaC0p7xdHu15W35ytAad8Wl+yOvf3
         A/E7OQiYgLNZzv70fGKM7WfWM1a/odgvkYOef/bXWoyhEjMDW4oOOxqq6LLW12vDtZks
         93xdGTGmc7fBFoEoB7dRPp09L3v1e2X5rwbQu86vGzYotXr3CGu79wgnaFDPdTXXu03H
         iEEwnzT2D9dsgHmPCjdmRm8fItvf9ryhxNdTzMl4aWUdysq0mb8Gt4Dktg2/ZIhPknKs
         930Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784052482; x=1784657282;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5ZMUNvcBCyxke0yxKFU8VZ37EGJlqlcJjNDq1EWEOm0=;
        b=egcVN0PFNp/kPD9Z1ED95DbrxAMkwWKGXNrOTEGCCA7nalykKnoiollr8vdayoywNy
         /C4drAhLcQM4SYNTrM35btrDUGQ5ARmw4R5UMQX/bStk0LwAMn9O2AARt/WZqIeZfWo3
         4eVMbfVcQZVZvblz+EaNd84S36A4RhZSC+XIXz+z7BNINbQL83k53xkgNuFLPXYnNKhL
         G1rRiYMaN9lgMfcPr4ot9vghiDPomhKdWzVRP+MoZLgsc67MHVEO7iXHZgS4nNrafSNo
         YUjPg0hpKQuHEjXpYeGQGj2fcio1RRp2ylFmvVW4+wewKL+nwhcPTNbdzpn6t4XhkNb1
         v5AQ==
X-Gm-Message-State: AOJu0YwzCyQNMwRFk5G+tjVawJYSGv6sNUj3EgaP+V64EaNZk1HbpJEI
	wcLETtH2j74osGrpiZY/AYHqNfFVCl0IQ7AsVrx4quP2FpcLavKOmZAXzMsroRUr976aMXwZH30
	6my9Fq5QLEL44k2Gze+nO+d/LpRd2+WWRr7AqoznV7aCJ/Z/WB02LwRxRBam6JE8TQrKg6cK8PE
	+o6A==
X-Gm-Gg: AfdE7clYcA0mENd2svRvuiJJebG8Z7qVhhrY9I5Us/M4h314IVJf2KgevCPHbbPrLPE
	jJsoh8BvO5w1CEUZBoc0cXdEas1ucklsy3c70j6aLkgCyRq3d8eHXqpxTOZ52HMZSg5jrrZiObi
	okMsEiKnmnDIVuyO58kuf5Z2262+FIMC6/j4iBeNEO7qyAVkziVYp7oF2tySgtgxRwWsYLoBslD
	l/V7yfB6AM0ChGBT2SCQRVcL7ozSwH3i4qqxyhwKWa95pdpffFHGDOvYQ5ZBs9dpQZDNBabUAEg
	r53Dw0dDYQAYVOEB1+JNblhYxi6gTfJn/Aoyn5bKLBZhwcUB2QQd/1XEiRR99Am0dq4WsCNoHG0
	gAo9qEzHov1a2JmOXRAImKyFqSrjfP1tsICSQv9W+CvhRbKmQnQYSvEr1jYsVlZ/TZA==
X-Received: by 2002:a05:620a:2549:b0:92e:4470:f6a7 with SMTP id af79cd13be357-92ef2b96862mr1443490885a.10.1784052481919;
        Tue, 14 Jul 2026 11:08:01 -0700 (PDT)
X-Received: by 2002:a05:620a:2549:b0:92e:4470:f6a7 with SMTP id af79cd13be357-92ef2b96862mr1443486085a.10.1784052481447;
        Tue, 14 Jul 2026 11:08:01 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930759c63fbsm465448885a.22.2026.07.14.11.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:07:59 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260701182428.906441-1-tamizh.raja@oss.qualcomm.com>
References: <20260701182428.906441-1-tamizh.raja@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v2] wifi: ath12k: Set
 IEEE80211_OFFLOAD_ENCAP_4ADDR after tx_encap_type vdev param
Message-Id: <178405247932.4102418.5292586403091961512.b4-ty@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 11:07:59 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE4OCBTYWx0ZWRfXwplhtPKHLCoT
 937zFOIeUuTm2vU4fIogWxH2qWpXiONWZZkyPjm/EZaipMaomtDz6LjWsaM7oYEsHLDH+ha9nZg
 5ziVwVLsFKPe9JKUDhNPEiil2WQDD9o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE4OCBTYWx0ZWRfXwRA5wh8UHCmE
 SxWVB0os9jrvymfWzzVsDvpbuxsUHPnfgW5Ut9cEwEfzN0PG6yPuBwqqk5xAKx7JZ0o9GkzWQCE
 xdSXTkhvovSgBSoN2RXsBjN3OiAIsXEeQ087XYUVMHZozoMfeYGx39V1hSMZPQWxjNBMtBfQWkm
 87IXdzPIrdv3P5QyBoXbdfQaIRETl3cK+lwWykcgOuQPXZtvS4Q1gjCFo4w4hhvWBa8KmQD0/db
 Sx7Es/vml7Aw4AYzXoInA07O0CQqwoZ5dVXqQjY0ODgoaLUfDS8XLiPYTtojqBkDrpfX7Mr8mto
 IriZ7h1OCXbxk4n+wHck8lJT+2NDMEJTAcNvXg74yzMBUHDTah8KCSahD4CurxUBF4y/ftKpz6P
 9AWaYKSplz2liD6kEN6ICRU9IkZOlRsbrI8NnGgGK6VYyiDMflJC/LnHB4tUpWv82cpuxYyYGBc
 mUycbmGeT5dKrS4zqSA==
X-Proofpoint-ORIG-GUID: qbt50eSgFIUbDXkyPJ5t1eoT4V8leTYl
X-Authority-Analysis: v=2.4 cv=NfPWEWD4 c=1 sm=1 tr=0 ts=6a567b02 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=zMGBYq01FbGhXOOdeYwA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: qbt50eSgFIUbDXkyPJ5t1eoT4V8leTYl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140188
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-39106-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:tamizh.raja@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1ED6A757BA9


On Wed, 01 Jul 2026 23:54:28 +0530, Tamizh Chelvam Raja wrote:
> Currently, IEEE80211_OFFLOAD_ENCAP_4ADDR is set when
> IEEE80211_OFFLOAD_ENCAP_ENABLED is present in vif->offload_flags
> at the beginning of ath12k_mac_update_vif_offload().
> 
> However, if the WMI vdev set_param for tx_encap_type fails,
> IEEE80211_OFFLOAD_ENCAP_ENABLED is cleared but
> IEEE80211_OFFLOAD_ENCAP_4ADDR remains set, leaving the flags in
> an inconsistent state.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Set IEEE80211_OFFLOAD_ENCAP_4ADDR after tx_encap_type vdev param
      commit: fde37c064641a4bad26d1583de25f6d491a7a9bd

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


