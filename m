Return-Path: <linux-wireless+bounces-38840-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dIEPAKODUGrX0QIAu9opvQ
	(envelope-from <linux-wireless+bounces-38840-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 07:31:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8294737581
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 07:31:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="eu05mGS/";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38840-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38840-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BEA593002F64
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 05:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F13366823;
	Fri, 10 Jul 2026 05:31:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129C6379C29
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jul 2026 05:31:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783661469; cv=none; b=YlVNN/utFYEBfXlzRcsJbwBFBVFBcnUqutqVcQliaxewuFxW0ZEwtqS2g4/lQHfTmlKxTJzD156UvDpXYROIbuPf5TwVT+PJShdF1nC/5hPyGHWKy3FNEqNygzpaXcfS+wbRPH3p0IV4WejI4B3iTPBzvvuPcVRyfThUNgy6/Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783661469; c=relaxed/simple;
	bh=HsaOXp3Gbc/tyE4LAuh9TAFbXeHBRMHcFLFSNwhuGnk=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=B4I6aOnzUvk6C4bYQm7zDki/eH1hFfGUR1IATzPuT1oXuemJVDgkOX+bhgomepSE4ZFrDycj15QfToA6Gt6IjVfGl4Kf6koKPBahInip/BVw4K1E8+oe7yayw18D+DOEloUNTevFMMnRh0yIvdGUKEdJO/jjwVZtcjVx06Nzu0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eu05mGS/; arc=none smtp.client-ip=209.85.221.44
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-472326ca506so370611f8f.2
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jul 2026 22:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783661466; x=1784266266; darn=vger.kernel.org;
        h=content-type:mime-version:subject:cc:to:from:message-id:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hziWzN2b1CW2nGJylmIy7Hz070WbBDjNrgzOZWpihy4=;
        b=eu05mGS/mlY5bjVzNpyR+Jo065qE5L48Fo4RDx19lTMOPc1FVAGDm2lrwPMMQEnEK0
         ctHbB+agpbIouPWgAGt7/pX/fgNCR/+T7SZ1fbyEYJt3Kh57bqI2N5fIcz1ZIwCRvemW
         GPnYcIFD4qf1rGYN3pHj7zfCeStGMQPJk0aqevVqxrFilCMWEIZeq6GTV8M7y8Kej81n
         r7a2kg1uuUQ8WR5DTcHWlTqJsStz4P3okRhYZrNuTujwdEApvwExL4tE28N3vJ/tkKeR
         zXssBhywLKur0TqJmiNp/qLiG+fRcVcLQxRgO/T3nfPsPl+oH1c28I7Z93hSLPzLKibu
         d73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783661466; x=1784266266;
        h=content-type:mime-version:subject:cc:to:from:message-id:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hziWzN2b1CW2nGJylmIy7Hz070WbBDjNrgzOZWpihy4=;
        b=LR+5T8C4Nh9dqk1gmdawy16g2/rdI+fjfnkDoPW/tK0JxUNUXrdFW5aOKlf/VFNAyL
         imSY51hMt2YY9ADJfplzKy35Ngx//Fqehtok3cIapzpeB1z2i7OaoQUkGL+BVY3cwtQF
         j6F4rYKJ13GAhJJrCEV9QQqXfVbQajxoSINZjcf7hoIUWBfT7U6fRwr8/KR1JEmK/B1L
         q3dR6j6iXZg/kV6dKSjZKgqwHLZudF80T2bqgU2VIjQ23yEQBFl0ULhwqR1dDlnNMT4B
         eELVEoXP5bzZr5PzkuWB6MUgd3cp/l1ejchQGxPoP/+iT4eODzwmhNolmgsO//l3gSIX
         Qm6Q==
X-Gm-Message-State: AOJu0Yy6poxjKsAu9BO0KflXV8nlU6+sUGcbyF9os2Qycj9ZxhEilHSV
	wbnq9qs0Apn0ILpaVjWh2xBcqPxLBRa+h+2eNDUW+jDYjplBsVyDI5F2
X-Gm-Gg: AfdE7ckjj+Xxtxjtyp16e6roF1GdBx/hRbMT/c7mSXxVBgPeTP/nCvzkcDz8QK6B2RF
	LdwOS+q/fEpxLSCNdimcHGxPKlkdoL76JnXIbCHri+gQsll6slR44yEPpt3jTZoDYjZWBngjCos
	GzAkJIQpmm6AIvwb44L//ZelJ+z+wsnxYsQnnAm5yrGlhr+SN7WIy3/WTobvKceDJX0JG61EQg7
	EUSViKDDBVd9W9JyVM7Q9WCTN6yiEIuy3c/88OTrRK5QRpqbCU8cxpLUwLodVK+w7s879ht3Lt9
	tKyw1bpfrAPpCfNZeAoABVv7sNtItKC2g4pT9QbEhNBSYm5UWVb8ystSxTW1/bGrSaOkIS1lTPB
	0ps5joqRSKweQWfRgu7yUV9byuQMV/uItKPkeTWT4H8KgCbo+X8AXLnfyKb1HP7mCo84TPHoHRh
	IaSkD+jBHSL3QIpb/SKRL/t0OoftJclsXp6iPb
X-Received: by 2002:a05:6000:2dca:b0:47d:e01c:c28 with SMTP id ffacd0b85a97d-47df076a672mr10417167f8f.36.1783661465998;
        Thu, 09 Jul 2026 22:31:05 -0700 (PDT)
Received: from localhost ([102.128.173.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039afacsm54554612f8f.19.2026.07.09.22.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 22:31:05 -0700 (PDT)
Date: Fri, 10 Jul 2026 07:31:02 +0200
Message-ID: <d40613782874b5dbca1042257922c3e1@gmail.com>
From: Louis Kotze <loukot@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, Bitterblue Smith <rtl8821cerfe2@gmail.com>, loukot@gmail.com
Subject: rtw89: 8922a hw_scan on an MLO association blacks out traffic ~3 s per scan (45-62% loss under load, AP kicks STA with DISASSOC_LOW_ACK)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-38840-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:rtl8821cerfe2@gmail.com,m:loukot@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[loukot@gmail.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loukot@gmail.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D8294737581

Hi Ping-Ke,

On an RTL8922AU station associated to a Wi-Fi 7 AP MLD, every full
hw_scan takes the link off-channel for about 3.3 s essentially
contiguously, with roughly 2 s of completely dead downlink per scan.
Under moderate load with a periodic background scan this costs 45-62%
of the traffic, and the AP sometimes deauthenticates the station with
reason 34 (DISASSOC_LOW_ACK) a few seconds into the first scan. The
same client and the same scan are fine on a non-MLO association, and
an Intel client is fine on the same AP MLD, so the failure needs the
rtw89 + MLO combination. Evidence below; I can provide full captures.

Environment
-----------

- RTL8922AU (USB 0bda:8912), firmware 0.35.80.3 (8ef4f0cf), cmd
  version 1, rtw8922a_fw-4.bin from linux-firmware 20260622.
- Driver: rtw89 out-of-tree USB snapshot r1868 (morrownr; the
  scan-offload H2C code matches current wireless-next). Kernel 7.1.3.
- AP: TP-Link Deco BE65 v2 (Qualcomm), EHT AP MLD, 5+6 GHz.
- Association: EHT160, tested both single-link (5 GHz) and EMLSR
  dual-link (5+6 GHz anchor on 6 GHz). Same behavior.
- Test: iperf3 UDP downlink to the STA, full "iw dev wlan0 scan
  trigger" every 5-8 s, loss measured at the STA; AP-side per-station
  tx_errors read from the AP where available.

The differential (three-way control, 2026-06-19 campaign)
---------------------------------------------------------

Identical 100 Mbit/s downlink + full scan every 5 s, 60 s per cell:

- rtw89 on the AP MLD (EHT160):     62.3% loss (repeats 60.4, 61.8),
                                    AP tx_errors +282k, ~2 s dead
                                    downlink on EVERY one of 12 scans.
- Intel AX210 on the SAME AP MLD,
  same channel, same test:          3.5% loss, tx_errors +4.7k,
                                    0 dead seconds.
- Same rtw89 client on a non-MLO
  AP (Archer AX20, HE80), same
  driver and scan:                  5.0% loss, no blackout.

- No-scan controls on all cells:    ~0% loss.
- A short scan (single channel, or
  8 non-DFS 5 GHz channels) on the
  AP MLD link:                      4.9-6.9% loss, 0 dead seconds.

So off-channel DURATION is the driver: the full-scan ~3.3 s excursion
is what kills the link, and only on the MLO association. The loss is
direction-symmetric (uplink also loses ~62%, with AP tx_errors not
moving, so this is not just an AP buffering question; the station is
simply away too long in one stretch).

Still present on current firmware (2026-07-10)
----------------------------------------------

Re-ran on fw 0.35.80.3 / driver r1868 / EMLSR dual-link, 18 Mbit/s
downlink, full scan every 8 s, 40 s:

- Control (no scans):  0.0% loss.
- Run 1:               27.2% loss, and the AP deauthenticated the
                       station with reason 34 (DISASSOC_LOW_ACK)
                       about 3 s into the first scan.
- Run 2:               45.3% loss across 5 scans.

Why this looks like a firmware scan-scheduling issue on MLO
-----------------------------------------------------------

The BE scan-offload design should protect an associated link: the
driver requests opmode=RTW89_SCAN_OPMODE_INTV with an op-channel
revisit interval, num_opch=1 and txnull=1, and I confirmed with an
instrumented H2C builder that this is armed with the correct link
BSSID. RTW89_OFF_CHAN_TIME should cap contiguous off-channel time at
about 100 ms. The C2H LEAVE/ENTER notifications do arrive at the
driver during the scan. Yet the observed result on the MLO
association is a ~3.3 s contiguous blackout per scan, as if the
op-channel revisits do not give the link usable airtime.

Two more over-the-air observations (AX210 in monitor mode):

- The station's PM=1 nullfuncs are visible and roughly double during
  scan periods, so PM signaling is not absent. But the AP sets TIM
  for this station in only ~59 of ~624 beacons during the test,
  versus ~98 of ~632 for the AX210 under the same load, and its
  tx_errors climb throughout: the doze windows evidently do not
  line up with the actual off-channel excursions.
- As an experiment I had the driver send an additional PM=1 nullfunc
  at each LEAVE_OP and PM=0 at ENTER_OP: downlink loss dropped from
  ~37% to 0% and the AP buffered correctly. Not a viable fix (it
  fights the firmware's own scan-time PM handling and eventually
  destabilizes the connection), but it shows well-timed PM framing
  fully protects the downlink on this AP.

Questions for the firmware team
-------------------------------

1. On an MLO/EMLSR association, does the BE scan-offload firmware
   actually perform the periodic op-channel revisit (INTV opmode)
   during a full multi-band scan, or does it batch the whole scan as
   one long excursion?
2. Is the per-excursion txnull PM frame sent at the right time and
   on the right link for an MLD association (and with the associated
   link address)?
3. Is there anything the driver should be doing differently for MLO
   scans (splitting the channel list, different opch policy) that
   would bound the off-channel time?

Practical impact: any periodic background scan (wpa_supplicant or
NetworkManager bgscan, roaming scans) triggers this; on APs with an
aggressive low-ack policy it escalates to the AP kicking the station
mid-scan.

I am happy to share the full capture campaign (client iperf3 JSON,
monitor-mode pcaps, AP-side tx_errors series, per-second traces), the
H2C instrumentation patch, and to test debug firmware or patches on
this setup.

Best regards,
Louis Kotze

