Return-Path: <linux-wireless+bounces-38225-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /5jbDSP6QGq4jwkAu9opvQ
	(envelope-from <linux-wireless+bounces-38225-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 12:40:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 679DA6D3A41
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 12:40:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nyu.edu header.s=20180315 header.b="qt8 0f/W";
	dkim=pass header.d=nyu.edu header.s=nyu-googleapps1 header.b=qubN+9KU;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38225-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38225-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nyu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E583300E3B7
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 10:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA74823EAAD;
	Sun, 28 Jun 2026 10:40:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-00256a01.pphosted.com (mx0a-00256a01.pphosted.com [148.163.150.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2C2233933
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 10:40:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782643231; cv=pass; b=Dob/37Cq2uKsw8WBrDufyDoFLexk04KZb71312mTjRkQCY3rdyDhEY6gtfjAwuP6Bc9aAv1sO6TMMrE4G4hPqltJSUpq86WXvaC9vvwBIH3ZaiP6eO746bVZ0GByfxpway/UiVcrR6HpAaFe5qj/Qcqhj7T3AW/9D8MS3S/NFOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782643231; c=relaxed/simple;
	bh=mWSYADSikqRBBBw/l6+1fgSqFY9GutZDLsvyNjYAOEs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TkCMIXUqicPAMK8jvOx0NSLwJNqoQmiIzCSKvBnQLb1p/4s/e2H+IxygbUwxz6SMWa20blnxDBPi2WbQ4MHyZsauvVXqdOmBn8CQSZlEv4iD2EWbiGpGtywTIxhFLrAp1Vrh2TAK8a4Lyszmb6x89qd0x5bQ3JLkf6fZDAg+dfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu; spf=pass smtp.mailfrom=nyu.edu; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=qt80f/WZ; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=qubN+9KU; arc=pass smtp.client-ip=148.163.150.240
Received: from pps.filterd (m0355794.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65S9ZHIe3840619
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 06:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	20180315; bh=+tQ+6VE88il0RYGsLv5vQZVWSmR1xeHekDkDjYsVFso=; b=qt8
	0f/WZl8dQD3BlCxgeK21Mrin3EUthecFAcbGf4zFxUgiQxqsP27ZKlyd5rEs99OR
	ff08LECVjs1/Sm9RAi0sZXa8wNGTdu86cCCjzbKQvaxi0MuT/b2MW3nC+L/L387r
	XgTvKjFagGWvWQTSQnSjhQg/c7t2+UDkunyDnlt8V+kVxW8mOc2yNJf5mKl9cR/H
	yjMypTOfHeG6OKrv2TyBJMHYdpk6B9Ghldtlrxj2DssPkwEqoG2ZxYvQ/sTXmc8M
	+HVDnEaOxSFwxkCu8JgSh837BC8UPpfx8W00IKJrFEAHoEQ3hRMD+CYWiFX+ECNg
	h+Xoa7tRwjuR2wcpGYg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4f2sp5j7nb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 06:11:52 -0400 (EDT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-845c296374cso1525331b3a.0
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 03:11:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782641512; cv=none;
        d=google.com; s=arc-20260327;
        b=IelRcu3lW09erxHgB0rUSgP4pXC0IQuUmJRNhzuels0fA4ht/LBsngItyCCvwx2ib1
         KPfPfubPbUiVvMt4N8XcwzDe5IYTJjf20J+532nXKTw45kDq0dimLLsrBOFjYoIf+QXj
         kqNeEggQgz/PeaQGls5/lFMI2M1+3ZnDsgArE/A/AaDbSQcYmA/m1R39umxsbKUeRFjy
         0oUd2t4dgSKTwVf6Q7jpr5wlNMFn11iGObUF6IP3X/kNMm8qq/4yyPGSTeosTshYar+h
         7R46g9ei496rMr+1p97RH3VoYBvdYYxQJl5vU6KIJo6tXfxmpsV4WEXwLlpAxXp7pdWu
         ccvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=+tQ+6VE88il0RYGsLv5vQZVWSmR1xeHekDkDjYsVFso=;
        fh=dYXvSfJMeWGIuWyaJ7so2v6k5ScSDoJOIu+g+0nDEsY=;
        b=RVYfkH3J58D9FclPZbt/MQU6PWZW1I+xSfSL6WyXfcGoT2RxAjXrcus17EOYjxjZvr
         f1DCqP7kSh/bHLwJkGRwrvt3TrtVbtt5GxHLAJzRZMqVMiFMirm8VYPXOLfU9BK7O5Pq
         PBExUWeWlsdy/MT5Y+UIinjMqPrd/kpcug0xLP/N4Nt0qoryef3AR8LLxVdveof5X29x
         mU9ni/VpB7GEsUJxLBDZognqKamC82W+0xgSjHxYqUoUNZfvfVesaiM1zVvYJaOcNym/
         bQ7x5ljJyl5AMA0bnBQffdC9bDV87uqtpVoCB4K1v3CsC+aXRoeoen24sALA9SoSoW3k
         PI2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1782641512; x=1783246312; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+tQ+6VE88il0RYGsLv5vQZVWSmR1xeHekDkDjYsVFso=;
        b=qubN+9KUHmL3JiTS356xSAHunkS/M9pRyi/QtbLbt7QEsZThS3jgvV/8xSj5N7Gbe1
         UJrw0BL6gtx6iT3f+h2/Mv6g4fKScPLUEHftt/HLErEwE+alvBT8I/A3QqE4TLsmunPt
         0iTK2gKFoPcqp6/4/yzZ90N9yGp7C24KAtIyFPMrj9pWzJXMxhqoXmrfaQJVKpk/s2QX
         tZXGDFDEk3RXeqjX9GPQYq3Uk3WjGBbvVgHV1N0iaF3qlkw/afnRfmDwz6TTIHtTUEtM
         EZ1FaQt0/PJGk0/XDDP7+kaYlawqRsUucEnAFD1BVLB4TRQqXrvj5aAVOv03jwI+uKA6
         wb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782641512; x=1783246312;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+tQ+6VE88il0RYGsLv5vQZVWSmR1xeHekDkDjYsVFso=;
        b=q62cumN2eGZOLRDSbmaU5lF34t2t5Fb+7SEc4W3nWPifz1ewczSoq8SxOJrc+pCjzR
         4r7tIGQlPIQBBdckJbaBe9/arR0Dkqc6YXUojEDIX/VjQDOW3cYNJEQ9hQNwuAboRj2G
         h07MPJltlDBnp8t0IhlAIig2iETwdTE9Hd/tGmmBXd59avKiebAwJtNuB86iP+14dE9x
         yogINMg6wZhZZw8mjjI3BspWd2RgAX1Brw51HHPYzndg2r1ppx7/gBxmprEn5FPFi8Q1
         HI92gDpZMsdl4w9cQtN+M5hC1zHoWsFU4MjAAdTrRu8Tq02NQ5YUXt3bUrI3wxvuO+N3
         rUAQ==
X-Forwarded-Encrypted: i=1; AHgh+RpJ7ob+DbMBVIguJNhCRvXZ8Bsya1AhQvJwB0yZc0t+iz2qLwHNLs7kByPnC+zLHiAKj0PzKYGJ3PTjO/YdSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YygJ5n2Ysx0iDqezcFug1Bo9YM/toDeWy7Qai5AY0MliZ9ec42A
	7F4fBKwRcRwTCtnPcHa7JS6rW7SiJKx3ycCsns05zDtjADJHaCrW+Hf6oOnaLjvpL2F2M1pLfLv
	bXYWMrAwa+VjQOkEBw9Zyqh5qt/iDGDYVPVrjOh6uaznf7EmIfnciST4BWph9NKRrsK7tvJiBie
	8bqc1CofgTMHJZ5/OQAPxnZoUjWH+8xnrpiAY5LuTE
X-Gm-Gg: AfdE7cmSA7qriop3NZdiqc/hSgrZWy9mYu1DISaxhBIs6Q0NlAdjDN/e5xXNKrxRryl
	Ngie34sqyf+rCUZjf1uhhFdGkt/EV6eNSa3k0nSXZHw5zzURCuCvvebfcUtphgmHmoEsbR8tFD2
	Anvok0xluazQYR62kvRg78nkoqVsFKWdif+C/8//yXx+TMPMAL7xDxMqVv7njKR+IGtF7w
X-Received: by 2002:a05:6a00:6017:b0:835:405a:7e6d with SMTP id d2e1a72fcca58-845b3aa11fdmr12288936b3a.21.1782641512356;
        Sun, 28 Jun 2026 03:11:52 -0700 (PDT)
X-Received: by 2002:a05:6a00:6017:b0:835:405a:7e6d with SMTP id
 d2e1a72fcca58-845b3aa11fdmr12288922b3a.21.1782641512007; Sun, 28 Jun 2026
 03:11:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yang Liu <liu.y@nyu.edu>
Date: Sun, 28 Jun 2026 03:11:16 -0700
X-Gm-Features: AVVi8CfAIoUNIfxM5v9T3o58Vnf7MK0HDsknT8lit6LguFvobXTyIEHZKWs90-A
Message-ID: <CAMt2zv5c0cYzfe0RQ5AfoUdm+b4bAshgjCs23NjFBhQXDKLniQ@mail.gmail.com>
Subject: [PATCH] wifi: mt76: mt7996: fix TX DMA mapping leak for ADDBA-req frames
To: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=KvB9H2WN c=1 sm=1 tr=0 ts=6a40f369 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Se5WoFf3ZZRiLcel0nel:22 a=A3cO9-ABBa8CDv30UOuY:22 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=b7W-z1OYDQUBpEVa_EYA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDA4OCBTYWx0ZWRfXzCsH1xenT9Jc
 1++sfm3fDzT5JfEtXiTL6wRq9cjqrjpTYfVXsi3Cx2kjY52YwPaf16P71WQbGxCQj+wWQPoHNTl
 95xw9+HSl0RGpqEiqN/DtZBclZBN+Co=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDA4OCBTYWx0ZWRfX5umrZiz+6a0F
 zPJNzn4EnqnvDIDSVpUs4MJXVZiqg4yKnGcCPVvY9Gn0cXvHwlTeLNTM/ilnEPlckCLGFT4+5bd
 HZZSLSR4HqRCT/rHEHRfpgb1rfAqJnkT9A2UFtsVh8lYcEpyYJh9+AUnbrRcrrSjSsiTvegIzgB
 MO/BezcQHxmhYB/6V8KTgPGbcJgAIwvUOW9ui1rzNCxE4XupXGl14M6zOz0GpvXacz5MOmxbxIS
 ApP9GJxQoHH7BNrg5YzDNKGfhzqtqLZGmLUGfx9OkSDKgQvC0otmba5DtU4icEOR3xAvuvla66t
 udEodGBMYAmFCdnj0nmxIpGtUOLE71VjVJdGHDpoI8pbCYLmb8XqkMUc6YkIGuoj1b63+UaFUK/
 FykrvjkhN+nUu4TssxcV9oUiEOFH+motK9/SQWd2gCuMmfCx/7z39BTtCrH/qAqyocZCSJrKORH
 ev47iM/MibbnkmxML2g==
X-Proofpoint-GUID: UOeczwQC6i_DICEKQSG_UxnsbHi4jVgK
X-Proofpoint-ORIG-GUID: UOeczwQC6i_DICEKQSG_UxnsbHi4jVgK
X-Orig-IP: 209.85.210.197
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 priorityscore=1501 adultscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 clxscore=1011 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606280088
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[nyu.edu,reject];
	R_DKIM_ALLOW(-0.20)[nyu.edu:s=20180315,nyu.edu:s=nyu-googleapps1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nyu.edu:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:linux-wireless@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38225-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[liu.y@nyu.edu,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liu.y@nyu.edu,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 679DA6D3A41

mt7996 hands the firmware a HW MAC-TXP for ADDBA-req action frames
(MT_TXD7_MAC_TXD, set in mt7996_mac_write_txwi_80211()), but the chip is a
FW-TXP device, so on TX completion mt76_connac_txp_skb_unmap() decodes
the per-frame txp as a struct mt76_connac_fw_txp.  For a MAC-TXP the
fw_txp.nbuf byte aliases the high byte of the TID word
(MT_TXP1_TID_ADDBA, GENMASK(14, 12)), which is always zero, so the
unmap loop runs zero times and buf[1] (the skb DMA mapping) is never
unmapped. mt7996_tx_prepare_skb() also sets buf[1].skip_unmap
unconditionally, so the generic mt76 DMA-ring cleanup skips it as well.

Each ADDBA req therefore leaks one TX DMA mapping, i.e. roughly one per
(re)association.  When WED is enabled the mt76 DMA device bounces these
mappings through the WED swiotlb pool, so under continuous client
reconnect churn the pool is exhausted after ~1-2 days, after which DMA
mapping fails for WED, the WiFi MCU and other on-SoC consumers.

Only set buf[1].skip_unmap on the FW-TXP path. For MAC-TXD frames
leave it clear so mt76_dma_tx_cleanup_idx() unmaps buf[1]. The FW
unmap is a no-op for these frames (nbuf reads 0), so there is no double
free.

Fixes: cb6ebbdffef2 ("wifi: mt76: mt7996: support writing MAC TXD for
AddBA Request")
Cc: stable@vger.kernel.org
Assisted-by: Claude-Code:claude-opus-4-8
Signed-off-by: X <50459973+ly4096x@users.noreply.github.com>
---
Tested on a Banana Pi R4 Pro (MT7988A, MT7996/BE14, WED enabled, 6.18.35):
under a continuous client (re)association reproducer (~51 reassoc/min),
/sys/kernel/debug/swiotlb/io_tlb_used grew ~25 slots/min before this
patch (steady leak; pool exhaustion and the resulting DMA failures after
~1-2 days) and is flat after it, with no double free.

 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 0eebc81..962dad4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1010,6 +1010,7 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev,
void *txwi_ptr,
     struct mt76_txwi_cache *t;
     int id, i, pid, nbuf = tx_info->nbuf - 1;
     bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
+    bool mac_txd;
     __le32 *ptr = (__le32 *)txwi_ptr;
     u8 *txwi = (u8 *)txwi_ptr;
     u8 link_id;
@@ -1096,7 +1097,8 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev,
void *txwi_ptr,
     /* MT7996 and MT7992 require driver to provide the MAC TXP for AddBA
      * req
      */
-    if (le32_to_cpu(ptr[7]) & MT_TXD7_MAC_TXD) {
+    mac_txd = le32_to_cpu(ptr[7]) & MT_TXD7_MAC_TXD;
+    if (mac_txd) {
         u32 val, mac_txp_size = sizeof(struct mt76_connac_hw_txp);

         ptr = (__le32 *)(txwi + MT_TXD_SIZE);
@@ -1167,7 +1169,11 @@ int mt7996_tx_prepare_skb(struct mt76_dev
*mdev, void *txwi_ptr,

     /* pass partial skb header to fw */
     tx_info->buf[1].len = MT_CT_PARSE_LEN;
-    tx_info->buf[1].skip_unmap = true;
+    /* MAC-TXD (ADDBA-req) frames use a HW MAC-TXP that the fw-txp
+     * mt76_connac_txp_skb_unmap() path does not unmap; free buf[1] via the
+     * DMA-ring cleanup for them instead.
+     */
+    tx_info->buf[1].skip_unmap = !mac_txd;
     tx_info->nbuf = MT_CT_DMA_BUF_NUM;

     return 0;
-- 
2.53.0

