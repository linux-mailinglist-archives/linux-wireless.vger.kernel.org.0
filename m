Return-Path: <linux-wireless+bounces-39111-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rvT5IP17Vmo27AAAu9opvQ
	(envelope-from <linux-wireless+bounces-39111-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 20:12:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6B5757C26
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 20:12:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=GSnbyL2b;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=HpQY0a2+;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39111-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39111-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4CEA3052E47
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 18:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D823CBE6D;
	Tue, 14 Jul 2026 18:08:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763C83CF96B
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:08:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052495; cv=none; b=X6/IRPbAT/Z6QBXUCGbd3LGtExsRu/s8KpYAAOjkaDD3ch7rst/jLqoNqz2k4YPBslJEeEdlwn25RjZ32GtTiHbxL7QFXqe9bLgm2rkHi+B1iKy2cXZCKhlvr8pE6yVpZcrMg5qwtAhf0I2rUbmTP8lnEiErjMcszekqNOt5m/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052495; c=relaxed/simple;
	bh=KzTpH30m2iskqJL541TzBmqCK3eYCZLkbtDEhhhsb70=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EURC7oCLgnUWff0d9lDtcBXAxghPOT8bMwyQlxEsZWe8pnJ7PsuIQeLYSzdk8qnmJNUuKctEdCHIusZllvXOY0gLTVJB6Eb7FnmAIxhpPrAAaSTRZySlGZAIYsu2xd5dyQqD/oLBjZ4WNQEoU9lVoZHLxIHfg8bBhvt12ZXMs80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GSnbyL2b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HpQY0a2+; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EHApEa1177396
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:08:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jt+0xnZ98YxTKU0vdngqDq5moE8+1eIe8lr5296G730=; b=GSnbyL2bA9oXAGZb
	akzIh/LberK5CzfRFtFA5fcS/IRxWkN6VYVI+s110P1X0m45h0+R1PSpZkmkHaWs
	rI50Ne14iR94yb4u3d9aay/0a396QziKlrnxJ2FPXTDvI8hDeXOQOz8R9K4hM8nm
	Gqj3l3WwNyA4R2/EoN6biV9TRz3M+jV/wlxPjRgThOrpC7iE+ruc6gNi3Lq9BVv2
	Nmi64CaTL0rFFl8tajMkmMOItKXoPxYuVXI90SroalWdRLNzcBXzzVh5K0GqgiZ4
	hir8QqWU055pDB5+FX07m/nF9IA/tEZRK6PnaoL41z8W5wgvEkGY4LdRBy/4V1K7
	Bi8AVQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fds9kr6pu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:08:11 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e6a2f5995so722799785a.3
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 11:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784052491; x=1784657291; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jt+0xnZ98YxTKU0vdngqDq5moE8+1eIe8lr5296G730=;
        b=HpQY0a2+wMQjUqhpHttnJV2BiY4woCHwMdTP2XFQ4C0i6w4I52/rjESpX3jiWi55U2
         w/TD5aItmhDtA8C1QuyKamqCqOumalyBbVZgq7uG40Rx0awx7I+bQ/ocpgYv1r5vwKN9
         yGYU2Qui0GOMxuQp6J9Fk7p3yq2rUQJwUfUCma0cCjIjSKjOrhvCHv0K+nwgC91BXgRk
         y7TmQ/4WZuxHdOy88g1LG8Wbw3nB1iBaeF0LDTmNvlVsIO6Lt0Djtu/jm2KDXuXvxqeQ
         4BIFrUqJdtl86zxRcPxEwY66aSi2r6lybVBbCOkCPl/9VIIA4xeOMgGbEy/nX+WQsKhQ
         bfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784052491; x=1784657291;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jt+0xnZ98YxTKU0vdngqDq5moE8+1eIe8lr5296G730=;
        b=HJXvyEkV6V1WGrA5dXUahNJmh+L4ZzAAZotC2Qoww3qVtJcbDc6duiIVrnOZih6qGT
         8XH3koHnbB1Ia5p9NJJFTSbTj+fKgCKsmqK9goCu1vBMyxYIjeMCv49j7obXGUvGrMw1
         c9m5tqywNT/NTflqqsjLKxQOj0DfwKfK4FXOVih1fcqlWGkVwHLekTgC0PhSDg66pVuv
         BAhPTOX2sdMu28W1eHHwtgp9HXjX1OjY61EXmnt4NxJ7P14KhyvLqiYRTDyOUwgjo9Fl
         aUKSxqggoUtES5RbFo5a7zYNHD3FdOQBrj8RjdH38oVoy9QLe9RcCTXawzKnyR8be9s2
         kSsQ==
X-Forwarded-Encrypted: i=1; AHgh+RpMJh6aKtBBsrUe/oQL5pfbymlrWYwxOBuCH0rmzm5PMn+vXhabPWZlau7efo4ohYL89zie6cq6DztN6DN1NA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGLtnPCUqsDYVkLSrtM/BracrwXUFEithr6ychg1hWYAfbt1GU
	f82j/ysEa72AIazqL1c9lnKrlqgs79PyQ4KROjmuyhTYEjZ0cXKJIVrypT1kiLRR3xzioU5cAme
	3wv5e23PXdz8EwCkugZBlx21rOIfIyBmS3KwsdMqoXw7/n9zVrsf5mQ4YA6ebl/K57Ge7bOVLCe
	dTBQ==
X-Gm-Gg: AfdE7cntlr9/VDRzdK59haMg3D2CX35Zg+SDVkLTCdem5xyflDdDBmGfi158WKH3xVg
	zMsqjZRBQ4UBIyJGlxTS5uo37KQka27U2J4SkEcW/VmnEJ64jkFbR835ETvMcpplcjqGQSyAmEf
	B4ulDctu8bSmeWxlFKAMW0wtJhmREvHzkqhq6uzKMrm0/VK+r13bD9LaP+EACDnsr31v2pC9Ppy
	DsMjiEu+35/8nhktV0M88yX5kr1sCIkC4/HCfQjjcast8QwMxP6X1RYZCpmlbE4KNVpnCaCj/ms
	NeTTrjB2o3lb/5a2zvROXTY8pZq8uWvfCQVx1bjb0/2LN3iNCFdx85Djc7hVkfiq1HvWYIwbv6Q
	RIO6b5A3Qy7yeuhz/BdcCYSF/BIP6BRpa37sSs0fono3IQN5VIdix8ptgoQucvQBwSw==
X-Received: by 2002:a05:620a:2549:b0:92e:4470:f6a7 with SMTP id af79cd13be357-92ef2b96862mr1443576085a.10.1784052490877;
        Tue, 14 Jul 2026 11:08:10 -0700 (PDT)
X-Received: by 2002:a05:620a:2549:b0:92e:4470:f6a7 with SMTP id af79cd13be357-92ef2b96862mr1443572185a.10.1784052490403;
        Tue, 14 Jul 2026 11:08:10 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930759c63fbsm465448885a.22.2026.07.14.11.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:08:08 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260705172405.119084-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260705172405.119084-2-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH] wifi: ath10k: Drop redundant NULL check on
 devm_clk_get()
Message-Id: <178405248825.4102418.11672660835815026374.b4-ty@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 11:08:08 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=Q63iJY2a c=1 sm=1 tr=0 ts=6a567b0b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=WD2RVSGR4ZOmZR8fVjQA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: ynuwIAK9bV5I1szqyelPVvrXRcdII8fW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE4OCBTYWx0ZWRfX+GVCX33WdzZv
 CKOitJ518MSKbpD+IrGZJ6EEXYN8ZOFFoNFq0GT04B/5YxM7fqfJo1dlmDa/qVNaOCKnToDIEjK
 gOb0Js7/Jedq5YRHwA4dUeNRhlm0KDo=
X-Proofpoint-GUID: ynuwIAK9bV5I1szqyelPVvrXRcdII8fW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE4OCBTYWx0ZWRfXzb19jOF24ycK
 myc/qq79EHm93Od9vfSofTN0REy0w1FpUkK1FSA8YKUCsEexR7dWhP4RK/Gdz/T8x7aogpBU3R+
 4D09Pu+4PK8xUghlVeJpUL1k6amxYr0JvWtrK/Zg54KNLlfs+GC90uPGBlHsaPsKSUwOc91Nypr
 iIpdOxrR60AGHBN7699Og94JwDYx2M/eJlPU0RcQMxxVLFm7eZmhiBzx8Ist6QBSouXYonujZ/z
 x6Qr74E0E8nqppHWtDY8ahZ0qOkK5MK5LPhguAOxIjS9dtO4vwB/0CVZ2gvAIOG00Jb1J8qpJt8
 vgzixOGBxQv4rsdegXo5+xsplAzQR4vDS2ultlF4tVPc0H29J9YmET4ptudGWi62jixpI3HNYxi
 sLfzJP41hQcsEsiqCnp9SNDbPKpLoZNYqvuKcJSRLv71QnSEd6T2VEpR10yGWb/dFovRdgelT4+
 A9hn001cwzX33MVo5ZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140188
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-39111-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:krzysztof.kozlowski@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB6B5757C26


On Sun, 05 Jul 2026 19:24:06 +0200, Krzysztof Kozlowski wrote:
> devm_clk_get() does not return NULL (only valid clock or ERR pointer),
> so simplify the code to drop redundant IS_ERR_OR_NULL().
> 
> 

Applied, thanks!

[1/1] wifi: ath10k: Drop redundant NULL check on devm_clk_get()
      commit: 298b337bb1d450793ed5248cc0345694f73f057c

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


