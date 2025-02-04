Return-Path: <linux-wireless+bounces-18410-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF75A26EF6
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 11:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10A5318871C4
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 10:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BB02080DB;
	Tue,  4 Feb 2025 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hd/E9e+w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FCA208992;
	Tue,  4 Feb 2025 10:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738663375; cv=none; b=M9/F5lVfgGTOIXisngUG1oBPimSztczVHNXUZ6zgOwkLo9cW+tFRwFRe4Dz6WIGBOcy93CLddiEpPw7L2I0pYTnkxEVcSxQzGIrMBufG4kANSGrqItBQ9gP1BxA6Umgnu4IdhWsw8hWLnbioUeTU3Qw8JcBg6DfDq7aE1RDJlaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738663375; c=relaxed/simple;
	bh=NVe+5Vj5wT+jv8MRUuBhLO5f0ZuuCoMo+ewbhxjx8dc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gxa4WaasFqBiUecP4XqWnUtHuZSN9Ijc0dPLh3dw03WOxO2LQlCfXpJKzLsX4aSc1RgvU4rxiJTIozHm/A5s/Xd55pszyan6CQCT8OBZi4SZYFTZE5s4eBjM+nG36+majOj5Lpd0vZI9hX3ra33XBpsqqQrSiiHmtcUN4SFpdxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hd/E9e+w; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38daf1f5091so132523f8f.1;
        Tue, 04 Feb 2025 02:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738663372; x=1739268172; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phievftbMhEJWOjF57oTUK/kdR4f6x3/eDPPiCF/bJU=;
        b=hd/E9e+wHHRte0VdAXsvSl0WFtiv7dIzPpjPUlkpXs/x/2FRtQlliztplO7rnLEek+
         z/uD5o/HZEH3htylh7vYjXOpxyaocnkE99UXGrbVcX9sewa81phKhhxhDKI/5OIII+8R
         5yCtBhrKSRQv1zZERSlMU63F10Zp7NByZXH0vyg0lP49hcdfO6m4wKyD3ACCSCTK04nj
         EwEVHFo+Vf0OV98F0FNexU5epQ2O7mzL1q6zut7SCxmZ68jaS6/xI5RcbGNAA8/a8k6P
         vrFaFgFG1f/bliEirVBxGaDGCM2f90vyRe2Gu7czUL9E0mlRF535lPsCMSRR69kx5lHm
         FLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738663372; x=1739268172;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=phievftbMhEJWOjF57oTUK/kdR4f6x3/eDPPiCF/bJU=;
        b=ak6vsPM8F9yobKlwL8+LSNrm4w8hXTYYqRpNm04J2QTFKjXwB7Tq+FoyrFVUZaMNIG
         MPuyfJ7wn+WWnqUlYVq3ukPrxdzz8s3SskgSX14YG35k98lZDGxT1l7kiC0iwQ4wtCGG
         HCurVxdrTClU7jNLb1tdI74x+pWixvBBS/kZbq80v6eFeS7qugEbaYnkSuL26kgoa3yd
         6bJgtHSsuSJrDHhswzAzI9FPU4Bn7mLGf+9DDqnZLNIC526zECkJXuSPtzXGLuTVxm0S
         vyV0p5aMUyegwRHlANy0mWIP5plLcVnQpexus+tA0XItnziI4JBCB1CJCKO4ziFelvpQ
         IXFw==
X-Forwarded-Encrypted: i=1; AJvYcCV6g/VpI5BBhOoa+2v0iQOI9YsJI1hh+f+oHkYWZp7GcFoRg3cGwpoDgn+2s6QvaY/pQvSbzM5f9AJnodg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIBYyN+r31cPMevKzSUzJCP3xAvCzIRePTgshTG4w3t23XiBvb
	2Z8cOPtpTxsUmK9OqeMpCz6MuSMCcSNqMgBSlgpDpyRBHZ8pzNu3
X-Gm-Gg: ASbGnctoOQw7W6ziizzcJgeF6VX8Lyb/zyJUcbT6cMGHiwIu1BSSEtNTx5uzHQK+nvp
	OyTe4/8qDpm5oC/NJ//SvcHzUc/+yjw0AcRIxR79bWnrrBumxLshzjtHvpdZmVK3jYbAm+v46yV
	DYOlFOaJryjsOEW4TuRIlZPmNhrdI61nQtHLOERR8HgZ96aQU0+/jD5YqFLFBzB5MCmGe9hLYWJ
	1yNlbZQSStrDrs/bNbQmkb8+N9BuZXzE/JUapOrzKUL+2uaYZKrJGnQdkUxUpLzjFrbFqaPvFJt
	nF+6d1e1z+AvDTZfXiFY2erqyYRxeyq9FQ==
X-Google-Smtp-Source: AGHT+IE17SiHozWKj+Os0pE2Y/1zwACLsOViGQPHYeNCGvgkHtVrDitOn4GliYkHWXRDJzqG8U9sig==
X-Received: by 2002:a5d:4d47:0:b0:38b:f44b:8663 with SMTP id ffacd0b85a97d-38c520bb322mr15854536f8f.55.1738663371922;
        Tue, 04 Feb 2025 02:02:51 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c11fadbsm15039077f8f.44.2025.02.04.02.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 02:02:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Feb 2025 11:02:50 +0100
Message-Id: <D7JKQ60C6EZA.24H639LLIG2U7@gmail.com>
Cc: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/8] wifi: ath12k: handle change_vif_links() callback
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Aditya Kumar Singh" <aditya.kumar.singh@oss.qualcomm.com>, "Kalle Valo"
 <kvalo@kernel.org>, "Jeff Johnson" <jjohnson@kernel.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250204-unlink_link_arvif_from_chanctx-v1-0-675bd4cea339@oss.qualcomm.com>
In-Reply-To: <20250204-unlink_link_arvif_from_chanctx-v1-0-675bd4cea339@oss.qualcomm.com>

On Tue Feb 4, 2025 at 5:23 AM CET, Aditya Kumar Singh wrote:
> Currently, links in an interface are allocated during channel assignment
> via assign_vif_chanctx(). Conversely, links are deleted during channel
> unassignment via unassign_vif_chanctx(). However, deleting links during
> channel unassignment does not comply with mac80211 link handling.
> Therefore, this process should be managed within change_vif_links().
>
> This series aims to add support to handle links in change_vif_links()
> callback.
>
> Patches 1-2 are making debug infra to work without device info.
>
> Patches 3-8 are the ones changing the code to handle as mentioned above.
>
> NOTE:
> * A new ath12k-check warning comes which probably needs to be added to
> ignore list
>
> drivers/net/wireless/ath/ath12k/debug.c:69: Prefer [subsystem eg: netdev]=
_dbg([subsystem]dev, ... then dev_dbg(dev, ... then pr_debug(...  to printk=
(KERN_DEBUG ...
>
> This is because, since device info is not known can not use netdev_ or de=
v_
> dbg family. pr_debug() is an option but that will require DYNAMIC_DEBUG
> and then ath12k needs to be probed with dyndbg=3D+p which we don't want i=
n
> ath. Hence, only option left is to use printk() directly.
>
Hello,

When applying this series I am no longer able to start an AP on a DFS chann=
el.
(I don't know specifically which patch though)

After the initial CAC period I get the following kernel message:
	[   45.248441] ath12k_pci 0003:01:00.0: cannot install key for non-existen=
t peer 3a:07:16:d8:00:08
And then hostapd goes in failed state:
	wlan0: interface state UNINITIALIZED->COUNTRY_UPDATE
	ACS: Automatic channel selection started, this may take a bit
	wlan0: interface state COUNTRY_UPDATE->ACS
	wlan0: ACS-STARTED
	wlan0: ACS-COMPLETED freq=3D5620 channel=3D124
	wlan0: interface state ACS->DFS
	wlan0: DFS-CAC-START freq=3D5620 chan=3D124 sec_chan=3D1, width=3D2, seg0=
=3D114, seg1=3D0, cac_time=3D5s
	wlan0: DFS-CAC-COMPLETED success=3D1 freq=3D5620 ht_enabled=3D0 chan_offse=
t=3D0 chan_width=3D5 cf1=3D5570 cf2=3D0 radar_detected=3D0
	wlan0: nl80211: kernel reports: key addition failed
	Interface initialization failed
	wlan0: interface state DFS->DISABLED
	wlan0: AP-DISABLED

Maybe I missed something ? Is there another series this one depends upon th=
at I
should have applied before ?

Thanks

