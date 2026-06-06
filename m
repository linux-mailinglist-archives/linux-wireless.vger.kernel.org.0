Return-Path: <linux-wireless+bounces-37455-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bPtcK+xCJGpj4gEAu9opvQ
	(envelope-from <linux-wireless+bounces-37455-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Jun 2026 17:55:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B19DD64DDFA
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Jun 2026 17:55:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=m5NGTruP;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=ZkPLmfMi;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37455-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37455-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7976301C683
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jun 2026 15:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48F53B47E2;
	Sat,  6 Jun 2026 15:54:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEAC3B6BF7
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jun 2026 15:54:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780761249; cv=none; b=Nw423QTYg6VBNYUSWVsPTXcWdHh/Xvffi5qdrtHq17r1g5ODF9Bmx/T5JfCx+LXp2COVyG/uVdzwB5RtnmV7yYazOSu8PtS2yxe+HFNgi2DMEKobhMUgAtB7o91tcLvum1WO57HJRj6CUCyVS9SaYwwRmDWWLQoyUtmrouTuOOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780761249; c=relaxed/simple;
	bh=Fx+A53sB6avgtAZ4VWf4CsnF720tT2FL4YsT2IZcFqU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=u/cYk7N8S1xOQisw5rydi2zL+hkLbLy+/g5Opd4BmxSTlW8fBKJkeyVpeJTNwDOr79W1MQkDJtK3XAh3hG2iqCjxf5Ge+IV/Ju/D0uBK5ubs/0ac9vw0hh7d8crfm3os6AETDlGGOiwceQZnJb5kA8pd74GeoJM7WzGaclgRFfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m5NGTruP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZkPLmfMi; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 656FA1Oj2194405
	for <linux-wireless@vger.kernel.org>; Sat, 6 Jun 2026 15:54:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wwraN8eF/L+zIHGRjDPV/c5+hf0cgwTb64mORmlZ7ws=; b=m5NGTruPDkNA29TK
	iyQ1IKB8RfwW+0YRe8CMe0jrbIRRMZQdgERPUMjwFT2Pcmr2Zs6076xjFGjqu91N
	gRLglEJsMduWO/hjpG9gbANuv7RMEEO4djgTbvNuER0/hnuFz6FnP20nrRG62cVK
	JpPas6cZvBDc9u8c/SndzAAbjY1PU6URY0+/dxTe0mT4aUqkTA2KvERzL6jfrBp+
	xz9x5sKJOZVWWtpzA6sIpRfBnyC6eYz4s8QqctCaiOvo8gVFgXwq6ynOUP6K3zfs
	ps/Eej6NN21Mg2zx8TLVUsZx6ygVY61cfcwqMrKmj4zEnUXJo6v2kVolp7dO+62b
	lsH4Cw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4em9k3j0hx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 06 Jun 2026 15:54:07 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-304dd917645so2895594eec.1
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jun 2026 08:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780761247; x=1781366047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwraN8eF/L+zIHGRjDPV/c5+hf0cgwTb64mORmlZ7ws=;
        b=ZkPLmfMiwboiNhmxvUSiD43VyIAZUg9PriD9WnWiQiJQAhSPcBCDhcmn/zSg5WU7y4
         3aG5MHU12Elrv2K46i5zu223XAAKH9A+hbHHeLDwrM+FR6kzoRs0r5MvbQs2zipQkHlP
         WD+oX4nPHYJvCRqfXw8UPx8BGtHQy4Fj+A7M3dQ+kb8wv1fbXvHjWi/qEmh3VOMNNXxG
         sCMqzP0YM3IB0ONfieA+Mjbi4CH2r1hXT0iFGKD0ZB/grAGmtg/ImitgWXxHz7dbrfa3
         5d/4YtuCY0pMd9g4f6qmnTTEBaYPc/1XOnWAs8T36eSlHI2nfJIAbkIO4X6g/A/CKZpa
         4PXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780761247; x=1781366047;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wwraN8eF/L+zIHGRjDPV/c5+hf0cgwTb64mORmlZ7ws=;
        b=HjjXjI1FgobawAV25xz0jFxfWLm57rjMr87sSsk0H1TEftqDE991vnbf6HdVTBdyRx
         D/5XusLtCOBXtqqFrH4G+A3zZTRWz/TuhRkGHfeqo5R3UJwr16v9Da414C5R+ShPAMOB
         8ULUcNbieHcraekKvcgg0r+2le0i2hhhXlr2E9Or0+xBS1/WGI3tpjnKegC3s6OFqn9l
         bagt/2u8st2Gf323nSqSIv/xCBXQA0/bH4IvAf8sBIRFrQbPcpz+cEwm7xXwM5MocdW1
         BMUySOOCzmBQK2lo+AIM+DzbNhF01iNWMimTWe6sBXT2DUDotzdQ2lpyav6aMaM/DfYA
         uDBA==
X-Gm-Message-State: AOJu0YxE2A69NU3I+zmi2YRbekRyVaCHbDna12KKbHeVe2GRJCX0YYCO
	6bdtHYB3WvQ5P76dw4hW7KtDipmW2YVHZ/wz9zvsRZ9HwXcPZO4EXmEUFgQoX/c6e7yojrGH5Qi
	f2LNHOaErcEs/zxss6QYpS4f9czauDvjFx8ZPan7RQn2P+s6ku+WLxdgMLudt1RQ6W2siKg==
X-Gm-Gg: Acq92OGuHZMrE3xWqEKco1NX4qocn71jiRn/BbtPaCAbZ/lRyXPSIWP1wwgrCu52F/c
	Oes2p8awjbMt6RxAxrvT+mWvMZ9oW+StDoUNhpELDO6Vghpn9q5QBLuysxfuTATieIOxqiXuAgZ
	yAd3qhUaPAv2QrUsMzMFzNbHxhh6EYAGtpCNDQF5x7iIGxX7g6FdYybgpn20wXwLcAAuCx3Z1aj
	deVq5NBQzcfix9co5EI94Y9qANBoTY1cZpS2YKwYuETBnvL+5zmKjMSKdHGoU880qpTBYvOSHQZ
	Kz3w0TCmvfNZt4dOcOpVB12tCBj3Re00HMBG43+FvStwcqkZTqqrMQ1tG7IdEDGsZfSMD7RXqVB
	PuF831yC4K8GEm9f5jPnfgkNd47ieMLzrazQRORPp847YEKhTDPenBMgYc0e3so7Kj+Tg9tjXrK
	Aqsj2gaZnHpko=
X-Received: by 2002:a05:7300:7fa3:b0:2ed:e12:376d with SMTP id 5a478bee46e88-3077b358a45mr5786528eec.35.1780761246739;
        Sat, 06 Jun 2026 08:54:06 -0700 (PDT)
X-Received: by 2002:a05:7300:7fa3:b0:2ed:e12:376d with SMTP id 5a478bee46e88-3077b358a45mr5786513eec.35.1780761246178;
        Sat, 06 Jun 2026 08:54:06 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df48671sm11240392eec.24.2026.06.06.08.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 08:54:05 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: linux-wireless@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260517222136.1660347-1-rosenp@gmail.com>
References: <20260517222136.1660347-1-rosenp@gmail.com>
Subject: Re: [PATCH ath-next] wifi: ath9k: remove TX99 power array zero
 init
Message-Id: <178076124495.768205.2846291342209078291.b4-ty@oss.qualcomm.com>
Date: Sat, 06 Jun 2026 08:54:04 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDE2MyBTYWx0ZWRfX7cKU5wKS0rVr
 dGzG2OD9nA9pzOPzYDL69DxTCYBGFQwHzAsUFk7tMSsZah+Ti3itDtPg0NvNxlgzsyNPrYw5vRZ
 VWBTbV3utMSr8bkxiHjvslpQfEAsM5kLy+lDOIL50J+C2gJg+7DKQHqRfdZ7z6jC4Vx77mg6+4J
 xHlYXotpmKRQXJ5NW+7T2DE7movGQw0/83+TQmhHE4SQqq0B613XL9Z8ihfkOx3m/NXkddRDlT0
 RUkQ/ajJ2NImInoi4QlfVURvtVc8cQwiwI6rsOVVTVesLB1w9QRB1Ra52vhmtmj4uMBINWUPPSC
 Kjka+AZtMT85o3OMh6QF7SnAcxntCASYTYlJ6tBukT2Bz0IKbXmXuyC4HGEzj/fa8tZ5mgI2c/b
 u/B2KYOvC39iBZW8T7IvZlbzGY2UWYPgA8/sr0kDJQgLsq2N2h6cFg7LG2ss1vP0YnnQkbM/fRH
 ymsWNpS08UPrvY07VmQ==
X-Proofpoint-ORIG-GUID: 9v3vGMLt7-guZPd_fvLFIk-06UomEpBq
X-Proofpoint-GUID: 9v3vGMLt7-guZPd_fvLFIk-06UomEpBq
X-Authority-Analysis: v=2.4 cv=TIB1jVla c=1 sm=1 tr=0 ts=6a24429f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=2antjxJqmC1r7Drk_m0A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060163
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37455-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:rosenp@gmail.com,m:toke@toke.dk,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B19DD64DDFA


On Sun, 17 May 2026 15:21:36 -0700, Rosen Penev wrote:
> This array is fully initialized in the loop itself. No need to zero
> initialize and then overwrite.
> 
> Remove static from the array. This was a holdover from when the array
> was a static global variable. It no longer confers any benefit.
> 
> Also add a min() call to avoid the manual if/ternary operation.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath9k: remove TX99 power array zero init
      commit: 13cdd324cc155200ea328257c746004d898ff3de

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


