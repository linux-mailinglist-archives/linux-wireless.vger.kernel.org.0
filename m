Return-Path: <linux-wireless+bounces-35228-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFrqGcsU6WmtUAIAu9opvQ
	(envelope-from <linux-wireless+bounces-35228-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 20:34:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE3C449C73
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 20:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB565304FFB9
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 18:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4236438F226;
	Wed, 22 Apr 2026 18:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oIAge54g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2893C552C
	for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 18:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776882604; cv=pass; b=nA7pomjzyD758Cr3fkAcZsynaxOx0UDgnzPfqiNRqOQKfY5H/NZmkU+UL8KMdh3JE4xXjUC+lnK9zCA+UIHu7TKDEazIwokLPuD93ZqUaWjhFRk6TB83ThKCL2yvaNtlizjb6HXgjgMEQxsiz/rjnRHTXzTcPbm9difwvtznDS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776882604; c=relaxed/simple;
	bh=cDLiIbpQ4C0rfS9ZCxoI4yN7JKXdGP763zZYXX2KLq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fTEPwbbQ4fv8xFB2ZC4JlOvTJo3Ormxc9k3YG7OhiebgMFJm/8x9HflEAQEfAu+6cNeE538EOJczlO4cOt9/u89XuafuOdf3nGSUM2WTAxvBgjGbxk8KXBquIPeuq99PqTjmJT7SVSt9v0ECpGy208TwsURiXS64ZRkIm+56TZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oIAge54g; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82f8892d4d6so2557124b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 11:30:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776882602; cv=none;
        d=google.com; s=arc-20240605;
        b=LLTdnvh83LH0jQIsF6ZSvfYbJgMD1Rg1mhORT9EW8R5MNy7peQnuprueoggo0v2pE0
         Lgu26unSXnPFu5cQv+q0itNV4OZNJsv+RfUJGeogpsHWsZpQBITeURq91SxqFuWL+hBd
         4d1GxfofLEKGU1n3AbCLwZslQEA34O6arqppLqLlW8pGBVSLdbTw5seI+VP812/rhDc6
         Px46bzOU0UqZ9B+nawMy3aUX9yuZad6XfMcOiT3tbWkTPQ1NApWm77+HfolEVga1ONux
         hYv5GjrviELOBQHNi8Q2EwEMHerfKR36J411zSNu1g517PXBfRAJb+PD73VJCUPrMlbR
         AEHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u4/X37XCFva5OVnePm1MhKl37TKCmccKP8OvCY5aZo8=;
        fh=tjVPZFMMQ+j2eHJ/4ndwfQGY5WRYYHNt0A4DeMB2h30=;
        b=OgaUw15yf6qmELsN38NPftPvmguVqHdLTqKoTT3UakafwNRTIsddC93Gp+dY9+vnVW
         8an1YMctHgQFW1IWqzhJmhwqcewf9MgsaYeGhsXWZMb7/xyjUVsgt6j/bE4wUkkYA+qL
         QuIWNPbeMfI/NGfonrelri4tfCLSbxraFib99HPkpiPoSV0Wzkzj+3oOhwksJXPxbDHd
         rCiZC32mbXGL8VLYm+p1auyQFQPQfY359ZxPC4tOAa+WKAl3XIeFqiDSQtKB41JA0xKR
         pdxqV4T7sHeTXFTDWPcTU/OEZirJT6GwUhTYjst8J0g3+lgIE26TBEJjaWkwvQbDB2zq
         WIiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776882602; x=1777487402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4/X37XCFva5OVnePm1MhKl37TKCmccKP8OvCY5aZo8=;
        b=oIAge54g+qgRoNvD1mT9jjOrJcZ3sbvJaH1rq5uv658/2w01yGh2lxSt8ubvXjFigq
         TyDLWFKERajTBofUS51YKdDkmDw1qswPqvK0X3Lr+IhAoWaYK98g68O5YrpUkH7IHLGq
         O5Rc9+fO22PZ3xTp8gEOP5c/Mj4AiiXY261mzg/67Egb4P1IP4uXSg01lKH3wNNU7pbq
         kPy96WCXxZRBXzuNIYV5oQmx19+LYLXP5mvhEIcoD+JLwg5LrNMY7GNnYgh/NGmdGZF3
         9a0/BBCdFrZHb+0ZXMjZg9+zXrVuqb2K2cAayoN3mgI7ODLiYkhmjZYldTgjjlzQY4W5
         kKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776882602; x=1777487402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u4/X37XCFva5OVnePm1MhKl37TKCmccKP8OvCY5aZo8=;
        b=jSpvufM1JrVCYtFT+ZbCmOK4LPlsO9xMdBG2rISkNqAO5XSBYdcJomE2pZ4D1/x6so
         AmFwg2Ti0QMkOV+Ad5ly1ShW/Py2DcLq8tKNWhoWj/Epnp2TNP0+017dYgixwBonNRXG
         byBpAfGNDjhUtRxVlLqhjrDbewfgJM3fgGHaPxrzg6XHil/PDW7Tih+6wN2Ducdjh4wd
         V9+bZa92QUaahGchIVAEedjIhYysBzKcU8oSrD+a+FFENj663p2NOLZVs9LqNJGoOTTm
         4sKRyQrHivv7mJO6ELgARt8Ekbp93pnGMXK2yFC2ewA4amRnQHPDvk/yk3FqGXY8Alle
         PdLQ==
X-Forwarded-Encrypted: i=1; AFNElJ/CcJajs+YJ3qHoULynHjBjT8j7AQ4DegJokDXHav7iY2JjOJcu8vBYuhMGwBXjUwuqECHRL/XGHEzhHX724Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDmH/31oZTJMF1GfCKNfDlEC7XdJbIMiuiUFNV2Gb5SVP+q6zR
	yIk/6F6CpIiQrkKIq7wT91wYBzOg6kH6dJKF/q4mGmYFdsekjGdknn2OQopkRgW0cizVaKV1Olj
	krYGcWXV9M/8rI+GKahoIgsjEjCJBSSk=
X-Gm-Gg: AeBDiev3QTE9mLDd7ooSY+HhTZJ7qC5qMyfD2TngbQEkZmDumvFh5iUhDlB5fWeu5bc
	6HRZ3JJwIa4yIkLW/mzkaRln5/n+qfw82dMtKsUbGOS7qxB2xI0NZPRa2zxcTm4EFH/sKyZj85s
	APQDDFPL+9JnwsyGT64TpTSTWXKEp2H+vVEO3G86VL6Qq+PR2nWcqZH/seurPgKoR4GrmE8/oei
	HDWgQMXnEERgQGfMQoAjsMCPSr+O5CVGoPl+o9ZE7qxeMNS/XTElP+Ozc8Iv6JfhC0YP76i6c4F
	gdYgij600JTV7m9PNbtUtYFcszM=
X-Received: by 2002:a05:6a00:3c86:b0:81f:40e5:34c2 with SMTP id
 d2e1a72fcca58-82f8c8bee9dmr24460114b3a.32.1776882602100; Wed, 22 Apr 2026
 11:30:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4cdf2e61-fe69-4168-9df7-55bb71585dfe@oss.qualcomm.com>
 <20260421172500.1050754-1-asas1asas200@gmail.com> <a396cf77-81ff-45a7-ae62-fb4e22c18497@oss.qualcomm.com>
 <5209fd4c-eee3-46ed-b731-1e822a04b03b@oss.qualcomm.com>
In-Reply-To: <5209fd4c-eee3-46ed-b731-1e822a04b03b@oss.qualcomm.com>
From: =?UTF-8?B?5pu+5pix57+U?= <asas1asas200@gmail.com>
Date: Thu, 23 Apr 2026 02:29:49 +0800
X-Gm-Features: AQROBzDxM0fqbCHkhOTTojJKKrEQPg26v2Vc1sqEZ8FbcRGZeJNS3g34dPnWJWI
Message-ID: <CAJo1PWGuSk4te+XVPn2cxqHpc1RfBfZbeKbtXm=8OZQ=rf_wpA@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: ath12k: fix false positive RCU warnings on PREEMPT_RT
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, ath12k@lists.infradead.org, 
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>, 
	Rameshkumar Sundaram <quic_ramess@quicinc.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-35228-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asas1asas200@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: BDE3C449C73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 06:33:45 -0700, Jeff Johnson wrote:
> Amended patch in my pending branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=3Dp=
ending&id=3D32f70ee38388bb9089b9cffa9791f5ef8d5d32cd

Thanks for picking it up and fixing the Tested-on placement.

Sebastian pointed out on v2 that the fix should use
lockdep_assert_in_rcu_read_lock() rather than RCU_LOCKDEP_WARN(),
since the former is gated on CONFIG_PROVE_RCU (same effect) but
expresses the intent more precisely. He also noted that the bug
is not PREEMPT_RT specific but applies to preemptible RCU in
general.

I've sent v3 addressing both points:
https://lore.kernel.org/ath12k/20260422180814.1938317-1-asas1asas200@gmail.=
com/

Let me know if you'd like me to do anything further.

Thanks,
Yu-Hsiang


Jeff Johnson <jeff.johnson@oss.qualcomm.com> =E6=96=BC 2026=E5=B9=B44=E6=9C=
=8822=E6=97=A5=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:33=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On 4/21/2026 2:27 PM, Jeff Johnson wrote:
> > On 4/21/2026 10:25 AM, Yu-Hsiang Tseng wrote:
> >> Two functions in ath12k assert that the caller holds an RCU read lock:
> >> ath12k_mac_get_arvif() and ath12k_p2p_noa_update_vdev_iter(). Both use=
:
> >>
> >>     WARN_ON(!rcu_read_lock_any_held());
> >>
> >> On PREEMPT_RT kernels built with CONFIG_PROVE_RCU=3Dn, this produces a
> >> false positive splat whenever these functions are invoked from paths
> >> that do hold the RCU read lock (e.g. firmware stats processing or
> >> mac80211 interface iteration).
> >>
> >> Root cause:
> >>
> >>   - On !PROVE_RCU, rcu_read_lock_any_held() is a static inline that
> >>     returns !preemptible() as a proxy for "in an RCU read section".
> >>
> >>   - On PREEMPT_RT, rcu_read_lock() does not disable preemption. A
> >>     task can therefore be preemptible while legitimately holding an
> >>     RCU read lock.
> >>
> >>   - Callers such as ath12k_wmi_tlv_rssi_chain_parse() (via guard(rcu)(=
))
> >>     and ieee80211_iterate_active_interfaces_atomic() do hold the RCU
> >>     read lock, so these warnings are incorrect.
> >>
> >> Typical splat seen on a WCN7850 station with periodic fw stats
> >> processing:
> >>
> >>   WARNING: drivers/net/wireless/ath/ath12k/mac.c:791 at
> >>     ath12k_mac_get_arvif+0x9e/0xd0 [ath12k]
> >>   Tainted: G W O 6.19.13-rt #1 PREEMPT_RT
> >>   Call Trace:
> >>    ath12k_wmi_tlv_rssi_chain_parse+0x69/0x170 [ath12k]
> >>    ath12k_wmi_tlv_iter+0x7f/0x120 [ath12k]
> >>    ath12k_wmi_tlv_fw_stats_parse+0x342/0x6b0 [ath12k]
> >>    ath12k_wmi_op_rx+0xe9e/0x3150 [ath12k]
> >>    ath12k_htc_rx_completion_handler+0x3df/0x5b0 [ath12k]
> >>    ath12k_ce_per_engine_service+0x325/0x3e0 [ath12k]
> >>    ath12k_pci_ce_workqueue+0x20/0x40 [ath12k]
> >>
> >> Replace the WARN_ON() with RCU_LOCKDEP_WARN(), which is gated on
> >> debug_lockdep_rcu_enabled() and therefore compiles out entirely
> >> when PROVE_RCU is disabled. PROVE_RCU kernels continue to get the
> >> full lockdep-based check.
> >>
> >> Fixes: 3dd2c68f206e ("wifi: ath12k: prepare vif data structure for MLO=
 handling")
> >> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.=
0_SILICONZ-1.115823.3
> >
> > Note that Tested-on: is not a official upstream tag, it is an ath-speci=
fic
> > tag. Since it is not an official tag, it should be specified separately=
 from
> > the official tags:
> >
> > <commit text>
> > <blank line>
> > Tested-on: ...
> > <blank line>
> > <official upstream tags>
> > Signed-off-by: ...
> >
> > Unless there are are other review comments there is no need to send a v=
3 to
> > address this -- I can make this change when I pick up the patch.
> Amended patch in my pending branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=3Dp=
ending&id=3D32f70ee38388bb9089b9cffa9791f5ef8d5d32cd

