Return-Path: <linux-wireless+bounces-39104-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gb4nM3B7Vmqt6wAAu9opvQ
	(envelope-from <linux-wireless+bounces-39104-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 20:09:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 319D1757BEA
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 20:09:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Jvy6dpCA;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=NTAgkKZi;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39104-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39104-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5309A315DDD0
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 18:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DB33CC33F;
	Tue, 14 Jul 2026 18:08:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBF532ED54
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:07:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052480; cv=none; b=CywU0EZl5PZzCEDIN6jJK0HuwFqgGigldP8J1Hjt9HrJjMhaBMtTFJ6xZKzGBJVgaBuGkx1MfY0kA4NFRri/0EXCwKxS0Wz1fKaFRzGVYtjvw8o7Ed6oM5cgpzqwoSp+pNL/l7f6CBQpDETDnZ+g3FpuF6ODE7efVIt0K3V7Pls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052480; c=relaxed/simple;
	bh=a0JBsoSiwO44ju4qQdeKcsvsYwNuLaSKSC00SrO+iUw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YMmdyPcRSMWJB9JsdBhtzFqcVqXKaGnroDi4+Hca1mPbjZOZMIDGBgwmvftgtThP/plg72rb8RIH1x/tgMN54yOQ7FpBIRem8nYKMjkbKTXs6HqWf53EgJrpv/i8iDyQZ2I89JJ1nfqNoTOZmVUgBTf+zn7VKlMtGIWRZRkmCSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jvy6dpCA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NTAgkKZi; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EG6pCV1003028
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V+5TrJoGURD9IsGPvc967TunM6WZHJBwBoK1PahMXkU=; b=Jvy6dpCAwi3yy9TA
	P8+4Gbc232HtANdQfoucgoKDPeYltAjwCfLPgwB6/MFM6MbWlEjwHqnvpVMFquBD
	oxksw1Us6lE8khfUDHlQtdr4DIZLCYscQeDJTtZScKwC+wrVD+2bWGkB4Tnnm7x+
	2ii5bOImTwjW9SrE314JBYRBe2RaO8Sew8ZC96U7OPjirfw6saEfnODCHQJZ6CbG
	1e2ywUJX+O8ed0PP0SCNVVnsMJi4hrH+/SQ166AarZ35Pa0DbMPO6VK/V5TxWa+G
	65M5vqBtXxOUJj+L6buU626q//UAeXEXKhFcemS/mVTKdIGXqH6czSDnOuA24+r3
	d37r0A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnnr191w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:07:58 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e5fc4c7e9so130038585a.3
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 11:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784052478; x=1784657278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V+5TrJoGURD9IsGPvc967TunM6WZHJBwBoK1PahMXkU=;
        b=NTAgkKZick6Eg0+5jfTSrzWxE34IV8fuwNg/2j1HqOTuXj89CzLeb1bF+7cGmnifJZ
         sIHGc7+lhVSCsu9F1hBnP6H2CD/pZwkDEErCMnmMCbfjcVFdwrskjJe8DiM/0u/HTsTr
         rG37gYxaf+Cp01GnIOl6W2TjB+Cc4NT3jhntsvy2PPjdQnOCqHNXknhBOOGnQo3rd+XF
         cLVN4m+xJmvoSb0EfOA9yOUIoPgZ/Yh00RfbG2GCij8Up9Ih6I+TjT4y96JnBjAdmuvF
         s8t1CGIdCHDFVY0Z2VgKu0ppzJc2RcT7mQgV/GospDvy2K6XNhWOTtJzFCBZ7j/We/Sw
         drVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784052478; x=1784657278;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V+5TrJoGURD9IsGPvc967TunM6WZHJBwBoK1PahMXkU=;
        b=GmUmPLnLpgRCsMq9ivhJXHqNf3bZNdgEKUxX4ZhRyhBTh3/AhZnPxDAdYyIpjQLPCZ
         HVc10WVHEwhla/zNCv4U95L3QNCYfY1R1OWJcfcN70x/KjGIc+q6hZvwkjCtY5sdNAJJ
         izMP/XzGd5P/wbZt44CcZk9IpuDIx1CD9EWHcrwBjx5+dSdhj03LR4u8V8/5ZzKoo6hi
         3VxOzlF1LZLpSMQ1hvnu99MPiwRM26L8ssMQ97+t151lWzhUoXmB1VnhgPWePhtuVKfR
         TD8zKe36ObMqIfeQWOZxCVsO5PkKwcSYw2pjVtQ27Fq7OjZgqX8ap35qQh+l3ZlFlJyC
         NIGA==
X-Gm-Message-State: AOJu0Yz3Bzc/gTlBMkUgWM03idGVXRMt7baulou60RY2KyXA//vFuO9J
	GqYrVgfU+kb5MGFGS7kAEDtFWgOH0tJEcIa/fvRRKQZcvwvbLt2yeCODQuyRi7NkEjWfO6cQaSI
	73xgUkBiOf92ceE3egVSFoW9en9RsTc+7KVdjI43igoQ3mBgEpVQAqY1agFTsrg5D0THnrnRXSS
	O5Fg==
X-Gm-Gg: AfdE7cnU73v0KStN4bBiE4NeesqfD2vpNDZ86gEOvCctg1QVoZJn/HNtj+tzqmNSlbm
	nhnxdTgnvdz+/48hQQcc5OK3pahXNIUXsvyXGbdID4zFaU3ttG5sSOl/wy8DM5wGXrvCQHCDKZi
	T172fuVcMQBWGaTHP30h/jW5Zw6cQ58tWXgTkinCqgttaWo5IBNMYbJH4Xnc1VNmWj3/V9uqQ+t
	U/gR3U6PYwhremMlr0rfPrPOI/Q5XDKnmiqcGVd8/kwo4rlvVsdBnGdHKuJKlju2wNlOr9VuSun
	iQspFz3b4pb0bCNBzfXZ/9ykjDARCy1lSmcsxMpSd1YO/dgL4tKahw90eTtfBHxN7ktPpPDWLh1
	xWnbZQaH03R/7c9fhWms8dbYVXnxXp0+OEdW53NYmYxpa058OEzo4DFsmcKMT40h9QA==
X-Received: by 2002:a05:620a:1b92:b0:92e:675e:8ef0 with SMTP id af79cd13be357-92ef2e26870mr1282272785a.68.1784052478113;
        Tue, 14 Jul 2026 11:07:58 -0700 (PDT)
X-Received: by 2002:a05:620a:1b92:b0:92e:675e:8ef0 with SMTP id af79cd13be357-92ef2e26870mr1282269785a.68.1784052477648;
        Tue, 14 Jul 2026 11:07:57 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930759c63fbsm465448885a.22.2026.07.14.11.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:07:56 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <20260701041611.3077185-1-aaradhana.sahu@oss.qualcomm.com>
References: <20260701041611.3077185-1-aaradhana.sahu@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v4] wifi: ath12k: add QMI capability
 negotiation for dynamic memory mode
Message-Id: <178405247522.4102418.17700867963490080440.b4-ty@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 11:07:55 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE4NyBTYWx0ZWRfX8KRxPs4C9MtJ
 skKzwr2xWZiFgabx9czSfpkV+11KSK1P7etxmV3PXmFeQOzMAL2IN28sQka6GTKhwG/6w1QWSqm
 XeUsXHUO6ih9XS+OHnKzqqveZdNFn7g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE4NyBTYWx0ZWRfXyXUn7uFQ6eSb
 QrIoAO7CoLWcv9xJzPbz/+g8ahh3CuxSDWkXbNkK7SwrYUpVsrXKpE2Ep7Q9NbamJKwNTsd5wdu
 jqCza4nWL+cs793QnwCyihojtLNZZvN7qUclUcMGkW789oaDFubq2EWTmEf6uhhKud+GoKFvv9s
 gnxdxJaOFV6CKCMMbWZbdxzAMgpvw4aOyXs41R9ljkB0c4do67+Ongm7zCIMeyI0GKXADKuaNJf
 J0QX2iH+jil+q4ES+uzh0iLabOLU3WegeZB4Ig8jlmiBVG7BtPkOpuDnYgn0BPXFIyZCxMFGTyl
 lClgQ8HSid2hFCYpyWld5OrqYRLba6ZCrPYcoVOZHIF4ZKJkBHubrmHPII+4vcd64TbyXp2cQhY
 nunT3+6sDUBpymG89lMzI1+AovVPhdHIpTRmITyh39dz991kjt9ahEr/VKqYlzLmGa9EGIriFpt
 /roEx0EgGxO3qJbbx2Q==
X-Proofpoint-ORIG-GUID: a0ACjLYh9TTpeVLZOHxgqGrgd200yw2z
X-Authority-Analysis: v=2.4 cv=NfPWEWD4 c=1 sm=1 tr=0 ts=6a567afe cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=CcOsbiKdpNObZueyBOcA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: a0ACjLYh9TTpeVLZOHxgqGrgd200yw2z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140187
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-39104-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:aaradhana.sahu@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:rameshkumar.sundaram@oss.qualcomm.com,m:baochen.qiang@oss.qualcomm.com,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 319D1757BEA


On Wed, 01 Jul 2026 09:46:11 +0530, Aaradhana Sahu wrote:
> On AHB platforms, firmware operates in two modes: fixed-memory mode where
> firmware uses hardcoded addresses for memory regions such as BDF and does
> not request HOST_DDR memory from the host, and dynamic-memory mode where
> firmware expects the host to provide memory addresses including HOST_DDR
> after the Q6 read-only region and relies on host allocation for all memory
> types.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: add QMI capability negotiation for dynamic memory mode
      commit: b93c1dc446847165fd4cafc3d4d1c67ee6c6e987

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


