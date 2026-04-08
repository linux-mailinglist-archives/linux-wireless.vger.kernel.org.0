Return-Path: <linux-wireless+bounces-34500-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIrOL3em1WnE8QcAu9opvQ
	(envelope-from <linux-wireless+bounces-34500-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 02:51:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF7B3B5C72
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 02:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39C10303A6ED
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2026 00:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0481326FA60;
	Wed,  8 Apr 2026 00:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ozit/gvS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Yju0S2s+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DC12EA73D
	for <linux-wireless@vger.kernel.org>; Wed,  8 Apr 2026 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775609435; cv=none; b=CG3L41PIy4dWRrWIXyxloI6Q46L5gdEWzIGjE8J1zrJT9q61np3rqzkyBPfv7S4IaTHErLSvWnHzeYkuja4QiCF6OIybunacaQtXcs2isans2d2S8ukH/dDy39ylV6oG1dp4m3xn8HCWyVJ+0N0PuUeZCc+nADji1s87KpuP0OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775609435; c=relaxed/simple;
	bh=1Cr8PTN53dHeqtE1be+fjHeXvdGFqpP3eIJjucFNLQs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ELbS3yiGRPRXxQjbula5o1/Gt0KHJRmhhJafv1Ra0xnPbuUEPnGTsHNjxaRTXOuCRID80e6lPLEknLXvsHeVoYnXbZRqVI7WMuYzJKrkLtRSsmwRSp7EjPgasR5SCfZuuakHb1q86GuE5DW84BTB+1vDjNr0fO2n3iBYNXU4KAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ozit/gvS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Yju0S2s+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637KOJJx250047
	for <linux-wireless@vger.kernel.org>; Wed, 8 Apr 2026 00:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wZebYKoM2cJKcNc6cSC9v93X+hvHPic9bASAAaTI9s4=; b=ozit/gvSbHcoJVGz
	CPR11U4zo2QpOIqtXcl3k6+zGBikRLbtrQVr5d4a1h3S8OG+LYXe1ZT2ZjPKDJ9b
	FnXPxfeg1+T0X/aVOz8pIkNq9VC18GzgQBRYutDbiIjo89g4Nql0GYNR6yZzaSvS
	N7EIAIm/wJccG6eTgLYdRy+TsvPAEWSfStmstOo7ICrO34Q1rBVTPz9z5YemuWUj
	evC3ztikv2vVAXXdNFj69YUXCHdATQV908f2H/jtzmosEREgoQOResAHcY/w0X3F
	lR89svDdwdJ/VZSdkXZ3ioJITapBSv8k16sgYU07AsHbCEQ57r0Da/pI8knxScin
	fR3JgQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd8x98m91-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 08 Apr 2026 00:50:32 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2c0f6593ef5so7800131eec.1
        for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 17:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775609432; x=1776214232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZebYKoM2cJKcNc6cSC9v93X+hvHPic9bASAAaTI9s4=;
        b=Yju0S2s+hoovooUW0Mst4atOgwZoIACRvx9HJ/mLxhRQCd5ToyfyQL23G7ttpdUpaE
         IDPaDEt94y6qasW6M4pnUZ44zMY40SakAL7LotHDSEuC3f0MLxmDSkHqPxzKWokVrwd1
         XtGiiuyUldPLdwynpjotjC0P0UD06qNM5KuFcaLXbQRARwQ/V50dYqTpJSC/2PAAiezQ
         SFJ0yFP9+F73nxVn9aJNGsuNuDbDeek96fGnAgQ4Az+tHQkBBfx5Y7AZzF9G1l6Vfg2a
         w8SjQowKRtqsB0uWZqm8s0BW2dNQObGJzjWB9JHJnVqJ/k2WuA5imoyL/JW18EIBV+Rz
         ELdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775609432; x=1776214232;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wZebYKoM2cJKcNc6cSC9v93X+hvHPic9bASAAaTI9s4=;
        b=QkLCJaT8xRm4Wv2DOYV8kpTBctPNHvu7Y7Iyb+F2ZA4xydKlp3DN9bGRp1sQWk0dcC
         PCI4pYxuyS2UfzSMqOntF7EV3gD3nRLmxczyAjp+nhB19CMN41X9Px9iKELjcmigivdd
         QAHerYezdYw9B/kywFJIGxBArqt1na8cOn59Q5OrK9BRX2VUmcyaDUU3sip4KzAI+QBd
         6XE9tNUxyUKRaJ56Xw0FqReqBAnyU7TfNwZXoRq3lyWpmBqL5x+2qi7si26KemC+CX+Q
         ZHVImXHGIQbqWtCP6kUjCe1Uh1HugC7jG14QepAvJQa/rceKRc0keuGPmQ7Hsj2VDtZ4
         hhbg==
X-Gm-Message-State: AOJu0Yysxo97U1PGrT35pHn4pV1QtbzpfK6dtBlcgOmmy7W3OkMhmGqV
	wLAu9XCs/du0JkC5wm5OnIdqH2uj/8o6KY4b4j3TYsjMJEtJt3/ydSYYKYpfIfjELDamfXC7aum
	koQv6RpeqWsvwXHngCdY6ioaAR28xOX0wFD2Pm8iYwvkzlMyFYjK39+zCAEDPX6nicwfkTg==
X-Gm-Gg: AeBDiet7IWcrHOJFRN4s1lIi11tSzWc0lQ4+7J3VMvlZa+CBdXxeLORfYGU2gceIIvE
	ZRt00Nfab2oAROIwkS5LViexGJACdz4iwlPitTHmppJRUZTpQBO1ZSlQaHF9aDDO5p173LSwrJR
	Uvjj3MuapNG1n5xop4EUjQkqPK8sPaws3cgi736hGuRhh9QAWH4olfM9k8Fn/XtOq0WY88oPZFd
	icHkoe+5MjfvurrD4DpAAL/4E+8SpYEvdjO/OwA+3YO6tdlS5Y/WJMwvPzCFt/ZVs32GJDpMDYg
	UfTvzv/yBqSR867r8gKzwiyhAukC83mH2nEv3ItEnmG7P9ZCitF1JXhYDm9WUHgT2L1PiATXUTI
	/O94lawE8OSqxEs17YOirhtR3H2iIhNJeFQeCp+iVPCeHzGvdnBYRV7feQOwxoIytplIxL4TeLb
	Sn
X-Received: by 2002:a05:7301:1f01:b0:2c5:50fe:c78f with SMTP id 5a478bee46e88-2cbfa9b024bmr8302627eec.12.1775609432231;
        Tue, 07 Apr 2026 17:50:32 -0700 (PDT)
X-Received: by 2002:a05:7301:1f01:b0:2c5:50fe:c78f with SMTP id 5a478bee46e88-2cbfa9b024bmr8302609eec.12.1775609431693;
        Tue, 07 Apr 2026 17:50:31 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d2d5409fd1sm1257301eec.13.2026.04.07.17.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 17:50:30 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
        Saravanakumar Duraisamy <quic_saradura@quicinc.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Sowmiya Sree Elavalagan <sowmiya.elavalagan@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20260407-ath12k-ipq5424-v5-0-8e96aa660ec4@oss.qualcomm.com>
References: <20260407-ath12k-ipq5424-v5-0-8e96aa660ec4@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v5 0/6] wifi: ath12k: Enable IPQ5424 AHB WiFi
 device
Message-Id: <177560943002.2878209.1743406779357406462.b4-ty@oss.qualcomm.com>
Date: Tue, 07 Apr 2026 17:50:30 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=Rr716imK c=1 sm=1 tr=0 ts=69d5a659 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=2XysiazmuIoG6y2HQ6cA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAwMyBTYWx0ZWRfX84Vke9pMAhlk
 28gPHLvj/nY+hDonMlXPXtH1jw0VvOWVLTJcO0wWlWI6ALga/qjo9/ZoyY4wYBGIrd5filhVPen
 arrbCy4MYEkdak56D1L0g590RbAPKQdDTgXr3aPQ4vI+ZAfx1BbfbJTyMR43eXcA/dfzd2OZJ20
 jTU7ZgWrwsxWsgzTT1xpEsXkcKIPbB4/kdjxpTV/kpGZHij61DHwhnnCIc/Y9gax0qaV0cJttTC
 Nt/mR/nKif6WIAbJ0jNiR2hjP0eYwHLlo9eKhm2XWvjBgrqxwzZAEaUa/ufKR60HxKQdgrmO/EC
 U43X0ZpPtPUO1Lkpxp+fimgnw8+Rc49E9bW6lxqaPhSx5u48c78hCPMAU+gqokmY0GdJFHt/f/n
 5mOMif49Mt92fQbaw89N5UO/b8EFHGaqLUAzzROoFPyKcKuATXRo3Hu/H/xVQvgQaNb0DHsq73d
 zRhn6kOL3iUkGaePJMQ==
X-Proofpoint-ORIG-GUID: jYocUPa1gEWoWJLPnap4VjQwqg6HHkQ7
X-Proofpoint-GUID: jYocUPa1gEWoWJLPnap4VjQwqg6HHkQ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_05,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080003
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34500-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5FF7B3B5C72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, 07 Apr 2026 10:56:27 +0530, Raj Kumar Bhagat wrote:
> Add support for the new ath12k AHB device IPQ5424, as currently, Ath12k
> AHB only supports IPQ5332 WiFi devices.
> 
> The IPQ5424 is an IEEE 802.11be 2 GHz WiFi device, supporting 4x4
> configurations. To enable the IPQ5424 device:
> - Add the necessary hardware parameters for IPQ5424.
> - Modify the boot-up sequence for ath12k AHB to accommodate the
>   requirements of the IPQ5424 device.
> 
> [...]

Applied, thanks!

[1/6] dt-bindings: net: wireless: add ath12k wifi device IPQ5424
      commit: 3ebaf730b5832319726e12ebe634a7679eaf2e9b
[2/6] wifi: ath12k: Add ath12k_hw_params for IPQ5424
      commit: b1ad1a052beda2ac0400d6d4cc05dd2e549a6936
[3/6] wifi: ath12k: add ath12k_hw_version_map entry for IPQ5424
      commit: 74f5a619b1a6a06cc5e6246d326da5b6f2b0fcbd
[4/6] wifi: ath12k: add ath12k_hw_regs for IPQ5424
      commit: 7e2131ba332f5ae62b6302eb889feeeea56a1691
[5/6] wifi: ath12k: Add CE remap hardware parameters for IPQ5424
      commit: 38cff745fa7c0b006f95565a2e5de9f0cac13702
[6/6] wifi: ath12k: Enable IPQ5424 WiFi device support
      commit: 8fb66931fe31094aa2e1b2a5c015050b8b4cb2ec

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


