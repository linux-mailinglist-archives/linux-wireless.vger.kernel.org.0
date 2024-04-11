Return-Path: <linux-wireless+bounces-6190-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C30D28A1CC8
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 19:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39C11C23A87
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 17:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7DE17A902;
	Thu, 11 Apr 2024 16:39:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns.iliad.fr (ns.iliad.fr [212.27.33.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF3C43AD9
	for <linux-wireless@vger.kernel.org>; Thu, 11 Apr 2024 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.33.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712853550; cv=none; b=fYaQE7/rmKcoRXz1tXr+GviG5iwI7Uj+Nz37EbfetWttv61Kva687Ud0GbrznZr3ypNT5hfyCVPfswGVxve4MhL3WCeQsSYv/Ebga0HMgO7zWRk9gSr+QSfNcv+SrPhAo0vXqk9hKN6Jbc1MNzvl9D489IV62Y7bbj6Vl09Icg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712853550; c=relaxed/simple;
	bh=OzeHSumXQNN5Wi6ka7rTLNPajb2VMuLdYr7ItN9DfwM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WSqxogBaQR1IWC6PCEY+WICfozYt1HD4b824tvXgWSqlgWmsTztyEkUUty+vBr8WMHCZ83G6g7iTSubTAFWWMTvhLz7k1D0t/xTWCV2fwFgcp+qY6vOEV5hmQuV3XX79wM+0ududojZFSO75odvfVoTzqquCzaIUitu6XbijFgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=srs.iliad.fr; arc=none smtp.client-ip=212.27.33.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=srs.iliad.fr
Received: from ns.iliad.fr (localhost [127.0.0.1])
	by ns.iliad.fr (Postfix) with ESMTP id 0F7C620338;
	Thu, 11 Apr 2024 18:39:04 +0200 (CEST)
Received: from [192.168.108.70] (freebox.vlq16.iliad.fr [213.36.7.13])
	by ns.iliad.fr (Postfix) with ESMTP id F31D82013F;
	Thu, 11 Apr 2024 18:39:03 +0200 (CEST)
Message-ID: <af70ee81e583f58dada3dde87ac335137c4038b0.camel@freebox.fr>
Subject: Re: [PATCH 01/13] wifi: cfg80211: Add provision to advertise
 multiple radio in one wiphy
From: Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>, Jeff Johnson
 <quic_jjohnson@quicinc.com>, Ben Greear <greearb@candelatech.com>, Johannes
 Berg <johannes@sipsolutions.net>, Karthikeyan Periyasamy
 <quic_periyasa@quicinc.com>,  ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Thu, 11 Apr 2024 18:39:03 +0200
In-Reply-To: <5fc2f2d2-7403-79d2-8909-ddda918ff8d5@quicinc.com>
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
	 <29f7ecb6d7c208c3614f37616943d5f97bb134d3.camel@freebox.fr>
	 <5fc2f2d2-7403-79d2-8909-ddda918ff8d5@quicinc.com>
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


On Thu, 2024-04-11 at 21:56 +0530, Vasanthakumar Thiagarajan wrote:

Hello,

Thanks for making it clear,


> > For example, starting a 5Ghz AP in ax-only mode, and at the same
> > time
> > creating a STA interface on 2.4GHz ?

> Yes, such use cases continue to be supported in single wiphy mode.

Understood, but I see some corner cases.


For example, assume two bands AP hardware, 2.4GHz and 5GHz.

Previously:
  - phy0 is 2.4Ghz
  - phy1 is 5Ghz
  - iw phy phy0 interface create wlan0 type managed
  - iw dev wlan0 scan

=3D> will only scan 2.4Ghz


With single phy approach:
  - phy0 is 2.4Ghz + 5Ghz concurrent
  - # iw phy phy0 interface create wlan0 type managed
  - # iw dev wlan0 scan

=3D> will scan both bands ?

  - <starting from previous state>
  - # iw phy phy0 interface create wlan1 type __ap
  - # hostapd -i wlan1 <config>
  - # iw dev wlan0 scan

=3D> what will happen then ?


Same goes for hostapd ACS, I assume specifying freqlist becomes
mandatory or we can't predict which band the AP will be on ?

--=20
Maxime




