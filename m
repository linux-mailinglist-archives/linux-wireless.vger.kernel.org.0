Return-Path: <linux-wireless+bounces-32652-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGfYNuUpq2luaQEAu9opvQ
	(envelope-from <linux-wireless+bounces-32652-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 20:24:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 492FD227068
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 20:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3534301C5B7
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 19:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A1336EA80;
	Fri,  6 Mar 2026 19:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuJcYofz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C404734B662
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 19:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772825059; cv=pass; b=nRr3029HaigAn79DBkuxAL6gcAO4lSpuu1BpJJ5wcE44sT4t3qYv6oPfnsipDwoh0eMpjfgUgDsAVd7pjfEwRgCoFR80skaFlFuVJWp2bzoivnojRxhh8xGkqdYygZmaszWWmggxzq5k5fa04CiEi1SaCtrzQLNvbgyShUfPBmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772825059; c=relaxed/simple;
	bh=WEttK6q8QiFo1/wJrdw1NHezI53/xbxB5o7MJRtdrdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EqpsX4/kvBQwLhRCnidaCuDKjAaW1BJFxjdEQ/xYmryi2EHgtUZ3Z+K2K+hTTEDTCkmz5n2xmbXYY1yvhNqjpY6lvpfGnklGvnKYqUDacEEG0fGnqBLu6+UtWJUcGfUiqsGRkHLb3MZKSbIY5UofQIaZfRd+rgGt+EeF9N62Irw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuJcYofz; arc=pass smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-899ee491af3so65270076d6.1
        for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 11:24:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772825057; cv=none;
        d=google.com; s=arc-20240605;
        b=CtA59XagHzADxW1cSwYXV4jkdH70+NTGJe9mq83hfB3hsWFsRSdvjYt1WD2xpKbG81
         mAPAMJSRWzb6cN/L9Gtql3hEhihY57YLWuG1RXeW1egrOttSQNel90X6IPFZ+RSSbUWd
         NB+TVv32flp8x+X/93Mkyszd4VWEOLBEr42uE5aEb/jKrTqTD66cpXWLM1B8NXgDhFh7
         L7f+N1sKJGJnaFlC09yos13l/QpmHynWBaBv6kQ4WF7DCHVIfPknJGGIAisvvdOr/imb
         jZAMEj5c/rf5Uoz2xUMcwrgcbIJU/KcIPEXp8Mq1PzHQ2LKUbMUNVWRI9FufbUXndwVy
         IAfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pIHX4XxyGgMtkUvBsJkxevkafLCMKRJmj0r7kVwPdKM=;
        fh=catXQ7Tn+OxyEnd2v3aLqF4uQdbmZNB9gk3U7d+3rvQ=;
        b=F8ZY/OX1w309z+f6HBj7zEGgZE3pDqAwQwxrkKy8QCG+ND52Fw09Ls1zz4J5NjpZWu
         J58tzZcuqLpL8RN1iQaBJFDnJ2XPAc5/JwvTDszvU04YGQbjTafPtUlji6Jf6rCf5pIF
         OjQED1thTltK9la5ER0lfJjgDRDyILLdSn8VwF/Dfp+DkwxCvCCT7W7eLCjhIkMzwsQM
         Lt1LgaqW1q9FHY6XqkLOiM9Opx86Zc9qwkMtC62jSCSfPgkY+rMbwrjSSzJkJUR06N2w
         jgkTympnKdNRQ0KN1FYbDEJxtJjVoG5StfXPMAXYgpu6/ZzvW/dRbrodZQz1aY9zAEkY
         bC7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772825057; x=1773429857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIHX4XxyGgMtkUvBsJkxevkafLCMKRJmj0r7kVwPdKM=;
        b=iuJcYofzxF34zwSIDUuYP+cU07V0vhtCz+WPm8J7M+x6pMOeUkhTwFXI9HQb0q67FH
         v2IfSirYyvopPJizItCvMzGOTaCEVoRDU8UCSpQP8ULedIOPUymzmnGPkWUvVujZ7UWf
         4kWf31p8aYmFIdAasO0zsI29dbkuOBJwNgDIurdmN+IGpt4fWLlqcWLqqbAa8XM78xAM
         SNh9DR8ZNF/gY5eBj5SRiADSgw+taHf3v3StxuwufkGPWuOWnn3t+sJA53rNpmQhZhtM
         9CNuawIlKzAnSxAAbz35zQFQHQ2VDPTdtkkG18NdXym8j0/W3vmUTu85KqiBgMA8Bwwb
         WRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772825057; x=1773429857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pIHX4XxyGgMtkUvBsJkxevkafLCMKRJmj0r7kVwPdKM=;
        b=PrCG2V6kHrRY3yk6cUuyElYv7MY337rN2Wb9YD1m1JcfEllqoJ8YTOlQemfUF9Y0F7
         RlGSELTwCymbIxSFs9iwSRFeiO9pDu8K0wlCXepvdFus+r9vblYKwImOmTL38ge80l6o
         01srkQMA3h926Q7KVaSXxImKJEhc7bwrll3lcTqBtVv28/kJLCVsDPluWkFiKZrvR+84
         T6rh0IaA8aznpDJKExT9A0LT5GaE+PkYuY57VJU6leSBnKZM4bRaGxMcZBIogMxxA4WV
         sDxutiSyw60Yb1t1UdEoIoTv2KOQENcFbgMvk8NeQCPEXQjSmWlPMH1EGOUuNeySAa/v
         1V7w==
X-Gm-Message-State: AOJu0YxzOzMKjvuj2EueLFt4Csbjl4xTKfIxe+LqsK5kqNhkV4UyVyi9
	cqK+9Kh5waPnzZ+cJaC7+BzypUvg+GUZHcsxsxDSWZ0uogPTCNqzOgmFHIRLmtf+bH9NO/gMqzO
	F8WtF57FeaIqBlP0TMYyTSFzvlmXDew==
X-Gm-Gg: ATEYQzxN+IFNNPeWoyS8mIuXxUmjAqWaPjqSp6w0ZA0SMwgJnucomn2lwEkjnI2juEn
	Tjvv1QvBOis5FIlso67or3lvQlXTTOnbemzHw4MpwpWmprgjyb/ntEFCOYnIhaFBmV2aQLVJwiA
	iSnMcxTtQxRIqmeiUU/zn3APo12m93d1W+zjW0dfiMJ6+SbjFxcD/AnBPPaUuGkUf66iPiSRhZo
	FNmoklIpqZuYNw6euZMPyzMuhTHqWTQh0nIeEzBXdyyKxotNIgwUttHOcyLNAvkQiidqJbka6OE
	bkQS+EKi/YVZOkgX7Q==
X-Received: by 2002:a05:622a:19aa:b0:506:9944:8cfa with SMTP id
 d75a77b69052e-508f46eb175mr40782011cf.17.1772825056739; Fri, 06 Mar 2026
 11:24:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFktD2eaVpRAJRkaGOj4y-m0woK-sNeCM+h_7A=9GELSce6TcQ@mail.gmail.com>
 <CAGp9LzrTMALkJKrGANTCzeG4KUDGwC1YJc8SRKNRriH3a9bnRQ@mail.gmail.com>
In-Reply-To: <CAGp9LzrTMALkJKrGANTCzeG4KUDGwC1YJc8SRKNRriH3a9bnRQ@mail.gmail.com>
From: Nick <morrownr@gmail.com>
Date: Fri, 6 Mar 2026 13:23:50 -0600
X-Gm-Features: AaiRm51Yz8B6N-Flc90a94kO0x9Pz25ZGocER4QIu-N_FSOdR88QB7SDONn2Zbw
Message-ID: <CAFktD2eG+nebKcNbw2imufSOz6MCR-SUXjcUQmDqJabNfwx4sg@mail.gmail.com>
Subject: Re: [BUG] wifi: mt76: mt7925u: probe with driver mt7925u failed with
 error -110
To: Sean Wang <sean.wang@kernel.org>
Cc: linux-wireless <linux-wireless@vger.kernel.org>, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Deren Wu <deren.wu@mediatek.com>, Leon Yen <leon.yen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 492FD227068
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32652-lists,linux-wireless=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.903];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[morrownr@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

> > Reference: https://github.com/morrownr/USB-WiFi/issues/688#issuecomment=
-3999038526
> >
> > The above thread is rather lengthy as we have been working on this
> > issue since Dec. 25.
> >
> > Testing with a Netgear A9000 USB WiFi adapter (mt7925u driver). Kernel
> > 7.0 rc2 and a x86_64 system. Additional testing with older kernels was
> > also performed with the same results.
> >
> > Problem description:
> >
> > Cold boot shows the adapter coming up and operating normally.
> >
> > Removing the adapter from the USB port and replacing it shows the
> > adapter coming up and operating normally.
> >
> > A warm reboot does not provide a WiFi interface and shows the
> > following in the system log:
> >
> > mt7925u 2-3.2:1.0: probe with driver mt7925u failed with error -110
> >
> > Using the commands rmmod and modeprobe do not provide a WiFi interface.
> >
> > Thoughts: The problem likely is not the module teardown. The problem
> > seems to be that the firmware (or the mt7925u driver) leaves the
> > adapter in a strange state such that a power cycle of the adapter
> > hardware is needed before the mt7925u driver can properly initialize
> > it a second time.
> >
>
> Hi Nick,
>
> Could you enable debug logs and check whether the driver can still
> read the correct chip ID after a warm reboot, and at which step the
> initialization fails before the -110 error? Thanks for continuing to
> test and gather this useful information.
>
>          Sean

Hi Sean,

Github user @exct has performed the testing requested and provides the
following report:

mt7925u Probe Failure Debug Report
Adapter: Netgear A9000 (USB ID 0846:9072, MediaTek MT7925)
Kernel: 6.19.6-2-cachyos

Summary
The driver can read the correct chip ID after a warm reload. The
failure occurs before firmware is loaded, inside
mt792xu_wfsys_reset(), which times out waiting for the WiFi subsystem
to reinitialize. -ETIMEDOUT (-110) is returned and the probe aborts.

Findings

Question: Chip ID readable after warm reload?
Answer: Yes =E2=80=94 MT_HW_CHIPID =3D 0x7925, MT_HW_REV =3D 0x8a00

Question: Which step fails?
Answer: mt792xu_wfsys_reset() =E2=80=94 WFSYS_INIT_DONE never asserted

Question: Does it reach mt792xu_mcu_power_on()?
Answer: No

Question: Does it reach mt7925_run_firmware()?
Answer: No

Probe Sequence Trace

mt7925u_probe()
  =E2=94=9C=E2=94=80 mt76_alloc_device()             OK
  =E2=94=9C=E2=94=80 __mt76u_init()                  OK
  =E2=94=9C=E2=94=80 read MT_HW_CHIPID (0x70010200)  =E2=86=92 0x00007925  =
=E2=9C=93
  =E2=94=9C=E2=94=80 read MT_HW_REV    (0x70010204)  =E2=86=92 0x00008a00  =
=E2=9C=93
  =E2=94=9C=E2=94=80 read MT_CONN_ON_MISC (0x7c0600f0) =E2=86=92 0x00000003=
  =E2=86=90 FW_N9_RDY is SET
  =E2=94=9C=E2=94=80 enters mt792xu_wfsys_reset()    =E2=86=90 triggered be=
cause FW_N9_RDY =3D 1
  =E2=94=82    =E2=94=9C=E2=94=80 write MT_CBTOP_RGU_WF_SUBSYS_RST  (assert=
 reset)
  =E2=94=82    =E2=94=9C=E2=94=80 write MT_CBTOP_RGU_WF_SUBSYS_RST  (deasse=
rt reset)
  =E2=94=82    =E2=94=9C=E2=94=80 poll MT_UDMA_CONN_INFRA_STATUS (0x74000a2=
0) =E2=86=92 0x00000000
  =E2=94=82    =E2=94=9C=E2=94=80 poll MT_UDMA_CONN_INFRA_STATUS (0x74000a2=
0) =E2=86=92 0x00000000
  =E2=94=82    =E2=94=94=E2=94=80 ... timeout after ~212 ms =E2=86=92 retur=
n -ETIMEDOUT
  =E2=94=94=E2=94=80 goto error:  (mt76u_queues_deinit + mt76_free_device)

Root Cause

After rmmod, the firmware leaves FW_N9_RDY asserted in
MT_CONN_ON_MISC. On re-probe, the driver correctly detects this and
calls mt792xu_wfsys_reset() to recover. However, the WiFi subsystem
never signals completion =E2=80=94 WFSYS_INIT_DONE in
MT_UDMA_CONN_INFRA_STATUS (reg 0x74000a20) stays 0x00000000 throughout
the retry loop. The subsystem is stuck in a state that the software
reset path cannot recover from. Only a full USB power cycle clears it.

Hope this helps,

Nick

