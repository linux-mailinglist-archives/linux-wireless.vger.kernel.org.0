Return-Path: <linux-wireless+bounces-35885-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEBkIGwY+WkD5gIAu9opvQ
	(envelope-from <linux-wireless+bounces-35885-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 00:06:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAB24C4492
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 00:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6358230214E3
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 22:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03D5372EEF;
	Mon,  4 May 2026 22:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxSj33NE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6475737B01C
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 22:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777932305; cv=pass; b=CN7lmtJYACznB65QE69dE84agybthxOInAyJNDsRYbDHgGnrmeLEHnJEvt0d2aUfNtaTxwQe0dK2Zj9LhCPbiheokP+KgvP6HB47juCcLfYL7trCSM5J120BBKJx8PVUnlZh992QYSXV0vIZ2ZUbHb4FcW8OimV4NDDgnVzzSKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777932305; c=relaxed/simple;
	bh=ef+okV1WY/Ettk8Z1TSghijudDzKoqUrOL7p7nJ39/s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XCRQunHzerQtHUzK5BfASmS9PqsqlS0MPYueBzTDogKzlLvQTqG7yGMV3LH9KxRKr+foy2vODXmrTcYMgkT+hDKB+2+JyDnfQEGcDgV08OlslKJePsOseesRzNnSLc8BADtqnYHjsLOVkwRUaBYABZ73TmCp3OrhXIQ1v4D38F4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxSj33NE; arc=pass smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8eb17d7bc16so25448285a.1
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 15:04:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777932293; cv=none;
        d=google.com; s=arc-20240605;
        b=MrZdmGDLim8tck9mHjUFsnxGnvuz7Vyc/VVCcLJCDbIqI/3NYTxVGq3n4iFtXxupo0
         YsOTLHlds7IrrxsKinmwkfZnsLhkRU4218hrMpZ87CcFDno0BnNaCH3ju/LibFGRBLLv
         Ir0VYmYEX1lKJy96pHt+QzbDzAwCcnebSZKTHbeL/MMY44BOyVUpFrD2+e87+0Ccuocq
         NrPR6mEudjk/3Zytudqix3pJN4TttFCI7sBOTZhtHAEukQrzcyIZV4lXFQevVUHiII3P
         WER4yCE7FpWdpha7AurHX8Udr5LkpXT3A6Kz2fdkAMw6mKrz2P1upOZKjS2XSk943yAz
         WT6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=mcv17kd14ethjp4K4zWKqsBrrMNiS9CCbilKO2xxkTo=;
        fh=c4OFbMEKnBwjyaTHCGmaQXFuxgjvvkeY/GUbBQHKL5Q=;
        b=N7R79Zjv01smCd+fB8V9O86/sq2GBh8CyrezkvB68U8A7K3KZTEm+73i43OUdcrHKd
         bTOkRQ4hmYqImkiOg3iekc+JJmMr/gHjuCN2hQFnKNFOIJJ0U3UyuiNqNka739r6bKNV
         iS2uT3HyrR/0ogJ12f55Ql13FgG8U+B76/8hB+ja2Z2llN0F8RlRtGk2+hLIVQPDMn5r
         xYgSjI3VPWnd46ziI8eduIYOal+AyHwrjWqRPQKLys2/9dRhRDUYiSU7tOmx98cvDxd7
         EKyl2OcDYb5On35p71ZeJwpSQmt8Zw9bc0s3zZstqLaEkXDumPRmmMzmtbzFGH5hz6q3
         7ypA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777932293; x=1778537093; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mcv17kd14ethjp4K4zWKqsBrrMNiS9CCbilKO2xxkTo=;
        b=ZxSj33NE2pSRrFh5d0/a1OmSE2i+rFCi1hrTb9FiZtie0JGcMpQk0UhCf0yJ8zvoBk
         lWqvsm4V8emGvbya4h1IO/F8ySj8WQ8nXxoVyRPdk54Pv/M7hP07DoCQ/+aNyMJaDKgU
         5RXXo4H1QDIfYJgA6IzuNRRdQ51Zxto2WT/Yd1aVMB+EkZc+GXVD1XmhglopsAH9pBDl
         uxtIFvkDjA9hVl3J3nZMkNCIlxvtvx2m7yhHGs6tH4YZkBVTO0ZjCAKtmyhOW3vaWhda
         u98rQf8505kGLfGxjL+fPhi/cdgmd7UOrQ/xavDUO2CpdUXE9FkcVxym+o1Q+IgtehG2
         2Pfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777932293; x=1778537093;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mcv17kd14ethjp4K4zWKqsBrrMNiS9CCbilKO2xxkTo=;
        b=WRVR36e4LCJJN6YjvQqp2ZIye2D5rvYJUpbQFXhJGWIok7UjlK+G8zzTy8qPwz1XEK
         +m3nciusGMr4N9te+gz8V7zi3ObyMVqJhUUO2RQUhEyYsV4T3GlYG7r1q9MXpFz9lIXn
         VkNG5PK6XAgEWp9F0yZNHJJpMxhxCe/Gfj3RkREdNDsIF2YiDNxq8TcQpppJLU6qc7FU
         ZQm3DhKuWHPlRrEriRRzKWNua1zdfBU11d/9lDjRfoYsnA2Tn3TUQ3cnv4SGs8yzjCGW
         qa5kq4ytLqtFTddmEdKLm/w1RTGqSBBIijs+eF3XYedxINj1Tfqr1rC6jDLocG0jsDua
         n4MQ==
X-Gm-Message-State: AOJu0Yxaf9kZ/14T2/GLjiSbP1jKMvMNT+K2yd8DIr0bgQSdV1pjOsiJ
	2j7rlDuxHZd6R97AI+4A9MzXQWpvKMR6UiUxtjVrYJwYOxZxdpVgYgpY+ykICvKIknsZ2bNx11a
	eYN0E9143PPyysoOjJlMNQyDdUNl/FJeHntPyfN6HfA==
X-Gm-Gg: AeBDieuPKchaqKxHCl33BwPGrcF1DOT1V1Bs//0WzOCVJORz5ZiSypnhRlO/6Ycvy+9
	PmoaPryyN5Nb62G3HvFx4tPl0JX+yIo80Y4D2wcLbxAq8nLMNaE437SiaY78wLkYgHE50zSGvl8
	9Ltw18Qb7Fnkew0hMTvyP4M2WX3fWYI+RFHFLT8H/QNe2+cG/Ljg+/QBS1TOjT8yRtFiPleoiip
	yrgZPy6A21ecWUNm4e3tEtReOeW1sElRMclEdD0T7U0MDGRitpbmzbRPOiXEIQcRf4uDr+p8QoH
	Xk5naa1GU1XXDq+cEnbXdR1/eeljtCClTNqVA1hVd1eRNJy+tOY=
X-Received: by 2002:ac8:5904:0:b0:509:2b5a:808 with SMTP id
 d75a77b69052e-5104bdf1f0dmr115831811cf.2.1777932288423; Mon, 04 May 2026
 15:04:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Bradley Pizzimenti <brad.pizzimenti@gmail.com>
Date: Mon, 4 May 2026 15:04:36 -0700
X-Gm-Features: AVHnY4JfZSvhc5_solnPzYTZFrqUSuywHKH0VTUtRg_fusEsqPSrDKbHRXQGuHI
Message-ID: <CACjnFajRjWoSt4KT+ABhaBuU2XuZW=OrvHEzDEwY4Ei4kyJjbA@mail.gmail.com>
Subject: [bug report] wifi: mt76: mt7925: nl80211 set_antenna returns
 -ENOTSUPP without extack
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com, 
	shayne.chen@mediatek.com, sean.wang@mediatek.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: DDAB24C4492
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35885-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bradpizzimenti@gmail.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi there maintainers,

`iw phy phy0 set antenna <mask> <mask>` always returns -ENOTSUPP (-95)
on mt7925, regardless of mask value or interface state. The driver
implements mt7925_set_antenna() in mainline (which would itself
return -EINVAL for invalid masks), so the rejection appears to happen
before that function is reached, and there is no extack reason.

Filing as a breadcrumb -- haven't bisected which layer (cfg80211 /
mac80211 / nl80211) is producing the -ENOTSUPP.

Hardware
--------
MEDIATEK MT7925 [Filogic 360], 802.11be 2x2, PCI 14c3:7925
ASIC revision 0x79250000
Driver in use: mt7925e (in-tree)

Firmware (from dmesg at probe)
------------------------------
mt7925e 0000:01:00.0: HW/SW Version: 0x8a108a10,
                     Build Time: 20260106153007a
mt7925e 0000:01:00.0: WM Firmware Version: ____000000,
                     Build Time: 20260106153120

Kernel
------
6.18.18-1-MANJARO (close to vanilla 6.18 stable; not yet tested on
wireless-next or nbd168/wireless HEAD).

Tools: iw version 6.17

Capability advertised
---------------------
$ iw phy phy0 info | grep Antennas
        Available Antennas: TX 0x3 RX 0x3
        Configured Antennas: TX 0x3 RX 0x3

So the wiphy advertises both chains as configurable.

Observed
--------
$ sudo iw --debug phy phy0 set antenna 0x1 0x1
-- Debug: Sent Message:
  [GENERIC NETLINK HEADER]
    .cmd = 2     (NL80211_CMD_SET_WIPHY)
  [PAYLOAD]
    attr 0x01 (NL80211_ATTR_WIPHY)            = 0
    attr 0x69 (NL80211_ATTR_WIPHY_ANTENNA_TX) = 1
    attr 0x6a (NL80211_ATTR_WIPHY_ANTENNA_RX) = 1

-- Debug: Received Message:
  [ERRORMSG] 20 octets
    .error = -95 "Operation not supported"
  (no NLMSGERR_ATTR_MSG / extack)

command failed: Operation not supported (-95)

Same result with masks 0x2/0x2 and 0x3/0x3 (i.e. setting the current
configured value also fails). Same result with the netdev
administratively down via `ip link set wlp1s0 down`. The implicit
p2p-device interface is present in all cases (mt7925 is P2P-capable).

Expected
--------
Either reach mt7925_set_antenna() and let the driver validate the
mask (returning -EINVAL for bad input), or return -ENOTSUPP with an
NLMSGERR_ATTR_MSG indicating which layer rejected the request and
why (e.g. "interface running", "capability not actually supported",
etc.). Currently it's hard to tell from userland whether this is a
driver gap, a mac80211 precondition I'm not satisfying, or something
else.

Use case
--------
I have a damaged secondary antenna (chain 1 at -88 dBm vs chain 0 at
-72 dBm, ~33% TX retry rate). I was hoping to mask off the broken
chain in software while waiting on a hardware repair. The capability
mask 0x3/0x3 advertised in `iw phy phy0 info` suggested this was
configurable; the -ENOTSUPP without extack made it hard to tell why
not.

Caveats
-------
- Not yet tested on wireless-next or nbd168/wireless HEAD.
- I have not used ftrace / kprobes to bisect the rejection layer;
  reporting the user-visible netlink exchange.

Thanks,
Bradley

