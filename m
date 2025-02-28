Return-Path: <linux-wireless+bounces-19595-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A40A49D05
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 16:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F7187A4028
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 15:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336CA2500CD;
	Fri, 28 Feb 2025 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="KZJgsuSY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2A81EF381;
	Fri, 28 Feb 2025 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740755684; cv=none; b=Z7KdYiHu1XkC9PousFWU9aI4HniJMGxHCJy4iDwlA+Nx+cQCYpBO1yhY9p8BhRluk3lI4Vtxax4qwgYymtxG6TrYkt1zDU/ZZgMyS4/LuQwMLpiu2prpdiZxqeWm0S/dlB1YQx2w7HuFolBIEkXmDwy5r5CpvncTZeB+8fVyIVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740755684; c=relaxed/simple;
	bh=NOIaiVi7loLRevJWOYiXC61BcUpEJwIqE3YlfRh2sRE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OC/THrrJ1RV07ckAKDxNC3drVsLF/xes/BwlFkT7JimA+xMrV2zm29Tk92rPxp/tQ+lFPIe3usBwXx75i1hIBOJugItO79i4K1uPwYacH+JOBPWSny6r0GUVdqq4BEoJwJ+q/iiqfwvQHHP8ug9y7Vta4yCGFVFiuajIgPV3tXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=KZJgsuSY; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1740755662; x=1741360462; i=ps.report@gmx.net;
	bh=Bm77GiaKy4B5E8U7E3Q8p7UvT2yl7qRHpaz9uX0zrNM=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KZJgsuSY7KBn5JLzAhrB/Z2J97PkcmTio/JMwanPF9Abq3Fv6zLEtg/ImvVBHh0/
	 +gcW8iw8+rQ9XlxttEnXAINtZFEFoCfdtFm8ZjjpHrBCG9CRRU1e1VPqu7JhwDh4o
	 QCPU328PDvFYZYxd6/E1qqFTRVzLfW4lWE4pTUAjFaHt6aVqiRuAOSapV2/Qe8XQy
	 DF/wHuvsddWy7O/X5TLvDJ8ldWFavzAeit80V5mhmULhGbezTy2L3ZjON9JsKpt6V
	 PX6dlVc411+eHCWzU3Yb/xBZEEQnscyafKsGUetzfiV3XO5RF7gZ9pSIFwx/PHaUT
	 PMVQKYNVWsgCGg0gaw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([82.135.81.95]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MzQkK-1t1PYs0Z9M-00zhNV; Fri, 28
 Feb 2025 16:14:22 +0100
Date: Fri, 28 Feb 2025 16:14:20 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: Christian Heusel <christian@heusel.eu>
Cc: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, stable@vger.kernel.org,
 Benjamin Xiao <fossben@pm.me>, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, linux-mediatek@lists.infradead.org,
 linux-wireless@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED][STABLE] MT7925 wifi throughput halved
 with 6.13.2
Message-ID: <20250228161420.11ac4696@gmx.net>
In-Reply-To: <b994a256-ee2f-4831-ad61-288ae7bc864b@heusel.eu>
References: <b994a256-ee2f-4831-ad61-288ae7bc864b@heusel.eu>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i4T6/EbgFwr0KfP3Z8OoxJOOCwMntS0pNgUxOQPDz3qE9Yunna5
 yYQNNRVMcrb1ujz1h5zgD4pXfZ1i8xNE7W6i+TJ0OO33ufyZIGS1/nhLPDOIe23ricKukSR
 1qDvL/xABENHxxZA8JvW6kqQSRqQuPsXVMpycxZsHxxFH8UwvS9sguMgMBlKmJ3Fz4sIJ3d
 fQ7K0RFosbpTR+RpA0zBQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vn2tnnWN6Fo=;Rtv/w94WvvtCQ5op19orjFAa30U
 3/hYOSUd6X+HGBVZrfzjiABuAhXF6qPtrF7qCQ4WvrTat3V1//t2hbwAj3iD23Pxd2WqFLrRG
 xoinsfikG+HgqUs3BquPocL8a/BlAUI4qmApFf+pqv2b9kQnL5FCUk8HCwoV6FenpgV8Tujdf
 EecoSvicsKHLt2A3sPGxevdSahVvaNXpBRnv4Rwcn7Ch0VJ02l0VjyanHBtAzm9JmNspPM7om
 KR4YCw8QsHKwfeEbVzTchIwfIwA3BBMO54dyszZ/tLA/dLqH+AU0ouKMSkvR+/YOSM85wT3x8
 byv4nAVRXcL66DbuvXRLH8bLiYvjE3jOyZ1NW+xVq3eblxeg2kDlphTgSttQIojwKCblneQKi
 pe6vWpIVKIR59k8SLq16WoPqf+18xazwe76/N8n2IDv7TkcetZ0EuoxWtOv9jNPCOe3FgUI1g
 gH9GNM9ASR2fcBuSXrrUldLU04Oz6/awgmUM28TkEZH5wVLU6DKT/4jSBogjwcFIrXcgHxyF8
 8LaV6GBRpinx7LD7NxZ+dSwgu4nj09EI9wztMitlwaGkT3w5sFVqLpsNejdqZnPlu6Cs0l6Pf
 RyhMm8uExhL+TOcpakXGe5Zxj6KwYEnUDJaT6aDy5TCZnjrbEjjzTz1rosbDNvl/Ri3xAGkHH
 JEmA0JJdD3G3ixtc13a7iJSQ8rkOEsYifUEmvgtfb5z84xXzJXC9HTPgsvldqIev7stf371YL
 mPzojRhlRZaKZV+LRv6dRJrHGJIIstipNcKKv2uwe5BIusoL6BGUG1uN42jxB6maPuNByfGnU
 28jtym+mo5B/8+2NE6OU1OhVVNSro9Obqnxpi794YSjwBIUwqYhv2u0UD8MhYWYWV32oGJTtS
 CtDxm9jn5e1y0lEgjWc+UZKOi0CmMtVf/BAgX7sk5WQfGFimoLAPvXe2PiZ7oMg04fwk5NaeQ
 mVxJWc0WkFNQSb8X4vsFWwIX4O6dODzElS96VPJJsKWonUoX6Fb+GcMbBggtRwPk9zKzKvW2m
 f2zQePbJ3iOWdis6GfHhvS9ecVtFfqDVKjAwjSphKlt1zIoLqe1JryFtMI9lakiEyzfDZaLhb
 dQxy171z/vBuJfMESu9MyColPywNTxGs4KVnI/vvsZKF+MySy3HSRoLy5Ez5Du+tKfzFywlsv
 l8ubZmCtN5hoES/U6gNi6uL5mYuM22btrEncBUb/S/bAHAWuQLM8MKW/XY3XX97cYcsTHI5bk
 Nsh4HQfehWur5ZWEypRwdAEqs9fNnYymj11l+46BJ4O/RoAup3acw32SFfYbdlG6aGl6TQRA5
 hEA9U4qSbNPzh3OlHE95RXquWq0CuKIHoBvGUsDePwvdFkuSqCp4F9cleyyd3EPDZxzC2rlmI
 +v9nMhumKfB+ikfrEzGLfVp4593hU/CfwsiTREyc3Yohche+bXp5kDhiEZ

Hello Christian,

On Fri, 28 Feb 2025 11:19:52 +0100, Christian Heusel <christian@heusel.eu>=
 wrote:

> Hello everyone,
>
> on the Arch Linux Bugtracker[1] Benjamin (also added in CC) reported
> that his MT7925 wifi card has halved it's throughput when updating from
> the v6.13.1 to the v6.13.2 stable kernel. The problem is still present
> in the 6.13.5 stable kernel.
>
> We have bisected this issue together and found the backporting of the
> following commit responsible for this issue:
>
>     4cf9f08632c0 ("wifi: mt76: mt7925: Update mt7925_mcu_uni_[tx,rx]_ba =
for MLO")

Seems there is already a suggested revert of the mentioned commit, see

	[PATCH v4 1/6] Revert "wifi: mt76: mt7925: Update mt7925_mcu_uni_[tx,rx]_=
ba for MLO"
	https://lore.kernel.org/linux-wireless/20250226025647.102904-1-sean.wang@=
kernel.org/#r

Regards,
Peter


>
> We unfortunately didn't have a chance to test the mainline releases as
> the reporter uses the (out of tree) nvidia modules that were not
> compatible with mainline release at the time of testing. We will soon
> test against Mainline aswell.
>
> I have attached dmesg outputs of a good and a bad boot aswell as his
> other hardware specs and will be available to debug this further.
>
> Cheers,
> Christian
>
> [1]: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/i=
ssues/112


