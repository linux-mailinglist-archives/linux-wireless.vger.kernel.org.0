Return-Path: <linux-wireless+bounces-37148-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIkEGp7yGWp10AgAu9opvQ
	(envelope-from <linux-wireless+bounces-37148-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 22:10:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0735960845F
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 22:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4852C314B326
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 20:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B4142847B;
	Fri, 29 May 2026 20:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2avko+1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF35A409629;
	Fri, 29 May 2026 20:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084872; cv=none; b=bf6L/LW8Bt4idMaOESnqtwKYPIAMjP/ugzfo19RDMPZ6vpdkn+J768ObA/rJ8nKly+ON80IpMIkiaVeTM+SPhq0RUIqpqlWCWZ6Ri6BD6uAbHWyJ2DAuQW/AVc2Orx1EmL+IR/hjWeN24qje+FRMUGDTo/s8SRSyNtrrrGSdfUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084872; c=relaxed/simple;
	bh=XSyy51MuZwA2GjVtTQbHBowdU707Ss5reS13iwms0Sw=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=kuazOMCziPo6vGB5/N/JH8KB2amuLMufLT+Ac//mpfde6YdmIX1aePTgZTHI9Arbrkry66dGNiXo71f27lWcO23k7inFwAnDi3BM7E06cSiIH0c7+EiwETeaL6gOllQsJYFBWqnUQHj7ayPP2Q1cjbgochvmhTQ3+tGPNkxT7aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2avko+1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6651F00893;
	Fri, 29 May 2026 20:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780084871;
	bh=qPFPr4UR6sdCcQ981+CAww5bj9pIWXC4SGPJ5TkTsVY=;
	h=Date:From:To:Cc:Subject:References;
	b=Y2avko+1fxxxpz9mcN2IFv7Nw/HV9AK4H7h4peMrZZ0SjSi/5US4CFD40q/21HYDR
	 Hrhla9+4wIUiq69olMtnFhhuVc6JH7uLoY1/EI9x98BGtCtVRnnpPn/D8XMel0fzUi
	 ahZiwVnyQacSRDheM9iVXwthal1CisbYrp96BLftVfq3tzfiHP4nn0ektpku2NBEEU
	 JsFqyJh4k8/iz6BapEARbrcblT/3ghLIANJ8E2vaqz4gcZGG3FNRY7JZ9Q+suh8oF3
	 jRO4E92RpsCZlwiSMsWq70zMnGksbg0u/tnJN1PczCX6EN0IfnQSWt5mFXFs3xKiIM
	 IBINiO6GpcNvA==
Date: Fri, 29 May 2026 22:01:09 +0200
Message-ID: <20260529195557.946612509@kernel.org>
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
Subject: [patch V2 20/25] wifi: iwlwifi: Use
 system_device_crosststamp::sys_systime
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
	TAGGED_FROM(0.00)[bounces-37148-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 0735960845F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thomas Gleixner <tglx@kernel.org>

sys_systime is an alias for sys_realtime. The latter will be removed so
switch the code over to the new naming scheme.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: Arthur Kiyanovski <akiyano@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/ptp.c |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ptp.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
--- a/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
@@ -271,7 +271,7 @@ iwl_mld_phc_get_crosstimestamp(struct pt
 
 	/* System monotonic raw time is not used */
 	xtstamp->device = ns_to_ktime(gp2_ns);
-	xtstamp->sys_realtime = sys_time;
+	xtstamp->sys_systime = sys_time;
 
 	return ret;
 }
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
@@ -185,7 +185,7 @@ iwl_mvm_phc_get_crosstimestamp(struct pt
 
 	/* System monotonic raw time is not used */
 	xtstamp->device = (ktime_t)gp2_ns;
-	xtstamp->sys_realtime = sys_time;
+	xtstamp->sys_systime = sys_time;
 
 out:
 	mutex_unlock(&mvm->mutex);




