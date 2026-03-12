Return-Path: <linux-wireless+bounces-33168-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eE2fCaAzs2ntSwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33168-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 22:44:00 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A48B527A212
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 22:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 318F331BCD85
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 21:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B4D3F54D1;
	Thu, 12 Mar 2026 21:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hU82wD5A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CEC3F99C6
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 21:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773351773; cv=pass; b=ZwP2vgFQZwJeZzAwpTt5mUfu31fXmZYq2dsHUl+O0ZHsEWwMkJEYdZ+7NY/Mc5P1q/X6G5s9YF/nI7t6/tZljceN3gw8rwlpTbqf1CiieFrZXy43nY5T+59M+IDwjgQzooXw9hCYbidckbxecr9GYzRJtWNZbkpmq0d2C03pnjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773351773; c=relaxed/simple;
	bh=+0B+g8jSBu9maiIvBLZcDTQnNNJgqwjARyfpMf9WHh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMaLDVN3mNv0MO6aWY1CnPgb/gDHwomhDT7tLf27Pj31biUAuPMLQ/N0nfNUx/kkFiTXjsdEYHFdnwCNNK3fBhOltpguhIJ52vT9dJ3qafs9QUFhs5I+/lTWE9U3N7DFLEbJpzzUBxyNCwYthA2pOmwXaR73EHDpBMQWNMh0t1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hU82wD5A; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-40ea611d1a4so638188fac.2
        for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 14:42:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773351771; cv=none;
        d=google.com; s=arc-20240605;
        b=KZuUYdosxgi6N9boaBMrtLBvbozffCr6PD4p28sj1uMDbQZhtC+G+8m6lRTYjktxML
         cxNId/oULdENDT1/e2lO2TrlmWiAvgRod9FjcAcsdM0b4itZFuBew34o576Bpmhj7UTA
         i0XGvt8+0kQUXiUk+2DkTzoLYXtmPMVrOG+E4+3fnUVs4ylYGOxSj0rDsKndIwL319ZI
         smP47cYbDabibmNFNpw13j9d4QRC/w9vBWpIQ6ByxmAppdl1WLeTY92TQfVvmuWHaDag
         1F3NbEbaLJm9ZS4xD3tbEmboY+k0TV+j9tFipLvg24Gc52wXPdJWo4LPhUGq7VWwYmM4
         OUjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DOtRmPU59pcEVq53EWNPtwK9vnHX/kwmOFgeMq+s5vQ=;
        fh=fFUQ3bDSnwWYL/1dqZwPKYywXd5TONRsAevI/mvHYbI=;
        b=ZHm0Y+dNefUS7sC57yYY9C2g0xFiQIzBJ67kgCr95I290UcmepLZ2D01eyKUvCT7ye
         xcuS9c7BlNxQNN7k5E5Sfp5mAPcVLUUvWdDIdxAFIML46eVPffICJhzz5l0tesT8a6FB
         9L1chptPkIpP/sppEOT2lkd8dobO11+XdUKjLmYskqRiLe4yyuE5y4kEpa9RjWDWlXCJ
         IqTcGz21YYVqVA4MJWVRQZjEdZquoJnEh9Qj9ihnFmQT1+C/K91xgHv8L+BJMyl8eLHu
         K/SWt0yrBRCYqjI9dzB1I5MDw8Km29YEJZIFxFGwWnIe7MKluLcbnDaQA5h9yyEsil/c
         LtaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773351771; x=1773956571; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DOtRmPU59pcEVq53EWNPtwK9vnHX/kwmOFgeMq+s5vQ=;
        b=hU82wD5A3SMMxSH4tspkHc4NwvdCXGfwhsfAaHJfJoXb/8zVQTb/3rZUpSOHRkfP2l
         pq68vkUT2p3oWqQVzq6ptW7QLe59RjGZYelY3rSDq4htvXEVu/6cWlrpyHmz6JHXVWn5
         CTNrtbRpUofD+6vg8NwDzTjdP0eB8Fk4YZhoAKIjj8gwGG5QjAeoWX7S7o8FULs9eLqT
         aQM6H/0GP0Q5IFpm0K8HEDbKJyYa6IBV5JG9Y0E1wR9Ddsfrs/dwMJrCkY5LmMEEHvXY
         6pWOU+x+3dujzPdCvNJbrnDOlpxZJ91NnfHonOn2AK6bTH8sOSwjo9hJcmt1H1pO+rsA
         EdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773351771; x=1773956571;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOtRmPU59pcEVq53EWNPtwK9vnHX/kwmOFgeMq+s5vQ=;
        b=DKvNRAUvwbIK6XICmQE0MecG0FFjwk4Cm6aul56lqKY/gr+IHIPNXgOKOcGCLeg4dN
         TOKu0RA8tLaBTdSsJ0IygIjd1ugc/bsWjLW9v1q2ocEJwMP3auxZo2OLhVk/W8nZWNGH
         bTAXPGMLHtYzWLIZmAQOKw8T5+ZiqKRUs3Gb+tJ0PSbnIxxLIVY0hvwMCxSXpYqhI33r
         9W75vkbNyB0hZv+8Ir3rN1EVhKEVSRW9hH6sTPI+6+/qbQzCEKeDjOct0lHhfsTZfVrw
         E96pj/w52scisBW2YwiAgVeMjv/qUeRQXrFTec+K37Vbh5FAEBP/tQkJDmiJxJPEet4Z
         5xjw==
X-Gm-Message-State: AOJu0YwZhYeNdLU485EIzlr6Yn7jg9eZFgSrqsvhNTq/mF1529lB3BxH
	2g+ksiDSt+Kf3BYFja3Msthkv+fgf4yf2onUIt87paWzRSE9yJ/ebBtT01SOHpiuv1DThERU1eD
	opL+yrPyp/9ugLoUFp1Jg1phheMXYN4AuazzAhdZvVY4QZmQ=
X-Gm-Gg: ATEYQzyc4pDw5E3cl7XJ5TBDw6LtcKykR/meHuKLJOiYg0hcH+7cKW0+CG+ABgrGj3h
	N/FKCya9a1wl5tLAgW04obchyWPT7zJDiBCh90EvaaCKCmiRSU8xVQoJclpjkFMq0+juVDixnBE
	ePsZNKmN6SK6vqKoc+N7OsfVxu0jerF4ul3OVmgX4t+o78Fak04Ats3JavtAyiZ61xcWmMU2uCM
	FSU1KvbtFw+axzeXMrC1RcpGIZv0y7M5FRVyzBWmFuuQxnDhHwID9qKXhIJh79iH3h8eT05LRlI
	20YjWh5aNKm8t83l7MaB2NMJd28aizD12G+K
X-Received: by 2002:a05:6870:47a5:b0:414:e37a:9b80 with SMTP id
 586e51a60fabf-417b9442986mr494414fac.45.1773351771023; Thu, 12 Mar 2026
 14:42:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <1e96af437fa24674b353ddb530b2d8e7@realtek.com> <CALdGYqQb=Vt0jjqW7k8RGMV1gczL0cg-26cHgCm3MmzBjezGMQ@mail.gmail.com>
 <792645eed36041f0b3df951f1b28a08a@realtek.com> <e6720993c8c14245981432cfa4ae902b@realtek.com>
 <CALdGYqQn8GGXXjZTsL+a5Mfdmw5HRYB2Jyvqq5M5SUwxK9yd_g@mail.gmail.com>
 <CALdGYqQee1sjgdBAPJSyb1gL6ksK4z8Uw_v3ANTnyXE+LXFAiA@mail.gmail.com> <458ed80e39734ea99610050140bb31ce@realtek.com>
In-Reply-To: <458ed80e39734ea99610050140bb31ce@realtek.com>
From: LB F <goainwo@gmail.com>
Date: Thu, 12 Mar 2026 23:42:14 +0200
X-Gm-Features: AaiRm52mMXYk7foPxz6NJ6ZFu8IWiEZZVW2UhxvsEa4grEBCDYez1BanPB-pKe4
Message-ID: <CALdGYqQykO9ZzO=-+D17R_8LC=Win5nGN6-9zFqChtNEyUzEfg@mail.gmail.com>
Subject: Re: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33168-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: A48B527A212
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ping-Ke Shih <pkshih@realtek.com> wrote:
> I'm really not sure how/why kernel becomes frozen. As I mentioned before
> it might because of received malformed data and no complete validation
> before reporting RX packet to mac80211.
> Not sure if you can try to dig and add some validation?

I reviewed both rx.c and pci.c in detail and found a genuine validation
gap specific to the 8821CE chip.

In rtw_pci_rx_napi() (pci.c), the RX path allocates a new skb based
on the pkt_len field from the RX descriptor:

  new_len = pkt_stat.pkt_len + pkt_offset;
  new = dev_alloc_skb(new_len);
  skb_put_data(new, skb->data, new_len);
  /* ... */
  skb_pull(new, pkt_offset);
  ieee80211_rx_napi(rtwdev->hw, NULL, new, napi);

If pkt_stat.pkt_len is zero, new_len equals pkt_offset, skb_put_data
copies only the descriptor header, and skb_pull then removes that header
-- leaving an empty skb (len=0) that is passed unconditionally to
ieee80211_rx_napi() with no length guard.

Protection already exists for the 8703B chip in rtw_rx_fill_rx_status():

  if (rtwdev->chip->id == RTW_CHIP_TYPE_8703B && pkt_stat->pkt_len == 0) {
      rx_status->flag |= RX_FLAG_NO_PSDU;
      rtw_dbg(rtwdev, RTW_DBG_RX, "zero length packet");
  }

No equivalent check exists for RTW_CHIP_TYPE_8821CE. Removing the
chip-id restriction would be a minimal, safe fix for all chips:

--- a/rx.c
+++ b/rx.c
-  if (rtwdev->chip->id == RTW_CHIP_TYPE_8703B && pkt_stat->pkt_len == 0) {
+  if (pkt_stat->pkt_len == 0) {

I also checked PHY-level error counters from debugfs during normal
operation (phy_info):

  OFDM cnt (ok, err) = (867,  11)  ->   1.3% PHY CRC error rate
  VHT  cnt (ok, err) = (267,  32)  ->  10.7% PHY CRC error rate

Frames with crc_err are passed to mac80211 with RX_FLAG_FAILED_FCS_CRC
set (not dropped by the driver), which is the correct approach.

However, I do not believe the freeze is caused by malformed RX data.
The freeze occurs deterministically about 10 seconds after the system
becomes fully idle with zero active network traffic, which matches the
LPS_DEEP_MODE_LCLK entry sequence rather than a random data corruption
pattern. The freeze behaviour also disappears entirely when ASPM L1 is
disabled (as confirmed by the Live USB logs I provided earlier), which
is the hallmark of a PCIe bus gating deadlock, not a data path issue.

> Are the 'h2c' timeout messages flooding? or appears periodically? Does it
> really affect connection stable?

The errors appear periodically in bursts during idle; network
connectivity is never affected (parallel ping tests show 0% packet
loss). The flooding documented in previous tests (hundreds per minute)
was observed under conditions where the LPS state machine had reached
a persistent failure mode after extended uptime. In shorter tests from
a fresh module load, the errors are sporadic (3-5 per 10 minutes).

> If you change another AP or connection on 5GHz band, does the messages
> still present?

Yes. The issue has persisted for 2 years across 3 completely different
Access Points. It is reproducible on 5GHz only (2.4GHz is disabled on
all my networks).

> I think it isn't easy to find out the cause without measuring hardware
> signals, since I saw the message very very rare. So, I'd adopt your
> suggestion (dynamic LPS_DEEP_MODE_NONE) if the test is positive.

The test is definitively positive.

Test environment: stock CachyOS 6.19.6 kernel, PCIe ASPM L1 confirmed
ENABLED via lspci ('LnkCtl: ASPM L1 Enabled'), no out-of-tree patches.
The rtw88 module stack was fully reloaded (including rtw88_core) for
each scenario. The disable_lps_deep parameter, which belongs to
rtw88_core, was verified via /sys/module/rtw88_core/parameters/
before and after each reload.

Test protocol: after module reload and Wi-Fi reconnect (verified via
HTTP 204 check), a 5-minute warm-up period elapsed before the
5-minute measurement window began. This ensures the firmware's LPS
state machine has fully initialised before results are recorded.

Methodology verified: 'modprobe -r rtw88_8821ce' removes only the
chip-specific modules, leaving rtw88_core in memory. The correct
procedure used was to explicitly also remove rtw88_core, then reload
all modules with the desired parameter.

Results (battery power, true idle each):

  disable_lps_deep=N (DEFAULT):
    Warm-up (5 min cumulative):  h2c=4   lps=0
    Measurement (5 min):         h2c=0   lps=0  [errors are bursty]

  disable_lps_deep=Y (CONFIRMED via sysfs):
    Warm-up (5 min cumulative):  h2c=0   lps=0
    Measurement (5 min):         h2c=0   lps=0
    ALL 10 minutes:              h2c=0

With disable_lps_deep=Y, not a single h2c timeout was recorded across
the entire 10-minute observation window (warm-up + measurement). With
disable_lps_deep=N, errors appeared within the first 5 minutes of idle.
Setting disable_lps_deep=Y completely eliminates the firmware timeout
loop, confirming that the root cause is the firmware attempting
LPS_DEEP_MODE_LCLK while PCIe constraints prevent it from completing.

Dynamic LPS_DEEP_MODE_NONE for the ASPM DMI quirk entry is the correct
and complete architectural solution.

--- Technical Appendix: RX Validation Audit Findings ---

I performed a deep audit of the RX descriptor parsing logic in rx.c and pci.c.
I found two concrete areas where validation is incomplete for the 8821CE:

1. Out-of-Bounds Read in rtw_pci_rx_napi (pci.c):
The DMA buffer size is fixed at ~11.5KB (RTK_PCI_RX_BUF_SIZE).
However, the hardware
descriptor (W0_PKT_LEN) is 14 bits, allowing it to indicate up to 16KB.
The driver calculates new_len = pkt_stat.pkt_len + pkt_offset and calls
skb_put_data(new, skb->data, new_len) without checking if new_len exceeds the
DMA source buffer. If hardware sends a malformed large length, this leads
to an OOB read of adjacent memory.

2. Missing 8821CE guard in rtw_rx_fill_rx_status (rx.c):
The check for pkt_len == 0 (which results in an empty SKB being passed
to mac80211)
is manually restricted to RTW_CHIP_TYPE_8703B:
  if (rtwdev->chip->id == RTW_CHIP_TYPE_8703B && pkt_stat->pkt_len == 0)

Expanding this guard to all chips (or specifically 8821CE) would be safer.

While these vulnerabilities exist, I still believe the freeze is
PCIe-timing related
(LCLK entry/ASPM conflict), as no RX-related warnings or memory corruption
traces were found in dmesg prior to the hard freeze.

Best regards,
Oleksandr Havrylov

