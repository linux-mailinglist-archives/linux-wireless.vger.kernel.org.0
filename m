Return-Path: <linux-wireless+bounces-39108-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3LbyKiJ7Vmpv6wAAu9opvQ
	(envelope-from <linux-wireless+bounces-39108-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 20:08:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF9E757BC1
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 20:08:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Z2AtfgTZ;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Mk9tpI1O;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39108-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39108-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0FD03013C51
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 18:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473D33C9EF4;
	Tue, 14 Jul 2026 18:08:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AC13CEB8F
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:08:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052488; cv=none; b=futABYePtH3nFrNzLU8eiUdd/FwkqxaATcuLG3/oVUYIhAIUUJLJblowk5Yc+oogC2Wa0NpgQdDFXovVbOJFUXo9UKWzVQusU+FQw0e1yDwSiYbWvC/lh1Y0ofARwWtggs2aS/vINkvkiPLs6lBWZD8muaCNVr7NLXbVlgOD8os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052488; c=relaxed/simple;
	bh=ubHvttGciSq7A/t86iLga/6zq50vf5r4TD+udRidvJs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BuwW9ud8G5UNcRo1N/U0wgVSkgizCUNEKyDl0kHW//GLa4zZt3IvB5MdkK97vpknIxiCkKTADOoG/+y+/d36ruMQfz/MlWzI7DSM8llkwVJms8nc8dpJvwp6ZfD04ryDLPbxBeIQ4aDpynBp2dhk50vDzOXiZzyb7GmGKjFm86Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z2AtfgTZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mk9tpI1O; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EHZgRq1209855
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M5+GJ0P12f0uqBrDr1x6vwM7QiP4mSPEkgb1duq1OVA=; b=Z2AtfgTZLeVOwFfg
	sDAheMJaUnnhqK9mdnC00BNpvPVI87t5I3w4AFtuq5zfvdoGAxd/caS+7pOU9/iD
	67fyB5bVmtNXVN7T6miOGXbSBG+lg5ZErT6pQ1oERxbeQgbOqR53/gWN+e755ulm
	CsbBvV3bq2p/BPxC+PKmeTH79J44ZTF3XTl8C0wQUN4Y6Jy4K4Q3GexHJoRjmxDL
	XhpgSW9y8YlO2BM4lWIwia1TeGvsqcum7SELEZcJnyXnB43uh6FVWV/bNX0ObY8h
	Rt8JrS/w3FbjpcJ5gZk4lMRpRjyRVtvnoLC4ogWNy/cqekRisgi/w+TkPjitxGbH
	FYnzUQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnnr192q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:08:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e663c29f2so154342485a.0
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 11:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784052485; x=1784657285; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M5+GJ0P12f0uqBrDr1x6vwM7QiP4mSPEkgb1duq1OVA=;
        b=Mk9tpI1Ow2QtY4hnq2iTyfjplWJd3eslyFUJeBcTVKWrYD6USMoX7/mINGE8KA4SdW
         d73liLQ2dtGJAuTgVMCfo2SPT11t1nrvpaqvWeccODJJPh3fE+qo3vYTjynNUsBQ++RR
         QOQiBWMtWRAWVyos4I5d37KAHiTjdGgJYI6IHoxnSGFzEL9s9niZCd90VTql9wt2Rjmo
         XwkLMyGt14atAwM8KaGe7mNXRPgeHd60gV3C/JpDZ+mTWPgPWv69j+22CD38MzeNaZPL
         6ZkloRen9v6Imesi0yJYEJaKlVw+YZvF+OBdgh3DTg5VgQRPqRfdKW2iBhJPj+NRUCFV
         8New==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784052485; x=1784657285;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M5+GJ0P12f0uqBrDr1x6vwM7QiP4mSPEkgb1duq1OVA=;
        b=PLhf/JnVaNpWPovlYlNI7M3qbJXzbrKF+hiqGq4zAvoRIqPwM8BQZ7IH6dngNjr2DY
         bfhBqucRXPQYemUUfki1Vhl13wQ83NGwJex1NLZvrKxqiPJMXMGj/Oc95McR0p4Qn/4F
         8r6SboZs+zGmUj9pNG200MEO+B+9BkwLHyjUq+o1y5sDCJ0Lz/7ePAhR9ga7dW71FJ7Z
         ZbPQhDYEVmKKky4mI+KNl6HtbVdmhrwJq6OTxF1fygbTJf7N98wJRjdfCdh536l2cw0G
         NZ/l5Be3o0gy15etY6Flz2B7RZbMfyeqZ8qMc9fNdN4lbKoLA7+32akZXhB4f2dzucT+
         fZCw==
X-Gm-Message-State: AOJu0YxXhacnMSLuzhUWCCzF2IdYUMbNKaeCQv+1UZqPp1ZSvfZ8hekn
	QJ/3jUkPp1ILU4/EUYP7Hp8Bq24EbQaLeCWY7Uxl0XQVSwzgCM0e3j3vQjGLWUjqGKEwJOBpJkc
	IrW8TfFma65Kid76t8yXnaLqXX4g8hpOFzAQg6RUSGT1g3MvM0tEMxHcXlQxUL9GT9CAFsJbDIP
	m4gA==
X-Gm-Gg: AfdE7ckIx8DhEnQFfA4XKEVlEEb/cxohAKsY9wt8nJ91X9JacRNKCvGqO2vU32oO780
	8m0H8MovOOP0wUZsWojcQDpqtK0RbkV65q/pmjn8ofcfCVpHt8vrHUzm+eVL5fujlUzzkiK8TI9
	yLnZ/Judnt2w/eyoSUhopPLAfbqjAhSzXozGYp4194LgnArXZDagDNonck0W+aW3QlFG1yTL603
	IXkbTmd6pDrj3AKKebVCRvKNpZaRHymhIQPmd+8HUUv/nsvvajJJpovQlrED9xN4vZw7jWf32ve
	jwGiivF2zAvpl2X/DHadRkXIY+/IIIWXC1qvAxyjOi441T6+7tkZvNvmLR/Co8KFPPzr1fLHqmS
	NNEnAEcvpRhGth0blmlOwE9k+w1gsZ55dBxBhIKOFCa7Z4vwKOP7FW57cX02xPcm4Tw==
X-Received: by 2002:a05:620a:4505:b0:915:e8fc:1396 with SMTP id af79cd13be357-92ef3d1b889mr1306804785a.13.1784052485216;
        Tue, 14 Jul 2026 11:08:05 -0700 (PDT)
X-Received: by 2002:a05:620a:4505:b0:915:e8fc:1396 with SMTP id af79cd13be357-92ef3d1b889mr1306800085a.13.1784052484626;
        Tue, 14 Jul 2026 11:08:04 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930759c63fbsm465448885a.22.2026.07.14.11.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:08:03 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260704011040.26233-1-pengpeng@iscas.ac.cn>
References: <20260704011040.26233-1-pengpeng@iscas.ac.cn>
Subject: Re: [PATCH] wifi: ath11k: validate regulatory capability phy_id
Message-Id: <178405248316.4102418.3725442894895717466.b4-ty@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 11:08:03 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE4OCBTYWx0ZWRfX38nvrom8L8Ya
 ZWaUFIY0Jj8UXREN0/AQGPrdQp46LzAMSGlu3gCZi1Kp54Ul/kBhXVqz50z/bsALaEiQW5VZ3L2
 rIFgGgO9KfEofLKuHib4VFnDOVmEONM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE4OCBTYWx0ZWRfX0CnXV4+6ynR3
 rH9A46DaFON5ZNveJNyW/er7lQgyalgj9q0eZCBrfo1UXtrbg4hz2MPAQBffeeJ8M31iATAL4KI
 8O55UcxFRJUxj82vMoP1b8VztCCLH7t5Vh9jDm+hPzBGyD6rg7zSxf47Kpst7EPZmZqFzaBfhn3
 Mn4OaweM4KHuoF/ZO/9TlC9kgr9KXNeuM7XBN1x0W6nGmf+guZao3c6bVbaGdgdPQwIP3ZHRl72
 Eduq4JC7EsQstEYv7QcpRGYmxechm5ts7mR5hUFnysVnyK3KlFagOouNtaFX8Igudh1hsC2+/n+
 K9zKoz6guak7uZekPG4MhNn85mBpVDt+AnhLEOvDwu+XlpwdxyWKY2ZLqqPtRVInWYwI/EhyPbG
 DNsYvf1flV0hZaNtvPX3+A6zCGIwr+E2LK7nCmiJc1e2XI7m5Zf0jed93B2lVX2WXj87Ug8eAYx
 697d0pVZKWLGu3BBGXg==
X-Proofpoint-ORIG-GUID: MY6VB4-0VkEuEpprkAcpcnzFADY5RsEe
X-Authority-Analysis: v=2.4 cv=NfPWEWD4 c=1 sm=1 tr=0 ts=6a567b05 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=TIgdfdpnsFF7rSLKS_gA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: MY6VB4-0VkEuEpprkAcpcnzFADY5RsEe
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-39108-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:pengpeng@iscas.ac.cn,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ADF9E757BC1


On Sat, 04 Jul 2026 09:10:40 +0800, Pengpeng Hou wrote:
> ath11k_wmi_tlv_ext_hal_reg_caps() copies firmware regulatory
> capability records into soc->hal_reg_cap[] using reg_cap.phy_id as
> the destination index.  The loop count is bounded by num_phy, but the
> phy_id embedded in each record is not checked against the fixed
> MAX_RADIOS-sized destination array.
> 
> Reject firmware records whose phy_id does not fit soc->hal_reg_cap[]
> before copying the parsed capability.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: validate regulatory capability phy_id
      commit: de4685d422a69a61f67e2e2ffdb5747d73d51308

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


