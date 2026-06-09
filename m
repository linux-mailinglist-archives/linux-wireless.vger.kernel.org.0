Return-Path: <linux-wireless+bounces-37588-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rYAYEdocKGrG+AIAu9opvQ
	(envelope-from <linux-wireless+bounces-37588-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 16:02:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C554E660CF4
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 16:02:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=l4hpcenH;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=E44DKQyk;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37588-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37588-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDF743091C4A
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 13:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DB2419306;
	Tue,  9 Jun 2026 13:55:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4872B4183DB
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jun 2026 13:55:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781013314; cv=none; b=Sxp/pTjDXM8CZ/JFS+8BM/aiNlA9sVRJZmTuQLSfvvpx++CbDfh8V0z5BCoVtB6l8hoeG7IoF31LR9A6JSpnvdyXrlx4MizWMiOhVDI6+vICXvoQ+/jJcGsO8Comc+2+E4cgIekF5X/QsBSrNLd+vDaSYh7PYjBzX+q0nCE5URE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781013314; c=relaxed/simple;
	bh=bGbPk90ZnW2tEzy1i+Dp7UI3ZZpmcNPFP+iQdml0RCE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=APWpQcAmbaksA09QLmXkJprcAfUVxGom6N7bNQbrgJQ0b1j/iDTNcKE2j7SgDo7Ww/oqy82ZFhzFfd4QHHJjTP/jK9dCPywSw776fpfCNFLA0FlW4Z3fDlxmkVccxt0wPf0MW9zGH0p6+VASlGIfFpcrWVKIkw8rKkW/ryizdZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l4hpcenH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E44DKQyk; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659ClZ1x2706236
	for <linux-wireless@vger.kernel.org>; Tue, 9 Jun 2026 13:55:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fNp9PgYvqtqRrJpy8tj4U4zpVli5lKE3Guj8hmd5vK4=; b=l4hpcenHn3dL1Mt/
	8+d7X+e83Qx2oQuc8st4gyGIzUWyl+13h4ehvpamQNf24jdVck63BejnvNFjF2NL
	YZLPf6+S9+DvHbHnr/urqx7L0Yu59mnM/srsHaAqriZZ3fmoQ1x/TOaTZV5cnz/l
	OchLWdTss1mLppH6koHdtR8DeObfMhofFgUnjmrvgnKmn+AFsp0Q/w9KoYfVMgne
	PPoCdAuiY529P4CdHOTrNTOC/It1GRIWdkMdk84MpzulFQm3Jqn40VIsPYAWgWO6
	gtfYpQ03I8dTTi31VmEtI9vTyLQ1d+DDYi+uu+b7WjJtXR+ZVzVZlnuiVEnGNY8S
	1pgg3g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epfdt1dvp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 13:55:12 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-304f1820babso6901940eec.1
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 06:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781013311; x=1781618111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNp9PgYvqtqRrJpy8tj4U4zpVli5lKE3Guj8hmd5vK4=;
        b=E44DKQykjKvKLBwXa/d6MGMpHvVbUu05XfcQ+NFI9lSyGkBbXPKTtRNXiVztGfLqpv
         GrsXQ21Be/u2iKmhm2FQuWqCL1albrAaNV6Z2kTwcWhZdg6/ZfyIgL1BAJAydrBHI1QO
         QURLuqCPQteBIKyTJ1MSw8Fr2+aoOZqNrJ9o5ylXtXZX9yvXV3iSLEymNJMbotxOkP0L
         NrPNkmsaWcr+5Wh6pGRobZM0jbP7xjHZTWVlSEorIgBP8qT8tGCYQQ2qn9p0gWoGWMav
         Y9rNvyeMeDCxSI+qWSXKgzg6p6uhULfn8RXCCzFVhNkL7sG8avgBF4rxmt8Ks8O9a+NW
         Ju4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781013311; x=1781618111;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fNp9PgYvqtqRrJpy8tj4U4zpVli5lKE3Guj8hmd5vK4=;
        b=a9bjzK38CmvwOf7BGRZLI59cJLtoiOmtER70SbTbRr+nPzedgiPE9t2sqgJO99ugnk
         Qjz2KNtmx93g4YXNg+G0mMcQmyyvGB5wjVHCezjEjDyRbe+hvg9oYf7VElAILe5HZqfq
         mvKut5fjDrowGWu0oQLvcGCf7ML8CZ8JDY7XDApF0lYEYZRIDrum5XjUHWxkyN+5G8h3
         EfE67lm4hSzWfN3BpqZa0HErUSMySL3AbHsOwuywNSUaYOWeJEiHxOZVClATY2Lt6y+x
         b3jKCcYU4GetZ0/guM7s7yYLAzjx161OoIxZOHCTgTa1AQjbtYc1xfexhCHsDFUqIkW3
         O7FQ==
X-Gm-Message-State: AOJu0YxhP/pN3nQNED8xny5yvpBTktg2A/ndnrukzAYQVDxJ/301l94e
	P0blfKyhBZPb4spLidvMMgtkSel9fAF/sBedKf1TxwFDsDcsLx0G/QzT5q5PiUi3rdVrq3HqvMK
	31bdj0U9OR+zBiTAUonWta6SyJgnmkXasiblVDCFmUomU6j0RRac4xanWLWZDHAf5HRvzKdbONe
	Ml5w==
X-Gm-Gg: Acq92OHmq6gIcQEM5x1VIT0eQ1sM15bEGj1jfKxJd6JtrEJ+CtPVj7hSh9UxSinjPN6
	MP5ID6n20TczhWbZOsX0GAEj2TPJ8Iey8CWydQDyhpEUkRhDKm9vneWFOoXpNO6xWkayNrKjU7Y
	l3ORJ0cKhBiOZPRHps76HjPlvIkn0L+sGB5V855xpXNgADftKuuSxW+VkJBe7qWNfRBOAN8LsWD
	RFRC35wKHmsdygf3EkevbLS/GMHaAuzcF3nycgxIGqgIJ28NcC0zjnFUH4vvcavM7qg8RtvIORH
	TSnc3bI105/B56SMDmdpXamSgfAx9wPkMOi5Ljo5X0TYgP3Gy1Bgj4ROV5U8qOZ8dwCRD6RM+4s
	n0YhcdsiKG7qi2mA6w0HLqt5AiG2FZiawHLo1oZ/nnnugX3p/ryDv51etE0yeHssxLTMAZaejR6
	7FpNI9+DBff4o=
X-Received: by 2002:a05:7022:ef18:b0:136:c443:80e5 with SMTP id a92af1059eb24-1380666051amr10703913c88.6.1781013311112;
        Tue, 09 Jun 2026 06:55:11 -0700 (PDT)
X-Received: by 2002:a05:7022:ef18:b0:136:c443:80e5 with SMTP id a92af1059eb24-1380666051amr10703880c88.6.1781013310607;
        Tue, 09 Jun 2026 06:55:10 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f54c9c12sm15289555c88.6.2026.06.09.06.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 06:55:09 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
In-Reply-To: <20260609-ath12k-fix-eapol-tcl-metadata-v1-1-d47e6f90d4ee@oss.qualcomm.com>
References: <20260609-ath12k-fix-eapol-tcl-metadata-v1-1-d47e6f90d4ee@oss.qualcomm.com>
Subject: Re: [PATCH ath-current] wifi: ath12k: fix EAPOL TX failure caused
 by stale tcl_metadata bits
Message-Id: <178101330973.3249128.16418465746928021025.b4-ty@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 06:55:09 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: h5mtH_wiqshK711cMAwcodqCppoZVueu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEzMiBTYWx0ZWRfX9uSBxHRzfZll
 RKcvpMMirVUxvIsFzC2Z2hHiFX2e3CJmYBeG+7DpRpyVN0fSGILTnWYwqClSTR+1E9+D9GGRb+C
 rpMJOL5oEjIIVPGZwylVZIwlfSZVjeYm6VeEfr8Kz/kQmseJ7Ap9cllmmgJVlwntEf83SZUWN6E
 yOreIMDgpxlC50eEnjKoiglCuW2q+UFg3Yg/IhHUxJWsVakCWjgd5NxZ6HNgaKA1/zXvd7oglK2
 KCA413saUwE01Gz5sRlpjgVzfM2N5hyDAMApmgv4fw+dLXIIgUFuzNfph8+xn7xFeic703ZPFAM
 FT/f8+6OMflw0KHmxpK5aBW0VHXUyxJt/PNdGSTByLozU0OciOoYuHzh/DF6SowrN28Gk06Bn0z
 9dSycgAqWjsm1655PQAsK7sK43I8Pd/W/zYeQXbwN/9uNxAauVk6QtqH4kcJOZtMYNL9ImFaLgV
 DYMAwKXJ4iueHc9TgvA==
X-Proofpoint-GUID: h5mtH_wiqshK711cMAwcodqCppoZVueu
X-Authority-Analysis: v=2.4 cv=doTrzVg4 c=1 sm=1 tr=0 ts=6a281b40 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=E298BOHA-sUTKqM6pTgA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090132
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
	TAGGED_FROM(0.00)[bounces-37588-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:baochen.qiang@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email];
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
X-Rspamd-Queue-Id: C554E660CF4


On Tue, 09 Jun 2026 10:10:47 +0800, Baochen Qiang wrote:
> On WCN7850, after the following sequence:
> 
>   1. load ath12k and connect to a non-MLO AP
>   2. disconnect and connect to an MLO AP
>   3. disconnect and reconnect to the non-MLO AP
> 
> the third connection always fails with a 4-Way handshake timeout. The
> supplicant transmits message 2 of 4 four times in response to AP
> retries of message 1, but the AP never sees any of them.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fix EAPOL TX failure caused by stale tcl_metadata bits
      commit: fdea4d44e4b9c3f7021c85f8cd766e84e224472d

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


