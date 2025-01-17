Return-Path: <linux-wireless+bounces-17634-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D94BA14C51
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 10:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594A4166F8D
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 09:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0821FA828;
	Fri, 17 Jan 2025 09:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzL4zTxa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6721F9AAD
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 09:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737107193; cv=none; b=ax8u65fFU+Zaj1PempL/DHrEmJWA8S+w817M0LGAkqthpB5HpvPKBKv0GZPgnwTxJwojjHs4tPncfMVz2LIg4ws36OU9MFLWY2oIkXZyX6E8SDJ4XtRYQW2076RrehxrdMKdKtKOho/pmsgAvx0mAJDUcwL/1+thYslWwjPl3Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737107193; c=relaxed/simple;
	bh=O4hBp0TCeNb4jgoyOrHuru28rEsiSTagGEUyqsSUl0U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YRQ0HLnVeiDHWHjfY+fI6vSjgRZ0ldo54/IKLksjmNGE72PFIGnI6eVQ0MIOYvET00MWQerPh3NXbifyrOMYuBObmqGRlcuY9ZU3/PJSMmniAtw77fvRnOIL4z0xSnRDMBKPrAijnhadXPhZkXXaeRd5We78t3/UZozCEKbg2Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzL4zTxa; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4368a293339so20000915e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 01:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737107190; x=1737711990; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4hBp0TCeNb4jgoyOrHuru28rEsiSTagGEUyqsSUl0U=;
        b=gzL4zTxabT7zl3tPp3TM8AqEBJY3/HYDuK3Dok2eFHIYgWLCyE4VXU84zhBl28XvPf
         IzSO3C1/80ErBKGhlqEVoM2BZ+ggrK5Soqj/Rz4Clc8MhqEhHf+TkfQmIJlIzyuPjL26
         x8DskKuxXbptSomMfqnLw2PzIUgBg6SHSHq6Ww0+1x3RtSjT3w3dQSE3qI8UyUuW9r5X
         AL/LZVBobkfesRTGdjsoRpljWEP9j+fwYMMOnop/ysSZbSejZrURGczME40CzclMukCt
         Kg8h8MrUEW9nttrpS6nlqmZjPkx9caoJ64D28Sahu1Tr7mREkJQT+E0YsoOpL4cTcy3H
         jMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737107190; x=1737711990;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O4hBp0TCeNb4jgoyOrHuru28rEsiSTagGEUyqsSUl0U=;
        b=Cfoc8cjzXyX3pAEIuayFoNr4Vnc0Q46o7kl02YhSeSFtKa2WQVpHQJGsRZqZtfXu+d
         YCiS+GcN0/2JLTiys9v7X+64VN4/8ub1y0V0QNJ7Yh7pECECnT5FtQ0hK+hynJaxSog9
         S8p1DpZbfWdxDrQmWrSpiqFaiKzmtIILIemlre9BA0dQcaE/9INqdokF0z1x6IYDfw/V
         4esu1noVXXAqNmpfeSR0WoExGFaBGwesB9/VoH9wU3P3m2Oe8lpopVtPeQYCBCo289/a
         sWcLX+spliHl7ceafDcO5o1eInAgVornsiC+V0LO60VGgdeqM9R1bZh6LrAGElUoE1Fz
         rfrQ==
X-Gm-Message-State: AOJu0YxS19Rrbx28/vUytj9Zuuks3cvRAO/bjL8Gh9tKhlGeBYeh2Ti3
	ltpljSHntKmdllIa4q+DCf8s2CF8Ppo6lxDgDZ2C4o7LvaQ30rRj
X-Gm-Gg: ASbGncuPpwd14VPVHPvw/9NlNY0p4NnX3Dd5Kgt1ApDGvcRnn/Aw/g117b0izAVAt+n
	GD2hzK1JejO6azD3+LfSUChkC5IJNop5SOqG7jXEKQKcAx2isUTSoHSrzAVRQvLZIcgi99zJkED
	bbhQeKCSotPs2bvvMG1KXFpsdd3NYd+i0nq32ipdSEVToMgC3CU+jSKdaRYSE0ql0FXI09reqbd
	VmWcsXgvugFaRPXOvjXpYjAPwSJiimboqhA4VtHOgCNcIpNQxKhulP+SRbZlev62iGWtuFKpcM=
X-Google-Smtp-Source: AGHT+IG44lq6Xs8TjLlxvjNLydQ9QPXwgmxcuG5OXImXTvfM0ujy+ohsngUpa7xqaoEz8L9b2iBHYQ==
X-Received: by 2002:a05:600c:1f11:b0:434:fff1:1ade with SMTP id 5b1f17b1804b1-438913df205mr16717345e9.13.1737107189411;
        Fri, 17 Jan 2025 01:46:29 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3278088sm2046160f8f.73.2025.01.17.01.46.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 01:46:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jan 2025 10:46:28 +0100
Message-Id: <D7493TJ2Q2YJ.2EVCWPQR58U4A@gmail.com>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 0/7] wifi: ath12k: Add monitor interface support on
 QCN9274
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Karthikeyan Periyasamy" <quic_periyasa@quicinc.com>,
 <ath12k@lists.infradead.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250107021017.3857555-1-quic_periyasa@quicinc.com>
 <D72U91ZG2PNM.2IXUT304LMEC0@gmail.com>
 <d9181c82-ffb1-e8de-c5c6-f58b73f9291f@quicinc.com>
In-Reply-To: <d9181c82-ffb1-e8de-c5c6-f58b73f9291f@quicinc.com>

On Fri Jan 17, 2025 at 5:37 AM CET, Karthikeyan Periyasamy wrote:
> On 1/15/2025 11:25 PM, Nicolas Escande wrote:
> > On Tue Jan 7, 2025 at 3:10 AM CET, Karthikeyan Periyasamy wrote:
[...]=20
> > I applied it on top of ath-pending-202501150104 + the "ath12k: Add peer=
 extended
> > Rx statistics debugfs support" and now 'iw dev wlan0 station dump' show=
s me
> > that the RSSI value seems to not be updated anymore after I stop a moni=
tor
> > interface on the same phy.
> >=20
> > Steps to reproduce:
> > iw phy phy0 interface add mon0 type monitor
> > ip link set mon0 up
> > # then just for 1 sec but it might not be usefull at all
> > tcpdump -nepi mon0
> > ip link set mon0 down
> > watch -n1 iw dev wlan0 station dump
> > # 'signal' seems to not be updating anymore, maybe some other fields to=
o ?
> >=20
>
> Not able to find the wlan0 interface details from the above steps ?

Arf maybe I wasn't clear, my bad.

I have a running AP on wlan0. I constantly monitor connected stations infos
using 'iw dev wlan0 station dump' on the side in another terminal, and then=
 I
add a monitor interface with the above steps, and thats when I see that the
stations connected to my AP have frozen values in station dump.

I suspect that ath12k_dp_tx_htt_rx_monitor_mode_ring_config() should reset =
the
rx filters to ath12k_mac_mon_status_filter_default when disabling monitor. =
But
I'm not so sure, you guys know better.

