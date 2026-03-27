Return-Path: <linux-wireless+bounces-34021-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMHFLgHOxWm5BwUAu9opvQ
	(envelope-from <linux-wireless+bounces-34021-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 01:23:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAE633D877
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 01:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BD7F23004CAD
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 00:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E6515C158;
	Fri, 27 Mar 2026 00:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaFQqGjX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57D015A86D
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 00:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774571003; cv=none; b=iQXq33o/nASeFYRukb9RdtwZcmgIU440RuieU2JFD23GJcT2ZicDwCeDV7abFobaejayMxD6IxqHuknZIBkmsVk193VwsMzJdchtAIJYn7Uc7X8K0GuBD+7irE1+XQR2M34+0/ONZaEcP/bYblNuiIUoTaN1zLXJrmu2EXL+4aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774571003; c=relaxed/simple;
	bh=j7Nt31dFKaFsqumzsZqmv1ULny9RxvGi6/PdugPHf8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EbN+dXSU3KuvTCMnlwb8A17uWkio+/MTAuiysn13VmRhavmPMkY/Jnr4k3K9h5B04hUu/+j3PbdVfZZtG3rYtj4nl9ocb986EIld/vw24bnF9u/hK6wjvPR+9A066LZYru9/Z+ckjdO0SuNDa5Ou9ep1SLEolsitA3KAGwZ9Hrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaFQqGjX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D948C2BCB2
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 00:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774571003;
	bh=j7Nt31dFKaFsqumzsZqmv1ULny9RxvGi6/PdugPHf8A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PaFQqGjX1eFsZ1D99arFtVc8P858lwfiJf6V7kHdPTbRL192i/VAhoF+gDOnGtQod
	 jzmJ1sVKX3JdO0n8zBpolrOkLrQuH7uqyHKFwudOrdfFPMpmxYIk752Z1WAtTXpMoU
	 nivndNlgjc/pPmfntH73czCQT/+vgNIy6ytFZDURtW2H+HCom+rvhj7gdryozV/IBC
	 T16ZsDqMmpWVXiCk7GmlUWoIgBtf7eZ/seer02riTn3/YZLOLEjXpnDL8fd42wBzvu
	 iNmC0GN9usYVlXuqWnaOXsZ2v1hAbIKzUGHBlqDlq040HyO2+XiAK+eSXi8aSvSWz1
	 ILLJFCf1HIX7g==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a283c44478so1743345e87.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 17:23:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXFKH+siLDMYXSl/7S22yuzIqx361AjsVW8Z1YdhbQJTLnpRY6tj7akwzkplqSQoePr2tZ3359zXXooSj9CkA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8YTXbI4/D/vAcuXJFOWnFLZma3UTVmCAyj0I3D6cqjGyyCmyQ
	CKUZwOp0sg3NsT/s8T/d/Gf4HrmVD4xgoqxY0VBUWWT/MC4wL9As2PjCm4RQXXIRvLOwim6HURC
	2C4Jl2pgdZp9dwpO+Y+AMehZK7d5Hs+A=
X-Received: by 2002:a05:6512:401e:b0:5a2:a8ab:ab57 with SMTP id
 2adb3069b0e04-5a2ab91ca08mr138533e87.23.1774571001632; Thu, 26 Mar 2026
 17:23:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325043318.13298-1-sean.wang@kernel.org> <20260326170407.406431-1-lucid_duck@justthetip.ca>
In-Reply-To: <20260326170407.406431-1-lucid_duck@justthetip.ca>
From: Sean Wang <sean.wang@kernel.org>
Date: Thu, 26 Mar 2026 19:23:10 -0500
X-Gmail-Original-Message-ID: <CAGp9LzoCyu7Qh9m7qURgemwa9UObKrTbmTXfL54Jojv7S-FoBw@mail.gmail.com>
X-Gm-Features: AQROBzBQDOYHgObrcEwJLMytH3mvTj3OvwfZEabjO8J-Nyk1beiReUrH1rBGPG4
Message-ID: <CAGp9LzoCyu7Qh9m7qURgemwa9UObKrTbmTXfL54Jojv7S-FoBw@mail.gmail.com>
Subject: Re: [PATCH 1/3] wifi: mt76: connac: use a helper to cache txpower_cur
To: Lucid Duck <lucid_duck@justthetip.ca>
Cc: nbd@nbd.name, lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, morrownr@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34021-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[nbd.name,redhat.com,vger.kernel.org,lists.infradead.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,justthetip.ca:email]
X-Rspamd-Queue-Id: BFAE633D877
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi, Lucid

On Thu, Mar 26, 2026 at 12:04=E2=80=AFPM Lucid Duck <lucid_duck@justthetip.=
ca> wrote:
>
> Sean,
>
> Tested the full 3-patch series on MT7921AU. All three bands working
> correctly -- txpower reporting is fixed.
>
> Test environment:
>
>   Kernel:     6.19.8-200.fc43.x86_64 (Fedora 43)
>   Device:     MediaTek MT7921AU USB (0e8d:7961)
>   Firmware:   HW/SW 0x8a108a10, WM 20251223091148
>   AP:         Tri-band (2.4/5/6 GHz)
>   Regdomain:  CA (DFS-FCC), also tested US, JP, DE
>   Note:       Internet maintained via separate USB ethernet
>               adapter during WiFi testing
>
> Baseline (stock 6.19.8, pre-patch):
>
>   txpower 3.00 dBm on all bands
>
> Post-patch txpower:
>
>   2.4 GHz  ch 1   (2412 MHz, 20 MHz):   36.00 dBm
>   5 GHz    ch 100 (5500 MHz, 80 MHz):    26.00 dBm
>   6 GHz    ch 5   (5975 MHz, 80 MHz):    12.00 dBm
>
> All values match expected CA regulatory limits. Connectivity verified
> with 0% packet loss on every band.
>
> Stress testing (28 tests, 28 passed, 0 failed):
>
>   - Connect/disconnect: 10 cycles per band (30 total), txpower
>     correct and ping 0% loss on every cycle
>   - Band switching: 30 sequential hops (2.4 -> 5 -> 6 -> repeat),
>     txpower correct on every hop, ping 30/30
>   - Module reload: 15 full rmmod/insmod cycles of all mt76 modules,
>     txpower correct after every reload
>   - Throughput: 100-ping per band, 0% loss on all
>       2.4 GHz: avg 2.4 ms, max 23.6 ms
>       5 GHz:   avg 1.9 ms, max 8.0 ms
>       6 GHz:   avg 2.2 ms, max 3.3 ms
>   - Soak: 20-minute continuous test per band (60 min total),
>     txpower sampled every 30 seconds, never deviated
>       2.4 GHz: 40/40 samples at 36.00 dBm, slab delta -4 kB
>       5 GHz:   40/40 samples at 26.00 dBm, slab delta +16 kB
>       6 GHz:   40/40 samples at 12.00 dBm, slab delta -16 kB
>   - Memory: 50 connect/disconnect cycles, slab delta +64 kB
>     (negligible, no leak)
>   - Band-hop marathon: 200 random band hops, 200/200 pass,
>     ping 200/200 OK, completed in 1232 seconds
>   - Concurrent managed + monitor: txpower stable on all bands
>     with a monitor VIF present, ping 0% loss
>   - Regulatory domain switching: txpower correctly adjusts
>     per country on 5 GHz
>       CA: 26.00 dBm
>       US: 24.00 dBm
>       JP: 23.00 dBm
>       DE: 26.00 dBm
>
> Zero kernel warnings in dmesg throughout all testing.
>
> For context, I originally reported this bug and submitted a fix in
> January (v1 through v4 on linux-wireless, as Lucid Duck). Patches 1
> and 2 in this series address the same core issue -- capturing the rate
> power loop output and subtracting the path delta before caching
> txpower_cur. Patch 3 (the per-vif-link get_txpower callback) is a
> good addition that was not in my series.

Thanks a lot for the detailed testing and for confirming the fix on MT7921A=
U.

This was my mistake. Patches 1 and 2 do overlap with the core fix
direction from your January series, and I should have credited that
more clearly.

I=E2=80=99ll add a Co-developed-by tag for you in patches 1 and 2, along wi=
th
proper attribution in the next revision.

                  Sean
>
> Reported-by: Lucid Duck <lucid_duck@justthetip.ca>
> Tested-by: Lucid Duck <lucid_duck@justthetip.ca>

