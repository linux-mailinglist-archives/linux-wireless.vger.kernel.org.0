Return-Path: <linux-wireless+bounces-38407-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IiTMFog0RGoKqgoAu9opvQ
	(envelope-from <linux-wireless+bounces-38407-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:26:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF22B6E821F
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:26:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=mOovXEcb;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Wqhcs+ZI;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38407-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38407-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BE6A301452B
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 21:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EA82D5C7A;
	Tue, 30 Jun 2026 21:26:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CB031BCAE
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854785; cv=none; b=Xfoy39baKf4E7UjMhp1ZxEEcCcFzZn17kKnlsSLTcD28xyRCkU4dE6D74zMXpEAoMQdRjj2fLbpECnzzezKIHw2DYRzNd6+smvQEN1motCRuW7eW3xcL0L6MIfMDW6wzcU5KaKGqvfaIyQB+UdMzYtWhyRdSd1WF/8cWMBMN5vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854785; c=relaxed/simple;
	bh=rPdk/fRDQOAwtXGgBUbkF6Dn2NlStntYRgzKVUB1Y0w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OViMORci0Ze03iL945WEib0bLOCBKVdxRzbCAD55LXaYEDKv9INoL5ZPCE8aHz2keL836Ixqkhgxqlo0B7f/H+vIVPOd/Z7hv48U1od9O6cV2kKYMzvbyBZG9eLQmNjL+uuh0w5YX6ouNSI4jZPUPPQeROCM2wAAi2/WfSuLmBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mOovXEcb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wqhcs+ZI; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJDYJn2942543
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KREdOKwOAyIofQzjb8Ff0K7Ijz9cfNWpd0Wm1nV17Gs=; b=mOovXEcb5gTVWthk
	QmrvjRHCpSWSi68OtPMZZDf5dV3Gm/xdseP+neFE/YdFly0HRRgcJ5YQ55a+xoyH
	h4SgaCqGoHrO8PnMv2Rc79Olf84opAh/aaCLIlBUiiSja8xw4+HDwKz5I06TblaO
	RNhImrGJNocSVedqSRmSfuXCas9DTRBkaztRa9Y8SPL7cq+S80dYVV/6IhEYASve
	zV2qWZFf1MaqYq36kuVyvbEvyNHJ5j0QFZHBSfxcCJc1FBhzNQLX0MfRB02J7hUt
	YWdIQMUntGqpnw8Jx1DrSUHMSCnLSi8b+2oyjqf18qJJVyDQ4/DkRSHnrUBn/IRg
	GT+Plw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4j99h0f6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:23 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30ca3374c6aso578461eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 14:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782854783; x=1783459583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KREdOKwOAyIofQzjb8Ff0K7Ijz9cfNWpd0Wm1nV17Gs=;
        b=Wqhcs+ZIeQlbT12VYaBqxzZCcDTxvTCtqBYiWBsiwsCOLRkv3Jw/EO056EmHhYHhPY
         fvErTFRtGKjb+NsG/VISRY59k7DjKYs0YSfdh8rey26XeQbzHdh3gwzaN0NqAVQJr4mo
         h7B9Sz+CDr3eZLOorz5uBhKcSjF+cg7PINccW1bUxDjToIoxNDgH/TO7A1Zao5cLZQcr
         ApWrjfDzspydAbj9DUtDpmEg3Djct64ToHq39bj7Jx+qffPLhnvmN8RdTjyGY+RqfFYN
         LlNZUj+tv9Nd3TX1czHxWpdIdgFnb0Mbw52gqG6dk3yMtqSR5nye+PHKwNgggHRtYGpQ
         vg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782854783; x=1783459583;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KREdOKwOAyIofQzjb8Ff0K7Ijz9cfNWpd0Wm1nV17Gs=;
        b=qocERbSEt886pl7PgCCuENMJqVLBp3tWNi51rwgcfVCSn+lshQwY4XnqhbR3M43USa
         hv0StgXTGt5gSq7mig6UnUBd/N/IMiManO+AFASnwh3w1WNqFCpeUXhrz8nou20SeiuA
         8YpmcMPqmmzjSQ73oNB4XhwMNsaYVGyvw/meHXb/1dQ69u620W16S+Cj21fERAcVpxj6
         ypyjkVQ8VyZ8jANDR4V43PqW/YgadeyR1tI/voVqq+dJZ7ro/+Sh98o3F5BU+LIEF7ra
         Nu1JBYCa1J/Ja624jPjX6K/FconuWC6SIu3y4JYwUd19uFYV3JUHWxl6/bTojLhb+aa+
         XREg==
X-Gm-Message-State: AOJu0YxW1CmWIKHvM4iuGnSVVxeRU5O9QThIBXPdgow+2wvrIIYEHj11
	qsPy4m3UvySeAxeRGtJkHzCf6ndqixh+zGyrMyETpvflypZD3od2hnLwnuYHPgpoYSf04E3PA5G
	i79x6jk6aJ+RJ+lutdJUt8VBZ2QafLJ5x/Qz9YBQLq5GCcypu+nLepJrAuFb6St3SjLYzCQ==
X-Gm-Gg: AfdE7cnIjbZ8QOQtna8KQc1MaepnHOAMy1EkxQNrRMhfeVpYJAEsF+pm00WVPlLxRVA
	+/wM9EPTN1/BbPH2ySthFmYjDrycfRU3YnQ6LLPY7+OAqqvwu3C3lCqMyFRYaLk5Z25U40ja/5X
	5NK1oAe/uDvYa+alU22tfniAHUA3kxGiTER2iGdAHGfUCoBHtzptofsL5/AnjMvni350TaUgF25
	Kcfp8bs+5wkKXYA47Jpt1JSUyW9e2RsBO5roGZS4wY5LrDRgLbqpxmbkuzp+yXG4imUzjvCm5n5
	fwjIRQ4Ovy5lZL4RDnFpcyPs+WS/TUZzfx3XWZBgY8S70npN/asXBhcfPodnJevjp8w5y+zmGph
	QfMXObwV0GHOWYKPceZH2oQ5C9n8aBwvkjx3zFly4lLV8dryIqQqXD3iCb4hqMa4OJQ==
X-Received: by 2002:a05:7300:5bab:b0:30c:ab4d:da3b with SMTP id 5a478bee46e88-30ee1472648mr3803057eec.45.1782854782599;
        Tue, 30 Jun 2026 14:26:22 -0700 (PDT)
X-Received: by 2002:a05:7300:5bab:b0:30c:ab4d:da3b with SMTP id 5a478bee46e88-30ee1472648mr3803032eec.45.1782854782134;
        Tue, 30 Jun 2026 14:26:22 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee300b286sm11604046eec.12.2026.06.30.14.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 14:26:19 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260623-qmi-debug-log-v1-1-79471aa8b898@oss.qualcomm.com>
References: <20260623-qmi-debug-log-v1-1-79471aa8b898@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: use %u for unsigned variables
 in QMI debug logs
Message-Id: <178285477895.1590147.6905883761168987404.b4-ty@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:26:18 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIwOCBTYWx0ZWRfX0C2rot8xt5hd
 sIoCihAvil2Kxblq4SEHTZ8jCIX/ghVdsJMHy3wfV7mdk3PYJxVMBh/nV6wcYGNvN0/msiWZyxz
 MyFs5DI6yIU5B06FQqzZpvy+rZ3b3jU=
X-Proofpoint-ORIG-GUID: 26lVlcUoWoNNGQNgu6LpOL8esh0ZKjc1
X-Proofpoint-GUID: 26lVlcUoWoNNGQNgu6LpOL8esh0ZKjc1
X-Authority-Analysis: v=2.4 cv=bNcm5v+Z c=1 sm=1 tr=0 ts=6a44347f cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=tGGASSKubhSInVnLuO8A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIwOCBTYWx0ZWRfXzKj5fpQqYfjm
 +ciuEiGk3J7bP6kaL8kPDcgOwHiCGAdmSzAIIG28uK8eXmk9UR/YXYOX5EQ7aANo6WKyUtPTmXn
 j+HCAmTLL2AKz4ygNEHG+NsjG2K7m5Klw/uTgMHeLJ9EltHbfYZGuQ+EN8ciWWlW79s0+Eb7uPP
 ELVfD2/+tK6JIr5fUMMg1klnjrLexUjqCED16asM5xoF8SWljODT/75N+MAOi8EEWN4WXnHbFiw
 5lbioDQLtAFAzglyV0H97uSXMi99TEh/u+ApyckZkvrvMED82J5DVdTpwE1fvYVV6nEpilfl4ul
 eVXYmf3KXlDA+qGXKKnjxQZtjPW0PiGvQUZfAjUHpV0ndGKuNw8xvBj9xHBTQjlGcT+uZqCJ9rB
 LaYUQHBTCbili/169zWjqk8BSWqyKbHgkokRIzCnxLL+vHez6VefH/dspk5IzuegKeSRyUmZEOG
 8MCTvxgc8UCy7ddfi7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300208
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38407-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:raj.bhagat@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF22B6E821F


On Tue, 23 Jun 2026 09:34:17 +0530, Raj Kumar Bhagat wrote:
> Replace incorrect %d format specifiers with %u for unsigned variables
> in qmi.c debug messages. Also add missing trailing '\n' in log messages
> to ensure proper termination. No functional change intended.
> 
> Tested-on: Compile tested only.
> 
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: use %u for unsigned variables in QMI debug logs
      commit: 26d529b99861707ed0a4c626184b9399bedca808

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


