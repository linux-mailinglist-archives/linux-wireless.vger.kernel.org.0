Return-Path: <linux-wireless+bounces-37007-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mM5FIZDkFmpIvAcAu9opvQ
	(envelope-from <linux-wireless+bounces-37007-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 14:33:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CA85E43B2
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 14:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C6CA30960C2
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 12:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0C73F6612;
	Wed, 27 May 2026 12:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcZVwmz8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926013F5BD9
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 12:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779884696; cv=pass; b=nP7pbFjHVLcQKC5GKdqKpz8biwI7CEe1APtf9jGIejtCezjd+CP+wpBrU61EME2KyeqRCcU17xcZUO3Lw/qzjVivjNK7mG/y+HYLCxuHbJTPOcUrWEiFX4fhCi3v1uOm3Tf97/Jpw9GUza0ReuH9cQa60XZZ3hRPca29ryLnOz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779884696; c=relaxed/simple;
	bh=UotFyGaxYvOTLZVRph8bKXeo0fn6Lh3dZwzXh0/xVV8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=urvH9qWsj4mfC3s3vAjVWBM34XfLEjurBn7Xvc40gnhQrMRe6YAkssAwyNkSZ8r+Nb1qyL0YlPtbPoAI/G8Bzh1Xhrfc0lXhZkfA9/DRGugqMLrXHCn8xn2rIO99t6IKsmYZbYHTMe5k1rLOirD5/A7FLGIVH0FS1HMYLFWJdak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcZVwmz8; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aa0cf8bca3so10681997e87.0
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 05:24:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779884693; cv=none;
        d=google.com; s=arc-20240605;
        b=NxN6USy0L2BQT+HBrEII3V0tDGMYsmdoS/36QvA7RKK6NF5U/UlnApD8qa7e+/+PGN
         CBPdVEKbtTvaz7fvLAYqGoG+MfaKTAsFkJ56EHO8WuSednLHAXjHZJcDTuKyisi89bsY
         p3p3mmrPgGy+B4BKbMxitcZGXfhqaGT01EJQqjLEg3Hc3kL4yY1rH6DgrQ7d9rR7mhfm
         fOcIckcnr0ra1yJSNWIcgmUXY8VLRvP+sVcHNNnqzWPUJZiDJ7OJTtuQXCYaplVO7fH7
         XN6dwfLyASnhrkKqp4V20mV+zyRPM30cguNFXpWfTpJPF3f78wAeoJmhMtSOgCKuvBUH
         CcdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=RUZRWrbEXU24iyCbbrl77+mYjH0y6gf2VXfudYwaXFo=;
        fh=IYJgr3wpDQK+w7L8vcclAB8xiJplZSAdsonuGHpAthM=;
        b=W6I02xGvCyGF5BMZYPieqXGCfeO+F6F18ZQkGzdnlqcgELvPovg/no2FtOKSgC2nms
         ov8V0p8bjDbjxcCQxQaRD1UDjWQP8S9GFVtN4Fpx8bWsLqKcaMYrCslnd5z2cgEhPHGK
         GoHEa8QvIIbm+Egr5aIjROWQFDiuqbVhrKpwKiIAB8ZfMP3q8J+9n2sFggnp6udhu+ax
         HYaU5ri5UUl7a1hpeeNA8lVGG0tZuSqj2Qou7JMtPZy9UekyaxbPRVQuJV+WJZdtmdCW
         LmxwNILThKPnr5IqirxcrJTJClqZlgTsOdgIw9tlm6NEo6Q1X7BlNXpORW84L4PjQ6OZ
         QG0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779884693; x=1780489493; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RUZRWrbEXU24iyCbbrl77+mYjH0y6gf2VXfudYwaXFo=;
        b=YcZVwmz8gMzbmcDBdTUXhNejEVLLPLdA0jdzN4G6TOQw0YWzfz2soxusmEwIrjAde2
         gElvVe38a0Jg4b7UbEY0ZqbNpHPnJqMNp9JMhBm+dSVfSZ6a06hmwk2mrtU9qKUfOWKH
         +4P05hpKHVjPQtXdyCRyngWz3VJf0TRa8+cYM6NSVPzpFHPXgB9mlcoYOQIf/qSSGIib
         Dbh6AQBYQ1yKnAdDxs3aBpHBDZgPzE+SgTrPmRgiqskZHABHOHKI1VXg6GblLfb72zpO
         8v5WWowUgBKJ5OFh8lQ6PnrGFmpGmgP0xVn0+e7icTTXoswb7b5LPzSET1A0jtrCG1T/
         NPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779884693; x=1780489493;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUZRWrbEXU24iyCbbrl77+mYjH0y6gf2VXfudYwaXFo=;
        b=oLmHN/sA3g0oJmyOj0dDJs1pix5q7UDkL5f0nrTJPUXLovzCJFuChkB/WcleqhRyXm
         5QTyN2PLR/Yvrh9TIv6348xY1hQDFFccmdlGI5pxEntR4RbUEZfNovVl6/fuov8TGQI+
         n+2UQKsuSiyjt5gdqT/aPKU0eajH/5ZtiQej4dT8qkTxBRp/NITTm6Ti3DKgE4tvmVl9
         O+WLbzCZkLDxOS3lzeRCnHWXNiSIZg3S/4shmhv2ANnr5KlshXMFT1O8G+NuhD+bDfdx
         igQV5p5xQsKmPwr3/qRqCLC5NtYKoiDRyg1nhkIUO/YnvIMCpFU2uJLo6pH7SpnUASSf
         rGHA==
X-Forwarded-Encrypted: i=1; AFNElJ97TvODKMl0gBYBqRlF9c4cTYeGMxRqBONehsKnns0S35pMNZ8JXXLzRWnnh8oQVtaBfqM+bTiQbYAWZaXyHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZTlb4C1enk3Wigp66E9es+YSCS00FpsUznBDvSvFb/4YY5Xfm
	XG2057+V99Og3YLmFJCmXnpIToRq678no6OJ82/Hd+COasg/jq3NU2OZewj9DEofi/vstg9aDmM
	PHga1GOtep0H1DK+4s45rtIFrJBcsJZGcPUKBsx0=
X-Gm-Gg: Acq92OH+4pXF0pja9tWIOXV7Mz4wVs9YC7FZ0f6uu1WKlCCsjs/0qLJE8mkEdNZfW1w
	Y1tSercpUwI2PhB+1olVjpWk0q6Qkale0hYJ/CA21k68u81iRKCMcXeY+Q0cA8bRJ9q9OTey7iL
	9SMj+1I9h44MJz0uvNDxUbkC/SX3UUyfvtb9y+x2PV8+3btcrVR7uN4iZ02N0Yk3JGGRmAc555X
	YOa1ud61bSrv1odxsPBqXmwZQAu60peo3F8X9IMWTvaV2d3oYT6ncRZyOWr51LBseOwfnNHq/qw
	gtPpNt2O1qm8HFFJJg==
X-Received: by 2002:ac2:5625:0:b0:5a8:7701:b815 with SMTP id
 2adb3069b0e04-5aa3237d537mr5419916e87.8.1779884692286; Wed, 27 May 2026
 05:24:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: John Henry <jshenry1963@gmail.com>
Date: Wed, 27 May 2026 08:24:39 -0400
X-Gm-Features: AVHnY4JkDJI6tcD9rdJGDYLvoe374uGsxsOSvUe06lI88pIIqwfblneWcp6ZKVw
Message-ID: <CAN6xzWcVDRLVTV-SQcs6osZjnfhLM728NP7+W8+sFcTDmeVipw@mail.gmail.com>
Subject: [bug report] wifi: mt76: mt7921: mt7925monitor-mode per-channel
 retune emits narrowband RF burst
To: Javier Tia <floss@jetm.me>, Bradley Pizzimenti <brad.pizzimenti@gmail.com>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, nbd@nbd.name, 
	lorenzo@kernel.org, ryder.lee@mediatek.com, shayne.chen@mediatek.com, 
	sean.wang@mediatek.com, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Deren Wu <deren.wu@mediatek.com>, 
	Nick Morrow <morrownr@gmail.com>, Sean Wang <sean.wang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37007-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[jetm.me,gmail.com,vger.kernel.org,nbd.name,kernel.org,mediatek.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jshenry1963@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:url,mail.gmail.com:mid,jetm.me:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nbd.name:email]
X-Rspamd-Queue-Id: D8CA85E43B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Just a kind reminder of this issue.

Please advise if this is already taken up in a separate issue I am
unaware of, but it is not directly related to the "iw set txpower
fixed accepted but ignored" issue.

On products available in the market, e.g.  the Alfa AWUS036AXML
consumer product and the Netgear Nighthawk A9000, in Monitor Mode
there is RF generated when scanning through channels and we get to 5
or more channels in succession.
This does not seem to occur at all in managed mode.

This means if we scan the 2.4GHz channel list, an RF Spectrum analyzer
will show a narrow pulse generated on each channel as we progress
through the channels.
This can 100% be reproduced using standard iw set channel commands as
shown below:
FACE=3D$(iw dev | awk '/Interface wl/ {print $2; exit}')
iw reg set US ; sleep 1
ip link set "$IFACE" down
iw dev "$IFACE" set type monitor
ip link set "$IFACE" up

# This triggers narrowband bursts at channel center on each retune:
while true; do
  for f in 2412 2417 2422 2427 2432; do
    iw dev "$IFACE" set freq "$f" HT20
  done
done

No special software required to reproduce.
I have shown that this occurs on all MT7921 based products, along with
MT7925 based products.
It does not occur if the channel list is set to the same 4 over and
over, no RF generated.

There are no calibration channel commands going from the driver to the
firmware, so I believe this is a firmware bug.

Best Regards,
John Henry

On Sun, May 17, 2026 at 9:01=E2=80=AFAM John Henry <jshenry1963@gmail.com> =
wrote:
>
> Just a kind reminder of this issue, has anyone been able to reproduce
> this monitor mode issue?
> When scanning through channels, and the list of channels is > 4, there
> is a large transmit tick/burst coming from the MT7921u and the MT7925.
> This can easily be seen on an RF Spectrum Analyzer.
> Confirmed on an Alfa AWUS036AXML consumer product and the Netgear
> Nighthawk A9000.
> This can be reproduced with simple scripts.
>
> Reproduction with stock iw commands (no custom code):
>
> IFACE=3D$(iw dev | awk '/Interface wl/ {print $2; exit}')
> iw reg set US ; sleep 1
> ip link set "$IFACE" down
> iw dev "$IFACE" set type monitor
> ip link set "$IFACE" up
>
> # This triggers narrowband bursts at channel center on each retune:
> while true; do
>   for f in 2412 2417 2422 2427 2432; do
>     iw dev "$IFACE" set freq "$f" HT20
>   done
> done
>
> # This does NOT (only 4 frequencies):
> while true; do
>   for f in 2412 2422 2462 2484; do
>     iw dev "$IFACE" set freq "$f" HT20
>   done
> done
>
> Bursts are ~800 kHz wide at the base, -30 to -50 dBm OTA at close
> range, brief (estimated few hundred microseconds), at channel
> frequency. tx_stats counters remain zero throughout.
> On Mon, May 11, 2026 at 1:58=E2=80=AFPM John Henry <jshenry1963@gmail.com=
> wrote:
> >
> > Bradley/Sean,
> >
> > Thank you all very much for the information.
> > I tested this on mt7921u based Alfa AWUS unit and also an mt7925 based
> > Netgear Nighthawk unit.
> > I can confirm that the RF tick issue is present on both models when in
> > Monitor Mode. I'm assuming it is in the base mt76?
> >
> > I attempted sudo iw dev wlxxx set txpower fixed nn where nn is the
> > minimum value, next few values up, and then a few near the max values,
> > and see no change in the signal strength of the RF Ticks when scanning
> > through 5 or more channels.
> >
> > Please keep this in mind when attempting to resolve the known txpower
> > 3dBm issue if possible, or please generate a new bug report for that
> > specifically so that I can track when it is patched, or in ??? version
> > so that I can test here locally.
> >
> > Incidentally, I'd appreciate it if anyone could please attempt to
> > repeat using the scripts I had shown in the previous posts and confirm
> > it is indeed seen by others.
> >
> > Thank you very much for your time and assistance
> >
> > John Henry
> >
> >
> >
> >
> > From: Bradley Pizzimenti <brad.pizzimenti@gmail.com>
> > To: linux-wireless@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org,
> > ryder.lee@mediatek.com, shayne.chen@mediatek.com,
> > sean.wang@mediatek.com
> > Subject: [bug report] wifi: mt76: mt7925: iw set txpower fixed
> > accepted but ignored
> > Date: Mon, 4 May 2026 15:04:35 -0700 [thread overview]
> > Message-ID: <CACjnFagN9zeSkwEv3-CSPJDUENPcEcOLjKyQoLQ91Yjn=3Drq5ww@mail=
.gmail.com>
> > (raw)
> >
> > Hi there maintainers,
> >
> > `iw dev <iface> set txpower fixed N` returns success on mt7925 for any
> > N tested, but the reported txpower never changes from a stuck value of
> > 3.00 dBm. The kernel accepts and ignores the call silently in both
> > directions (above and below the displayed value), and well below the
> > regulatory ceiling.
> >
> > I'm aware there's prior art on the cosmetic 3.00 dBm display issue
> > (Razvan Grigore's v2 series, Feb 2025; Ming Yen Hsieh's txpower init
> > refactor, Sept 2025). What seems potentially distinct here is that the
> > user-issued `iw set txpower fixed N` itself is silently no-op'd,
> > separate from the reported-value question. Reporting as breadcrumbs
> > in case the second observation is a separate bug rather than the same
> > one.
> >
> > Hardware
> > --------
> > MEDIATEK MT7925 [Filogic 360], 802.11be 2x2, PCI 14c3:7925
> > ASIC revision 0x79250000
> > Driver in use: mt7925e (in-tree)
> >
> > Firmware (from dmesg at probe)
> > ------------------------------
> > mt7925e 0000:01:00.0: HW/SW Version: 0x8a108a10,
> >                      Build Time: 20260106153007a
> > mt7925e 0000:01:00.0: WM Firmware Version: ____000000,
> >                      Build Time: 20260106153120
> > Files: mediatek/mt7925/WIFI_MT7925_PATCH_MCU_1_1_hdr.bin
> >        mediatek/mt7925/WIFI_RAM_CODE_MT7925_1_1.bin
> >
> > Kernel
> > ------
> > 6.18.18-1-MANJARO (close to vanilla 6.18 stable; not yet tested on
> > wireless-next or nbd168/wireless HEAD -- happy to retest if needed,
> > but flagging the data point in case it helps as-is).
> >
> > Tools: iw version 6.17
> >
> > Regulatory
> > ----------
> > $ iw reg get
> > country US: DFS-FCC
> >    ...
> >    (5730 - 5850 @ 80), (N/A, 30), (N/A), AUTO-BW
> >    ...
> >
> > Connection context: 5GHz channel 161 (5805 MHz), 80 MHz, VHT-MCS,
> > NSS 1. So we are on a band with a 30 dBm regulatory cap.
> >
> > Observed
> > --------
> > $ iw dev wlp1s0 info | grep txpower
> >         txpower 3.00 dBm
> >
> > $ sudo iw dev wlp1s0 set txpower fixed 100   # 1 dBm
> > $ iw dev wlp1s0 info | grep txpower
> >         txpower 3.00 dBm
> >
> > $ sudo iw dev wlp1s0 set txpower fixed 1500  # 15 dBm
> > $ iw dev wlp1s0 info | grep txpower
> >         txpower 3.00 dBm
> >
> > $ sudo iw dev wlp1s0 set txpower auto
> > $ iw dev wlp1s0 info | grep txpower
> >         txpower 3.00 dBm
> >
> > All four `set` invocations return exit code 0. The reported value
> > never moves.
> >
> > Expected
> > --------
> > Either:
> >   - The reported txpower follows the requested value (or, where
> >     capped, the actual applied value with extack indicating the
> >     cap reason), or
> >   - The set call returns an error rather than silently ignoring the
> >     request.
> >
> > Caveats
> > -------
> > - Not yet tested on wireless-next or nbd168/wireless HEAD. If a
> >   reproduction on a current dev tree would be useful, I can do that.
> > - I have not verified whether the actual radiated TX power changes
> >   in response to `set txpower fixed`; I am reporting only the
> >   user-visible behavior.
> >
> > Thanks,
> > Bradley
> >
> > On Wed, May 6, 2026 at 8:12=E2=80=AFPM Sean Wang <sean.wang@kernel.org>=
 wrote:
> > >
> > > Hi,
> > >
> > > The TX power reporting issue has already been investigated by Lucid
> > > from the Linux WiFi USB community, and there is a proposed solution.
> > > I think we can continue checking whether there are any remaining
> > > issues on top of that work. Please refer to the patches here:
> > > https://lists.infradead.org/pipermail/linux-mediatek/2026-April/10572=
6.html
> > > Thanks everyone for reporting and raising these concerns.
> > >
> > > On Wed, May 6, 2026 at 3:09=E2=80=AFPM Javier Tia <floss@jetm.me> wro=
te:
> > > >
> > > > On Sun May  4 22:04:48 2026 Bradley Pizzimenti wrote:
> > > > > `iw dev <iface> set txpower fixed N` returns success on mt7925 fo=
r
> > > > > any N tested, but the reported txpower never changes from a stuck
> > > > > value of 3.00 dBm.
> > > >
> > > > Hi Bradley,
> > > >
> > > > The 3 dBm display bug is a known issue we have seen when using mt79=
27
> > > > and a tested fix has been working well so far. The root cause is th=
at
> > > > mt7925_mcu_set_rate_txpower() programs the per-band SKU tables into
> > > > firmware but never assigns phy->txpower_cur. mt76_get_txpower() the=
n
> > > > computes:
> > > >
> > > >   DIV_ROUND_UP(0 + 6, 2) =3D 3
> > > >
> > > > regardless of the actual power level. The RF output is unaffected;
> > > > it is a display-only bug.
> > > >
> > > > The fix reads the effective TX power back from the rate power limit=
s
> > > > after programming the SKU tables and writes it to phy->txpower_cur,
> > > > following the same pattern used by mt7996:
> > > >
> > > >   https://github.com/jetm/mediatek-mt7927-dkms/blob/master/mt7927-w=
ifi-14-fix-reported-txpower-always-showing-3-db.patch
> > > >
> > > > This is part of a series we are targeting for wireless-next; not
> > > > yet upstream.
> > > >
> > > > > What seems potentially distinct here is that the user-issued
> > > > > `iw set txpower fixed N` itself is silently no-op'd, separate
> > > > > from the reported-value question.
> > > >
> > > > Agreed those are two separate issues. Our patch addresses the
> > > > display-only side: after applying it, iw will report the value the
> > > > firmware is actually using based on the SKU tables, rather than
> > > > always 3 dBm. Whether `set txpower fixed N` propagates to firmware
> > > > to change actual output power is orthogonal and not addressed here.
> > > >
> > > > If you can test the patch on your MT7925 and confirm the displayed
> > > > value reflects the correct power after association, a Tested-by
> > > > would be appreciated.
> > > >
> > > > Best,
> > > > Javier
> > > >
> > >

