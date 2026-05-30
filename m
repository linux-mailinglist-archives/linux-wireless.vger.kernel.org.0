Return-Path: <linux-wireless+bounces-37170-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNCRKT3EGmpw8QgAu9opvQ
	(envelope-from <linux-wireless+bounces-37170-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 13:04:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2C560C53D
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 13:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 02F7630187B1
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 11:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D6D3A8745;
	Sat, 30 May 2026 11:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="hF98J4lt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpcmd0757.aruba.it (smtpcmd0757.aruba.it [62.149.156.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCFB3A7590
	for <linux-wireless@vger.kernel.org>; Sat, 30 May 2026 11:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780139065; cv=none; b=CV32bqrtjDvHsTNi63lzWbvsK0tGBcUwtsPYil7IP8sa7KOFM2nlQ3BON0033weiiQwPKbpvcfbJWSKB4OS0+LJH0JXOsFw8671ngCOsRIaw7vreVCTbrYOpibwk2IVdH9F5xn5Z0VpCDRYWDQnuA0O6VOJL8Ex56uA8Mxt9sDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780139065; c=relaxed/simple;
	bh=ql10+8xRiIzQXjadTxmnZisxTkDNSdk8C5q/jqCPnEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JV2rXxOOJtBMGUZ1Ok48vV4cg0rSGRsXjLKT9/Uw9jZjU9SfKMQmLdrQmXMPm9hmJhCHqpM6K1ERdNq4Q9gb2b7DsZJ9mrtf2XEFBQ2FnPUL6PzwHyuKoNl+OqRDT/UrofdcQTLXjCFl8UQlARcuBR7aquG8bBz0LA84H4B7uKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=hF98J4lt; arc=none smtp.client-ip=62.149.156.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.0.186] ([109.118.80.246])
	by Aruba SMTP with ESMTPSA
	id THUBwvKe7tpTfTHUCwL2Xb; Sat, 30 May 2026 13:04:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1780139054; bh=ql10+8xRiIzQXjadTxmnZisxTkDNSdk8C5q/jqCPnEY=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=hF98J4lt1nU6TI38hjDN7wAYPP66gs0eVJQfVgrs0VkzBH65bs4Z04X+eqAtJ2Cpy
	 fFMQPIhRx0xJeXdXZvWhhT3uIqZcsYRSsfUIkyCyU7XclnLEBVNtOz3D5mTg6Wc/EQ
	 N86qIL/WGlwv33vGt1wq+95wpVdMV61kaeO/exL/p/mYXyav1Ip45lF+vyDU5H/VCE
	 JSlQxaUKjb50HbnEUIvvQvUDF/DHLBDJOmOzYMyhNDTn6Rf/B2lBVD7NFUyqPwH+KA
	 u4P9RbKPGW4KlUea+gJJTMpYjut46mvcCaDVEnMVwK9QZ6IOuSeJjqW4qNKJ0jdest
	 zy48G9YUqdgqQ==
Message-ID: <86b5b571-824d-40b7-924f-6e1d4bf58d8b@enneenne.com>
Date: Sat, 30 May 2026 13:04:11 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 03/25] pps: generators: Use ktime_get_real_ts64()
 instead of ktime_get_snapshot()
Content-Language: en-US
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
 Miroslav Lichvar <mlichvar@redhat.com>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, thomas.weissschuh@linutronix.de,
 Arthur Kiyanovski <akiyano@amazon.com>,
 Vincent Donnefort <vdonnefort@google.com>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev,
 Oliver Upton <oupton@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Johannes Berg <johannes.berg@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Peter Hilber <peter.hilber@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev,
 linux-wireless@vger.kernel.org, linux-sound@vger.kernel.org,
 David Woodhouse <dwmw@amazon.co.uk>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
References: <20260529193435.921555544@kernel.org>
 <20260529195557.074439049@kernel.org>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <20260529195557.074439049@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCJ4L6AvktiBiSjgdZHz6cd9G2cR3VoqAhOyLFZMlg2ukyXgpcoRDfIf42yajPI8mJBtuEmbaYcgebabmcEyNfb5V2AkY0KKGxs4D8kFPqg0j68KJE3J
 Yvxknvg3dHFQC/aKOSX5dv+Ry5tghm0g49aQk4oM0kY/Gijw5KC7j+eegpXH8Wk8XwVQVCNNkZumNpU/yUAHQw8lft/nr9CCzuIsTNcqR0HJvrOKcdj65QZM
 8rye27fAUDEUpLY6Tr89jYlsM/2wPmxhwkmbdBbUVDsYh3C9v38aAIsY4V8aFZjpKraNPFW4903gB3FtMzhAnvKS9+siK5ekieMHnN7gD6KZGQxxu7XPdtxr
 k0eEpab987THqcDO/6E2HJVt2Tk898anHlepE0cHJuuOfo3mqR+RxlLPL9oLI5RwNR1Jj86BZkC3kkkHoRuW47iSxDqCi+cCbPNR8QT+KCTW4CFOCJnVR4Yo
 Rs18jeV3qCLoamvFfGjOQOGc7UnOX3VeBJMjYOxM2kGSQL9c1lNQJ9sSJ1091rNF/HKfCkbNfdXpyvJIQp8SGhJa7hNHuAdhTu7BqYUqIoT6nBt8oLg07SVv
 +DFvG1XNqwxUC2QLYxzy/HT0RwvXLZ4b+xnuah5tQ2knl/5qMJ5JP8f/ZTnsJt4S7MhfxToAgxP6pmC1XrH38iPZp49LKrn3ZyFswbgja8wO29M5cjK71Doa
 sZgGk06o6xKfAF/v7XzrgK0p6ohngW6G+CQaKrW6hvGzZVCz+P/YuIitQAhDcbBAOn44lQ9kB3rk2PrHCqV133Nha9VjiWRAQAcqsopCelGWdQ5DVKiYGIB8
 j8RkiRITBwJz7xLLRWGPV9qUOwrRxc5cKAsMzbTCVVQU6u2LbKl87+wnNNTZcVWq3AzwuOD3dw0db67dRKSqlrn6X+YIOn3A/K+oMiO7DnYDipxB5QBu5yuM
 wVwn2KMT2JC2mDpjNz+V4shk2gKEZz8cMDC0xTZKey2ePfoHada9STI694BrUVNVrP0QGH1/ANPvccrxRMSxKRbEtCIPkXUbQs4ccndlXmrv2Eb9ouVIq3Sl
 t0MsxK6jwZvU/tiFFhBMBO5PwSkW6A1GzEcJzr5qE/Ecvlgcp/glIAIT8Lrp0gr6Bxzrtv/PLh8vrlTeuETdK1eQQfE8cvoBaqFaClotMSf2bZ4AtbSXuMXc
 e6BR2eUFWvhou56Zt0WkDA==
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[aruba.it:s=a1];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[enneenne.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37170-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,linux.dev,lists.linux.dev,gmail.com,vger.kernel.org,suse.com,intel.com,nvidia.com,oss.qualcomm.com,amazon.co.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[giometti@enneenne.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[aruba.it:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aruba.it:dkim,amazon.co.uk:email,intel.com:email,linutronix.de:email]
X-Rspamd-Queue-Id: 3A2C560C53D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 29/05/2026 21:59, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@kernel.org>
> 
> There is no reason to use the more complex ktime_get_snapshot() for
> retrieving CLOCK_REALTIME.
> 
> Just use ktime_get_real_ts64(), which avoids the extra timespec64
> conversion as a bonus.
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Tested-by: Arthur Kiyanovski <akiyano@amazon.com>
> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
> Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

> ---
>   drivers/pps/generators/pps_gen-dummy.c |    6 +-----
>   drivers/pps/generators/pps_gen_tio.c   |    6 +-----
>   2 files changed, 2 insertions(+), 10 deletions(-)
> --- a/drivers/pps/generators/pps_gen-dummy.c
> +++ b/drivers/pps/generators/pps_gen-dummy.c
> @@ -39,11 +39,7 @@ static void pps_gen_ktimer_event(struct
>   static int pps_gen_dummy_get_time(struct pps_gen_device *pps_gen,
>   					struct timespec64 *time)
>   {
> -	struct system_time_snapshot snap;
> -
> -	ktime_get_snapshot(&snap);
> -	*time = ktime_to_timespec64(snap.real);
> -
> +	ktime_get_real_ts64(time);
>   	return 0;
>   }
>   
> --- a/drivers/pps/generators/pps_gen_

From: Thomas Gleixner <tglx@kernel.org>

There is no reason to use the more complex ktime_get_snapshot() for
retrieving CLOCK_REALTIME.

Just use ktime_get_real_ts64(), which avoids the extra timespec64
conversion as a bonus.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: Arthur Kiyanovski <akiyano@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
  drivers/pps/generators/pps_gen-dummy.c |    6 +-----
  drivers/pps/generators/pps_gen_tio.c   |    6 +-----
  2 files changed, 2 insertions(+), 10 deletions(-)
--- a/drivers/pps/generators/pps_gen-dummy.c
+++ b/drivers/pps/generators/pps_gen-dummy.c
@@ -39,11 +39,7 @@ static void pps_gen_ktimer_event(struct
  static int pps_gen_dummy_get_time(struct pps_gen_device *pps_gen,
  					struct timespec64 *time)
  {
-	struct system_time_snapshot snap;
-
-	ktime_get_snapshot(&snap);
-	*time = ktime_to_timespec64(snap.real);
-
+	ktime_get_real_ts64(time);
  	return 0;
  }

--- a/drivers/pps/generators/pps_gen_tio.c
+++ b/drivers/pps/generators/pps_gen_tio.c
@@ -189,11 +189,7 @@ static int pps_tio_gen_enable(struct pps
  static int pps_tio_get_time(struct pps_gen_device *pps_gen,
  			    struct timespec64 *time)
  {
-	struct system_time_snapshot snap;
-
-	ktime_get_snapshot(&snap);
-	*time = ktime_to_timespec64(snap.real);
-
+	ktime_get_real_ts64(time);
  	return 0;
  }


tio.c
> +++ b/drivers/pps/generators/pps_gen_tio.c
> @@ -189,11 +189,7 @@ static int pps_tio_gen_enable(struct pps
>   static int pps_tio_get_time(struct pps_gen_device *pps_gen,
>   			    struct timespec64 *time)
>   {
> -	struct system_time_snapshot snap;
> -
> -	ktime_get_snapshot(&snap);
> -	*time = ktime_to_timespec64(snap.real);
> -
> +	ktime_get_real_ts64(time);
>   	return 0;
>   }
>   
> 


-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming

