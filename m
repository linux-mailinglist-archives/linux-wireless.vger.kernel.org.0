Return-Path: <linux-wireless+bounces-33171-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mxStImxUs2mzVAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33171-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 01:03:56 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D9F27B647
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 01:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C7008301BD66
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 00:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E184414;
	Fri, 13 Mar 2026 00:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9MHqTNE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15EB2110
	for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 00:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773360231; cv=pass; b=pYtQhbG6oyQHM8eLHOwRzfGmicJBBV7mGA929KzzILD2uw669jdnZoejNNaGv12k3H73Ny8wdjkW/NtpKF4KyKEyrWbfDL5aq12nWZr96vZh+rAT02iXbPlqifpAQWmEXeGBFLxc47DH2UnCdziHi8pDutH/H4SINKSmSqUo8bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773360231; c=relaxed/simple;
	bh=uyZi0OmQMUsTCbO/CQ+TwUcVjAB0M2jduvnTa3gXlZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mStR/sTnV9dHAowQ0ol0mUnagTk8kbQKmlmHXpTdJ/TOJrfgbSBOkCftiugrnYC4cOWKFeBrbwuK0fWxCqQ/Dy5+pRqOox7YIG+rDAVhnJdLLF3dUbwZULuAmLUWDe36OYufnGaN6TQ5Ww1Mr4ziAQm0ZzYQCJG+MwLevM1o+O4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9MHqTNE; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-41708f6c3feso1055943fac.3
        for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:03:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773360229; cv=none;
        d=google.com; s=arc-20240605;
        b=N7EuCvOp6K+6rfMR7TOmPDwZKut7q5rZp9Q+WOB3ARya7TKMHRYtpJ/s/KFbkGZo/M
         K9SNH152rJGCswFlgLWp3iTaQFINY/AXyqPzk1Wzzf46SZS+v1Kg3ngzrbXRuh7VTLoa
         r188e+24H0OFLX3xbe+99xh7ARuhIonQlkCdblhE7gzWZtKRsgvwJA36zO5+9yeCwF1s
         wIt2SyIU9xLw35TlQDoFhwmbaj1Fy49JGs6klrnktrSQGIXTkA9zuURJpW6AMZm5NgnZ
         B6JEYjfAa6Ae37NW5bVI5W6TgpvhRoRbSk+eEjL+OQ76tbPfJnxpaC83XY/Gsnq4ceUJ
         xKvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uyZi0OmQMUsTCbO/CQ+TwUcVjAB0M2jduvnTa3gXlZs=;
        fh=fFUQ3bDSnwWYL/1dqZwPKYywXd5TONRsAevI/mvHYbI=;
        b=UveNPPUEMkjlzMYkhjlyTVe1e9WqDYaY2/QohgvmWmCYWdQyXIzAf++c6Yz0nTbs2n
         l+Jwqrk2/+pgz02qtyR1UKu807PsMcbMmvbIuscP5/vIGEGv9JChH1BZtZ+trEEv/kyf
         A58kQ/6Cag7TeAscGmH8iQql1Mc8zKsL1TYZHwMZStFaLlAKexjl4LUW1o3C+q1fDtr2
         SE5/60AbmTehaRUH5fEZkUKtcFUUuIJTLJeK2XDVOtUFt3G1wYADhMR7S9/4LyKLUHZm
         hIZ3r0wrxGfHude/nTtGuuRjX6o8VKw0wkCPZTZ8zP94Ly9DFZBDdynC4Tdli1baR2Gh
         Dn2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773360229; x=1773965029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyZi0OmQMUsTCbO/CQ+TwUcVjAB0M2jduvnTa3gXlZs=;
        b=e9MHqTNE/IF9WTYAhz4I0G57ysrmtylq68Y4IrcRHn3GfNi160BR/Ko5KyDlrv34m6
         OvPIMgfEhCsewyF4S4+yPAmlT+cfJnn/lnk9uMz5XEtYuwoxDYVb6GD+OAS9DW/0RCSp
         RxDK+rrWpF52gl7LX8uAukCIZjnW7aJQXBaN2v0bB9mGNYHsOIqoYLxpgDycs6398URO
         Yy29mlPzxO1FA6r/wF+Z5BuT+iE0cWz5hcPmeOMwZxgfr7YGc/RqAz78eF/tLqpt81gC
         mSl30ZgeU7YqBA9ccqvQShwJrduwK9VerSQr6foCnLj0fVfPLnRhZ+Env9CUmg6Iqnxs
         Z3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773360229; x=1773965029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uyZi0OmQMUsTCbO/CQ+TwUcVjAB0M2jduvnTa3gXlZs=;
        b=CU96njauaeg0T4i/coLw6mezBPDk9friYHLcCQEvhGJiJole4VghHAMDNKYRoqrU61
         VaCmeIl039ousZAKhA/TTAbAyGo6LjDxd5RPkZFDJV4YbMJHqKxezlOj8TXh+vZxrYAY
         fP83xtShrJ+eOb3eCJbmFwtgDJj3Opmv056O7mFlrRhiULbPNNjqq1MULnmoY9SxVsE6
         4al1Wr4q9FToGcvLYxKX5VApR/2fMk7m0S7JJJD3gDmZDn1fnjXZ2ZOtWbPZXSPXR2Wx
         O6lRnnhSuWDT66lOpB++/7/uNgXx4aRP9ugjMN/IUvJWclZpeFrDso57wNONtZJn8nje
         +bsw==
X-Gm-Message-State: AOJu0YyES5XMj3AN+EzSGZYYVl3/GsY6/yRtJm1wK7MST512GIPIJfxW
	3fQXJNsnxqXVSnZtieKdsXcBjS3vPG+vt2AtJkj4w0pM9hw+adgDFs1LI4tT8VW6bNtI8WinMum
	QLxNbtLnnxMbcCeL4dbH/wVR58pZWWl8=
X-Gm-Gg: ATEYQzwtnCPQhMe3oR43/B/CGicN458U/V0HWsoLIS4i/3ehBfYIYkqyH3JaQKuck+T
	Tm1bUnSse1Ju01v7EQSoD5u/nfaRNVVOXScro0d/1BprfH6AtkdGoxVfWJ08/CF1ZaHIYK58a0T
	FYNRA/Ni++fpInG2xaDcoWZKwgeNw1k0wKslWYJHgHr++PIqwFaFUAVUgapkhOLsMuAtMDyVbHi
	nqV4EFyUUGan+4G8FexzDcUiTRx/Jwl5gf/LXzTzRAWYEHsYV31Moz5ZcGVoB4E7sz+H1EuJzw1
	OFwydgr/W/p97eDY1qy22P6FlQ==
X-Received: by 2002:a05:6870:6c0f:b0:3e0:fd27:2623 with SMTP id
 586e51a60fabf-417b9059bf0mr776997fac.4.1773360228767; Thu, 12 Mar 2026
 17:03:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <1e96af437fa24674b353ddb530b2d8e7@realtek.com> <CALdGYqQb=Vt0jjqW7k8RGMV1gczL0cg-26cHgCm3MmzBjezGMQ@mail.gmail.com>
 <792645eed36041f0b3df951f1b28a08a@realtek.com> <e6720993c8c14245981432cfa4ae902b@realtek.com>
 <CALdGYqQn8GGXXjZTsL+a5Mfdmw5HRYB2Jyvqq5M5SUwxK9yd_g@mail.gmail.com>
 <CALdGYqQee1sjgdBAPJSyb1gL6ksK4z8Uw_v3ANTnyXE+LXFAiA@mail.gmail.com>
 <458ed80e39734ea99610050140bb31ce@realtek.com> <CALdGYqQykO9ZzO=-+D17R_8LC=Win5nGN6-9zFqChtNEyUzEfg@mail.gmail.com>
In-Reply-To: <CALdGYqQykO9ZzO=-+D17R_8LC=Win5nGN6-9zFqChtNEyUzEfg@mail.gmail.com>
From: LB F <goainwo@gmail.com>
Date: Fri, 13 Mar 2026 02:03:12 +0200
X-Gm-Features: AaiRm51d7o_QYFf6L9WLlwkGaUVfdNVtR1e2pjfSTzToSsaEkZ0rgfbFwrhXjW0
Message-ID: <CALdGYqTHz5Pz3uSGLbrVuNMWAXaqniUCuOSQACXUYHSL22ySvw@mail.gmail.com>
Subject: Re: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33171-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 85D9F27B647
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ping-Ke Shih <pkshih@realtek.com> wrote:
> I'm really not sure how/why kernel becomes frozen. As I mentioned before
> it might because of received malformed data and no complete validation
> before reporting RX packet to mac80211.
> Not sure if you can try to dig and add some validation?

Hi Ping-Ke,

I took your advice and performed a deeper audit of the rtw88 PCI implementa=
tion,
focusing on both validation and concurrency. While the RX gaps I previously
mentioned are real, I found two critical architectural issues in the TX pat=
h
that likely contribute to the "hard freezes" and DMA stalls we've seen.

1. Concurrency: TX Descriptor Management Race (pci.c:836)
---------------------------------------------------------
In rtw_pci_tx_write_data(), rtw88 fetches the descriptor address based on
the current write pointer (wp) BEFORE acquiring the irq_lock:

```c
/* drivers/net/wireless/realtek/rtw88/pci.c:836 */
buf_desc =3D get_tx_buffer_desc(ring, tx_buf_desc_sz);
memset(buf_desc, 0, tx_buf_desc_sz);
/* ... packets are filled ... */
spin_lock_bh(&rtwpci->irq_lock); // [!] Lock is taken too late
```

Since mac80211 can call rtw_ops_tx and rtw_ops_wake_tx_queue (the latter
calling __rtw_tx_work) concurrently on different CPUs=E2=80=94especially fo=
r
high-priority AC_VO traffic=E2=80=94two threads can fetch the same wp for t=
he
same queue simultaneously.

Result: CPU 0 prepares data in slot [N], while CPU 1 simultaneously zeros o=
ut
or overwrites slot [N]. This explains why we see intermittent descriptor
corruption and subsequent DMA/firmware hangs.

2. Synchronization: Missing DMA Memory Barrier (pci.c:786)
----------------------------------------------------------
In rtw_pci_tx_kick_off_queue(), the doorbell is hit without a memory barrie=
r:

```c
/* drivers/net/wireless/realtek/rtw88/pci.c:786 */
rtw_write16(rtwdev, bd_idx, ring->r.wp & TRX_BD_IDX_MASK);
```

For PCIe DMA, it is vital to ensure descriptor RAM writes are visible to
the device before the MMIO register doorbell hits. Standard Linux practice
usually dictates a wmb() here. Without it, the Wi-Fi controller may read
stale or uninitialized memory, leading to the "failed to leave lps state"
timeouts and H2C command failures we've logged.

3. Confirmed RX Limit Mismatch (rtw8821c.c:254)
-----------------------------------------------
I verified that the hardware is explicitly programmed with a 12KB limit:

```c
/* drivers/net/wireless/realtek/rtw88/rtw8821c.c:254 */
rtw_write8(rtwdev, REG_RX_PKT_LIMIT, WLAN_RX_PKT_LIMIT_512);
```

Since the driver's RX buffer (RTK_PCI_RX_BUF_SIZE) is only 11.2KB, any
malformed or large packet will result in an OOB read in rtw_pci_rx_napi().

I believe addressing these three points (TX locking, TX barriers, and
RX buffer consistency) would significantly harden the driver against
the stability issues reported in Bug 221195.

Best regards,
Oleksandr Havrylov

