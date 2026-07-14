Return-Path: <linux-wireless+bounces-39103-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /j15L297Vmqs6wAAu9opvQ
	(envelope-from <linux-wireless+bounces-39103-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 20:09:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28066757BE5
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 20:09:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=QKMbdXmB;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=FTqgfuYl;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39103-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39103-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D3B0315BA32
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 18:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0674C3CBE6D;
	Tue, 14 Jul 2026 18:08:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6003F9F41
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:07:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052480; cv=none; b=WIhgO8kHHu7dXP+DhATjMk0OfedtlDvSJVbAJxmG0icNcNWycZl6Nij7m9Q7PfgeuKh+1zyHIVwaSyvujqY85jzvD1Bo7825YcMNRtQZrBPJ675Q8XUy/MxgK2Tu8AHt6Qb1EtDTI74IgGxkxkeiLo92+n9VBBULBFFHD3COmgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052480; c=relaxed/simple;
	bh=vAvQ19NryTtuhufr3k6FiVI8DxVqGiZyDtV1kSPmFZY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lwJ7t7wWoA9tyRf0dznnUBIop7APAxLxBtm07JYagCo5yMdRZEBmgaQQOCHG2Hhcsf37DaheufQUWGBZru+svztn+nckTriLH7lV8G1R4SbEh231iwrRgfrNztdYrNgCnEEritK55UKtwLKWoOBYI1NkDTl/Nbg8fWyS53gQKbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QKMbdXmB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FTqgfuYl; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EG6wLU975578
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o5rGi/DdviKjAvU7tgHrvc/byDs8bfgUehxEkcVWHEU=; b=QKMbdXmBND2UqqkU
	2mg2qFon7SZdnXUT7PYjvnz54PaF2cvE1tmV82DT7Mfm0wiOKOaH+8W7fd4LwgXP
	FKo6U3WLV8xyIJgkFwiT5cRgePHSR3Z6LvH459MdQpmUF9GgD9tdoiL0IULTx+hf
	FgG1XT8pzmlaaOXdHJiJlff3UvsNbnDNAaTv9OsAMcDP2G46nfOnmBI6n7wpOzlS
	IC+VKi1Z8HxdNqBLqVu0fTuhfemPiseCGGuVpFVzV55L3J/GOk+pKEXIAXUZqW9c
	2nOz5B1mi03fh7R9NahTBldDRWVKjqHeBmfOZCwGOXnNzywe00RI+F1BckpyBkJJ
	D79JvQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdgeq2k92-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:07:56 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e55f0613cso530110585a.3
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 11:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784052475; x=1784657275; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o5rGi/DdviKjAvU7tgHrvc/byDs8bfgUehxEkcVWHEU=;
        b=FTqgfuYlrufseL5mrBQdMviUFJrzfmGIFmT2GQ2oe5TY10h34RmVusqv81H1TdgokH
         Tjl2IV8c2/thfFl8xtPw1UZrl6KheqYPRFEvSKdGh9pib32DcW2bJVd1tTf2FcT8MPJG
         M6XFipm8wLFAkQ0i8ymZUICHaPkIcP4hTGe5abxwrI+aVydRXeR3NJukpHgZqfbn1APk
         xGfPJ7vPe8xo11TIlZ+pCQjFyZ9dWxwf608gwwySZBEW6HEGj+ej2LtMcp+tqHwNS0rt
         yzgMaXCzdv+N84NI2xkJP+BbtQYkHkxE41Y9J15Y9gT70kLE6XHAZaIbnN6CjBjIXdSu
         IIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784052475; x=1784657275;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o5rGi/DdviKjAvU7tgHrvc/byDs8bfgUehxEkcVWHEU=;
        b=opqFWRfGmjh+j6lIXrQlITeEJgiwcDMKz2mksPaaWYZMSo3QsM61m/lK7yidDQY0yy
         5uTk7LkrjArecs2WU2wU4rTfI2YjO+HJBIPFOSDtmoVQ3CS+LthR0Pzga1+2IrKftFKF
         2sFkaCZVmp/dX+VYQfgyBIot6kmfCyCqQvFP6Rn9mbPxtLajQQcVLUUtDd/HBbzy0HaQ
         xT0xhE8Th9vsd72XWisCLa2xGfbOOwPAbk8g4+ES1yzPgfXMXecCCDVgFhJH2eQrPp8a
         r7dioudo53VLyw6Bw9vNWUOYcRpZcdaG9eLcaehBybye5Eo6pdjNcBWeeIxuioG2pPIJ
         1OmA==
X-Forwarded-Encrypted: i=1; AHgh+Rq4vK5RGK06IIMNCrMihn6cfZnfToqlckRmYpXY25g/GSD7l3BaKnwwDKLX12OXXF2eMLMPS0f3YeQif+yy8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKWceFo+ftFELrwDTyHgeI4bXIELWHWZon2E+Xho5eX5EWE+8z
	boY+cOjGhFw1WeybMs2psysYZAY5QZLLAc5kfKQG8ty/cbXUxM4biAr95JaABz+r9L/86LO5Scv
	58XyTCBf6zGShErPosf5n7WNPO3ku/WIBlJUgor1TxxF8k9J6dGjCpY5S5sJqzRN4DKEQP2Fa3Q
	lGyQ==
X-Gm-Gg: AfdE7cmMn8w4q67mXIo43Vc2ZMmJzTqZVt2sYhDiS+TarAXmeN0gxXgNWS2862HRE93
	5EVtBIc3xHactW7VG2PGu+BGCR0wJGC7iXA1m83MUtipvhXepAaJH/YQt0vJL9KYA5/QdxzShrZ
	dDZiNIWAgx8Zzyh4jrF9tMgM7cX4QVGl7jKoNChcLNBWNI3vKGN61VECL1yn2dNo9npweb1vQZy
	EDbYO0uuYIWtjPW40r7E/BcI1WmzBNdv6uP8Jyz3tfe3B29SNe4O8wd/8cRjUJRQlabrMXm+s3V
	VVJYpu4EjpeiIwPcbHCtgvKk3vMSUxDcj4f3Z4PXjtrd24g5lD45Rctu112SgXcY2f2KfND92L+
	EQsfTty12Z6/4MGmaUlZxtCfHoOtwJWNO7ljhnCUf17d0dUSuqGFJCCnDnc/FVHJ4PQ==
X-Received: by 2002:a05:620a:170d:b0:92e:6fb0:e79a with SMTP id af79cd13be357-9308683bd50mr330621085a.2.1784052475529;
        Tue, 14 Jul 2026 11:07:55 -0700 (PDT)
X-Received: by 2002:a05:620a:170d:b0:92e:6fb0:e79a with SMTP id af79cd13be357-9308683bd50mr330617085a.2.1784052475004;
        Tue, 14 Jul 2026 11:07:55 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930759c63fbsm465448885a.22.2026.07.14.11.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:07:54 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Wei Zhang <wei.zhang@oss.qualcomm.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260629061529.1993932-1-wei.zhang@oss.qualcomm.com>
References: <20260629061529.1993932-1-wei.zhang@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: fix rx_mpdu_start layout for
 QCC2072
Message-Id: <178405247365.4102418.16075223393291078104.b4-ty@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 11:07:53 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE4NyBTYWx0ZWRfX12IbRDoLttjW
 xXpKYlfFjce3hgaGYxKgPbEL7YGKIzp8NQGxYgFy04S6xYZO7qlhYpWWSy8cFKS2cAwukYhG6oa
 TcmDSknA3QmgbNcGo+RyPz9Ch4bx/FRMYRxyGG/xUfE5O6H+Q0C9z0mp/9JgjWCOlAIPsq1OnMJ
 RCzSgD3C7vWOZ5YBQUY8qy6NRJxe39lgqCxM+VZUUwzJI1w+Dm2h5wUdhZJUPXUar3DAXZNyybf
 ELaI9TIsXpQ6W1eP1tX29NAlf1VtzHJFeJjhsGHQa8tQCLmcdGZeCTVh2XgidAXWgyeVR7xhwz+
 zJ/4B0cA9+ijTRoWFed0C72QHYiAbHRxx1wXfq0IMINr3UT893pHHqXnIxYp0L0mFp/qYzkQhhS
 HyQ1QwV/zT8EnF3B7IjQucfhP2n3UR4ObGzEMGqu3J9c/YtC2Ie4xtvV2e8njKfMMbiFCAGHSUV
 TDzyEsTI+rgMWAjOUeA==
X-Proofpoint-GUID: YAjkmreQqO6taHLOtmEZn6ksTrdh7hNW
X-Proofpoint-ORIG-GUID: YAjkmreQqO6taHLOtmEZn6ksTrdh7hNW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE4NyBTYWx0ZWRfXwPDDIEh1l/LB
 uFW0lm3ayl57QYagj1nMXupLH/T4Z134zMTLz0WmnFMahSrA/dY41CZ7TWBEUE2aNKUQ0cysnNP
 EI9ekeIf6Ak1N5zTJlYGl5FJeb5g/eM=
X-Authority-Analysis: v=2.4 cv=V9VNF+ni c=1 sm=1 tr=0 ts=6a567afc cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=WD2RVSGR4ZOmZR8fVjQA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-39103-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:wei.zhang@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
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
X-Rspamd-Queue-Id: 28066757BE5


On Sun, 28 Jun 2026 23:15:28 -0700, Wei Zhang wrote:
> QCC2072's rx_mpdu_start TLV has a different field layout from QCN9274.
> Reusing struct rx_mpdu_start_qcn9274 in hal_rx_desc_qcc2072 causes the
> RX datapath to read the wrong offsets for info2, info4, pn[] and
> phy_ppdu_id, producing corrupted sequence number, PN, ppdu_id and
> mpdu-info flags (encrypted, fragment, addr2/addr4 valid).
> 
> Add a dedicated struct rx_mpdu_start_qcc2072 that matches the actual
> hardware descriptor layout, and use it in hal_rx_desc_qcc2072.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fix rx_mpdu_start layout for QCC2072
      commit: 9eb29fd47595e8128775f8ac57ca671238cb798a

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


