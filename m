Return-Path: <linux-wireless+bounces-37149-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IPDH+PxGWoX0AgAu9opvQ
	(envelope-from <linux-wireless+bounces-37149-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 22:06:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B016083A2
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 22:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72567303E582
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 20:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B891C44D68D;
	Fri, 29 May 2026 20:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVTgFGFP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA8D409629;
	Fri, 29 May 2026 20:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084876; cv=none; b=l0IZqq60tdg/knf3GUseGHuYlVgnKyY6oz7iCLskYrE4qzUy+bxGuqGUWVcuv6lrnKCOmDFZhOUiby4pRzis1BVmwliOfbpU/mr4gHRDgUeEHe0eENuDfQFuimf8gJTkSrgZbsi7nsjverldDmo41oa+zxzgfL6IYHibPep01Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084876; c=relaxed/simple;
	bh=XLitJgpfGmRutMPFJzOM1pjEY3gn7ksLn0f7TeCcaaM=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=JttogS4UNe/SvCk/mQwXAJ9uSC7WVY2xV2TXxyakThDOFFCbOJQ7ocqFowIclq7OCOrAzKbiu8s25U6GNNAyEmsEokCfyDeGjMBYdut9iMe0tSVOb3sMzIwjgowuNntqBWTAsaiWEP0TkmAKmuZytDcrZXwdbe6FYDYUEGk4Egc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVTgFGFP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3F41F00893;
	Fri, 29 May 2026 20:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780084875;
	bh=LhRFAgSNvBh+ZqD31SHVs+HFkLsPpwGrlWZRmKcDpmg=;
	h=Date:From:To:Cc:Subject:References;
	b=hVTgFGFPlkC2+XDoaYA6/zfeQRv0hlPIcTW4ASFNt+kqI/ihcbO1x/hvzTXVQQTyv
	 uZ1Nuzx5nAypR5GKmnDHxW/sznpSPcbTrXP8122glU7mQkjvN0+1lah4NbhqtkvKAS
	 BPc7pH9yFRKEDiJqpUVrLwFJmorg6hI2KzGJVyTSuEWkVYU1WXTdhihbd03ICWdiHu
	 j9qjL/uv+NDRjCEiJYlDFdNNNh50WHE7tReNtm1Y8oIy8ZjzvBN/SNIEzYQguIZUty
	 JyU/rEqXTT7827J/9FWoIOT9G07NYNG38vc+0R9Gi+0qFykcVxuaboHOpImytrOzG6
	 REHFmH5t+M6XA==
Date: Fri, 29 May 2026 22:01:13 +0200
Message-ID: <20260529195557.995298795@kernel.org>
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
Subject: [patch V2 21/25] ALSA: hda/common: Use
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37149-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,enneenne.com,linux.dev,lists.linux.dev,gmail.com,vger.kernel.org,suse.com,intel.com,nvidia.com,oss.qualcomm.com,amazon.co.uk];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,amazon.co.uk:email]
X-Rspamd-Queue-Id: 19B016083A2
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
 sound/hda/common/controller.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
--- a/sound/hda/common/controller.c
+++ b/sound/hda/common/controller.c
@@ -525,7 +525,7 @@ static int azx_get_time_info(struct snd_
 			break;
 
 		default:
-			*system_ts = ktime_to_timespec64(xtstamp.sys_realtime);
+			*system_ts = ktime_to_timespec64(xtstamp.sys_systime);
 			break;
 
 		}




