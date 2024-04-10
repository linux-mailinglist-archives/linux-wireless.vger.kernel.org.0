Return-Path: <linux-wireless+bounces-6131-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4530E89FF73
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 20:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76AD41C22D2F
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 18:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D5917F36D;
	Wed, 10 Apr 2024 18:11:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns.iliad.fr (ns.iliad.fr [212.27.33.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E637217F391
	for <linux-wireless@vger.kernel.org>; Wed, 10 Apr 2024 18:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.33.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712772665; cv=none; b=iAVGPzyCAEuol8YgjjPYTXwEUaoU12VrekN0GSpcV28+6YkLLvcVbXD5RpeGuUmC9bpFxXF5ctdgYjM4a3ARNrh7Y0F1Kppa0Ad9+mOQGLw0QgtPySTm+X7+Uqs4Kh/3rjHTY3DxDc2jctD6y0WTfXon+WfD3KPcLS4YtWpxER8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712772665; c=relaxed/simple;
	bh=ZZyEb7uiN481wBR3oC8sUMfe+NR97MSLzHpHTssFaHA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hc9Z2srvGfPK9B4Tb4j9qDbk74x5Fp/a0pTzLRgWcaLUZOsnBXf5bNTy0bJN88pkfPFOCbYn9HR0BKtd41RX4J/ad8wJZVncOFFdOdH6meDjYpYLJg3IUF/1ok6aTQ4HRXAI3MeRx1qc6mBlcycx3vz1lpB2sMy/vr9p0opVZ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=srs.iliad.fr; arc=none smtp.client-ip=212.27.33.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=srs.iliad.fr
Received: from ns.iliad.fr (localhost [127.0.0.1])
	by ns.iliad.fr (Postfix) with ESMTP id 29D98201B7;
	Wed, 10 Apr 2024 20:01:05 +0200 (CEST)
Received: from [192.168.108.70] (freebox.vlq16.iliad.fr [213.36.7.13])
	by ns.iliad.fr (Postfix) with ESMTP id 1A29C2018E;
	Wed, 10 Apr 2024 20:01:05 +0200 (CEST)
Message-ID: <e5f0c5babb5b0b6c2dbe69b440f93b363a9055ae.camel@freebox.fr>
Subject: Re: [PATCH 01/13] wifi: cfg80211: Add provision to advertise
 multiple radio in one wiphy
From: Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To: Ben Greear <greearb@candelatech.com>, Johannes Berg
 <johannes@sipsolutions.net>, Vasanthakumar Thiagarajan
 <quic_vthiagar@quicinc.com>, Karthikeyan Periyasamy
 <quic_periyasa@quicinc.com>,  ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Wed, 10 Apr 2024 20:01:05 +0200
In-Reply-To: <aa9e1d54-bb5f-37cc-335f-c9970ab13789@candelatech.com>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
	 <20240328072916.1164195-2-quic_periyasa@quicinc.com>
	 <e36599d3269496de59505b36be46f873976f8706.camel@sipsolutions.net>
	 <033185b0-f878-a50b-d0d9-57fa79439bdf@quicinc.com>
	 <ef6b6a7a4a9d3b01c0eb6abf0991e7e27425e102.camel@sipsolutions.net>
	 <80fe5786-f764-455d-ac44-22adf7aeaf94@candelatech.com>
	 <31f30c0e318904f3a082c7f213576ceb1f407141.camel@sipsolutions.net>
	 <20b56e52-a5e2-70cd-a62a-8c4a3526c2cf@candelatech.com>
	 <614bb8a8f1d9174ad7d87cf7636f657cda7b1ef9.camel@sipsolutions.net>
	 <aa9e1d54-bb5f-37cc-335f-c9970ab13789@candelatech.com>
Organization: Freebox
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


On Wed, 2024-04-10 at 09:23 -0700, Ben Greear wrote:


Hello Ben,

> How will you allow all three bands/phys to host bssids that can talk
> to wifi-6 and earlier stations if there is only a single phy seen by
> hostapd?

Unless I'm mistaken (I did not try the patches), the single-phy becomes
multi-concurrent-AP capable (described via netlink iface combination).

So you can still create multiple devices (AP type wlanX) and have the
same behavior as previously.

If I'm wrong, then I agree with you, the proposed solution is a
regression.

--=20
Maxime




