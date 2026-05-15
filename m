Return-Path: <linux-wireless+bounces-36499-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIpxHMVhB2q90wIAu9opvQ
	(envelope-from <linux-wireless+bounces-36499-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 20:11:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 958E2555F2D
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 20:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 504FF3022AA5
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 18:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633D43EFFB2;
	Fri, 15 May 2026 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9QGZE+1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8A03FDBFC
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 18:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778868294; cv=pass; b=C3nWcoKXLgYunjfXwH6sdsglm2kVKsyNEwnobFcjfhHG+exyJjrQ/4YekFTlRfukf5wChDhGnBP0Sk/t1pRs1/E4JPeLrYAzxiLHrlf8Uxdij2u7MsVGT5g+etPEV6Q8FEoZURK0hoobZjnaTJ11mDtapyvxmMYLqgE+zqm+ep8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778868294; c=relaxed/simple;
	bh=d7NbIZXo+ERkUX/2/I0SU5fUURc4zvWrPIReK+qEBwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWAggc+cJpzUMKFqJmQ+9bdj4LEh/7I2jX0lWLAW0zQdaIucYRAHPMMvlz1ACTdM27jGDTe2CcsIrsWn5as5Y1Me4qRtgQiQmrX5cXGUbjHwjBHLs25DeDAIY9zzZmTBJeT2GKLB7J9c1cSNz8DP6SI07nHHTtov1XFdxfD/ptU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n9QGZE+1; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bd11a3729e8so8798966b.0
        for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 11:04:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778868291; cv=none;
        d=google.com; s=arc-20240605;
        b=bVCMV1jD3DBK1vZqV4T7jWODlBshphBkNiP89TAo9JbHj1BQZrMW1iecrio5ioYUoP
         AzaGrLA9VowLPZQEEIXeJw4tkVZZWawVIb9ypsTLCBuFpgpqn6kSQtwVuoNgQ/nfhgQ0
         fqJ/jOjm+JY0HQTPrGKn/tZwg/kgz0FlWH1TgKNC1ZMgtqbIr/mr1U+/sgdfiwYsmesN
         zD8+P2NCZNAJBazCgAhW4Cts9FZeAJD8itXYkptGemv/Dvxn7ZsPcJajnoFE/TRMKEcH
         msKN9OoMDcJ1UOKvzn+XjVVHmuORmUYB8IccPCaZCoGhYS8OMkOpj4HZyhaut2xbcyxl
         dC6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YriEPBtKGtIXqM5Df/lPqipwYiY6kEfqEv/SB2R7NXc=;
        fh=KZ8xS6HGrGQtEu6PADRXNcS4vAiKlO48ZYCBDiDL5Io=;
        b=beiFPcKthf/xVd7ZQVe2/IOion6kAEpTIBmo6YrxUQx4N3ehV+G3quxqXrDBPyQVqX
         +fGWwPyjtgwdBQbCcKPPrvHhpxWWv5DHoeL9BN9HJB7cIAI9YxixzoPFPRYmB8ywuooy
         AIk1TkeoMgF5vo2MnArwL5LFvtOHozOaJB40L/RIgyWhOMW+4qTVjuDBvc4YKB1aRAK3
         yNxD+mZk7YQq7/zMouwddGm/cUKyt3d+FtF9E4/Dp0t/RmCaRBUdI4k1Y9npw+SUbOHF
         FRrFiErnCLUeufZk8+t6dskQgywmMFjsum446fsOuEnUutFAufrRO1eFpnWSz4RrL962
         Yr3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778868291; x=1779473091; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YriEPBtKGtIXqM5Df/lPqipwYiY6kEfqEv/SB2R7NXc=;
        b=n9QGZE+1ZJVEoyFLhgu7nH3xNCGBZQ9cVyj5Pc19wduIFN/YVzf6qpZ02VktjQ2iHG
         sgiv+7TKcst8lsJ4ytOk4xDTX+eujS74sbnqMRZYriQg8739jUh4xssiic+RkCW0o8I8
         wvKqn+BHglFTvhVj9izq2JrsbusUsVEzip7vB4Jsv7rh+X3D3TgNafUbpifsBOKa25JZ
         zTVBB0HKYP3S+6+LsJTFO7rDQy2WvMqiF9nNl7F2IPh3Xvfrdj9FSEpa8RPVpA7gNFE9
         E7l9b4XvxzZhQuhhlFihBVJX3lD3xWa1+SwkeNrFJ7zp6iuMlyMqTG7qDNoDz0tEJpwX
         m88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778868291; x=1779473091;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YriEPBtKGtIXqM5Df/lPqipwYiY6kEfqEv/SB2R7NXc=;
        b=htugGSLZbAshoHA1e7PKOGH0kYG/PPeVRXu1eIvVLrgEU2uQsnbouBIDpa4lJujpc+
         uTlw0bwA860Zfv6Q6wiOVDT+Y3r4STWsqXlWD3kjLyZXnkw8TCc2L4ZZccLcfs4Z9c1r
         O6TKCLimPpUDD/WjBSq7f2TWkeONo39JquK10/t7o5CZK6GR8XFvychrQlbTR1Y1cGOw
         6wiCOdrH+FNOhGBcPtDGK4NpY3v8LE7tNLOvpjfT7Sov8c5mTJRi+y2jSqnWn9UTjywm
         a0PV3mJLi3yK+8lbUJuqztYm4ntjIIQReiqNaRYlBeY0yZ2gBKxQegGL9vw9l+QY4Vyv
         BjYg==
X-Forwarded-Encrypted: i=1; AFNElJ8IP3hc75Ni9VC/2kefiF2BP0epoSpUPYdld/Hy7iU/2BEEocQQBmo+gyjZKqpq3KC6/YEzSXdR/dYJcnpvTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcafUMc+0KWrFX4c8g9yN/Yvfypk+dDw6yyPC59uEoHgYNKQ/O
	2bxkJzUSnzJZrnQCP2eQru+eApxsrNdWcQR5voAv9EZjcaf8hStfuJSEqg6BLtcfPxSoVNnoimY
	hK8wKoizlj4lXjZ3sXoxa48sdJaNsuYI=
X-Gm-Gg: Acq92OEa+7BuLd8ptQ9JUx0+K0wT6BxNhdUOtDJiIT3AypGGL/DgMKJX3MpJlP32Wcv
	t29CkaSwhg0J+7y4pYgSklTgN8lL/4V0D8oB322puFzfaGDnkXc9O21ub+0+9tpvMpwDPoBAc4d
	o5+Ufh32bJV/E9kjsSyqlQW4oBVohAO57YyZd/bctZXtKssBzl4IZPAdj/3VlOczkEY77JIXpHr
	0uMyQ1OLh5r5f+F0dJBwuM85afUqCJbEir1YHfBbnKfJz6sZRjw0hnQ5SYxbpFTkztg4oKVaHEb
	gtxbLXbbRUW6efE6FrNEudZ9spUSWIGVnq0CRPGn
X-Received: by 2002:a17:907:e15c:10b0:bd3:417e:b85d with SMTP id
 a640c23a62f3a-bd5177ea873mr224170666b.13.1778868290941; Fri, 15 May 2026
 11:04:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5ecac6a9b7d29526e8438dea105b58f5487c93aa.1778521232.git.ryder.lee@mediatek.com>
 <agdJ1EtZjjWh2R1h@lore-desk>
In-Reply-To: <agdJ1EtZjjWh2R1h@lore-desk>
From: Cheng Hao Luo <roychl666@gmail.com>
Date: Fri, 15 May 2026 11:04:39 -0700
X-Gm-Features: AVHnY4KbrKR9CaA_jQmHLyQZ08ngRHLldKj46sSAK1t83aUKIVFRDiqTWe1rvrA
Message-ID: <CAHoxojJX2BRRTLMuM_QcJqMMmshxS4EAwrB1VjU3rsZ+0k2PAg@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt7996: avoid memset overwriting tx_info->control.flags
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Felix Fietkau <nbd@nbd.name>, 
	linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org, 
	Shayne Chen <shayne.chen@mediatek.com>, Roy Luo <roy-ch.luo@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 958E2555F2D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-36499-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roychl666@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

> struct ieee80211_tx_info {
>         u32                        flags;                /*     0     4 */
>         u32                        band:3;               /*     4: 0  4 */
>         u32                        status_data_idr:1;    /*     4: 3  4 */
>         u32                        status_data:13;       /*     4: 4  4 */
>         u32                        hw_queue:4;           /*     4:17  4 */
>         u32                        tx_time_est:10;       /*     4:21  4 */
>
>         /* XXX 1 bit hole, try to pack */
>
>         union {
>                 struct {
>                         union {
>                                 struct {
>                                         struct ieee80211_tx_rate rates[4]; /*     8    12 */
>                                         s8     rts_cts_rate_idx; /*    20     1 */
>                                         u8     use_rts:1; /*    21: 0  1 */
>                                         u8     use_cts_prot:1; /*    21: 1  1 */
>                                         u8     short_preamble:1; /*    21: 2  1 */
>                                         u8     skip_table:1; /*    21: 3  1 */
>                                         u8     antennas:2; /*    21: 4  1 */
>                                 };                       /*     8    14 */
>                                 long unsigned int jiffies; /*     8     8 */
>                         };                               /*     8    16 */
>                         struct ieee80211_vif * vif;      /*    24     8 */
>                         struct ieee80211_key_conf * hw_key; /*    32     8 */
>                         u32        flags;                /*    40     4 */
>                         codel_time_t enqueue_time;       /*    44     4 */
>                 } control;                               /*     8    40 */
>                 struct {
>                         u64        cookie;               /*     8     8 */
>                 } ack;                                   /*     8     8 */
>                 struct {
>                         struct ieee80211_tx_rate rates[4]; /*     8    12 */
>                         s32        ack_signal;           /*    20     4 */
>                         u8         ampdu_ack_len;        /*    24     1 */
>                         u8         ampdu_len;            /*    25     1 */
>                         u8         antenna;              /*    26     1 */
>                         u8         pad;                  /*    27     1 */
>                         u16        tx_time;              /*    28     2 */
>                         u8         flags;                /*    30     1 */
>                         u8         pad2;                 /*    31     1 */
>                         void *     status_driver_data[2]; /*    32    16 */
>                 } status;                                /*     8    40 */
>                 struct {
>                         struct ieee80211_tx_rate driver_rates[4]; /*     8    12 */
>                         u8         pad[4];               /*    20     4 */
>                         void *     rate_driver_data[3];  /*    24    24 */
>                 };                                       /*     8    40 */
>                 void *             driver_data[5];       /*     8    40 */
>         };                                               /*     8    40 */
>
>         /* size: 48, cachelines: 1, members: 7 */
>         /* sum members: 44 */
>         /* sum bitfield members: 31 bits, bit holes: 1, sum bit holes: 1 bits */
>         /* last cacheline: 48 bytes */
> };
>
> According to pahole, the size of the control inner union is actually 16 bytes
> since the compiler adds 2 bytes of padding. Since mt76_tx_status_skb_add()
> meset to 0 just mt76_tx_cb size (that is 16 bytes) I can't see how
> control.flags is overwritten. Am I missing something?
>
> struct mt76_tx_cb {
>         long unsigned int          jiffies;              /*     0     8 */
>         u16                        wcid;                 /*     8     2 */
>         u8                         pktid;                /*    10     1 */
>         u8                         flags;                /*    11     1 */
>
>         /* size: 16, cachelines: 1, members: 4 */
>         /* padding: 4 */
>         /* last cacheline: 16 bytes */
> };

Hi Lorenzo,

The mt76_tx_cb is placed at status.status_driver_data (offset 32).
It overlaps with hw_key, flags and enqueue_time in the control union.

static inline struct mt76_tx_cb *mt76_tx_skb_cb(struct sk_buff *skb)
{
BUILD_BUG_ON(sizeof(struct mt76_tx_cb) >
    sizeof(IEEE80211_SKB_CB(skb)->status.status_driver_data));
return ((void *)IEEE80211_SKB_CB(skb)->status.status_driver_data);
}

Regards,
Roy Luo

