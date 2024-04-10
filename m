Return-Path: <linux-wireless+bounces-6130-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A0589FF6D
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 20:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35E4CB27933
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 18:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832E417F396;
	Wed, 10 Apr 2024 18:08:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns.iliad.fr (ns.iliad.fr [212.27.33.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BC0178CE7
	for <linux-wireless@vger.kernel.org>; Wed, 10 Apr 2024 18:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.33.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712772533; cv=none; b=jwfNNjBpaJ5BECq7iNwSqgoBmczs2WPvSlWF0VIZpBz7YWPMawq8uZfg0ey7LBA1wHvOcykT97L3EcisdeG0Tgvymm/L3Sfv78hU0yzRCt3BSV8DZ2u9KGgCrzvB7kR1PKltG4RGXDj2oXi6zD9h0IacvSNNC01Ayp56WJqxWj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712772533; c=relaxed/simple;
	bh=cBk+DfF+9TrNkFoJgldIrwk6rXgdE9PyQYleu39XY7o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZdhJYRtOMvUkRDzoIuEaQ58U1n+h+Y7k6y7b6eAG3uK6HPY6ma95ZOsCWbnJqWMiNJ8wRR8NqeIOJLYi5ir4vEMCq1aIpsn/jGBuSCvSo6TBX1omPwe32pNZl8GLlFZDZW3DbakSbjOJbfquKH0CadT3rNVl6TIDhBQ8qfnEaxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=srs.iliad.fr; arc=none smtp.client-ip=212.27.33.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=srs.iliad.fr
Received: from ns.iliad.fr (localhost [127.0.0.1])
	by ns.iliad.fr (Postfix) with ESMTP id A0F09203EE;
	Wed, 10 Apr 2024 20:08:46 +0200 (CEST)
Received: from [192.168.108.70] (freebox.vlq16.iliad.fr [213.36.7.13])
	by ns.iliad.fr (Postfix) with ESMTP id 908422018E;
	Wed, 10 Apr 2024 20:08:46 +0200 (CEST)
Message-ID: <29f7ecb6d7c208c3614f37616943d5f97bb134d3.camel@freebox.fr>
Subject: Re: [PATCH 01/13] wifi: cfg80211: Add provision to advertise
 multiple radio in one wiphy
From: Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Ben Greear
 <greearb@candelatech.com>, Johannes Berg <johannes@sipsolutions.net>, 
 Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>, Karthikeyan
 Periyasamy <quic_periyasa@quicinc.com>,  ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Wed, 10 Apr 2024 20:08:46 +0200
In-Reply-To: <0cfe990b-182b-4ceb-b5b4-2989fefedb2f@quicinc.com>
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
	 <0cfe990b-182b-4ceb-b5b4-2989fefedb2f@quicinc.com>
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


On Wed, 2024-04-10 at 09:43 -0700, Jeff Johnson wrote:


Hello Jeff,

> Ben, the patches we have posted so far allow ath12k to either have
> each phy assigned to a separate wiphy (legacy operation) or have
> multiple phys assigned to a single wiphy (required for MLO
> operation). In an upcoming patch we'll introduce a DT-driven

When the physical wiphy are grouped in a logical single wiphy, can we
still do "legacy" operations on the individual physical wiphy ?=C2=A0

For example, starting a 5Ghz AP in ax-only mode, and at the same time
creating a STA interface on 2.4GHz ?

If not that's a regression. Changing DT (imply reboot) does not really
fix the issue.
=20
--=20
Maxime




