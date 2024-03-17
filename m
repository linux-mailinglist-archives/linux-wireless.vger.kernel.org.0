Return-Path: <linux-wireless+bounces-4804-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B66387DCA2
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Mar 2024 09:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBBCBB21080
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Mar 2024 08:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8498C05;
	Sun, 17 Mar 2024 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=testtoast.com header.i=@testtoast.com header.b="Y1piuJph";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nBzb41Oj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C0A63CF
	for <linux-wireless@vger.kernel.org>; Sun, 17 Mar 2024 08:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710664864; cv=none; b=uLZcoxhGA37cD/5/qDhffCGJlNDSjPzS0rFuoML0hLRT3NIgXGj6n63cVO7O2NVQHkUyAZcTu6yN6EL8BZMyZs9stEGH/tcOJ7S/DnORP17W/d+WmqYYb61HCiekfY/8KySb1L4koPg35rL6mJdSL8wFrJnr4rSatofyub2M6Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710664864; c=relaxed/simple;
	bh=anmDECffHNT93jRiQ0rFWIJyrxE2Iql748bcsJ3j+/w=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=EzlYCx5QnL5MoCAgRunq29k5d3KU7nd8Pf4P7an2MezKvPf+vR1rYJkj9SiCMXEWcCvysUg599d+BFiTiK7ldE4oLcLci4uDO/jBBKQlCHzAcF9omiIxCMgVqWYJ0fR9vpgXMjiWkwNuDSdBePST3sx0UWGjQ08hifuFbfDHim8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=testtoast.com; spf=pass smtp.mailfrom=testtoast.com; dkim=pass (2048-bit key) header.d=testtoast.com header.i=@testtoast.com header.b=Y1piuJph; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nBzb41Oj; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=testtoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=testtoast.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4D2AD13800A6;
	Sun, 17 Mar 2024 04:41:01 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Sun, 17 Mar 2024 04:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=testtoast.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1710664861; x=
	1710751261; bh=iq/K40ZVnREET5uAoPChJlJ91jSHo5fC1dCAOVnA7uM=; b=Y
	1piuJph5ONlP1Et9LIsGahW141CmZzoPrvhvUbqDWigYtnAr4PQgjP2S/D04SGa5
	eKMD+0nCN6avXP7sDVXsVZdP4sl5M6Wj+IT08siBqa/DU9qQHX6/hhHP3ybexKgb
	5KpIqjn1batlPMHI3koriQ/X+fTdxX0xwZsWwJKkzpbQTxeho57Ebvi0fXsT9N3n
	cYK1FsT5R8+I4Y3FcmzgjzzCBAXngic5m2msujfAZkV7jIBvMusJvnI+sWkQ96yR
	d8SubbLwXXKcBZTZQqDV36gDruYTGOwroDxDavc1yImEnIWCXKn6XnRjzHOLFlZ/
	VJRROJUDka++bH5e/OMIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1710664861; x=1710751261; bh=iq/K40ZVnREET5uAoPChJlJ91jSH
	o5fC1dCAOVnA7uM=; b=nBzb41Oj7MHf1nwZWJi9RrtXILtmBjxlxr/8RYuKG9i/
	IdSPx9VqMNjGpv24P76sKMIDef+S/vBqYbezffOQYrqdvQBuA3FDrN0YOUnp0/ID
	x/DbmV2ENvl6574QAI04l8lDU7lzvor5FS1z54bNwCaKmVmGuhKexdMpLYPyAwe3
	W5GQkDTG3hvuILXvWLC86MwAriLP7NgmrPW48H7ROh+K2bm3crdiD4Epvri4EHWe
	j8tE+/UPMF3hydQPwrNvjGH0C8p6oqBEN6WqaCSGi9SG+XZdc7Wir0Uw31sSIkW4
	foA85hdMHfPsSqkx+X1OpUIb7DPu8bpV/sIP67ZgnQ==
X-ME-Sender: <xms:nKz2Za3ESRxddTFqYPDtAbRBmSSjF50N1BJvXxxu-9kCzERWuTqGdA>
    <xme:nKz2ZdFHju_tfmeC_g_Yt-sDpYHpU_ApfiaQaLUVzGXQ0o3R1AE5M8WzoOO_1xy1r
    DtIzPl0Oun8KDfpew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeefgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftfih
    rghnucghrghlkhhlihhnfdcuoehrhigrnhesthgvshhtthhorghsthdrtghomheqnecugg
    ftrfgrthhtvghrnhephedvveeigedujeeufeegffehhfffveduhfeijefgtdffteelgfet
    ueevieduieejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprhihrghnsehtvghsthhtohgrshhtrdgtohhm
X-ME-Proxy: <xmx:nKz2ZS6yJj7D0OPvxVDyRdwMNlXWu95aNEXprKpmDT3bvVqhst1G4A>
    <xmx:nKz2Zb2d2qXcJDKzV5Q46oIyxpWTwjh7IKadcJW9ucoKv2nsi3PGiQ>
    <xmx:nKz2ZdG7TJQg-KdS1hJADtwq7V9AqEK38p-Jy5k62K-Q1PHCfaSj3w>
    <xmx:nKz2ZU9a_PgJenGkJlrX7j5p6gwInfMDc_9s-td7MGqaau5IqE2W8g>
    <xmx:naz2ZdAastgVCkSx6zseZVw9CtgpdLtXZZqt3NCDuNds1Le_UVe0XQ>
Feedback-ID: idc0145fc:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 17CE8A60078; Sun, 17 Mar 2024 04:40:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-300-gdee1775a43-fm-20240315.001-gdee1775a
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9ef4c29f-de98-4192-bf5d-1b2802496761@app.fastmail.com>
In-Reply-To: <902ff7d3d6221f28df21c2e5b3e743671355c874.camel@realtek.com>
References: <f3656995-b8fe-49c4-93b7-67612c685954@app.fastmail.com>
 <2afd1590823740a2b6a8f7e485a33842@realtek.com>
 <d5889133-4b8b-49bc-a26f-204ee9fcfdbb@app.fastmail.com>
 <902ff7d3d6221f28df21c2e5b3e743671355c874.camel@realtek.com>
Date: Sun, 17 Mar 2024 21:40:39 +1300
From: "Ryan Walklin" <ryan@testtoast.com>
To: "Ping-Ke Shih" <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>
Subject: Re: [BUG] RTL8821CS panic on entering power-save mode
Content-Type: text/plain



On Sat, 16 Mar 2024, at 2:47 AM, Ping-Ke Shih wrote:
> This is because it is trying to enter PS mode but TX queue is still not empty.
> If power consumption is not big deal to you, try to turn off PS by
>     iw wlan0 set power_save off
>
> I think messages can be disappear. 

I would prefer to have power-saving on as it is a portable device but this does stop the remaining messages about the queue.

Finally I get extensive logging of 

[ 1137.214502] Bluetooth: hci0: Out-of-order packet arrived (0 != 1)
[ 1142.185255] Bluetooth: hci0: Out-of-order packet arrived (1 != 2)
[ 1142.319504] Bluetooth: hci0: Out-of-order packet arrived (2 != 3)
[ 1142.446742] Bluetooth: hci0: Out-of-order packet arrived (3 != 4)
[ 1142.574117] Bluetooth: hci0: Out-of-order packet arrived (4 != 5)
[ 1143.160501] Bluetooth: hci0: Out-of-order packet arrived (5 != 6)
[ 1143.287232] Bluetooth: hci0: Out-of-order packet arrived (6 != 7)

When I am running a bluetooth scan and/or connecting to a device, this seems harmless but does spam dmesg quite a bit.

Thanks,

Ryan

