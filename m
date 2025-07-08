Return-Path: <linux-wireless+bounces-24894-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BC4AFBFCC
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 03:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03C8C3B448C
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 01:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2507F1DB54C;
	Tue,  8 Jul 2025 01:19:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E622C7464;
	Tue,  8 Jul 2025 01:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937572; cv=none; b=JEVU0d18ISuvR19pRb/1tamjeKMoo+d16hA7J+AWsFD3w4EMhy7qGSe5BTYcBNPh+AhMWQkD9H/2pJX1Mf9e/6WmFKUWhIMHhLLBUZkkUdIdqrChD5gDCf0c4aDd9qYJGKAT1PFTxepcmhPcrQyPkmZ1doeo/VYmcDIi9diBgUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937572; c=relaxed/simple;
	bh=oBIIPlnYrfnbzhQJIN4o0z5areYZlkrUgzPse2JkzhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpZ6TwcBGMcqUFdQzgJdJpWoX6aA3RKYLytb/Wq/kbaTtMhntpyeXTTSJsak8bCS/XQrr1+fiB3wh+O1VMa6QIwPL6rLNYjJ+o9nfYamcJpSju22CaX2Ssc3tw/1wLfBOQqrI/BA5LdtRgsbEooDK9/phSEW/uwxxbJywgC7VDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uYwzK-000000007oP-40A6;
	Tue, 08 Jul 2025 01:19:15 +0000
Date: Tue, 8 Jul 2025 02:19:11 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>, yangshiji66@qq.com,
	ansuelsmth@gmail.com, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:MIPS" <linux-mips@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 6/6] MIPS: dts: ralink: mt7628a: add wifi binding
Message-ID: <aGxyD3mtzdNZPPnx@makrotopia.org>
References: <20250706214111.45687-1-rosenp@gmail.com>
 <20250706214111.45687-7-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250706214111.45687-7-rosenp@gmail.com>

On Sun, Jul 06, 2025 at 02:41:11PM -0700, Rosen Penev wrote:
> MT7620A devices all contain a wifi device as part of the SOC. Add it
> here to get it working.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  arch/mips/boot/dts/ralink/mt7620a.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)

The commit title

MIPS: dts: ralink: mt7628a: add wifi binding 

seems wrong as the commit (correctly) touches mt7620a.dtsi and not
mt7628a.dtsi (which would be wrong as the WiFi part of MT7628A is
already supported by the mt76 driver and part of the device tree).
Also the word 'binding' seems wrong in this context, you are adding
a node to the device tree, not to the device tree bindings.

I'd hence suggest to change the commit title to

MIPS: dts: ralink: mt7620a: add wifi

