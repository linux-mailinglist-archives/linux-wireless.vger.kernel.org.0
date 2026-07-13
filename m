Return-Path: <linux-wireless+bounces-38976-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Vv/DCgXzVGpXhwAAu9opvQ
	(envelope-from <linux-wireless+bounces-38976-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 16:15:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D0D74C3DC
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 16:15:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=BtIqr6ue;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=UtzKIENI;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38976-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38976-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 051C83045807
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 14:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37131235358;
	Mon, 13 Jul 2026 14:05:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F9343900F
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 14:05:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951553; cv=none; b=Y49NoXe0ya6/W520zbko2PMqi7fFNKJZ23NqP81KlDdrbRymodsCLjYO8nf5QvGadfiKV+4RBkBkNFJOoT1NoDONTomVdMVkfqZANfSK6+SBf9F+oMRsWHkgMlB+48kkcG3UIq40NSXfxNyMVLo7d+kWA51XfcOK9LDjC+C9K4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951553; c=relaxed/simple;
	bh=/EO2vDPaRxja75Udsk65s0EzpjOnz3w46NBbh6z48LA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eo4GndP8jhGaq3utFxAtNxgfM9pQ6jA0TB6Om0o+ltKOheo6SgcHVAaceRVQVNdig2NbOx3cU/eIJJLmePyxbi3uzpfVGUv8DXFE0x5Mz4YYDGbL33SC9UbwZds7agorJohzRIBRxgweBiNsd3LXXuNuDYcPsYBfjcN6GoJqCcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BtIqr6ue; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UtzKIENI; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCE3Jv1561407
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 14:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y7J4oATUdhmwY0ymgeqhF4QmNlI0NGtE4x+xMlfu2dY=; b=BtIqr6ueWpZQgJD1
	kQsLtZRLNgRfCkFah0UekKd4VhcntQFVzqqjAcbikayKIFdzGYAzhmBHNQu/kUnS
	WkF8aAgWYXQmPCBVDpMy5YDJMWqAniax/oV2i074CUU6JJYovsLPMQBmmQwx7jJB
	qDtofut5F7zN55hNYOBwV7Io2OWLVmmWT5zFveTdZsW4aRE59rtLi/EMwFJeKmbd
	vK2bPJsVeRCTCcPB6K3sPpLmlsdMMihZp9IGpvfMZlFmGWcY4xwkbvaPXpS86CDN
	dRE/HYD35fe+N6s0Ro+RaG+FOMqFvdJsIEVdLzaVUlclgEwKwGLJh+iPH4xaII0S
	MxAN9w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcjn3av0e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 14:05:51 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-380a638fb5bso3753376a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783951550; x=1784556350; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y7J4oATUdhmwY0ymgeqhF4QmNlI0NGtE4x+xMlfu2dY=;
        b=UtzKIENIw2DaSWoqueaGsl1giLrYbgWNLyh3VYWF0Fg4qN5RE6iFXVsl8WgPI7iwUr
         aheJbGR4dyI1upcbqFXrv4yc/N2U3slHQo9n7H0wkvy5ET+sGqZZIXpuXP/Vij0FcAK7
         tsYSt/mMZXyIShxMkFGkhTNjylsniO3JHFV/zo2jMx5rAzoEvuGLIjjGXtlMRlzpvvqd
         975Tr8xpbBsQ6SxgL9fwLepi67Ein9UkFz0Xl/Ny2kAN+AW5DiYGqlV2Djlo7QKwc+81
         +dpYUJJZMfzxscj0ESWJUxjcegD/Y4SXENzhEPfbh0KmJJ3nOv5RBzM2JlhJVVFz9iNp
         rBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783951550; x=1784556350;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y7J4oATUdhmwY0ymgeqhF4QmNlI0NGtE4x+xMlfu2dY=;
        b=K7WUvtIL77c2xlIOUamCxkFzwZ4T6xUGNTUbaqwjj+oWxUHzvkQJBEsxMlrHfc+LJ9
         X0rzvAUieTAkwPgLWaZRgb/TKocwr7mNNNgRsIkpmXwgNgRM4g+/yRvv7/cmPmb/HhV2
         wWDvJnFEYjstzYNUXcIWCeLX6LtsGgfnHi8Wgsw7QQatwCwbZjpe1jqANzGQUk59VDMZ
         4xWbPVSkqBHAqRkvoBdFSJ5Xv8Yts/HUk+N8nkUe2RiBz4RC+wwJtv4yr3icnQKjxYJC
         QlpUNQoyrZuhzzvRCyUFZbfK7MZ4Am7+xp8Wm2PMknbYTXBfs/R7EYxLcCN/DNSrau5s
         tfcA==
X-Forwarded-Encrypted: i=1; AHgh+RrHGsu5Sv6gG+UC06XeEvntTbJdYBz6a5tguabb2Wu8GNNlr0VeUpMFLGtT2I2znuK/bFovRlPwGpqIBscMmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRLbAvt0tHSGkwDk0kFtMsz92SM2yNAaTg2+KLltF3J4l4MQVS
	18RCVo5TcpuST/qP2ltjqZsst3HgzrGARwRRaFhiAWBvpKkH6styiKEwW9ekqTNblLkxOrWUSBo
	eilh7xdFzJkx/UUc97eIgpqHfqQLBgraUJ1kLQeSKqnGvx2MUGPuCFXCUQni/ZJyB4M0fCTviBW
	QlhQ==
X-Gm-Gg: AfdE7ckR0hYqqIU5LjA5JwuTr4ONV+x293MObgdWiw6Hko8KOQml4FsvjPgK+Bj458T
	WMxeTZ9DJU3H/klAK6u87HjpdHnANSovtFmCIaJSFZET7a2Ntr03vilS3ugvvM4CBZs/1JRvW1R
	SKtCp5fM4I4MoxWi/pf+Sp5nX7OG91DRmxAi5D/Ac2e9hTlOryYTQf7TN0yb/CjCMAJrFjh1mci
	kv+fMse9hbkqfnnDvuDejOp3kUJMaZu0YproPzoRbZaHyBU5u9wdtv+AG6kH3Ah3W23b8aJko/X
	ex0ZqrIWZiUb6F7Y0w2xZSTZ2JgW0+pCOVJ4BQ8kgt9T5EIS0PSVqToTpucF93WbrSoldC0wtK4
	UsQNvmywqvpdnzAV4o0OwWwm2kSgcAb3VeTQ2F2CUQ2YifUAfy61COZ3qMgfNJZY0ng==
X-Received: by 2002:a17:90b:5545:b0:36b:944b:fd81 with SMTP id 98e67ed59e1d1-38dc74d0274mr9032524a91.4.1783951550419;
        Mon, 13 Jul 2026 07:05:50 -0700 (PDT)
X-Received: by 2002:a17:90b:5545:b0:36b:944b:fd81 with SMTP id 98e67ed59e1d1-38dc74d0274mr9032480a91.4.1783951549971;
        Mon, 13 Jul 2026 07:05:49 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm77071424eec.0.2026.07.13.07.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 07:05:48 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Kalle Valo <kvalo@kernel.org>, Tristan Madani <tristmd@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, tristan@talencesecurity.com
In-Reply-To: <20260625232907.3620746-1-tristmd@gmail.com>
References: <20260625232907.3620746-1-tristmd@gmail.com>
Subject: Re: [PATCH wireless v4 3/3] wifi: ath6kl: fix OOB read from
 firmware num_msg in TX complete handler
Message-Id: <178395154819.877545.15949541191732357568.b4-ty@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 07:05:48 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE0NiBTYWx0ZWRfX1PGI2yRsyf2o
 TSvJz1SNg3Ch8yguXbDtAkoSPtoGmQWdzHCmGZ7x6yYqZxAfbzL9B6FuGhK6+AddhLBN9JXMGG7
 rZcHeOlR4T/782gGQF4nYRssB9xdWUupACC58o/zDavqSA14UQzw0ekrV+wBnMbIZQ94RCOVMtm
 XnWTl2xNnGwAGS5iOch/hKFfxxhjmQvZlrLiUwhtbzBW16Mr+pCIu5XsLFO5yh9aoKLCX5EpWYn
 qIynCmBLSQ8B/SzyfzLdj/U07uXWSAnptImVpeEWJryW9nMIdjJ7RQYtvKR/KflEakHW1/2aWTr
 Q9Fel8zSbRSqPeHgNIEDD0KVhOREV0YOup1JXWn2HWiFXIgj5wIKxOWuaWGefihoJLJpDZmGocB
 9Xn+/Eg/6QrNSytucrTrA1tXBC53EE5e8916VJUjbcWQBFnBdpbB2u+/I7bwv4Kgn0ejGeO/Cfb
 IVFtPaGMrJ7jGFjAAXA==
X-Proofpoint-ORIG-GUID: uSUuLVWJJYhj_uhqXAv5X_DzjU7EkZ5j
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE0NiBTYWx0ZWRfX21nzZSwxdSp6
 ajN5WTPEZlHKIr4TXQucHNNlsJZ8ANK1LNWjryw9R5d9x95+mjb94LS97Qm4rV7OF2KukA4Wt5X
 DBKHhWa/t5DHF5yABXDWvzIGRofdkq4=
X-Proofpoint-GUID: uSUuLVWJJYhj_uhqXAv5X_DzjU7EkZ5j
X-Authority-Analysis: v=2.4 cv=aaJRWxot c=1 sm=1 tr=0 ts=6a54f0bf cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=70hjgUy62BnErg2dADwA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130146
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38976-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kvalo@kernel.org,m:tristmd@gmail.com,m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tristan@talencesecurity.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E3D0D74C3DC


On Thu, 25 Jun 2026 23:29:07 +0000, Tristan Madani wrote:
> The firmware-controlled num_msg field (u8, 0-255) drives the loop in
> ath6kl_wmi_tx_complete_event_rx() without validation against the buffer
> length. This allows out-of-bounds reads of up to 1020 bytes past the
> WMI event buffer when the firmware sends an inflated num_msg.
> 
> Add a check that the buffer is large enough to hold the fixed struct
> and the num_msg variable-length entries.
> 
> [...]

Applied, thanks!

[3/3] wifi: ath6kl: fix OOB read from firmware num_msg in TX complete handler
      commit: 3a21c89215cc18f1a97c5e5bfd1da6d4f3d44495

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


