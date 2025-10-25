Return-Path: <linux-wireless+bounces-28271-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 901C1C09E68
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 20:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6D91434CC77
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 18:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80662301022;
	Sat, 25 Oct 2025 18:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="FABmC0It"
X-Original-To: Linux-wireless@vger.kernel.org
Received: from mail-07.mail-europe.com (mail-07.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F6618E1F
	for <Linux-wireless@vger.kernel.org>; Sat, 25 Oct 2025 18:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761417351; cv=none; b=YLTLZy9zsus9EtEZgZzHQ7k2vNiXP3vceiXBhltqmFJqPjdhV5/pWdmgXMdu9yvjtIA5KhTw+o9nf58DxiCOngxnzQiVZMMaGQr48qNNXqnXUYxWYy3DKsKwg7HF1E7YUFXi6OOTD9OvZ0rFUrC4EBWn37vAlnam/Pzvo7V1GnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761417351; c=relaxed/simple;
	bh=hrls5/Ad1iVeQotMvLsY5g1yyc4AAKD7ajSaBxJVjT0=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=UC+EmaIq05z8jT7N6NDUeQbfGmg9o1IlsK7CJqJ+gbSVPF3VDCKX1cNCfrP3rqlkKGwsnotLYfwwe5/ZpAEeTpB3HffUqEYCY551qSP/RnoU8qWM1fIGCl8Ci4iaSOzbVuUF/7wHq3xV+1YTwx7dHFKlVEyodkRDkj9rAqmRWMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=FABmC0It; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1761417338; x=1761676538;
	bh=hrls5/Ad1iVeQotMvLsY5g1yyc4AAKD7ajSaBxJVjT0=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=FABmC0ItsHOoph/HwwXSWWEkQY+oN7zE1EITRM18FqkbP6emDdzC5pMMzJsqXN0c7
	 UohlgqezZ6PXfVg8VbehMM17pgaOIoq9QfXZJdfDl2C/7TbPLxP+2KPhIAEENfcri9
	 Dk3IxKD83proUlUltC/X+a6KCuRQZBOcouUFa4t1/rQeDxzM5bDJ8XX1PTJk3QTokj
	 Cd8npYzMEn3dynAzN0g+4KBpan/H+fPXGBCtves1snFe3VdBt+zZY0tOXmmWTiGENC
	 1EZDy59HpkkKu/YuC/4vfARoyrn6ldCNT0y2N6ea4MfNq4zat03s5svky17nMjE9K1
	 PAHIOp94RJ7wg==
Date: Sat, 25 Oct 2025 18:35:33 +0000
To: wojcikmarcin49@gmail.com
From: Nate S <gitnux@pm.me>
Cc: Linux-wireless@vger.kernel.org
Subject: No networks available after suspend on Debian 13
Message-ID: <880cd1a0-647f-4039-9edc-bd76576b5a74@pm.me>
Feedback-ID: 91264322:user:proton
X-Pm-Message-ID: 4e47c6a4f1c79a13f3aeb1c308dbbbd16671ae71
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I was asked to reply after this fix:

`echo 0 | dd "of=3D/sys/bus/pci/devices/0000:01:00.0/d3cold_allowed"`

---

6.12.48+deb13-amd64

DMI: HP HP Laptop 15-fd0xxx/8DDB, BIOS F.19 05/28/2025







