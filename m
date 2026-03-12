Return-Path: <linux-wireless+bounces-33120-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DitLTPqsmljQwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33120-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 17:30:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EF12759C0
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 17:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 03A143013DC4
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 16:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BF53F99E5;
	Thu, 12 Mar 2026 16:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7NdcNT9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345FB3F9F4A
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773333040; cv=pass; b=Hs6qPfyQRwoO/fLx8rSyOFr32ftLeSD+CVqeE5dnzUA6/ze+imNmCU9gxpd7Uo1ADJ3s3mh1J2FxtWtc680uS7eU2rtzrrsvPNV/45xJNiyCxAcu/bgZvBaX+t7A4EpTnzn9WMBCToYacXSL1U/YmodyHS/GUooPky37dFkxJoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773333040; c=relaxed/simple;
	bh=naaIlYpcftWtQ9jUH27SuU3SoPUENIuURPnppODKJfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqzlt/ktsCeMHdnwV4KkAU/P33TRPb6SwNhd7wq3E//jydCPQOxhP3jczZ0IEGJ0Q7QvvgAb1iRrbUxNQdlpDy8u28/o0oEballnLtufPAFH9bFckSgJTcrEbtqS2XlT1A2Hzl0VQj54xD6ZpzXhAG65QuqG/rAWR3oPBEZxUy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7NdcNT9; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12732165d1eso1549875c88.1
        for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 09:30:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773333033; cv=none;
        d=google.com; s=arc-20240605;
        b=h/18Vlf2hjplKPS1M1la72MbQbAxzWgUwqVI9lIISZCmM7lOd07oxHBj0TEIypqpfz
         EH3Z/5OiM1hA6HZm5bHxVkhaN4DSTJ4cSynRv4so/RcmVd917CiBiAR9bf2pXaeRN3rR
         dypqP9fUsnxv8sjhhIgcfCvM0cVe2Sgo7tvSOrqI9HavBtK5CTAFUfm/kmC498Czn+kl
         HUlot81Qj+4vYkr4Wtwao2ZDCAjIdkz/uM3jtEBUjWuS7jQn9b7ZbraFTPAbybuN9UKG
         SgSeMzwdOGBuf9A42++odr+ybJfcuKbL9AfDUor2JL76JHsgfcbr+nyy72Gqi71eAavd
         5X6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KM8KaYwOxl26cN0NYbbOg/R+fvkWdnp9O3HOgTyJzNA=;
        fh=MXkW9Xo5Ym/gIF9EG8Fk1lbc8jJJ90IIrm4Se6meZo4=;
        b=PrEou8os8qdWCj2/spf+51d0DWymF5uvgQDFjw1FsmGxaazj/ZBohvQ+zDrdZ2a+ZD
         4S4vL3UcvbR5Zq5QjbYOMsEbAL97ifezrsQSAAU32rcmkpsAN6+EMaSkOspI6xZbhPlc
         42LLkYMcZHXq5d5zhK/1TpaofQZX0phT0rH7nEc8rkID4UBhcKxhIsLi/Gm8gtb0Bj1a
         vGc/pVs9C31lBgpzKUBjL+6AiIIsEFabzaPn6ZFpmH1CCL8HTPRK5EtC3+FXgweuIiAT
         PBIOcSCoP5NSK1G/TXE8hN0ZrjBpSZmyoBDFMDulH/msdBGSN2IoUM8C/KAbxpge6u95
         ZzCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773333033; x=1773937833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KM8KaYwOxl26cN0NYbbOg/R+fvkWdnp9O3HOgTyJzNA=;
        b=M7NdcNT98JOBmKIuBpUg8DeIta/UUhkibec98PDxjknz25q+yV8Fer69NHBIsgnz2G
         Iru5D2kpBhnz4JhJumqlgoZ53xZvtjB9WGQWOvsU+hc6F4yV6s1XMhx7ppX6A+VxNDeY
         6kU4YZcBJ7o6CwPldv7IArVUKaAsfdx2aUgbWT5vmRfDpsN7RJE6fdp+NSH+AWE5O0kz
         5D9oabk77jiMOJAdbpNjsk2AD3Iiq6Lv1Vw/dOmlYIUFiJHSJMlicfVhlonzKAUVtIOl
         d8OVBeO9NAVj19qgh1ICQQFKjbYKQ9SSKk025Me2jCxPi1vEv/d8ObM+C1t9Cne0kIAO
         bRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773333033; x=1773937833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KM8KaYwOxl26cN0NYbbOg/R+fvkWdnp9O3HOgTyJzNA=;
        b=WsruDRbQGbdo8irmixQgiliiQCaKfByJsFyl246YJkq6JTaQYchme31coq+ANriGLb
         qlqARCZliJEZnG2uIsodkQjw38OM7AbbqS5S2lfynI9TzwzcUEFitljYWcHdaB7dAmb2
         e3mUWpLAVmiSCUEcMTeaMH9XCNDrL2cBeW8pWOr7PzN4flh2RO/KteO+kmYfFfQJw+Gl
         xwwLXy0wvCaYJLU6dAwOtQbJhN57deVsm0FuwDY2EY4t0FLU+5yrMROBxesHz0GdbRPD
         QcPeKBy177DS0PwjIexYXMZbMrriwXCabunKVADPmzpPnfR3WWPWmzGJbSutvH4k3gvZ
         arFQ==
X-Gm-Message-State: AOJu0YzkIvV2V1sQxMGgB+JuI3hJLREekOuKTUk3Q6gjPGq3CZpWL99h
	WR7eD2WRQGTbKryHP2Mg/XyNQ+vk4KLcmmZtvXoU0Y5/0U+W/v6duRPu8atKwUYMOJrnviuzf/l
	/piUxBtbQXguX3iK+2lSSgsXsCuCgObc=
X-Gm-Gg: ATEYQzx9rmw+ZsqEULg4G4tMGWHywIv+4F/+dY2NhlDhI/+qgsvs19WZXuj6Hq8hGul
	uhsspxc7bMSGECO5IqACRzCcDHRSpp1TyhYQmeEnGI1epn5ppZqUsvs0pYtTKD1l/+V5Y+VMjsX
	v38H+xQ7d58KmMG0KtBeogFSA0lcLLcjomDSEtVPFb/GTmKEyVbNisva32uoSIeUya1j9l2PDQ/
	Bllzs95QkCg1RTjB38POXHPsegWT38LdbkIyQ/OHb0kvNFWOseiz134xu98C5quULXt+TfH1pQe
	dvYkBJQa
X-Received: by 2002:a05:7022:784:b0:119:e56b:98a0 with SMTP id
 a92af1059eb24-128f3d17f5amr93984c88.7.1773333032705; Thu, 12 Mar 2026
 09:30:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANAPQzi3BkfnRS4CEXAA560O5cO8e6MEYxeVVx1u+xUeXS-gmA@mail.gmail.com>
 <CAGp9LzoidBL1iYYC371+Fw+drbArLRTneJKxCoFiitx=dweKCg@mail.gmail.com>
 <CANAPQzjiBf8Rqphn2SypYN2O6bddj6vB=63Mp=T5YVEt2oGvyw@mail.gmail.com>
 <CANAPQzgiE1rMP3F=5NJg3hp2uBXtq44+vTRBdkHwdfHyXJ8MQQ@mail.gmail.com>
 <CANAPQzgD312EPSbvaQTE6U+wn85L65+xZHms7DP509ApxWvSZA@mail.gmail.com>
 <CANAPQzgXN2UOjuwV1fRofN2syxG933kSaB9S7DyFAykHHMRzew@mail.gmail.com> <CAGp9Lzr4KsXEXbj+4h+Lk2fKU7z6BqtL5krzZmu-_So2-bN4_Q@mail.gmail.com>
In-Reply-To: <CAGp9Lzr4KsXEXbj+4h+Lk2fKU7z6BqtL5krzZmu-_So2-bN4_Q@mail.gmail.com>
From: bryam vargas <bryamestebanvargas@gmail.com>
Date: Thu, 12 Mar 2026 11:30:19 -0500
X-Gm-Features: AaiRm53n6pmgqCbUrPSX8yo07dBdb14BIJ-x5VM49Aymd3MRBVn5ECKANeFOA0Q
Message-ID: <CANAPQzj24sTgnuXMo3wqVDhA==UQ6JQLESk0AernQUUmZvTi2w@mail.gmail.com>
Subject: Re: [PATCH 1/2] mt76: connac: fix txpower_cur not updated in mt76_connac_mcu_set_rate_txpower()
To: Sean Wang <sean.wang@kernel.org>
Cc: linux-wireless@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33120-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bryamestebanvargas@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 98EF12759C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Sean,

Thanks for the thorough v2 review on both patches =E2=80=94 really helpful.

I spent the last few days digging deeper into the txpower reporting
path across mt76 sub-drivers (mt7615, mt7915, mt7996, mt7921, mt7925)
to find the most efficient fix. Turns out, Razvan Grigore already
nailed it 13 months ago:

  https://patchwork.kernel.org/project/linux-wireless/patch/20250211081247.=
5892-3-razvan.grigore@vampirebyte.ro/

His patch adds 3 lines to mt7921_set_tx_sar_pwr() =E2=80=94 same pattern as
mt7915 (mcu.c:3393) and mt7996 (mcu.c:4802):

  tx_power =3D mt76_get_power_bound(mphy, hw->conf.power_level);
  tx_power =3D mt76_get_rate_power_limits(mphy, mphy->chandef.chan,
                                        &limits_array, tx_power);
  mphy->txpower_cur =3D tx_power;

This runs before mt76_connac_mcu_set_rate_txpower(), so it uses the
same SAR-bounded, DT-capped value that the firmware receives. And
since set_tx_sar_pwr() is called from all four paths you pointed out
(init, config, regd_update, set_sar_specs), it covers every scenario
=E2=80=94 including the ones Lucid Duck's BSS_CHANGED_TXPOWER approach miss=
es
when not associated.

I'm withdrawing both of my patches. Razvan's approach is the right
one, and I don't want to duplicate his work.

What I'll focus on instead:

- Testing: I'll verify Razvan's patch on my MT7921U (NAB9, 2400m
  altitude, daily use serving real users) and provide Tested-by.

- SEFI/USB reset: You're right that v2 was premature. I'll file a
  proper bug with full dmesg, lsusb topology, and usbmon captures
  first, then propose a fix only after the failure mode is understood.

- WF_MIB over USB: Still interested in your thoughts on my March 12
  email about MT_MIB_SDR9/36/37 returning 0 on mt7921u. From what
  I've seen, the USB variant has several gaps beyond txpower =E2=80=94 surv=
ey
  data, channel time counters =E2=80=94 that I'd like to help close.

Best regards,
Bryam Vargas

