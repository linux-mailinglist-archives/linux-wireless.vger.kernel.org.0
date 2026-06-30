Return-Path: <linux-wireless+bounces-38410-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uN92OaM1RGo8qgoAu9opvQ
	(envelope-from <linux-wireless+bounces-38410-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:31:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 495D56E826D
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:31:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=YpqEcNa9;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=bIB6vxVT;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38410-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38410-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0B843136CB2
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 21:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BA625B0B7;
	Tue, 30 Jun 2026 21:26:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165A031AA87
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854791; cv=none; b=ST8FSF8x7KI5dkKw691ETq+PcUbojaZ3YaBUt2dtJ/NIfRlfJC815Vba6dKfpCUK7WIuocrs6+xbyEK0+vlwNkjPuOCREm35S2tdlWpSZaIuPXWqRLIKzS393paNBOiRyONvS+xckQAahhtNF2Qvwt1uYIcOuanXAt4I9rN0bk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854791; c=relaxed/simple;
	bh=0Sn7ZHVbg/viY8GY0j91btTXAEFRBUwW8wD4TMGcQbI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tKrEvcju1geRQn3i1zDelbnuiHie9jqHGSGTyJWmhZR2mT/WcE/9i5qP05/Zj4j8nwc3D4wYRNbZHjudmW0i7VdxocMFlxpEc8XuYZPJkQInKf1HmEbdddUvmavdn25GGRHbOVQ1qIEMEHS18PqBmd6e490k9FXTaz8QNuxym3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YpqEcNa9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bIB6vxVT; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJDXHZ2948414
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tW4zQR+2Ehtjc5CScWNshZs8opJhgZensbpccJj6Wl8=; b=YpqEcNa90YsfmZVj
	GhX8n2icSIBti5b0v1ETQKTIIIX6zTpmSA+VQGzR6+k8IxR0ntHNmifMOz+OEcjf
	9BLwrBKmrbXA49IcAXh+9JwBdReXGJtlzw+virVPkSQlXIpbwdbisGpbONA/HN/1
	w31MQEvO5gfRjDNn4f03igJYo0FMnDX5wwZbmG+vuE0dIxfDQySxA2DN+HitWmMb
	TzYlDEXVQnm8Q7Y7j0i8nyHXfVpr6nSckT2w0YYV0KYvn1QFjyjSN++QK50/hfuK
	sdfh0Utxv0fes66HGqItnrvuA0Ck5ylOqPA4D7/x/zAQVmQjh7CYsd19n3J6pfnC
	vQpA3g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4kgw0k0a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:28 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30eefcf4a1fso1009598eec.1
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 14:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782854788; x=1783459588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tW4zQR+2Ehtjc5CScWNshZs8opJhgZensbpccJj6Wl8=;
        b=bIB6vxVThfiIvnAzj9ygi9iz/LBIZua6fNUo7UAgQmVD0bcECAUTe5yeY+ddgrNk/C
         r7SGgAjqrcDuPKQxMJIV0BCFtgyUjRf8LPOGs/NwxPdoNrBwzAB/jElT1zXkOxK41WAd
         o47c/SIQCHMYwa/63gQ4gijjZdbzVgMauYZkcI1IXD67wPHdR+q4ZjruUBRPL0K1cEAj
         P4anTC28vlr/9P/TCPo66fBth14923w0wBxpvI8K91On5aX3S1SZf13ITYKnAiDpyn4v
         hZi3qM+qs1EcNpfynzCkwHY+zbYM9rtDA3/i7kUelmbR9e4RcfMVTLO7A4+/BchsisXT
         nTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782854788; x=1783459588;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tW4zQR+2Ehtjc5CScWNshZs8opJhgZensbpccJj6Wl8=;
        b=RjH1RmLJdnulXiP5MY/d+C2DCZTAGevoOonQNaSBlVUNysdXddThQPtJEQrps02Lua
         oH/aLvbyo33i4sex6bEc0q1ZcpBna6weu4wRZWpRhhdeQDdSbxfGZcbrXgSZdGW6/TX+
         HBzIi37p0+sCm+HfPWPWeXqu4RZnbiA1+ggNyJGWa6k6qpd3atxZ2gMsFTn2cngEykv/
         qZ7tT/Cz5gDP1PBq/HCvmiNeOkBdKDqdIIs1XKmQ+d4NJlDRKcayFO4fSYJQiotoKrcH
         87GOJk6XV3azzq5arustvgzZmY0XL5hc3t+eIEc8MHqpIGsTv6Z12kmxYGtLqPebeJDZ
         4KSA==
X-Forwarded-Encrypted: i=1; AHgh+RpK1QtCgoE8K65t/XFaqKjtsgpY58TQ5Dqr9PWLYpbl8LMTxyl799yR1yNTHpO+oVKF9+NVgZzKiQq7QR38oA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyM4Cw6IWmK8OdfWgmgyljAQt3lBtcgErEXwiKXGmNVBzvNjw6H
	htfMyvYQ6K52DwoSyzTLjGMaw3yP/xeKAVJBhk3GkI3iWtXzAWc7YVykos+ZZJZtlpFmkrEE8Az
	dKs7YitogjJiY9OYR6gpUlQS56UDuEINovZjVBaIcqjOVwX/Kc91r8NfteVktzaQVnRW1yhrnqn
	bm+Q==
X-Gm-Gg: AfdE7cmhryuARa9+W1NdXw8tHH31MhipEhdVO0QKxQyeuPXu853PEXvKjfzJA6ThcX3
	eqYlbXWW6Vne+pCBgwP2n8fCr/jz4rxIa9oxuxpyEE1WP4LQJ21DxWmb7WhKGfeqdBiJdy1Ken/
	sR0xp2JOABgxoBv7YvTWRVVXTWDFyBU2s9kLJ9ifuudonnSn0ZnkMO4fN7LfHxVavl3QzYTgNBk
	vNy3wFtAtHOX5tVIK4fX7/Uyu86B0O6oLZnV4HdPhn6++gYWPXUSptVBYtVtEnjqQjPipg1siQq
	9Y4kQRBAhWE0Ce/FhMS3T2yde92Id9MJOMO9rUqkeWJ7qUmG+ehiGs8Xwt0k+oAJ87aZ6WCixq9
	PDFF7SZDsSGSQRNIC59BMVQiGKELxgpcUyZ6nxt4tHhNGbi8ZENi8IdJcg/s8LVId6w==
X-Received: by 2002:a05:7301:9e43:b0:30c:b149:233b with SMTP id 5a478bee46e88-30ee134cb5amr4459316eec.20.1782854788116;
        Tue, 30 Jun 2026 14:26:28 -0700 (PDT)
X-Received: by 2002:a05:7301:9e43:b0:30c:b149:233b with SMTP id 5a478bee46e88-30ee134cb5amr4459298eec.20.1782854787613;
        Tue, 30 Jun 2026 14:26:27 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee300b286sm11604046eec.12.2026.06.30.14.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 14:26:26 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: jjohnson@kernel.org, Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260509025819.1641630-1-miaoqing.pan@oss.qualcomm.com>
References: <20260509025819.1641630-1-miaoqing.pan@oss.qualcomm.com>
Subject: Re: [PATCH ath-next 0/5] wifi: ath12k: fix dp_mon RX parsing for
 32-bit TLV
Message-Id: <178285478616.1590147.14797121014258214796.b4-ty@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:26:26 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=Co2PtH4D c=1 sm=1 tr=0 ts=6a443484 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=F1YDBqfJIRUrzdMvX-kA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: 3UB6BA52mjNvJQX39dyTzx5riI7sQMwK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIwOCBTYWx0ZWRfXzx3pw7rBfN++
 J6G6KLx48IbeZWWBH/zSti8rx9/GegmF8kXn7UiePJNjGZtzOtg9K6I+Ayy2YnQW3wSogWxMDwJ
 sKMzEK4SwFyt0U+fQA+WUlhFFdMoQyE=
X-Proofpoint-GUID: 3UB6BA52mjNvJQX39dyTzx5riI7sQMwK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIwOCBTYWx0ZWRfXzbG3VxXdrMKU
 3RDh+GrF5WIqCU9vp4OT6T7cWDfOZa57zT3XvkVwW73RhwyVGlZN2hwnPBCn1L3z1nYP7s+rhas
 tgFHPYMPATKF38WXDULoPGzUmgDMcno+nH+Vk91CnM4zYuFwD6tvO4EArCrSaDxH/lKDlvpleob
 EIf70fIh67PfWx8vSCirdfp83JJ2Gv2/puPSfhKS4bleAs63MQEcUSb2sx6A5S3DzoQM2GqIIpw
 kW4wVNWa3INpnxLaCIREDalJDgs2GHPKLfYMd5W+r5T1jBIbeVXDVdhf5GYR1v4jlgq0Mel5DAJ
 XlLH/Xd090rY1siH/vVxQwDq0eHFugueAWAunaYg+Kk1tD8t8wAfo82mca2xDbOOgMlbJf8WsZb
 wwXVkamweiyeAw99ZO12gYrEFvq0l+9XlA7C0ZCY5yegcUMztn9wC0eo2y3qTSeS05V8qnSJYfv
 LmmCPoZVeIdxuBUYCxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300208
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38410-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:miaoqing.pan@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 495D56E826D


On Sat, 09 May 2026 10:58:14 +0800, Miaoqing Pan wrote:
> This series fixes RX monitor status parsing issues on platforms using
> 32-bit TLV headers (e.g. QCC2072), and tightens TLV decoding robustness
> in ath12k datapath monitor handling.
> 
> 

Applied, thanks!

[1/5] wifi: ath12k: fix TLV32 length mask
      commit: d762bbc08ca70a1985c9f9420c4bf67e0ba0e9be
[2/5] wifi: ath12k: refactor HAL TLV32/64 decode helpers
      commit: e264a3dbe866870ed21ef83c67ad956a45391859
[3/5] wifi: ath12k: add HAL ops for monitor TLV header decode and alignment
      commit: 9d1d61121b05c0a854e6da227e37b99b3740dae9
[4/5] wifi: ath12k: add dp_mon support 32-bit TLV headers
      commit: 4c09bbf0c1e11bae19a0643bd9824d4f05d9c281
[5/5] wifi: ath12k: tighten RX monitor TLV bounds check
      commit: fffa54aeaeb2e9ac923254b39e89bf07799615aa

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


