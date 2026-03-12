Return-Path: <linux-wireless+bounces-33152-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOBpGDv7smmPRQAAu9opvQ
	(envelope-from <linux-wireless+bounces-33152-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:43:23 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7851D276B67
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3E04303FAA7
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 17:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E72A3FE34E;
	Thu, 12 Mar 2026 17:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="xCQvY7ul"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8273A5427
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773337105; cv=none; b=oXU3rMCyIUDVI8Lu+l1s47Vu+5P7uK0wYY08rVMsRMgR+NiiS0RCqhyYcrQPv5aEuPGoXIlBb0ClBrws2MpecMbu+kvwnpuvPLqgJRjJn9BMSLabk9+V4B5sfeWS+w6BNJ1CdWWrJjOBiZBDWYmakhJv8V3pqHeOM4JK99GuaFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773337105; c=relaxed/simple;
	bh=2ZtmxPFp7tjmIAcDAaXvqFg2IA7lv1jRnqt7W/UdDeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lwfYWazf1Fc09WNM4jsdiSUrOG2u4HKLV8CnmCceqVqdq2sS2jWas6Aq8+3DmyrtpQ0SO/08momlEo0G2PIqaV/FtgDPhyPo9hTK4/+5HV/t6wvSFpRr9aZGXSLmLhV7XYfdMKCZNhXmolwXBv9k4y4J2ScUUV/zFOQqVDpiyHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=xCQvY7ul; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1773337101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QoEyDsrNn1sJQQOf4n4C8gB9lLJkwHU+ONbuO6JKHL4=;
	b=xCQvY7ulUNj8rywydE9yTLNU1Ziq9y607ZEFkqt8/TvGNJ8RbsnH6lflbODqueNGkpjJye
	wwh1Ar2lim4h2NIGcosX0wykE/MBz2hAfWJXTk0x6QtNUiD4ULAPmJxF9zlE4jokGEaM2U
	9uNTU+08bXfwZK8Cs/d3ZozijpDxJft1z37NXVv8tiwvte+OAY9iwvMJo6RanQZNrLVTSW
	l7V2NYKCvwMJaDCa6M7mZh4bY0sqnEolmLOH21pjWShJ6ZuwFMxR/DDpJgu6QFyJoWlc2o
	stjFXKAuEyo5nqY34fR4OkwCUBWkXQp6s2zzlXIoUJKh2znvBOwrCwU8zekzBw==
From: Lucid Duck <lucid_duck@justthetip.ca>
To: bryam vargas <bryamestebanvargas@gmail.com>
Cc: Sean Wang <sean.wang@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/2] mt76: mt7921: add mt7921-specific get_txpower callback
Date: Thu, 12 Mar 2026 10:38:12 -0700
Message-ID: <20260312173812.169961-1-lucid_duck@justthetip.ca>
In-Reply-To: <CANAPQzgD312EPSbvaQTE6U+wn85L65+xZHms7DP509ApxWvSZA@mail.gmail.com>
References: <CANAPQzgD312EPSbvaQTE6U+wn85L65+xZHms7DP509ApxWvSZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[justthetip.ca,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33152-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7851D276B67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Bryam, Sean,

I tested this on my MT7921AU USB adapter (Alfa AWUS036AXML, Fedora,
kernel 6.18.16, ISED/Canada). The callback itself is clean and with
one fix it gives correct values on all three bands, stable across a
full gauntlet. Nice work.


chanctx channel source (affects all mt7921 phy->chandef readers)
-----------------------------------------------------------------

This one bit me during testing and is worth flagging because it
affects more than just the callback. mt7921 uses the chanctx model,
and mt7921_add_chanctx() stores the context in dev->new_ctx without
updating phy->chandef. So phy->chandef.chan stays stuck on whatever
channel the firmware scanned at probe time -- channel 229 (6 GHz) on
my system. I confirmed via debugfs: "Tx power table (channel 229)"
while actually connected to 2.4 GHz ch6.

Because the callback reads phy->chandef.chan->max_power, it returns
12 dBm on every band. mt76_get_power_bound() has the same issue
internally since it also reads phy->chandef.chan.

The fix that worked for me: read the channel from the VIF chanctx
(falling back to phy->chandef.chan when unassociated) and inline the
SAR + delta math to avoid get_power_bound:

    rcu_read_lock();
    ctx = rcu_dereference(vif->bss_conf.chanctx_conf);
    chan = ctx ? ctx->def.chan : phy->chandef.chan;
    rcu_read_unlock();

    if (!chan)
        return mt76_get_txpower(hw, vif, link_id, dbm);

    n_chains = hweight16(phy->chainmask);
    delta = mt76_tx_power_path_delta(n_chains);
    tx_power = mt76_get_sar_power(phy, chan, chan->max_power * 2);
    tx_power -= delta;
    tx_power = mt76_get_rate_power_limits(phy, chan, &limits, tx_power);
    *dbm = DIV_ROUND_UP(tx_power + delta, 2);


A note on Sean's rate power loop direction
-------------------------------------------

Sean's feedback on both our patches points toward deriving the
reported value from mt76_connac_mcu_rate_txpower_band() -- the loop
that computes per-rate power limits before sending SKU tables to
firmware. That would sidestep the chanctx issue entirely since
txpower_cur gets written at configuration time rather than computed
at query time.

Looking at the code, mt7915 already does this (mt7915/mcu.c:3396):

    tx_power = mt76_get_rate_power_limits(...);
    mphy->txpower_cur = tx_power;

The connac equivalent calls mt76_get_rate_power_limits() in the same
loop but discards the return value. If that were fixed to match
mt7915, the existing mt76_get_txpower() would report correctly
without a per-driver callback.

That approach would also cover user txpower limits for free --
`iw dev set txpower fixed 1500` currently succeeds but the callback
reports the regulatory ceiling because it starts from chan->max_power.
The rate power loop already reads 2 * phy->hw->conf.power_level
(mt76_connac_mcu.c:2162), so user limits would be reflected
automatically.

Either way, happy to help test whatever direction v3 takes.


Test results (chanctx fix applied)
------------------------------------

Alfa AWUS036AXML (MT7921AU, USB, 2x2 MIMO)
Kernel 6.18.16-200.fc43.x86_64, ISED/Canada

    Per-band (10 runs each):
      2.4 GHz ch6:   30.00 dBm  (ISED: 30)   10/10 PASS
      5 GHz ch100:   26.00 dBm  (ISED: 26)   10/10 PASS
      6 GHz ch5:     12.00 dBm  (ISED: 12)   10/10 PASS

    Band switching:           18/18 correct
    Rapid cycling (20/band):  60/60 PASS
    Regdomain (CA/US/CA):     9/9 PASS (5 GHz: 26->24->26)
    60-min soak (5 GHz):      61/61 PASS, zero drift
    USB torture (module reload, monitor cycling, assoc interrupt):
                              20/20 PASS
    Kernel errors:            zero across all phases

Tested-by: Lucid Duck <lucid_duck@justthetip.ca>

