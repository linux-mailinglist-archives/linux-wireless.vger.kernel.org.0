Return-Path: <linux-wireless+bounces-34187-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wH7GJ+Vfymn27gUAu9opvQ
	(envelope-from <linux-wireless+bounces-34187-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 13:35:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2388F35A54B
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 13:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46117300C820
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 11:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B7B3BC66C;
	Mon, 30 Mar 2026 11:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiHqJX4I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B11A2D97B7
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 11:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774870482; cv=pass; b=TPCRbl1Ac+vdENSag0ReoK+gg+4YyqFdTvffoVaI6q+L/lYGuIls3J4MEBNLzStqaxuqkaEq9TJFAFSfePH6Eo3UlWlQ208a9cWN8148M96ydloby7fee8aiAgi+PD/3pAFIMfzlaTzvobRrxBlw6oAoZelt+dajx5lpeNJ8yW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774870482; c=relaxed/simple;
	bh=aoubMhwcdnby79su040aenM/eFJAm3gcqXIJS9sonuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u0fbzb+AShh0MyqhQG6VPwOIHh9FdTdx9+dmhcqTWLL1I8gxh3waKvKf+R0jPvQVSgyV8Ien+t39yCQ0r1JD1hZj2NA6xcoP4Rl8R0XY8L2G1SWYBlaD/rcvdRDbWU24E3s6qwvx4PDAIFYP0oU+CnwSr+MfVDBtulZvGI4pd+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiHqJX4I; arc=pass smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-67c250805ccso1618088eaf.1
        for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 04:34:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774870480; cv=none;
        d=google.com; s=arc-20240605;
        b=J4AEb1bQMMSptjj+5nXRJQJJExGKsdgx2YJzWOBx+aVsV/sGDdtwPY7jYXwE69CD1t
         em73ehlgjabRxa1XUB1VVKP0yd0i2NhgORUXHoak1A5XiafNl8iq8QVJqGHZWgpZI+U3
         RUalJmHJvNsHfqcdQ1GK7ysMId0zx+KFO4/MRALQxmhhTf+C+gCNTBJkNbUcSuUj/1tA
         nNZu1w91DC5f8cIEtaKkMZcB/5/OHO8mzefDtQj6p5htZgpDw9a801AkRawGYPBVhy28
         e61u9Trk1imefxWd5zp1cnIcbhjelXXZXuEW9qAwF4OeoAHgzVnm07/8R6DMhDn3zhcn
         6w3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rqARNcuRlfvbzOSZlcUzdW4BysRbTXBQSK7rJV9/C6Q=;
        fh=n1Uo08K0eJHLW23Ct8eVBV04Xat4DSo8H9MqTio2voQ=;
        b=k+vqerHk2xPM/GRb1JP0AY0CRTmaW93l57Ld2tacaWi+3YHVj5gguthHBIjKxuxb4m
         OMHibAFBlEYxxafLtORLtu316++9Q5+WqpuN3RNvtivnMfiTJRPbFUD1KRnc2dn2jR3u
         fzcrJGTgOVKMDtMoGmSGIB6eoZ/3yDZOkcAqvToM/Q5y+0bOlaubhbZko52OB3mQUFC1
         y1UdwLhNaO2D2svmTHJiw2PuSJPM4TS6xneCCKdEElgLAcGVljdIuZPlc5JXsO/ySUPs
         yWqtofzQJArCxARCoXSP3CPAd+nfG4sFmirSHtoG+yQOeWGuTdW/ic4bcIVm+CRuyYDd
         0jxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774870480; x=1775475280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqARNcuRlfvbzOSZlcUzdW4BysRbTXBQSK7rJV9/C6Q=;
        b=WiHqJX4IPZSphnPGtjmgDTq02OzB/ALp1TV6kG9CRMk+NF/n17U9vaiIg3nJzNspUn
         AHeRoN1+Mlzn+qDZVFLSG/qvlwhkFZmqjwTf+KWml2D5c+Q4SsX7BhLbOpvB9yhlbpxY
         aCb+v0DOQttSn9HdROG9lEPSbHds1voLDKbXO83Q+BF19rJ/LVF2WoFhti6Jv3aMchXB
         vmhjAC+y430Rd6ZC8cEJpyfZBRnLE3aR84v9JQdRTuxy/TGQ+2iBCMMofteEq/kMeK0u
         Pg0igJZ/A+0EDxtVCNaPapg6SLMTLV1o+KFUvSBXoVDQDfRFE/M8nTO+4EQqx491aNJ2
         TkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774870480; x=1775475280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rqARNcuRlfvbzOSZlcUzdW4BysRbTXBQSK7rJV9/C6Q=;
        b=TL0OCD37AJgEcgeAvh+sAVkabEg9mGWQ5uVx9+fubbHYs74FTDsBldxDzWUcXZfGgR
         lVq5QjuJ+LUUTBK1DEPw4LQngwYsWC2iR+kKi2FsVTvAD9gOGzOcrk4a+WrY0AyDfRs0
         O07QJdTzKHKBae/r1wkgYHN3VgsdfKVYcV6MHeJshfbCIw9EYpOE168/MFXTP3JLhHKO
         6srLiuWu1Y/3Um2pmw52iy1DlX6zca8Z3YrIod7PpEjJlu79EtKXcE271WCl6Yw4jZiR
         lMyRbZBoFAQ0xScS/sdLa3B8+N2cpE4MECednfBCxW7SCke4ROktLEqobiptKI6dP0GW
         28tA==
X-Forwarded-Encrypted: i=1; AJvYcCXK5bnO0s6DAKnhZu2pKfmpp4+KMK7Fcw9eExHIrDnE4ObTHMuSZwjfyRlaI5itw3Nu/4pTPrwu7dcCi4TcRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDeIjag2RcQzIFOodK/haOrHge3pTJAO9LtvTzddDEQPi/uzdW
	fe4lcrP3RoTgF0/rOHT5E1xLzVDX/4tlDSPRPQg4I6mYL7UNnQ4/Uw+VmqsMgppl+cWhCyhmMYY
	QRdRbCzWUGM4vUjyWWRjrXAUcVCGLd50=
X-Gm-Gg: ATEYQzwHQeAWMdcbueHc29Eu0X1driwEG7uygKlYUyKhpQe9FDgq4moV7o/V1L1UAd0
	+ouAvvWVhjsvmrn21GAGuquK2/Y9laoK4OJDKIESdc0lfcggXVctDp0ixDyDcYGlKtoj4AipAHZ
	fkw023UnQrmiTuGBQ6BsjSqNkBV5bJZa1E9BbrLLsfqxMrQE+8AOAsRovpwLP/iM6iC08RUPfe0
	6bL0IcWlvwyfVxRlktmfDcaNnoVGrAWRaMgmeKnGaGAh8v3zmqBJefK02JmSErv77pOtXa1HebI
	V1iV459e
X-Received: by 2002:a4a:e907:0:b0:67d:f992:86fa with SMTP id
 006d021491bc7-67e187901cfmr6055758eaf.64.1774870480248; Mon, 30 Mar 2026
 04:34:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <CALdGYqQ3tS_aQpmf7xLkaCG9W55ATQXP=tnRNdjBAG8waqg8yA@mail.gmail.com>
 <dbe78a09fafe4a0ab16cd691049896a8@realtek.com> <CALdGYqQ3JQgFvvjiqh-ck8UqUQpAoJ0zeUzEL4i4Un8qPmqxJA@mail.gmail.com>
 <CALdGYqQuS5EOWCaeimr6PY758feF-DPo5i3XFwoQ8ewf4xnm7A@mail.gmail.com>
 <b231d63665334ac786e808610fe4a1e9@realtek.com> <CALdGYqSd61wxNrPDui+m-S+Na_is-RM18-=L6xm-Jf4QQ+-DOg@mail.gmail.com>
 <a8e187e1b40e4a35bbeb3bc3a3d21821@realtek.com> <CALdGYqRPcDRctCpNSJFatXvqMKLFiiRGXZoQa3KJwfwutHJEwA@mail.gmail.com>
 <ba9790526e4e42c386642a05fcbc2f34@realtek.com> <CALdGYqQ5U2USCqVEixoDda1Xd2ugBakh1K1QkaKAU7HPSTTNWg@mail.gmail.com>
 <CALdGYqQ_RCOwa2J-GsEyCxCQ4bztyxSzbc+6eYNesBSaY3Nt-w@mail.gmail.com>
 <da30a61b-dad0-48ff-a283-3dd8e9bdf91d@gmail.com> <CALdGYqS53=MmG4yCLwgV+RJAZ=U8Aqi8QQZFZ5oFMernhSyxTg@mail.gmail.com>
 <5eb90d6d-e590-4c9e-91c8-1ba315f45304@gmail.com> <CALdGYqRkX8=XMOePeauxvSTDZFLEYyJZKCtoxCzqaNwdO6BNnw@mail.gmail.com>
 <a5ea6373-8c07-4fcd-95fc-d87ce6aef6d5@gmail.com> <6898154c58c84536a0dd4351b3b026fb@realtek.com>
In-Reply-To: <6898154c58c84536a0dd4351b3b026fb@realtek.com>
From: LB F <goainwo@gmail.com>
Date: Mon, 30 Mar 2026 14:34:03 +0300
X-Gm-Features: AQROBzCTrD2k0Y4dI_amOjhoRKrbbx4Uq4xAvMGzxw-AC5t1g5xDXvIrBpfpoMk
Message-ID: <CALdGYqT2e+jt+mK-o_bL8hfdEwqZ44fUt9_N6-H4jYp8FpqQJw@mail.gmail.com>
Subject: Re: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34187-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2388F35A54B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ping-Ke,

> Oleksandr, is it possible to sum up the conditions these weird frames
> happened? such as enter LPS? with BT devices? or something else.

To be completely honest, I cannot point to a single definitive trigger.
But I went through my kernel logs very carefully and here is what I
found =E2=80=94 I'll present just the objective data and let you draw your
own conclusions.

=3D=3D System context =3D=3D

This is a WiFi+BT combo chip (RTL8821CE). Bluetooth is active most of the t=
ime =E2=80=94
I constantly use a Soundcore Q10i headset (A2DP audio streaming + AVRCP).
I also use hibernation (suspend-to-disk, S4) frequently. LPS_DEEP is
disabled via the DMI quirk.

=3D=3D Corrupted frame distribution =3D=3D

In one boot session I observed 310 "unused phy status page" events.
They were NOT evenly distributed =E2=80=94 they appeared in 3 distinct burs=
ts
separated by hours of clean operation:

  Cluster #1:  00:21 =E2=80=94 00:38    50 frames over ~17 minutes (gradual=
)
  Cluster #2:  01:39           120 frames in ~2 seconds (explosive)
  Cluster #3:  12:23 =E2=80=94 12:26   140 frames over ~3 minutes

Minute-by-minute breakdown:

  00:21   1     01:39  120     12:23   48
  00:32   3                           12:24   25
  00:33   4                           12:25   61
  00:34  12                          12:26    6
  00:35   5
  00:36   6
  00:37   6
  00:38  13

=3D=3D Full timeline of key kernel events =3D=3D

  18:46:40  Cold boot (Linux 6.19.10-1-cachyos)
  18:46:49  rtw_8821ce: Firmware version 24.11.0, H2C version 12
  18:47:xx  wlan0 associated with AP

  19:22:40  Hibernation resume #1
  19:22:51  wlan0 re-associated

  20:09:35  wlan0 deauthenticating (entering hibernation)
  20:11:23  Hibernation resume #2
  20:11:33  wlan0 re-associated

  20:55:01  Bluetooth: hci0: unexpected event for opcode 0xfc19
  22:42:25  input: Soundcore Q10i (AVRCP) registered

  [ No other kernel events besides atkbd key events until: ]

  00:21:20  >>> CLUSTER #1 STARTS (first corrupted frame)
            4h10m after resume #2, 1h39m after BT AVRCP event
  00:37:35  WARNING: net/mac80211/rx.c:896 (mac80211 WARN_ON triggered)
  00:38:59  Cluster #1 ends

  00:47:45  Chrome SharedWorker trap (unrelated userspace crash)

  01:39:33  >>> CLUSTER #2 STARTS (120 frames in ~2 seconds)
            Also logged: "unknown pkt rate =3D 41" (0x41 =3D 65 decimal,
            far exceeding DESC_RATE_MAX =E2=80=94 confirms completely garbl=
ed
            RX descriptor)
  01:39:34  Cluster #2 ends

  [ ~10 hours of clean operation / hibernation ]

  12:21:29  Hibernation resume #3
  12:21:30  Bluetooth RTL firmware reloaded (rtl8821c_fw.bin)
  12:21:40  wlan0 re-associated

  12:23:14  >>> CLUSTER #3 STARTS
            Only 94 seconds after WiFi re-association post-resume!
  12:26:09  Cluster #3 ends

=3D=3D Observations (presented carefully, without definitive conclusions) =
=3D=3D

1. The corrupted frames come in BURSTS, not continuously. Between
   bursts the adapter works normally for hours.

2. Cluster #3 has a clear temporal correlation with hibernation
   resume =E2=80=94 bad frames started only 94 seconds after wlan0
   re-associated. This is the tightest correlation in the data.

3. However, Clusters #1 and #2 started approximately 4h and 5.5h
   after the preceding resume (#2), so hibernation alone does not
   explain everything. Something may be accumulating over time.

4. The BT subsystem logged "unexpected event for opcode 0xfc19"
   (a vendor-specific RTL HCI command) at 20:55, roughly 1.5 hours
   before Cluster #1. I don't know if this event is normal or
   indicates a firmware anomaly on the combo chip.

5. The bursts vary dramatically in intensity: Cluster #2 produced
   120 frames in 2 seconds, while Cluster #1 was spread over 17
   minutes. This suggests different failure modes within the chip.

6. Between resume #2 and Cluster #1, the ONLY non-keyboard kernel
   events were the BT unexpected event (20:55) and BT AVRCP input
   device registration for the headset (22:42). No PCIe events,
   no driver restarts, no suspend entries.

=3D=3D Questions =3D=3D

Could you advise on how to investigate this further? For example:

  - Is there a debug flag or register dump we could capture right
    before the first corrupted frame in a burst?
  - Would it help to log C2H (chip-to-host) traffic around the
    time of these events?

I am ready to run any specific tests you need. In the meantime,
I agree that filtering by DRV_INFO_SIZE is the right practical
solution, and I'm waiting for your official patch to test locally.

Best regards,
Oleksandr Havrylov

