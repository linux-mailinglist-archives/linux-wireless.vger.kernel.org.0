Return-Path: <linux-wireless+bounces-34908-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKDcAOlS4Wl5rwAAu9opvQ
	(envelope-from <linux-wireless+bounces-34908-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 23:21:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66ECC414E20
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 23:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E03553017FA9
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 21:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475523947B5;
	Thu, 16 Apr 2026 21:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iL9bptGt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50D539478F
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 21:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776374500; cv=pass; b=R04I8wN61u2PLe6FgFlHnjmqUQlo8zUYYNB0DRexq3o6+W/4nrA+m4WD1IOLhaihUQTnzjV1gvgBqVZlg+T9leq5CqhPwJfrmVOKo7jALbtS6RP3FSUhxlYEYs9g8apluC5chXobM/qEc/SPzLHNltILWRGG/iB19u0rsQdHXdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776374500; c=relaxed/simple;
	bh=i9rNnwTpoO+eqDzaippeUCmIIbN9U1gm3TO1fVYUwIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k2Gm0zhdPIAr9aUQp1IoSdj2Z+oeLZZzcs31weskRL62/+VmE8mfC1Aq1CY4HRRR2cuSkiu1yG7Z1ZhYZIg2T58D/+ieCvnmIDX52UA+0hoqLyCfSjR4eBID3lMngZjjHZkWCd7oi1TsVGjuQ6VLTLcoepKDA+5vSR5xYctL7SE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iL9bptGt; arc=pass smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7dbcd61429cso11274a34.2
        for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 14:21:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776374497; cv=none;
        d=google.com; s=arc-20240605;
        b=JtiiDAdP7aiAey1QDNCTHTtPRd6iimXel2A+F+phItixctxJI4bcHh5mUsCuSCBCyB
         6vYjceveOvhOLiK4HSRW7Je1EfFwgPdnjIvJGddVOU9pkvb4pcWGj+UfNeUqZe6i9HQo
         GRWMe8Jx52DEEl4QFan75e/dFpNnotYZVmVpOLIVhpGkwc8kExEh88qJM1KKrqpZVZC4
         6k37bMrzK9thcqoKGz2GTvR9nGXCvsfWyTJsrMyVscepHMSyCNc/URjuf7HXsezrrufZ
         krkecs+Io4AIuLprk5HmYGfG9uENsVOUuNqyDrxEDxXJiod/3tD1xSQaLWZ+qw2XMlO8
         wyCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mk45EJR1eQYrgkI1k9upoEBz9Is8b636VK003Rnf45Q=;
        fh=T0Ey18rrLxlO+CsVj7eVQ82PPeTki6qXIgqqPSiSYR0=;
        b=ILSW8JdyPWLIJroJ3h1/9T27IXOK0rBCBbThAZXC9pU6NBZ2BghIzxh04agniPIloN
         xCdRH9pyIsEwX3L4l64WWpdefFPNCLwIccp/+JeHuSEggeEAzv3YhhMQ6u7XzTghNiT6
         I0TGTKOrGPJ1d31BxeWO1Y/IzYgavKUyD66RXGc/Ul2o54qCQGbGwfRxv/ffNH/Yrtw7
         /6Bdl187JQQ884xQCtCGXq93zkJ/eKl2CxnMa5sJ33L/GNEZmWfCKgzrVT+zbs0vJZpb
         UKMn+ISriKpYyEJYiy/kHBnct6QPF+IDHzIx/FxBnoP/bfdt7oyJAuLrvCNh1I9QSWPp
         Vkdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776374497; x=1776979297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mk45EJR1eQYrgkI1k9upoEBz9Is8b636VK003Rnf45Q=;
        b=iL9bptGtIGS1N9TcY9m7K3/vjwyNWN3SOsZIeT5f0ENispEUTO/6RjmQcqZUaM9sGd
         R7dhPcBYAvAvSXuWJUjbx5DTMo/NokGm6FGCID1nlHnOwi9XKRFqofjrR+whluS3m7Gl
         VAd7I3APiNrrfehvG4SySRp6uB/iPgVG9AgDGT1HZ7scolfgTdwAiGgkvtxH9Tnr0H72
         cF0aHq7p2PHMDsgth72FmlXJas74QEzd+Pv3NRQ1Ypwg0CEiY/gg++w1C6S3lhJ/G8SA
         w1thUdCTb1alZy6oQbbkGsCRh5QK7vbDQwNyM0rV4TMBQHNy9S3gpZZE4/9VWgTPIgea
         f7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776374497; x=1776979297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mk45EJR1eQYrgkI1k9upoEBz9Is8b636VK003Rnf45Q=;
        b=AaW72cVFcu0LRtC0XmlBoyyl9MjK0G6xRqY5o5RVkwrkBTbeTuo1Rcxig5Ak6cheWt
         mFvvNlLEIbI1HWP0nYN2YiR9SxbDYPVEJI5Hrkekl3uKBsC0tfHHm78qEpBDIyJ13g9B
         h/Bb3YUpz70UgKutPwVM1NLv8K6rwBzboKZVsSLG8qjuCxiKpBJdAnTQ/w2pmvdw2uIX
         wH+QD9D8FrQADHaMRWvHlzMLIc/pR0hLaMl2Xzg0Y7+SVDEmv+mRodBx4HQU4ZroyxYv
         hF/sItpHhxFLPvR0hV6iTTlRTyzzIVI+CHBF41GWSKeKTvokUNuXtD8z1R+87WiTwRu6
         anTQ==
X-Forwarded-Encrypted: i=1; AFNElJ/wyY6/LNwFHkMrLj5ycK77ezyT17yfHkzCEepYLWpBjYoznZpX2tZ1fWEdjMUtwyRQmdsYjBUiXKajk/2wgw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOdXE7xhZlzmrQJEJKrPHeT/dkD8TTYAQmxAyvzIHSC/fkVcC9
	hunnxaj54fRlxaF+sstJeUgYN6AIAJ9Q6X3gJMl8LvqJVrx0nrP4v/iLEj3d1Wxj7ppZwhe433V
	b/OBWllBLT8tLETK88HR46ME6W3ExZOXV5E+/83fCpg==
X-Gm-Gg: AeBDieusQkYOg/Rbdc9zsIvqfyXvfJ5hcMXx/Seknz+tlN69Dc0EECdBdMvEJm3WDa6
	z+b5njd4uJdHYtmazYzvFrPVCGnabDYd5lae5j7nh6CaWIyFENDE1368j8zVyGWbSQ88QjmK7RT
	0q90/imXpBNlnSzfuYsa1eq5U6fGwjsTSQIaOtj0MqrHlolGuRSf1wmBMOw1bfSJ8080+Mpy0Qe
	Zc40Ber/3Qj40zpDfEqihj/OjJ47tPXoKfhNBPEC8zdGWQAALwd658Y9XLQOcFgn2oqOKoBabZ9
	F/1mk2ziQ6xI6vMkewA=
X-Received: by 2002:a05:6830:310b:b0:7dc:3e5a:64da with SMTP id
 46e09a7af769-7dc94f85a85mr160920a34.5.1776374496599; Thu, 16 Apr 2026
 14:21:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414194757.163339-1-npetrakopoulos2003@gmail.com>
 <20260415052959.14844-1-npetrakopoulos2003@gmail.com> <ad69b2f3dbc74ea6b9b1a17f2a77fbb4@realtek.com>
 <CALdGYqSepO3xy9UerKXFfKLdj1BS1jGQh5YgkcSHrxYYY=n3Kg@mail.gmail.com>
In-Reply-To: <CALdGYqSepO3xy9UerKXFfKLdj1BS1jGQh5YgkcSHrxYYY=n3Kg@mail.gmail.com>
From: LB F <goainwo@gmail.com>
Date: Fri, 17 Apr 2026 00:21:00 +0300
X-Gm-Features: AQROBzCz-xPeKfQ8D1BsLCPG0yEBFok1LhLzuLdiYxEjMd7wA_47ZmemQsLyw-E
Message-ID: <CALdGYqSPY+bHQiQQq9z1F_F2NP8-tZMVy5A5qisnbg+5AmBeFA@mail.gmail.com>
Subject: Re: [PATCH v3] wifi: rtw88: Add NULL check for chip->edcca_th in rtw_fw_adaptivity_result()
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34908-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 66ECC414E20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 15 Apr 2026, Panagiotis Petrakopoulos wrote:
> Add a NULL check for edcca_th before dereferencing
> it in rtw_fw_adaptivity_result() in fw.c.

Hi Panagiotis, hi Ping-Ke,

Following up on my preliminary note from yesterday =E2=80=94 I have now
completed a structured 27-hour stability test on the affected RTL8821CE
hardware with the full set of patches applied.

Test environment:
  - Hardware:   HP Notebook (DMI: HP P3S95EA#ACB)
  - Chip:       RTL8821CE (PCI ID: 10ec:c821)
  - OS:         openSUSE Tumbleweed (Slowroll)
  - Kernel:     6.19
  - Driver:     lwfinger/rtw88 out-of-tree (DKMS)

Patches applied on top of the out-of-tree driver:
  1. [rtw-next] wifi: rtw88: add quirks to disable PCI ASPM and deep
     LPS for HP P3S95EA#ACB (Ping-Ke Shih) =E2=80=94 pci.c / main.h
  2. [PATCH v2 rtw-next] wifi: rtw88: validate RX rate to prevent
     out-of-bound (Ping-Ke Shih) =E2=80=94 rx.c
  3. Diagnostic hex dump patch (Bitterblue Smith) =E2=80=94 rtw8821c.c;
     logs raw RX descriptor data on "unused phy status page" events
  4. [PATCH v3] wifi: rtw88: Add NULL check for chip->edcca_th in
     rtw_fw_adaptivity_result() (Panagiotis Petrakopoulos) =E2=80=94 fw.c

All four patches were verified to be present in the compiled
.ko.zst module binaries before testing began.

Test methodology:
  - Continuous ping (50 packets, 0% loss)
  - High-throughput RX: 100 MB file download (~6 MB/s sustained)
  - Bluetooth A2DP coexistence (Soundcore Q10i) with simultaneous
    WiFi traffic
  - Suspend to RAM (S3) and resume
  - Suspend to Disk / Hibernate (S4) and resume (**)
  - Reboot =E2=80=94 verified DKMS modules reload with DMI quirk flags acti=
ve
    (disable_aspm=3DY, disable_lps_deep=3DY)
  - Download interrupted by suspend mid-transfer, followed by resume
  - 27 hours of general-purpose uptime

(**) Hibernate (S4) was the most critical scenario, as the original
    crash reports correlated garbage RX bursts with post-resume
    conditions, typically within ~90 seconds after the adapter
    re-initialized.

Results:
  - Zero kernel oops, panics, or system hangs across all test scenarios
  - Zero "unexpected RX rate" events
  - WiFi reconnected cleanly and automatically after every
    suspend/hibernate/reboot cycle
  - 3 isolated "unused phy status page" events were observed during
    the first ~2 hours of uptime (pages 7, 9, 10), with zero
    additional occurrences over the remaining 25+ hours

Those 3 isolated events confirm that the hardware still generates
the garbage RX data described in Bug #221286. However, the NULL
check now causes rtw_fw_adaptivity_result() to return early before
dereferencing chip->edcca_th, preventing the oops entirely. The
system handled all three events silently and continued operating
without any disruption.

The hex dumps below were captured by Bitterblue Smith's diagnostic
patch (patch #3 above), which instruments rtw8821c.c to call
print_hex_dump() on every "unused phy status page" event. This
confirms the diagnostic patch is functioning correctly alongside
the NULL check:

  [ 5366.904709] rtw_8821ce 0000:13:00.0: unused phy status page (7)
  [ 5366.904723] 00000000: 4c5635d5 174b302f 0945df3e f4ebe6d8  .5VL/0K.>E.=
.....
  [ 5366.904728] 00000010: 08726c23 3e7be907 8a76d3a7 cd252c75  #lr..{>.v..=
u,%.
  [ 5366.904738] 00000000: 88 42 80 00 8c c8 4b 68 d1 63 6c 68  .B....Kh.cl=
h
  [ 5366.904742] 00000010: a4 1c 97 5b 6c 68 a4 1c 97 5a 00 43  ...[lh...Z.=
C

The rxdesc portion (lower dump) shows recognizable 802.11 QoS Data
frame headers with the adapter's own MAC address (8c:c8:4b:68:d1:63)
and the AP BSSID (6c:68:a4:1c:97:5b), fully consistent with the
garbage RX pattern documented in Bug #221286. The phy_status portion
(upper dump) is random noise with no valid structure =E2=80=94 exactly as
Bitterblue Smith described.

Tested-by: Oleksandr Havrylov <goainwo@gmail.com>

Thank you to Panagiotis for authoring the fix, to Ping-Ke for the
prompt review and Acked-by, and to Bitterblue Smith for the
invaluable diagnostic groundwork that made it possible to understand
and reproduce this issue correctly.

Best regards,
Oleksandr Havrylov

