Return-Path: <linux-wireless+bounces-38414-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BDJ7N5o0RGoRqgoAu9opvQ
	(envelope-from <linux-wireless+bounces-38414-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:26:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDA76E8227
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:26:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="mb+0K/O4";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=ZloQAR0e;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38414-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38414-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B66D43016AF2
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 21:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7C131AA87;
	Tue, 30 Jun 2026 21:26:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2814425B0B7
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854799; cv=none; b=NnpWXpo5ssg7T2AF63xAEdVXeiStwnGAzhn/gtaOSGAFBMw6eqThdt4B+yD5bOCycmqjQyF8CFbFxi3iXNB8znS0x36qSaejeA/6ro5vEfAOzQWF0jSl5uH01CSsg6cPqxVVsdc9qUGxExT4XPNGW/YJkgp3tpuMLTT61toQfrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854799; c=relaxed/simple;
	bh=o1Ig5gua/Lf5mGwBiaNoZNF8kLLIvsF6+5oObsqxRJE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QYGBW6R8ZqM0xYbCAwGCCbPqJDQAtQWUHilr+/+Ql22rhJwnO7Nv5W5NUvdNQ9M5hQImWljsVRZNZCkHNeiofzuV9nP1Ov5S93Xb4g5fsRdggF0As7itP4z2MpRTDC6vkM0jBsd9plQOok9qzXFMCPulIx1kM4cjO/jhmDks6uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mb+0K/O4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZloQAR0e; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJDaCZ2959907
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dU0o+2l8vSV1Dy91oKNMoT6ECd1McbX7tc5D01UR6xQ=; b=mb+0K/O4ExwJsgjE
	ncrUrVaXobD7FlWZ5kTIY6Ucb0NkszAKvbtN8Hhpcznr5PgMlp0YbgBbNwwfDr/8
	uQjTkcEdIsibApGJKblsMDNk25YMofkHGCCzlPTxgZf3xkX5ZbrSNPKwv2Ab0rpI
	CHq1RzPNiIgj1GeRx/WKhDmu+HIvM4LCFt6kHa6NLr73KpLnbqKp9gUO/OjD0uvD
	uMVc2ROFA/zj2gLAV8/1vDdGyUfj5wJkRC7yxyIyuv2iK7OxTcFU7rNMNL1HlPVD
	I9jGhgxAEYcXWLNdqPoyWElV2H3/+j0tPa3lkQ3YzxBKTKLdxus1NiOEUm5LOqIX
	6IKW6g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4j911015-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:37 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30bcb065bfdso5881898eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 14:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782854797; x=1783459597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dU0o+2l8vSV1Dy91oKNMoT6ECd1McbX7tc5D01UR6xQ=;
        b=ZloQAR0e2PYSU/23SL1hNpY4dPwCjLBvEtD7VWRzNyezcoRoSCATAOySc397aDFjw1
         36A1rynFU6rltLA1JuPRWORv3+b94w1QdC08udvdAuQ6WPWNd1sJAcAKLlZEetRI0Zh2
         97NF8/jeC+Q2mSCyxA1JujexO1CD9PFab2JHkG9bcFj/5A5RSc/V2Lnn7ybWtiei1wnX
         O1mqtGv/MOP3SFvnfPXWe/bFCrdElETC9sOkTlDIuEV/jt3F/daKx1u8pqn9xJs1x/yH
         b4Cd/Nu+h0RT/p15SL/y8oo2Z+4JvgrLcJwA9kgxFvR4ZIaOigkvrvFojwSGSt0qqY+D
         LWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782854797; x=1783459597;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dU0o+2l8vSV1Dy91oKNMoT6ECd1McbX7tc5D01UR6xQ=;
        b=ZjVk1fCcjKZi0IHfTKUpgIiZv1J7Viu0hm5w7P6zNWX8Eccl/gEax3+z3Cpc1wiYS9
         Q8t/Mn8mpeqwfO64KMCUh5L0nOgeyqPQb0F7bbY+npJDEfze/6c4zhDZ8F2PFebsafmR
         WA3OBTGnYRof6QEE7lskPzk3MwPPPRJlHFGF36+/h8NBbUBLgsXksDJRdjIo10SI2awN
         en+/fUyU8CJhrVIkTttevUzh559kfN/m08Qmlakw5y/kBDAmMLhULia566QVb9QtRbwn
         6pVQCCMWHiRGriunGwMg9SHADtL3yj6GqIwEUit0vAbe/Def/WmNElEm8I0wi2WyzMu4
         ZWlw==
X-Gm-Message-State: AOJu0YwaYigsovSMCgtaTJgCARv3eiledW5+CD+1fWDAUd5t+w9+H9BR
	QBL3nZKUUg62GBsNExnEH4xmg0d0P6Ybv84xPZBrh9gK/qAgCNTR+UNLcEtDwUJMn90ibakm0O0
	d3qL7r7zVTnpqg6oyjQf8p+EqCKlpSXhIsfe6VpClSCI3EG7uXd8vRonOSUjeC/m9PcUW6FUcxH
	uMIQ==
X-Gm-Gg: AfdE7cn5skZl3knqEK8feqm3g2utiRLp7dZuYhB2zoR8arZRmgovSPXKyaRH4KCXkCy
	lxhOB30AQQsE1HGP9MYICVqiCA6xgcAW3N4Bl4+yVnprhoRviZba3nlydgRnP7fIBdBSdGe3+rM
	CMUbAjoRFfY5sB2y5/hOEPIV2kjZw7enr0EI1x/zRtJRRMFyx0IgizVIHvbuiMfu/9OjDzNmjoB
	QK6SAqp7YOfgVl3Pk3oucXTPsqAEwI8YNjfh0fXmCDt0yeDN7lPTkOPu2QbTymTpdEs+Ac4bQv+
	6vY4sUVE7/xBTYK5mZTZ3xRguIMgWQDGGplW6wAzGPsYxxnDFrx28lkW22cO180271DqFxSOHjn
	rfcDoMKLE9HdjgCx8H4bPFYVeNElmJK+pudONmPnbo9cyNnEyXTf/+3psR6Uom8QyYg==
X-Received: by 2002:a05:7300:545:b0:304:bce8:fa30 with SMTP id 5a478bee46e88-30ee11ab946mr5307231eec.5.1782854796927;
        Tue, 30 Jun 2026 14:26:36 -0700 (PDT)
X-Received: by 2002:a05:7300:545:b0:304:bce8:fa30 with SMTP id 5a478bee46e88-30ee11ab946mr5307200eec.5.1782854796382;
        Tue, 30 Jun 2026 14:26:36 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee300b286sm11604046eec.12.2026.06.30.14.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 14:26:35 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260623100501.2100119-1-tamizh.raja@oss.qualcomm.com>
References: <20260623100501.2100119-1-tamizh.raja@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Advertise multicast Ethernet
 encapsulation offload support
Message-Id: <178285479567.1590147.4813798296880347761.b4-ty@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:26:35 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: kXjvbrHFAz-h9eQVe3DJzwHcevdRj-29
X-Authority-Analysis: v=2.4 cv=ftfsol4f c=1 sm=1 tr=0 ts=6a44348d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=0vawpYmtxxF2E-qvgzkA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: kXjvbrHFAz-h9eQVe3DJzwHcevdRj-29
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIwOCBTYWx0ZWRfX4xkRP+LNAanC
 V/KLGQ8+xN2fwyiuyNHW+ghjbowmdBQxy7K8L/v194QB/eRc5IObVTJs9otmHMgT8QNuvjCXTnZ
 Y7cDkiBVtWkwULR9LG5n+yjWv5umRiOgTHnKJfPRjhpnv8FIf2pETnSI++3/va0GR16Y3jUPd9M
 R4+eM3MR65/jGfLg/H3w5vtMqhcKP5wXWU+E/hNLCIFRgJNR0gfCQcyXRJx4+auK6G0KOTodojO
 ForpejthbkGxnKTy7avjnpht5iCZaasbICOeNXfpwdlXz5ZfwuHlKXSO101e+2BzkF2y/XKcOf3
 qjiCPMfR1P/bltHnPH6FTmmhBH6d+pNxTOKiTMMx+GGymW7PY7k3oon3TmiCIFDFj5YBWEujQZH
 f2IBleoEOJ+tmkG/G5Oa8/b0Hhaeneox2r+cpVC8TS8si0D2ZFtvtK3pcO0dmXcbFQ31ifSgBtV
 wbDMJDAWsXTzq60IDIQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIwOCBTYWx0ZWRfX7alBfjdYw/1S
 FAcnY+NDUV3RalCAxwEzzOmrN0lZxZs4N4EdQD9aCN6QkWQUyd31pzc5xK73O0uo6gDXjv/92oY
 N6Kl/LrXnfFpfe0pJ2m2BoXtscDCJt0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300208
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
	TAGGED_FROM(0.00)[bounces-38414-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:tamizh.raja@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CEDA76E8227


On Tue, 23 Jun 2026 15:35:01 +0530, Tamizh Chelvam Raja wrote:
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
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Advertise multicast Ethernet encapsulation offload support
      commit: e47d6c9bb4165721f61356f5fccae8f7dd78876b

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


