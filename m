Return-Path: <linux-wireless+bounces-38416-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UIxEEcs1RGo+qgoAu9opvQ
	(envelope-from <linux-wireless+bounces-38416-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:31:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 949216E8276
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:31:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=YPjfad2w;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Gxr9ZWj+;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38416-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38416-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87DEB3157C30
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 21:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC23224D6;
	Tue, 30 Jun 2026 21:26:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053712F6918
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854805; cv=none; b=baAlL3BbF9kvwwsU9/o2xN6lK3xX7lP9TxEeN6YtEXIfSSuilvvrQD8MMxAl8rRDSPWWVvgMEK6liONLY7kfR57VIDVbnGLPqcGiR02yad1mIShSXffbIBw2/fMzGGgSpY3cWwmBYYYSArMm3yiLJODGSYRyPoPP8rK8/6MXfLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854805; c=relaxed/simple;
	bh=ttpjFsyVJ/rGdAkouQDsG/QygIrm2cP3CTWBjkW6dnk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rbm9E0q+ipniGANY7ch0ll0qRtPmIW+93C7lRYishc3MbgyIunl96tAqESX2ZADMkNIQW0/hh1os92BwwFYjPORWiDb5XxNGMUNs/P01qiD37BGeSO82HDlqwSAWDYzH/HW/sdJ4M0EsJO0DVQypx8DMY+UAVCtt8eYuZWJFQLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YPjfad2w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gxr9ZWj+; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJDc8Z2873527
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	33L9NYOV6pllzBF6e2bYrYWI2ExNYhnVZGJ+dAvs+s8=; b=YPjfad2wmJFKCaEu
	7YNQCeJwIrjyrmEkz2D77WNbT+pHiOIrDGzB8A18ywmE8VTwzI2+T7hiwgBZXtxI
	6n6P4S7/pf80uZYlCinlyjnxuWCgqHS4RRNWaGzl7mVxtiKL1UdKaSpS4GxwZkFK
	Y5efcHPK6NLg31sIPwezliq8ol6xO/zFKbHLoKT+b5yOfpZ9r7XAKWg8l2XRNxR+
	SfGBYqRIsD2vyaFWCViDh2dJh3uPDvq4QTYBFT4vdGkkMGgwM9J4T41rufYzydVH
	oG6NXs5GN84DLb5HX6szzsuL3LWdP/ve0firjPPldaDweAbvATwqrk09r6TS50Tk
	O8lVHA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4k3sgq01-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:43 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30e773699d6so3765064eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 14:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782854803; x=1783459603; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=33L9NYOV6pllzBF6e2bYrYWI2ExNYhnVZGJ+dAvs+s8=;
        b=Gxr9ZWj+53844gzgUN5WTbhiNWE/0Y/d/zAV0uIyCvHMaMUf8z0DZufrp2FNI7S/64
         ZyzNnPqQLBcTg2pGeUs8N+hWjIZngS/IIaIfgJEEu2RUCg1qgpk4vy15cvaBbkitTU7x
         gt06N4MmKPzN3DjUwXwd+OFA1Z/OFco/ghd8bVuQO7Xc9scIZzLupksrj6w9yj3MUVpm
         wcOx9jMC03dDUFiDaTMTumbPyi5FSR82CIdq7/wQrSA5B3WFu6z2H0TjLbVuQkBa/oDT
         3WUuwRpH1zG2BsGtvS+ahF5nebInf72oZLQc3bZvsEHMbyk9OTV2IqDD/Vgvw0WQ3AWx
         UtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782854803; x=1783459603;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=33L9NYOV6pllzBF6e2bYrYWI2ExNYhnVZGJ+dAvs+s8=;
        b=NgNVdJg/VOIifMQcb0G7B9ax9kX+iZuPJoYoYIsWdvG1uhL3yPOEMpgO3hukRl70Xt
         pZ2nfdAqPgtJV9iotqhHQrngWuQTM9jTCydb/QWfKSt9nGquGe9d4gw4nfinTEuewLLq
         80Sr4y79wG4lFEJEfxhMmhDtH3NdkSdtt/uaFB6wgSb7dmp6LO39lXtkgF1Lr18unyYm
         +ntmxg56dagTLNPTEBvSN9HOoMLjJvJIZ8fvcOwHbRqk8IH7/fTDTeFWnTp60dCePrGp
         yyawUPa3MeMvMnA2tyFn3RL46vJiszg9sxe8elzxKAVVFlD3d+Of3sqOPUpwp1NHbUYu
         fv3g==
X-Gm-Message-State: AOJu0YzxrOUi29bqlakgMkl4oZmK9r8/f/5g/uno/F2K2s1Uw62QmC8A
	4Ws/H/VOhD2XrmEcK8CKLa2f7ZVIkTo2oPS6nRaA+42dgJ+kAcOQKzdG85Ad6y9/O/y++8Vw8ai
	QdglrMl9LnjbE9if8H1mqLxsC+Pfv18ch6jwZkDpx3364ui8FdDe97lb2PCrvsVOmStKTuGixfk
	EsDA==
X-Gm-Gg: AfdE7cnjdrdF8MaoLb3sJXA1AnrBZWVMWTanAU9C3hl06zLSbSYWgoLm/dIRu1YCZ0Z
	/VPfiizEVMlm8nfBWOYj3BsOgHehMvT80BMLs/SkcWxJ7r4KANTwlUc/McCelIesAXr0aMVr+jQ
	MOyomxCySYiwSFJBmpwKTma8eHtQ9k3Ub/LbsE9FdqAYpBJsTl+1fsI2tTtia62AYDZA1siY+0M
	wgDWPLmZdgY2Mw2Q6CEuo2OSIEQ39pV5wIY7aK9JQ+DQ6XrHrvQ1K9+MeBr/AmxQsNuMypFcoe+
	BLxP9Bw3PxviZOih4UBJHbJ/YzsPJuc4q3yMXP+aCr3Gb1FFB28puIz0ND7z+7isKgxgK0O4WZv
	bpWRQELBQcLjJh8ro80YrTIXdXlidRspYidTun1+n+Hem8nIgogv4hIVkViFghoqVkw==
X-Received: by 2002:a05:7300:1898:b0:30c:ab4d:3826 with SMTP id 5a478bee46e88-30ee150fb37mr4156684eec.40.1782854802638;
        Tue, 30 Jun 2026 14:26:42 -0700 (PDT)
X-Received: by 2002:a05:7300:1898:b0:30c:ab4d:3826 with SMTP id 5a478bee46e88-30ee150fb37mr4156655eec.40.1782854802146;
        Tue, 30 Jun 2026 14:26:42 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee300b286sm11604046eec.12.2026.06.30.14.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 14:26:37 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Sushant Butta <sushant.butta@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260609064856.547032-1-sushant.butta@oss.qualcomm.com>
References: <20260609064856.547032-1-sushant.butta@oss.qualcomm.com>
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: correct monitor-mode RX
 metadata handling
Message-Id: <178285479779.1590147.10839171330562309613.b4-ty@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:26:37 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: Em4jmBjaUtDyeq4zrcRRWQjAuIj5RiQf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIwOCBTYWx0ZWRfXyp3IvaY4MFUE
 a1qpSGNeGR4W5pu+sLR2FsrAs7Z81jQ/OTwwZErZ12cS+ODapaSkclrLQmwfgfTWFugq1CAXn5m
 JCa316dfDx0ZGNgGgoqdPsP8OjR36O2+ed/RhL+zzMNcfDpoaEzFYSF0qsLlTQagF9GFTEwpckq
 AHqXEFuAWrCbw7OMJvb0VoVwfWV7xVb4c4rh110cFnjGShGjdw2AnGYA5sYOBYGyXFdEZ9gn3J0
 upKFhofHR674WKkJyqfp0WSZAViQ4v4y9ib0d9fc/qABeADB4n/HOiH/Pk4XE9oKlMnOZwfFYIH
 sf64EC5GCR3gJaO3EGdKC88JI0DWPj8gNoFsuE5LHpUZUQIa6CDwzfVMh453scqdLQzTZjaNfLz
 IkmeThcQ16XjkKZuciCvTkT5jpa0x4BiNx+SKc3pqI8VmPqf/SBhqp7uQyraPJCiAyctQbBJfDv
 T6OPzlmSz4wItFh3ksQ==
X-Proofpoint-ORIG-GUID: Em4jmBjaUtDyeq4zrcRRWQjAuIj5RiQf
X-Authority-Analysis: v=2.4 cv=Ff4HAp+6 c=1 sm=1 tr=0 ts=6a443493 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=k0c8v7JCAQ1gsNTydDoA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIwOCBTYWx0ZWRfX0zxX8B5SnIaC
 pmIhuPs3qILvmt/uTR1RqgYS50PYsJkQctgLwF5/D19tzIHY7npr7MNgvkFO6L+sB0IuCFMjBls
 4s2P72W2Na941n2YUWW3uvDfZaiQVhM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300208
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38416-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:sushant.butta@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp];
	TO_DN_SOME(0.00)[];
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
X-Rspamd-Queue-Id: 949216E8276


On Tue, 09 Jun 2026 12:18:54 +0530, Sushant Butta wrote:
> This series fixes monitor-mode meta data handling in ath12k and trims dead code:
> 
> Monitor mode delivers raw 802.11 frames should not set RX_FLAG_8023 flag,
> and populate peer/link metadata in ieee80211_rx_status for monitor MSDUs.
> 
> Sushant Butta (2):
>   wifi: ath12k: Skip setting RX_FLAG_8023 for Ethernet-II (DIX) frames
>     in monitor mode
>   wifi: ath12k: Skip peer link info update in rx_status for monitor
>     MSDUs
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: Skip setting RX_FLAG_8023 for Ethernet-II (DIX) frames in monitor mode
      commit: 5a2b5d6a5a4a19b86d1c0698a3eb3d21f0b06401
[2/2] wifi: ath12k: Skip peer link info update in rx_status for monitor MSDUs
      commit: 56f8f12c1a3c5312de0d7312b229d7bca03dbb81

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


