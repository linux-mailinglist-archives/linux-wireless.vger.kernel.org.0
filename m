Return-Path: <linux-wireless+bounces-35742-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IH43NHVR9GmKAgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35742-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 09:08:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A444AAC90
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 09:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F05430078BC
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2026 07:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D29363C79;
	Fri,  1 May 2026 07:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXTou/N1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6413612D7
	for <linux-wireless@vger.kernel.org>; Fri,  1 May 2026 07:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777619315; cv=pass; b=MZNjmnjc4WjGVGKSLAGc0q0EqCr15KevupuhpZDDC44tCzn20wVoltdQXwFO2IJJq9wa9xAtyh+U2OOZGxnjKSqntDjP8GzWEX/7UFUWpN/0Sn7qjw6Dpv68SazRWAuMVBEorg814oe6SVftzKUiFKobWFWz8JKxjt8gWgbLoiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777619315; c=relaxed/simple;
	bh=/2lPvMgBwRlXYz+hwNAd2sawmW+FBi4qQaQzXa4mF5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QI826xUWyYdujoP3nLeSvOorD1fFxdXg3zG1k2jDctALpqj/ihiehdIxWZvNrFN0GdyXA65YXDlIa+fcEMNo23JhwAYyZaKBjwknI+IyrXpNW9if8kZRw0Xhhj9maJSF+zIXwdcApYp0FO0Am7Yd3qeSXtM7uNHcggcOHZuYTDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXTou/N1; arc=pass smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7dcd689829eso1541450a34.3
        for <linux-wireless@vger.kernel.org>; Fri, 01 May 2026 00:08:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777619312; cv=none;
        d=google.com; s=arc-20240605;
        b=JPFLla7xmd1v6JDVH/+JLOQP1MsNA5zs+VxA+AHVRS3a37xnZbXM5Un7tNNUI6Vsqz
         YmOnyv1Zswf03cQ0zaROtfQlSRf/dYLxwRAgHdiOHyXkCoqnh7maYUn/XOKOgzXpgYtS
         9TqHC89eSoVVXWqpGd/uxByJB7BguXt1CBO6SDbqlY/o2e/LeEOUD7cYsTAWZ5SANy51
         q157CDG8EwY7Y7x4esccmLmz9+y+Zx4uaUjFv/pQwsKOEfqSN9qlkCHShtIoaYhQwWra
         4K58EKwazjR/I2MPJmnHAGtR5x/GnctoIuWEkBbxkXlSB4BK8MOXZoEsP77hWO9h8Nya
         Ws6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tGtVcTIpMWEwpucmYm7Gx7tK/7UnKyIDFZfgCJLjmmw=;
        fh=THoG8FBKFssiqRn5NcDBSL8nR5Lr6qA9KrAPXCyExks=;
        b=QFHiNxg6v2IhsHk7t/gJDEACDIMdzP/hiCrpZb/dD5mFnDcht9/vohPBlULdwro/J4
         +cc16uygitec9S33347JDcLOXNDY54dr6s7OFPsbp7rm/eNC8Kfgpf2zF5agwFvsMW42
         Hff4pFAjfL/zPjX9yjeeehyB9FNLoo6++B+vlZei2O4QBlPZkdGs1fvk7CfCU+fk8CCD
         4kC9Kcw4Vs2fiyoVyIlMidey1ikmCNgsuRizLIqgIzSU8iNtOD3YzC4MXruVmqX0kj/m
         Hd86jWgLRralyZ85uXVTIReUuf5kVpqRgsJrv77sXPsMg1RsQ1QruN4fX5sTyadUAcYy
         PwXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777619312; x=1778224112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGtVcTIpMWEwpucmYm7Gx7tK/7UnKyIDFZfgCJLjmmw=;
        b=cXTou/N1+kS9GIoVx1HqLcqUjD3JRvLuk2U20KpVJzepXqWsjhNbObYaPUerntmAkA
         hLKC7yfpZcpTeKlWAnuPNwldnVlLzB2rLc6RLDJKaOj6oCy7SDyoao5AXWR40J24VUIN
         Z63R4dLIc+kF9oJg8cg9fjXlFbv3AUVOMbRxUAgulD5igZKFZItYpo8eS3kt2NexIcbQ
         dSVKBCjLUvaEjksY6/cJrnRdFSsgKl22RM78y2IQufQcibQfYIGHqqeyWiRnuKgfptJ6
         20fEd+LYPTTkJ3wLe0FytePCUGQhqe8fSBZjfBmFJTEdsyCnPCzbKoOoGYUIrVerzlMU
         99iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777619312; x=1778224112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tGtVcTIpMWEwpucmYm7Gx7tK/7UnKyIDFZfgCJLjmmw=;
        b=LKAmH9/ydjZdpLT3UUmEC0LQau3hwB8WXUc+Set/NgZKpf8Au+nQE+W7heLoz/Mbtt
         Ka3o5gMIeOntg7Vmf1u0lq27YcCilSu7hNnMuRRu6Lr8iGqBw7QKcNKsKEZbVKoEsSFh
         UzrCWuoadHzmOlTzPNk71S+z4MJ/rp9N3+2w//VuUFP1RJudWsObEyLxJz6IEDdiP/Tk
         cGyzhIv/rC6x03XT3+48kCSfop4ZumpyDT0wexXyzJe47tg5oKphCq8G2NjGNSgIYWB1
         zXSBxaqQU5TN8vfCzuIooTNSfQdAE7bYb+A9c/nE5GYZovhkw6rZwdp1FiTsauHCrQA7
         B4IQ==
X-Forwarded-Encrypted: i=1; AFNElJ8c5upKJ+rqTklRQvOye7GBhjHCugQtLc1atQpGtgJ10wKyrFq1Oby/+bBUx/977IAIhjJwTDqsJsvGSgHTxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJyCJBBgXLgbktyEiEqz9HknqFlGIWilpXFHnJFYClTBxk5SwN
	8h3cS7EWlFfaju4k/wxsmhWzrlW+kXqTzFQTWNo1n3a/RTKAS5037KMNYZJVj9LYa6PlfwF409x
	9HGs3Eg28fEJPu8LXbt5Y1iAUQB0HpIU=
X-Gm-Gg: AeBDievgzQCowSxT5YF0LUZdmzSaF4UJXI6hVXwWapjJAHTlcMQ/OvAWpNgLlAanFwd
	CvH1HuKiGLnTk95sVjhjtGc3QPW0efNstanjpTcQL26tbuJ+IZsg8YyvyRBO43qt/H2wteEXoNk
	auER4dRrHPhDytSLu7z07tYX0QoyeqkzYNhgqRrPuxDl4fn8PBZAzyxq3RcN5RlgmQ7pg8Jhlnv
	pVp+YWXTFXhDePcWER8BCcq1L0EBn+YrfP6zqYAOL7T5HVRpjCi3WI+//Zm4eeoswNvgEu7+pbh
	nf3hub4UUND6KEAZnzi7du+vaIyrcuv29SnMIFHa7QliTew=
X-Received: by 2002:a05:6830:2650:b0:7dc:c926:4f87 with SMTP id
 46e09a7af769-7debdde82d2mr3374302a34.16.1777619311744; Fri, 01 May 2026
 00:08:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330-p14s-pm-quirk-v2-1-ef18ce07996b@gmail.com>
 <082b3d13-6fb1-4041-a187-fddec3b013e4@oss.qualcomm.com> <CAOPSVF0VHR4BQsmfWFeFnANsQYBw-x7fHxH2JFNO=oWjgeS66Q@mail.gmail.com>
 <ba4d194b-6d31-4d8a-a6a6-da116f9f56ac@oss.qualcomm.com>
In-Reply-To: <ba4d194b-6d31-4d8a-a6a6-da116f9f56ac@oss.qualcomm.com>
From: Kyle Farnung <kfarnung@gmail.com>
Date: Fri, 1 May 2026 00:08:19 -0700
X-Gm-Features: AVHnY4ICkNhQPdf3q3XMOiB8IYKOepiuhb0qIQbdpuz7l3PNcE3h0yiAcsn0i0o
Message-ID: <CAOPSVF04q6uvVdq8GTRLHBrVMdpt9=o9wVcFMc6f-yhmSBcZqQ@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: ath11k: apply existing PM quirk to ThinkPad P14s
 Gen 5 AMD
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, Baochen Qiang <quic_bqiang@quicinc.com>, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 75A444AAC90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-35742-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kfarnung@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,qualcomm.com:email]

On Mon, Apr 13, 2026 at 11:43=E2=80=AFPM Baochen Qiang
<baochen.qiang@oss.qualcomm.com> wrote:
>
>
>
> On 4/1/2026 11:48 AM, Kyle Farnung wrote:
> > On Tue, Mar 31, 2026 at 7:08=E2=80=AFPM Baochen Qiang
> > <baochen.qiang@oss.qualcomm.com> wrote:
> >>
> >>
> >>
> >> On 3/31/2026 2:32 PM, Kyle Farnung via B4 Relay wrote:
> >>> From: Kyle Farnung <kfarnung@gmail.com>
> >>>
> >>> Some ThinkPad P14s Gen 5 AMD systems experience suspend/resume
> >>> reliability issues similar to those reported in [1]. These platforms
> >>
> >> how similar it is? can you describe the issue in details?
> >
> > The issue is that intermittently after suspend my WiFi adapter connects
> > successfully for a few minutes and then drops. It will then keep trying=
 to
> > reconnect in a loop but never succeed. A reboot will fix it, but eventu=
ally
> > I found that reloading the module also resolves the issue
> > (modprobe -r ath11k_pci && modprobe ath11k_pci). Based on some searchin=
g, I
> > did try adding "ath11k_pci.disable_idle_ps=3D1" to my kernel arguments.=
 At
> > first it looked like maybe it worked, but then I hit the same problem
> > again. At that point I decided to try building a custom module with the
> > ATH11K_PM_WOW override and so far I'm two days and 10 suspends in witho=
ut
> > issue.
> >
> > Looking through kernel logs, the issue appears to have started with ker=
nel
> > version 6.17.4. It looks like my Fedora install jumped from 6.16.10 to
> > 6.17.4 on October 22, 2025 and I started seeing the issue two days late=
r.
> >
> > Here are the logs from the most recent occurrence (filtered for brevity=
):
> >
> > Mar 29 15:26:24 kjfp14sg5 kernel: PM: suspend exit
> > Mar 29 15:26:24 kjfp14sg5 kernel: ath11k_pci 0000:02:00.0: chip_id
> > 0x12 chip_family 0xb board_id 0xff soc_id 0x400c1211
> > Mar 29 15:26:24 kjfp14sg5 kernel: ath11k_pci 0000:02:00.0: fw_version
> > 0x11088c35 fw_build_timestamp 2024-04-17 08:34 fw_build_id
> > WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> > Mar 29 15:26:30 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> > CTRL-EVENT-REGDOM-CHANGE init=3DDRIVER type=3DCOUNTRY alpha2=3DUS
> > Mar 29 15:26:30 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> > CTRL-EVENT-REGDOM-CHANGE init=3DDRIVER type=3DCOUNTRY alpha2=3DUS
> > Mar 29 15:26:30 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> > CTRL-EVENT-REGDOM-CHANGE init=3DDRIVER type=3DCOUNTRY alpha2=3DUS
> > Mar 29 15:26:35 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> > CTRL-EVENT-CONNECTED - Connection to 68:d7:9a:2a:94:f8 completed [id=3D=
0
> > id_str=3D]
> > Mar 29 15:26:49 kjfp14sg5 wpa_supplicant[2373]: wlp2s0: CTRL-EVENT-BEAC=
ON-LOSS
>
> this is the reason to your disconnection
>
> > Mar 29 15:26:55 kjfp14sg5 kernel: ath11k_pci 0000:02:00.0: failed to
> > flush transmit queue, data pkts pending 9
> > Mar 29 15:26:55 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> > CTRL-EVENT-DISCONNECTED bssid=3D68:d7:9a:2a:94:f8 reason=3D4
> > locally_generated=3D1
> > Mar 29 15:27:00 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> > CTRL-EVENT-DISCONNECTED bssid=3D80:2a:a8:98:26:3e reason=3D6
> > Mar 29 15:27:05 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> > CTRL-EVENT-DISCONNECTED bssid=3D74:ac:b9:df:54:36 reason=3D6
> > Mar 29 15:27:09 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> > CTRL-EVENT-DISCONNECTED bssid=3D68:d7:9a:2a:94:f8 reason=3D2
> > Mar 29 15:27:09 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> > CTRL-EVENT-SSID-TEMP-DISABLED id=3D0 ssid=3D"Batman" auth_failures=3D1
> > duration=3D10 reason=3DCONN_FAILED
>
> and the bssid is disabled so association to this AP won't happen in a per=
iod.
>
> Anyway, although it works, using the PM quirk seems not the right fix. As=
 you mentioned it
> seems like a regression starting to show in 6.17.4, can you do regression=
 test to locate
> the issue commit?

It took a bit of trial and error, but I'm reasonably confident that [3] is
the culprit. The issue is pretty sporadic, but I've been able to reproduce
it twice in ~50 sleep/wake cycles on that commit, while the immediate
ancestor has been clean for 17 cycles so far. I'll continue testing and
report back.

The change looks suspicious as it modifies a code path that runs on every
sleep/wake cycle, and the failure appears to be some sort of corrupted
firmware state. In a couple of cases the WiFi firmware crashed outright
(MHI_CB_EE_RDDM) while the issue was occurring.

[3] 79266fd78df1 ("wifi: ath11k: HAL SRNG: don't deinitialize and
re-initialize again")

>
> >
> >>
> >>> were not previously included in the ath11k PM quirk table.
> >>>
> >>> Add DMI matches for product IDs 21ME and 21MF to apply the existing
> >>> ATH11K_PM_WOW override, improving suspend/resume behavior on these
> >>> systems.
> >>>
> >>> Tested on a ThinkPad P14s Gen 5 AMD (21ME) running 6.19.9.
> >>>
> >>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D219196
> >>> [2] https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/=
thinkpad-p-series-laptops/thinkpad-p14s-gen-5-type-21me-21mf/
> >>>
> >>> Fixes: ce8669a27016 ("wifi: ath11k: determine PM policy based on mach=
ine model")
> >>> Cc: stable@vger.kernel.org
> >>> Signed-off-by: Kyle Farnung <kfarnung@gmail.com>
> >>> ---
> >>> Changes in v2:
> >>> - Fix missing mailing list recipients (linux-wireless, ath11k, linux-=
kernel)
> >>> - Link to v1: https://lore.kernel.org/r/20260330-p14s-pm-quirk-v1-1-c=
f2fa39cc2d5@gmail.com
> >>> ---
> >>>  drivers/net/wireless/ath/ath11k/core.c | 14 ++++++++++++++
> >>>  1 file changed, 14 insertions(+)
> >>>
> >>> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wir=
eless/ath/ath11k/core.c
> >>> index 3f6f4db5b7ee1aba79fd7526e5d59d068e0f4a2e..21d366224e75904feeae6=
cb9c93d9ef692d127fe 100644
> >>> --- a/drivers/net/wireless/ath/ath11k/core.c
> >>> +++ b/drivers/net/wireless/ath/ath11k/core.c
> >>> @@ -1041,6 +1041,20 @@ static const struct dmi_system_id ath11k_pm_qu=
irk_table[] =3D {
> >>>                       DMI_MATCH(DMI_PRODUCT_NAME, "21D5"),
> >>>               },
> >>>       },
> >>> +     {
> >>> +             .driver_data =3D (void *)ATH11K_PM_WOW,
> >>> +             .matches =3D { /* P14s G5 AMD #1 */
> >>> +                     DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> >>> +                     DMI_MATCH(DMI_PRODUCT_NAME, "21ME"),
> >>> +             },
> >>> +     },
> >>> +     {
> >>> +             .driver_data =3D (void *)ATH11K_PM_WOW,
> >>> +             .matches =3D { /* P14s G5 AMD #2 */
> >>> +                     DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> >>> +                     DMI_MATCH(DMI_PRODUCT_NAME, "21MF"),
> >>> +             },
> >>> +     },
> >>>       {}
> >>>  };
> >>>
> >>>
> >>> ---
> >>> base-commit: dbd94b9831bc52a1efb7ff3de841ffc3457428ce
> >>> change-id: 20260330-p14s-pm-quirk-0a51ba19235f
> >>>
> >>> Best regards,
> >>
>

