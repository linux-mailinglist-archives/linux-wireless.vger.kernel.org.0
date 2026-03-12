Return-Path: <linux-wireless+bounces-33031-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDqHCJ4NsmnuIAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33031-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 01:49:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7893226BC1F
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 01:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15F483055951
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 00:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE90322B8B;
	Thu, 12 Mar 2026 00:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AalmctL1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C9514A8B
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 00:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773276570; cv=pass; b=nYzwCspO3kulSxZx4+tBFn0/wHoRXnYqSW4DC/v61XD/LKpIxzk30V8v4JPHzsmmy0DXeDuH2LkQ4KEcUkHWlAzw4RyS6d2MEU6VFPaoXBpNiVJYxFXVR4XgiHhYfESmlzi5q3S2wC4xj07fRHoN7aSZ4Q7KkISFCS5PD6sESVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773276570; c=relaxed/simple;
	bh=mwVpUA/giWdIJw58k9hDbz0hUZ4oBZ31MQ6sjUpSbkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C0LjIqqakEjJjb0A+Cz/I3YoZxDIPf5318RiDm0/QGMlr7EepD4WNXsmpIFVWl7bd/X1wxpzsD/zKC3SEmaFfDRIQGxaqiYHaJ5VVBtQV2zvmdNJjRkXwRrxRfzg/Jv54vhkAZwdvyV7u6c7ARx4fEgdaixX81DmpMgihu5DJsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AalmctL1; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b942a41c5fcso55897766b.0
        for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 17:49:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773276568; cv=none;
        d=google.com; s=arc-20240605;
        b=QGVGeeUd456RlqfaGpBDaKlqYFsfw0s5DaAI4+J+J4PhFfDfi5ys2GXnntd9hQV4kk
         shrLJCXLMYblU7U/qfOassGsm18u+7c16KlSg3GaDB67G6ne05eiOBSLjj3ugRXNNe3N
         9cbH16WgIDU0TRM63pip2uEX7RBiXKR1ZLVPUNYVaorFVohJjbd8ChiyuLElSwrANlN5
         Z5zaxsAkyEMsVerFZVItw5I17ykhpjYE62SwZH3NArZATqkLnX98Y6PrXHxt4rHGJAvF
         9DBxfLB7puer1VQuD9DtCuRH7FKgsie83c16ohPUTSYjI/Rnc6wJJDHl7T0THcAo240X
         HIMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mwVpUA/giWdIJw58k9hDbz0hUZ4oBZ31MQ6sjUpSbkU=;
        fh=NEObcxblMrqXviMD6t8Af9NV6vBFXK2xX2AX9Y7rA0c=;
        b=Y2Z0P0+wGpqNVqwG43PIPkr/SusRYwPOlRKORlWLKMRAgQ+Au6FA3BEz5dOzile2JR
         oEdzxrqDTsQmXSejkom2+xOHot3AzxM+5JasgcsDWaYtDBPE9YMUAse+r3RREXmRFlr7
         MtP/NlnEBx9ce7D+i1foZIjhvBtJY4yrrdcoDRuHBXXzTNAVDHIUdT6o459GfldDBZi1
         sYWmmhQDflJcmbWq2qoMUsq9LiS4ICaiQSObcg4Y5YT9VWZgXsQ/7qlnT/ZjN/1XcnWZ
         Y1aeD2aL6St4cV+JO0WBRkw0VN4lWaGx08wilyCxZAHaork9iypP+c9+SXJ8XVxWbU1r
         hKzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773276568; x=1773881368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwVpUA/giWdIJw58k9hDbz0hUZ4oBZ31MQ6sjUpSbkU=;
        b=AalmctL1rAyeyp2LDB/BLBLH0068yqJ4aTEixZLgp4n/ZdbI2yO1jjOrXXELFh+Z/S
         YXKQElfCaLrQtTDp+p/d+5/QRpDpWrcP55jFkftuL4dXV1lBYM9WTs5Ce1LLsnsw0Nni
         jEmtvwVzk3xKAhClxbzQVJ9/0/qOfvIayBuDUexfdyf3vuNwobCYByaU6J+wuaFtdhEu
         fmpFKQMOYmKSId0aHTK1Jt6G+WguRo94HB8k5pXq2GBAhguCZ1+/A8A6BeYs98WNL12v
         0CD9JAFkCsexk1yVfOsTq2Lv8WgtiI3Y8Ly5CBaZCWrkE0h3cwN3pdI4pYyNWVzBuiab
         /LEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773276568; x=1773881368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mwVpUA/giWdIJw58k9hDbz0hUZ4oBZ31MQ6sjUpSbkU=;
        b=t3gjBhyjBbc4ff9RIWecrxqOsRXOGTY18Xc58hvlm55vFw1ENHJT4SjFW9i7gca0nE
         KPR/faKr9eD+jfNOecQccMtnS2MerTdcPjimpMjH7l6m6qpXdG8mNkbRIEfRMRuAKf1I
         1HEzywoWp9XaOMpa8L3PgmCtrswlImuwTwkIFDy4fMGcxnqEHBzCYgjK8IXAbhmOyrHE
         8JBWXcJRLFkvVVbzXxT3tYHVeY5LzFBirvsvp7OmjxPzmFxua9EKNoKjnZs5MtvsracL
         aceVeLsCZ072uG5kTafIQoFu+49Qh7IPmkg5F1eehPuHHqd1gq0BdbGMIlxFuPPo1PRh
         zh8Q==
X-Gm-Message-State: AOJu0Yy0RJ5KhMVDM54Qo6N7LmJWrs1Bi9f/ZFHbmRU4Knbnp9Y7XMaN
	sBru7hkC2HJNvBpd0tXz0I/PS8+xbBXLoDLYkQt4PbRx5OfW9Tzey39AFuHOgws+n1JbvNuseye
	ATbanenA6SPUc2WTxHp+Aw/OQ/uCqIBI=
X-Gm-Gg: ATEYQzz1z5m6jCfrM5PsWWRtBwjxizuq2uXeWi3+kbFYVxAqMWO43LfrRWtKcM1xPcn
	66A8XJ0vHgyxekwSWKkLvIQPZrpx4Y9/UkOJKpRNp2BoCq/QnxU4M9S54oIUSJB5FP23L2A2ey9
	GSjDZcikvl9rRvBjtG+JgQy/Al5XJpUcbRXZubJxtPB9bJojMFMrM1po8X9SSouOmoL3e4SCF6L
	xyQQlBkukzdlnFjQowsOiljf3dPrSetClIBXRJg1XAqQpgWpsc5KEuDmmBo+PAmMx2hIeNV30H9
	caWhwQ==
X-Received: by 2002:a17:906:a8f:b0:b88:4e52:bfb6 with SMTP id
 a640c23a62f3a-b972e6c8e7dmr179250466b.56.1773276567628; Wed, 11 Mar 2026
 17:49:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANAPQzi3BkfnRS4CEXAA560O5cO8e6MEYxeVVx1u+xUeXS-gmA@mail.gmail.com>
 <CAGp9LzoidBL1iYYC371+Fw+drbArLRTneJKxCoFiitx=dweKCg@mail.gmail.com>
 <CANAPQzjiBf8Rqphn2SypYN2O6bddj6vB=63Mp=T5YVEt2oGvyw@mail.gmail.com>
 <CANAPQzgiE1rMP3F=5NJg3hp2uBXtq44+vTRBdkHwdfHyXJ8MQQ@mail.gmail.com>
 <CANAPQzgD312EPSbvaQTE6U+wn85L65+xZHms7DP509ApxWvSZA@mail.gmail.com> <CANAPQzgXN2UOjuwV1fRofN2syxG933kSaB9S7DyFAykHHMRzew@mail.gmail.com>
In-Reply-To: <CANAPQzgXN2UOjuwV1fRofN2syxG933kSaB9S7DyFAykHHMRzew@mail.gmail.com>
From: bryam vargas <bryamestebanvargas@gmail.com>
Date: Wed, 11 Mar 2026 19:49:16 -0500
X-Gm-Features: AaiRm50HsJHpMb3HbIXjmjo7HBZSIJYEz5Gy_TSE0LfzfxeboZKaIdZ6E1IIr6E
Message-ID: <CANAPQzhJfMCqqgdJJEY8uYPexBXYaXx6XVVUiRcQZA5=t_fBgQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mt76: connac: fix txpower_cur not updated in mt76_connac_mcu_set_rate_txpower()
To: Sean Wang <sean.wang@kernel.org>
Cc: linux-wireless@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33031-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bryamestebanvargas@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7893226BC1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Subject: mt76: mt7921u: WF_MIB registers inaccessible over USB =E2=80=94 ri=
ght
approach for survey fix?

Hi Sean,

Thank you for the v1 review. I've just sent v2 addressing both points.

While investigating why iw reports zero channel time on mt7921u, I
traced the issue to mt792x_phy_update_channel(): it reads
MT_MIB_SDR9/36/37 via mt76_rr(), which works fine on PCIe (direct
MMIO), but on USB these are hardware MAC counters in the WF_MIB block
that the firmware does not map in its USB vendor request table =E2=80=94 so
they always return 0.

Evidence:
- iw dev wlan0 survey dump reports 0ms for active/busy/rx/tx time
after transmitting 638 MiB
- Disabling power save has no effect (rules out pm_wake early return)
- mt7925 USB has the same issue (same mt792x_update_channel path)
- WTBL registers (MT_WTBL_AC0_CTT_OFFSET) work fine over USB =E2=80=94 used=
 in
mac.c for per-station airtime

Before writing a patch, I wanted to ask:

1. Is there an existing MCU command that can retrieve MIB counters
(busy/tx/rx time) from the firmware in the mt7921 USB case? I didn't
find one in mt7921/mcu.c or mt76_connac_mcu.c.

2. Alternatively, would it be acceptable to accumulate survey data
from the per-station airtime counters (airtime_ac[], already read via
WTBL in mt7921_mac_sta_poll()) into chan_state->cc_tx/cc_rx? This
would give approximate but functional channel utilization reporting.

3. Is there a reason the WF_MIB block is intentionally not exposed
over USB in the firmware?

Any guidance on the preferred approach would be appreciated before I
write a patch.

Best regards,
Bryam Vargas

