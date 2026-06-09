Return-Path: <linux-wireless+bounces-37587-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZuoAOzocKGpx+AIAu9opvQ
	(envelope-from <linux-wireless+bounces-37587-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 15:59:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E67660CA2
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 15:59:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=psIJa4hw;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="DBL/Lnxn";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37587-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37587-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA5D130699EF
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 13:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94840421EF8;
	Tue,  9 Jun 2026 13:55:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550EA274B44
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jun 2026 13:55:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781013313; cv=none; b=iPQeBnWnWiidMkOiSlDnP+8UhVZmELDKVQR/A+dYscsql8yrjk+bfp7jtCej8QqRvz95zGzAQ/hVGtC5hm+X5wqsoxu+6fs1aKuKMbXdPF7bH8snw0xOShYtA/rNnlDh8r8fZNOqBa7HMBKxJogPHOpuXeGWuKevCh/TY+zkz5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781013313; c=relaxed/simple;
	bh=O9h+B/vjDvyVdqobbMKYv1lcWWJLo2ViCtHb0iNlXBw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FM+JfPJlcOi4nVeoBPyLdZ6QLOb19ajYSlw9rTXI0GHTBwt9aNPc9AeYJ2ftnSBxmM1IJgs6HfvyOH86MJYt+s8qqT8+vUTO75I37EWpI2Qp7D+WfSpxyNzwpyH/0mzZD/XOmggYPv1Bu1rnBPTdCfQnCkn60r6ka4qln3Aa4uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=psIJa4hw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DBL/Lnxn; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659ClW3m2693966
	for <linux-wireless@vger.kernel.org>; Tue, 9 Jun 2026 13:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tPUhQU2r01fTv3p26ZiHt/lae2p6AaG41ksdfDwY4IQ=; b=psIJa4hwrjT/9RRi
	WMl+IQdnpcyeDVvI/i5tCQ18DZxeWQr8JXXopWK1ZjzLlO/wcQzcsWkOk838yIPa
	QBSVvMQKdUt/BhPJPwTIni1WewXMwj+yGTCAE+lTMS4JjyQGNCVSskgfif6OmnNh
	SuyoNtAXpfR02A4TnNXrFJAiEom9YzABCttS4NvB86pNx3sPbftTcTalcQNNcH1F
	WIbRgtPFtVjYCrKeir2EdvRPtNlIO4O8LDQDjk9LeI8B0UxFFN4dkFisdYM+4dWN
	BMTE/L6NRIfi5bsl8fD/Uc/PI8Ma5gIhUYPt3I4RQVU40iG0myViCpdWQPIOt5mk
	e8373A==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3v17at-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 13:55:11 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-13815e0e6baso3345997c88.0
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 06:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781013310; x=1781618110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPUhQU2r01fTv3p26ZiHt/lae2p6AaG41ksdfDwY4IQ=;
        b=DBL/LnxnIJOCyUArghftrN7QBBnKJ+RfkP+wxGjVCGsmV4MiSp2KVB1ey9IQY/z1CA
         ar2iKqOFNhiTcjcVmf5jSsr16qy5VJ/GHPW7o+UlHyuyXoct5aqea+KOAUlwHqNWTEzP
         4Mf4UCQfGjPJHr8b4MC3GQ6k7qUtD9tidOObj+Yohkr4Dr/WwTzC2KnxGmiIFXFet7C+
         pyTn2COx/FcGy3ghAd2g8423fVU5hnEKcMYu2kFX/vsbobj10cSnZ2xFtCLUCrGzaqEo
         7nA5hzK4GjyN3BKbUlfTtVkUe3/VcfaQOSg+pJxRRZkMxhd9iXd1ZvkVXxZXm74FMnXU
         hYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781013310; x=1781618110;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tPUhQU2r01fTv3p26ZiHt/lae2p6AaG41ksdfDwY4IQ=;
        b=GAnfavCk9hmZYA1ZbYRD9u4TmV1C9SeZwpeHgnN1S/y9DMXC1H2htjXVZgfotXMP/Z
         QPRW9m2pH6X/rlxvINNpVVf6xV8TAAtoZWa58i5+MwqOAKM696zwLed6PmZsO0DTsLTd
         MQlxy2qgV9TSt0vWZL2n856T3huhpY+WnXNfaX3Q0qaOWvVQeprTTOlTKnDp8qmYIWKT
         f2gsNdHbmnrFpDQhcpE/J/diS07NYwBj4NvKdpb+q9oGzp/GlFf5Z0dgUKlr+FhlCy5Q
         5XJt0II5sqFBLajzew3x4mkQFhtcR3wdRjWCiQSNYeSiZFSiqiCu03UrLOxbO4Of01U1
         Bptg==
X-Gm-Message-State: AOJu0YxOvXDPLl49EX/y814H7PDzCeS0lCK1Revu+XFK6VBG41fK9k7N
	27w5es7aaO1lqGrTcQuMTXo6UrLdCoQZazTTPKcWGCq05WG8UQPh016Lm+CAeXGyLSRFRLXFHYa
	SQqApkImcEc+DZ8G/TTR5Bn1Ek6pd6HgVqBtI0CHx6biMmSef8KsJQZwuPYvR4JQWmm1dLvkaOC
	j8Cg==
X-Gm-Gg: Acq92OHqWxBc6S248cHrd7VMrwLxi+n3teAyXAx/QXTg+PPj1/6yvlDHOe3QlOft6dy
	rDvOR++2jFBFKHz/JUfmirFDE5l43/l0Hrwk5PlrY1+6ocO/moNo6d0VDeE/EfLLGcV2aiWd7yD
	pnQyGc/5KVp6cSxX0gWuGjq0U1Clx5O87JK1s1GLysHCAnGMCntKHMatkii+opGk4r2lE50afzT
	SSQ8zN86joTqDwX2IqJsA4B2lCTt2S7mi7kTW78AxQLLh1v2/Z86HVvN3VT4x9ic/HUM8kVl/Es
	4UmI1e/MaztMbteOKpP7SSND5tY9bDrTrnS0wbRo6SoM9qMpEl75pVTjGNgcIMzOQR/efoMPcmC
	9VkVTQxD+j6Zyf8hJoh2vE5G3iimR+JlBLEOoihJwusVzHQulbzNQH9WTxIWYQWZtVWNVSa3RDw
	LVV6yCBfUOXDI=
X-Received: by 2002:a05:7022:485:b0:12d:ff1b:92f5 with SMTP id a92af1059eb24-1380671c90amr10859154c88.28.1781013310200;
        Tue, 09 Jun 2026 06:55:10 -0700 (PDT)
X-Received: by 2002:a05:7022:485:b0:12d:ff1b:92f5 with SMTP id a92af1059eb24-1380671c90amr10859126c88.28.1781013309570;
        Tue, 09 Jun 2026 06:55:09 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f54c9c12sm15289555c88.6.2026.06.09.06.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 06:55:09 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org,
        ath10k@lists.infradead.org
In-Reply-To: <20260608-ath12k-copyright-v2-0-37504d70b03c@oss.qualcomm.com>
References: <20260608-ath12k-copyright-v2-0-37504d70b03c@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v2 0/4] wifi: ath: Update copyrights
Message-Id: <178101330879.3249128.7536641999721220001.b4-ty@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 06:55:08 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=St6gLvO0 c=1 sm=1 tr=0 ts=6a281b3f cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=p5YVH5xWJpdpfVUbqF8A:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: AXiqVQWFvzhBXVT-TEP2fn-p-YItYMdy
X-Proofpoint-GUID: AXiqVQWFvzhBXVT-TEP2fn-p-YItYMdy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEzMiBTYWx0ZWRfX6A9Inl7XTP7f
 9dNtiKMcYZZBfOCg99QIx1hocezxz0bAt6BNKxt1iCD3qzUqW4j7bpAiMwbPtcURp1U76E8Jy++
 hfE/lqpyUxdem/6F/AExM+X8JkaA2Q6imibcHXrYAhlO08Bet35yu26KSUV83eFPjHZeFqqU82p
 1oy4qcusAL5wt/dP/jGbKOgVJTwSm3JqrhKfjIFD2O53AzlsshlPgAXq68Wj5L+zKOavwhWXODb
 0iZyC2ddVCUA4S+MSehtVNvJ4RvP2qmFSgn7ZV6j6g1MHfaEWeFtQOF4Lo7q2p0laDodxtTtJ00
 be75fMbFjoSklugTPXFney4eFeuLUc1fdOIX7JEoahHZYqfuGrQJIrOPMY0UDPqdQXNyDMisOI4
 HOYYGOu5zhc0/eWPqERhyoZQ+aSUDHbn/++Mn908V5eWhNrsulHGb6mBKpWa+vkQLkYviFZJ/Ts
 sbuwqraAH0oeLwV9yUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090132
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37587-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:jeff.johnson@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:ath11k@lists.infradead.org,m:ath10k@lists.infradead.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64E67660CA2


On Mon, 08 Jun 2026 06:21:31 -0700, Jeff Johnson wrote:
> Update the Qualcomm copyrights in the ath wireless drivers that were
> substantially contributed by Qualcomm using the current guidance from
> the legal team.
> 

Applied, thanks!

[1/4] wifi: ath12k: Update Qualcomm copyrights
      commit: 1c316d02c399e5efb1279666c078f99b3f72b0ca
[2/4] wifi: ath11k: Update Qualcomm copyrights
      commit: 053a93808d4654fae18633b01a747caa7a281aaa
[3/4] wifi: ath10k: Update Qualcomm copyrights
      commit: ae667b0f98b80146ea22830a1b53c5758ad742f1
[4/4] wifi: ath: Update copyright in testmode_i.h
      commit: 21d83c6e9e45156f4cad8c7cd6fc2d5bbc76f73e

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


