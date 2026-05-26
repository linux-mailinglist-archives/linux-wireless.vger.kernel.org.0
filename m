Return-Path: <linux-wireless+bounces-36904-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JFoIDTaFWpYdAcAu9opvQ
	(envelope-from <linux-wireless+bounces-36904-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 19:36:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A695DAC5D
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 19:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDEFA3112256
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 17:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F215409E1B;
	Tue, 26 May 2026 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiWLiWZE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E391402B99;
	Tue, 26 May 2026 17:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815617; cv=none; b=m/4/WuTYixawuyi82iorDuVSNcDgLesARXYaV7BikSHHwCezRcvfzIPGURW4wIzqIG+f/xdfZWIhI68h0BXmIh21/3+lFsiiNYLHLImIvt+UhMaIFNEx5WVfDznTp+0ZILinmjxYVB5qYs1ojwPKK+yf6nTmCC1tNL7w78BtxSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815617; c=relaxed/simple;
	bh=T3aDw62QgaJPdgPM5fyZHuVaFNW6CtrC1JugliHQVUs=;
	h=Date:Message-ID:From:To:Cc:Subject; b=HFSitilLK0njWQptKVkOmgc4GCdicqfhj/RZ00L0WLrRm1hYaofrHYg2C+oLGWja5Bv6lb+lbdNbVppFuabqF91ztvcFVMkbNa3Vt5sizZ1Crrk7D4m3zoaji87OB/RVUP3S20n9PUN/bB4CFOeH4g5lmsdzC0vPsh/6qBo/1Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiWLiWZE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4B2B11F000E9;
	Tue, 26 May 2026 17:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779815612;
	bh=Uy0V1zhnjEjksxlqK8ls+jYCj1jGvamk9ZvvNPf1nY4=;
	h=Date:From:To:Cc:Subject;
	b=TiWLiWZE0n1A9A/fwtyZiNaNpQBWAAJ/UBJvVPCBqTE2D304Iz5VwpS2AF8RpdCp5
	 qoy7pa44RDYgc0smqnZ26PP3Ty9o2Gp5u88IMsmAlfiJfEjFZtAJpuzhNsHJI+ZREE
	 O0Sw+gLWIj/U8wOmdjYTgqE8ReyfcJiNqtfSMUNVmIUdO3qhQuhnlVyNLNf7tYQELt
	 BlXx+3mNneoPULh81Wg3tUrg+4XrIp1dilB9E1XbM/XKDmrjOU/A0+iUWGRhYfQghi
	 KSzrl4SIh1MoXTcZnck4++4+fCygZn8hi0t5JX3OOO1TFwFMVPoClzHpB1KRPWzJX0
	 FHzHJLfhQUuig==
Date: Tue, 26 May 2026 19:13:28 +0200
Message-ID: <20260526165826.392227559@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
 Miroslav Lichvar <mlichvar@redhat.com>,
 John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 thomas.weissschuh@linutronix.de,
 Arthur Kiyanovski <akiyano@amazon.com>,
 Rodolfo Giometti <giometti@enneenne.com>,
 Vincent Donnefort <vdonnefort@google.com>,
 Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>,
 kvmarm@lists.linux.dev,
 Oliver Upton <oupton@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Johannes Berg <johannes.berg@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Peter Hilber <peter.hilber@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux.dev,
 linux-wireless@vger.kernel.org,
 linux-sound@vger.kernel.org
Subject: [patch 00/24] timekeeping/ptp: Expand snapshot functionality
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	TAGGED_FROM(0.00)[bounces-36904-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,enneenne.com,linux.dev,lists.linux.dev,gmail.com,vger.kernel.org,suse.com,intel.com,nvidia.com,oss.qualcomm.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E0A695DAC5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sorry for the large CC list, but changing the inner workings touches
unfortunately a lot of places in one go.

PTP wants to grow new snapshot functionality, which provides not only the
captured CLOCK* values, but also the underlying clocksource counter value.

   https://lore.kernel.org/20260515164033.6403-1-akiyano@amazon.com

There was quite some discussion in seemingly related threads how to capture
these values and how to provide core infrastructure so that driver writers
have something to work with

   https://lore.kernel.org/20260514225842.110706-1-hramamurthy@google.com
   https://lore.kernel.org/20260520135207.37826-1-dwmw2@infradead.org

This series implements the timekeeping related mechanisms to:

     1) Capture CLOCK values along with the clocksource counter value for
     	non-hardware based sampling

     2) Expanding the hardware cross time stamp mechanism to hand back the
     	clocksource counter value, which was captured by the device, along
     	with the related CLOCK values

     3) Adding AUX clock support to the hardware cross timestamping core

It's based on v7.1-rc2 and also available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git timekeeping-ptp-extend-v1

Thanks to David for rebasing his PTP/timekeeping work on top and providing
feedback, fixes and testing.

Thanks,

	tglx
---
 arch/arm64/kvm/hyp_trace.c                          |    8 
 arch/arm64/kvm/hypercalls.c                         |    6 
 drivers/net/dsa/sja1105/sja1105_main.c              |    8 
 drivers/net/ethernet/intel/ice/ice_ptp.c            |    5 
 drivers/net/ethernet/intel/igc/igc.h                |    1 
 drivers/net/ethernet/intel/igc/igc_ptp.c            |    4 
 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c |    4 
 drivers/net/wireless/intel/iwlwifi/mld/ptp.c        |    5 
 drivers/net/wireless/intel/iwlwifi/mvm/ptp.c        |    7 
 drivers/pps/generators/pps_gen-dummy.c              |    6 
 drivers/pps/generators/pps_gen_tio.c                |    6 
 drivers/ptp/ptp_chardev.c                           |   18 +
 drivers/ptp/ptp_ocp.c                               |   11 -
 drivers/ptp/ptp_vmclock.c                           |   25 --
 drivers/virtio/virtio_rtc_ptp.c                     |    2 
 include/linux/pps_kernel.h                          |    8 
 include/linux/ptp_clock_kernel.h                    |   15 -
 include/linux/timekeeping.h                         |   54 ++---
 kernel/time/timekeeping.c                           |  211 ++++++++++++--------
 sound/hda/common/controller.c                       |    4 
 20 files changed, 236 insertions(+), 172 deletions(-)

