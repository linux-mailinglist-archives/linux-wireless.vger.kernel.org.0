Return-Path: <linux-wireless+bounces-34020-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIVbL+jHxWmgBgUAu9opvQ
	(envelope-from <linux-wireless+bounces-34020-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 00:57:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBBC33D4D6
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 00:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 20A033056271
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 23:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA5B38F634;
	Thu, 26 Mar 2026 23:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KawYWoyL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B55235DA44
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 23:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774569202; cv=pass; b=M8xgXKVjZyT8w9YrGH+VJwYhHD2XoLxsEBDWwJOfyZZ9DoZK0VYG5E7S3Tii4FjECDHRb/4+mCvPQzHiPwIwuzBkNG01y4DHN3DAV9S09MuvFdp/UNu2bU78r3WVQ0oPhzoyllrolZG7rUuBJxNar+suEIxpjAH+VzroDDZdcxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774569202; c=relaxed/simple;
	bh=NAX/d/1g+cMT4uou7cLP0KTWcON4A6dUX3kvyNMNkZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCy8iiaRecSXpd7KxBNsNbqDJ5cYXmOEYQ+5iTA3brRY2ahWV6rwJD8H0wgiGlYwdV7Q/TDQWVnMbwOPA9bYfQ1zkex0i+BS5n78tNlrHqiOSNb37wr7sARu2TJ4vDH9QXbcSn/60W96jLzcfBj29C8eNZ/owOT7BuS88kFPCxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KawYWoyL; arc=pass smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-40427db1300so967114fac.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 16:53:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774569198; cv=none;
        d=google.com; s=arc-20240605;
        b=aIzpJhAqaZfHCuxz5qlY6hzuM9ZtbMYMqwSiolDeK6E4/S9sPspnClL3PWtiEu2hxN
         FrRCGXFgf1tbe6iV7HhZu7zXjSQq4tUMFPSOWyYGYUIt3OL94iYQPmB8+rsBweQ82zlZ
         FtSzdaD/HmgFlXnDzrYmiIWT94o+pSIBe0XIsCfKRykz4dLJyN3YEAvLQTOKmyeoMq06
         PPo8dmT3yGq4Qog1z69r4xB4LS/82ROkHGPnmCQkZ5iMhTPh3NF09kpz8UhCTySYhZlZ
         LiI3NAqILZjV/BzTgsz387cOB2jLzTQNkkLc+o7s7B3mbbl/ryFimq9M9qRtIixSAzFU
         X+sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CczUz3Jen9LgawFnvn8a6lnGF+BsuHerJ5Os+KTBam8=;
        fh=fFUQ3bDSnwWYL/1dqZwPKYywXd5TONRsAevI/mvHYbI=;
        b=kBhK2s4dTbQs7J+CkC5lJ46dDGDgIJaD1L8Pi6OXPzAA8LurmcfY6dJ7IWO+EnHt6l
         /RKQPyV4ctB3eN/BhWs/TjofO8Ujo1Eb7EYa/pkzvRjalbUiIjb1buZ/35iM9+K9Nf4z
         JBqQq3/ayWMEW8svv34II3XAanQCqjDb3JFXOj5iXncASA0jXDMSkzpnFt/dRh8Pq+GI
         29YQm0OWInnuTtWYTtJzpYTXF7KK4x8RC2CzrZXdqvZoZ6bpr4ZZd++xW+08bsFgVKLX
         pka5VWxCqM8+sghtKHzQuS2DQzNJLfFIKs+xfRJIYXCVhhRmIlHzpal7HPuxqJG3cOQy
         dWqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774569198; x=1775173998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CczUz3Jen9LgawFnvn8a6lnGF+BsuHerJ5Os+KTBam8=;
        b=KawYWoyLcMo4NM4vL+vzkBk0GA8nRAArlLj2LJzsN5Zd4tWJIcGk4tef7fHJbP1d7/
         rPv7bYoc26CeP0HLXsg9075Vfz0xCxT74AmdHYmRVg9bO//CH87OGDrKx+RqMpd38p59
         jk+LQ+WEsQXvV5EesoaAXcgibyX7PgmGASxzjEfqMe+3yd0MHepHeXHEbqtWZs8HYsr2
         S6WVZdjcv6qMUqS6hDLUiYGYgO24mNlex7yoqlWjhj1RlQwVclN0MGngvxm32yUEHR6X
         JC8LeXXTfL92tAY7N7pbrKiHtoEQi1hzcLtfXsrXps+2d+ycMMu/SGQUk8pXBC5Mh061
         TYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774569198; x=1775173998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CczUz3Jen9LgawFnvn8a6lnGF+BsuHerJ5Os+KTBam8=;
        b=mFkVyX6QbxZkTrwaqQbVllQiju+3v0DyuTnD+jkBehIrwfISu4mMjJjOkCtMZiz6VT
         ZTSqGmDg6eGr8Q6ZQdmbqx+d6ckD+sMdw58TpNxhWJm9EVTsJnTntHTBhOPVCyPmSBQ5
         eMzYpUEHL/xRy3FPqcPgnxboHARYvFJ9C188Uadqbv9OpKyXFPU797qV9xzUJCTTIAV/
         +V3XkQfRkDjmp2Auiuo+DCzhGmsJvzOSkLMFc2DuTFGxPOPrAYnKTXO9IqG0lYZWJCw4
         FzjxgBhKvCb6GHrb9ga5MOm8kYM0t5eZaFLtTLW/ktRNMM4ZhjyTv2e+mDUH0mDse9oD
         9bWA==
X-Gm-Message-State: AOJu0YxUDSNZSQMNCg03+CkKDjxnw+RgfOIR/q5foqD91wMb5GyDh9dh
	bqj+t6lRrVDl0IK7LnJ6+vLf7e2uOOY0VHXMoMK39/4eHjXvNP+82k6nlSM1815Rgk9XDfovr8u
	553nfKzHM9QT2i3Dz+HYMrpMTLpZxNsY=
X-Gm-Gg: ATEYQzwkKuno3RSSGWxxiOar6yoiSwzBbHgCVmU06HgpAEjkKSq4yOMD5bojwzN5dZj
	WzeDZWoBbreaqPuVPzxXxJuxACqYR29VgLSI/FpdtLDP5qTPr108lWg1uj8lyWUs9An0jmTXyxe
	gAjyYLkWDQZAwhPWWtXGuo7g2nyzGdbH5V3i5SAbDF2QzkNjNxBHl4XHmRoq/1r2vPT1xIySD4d
	y/g/ZoACSFYRngu3nUx8P2EoXQzywxVxyg9DbT69gIuDMh4sZwGLRbYvJaIA02jGwOVK0jIY9DJ
	bJDLnSjR
X-Received: by 2002:a05:6870:6492:b0:409:95eb:9618 with SMTP id
 586e51a60fabf-41cec15d144mr162411fac.17.1774569197691; Thu, 26 Mar 2026
 16:53:17 -0700 (PDT)
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
 <CALdGYqTHz5Pz3uSGLbrVuNMWAXaqniUCuOSQACXUYHSL22ySvw@mail.gmail.com>
 <CALdGYqQ5K0iuxjjX4TwNLi9Km5O+YL3Y9r6Bwfk9BaiuV3BHPA@mail.gmail.com>
 <CALdGYqRYVxGbg+qRNUvRNr9V4f2YVZ7p=amwq1ktdmZVkwxjQg@mail.gmail.com>
 <CALdGYqSq416qqqZ7t+wG5fir9NWfi3578+brdaj05q-42Gj14w@mail.gmail.com>
 <CALdGYqSf66mBiufysr3tjm74A_w98LRN50fik0U9WGVvkBJ_5g@mail.gmail.com>
 <1bd495ffe57c47eb827eec084729afa2@realtek.com> <CALdGYqSMUPnPfW-_q1RgYr0_SjoXUejAaJJr-o+jpwCk1S7ndQ@mail.gmail.com>
 <e5f00d0a42994812b42df867718fa087@realtek.com> <CALdGYqRbkV7_w7WDiqD-vYMa8MUFV7nSYz-=q2FzotgLHRy=HA@mail.gmail.com>
 <cb32c1eefb614a8bb96ef6fe2c4f4989@realtek.com> <CALdGYqQ3tS_aQpmf7xLkaCG9W55ATQXP=tnRNdjBAG8waqg8yA@mail.gmail.com>
 <dbe78a09fafe4a0ab16cd691049896a8@realtek.com> <CALdGYqQ3JQgFvvjiqh-ck8UqUQpAoJ0zeUzEL4i4Un8qPmqxJA@mail.gmail.com>
 <CALdGYqQuS5EOWCaeimr6PY758feF-DPo5i3XFwoQ8ewf4xnm7A@mail.gmail.com>
 <b231d63665334ac786e808610fe4a1e9@realtek.com> <CALdGYqSd61wxNrPDui+m-S+Na_is-RM18-=L6xm-Jf4QQ+-DOg@mail.gmail.com>
 <a8e187e1b40e4a35bbeb3bc3a3d21821@realtek.com> <CALdGYqRPcDRctCpNSJFatXvqMKLFiiRGXZoQa3KJwfwutHJEwA@mail.gmail.com>
 <ba9790526e4e42c386642a05fcbc2f34@realtek.com> <CALdGYqQ5U2USCqVEixoDda1Xd2ugBakh1K1QkaKAU7HPSTTNWg@mail.gmail.com>
In-Reply-To: <CALdGYqQ5U2USCqVEixoDda1Xd2ugBakh1K1QkaKAU7HPSTTNWg@mail.gmail.com>
From: LB F <goainwo@gmail.com>
Date: Fri, 27 Mar 2026 01:52:40 +0200
X-Gm-Features: AQROBzCuc7g-VXFuoKkDPw4xP3obil5aohlLAVW-W0euwsTmYpcVLGA5LuxqY6M
Message-ID: <CALdGYqQ_RCOwa2J-GsEyCxCQ4bztyxSzbc+6eYNesBSaY3Nt-w@mail.gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34020-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,archlinux.org:url]
X-Rspamd-Queue-Id: 7EBBC33D4D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ping-Ke,

This is Oleksandr Havrylov again. Thank you for the ASPM/LPS Deep
quirk and the rate validation patches =E2=80=94 they are both working corre=
ctly
(zero h2c timeouts, zero lps failures, zero mac80211 warnings).

However, I'm experiencing a different, separate bug that causes kernel
oops and makes the system completely unresponsive, requiring a hard
power-off. After disassembling the crash site, I believe I've found
the root cause.

=3D=3D Summary =3D=3D

When firmware sends a C2H_ADAPTIVITY (0x37) command to an RTL8821CE
adapter, rtw_fw_adaptivity_result() dereferences rtwdev->chip->edcca_th
without a NULL check. The RTL8821C chip_info (rtw8821c_hw_spec) does
not define edcca_th, so the pointer is NULL, causing a kernel oops.

The crash occurs on the phy0 workqueue while holding rtwdev->mutex,
which never gets released. This causes all subsequent processes that
touch the network stack to hang in uninterruptible D-state, making
the system completely unresponsive and requiring a hard power-off.

=3D=3D Root cause analysis =3D=3D

rtw_fw_adaptivity_result() in fw.c (line ~282):

  static void rtw_fw_adaptivity_result(struct rtw_dev *rtwdev, u8 *payload,
                                       u8 length)
  {
      const struct rtw_hw_reg_offset *edcca_th =3D rtwdev->chip->edcca_th;
      ...
      rtw_dbg(rtwdev, RTW_DBG_ADAPTIVITY, "Reg Setting: L2H %x H2L %x\n",
              rtw_read32_mask(rtwdev, edcca_th[EDCCA_TH_L2H_IDX].hw_reg.add=
r,
                                             ^^^^^^^^^ NULL dereference her=
e
                              edcca_th[EDCCA_TH_L2H_IDX].hw_reg.mask),
              ...

The RTL8822C defines .edcca_th =3D rtw8822c_edcca_th in its chip_info,
but RTL8821C does not set this field at all =E2=80=94 it remains NULL.

I verified this by disassembling the compiled rtw_core.ko module:

  Crash RIP: rtw_fw_c2h_cmd_handle+0x127
  Address:   0x1d527 =3D movl (%r12), %esi

  R12 is loaded at +0xe5 (0x1d4e5):
    movq 0x140(%rax), %r12    ; rax =3D rtwdev->chip
                              ; 0x140 =3D offset of edcca_th in rtw_chip_in=
fo
                              ; R12 =3D chip->edcca_th =3D NULL for 8821c

  The function is entered via:
    +0xd8 (0x1d4d8): cmpl $0x37, %ecx  ; c2h->id =3D=3D C2H_ADAPTIVITY (0x3=
7)

  With R12 =3D 0, the instruction at +0x127:
    movl (%r12), %esi   ; reads from address 0x0 =E2=86=92 NULL pointer der=
eference

I also confirmed that rtw8821c_hw_spec in the mainline kernel
(torvalds/linux master, rtw8821c.c) does NOT set .edcca_th.

=3D=3D Reproduction =3D=3D

The crash is highly reproducible: it occurred in 4 out of 7 recent
boots. It happens during normal active usage with no specific trigger.

  boot  date/time of crash         uptime at crash
  -5    2026-03-25 00:58:06        ~2 min
  -4    2026-03-25 21:32:00        ~6h
  -3    2026-03-26 00:28:14        ~2.5h
  -1    2026-03-27 00:56:58        ~23.5h

Both ASPM and LPS Deep are disabled via the DMI quirk. The crash
occurs every time with the same pattern and same RIP offset (+0x127).

=3D=3D Crash pattern =3D=3D

Every crash follows the same sequence:

  1) Burst of 50-60 "unused phy status page" messages in ~1 second:

     rtw_8821ce 0000:13:00.0: unused phy status page (8)
     rtw_8821ce 0000:13:00.0: unused phy status page (2)
     ... (50+ more within same second)

  2) Immediately followed by the kernel oops:

     BUG: kernel NULL pointer dereference, address: 0000000000000000
     Oops: 0000 [#1] SMP PTI
     Workqueue: phy0 rtw_c2h_work [rtw_core]
     RIP: 0010:rtw_fw_c2h_cmd_handle+0x127/0x380 [rtw_core]

     CR2: 0000000000000000
     R12: 0000000000000000   =E2=86=90 edcca_th =3D NULL

     Call Trace:
      <TASK>
      rtw_c2h_work+0x49/0x70 [rtw_core]
      process_scheduled_works+0x1f3/0x5e0
      worker_thread+0x18d/0x340
      </TASK>

     note: kworker/u16:6[262] exited with irqs disabled

  3) After the oops, processes hang in D-state indefinitely:
     warp-svc, avahi-daemon, kdeconnectd =E2=80=94 all survive SIGKILL,
     making clean shutdown impossible.

=3D=3D Suggested fix =3D=3D

Add a NULL check for edcca_th in rtw_fw_adaptivity_result():

  static void rtw_fw_adaptivity_result(struct rtw_dev *rtwdev, u8 *payload,
                                       u8 length)
  {
      const struct rtw_hw_reg_offset *edcca_th =3D rtwdev->chip->edcca_th;
      struct rtw_c2h_adaptivity *result =3D (struct rtw_c2h_adaptivity *)pa=
yload;

  +   if (!edcca_th)
  +       return;
  +
      rtw_dbg(rtwdev, RTW_DBG_ADAPTIVITY,
              ...

Alternatively, the C2H_ADAPTIVITY case in rtw_fw_c2h_cmd_handle()
could check edcca_th before calling the handler. However, since
RTL8821CE firmware does occasionally send C2H_ADAPTIVITY commands
(as observed in this bug), you may have a better understanding of
whether a more complete fix is needed (e.g., defining edcca_th for
RTL8821C, or preventing the firmware from sending C2H_ADAPTIVITY
responses when the feature is not fully configured).

=3D=3D Hardware =3D=3D

  Machine:   HP HP Notebook (board: 81F0, SKU: P3S95EA#ACB)
  Adapter:   RTL8821CE (PCI 10ec:c821, bus 0000:13:00.0)
  CPU:       Intel 5005U
  Kernel:    6.19.9-2-cachyos (PREEMPT full, SMP PTI, LLVM build)
  Driver:    lwfinger/rtw88 out-of-tree with DMI quirk + rate v2

=3D=3D Confirmation that this is NOT a local modification =3D=3D

I verified that:
  - fw.c: rtw_fw_c2h_cmd_handle() and rtw_fw_adaptivity_result() are
    byte-for-byte identical to torvalds/linux master and lwfinger/rtw88
  - rtw8821c.c: rtw8821c_hw_spec does not define .edcca_th in any of
    the three sources (mainline, lwfinger, our local copy)
  - The only local modifications are your DMI quirk (pci.c + main.h)
    and rate validation v2 (rx.c). Neither touches fw.c.

Please let me know if you need additional diagnostics or if you'd
like me to test a patch.

Best regards,
Oleksandr Havrylov <goainwo@gmail.com>

Tested on:
  Kernel: 6.19.9-2-cachyos
  Driver: lwfinger/rtw88 out-of-tree with DMI quirk + rate v2 patch
  Distro: CachyOS (Arch-based)

=D1=81=D1=80, 25 =D0=BC=D0=B0=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 22:38, LB =
F <goainwo@gmail.com>:
>
> Subject: Cross-platform analysis: RTL8821CE ASPM/LPS instability
>         affects multiple OEM platforms beyond HP P3S95EA#ACB
>
> Hi Ping-Ke,
>
> First of all, thank you very much for your work on the rtw88 driver
> and for the time you spent helping us resolve the issues on our HP
> laptop. Both patches -- the v2 DMI quirk (ASPM + LPS Deep) and the
> v2 RX rate validation (rx.c) -- have been tested and verified stable
> on our system across two kernel updates (6.19.9-1 and 6.19.9-2),
> sustained network load (~1.9 GB), and multiple suspend/resume cycles.
> The system is now completely free of freezes, h2c errors, and
> mac80211 warnings. Your patches genuinely solved every issue we had.
>
> While working through this, I noticed that many other users across
> different hardware platforms appear to be experiencing the same
> problems that your patches resolved for us. I decided to collect
> and organize these observations in case they might be useful to you.
>
> Please note that this is an amateur analysis, not a professional
> one -- I am just a user trying to help. It is entirely possible
> that I have missed nuances or made incorrect assumptions. My only
> goal is to share what I found, in case it provides useful data
> points or sparks ideas for broader improvements. If any of this
> is not relevant or not useful, please feel free to disregard it.
>
>
> 1. KERNEL BUGZILLA: OPEN RTL8821CE REPORTS
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> I reviewed all open RTL8821CE bugs in kernel.org Bugzilla. Three
> of the six show symptoms that directly match the root causes
> addressed by your patches (ASPM deadlock and LPS Deep h2c failures).
>
> --- Directly correlated with ASPM/LPS patches ---
>
> Bug 215131 - System freeze (ASPM L1 deadlock)
>   Title:    "Realtek 8821CE makes the system freeze after 9e2fd29864c5
>              (rtw88: add napi support)"
>   Reporter: Kai-Heng Feng (Canonical)
>   Kernel:   5.15+
>   Symptoms: Hard freeze preceded by "pci bus timeout, check dma status"
>             warnings. RX tag mismatch in rtw_pci_dma_check().
>   Workaround confirmed by reporter: rtw88_pci.disable_aspm=3D1
>   Reporter note: "disable_aspm=3D1 is not a viable workaround because
>                   it increases power consumption significantly"
>   Status:   OPEN since 2021-11-24.
>   Link:     https://bugzilla.kernel.org/show_bug.cgi?id=3D215131
>   Relevance: Identical root cause to Bug 221195. The reporter's
>              confirmed workaround (disable_aspm=3D1) is exactly what
>              the DMI quirk implements.
>
> Bug 219830 - h2c/LPS failures + BT crackling
>   Title:    "rtw88_8821ce (RTL8821CE) slow performance and error
>              messages in dmesg"
>   Reporter: Bmax Y14 laptop, Fedora 41, kernel 6.13.5
>   Symptoms: - "failed to send h2c command" (periodic)
>             - "firmware failed to leave lps state" (periodic)
>             - Lower signal strength vs Windows
>             - Bluetooth crackling during audio playback
>   Cross-ref: https://github.com/lwfinger/rtw88/issues/306
>   Status:   OPEN since 2025-03-02.
>   Link:     https://bugzilla.kernel.org/show_bug.cgi?id=3D219830
>   Relevance: The h2c/lps errors are the same messages we observed
>              before the DMI quirk disabled LPS Deep Mode. The BT
>              crackling may correlate with the invalid RX rate
>              condition addressed by your rx.c validation patch.
>
> Bug 218697 - TX queue flush timeout during scan
>   Title:    "rtw88_8821ce timed out to flush queue 2"
>   Reporter: Arch Linux, kernel 6.8.4 / 6.8.5
>   Symptoms: - "timed out to flush queue 2" every ~30 seconds
>             - "failed to get tx report from firmware"
>             - Stack trace: ieee80211_scan_work -> rtw_ops_flush ->
>               rtw_mac_flush_queues timeout
>   Status:   OPEN since 2024-04-08.
>   Link:     https://bugzilla.kernel.org/show_bug.cgi?id=3D218697
>   Relevance: The flush timeout occurs when the firmware cannot
>              respond to TX queue operations -- consistent with
>              firmware being stuck in LPS Deep during scan.
>
> --- Potentially related (no confirmed workaround data) ---
>
> Bug 217491 - "timed out to flush queue 1" regression (kernel 6.3)
>   Manjaro user. Floods of "timed out to flush queue 1/2".
>   Similar pattern to Bug 218697.
>   Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217491
>
> Bug 217781 - Random sudden dropouts
>   Arch user. Random disconnections during streaming/transfers.
>   Reproduced on Ubuntu and Fedora (kernels 5.15 to 6.4).
>   Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217781
>
> Bug 216685 - Low wireless speed
>   Reduced throughput vs expected 802.11ac performance.
>   Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216685
>
>
> 2. SYMPTOM-TO-PATCH MAPPING
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>
> dmesg signature                    Patch that resolves it
> --------------------------         ----------------------
> Hard system freeze                 pci.c DMI quirk (disable ASPM)
> "pci bus timeout, check dma"       pci.c DMI quirk (disable ASPM)
> "firmware failed to leave lps"     pci.c DMI quirk (disable LPS Deep)
> "failed to send h2c command"       pci.c DMI quirk (disable LPS Deep)
> "timed out to flush queue N"       pci.c DMI quirk (disable LPS Deep) [1]
> "failed to get tx report"          pci.c DMI quirk (disable LPS Deep) [1]
> VHT NSS=3D0 mac80211 WARNING        rx.c rate validation (v2)
>
> Confirmed in bugs: 215131, 219830, 218697, 221195.
> [1] Inferred: flush timeout occurs when firmware cannot exit LPS
>     to process TX queue operations.
>
>
> 3. AFFECTED HARDWARE
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Current DMI quirk coverage: HP P3S95EA#ACB only.
>
> Platforms confirmed affected in Bugzilla:
>   Bug 221195: HP Notebook 81F0 (P3S95EA#ACB)
>   Bug 215131: unknown (Canonical upstream testing)
>   Bug 219830: Bmax Y14
>   Bug 218697: unknown (Arch Linux user)
>
> Platforms reported in community forums as requiring
> disable_aspm=3DY and/or disable_lps_deep=3DY for stable RTL8821CE:
>   - HP 17-by4063CL
>   - Lenovo IdeaPad S145-15AST, IdeaPad 3, IdeaPad 330S
>   - ASUS VivoBook X series
>   - Acer Aspire 3/5 series
>
> All use PCI Device ID 10ec:c821 with different Subsystem IDs.
>
>
> 4. LPS_DEEP_MODE_LCLK IN THE rtw88 TREE
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> I verified in the source which chips have the same
> lps_deep_mode_supported flag:
>
> Chip file       lps_deep_mode_supported            PCIe variant
> ---------       -----------------------            ------------
> rtw8821c.c      BIT(LPS_DEEP_MODE_LCLK)            rtw8821ce =E2=9C=93
> rtw8822c.c      BIT(LPS_DEEP_MODE_LCLK) | PG       rtw8822ce =E2=9C=93
> rtw8822b.c      BIT(LPS_DEEP_MODE_LCLK)            rtw8822be =E2=9C=93
> rtw8814a.c      BIT(LPS_DEEP_MODE_LCLK)            rtw8814ae =E2=9C=93
> rtw8723d.c      0                                   rtw8723de =E2=9C=97
> rtw8703b.c      0                                   (SDIO)     -
> rtw8821a.c      0                                   (legacy)   -
>
> Source references:
>   rtw8821c.c:2002  rtw8822c.c:5365  rtw8822b.c:2545
>   rtw8814a.c:2211  rtw8723d.c:2144
>
> RTL8822CE community reports (Manjaro, Arch forums) confirm the
> same disable_aspm=3DY + disable_lps_deep=3DY workaround is effective,
> consistent with rtw8822c.c having LCLK enabled.
>
>
> 5. COMMUNITY WORKAROUND REFERENCES
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The following are concrete examples of forums and wikis where the
> same modprobe workarounds are actively recommended:
>
> Arch Wiki - RTW88 section:
>   https://wiki.archlinux.org/title/Network_configuration/Wireless
>   (section "RTW88" and "rtl8821ce" under Troubleshooting/Realtek)
>   Recommends rtw88-dkms-git and documents the rtw88_8821ce issues.
>
> Arch Wiki - RTW89 section (same page):
>   Documents the identical ASPM pattern for the newer RTW89 driver:
>     options rtw89_pci disable_aspm_l1=3Dy disable_aspm_l1ss=3Dy
>     options rtw89_core disable_ps_mode=3Dy
>   This suggests the ASPM/LPS interaction is a systemic Realtek
>   design issue, not specific to rtw88 or the 8821CE chip.
>
> Arch Linux Forum - RTL8821CE thread:
>   https://bbs.archlinux.org/viewtopic.php?id=3D273440
>   Referenced by the Arch Wiki as the primary rtl8821ce discussion.
>
> lwfinger/rtw88 GitHub:
>   https://github.com/lwfinger/rtw88/issues/306
>   Directly cross-referenced by Bug 219830. Reporter reports h2c
>   errors and investigated antenna hardware (no fault found).
>
> lwfinger/rtw89 GitHub:
>   https://github.com/lwfinger/rtw89/issues/275#issuecomment-1784155449
>   Same ASPM-disable pattern documented for the newer RTW89 driver
>   on HP and Lenovo laptops.
>
>
> 6. OBSERVATIONS
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> a) Three open Bugzilla reporters (215131, 219830, 218697) show
>    symptoms identical to those resolved by your patches but have
>    no upstream fix available since they are not the HP P3S95EA#ACB.
>
> b) Bug 215131 reporter (Kai-Heng Feng, Canonical) explicitly
>    confirmed disable_aspm=3D1 as a workaround and called it
>    "not viable" due to power cost. A DMI quirk for their
>    platform would give them a proper fix.
>
> c) The Arch Wiki documents the same ASPM-disable pattern for
>    both RTW88 and RTW89 drivers, suggesting the underlying
>    hardware/firmware limitation is shared across generations.
>
> d) Asking Bugzilla reporters to provide their DMI data
>    (dmidecode -t 1,2) could allow extending the quirk table
>    with minimal effort and zero risk to unaffected platforms.
>
> e) The rx.c rate validation patch is chip-agnostic and requires
>    no platform-specific consideration.
>
>
> 7. REFERENCES
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Kernel Bugzilla:
>   https://bugzilla.kernel.org/show_bug.cgi?id=3D215131
>   https://bugzilla.kernel.org/show_bug.cgi?id=3D219830
>   https://bugzilla.kernel.org/show_bug.cgi?id=3D218697
>   https://bugzilla.kernel.org/show_bug.cgi?id=3D217491
>   https://bugzilla.kernel.org/show_bug.cgi?id=3D217781
>   https://bugzilla.kernel.org/show_bug.cgi?id=3D216685
>
> GitHub:
>   https://github.com/lwfinger/rtw88/issues/306
>   https://github.com/lwfinger/rtw89/issues/275
>
> Arch Wiki:
>   https://wiki.archlinux.org/title/Network_configuration/Wireless
>
> Arch Linux Forum:
>   https://bbs.archlinux.org/viewtopic.php?id=3D273440
>
> Source code (lps_deep_mode_supported):
>   drivers/net/wireless/realtek/rtw88/rtw8821c.c:2002
>   drivers/net/wireless/realtek/rtw88/rtw8822c.c:5365
>   drivers/net/wireless/realtek/rtw88/rtw8822b.c:2545
>   drivers/net/wireless/realtek/rtw88/rtw8814a.c:2211
>   drivers/net/wireless/realtek/rtw88/rtw8723d.c:2144
>
>
> Best regards,
> Oleksandr Havrylov <goainwo@gmail.com>

