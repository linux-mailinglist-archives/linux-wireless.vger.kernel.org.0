Return-Path: <linux-wireless+bounces-37140-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APkNKyDyGWpl0AgAu9opvQ
	(envelope-from <linux-wireless+bounces-37140-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 22:08:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 702D06083E4
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 22:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E03730611A2
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 20:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5E63B0AE1;
	Fri, 29 May 2026 20:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsH5kdL5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3263D2771B;
	Fri, 29 May 2026 20:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084840; cv=none; b=Y4vl4bpXBRbZ/0BVtwbjtyj+0VfIfa0LkMnjmMlqWewFLPRHkc9cbRGHdbfItXx+96acYfSYNj/IreBn15Tk6HyxAz4N+dm885FC+vnxqVb66IyTfFDDKfpOlpVz4zqgQ613RBCm+hOgPKeTBOrl6Bd+HwPcWKQI/24dzRcxTCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084840; c=relaxed/simple;
	bh=2aXWzPzNzd2NCIogDsWygVizy8ue3Nyysy1+INo+kow=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=nEKbJhDthu7ps0ARkRj1Pl/TgpbTlmAPIceXYLK82E+rbjW9+ms8hmzWypbwWPNAQpd2QHlMviOuHeZUnqdAnLBe21P2z5KVcqnVnkXxa4ZiBdrroUPwQzEOf7NEnqLNDxGNr9LGjJPscO7ocdbLtRAxz9eIeXU2HiSBK9WwF7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsH5kdL5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A221F00893;
	Fri, 29 May 2026 20:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780084839;
	bh=F1/ehgTNHxWvIPIuJRlhZs5X/XHWu+J4Hrpk2VF31vs=;
	h=Date:From:To:Cc:Subject:References;
	b=YsH5kdL5X64aHcR0awQT0o5oVy/aVFd0GPvzZYs/EgvcGWq864jE0TplPfxutQY3l
	 hxSWPjvvaxsEBT126oCgCH/0TqTGhiWrlfhsLY/ocm1AcdKBLu6EjE79SvbG8K2tPO
	 Rynq/bmX35Ny3cD66hfL089tsVhqnUmJrAoJpmfg3fAIYSYjJ0pJZh5zMpSSX/Im9K
	 Duk7xFUnYyuWkeV7mnvaGXURd+DJFTW9ob94kkjQ8YBjBvyTWXyNXfn5utaATEYYip
	 T96eHcjd/ZAAyhkyaRYI5J4WZpuCUh+5DclvQ/clO3txImzGNQSOr4lZDZqXWxB356
	 doxw65VjX5EUw==
Date: Fri, 29 May 2026 22:00:36 +0200
Message-ID: <20260529195557.535447186@kernel.org>
User-Agent: quilt/0.69
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
 linux-sound@vger.kernel.org,
 David Woodhouse <dwmw@amazon.co.uk>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [patch V2 12/25] wifi: iwlwifi: Adopt PTP cross timestamps to core
 changes
References: <20260529193435.921555544@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37140-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,enneenne.com,linux.dev,lists.linux.dev,gmail.com,vger.kernel.org,suse.com,intel.com,nvidia.com,oss.qualcomm.com,amazon.co.uk];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,amazon.co.uk:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 702D06083E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thomas Gleixner <tglx@kernel.org>

iwlwifi only supports CLOCK_REALTIME timestamps and provides an incomplete
result without system counter values etc.

It also zeros struct system_device_crosststamp, which is already zeroed in
the core and initialized with the clock ID.

Remove the zeroing and reject any request for a clock ID other than REALTIME.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: Arthur Kiyanovski <akiyano@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/ptp.c |    3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/ptp.c |    5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)
--- a/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
@@ -250,7 +250,8 @@ iwl_mld_phc_get_crosstimestamp(struct pt
 	/* System (wall) time */
 	ktime_t sys_time;
 
-	memset(xtstamp, 0, sizeof(struct system_device_crosststamp));
+	if (xtstamp->clock_id != CLOCK_REALTIME)
+		return -ENOTSUPP;
 
 	ret = iwl_mld_get_crosstimestamp_fw(mld, &gp2, &sys_time);
 	if (ret) {
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
@@ -160,13 +160,14 @@ iwl_mvm_phc_get_crosstimestamp(struct pt
 	/* System (wall) time */
 	ktime_t sys_time;
 
-	memset(xtstamp, 0, sizeof(struct system_device_crosststamp));
-
 	if (!mvm->ptp_data.ptp_clock) {
 		IWL_ERR(mvm, "No PHC clock registered\n");
 		return -ENODEV;
 	}
 
+	if (xtstamp->clock_id != CLOCK_REALTIME)
+		return -ENOTSUPP;
+
 	mutex_lock(&mvm->mutex);
 	if (fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_SYNCED_TIME)) {
 		ret = iwl_mvm_get_crosstimestamp_fw(mvm, &gp2, &sys_time);


