Return-Path: <linux-wireless+bounces-7817-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A168C8FA1
	for <lists+linux-wireless@lfdr.de>; Sat, 18 May 2024 06:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42A62830C8
	for <lists+linux-wireless@lfdr.de>; Sat, 18 May 2024 04:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D42BE65;
	Sat, 18 May 2024 04:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b="VHHaOvfH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468EC2F43
	for <linux-wireless@vger.kernel.org>; Sat, 18 May 2024 04:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716007502; cv=none; b=OrUv9BXS6aLIBIj0e5uCS+WBYNz6C5WikBZSC0RupQMptrOOhNRkXG6Vh+zcI0vAc+V8BQbDeI1RbZFrYNde/YZNkDwsnsPXAu2DAovap6uKglKj2jPPETwGpGs0SarYooBBlBAmwHj/WSDCLOiTdjvOSUoHDyeVlTmY18qRQfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716007502; c=relaxed/simple;
	bh=GI3RrWaBWkV4cNTeIYZvQWAM7eMhiWJbQne6k2e4F9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K0+ReMdBBK/RQ7/KLGsImh+VY5fAFHLB7chbg3NWkjx0TzA0i6N1ZgHa1gXyIFZb6YPTLNbNlqeZAgytgOCe40tn4XTrk4m73WaPSoSBqyBVWJTrED4b1hXxfbgUA687OQPEnrtvdmOby3otOMSNACop5ZYGtYmh3VTggP88AMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b=VHHaOvfH; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716007481; x=1716612281; i=s.l-h@gmx.de;
	bh=v+e4K64yTFGSTRn+I9ej8kfY2RPSsYoCvmxaQP4k0NI=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VHHaOvfHvjWqV1C6DMSQkM9rNub3wUobibEXgUkfPDOsjuQdqJzH/m1RVFX/aDIx
	 PQEiDG2BCr7Hh1BmBpc3h3GRwiQ4LE6mxKGta9Ih6NdKgDCK3WkwpwRHG86151Kua
	 efStoqBdAhklMJU9alOUhgIewTqaaXF3kmPjvFPpdpRDGiKKc0SIc/Luzdl2eQhXb
	 d2BGIOcl0km8Po1RdosCi2TCfY8P7rNjfX/wTfbR6OqaM7MXiWeevJX14v7Tn/eKU
	 I3Tec1nYT68AGJPBtU4FQ9rP6sZPfgsNIhIKb09bT7C6UOCfF7Rt1K7vhxX/2bdq8
	 SzbROe/sg7Run8w+mQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mir ([94.31.83.155]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpUUw-1staUf37JU-00meHW; Sat, 18
 May 2024 06:44:41 +0200
Date: Sat, 18 May 2024 06:44:38 +0200
From: Stefan Lippers-Hollmann <s.l-h@gmx.de>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>, Larry Finger
 <Larry.Finger@lwfinger.net>, Christian Hewitt <chewitt@libreelec.tv>
Subject: Re: [PATCH v6 00/11] wifi: rtlwifi: Add new rtl8192du driver
Message-ID: <20240518064438.0edf5c07@mir>
In-Reply-To: <0c22c048-c372-4596-b2c6-612c6ec7ab77@gmail.com>
References: <0c22c048-c372-4596-b2c6-612c6ec7ab77@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6DFylh2edYu36yyfAehZAJbEWiXjRstGLcUqmXV6t/iD4IfYsur
 loxr17JL4IB82g6IeHk329l0AXOiHt9+NjkpO5BcGDLSJtLk7iE51Fm6jcZj2dd0z6p7660
 VgvzpWDHJkNZ7T3Ba8uzJhUqkDWHSWUXl/eLBCf1FM2nBnTYzGrEad/MS0Xv06lVgmhaGzs
 uPcC0HdZNtrsapqXFzKhw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zm40TPmBCb0=;3zJVaSq78srBMktg3WItDz/TaNO
 J2kMdgaitdlvhiOVUL+Sn5NSq0JFqPJgl6xxr/H66PktiMUZt0G+9k6IaI5aB3MXgknwWHCFx
 ICWEBGpGZjfWnDVjX150WbJnVu2OzRzIamOY4e43Mbb9sXOf9S7k9cRV76SefEKXbPJL0Bk4p
 HT0UHIkTWpuk+1nJKQ37O8MT6+69WaxlinVTe7X+bofRl7dwZtH/3N2jGv7Wp9tAwxVw4ySW7
 8+wy3uPNsZDM1DYAkWGcIwwD/qUJ54FZJv+6XUCK4C+xu/ZIhB+1VJzBQuhJmxOMIKDjAGNIL
 mNQsYvh5UUKckwu07+gZkOPkaFbWgZnAop0vH9wyAdTClnlCCygplmkpjMBWHsLkJc+xOg61u
 vgE/E/NdTSJdrxZVPNkv65QKinb4J3hoQ4ORz7/tR9kpCZH0ufjfy1pDqKghFs0WTT2MKRRIV
 XFIqp4Zu4Q++r1I3fyix0+H94Vh6IAX3sGKyVU/tRXf6foO8tKOJ+1IKvoOtmBkqIkb+eW8j3
 uKqR9/52ZOpnAsba6UvgFqF+WGciTgELGddKXTwdzla0GSdLRfcLRM6YyEjT+c1MIrewHZeX2
 FOHsnQL9fX1wEQqKaDz7gwm4gSN2z9SedRO9RoFGN7PRtJWFz45BUbYv4GN/6XDNp17J54egk
 k3gXqzsFTdI8jr67mkzm+tVOHDwCW5O+UpJHDlAmxeESCROhFYqkSv0i9UIl1alJfSKUP7A17
 i88IwlxLslljN9zRAbhq7juENKGvA6785r+PmH6EjA5cvVbjU5h+tUdJELHJxm8rc2pHPr6ZJ
 NrWEnWs4BwDFky9MAsM5LyZQQ9Ym5TivRro/q++2ybG1k=

Hi

On 2024-05-18, Bitterblue Smith wrote:
> These patches add a driver for the RTL8192DU chip.
>
> Power saving is disabled by default because it's not working.
>
> Dual MAC chips are not tested.

Just a quick functionality check with v6 (based on top of v7 of the
common code preparatory patch series), all fine at ~162 MBit/s
thoughput (5 GHz/ ch52, WPA3SAE, QCN5054 AP, ~3m distance). Steady
performance, working really well on my Delock 88540 (0bda:8194,
single-mac).

Tested-by: Stefan Lippers-Hollmann <s.l-h@gmx.de>

Regards
	Stefan Lippers-Hollmann

