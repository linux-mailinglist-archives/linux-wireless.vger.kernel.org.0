Return-Path: <linux-wireless+bounces-28692-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA0FC42755
	for <lists+linux-wireless@lfdr.de>; Sat, 08 Nov 2025 05:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E0A5B34AB0C
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Nov 2025 04:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6538D28C5DE;
	Sat,  8 Nov 2025 04:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AobGWqrp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4701883F
	for <linux-wireless@vger.kernel.org>; Sat,  8 Nov 2025 04:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762577973; cv=none; b=Z9SfqVwahy8eB8ZnSlVYFv6CoBX/qhzVRk+2Wkl62CkRNXsCK5ouoxcIxcN5OkCgU1axXSrRvlKt2tFL1AsrBataizspZPx8qkLq0/tqrsgxpGgCtv4OviV3MAWRxvcl2GCkZCRb6BbGKbOg9j0kyTzpOnqgOtgA+WiKs/ecHMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762577973; c=relaxed/simple;
	bh=ZqqdSWiwpjOezakq7wJoS7DxeQN0DZ/YihDSKS+z2DI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=isIkiUmesXmGw+YmVTUQTTfedRzkpk7Y8wFOU+d+Oc78thQdXn2BVKWmRos2qHRuZ/ttAfU45hV6MTbPmhHgcJkbdyKpglJOyHZuVUXo8giJWlPdIRYDEEPD6ewdTChCD/PG6Ip1Fe5e98D9qisdZKEDUsDFTMpNLonBYqVhz1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AobGWqrp; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso1113825a12.3
        for <linux-wireless@vger.kernel.org>; Fri, 07 Nov 2025 20:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762577971; x=1763182771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUrthg7LTa8MSiT55+OVFlTeSXmJjUd5aal+Gc9S7xY=;
        b=AobGWqrpHXjGsBEivICDiTHL2kfu5KJe86vdsAqQfXCQU7Vc3hI3YkYR21/xsj3O/G
         wZcV9qnFGUmNQ5PTw9qSYOk+Z/KL+Up4jN8clARxKziTAV1x1liL7Zw/1rYFOA5eSCfN
         yZuUGuEW2yPpfTgsZ7YAMk6dCGg0c8i9EQ7El0vbi1KcZMtx0tbJF26OZbuBE14kGm0m
         b6jv9PXDS++kETP/XwarQ0FgX3NwHKhwsIrHd6jLfBowVG+O/YGpUpZ9xwJqdQsnVXMs
         Bpxrx0RKB27aKmVWHtG595sRKQXJ7RaPPlVfGKutm2ixuF9Gpc23fPZ2oEBZYReMuDw3
         bTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762577971; x=1763182771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rUrthg7LTa8MSiT55+OVFlTeSXmJjUd5aal+Gc9S7xY=;
        b=YHHxWCPrzp5M901ZY1tqgHbz0J/lIJdfYQZAG+ibIP3gD3alyXt7C0ao0KpMiD5S42
         t9pO364OHtO/deaphRauLWWlW64XCgy5UpYp10cVMy9hWsZAGrhyovesuIbeOkVF0GxR
         Shs4qMzwwmmYzRhNq4XMelUyHg6CjhqoqTndEhq8CISts8so0xmBKCZPTuYNbWu1I3CI
         cmidsdtAvDn350GTWkhPTMU/01yXcFgSNCub98Beeh3wTdaHjzmevqWVbby8jbJ67OJ2
         1/pvv7bBglQR6xqtKwYEkn3VAP7uD4/pcIE5kMFcSZfCw6kQcI/pQZqGPqfmycAkQ12Z
         ApYA==
X-Forwarded-Encrypted: i=1; AJvYcCXSGleRyOQLeZ70kuMletqJMK3yj3zDkrr2r7J2jSc1ttcXNG8dDOSOCvWCcMG1hlq34KM2Hbjj/JzwAr7pRw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5gxPU0jT8kWPnk1kyIBK+91ftANwDRfDIyAXN0YpGbI0VOMT0
	kki39mriXi2n/eyGEQTYff4TYNW3LMiRGiA1pP9gGzU9ipuRi1fIcMTqEPR70J8P6hcFo55DrsF
	Xa7FClitesrFyQ7JFVdNk3C8EDFEWZhbCfYR1VEbQ
X-Gm-Gg: ASbGncv45k2I5BWKtgBNkWdbSMz7rHarxr3EqqNiCi0CgsLHpZMarYx4S1nNMwbJNBH
	ccaGbHfsqZ7L+dQfEOWSgK7qnnJLxXdihRlQK0znwk73ZppuBlz73/buh6LU0RL5zByWHymE4pU
	T9OhfTXMkQeczO50aQFLusaOkIQGtdJY9qmFrZpxgWxUzd8LBIoup1ewTb1mtr3faL63cjB113B
	nkQGi9XwrDnaSVEpNNrQO0dQ8S57IW1A7sWvOfItdlqsSe3jRXzg3EvmZ0WYhTA7xM26Zbhxeva
	4DLuSwCU0yzoyFkVFSGIda8dUJRa
X-Google-Smtp-Source: AGHT+IHF0KwKtclECib2P1zX8IcCdtJo1VZExPfZQ8JDWvscy5b7/GgckQOBWwL2UbdMZJS5FufxLrBidfyLfng0Iyk=
X-Received: by 2002:a17:903:19e3:b0:297:c889:ba37 with SMTP id
 d9443c01a7336-297e56ce112mr20555365ad.41.1762577970811; Fri, 07 Nov 2025
 20:59:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104225915.2040080-1-thostet@google.com> <20251108044822.GA3262936@ax162>
In-Reply-To: <20251108044822.GA3262936@ax162>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 7 Nov 2025 20:59:19 -0800
X-Gm-Features: AWmQ_blixJTeuI6gtkf3uXiCfIVKcT-SsFypFauJC4TJRl_ZNrVEjysdEmuUMzA
Message-ID: <CAAVpQUCoNB6RqXpCbxxZ3z9Fk6XgSZHh+mB77DUdJWMQT16VDQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] ptp: Return -EINVAL on ptp_clock_register if
 required ops are NULL
To: Nathan Chancellor <nathan@kernel.org>
Cc: Tim Hostetler <thostet@google.com>, netdev@vger.kernel.org, richardcochran@gmail.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 8:48=E2=80=AFPM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> On Tue, Nov 04, 2025 at 02:59:15PM -0800, Tim Hostetler wrote:
> > ptp_clock should never be registered unless it stubs one of gettimex64(=
)
> > or gettime64() and settime64(). WARN_ON_ONCE and error out if either se=
t
> > of function pointers is null.
> >
> > For consistency, n_alarm validation is also folded into the
> > WARN_ON_ONCE.
> >
> > Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> > Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> > Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> > Signed-off-by: Tim Hostetler <thostet@google.com>
> > ---
> > Changes in v2:
> >   * Switch to net-next tree (Jakub Kicinski, Vadim Fedorenko)
> >   * Fold in n_alarm check into WARN_ON_ONCE (Jakub Kicinski)
> > ---
> >  drivers/ptp/ptp_clock.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> > index ef020599b771..b0e167c0b3eb 100644
> > --- a/drivers/ptp/ptp_clock.c
> > +++ b/drivers/ptp/ptp_clock.c
> > @@ -322,7 +322,9 @@ struct ptp_clock *ptp_clock_register(struct ptp_clo=
ck_info *info,
> >       char debugfsname[16];
> >       size_t size;
> >
> > -     if (info->n_alarm > PTP_MAX_ALARMS)
> > +     if (WARN_ON_ONCE(info->n_alarm > PTP_MAX_ALARMS ||
> > +                      (!info->gettimex64 && !info->gettime64) ||
> > +                      !info->settime64))
> >               return ERR_PTR(-EINVAL);
> >
> >       /* Initialize a clock structure. */
> > --
> > 2.51.2.1026.g39e6a42477-goog
> >
>
> I am seeing this warning trigger on my machines that use the iwlwifi
> driver, presumably because .settime64 is not assigned a value in
> iwl_mvm_ptp_init().
>
>   [  +0.000003] WARNING: drivers/ptp/ptp_clock.c:325 at ptp_clock_registe=
r+0x103/0x780 [ptp], CPU#0: NetworkManager/483
>   [  +0.000010] Modules linked in: ...
>   [  +0.000036] CPU: 0 UID: 0 PID: 483 Comm: NetworkManager Not tainted 6=
.18.0-rc4-debug-next-20251107-07207-g9c0826a5d9aa #1 PREEMPT(full)  84ece34=
56f9361105a10b63b41a3c832c71ec446
>   [  +0.000003] Hardware name: AZW MINI S/MINI S, BIOS ADLNV106 05/12/202=
4
>   [  +0.000002] RIP: 0010:ptp_clock_register+0x103/0x780 [ptp]
>   [  +0.000003] Code: c7 60 22 f2 c0 41 89 c5 e8 8a 5d 2f d0 45 85 ed 74 =
4e 49 63 ed 48 89 df e8 da 94 6a cf eb 14 48 83 7f 78 00 0f 85 66 ff ff ff =
<0f> 0b 48 c7 c5 ea ff ff ff 48 8b 84 24 80 00 00 00 65 48 2b 05 3c
>   [  +0.000001] RSP: 0018:ffffcc5b04adb290 EFLAGS: 00010246
>   [  +0.000002] RAX: 0000000000000000 RBX: ffff8934d76b2068 RCX: ffff8934=
d76b4900
>   [  +0.000001] RDX: 0000000000200000 RSI: ffff8934c1ebb0c8 RDI: ffff8934=
d76b4810
>   [  +0.000001] RBP: ffff8934d76b4810 R08: ffffffff8ff70160 R09: 00000000=
00000001
>   [  +0.000001] R10: ffff8934d62fd1c0 R11: 0000000000000000 R12: 00000000=
0ea00000
>   [  +0.000001] R13: 0000000000000002 R14: ffff8934c1ebb0c8 R15: ffff8934=
d7708a10
>   [  +0.000001] FS:  00007fac016312c0(0000) GS:ffff89389cd6b000(0000) knl=
GS:0000000000000000
>   [  +0.000001] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [  +0.000001] CR2: 00007f7f93e50f30 CR3: 0000000119666002 CR4: 00000000=
00f72ef0
>   [  +0.000001] PKRU: 55555554
>   [  +0.000001] Call Trace:
>   [  +0.000002]  <TASK>
>   [  +0.000002]  ? iwl_trans_send_cmd+0x3e/0xb0 [iwlwifi 72c0d1371c0a5e88=
07f47a9d18b5f8082f51cdd9]
>   [  +0.000022]  ? iwl_mvm_send_cmd+0x16/0x40 [iwlmvm b29beaee96a9c574b7e=
4367316ad1fb89a4d5bfc]
>   [  +0.000019]  ? iwl_mvm_config_scan+0x145/0x1b0 [iwlmvm b29beaee96a9c5=
74b7e4367316ad1fb89a4d5bfc]
>   [  +0.000017]  iwl_mvm_ptp_init+0xe1/0x150 [iwlmvm b29beaee96a9c574b7e4=
367316ad1fb89a4d5bfc]
>   [  +0.000014]  iwl_mvm_up+0x8e9/0xa10 [iwlmvm b29beaee96a9c574b7e436731=
6ad1fb89a4d5bfc]
>   [  +0.000012]  ? kmalloc_reserve+0x64/0x100
>   [  +0.000003]  ? kmalloc_reserve+0x64/0x100
>   [  +0.000001]  __iwl_mvm_mac_start+0x78/0x2b0 [iwlmvm b29beaee96a9c574b=
7e4367316ad1fb89a4d5bfc]
>   [  +0.000012]  iwl_mvm_mac_start+0x47/0xf0 [iwlmvm b29beaee96a9c574b7e4=
367316ad1fb89a4d5bfc]
>   [  +0.000010]  drv_start+0x48/0x110 [mac80211 5dddabcc52998b16707609bbc=
ccb5a7bd69e6ccc]
>
> Seems like iwl_mld_ptp_init() would also be affected by this?

Right, I guess this was not found so far just because syzbot
does not fuzz wifi drivers.


> I did not
> see how many other drivers are potentially impacted by this.

FWIW, I skimmed the code with this when syzbot reported the
issue and didn't find buggy drivers except for gve,

$ grep -rn --include=3D"*.c" --include=3D"*.h" -E "ptp_clock_info.*?=3D {" =
-A 30

, and yes, this does not catch drivers that set func ptrs
dynamically, but I believe such drivers are a minority.

