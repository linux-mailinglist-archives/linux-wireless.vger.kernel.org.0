Return-Path: <linux-wireless+bounces-31407-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCzVLBEwfWnTQgIAu9opvQ
	(envelope-from <linux-wireless+bounces-31407-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 23:26:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D833BF1FB
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 23:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CEAC300AB34
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 22:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C1C3876A5;
	Fri, 30 Jan 2026 22:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t32smtp-sign002.email header.i=@t32smtp-sign002.email header.b="bN6mx9FJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail116.out.titan.email (mail116.out.titan.email [54.173.78.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66AB3876AF
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 22:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.173.78.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769811981; cv=none; b=aQuIvVuimyQ1zC9BdrKGUqk5Y6oe0sXEBkvEDu0OW+dx/WwcZhnWVPxF50EyzywJdFexG/Ou1lgXUnGcWLnFoI9YGH4q6m8BYf3XsflJTvbq44Yajx+c3w7aQPuiEbGpVcQZY+RGCr3Y17K0E4c282Nu2ENSJ6+d0AIIsR1viUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769811981; c=relaxed/simple;
	bh=dND5tRrQCm1VcmbeB2Cet6BlzfSlMGt1m4MLDyFtvrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PnYpWpiUkivpEycv4LcMQd30234VDssY5+8L8ueM0dt3P1em43MK6BdqFTrM9TEyiN19peAlUWSeH/PP6CwODNZXwsgFAPV0WZJU9gIfN+G4eqoKePHJuOcwn6BztfT+mIpNfXAKnhpQjJ4WSGCGxW/U2tYXfogZdVDrbPhSZWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (1024-bit key) header.d=t32smtp-sign002.email header.i=@t32smtp-sign002.email header.b=bN6mx9FJ; arc=none smtp.client-ip=54.173.78.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 4f2qhp5tMqz7t81;
	Fri, 30 Jan 2026 22:01:14 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=8rt6F0YxN7RbEkqZaKEn0vjotF7rAQKaY4ronrAOtNA=;
	c=relaxed/relaxed; d=t32smtp-sign002.email;
	h=to:cc:date:from:in-reply-to:message-id:mime-version:subject:references:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1769810474; v=1;
	b=bN6mx9FJS78TyXQFAhKNZ6vz5Yzi0hPXp3xYBs8hcXXbQK7DtJmLI83UOnowfGuwbjMXiA+t
	YqAtNRw+v66/CnR7M2q0ax76zramZVlzU40CdmBjA9gTM85mNvytNNwppC0HIEi0aRGwzkK9kLs
	IwhnlJt1i9+7xEzDhmGUZnD4=
Received: from fedora (unknown [185.153.179.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp-out.flockmail.com (Postfix) with ESMTPSA id 4f2qhp0W5Lz7t7g;
	Fri, 30 Jan 2026 22:01:13 +0000 (UTC)
Feedback-ID: :lucid_duck@justthetip.ca:justthetip.ca:flockmailId
From: Lucid Duck <lucid_duck@justthetip.ca>
To: nbd@nbd.name
Cc: lorenzo@kernel.org,
	linux-wireless@vger.kernel.org,
	Lucid Duck <lucid_duck@justthetip.ca>
Subject: Re: [PATCH v2] wifi: mt76: mt7921: fix txpower reporting
Date: Fri, 30 Jan 2026 13:58:39 -0800
Message-ID: <20260130215839.53270-1-lucid_duck@justthetip.ca>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260125222235.36565-1-lucid_duck@justthetip.ca>
References: <20260125222235.36565-1-lucid_duck@justthetip.ca>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1769810474600722859.6018.1104361142277391468@prod-use1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=IfN9WXqa c=1 sm=1 tr=0 ts=697d2a2a
	a=r7RGZ+kgjEOtWJk29F+/ow==:117 a=r7RGZ+kgjEOtWJk29F+/ow==:17
	a=IkcTkHD0fZMA:10 a=CEWIc4RMnpUA:10 a=GM3V9Ec3FA4UBN0WKU4A:9
	a=QEXdDO2ut3YA:10
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[t32smtp-sign002.email:s=titan1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31407-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[justthetip.ca];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[t32smtp-sign002.email:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[t32smtp-sign002.email:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,justthetip.ca:mid]
X-Rspamd-Queue-Id: 0D833BF1FB
X-Rspamd-Action: no action

On Tue, 27 Jan 2026, Felix Fietkau wrote:
> phy->hw->conf.power_level is the user configured power level, not what
> the hardware is capable of transmitting.
>
> To fix it properly, I think you should determine the maximum rate power
> used in the loop within mt76_connac_mcu_rate_txpower_band (updated with
> each call).

Thanks for the feedback, Felix.

I looked into tracking the max rate power in mt76_connac_mcu_rate_txpower_band()
as you suggested. However, I found that this function is only called from
mt7921_set_sar_specs() during SAR configuration changes - it's not in the
normal connection code path when a user associates with an AP.

As an alternative, this patch updates txpower_cur in mt7921_bss_info_changed()
when BSS_CHANGED_TXPOWER is set. It uses info->txpower from bss_conf as the
primary source, with a fallback to chan->max_reg_power for cases where
bss_conf.txpower isn't populated (which can happen on newer kernels).

If I've misunderstood your suggestion or there's a better approach, I'd be
happy to revise.

Background:

I originally started debugging this driver because hcxdumptool was
crashing repeatedly on my new Alfa AWUS036AXML adapter. The crashes
appeared related to the bogus txpower values being reported (3 dBm or
67 dBm). After applying this patch, hcxdumptool runs without crashing
and txpower values are reported correctly.

Test Results:

Tested on Alfa AWUS036AXML (MT7921AU), kernel 6.18.6:

  Test            Expected    Actual      Status
  --------------  ----------  ----------  ------
  2.4GHz ch1      ~33 dBm     33.00 dBm   PASS
  5GHz ch100      ~27 dBm     27.00 dBm   PASS
  6GHz ch5        ~15 dBm     15.00 dBm   PASS
  Band switching  Updates     Correct     PASS
  Consistency     Stable      5/5         PASS
  hcxdumptool     No crash    8927 pkts   PASS

Regulatory baseline (Canada):
- 2.4GHz: 30 dBm limit + 3 dBm path delta = 33 dBm reported
- 5GHz DFS: 24 dBm limit + 3 dBm path delta = 27 dBm reported
- 6GHz: 12 dBm limit + 3 dBm path delta = 15 dBm reported

Before patch:
  $ iw dev wlan0 info | grep txpower
          txpower 3.00 dBm    # bogus value

After patch:
  $ iw dev wlan0 info | grep txpower
          txpower 33.00 dBm   # matches regulatory limit

Lucid

