Return-Path: <linux-wireless+bounces-37297-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ms3IkmlHmq3IwAAu9opvQ
	(envelope-from <linux-wireless+bounces-37297-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 11:41:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 329F562BBBC
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 11:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9ACC5304C4FE
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jun 2026 09:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4FF35AC03;
	Tue,  2 Jun 2026 09:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+IpyZ8O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D983B8BC7;
	Tue,  2 Jun 2026 09:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392709; cv=none; b=GrEEy4T944gTr7NiL5AbBm38wNERx68UO9lrlusSjf7J628htJCzUuaBb4CXLewsNcbB/XlldcwYJ3p2N1HFdCmmh1+5tU+0sKxYFT7E3/4o9NE8D6/T2o/VoTlnwO0yxrqGPh9Nec29cP2WHY7BQ7NIzyP3zF4GISzi6gIXnEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392709; c=relaxed/simple;
	bh=oVFK0nG008aHrlI8LnIts54WnpxPIH7UStYVo6BNbp0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eFKp0G73eqy+7WqKD5aqncLKVJHFye0383go5hXx4r7+zvfL/3XlsfLAaTJl5w+Ez5xNpaIJMaEZ1XRXJJB7X6We/iSmQ8XCeQPRq+zfQLHgIX79b0gmD5ui6oQNUzuCYLCKsagWtqZq+V+Pt07dwvx89MqPymf2p5nb6bJOVe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+IpyZ8O; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323701F00893;
	Tue,  2 Jun 2026 09:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780392703;
	bh=l9Fnu7ql/xw3WcbLnwmXcQ6Np+ykb7eXiOcMgZ1/zrA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=G+IpyZ8ORqglynUsO5PqcmN9TOoMfpn/CrlCCnUVH6YlWLr0MUKCjg8JLpHl2ljOA
	 P1R6cZugmO5ewnx1OWoJ7YSpv8jik4V9TQt/awnIbmC8xYDzNnztKJJ2aobL+VbTtF
	 5rmc6dw/7bksesUxZVCTCDGWrTr8AI1+AIh8+9dEvy4r9aW3mlUxjPDuRqsitDf7CF
	 CU8CDMNsmCx4lgYkC6HDkWhXZs8sdcB6qbTcE/PP5+v8gQI5O0APeSHUvt5CkKCrrd
	 d6U0aDVmb5bBTaSHV3MYMSd2oxAGkxdVqwMVO8j5MT7AAUrRHRPHCpL9AuriNQaMZO
	 YLyDVj4i3gOqQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Rodolfo Giometti <giometti@enneenne.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Miroslav Lichvar
 <mlichvar@redhat.com>, John Stultz <jstultz@google.com>, Stephen Boyd
 <sboyd@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 thomas.weissschuh@linutronix.de, Arthur Kiyanovski <akiyano@amazon.com>,
 Vincent Donnefort <vdonnefort@google.com>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev, Oliver
 Upton <oupton@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>, Johannes Berg
 <johannes.berg@intel.com>, Jacob Keller <jacob.e.keller@intel.com>, Tony
 Nguyen <anthony.l.nguyen@intel.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Peter Hilber <peter.hilber@oss.qualcomm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, virtualization@lists.linux.dev,
 linux-wireless@vger.kernel.org, linux-sound@vger.kernel.org, David
 Woodhouse <dwmw@amazon.co.uk>, Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [patch V2 04/25] pps: Convert to ktime_get_snapshot_id()
In-Reply-To: <912a22e8-878f-4763-958b-71052ee69b36@enneenne.com>
References: <20260529193435.921555544@kernel.org>
 <20260529195557.123410250@kernel.org>
 <912a22e8-878f-4763-958b-71052ee69b36@enneenne.com>
Date: Tue, 02 Jun 2026 11:31:40 +0200
Message-ID: <877boh8f0j.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 329F562BBBC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37297-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,linux.dev,lists.linux.dev,gmail.com,vger.kernel.org,suse.com,intel.com,nvidia.com,oss.qualcomm.com,amazon.co.uk];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, May 30 2026 at 13:08, Rodolfo Giometti wrote:
> On 29/05/2026 22:00, Thomas Gleixner wrote:
>>   static inline void pps_get_ts(struct pps_event_time *ts)
>>   {
>> +#ifdef CONFIG_NTP_PPS
>>   	struct system_time_snapshot snap;
>>   
>> -	ktime_get_snapshot(&snap);
>> -	ts->ts_real = ktime_to_timespec64(snap.real);
>> -#ifdef CONFIG_NTP_PPS
>> -	ts->ts_raw = ktime_to_timespec64(snap.raw);
>> +	ktime_get_snapshot_id(CLOCK_REALTIME, &snap);
>> +	ts->ts_real = ktime_to_timespec64(snap.systime);
>> +	ts->ts_raw = ktime_to_timespec64(snap.monoraw);
>> +#else
>> +	ktime_get_real_ts64(&ts->ts_real);
>
> 	/*
> 	 * Prevent kernel stack information disclosure if the
> 	 * structure is later copied to userspace.
> 	 */
> 	ts->ts_raw = (struct timespec64){0, 0};

Which will fail to build because of:

struct pps_event_time {
#ifdef CONFIG_NTP_PPS
        struct timespec64 ts_raw;
#endif /* CONFIG_NTP_PPS */
        struct timespec64 ts_real;
};

No?

