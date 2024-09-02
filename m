Return-Path: <linux-wireless+bounces-12332-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF17B9682BC
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 11:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C2AD283EA8
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 09:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41454187330;
	Mon,  2 Sep 2024 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjNnSv7V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118BC187328
	for <linux-wireless@vger.kernel.org>; Mon,  2 Sep 2024 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268192; cv=none; b=T5eWJqiSBLS2ejgIsG35x+9swHLAOrV/zhYLShQzq6IbbzvL5KqcPhWTeZQjHsDYUp8wsObiJLGl2LJsY4+XoswSq3GXI4V6kKTRCIOObBoO/K0vX1uRpfcRtcdMfgp7M6bYNm8+yJIdPa9AZpygxZaHdyta5seWiqBRvlC63Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268192; c=relaxed/simple;
	bh=6lx7kL3Tx8Pg35jgHRUUy/rUc4Ba/uOGg0tbgEVT9yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjfEUTEzpXn8jul+5TJmalFihR8WTw75dL75EzSamQBAW/NHHurYrcgWu6xJVXV9TaIUbTMqMtzJXtR9V5FRKvt9iGFKeug5he4pOdSDvh1RBI1JVlSRRkQkE1W8VZrPiOHAN3sUE3yfSifme+Xwj+IA1XomnOGCOnDr/dCVt3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjNnSv7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54C7C4CEC8;
	Mon,  2 Sep 2024 09:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725268191;
	bh=6lx7kL3Tx8Pg35jgHRUUy/rUc4Ba/uOGg0tbgEVT9yM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rjNnSv7V83ZN/yfhP0ArBJ/jf1c9yUOuaRRDAW/5nx+bjWCYXcBQLu0au5aLYVZta
	 +3tToQRVfdBxTgAw7OrbWBJrLPMV31UFSG/YJQvbNpEGmrDgncJpiOLflr22z4L/0I
	 XtSTw96MfGv8DlOexhe5awlx0qlEl1hroNPd8MPNFL8ZpJ7b8qwhOKDJdgnXO0oQ7c
	 SClhNCeKs5hw05WQxICBoW1h5vAyOv6IZhkqbgfxg5WvfniPoCjhdjooQ27Oh/+6sP
	 vmBX/mwvitvdBc+RpOHAUWl5/qiCwZXCBty7SkSSJr2DdpOfssMXSyH9ExhnHevJPu
	 LuX/2TsApRO4w==
Date: Mon, 2 Sep 2024 10:09:48 +0100
From: Simon Horman <horms@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
Subject: Re: MAINTAINERS: Add net-cw1200.h to NETWORKING DRIVERS (WIRELESS)
 section
Message-ID: <20240902090948.GB77312@kernel.org>
References: <20240816-wifi-mnt-v1-1-3fb3bf5d44aa@kernel.org>
 <172431772309.2253380.3452086285097996947.kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172431772309.2253380.3452086285097996947.kvalo@kernel.org>

On Thu, Aug 22, 2024 at 09:08:44AM +0000, Kalle Valo wrote:
> Simon Horman <horms@kernel.org> wrote:
> 
> > This is part of an effort [1] to assign a section in MAINTAINERS to header
> > files that relate to Networking. In this case the files with "net" in
> > their name.
> > 
> > [1] https://lore.kernel.org/netdev/20240816-net-mnt-v1-0-ef946b47ced4@kernel.org/
> > 
> > It seems that net-cw1200.h is included by CW1200 Wireless drivers, and
> > thus that NETWORKING DRIVERS (WIRELESS) is the most relevant section for
> > this file.
> > 
> > Signed-off-by: Simon Horman <horms@kernel.org>
> 
> Why add it to the general wireless drivers entry? To me the cw1200 entry would be more logical:
> 
> CW1200 WLAN driver
> S:	Orphan
> F:	drivers/net/wireless/st/cw1200/
> 
> Please change the title to:
> 
> MAINTAINERS: wifi: cw1200: add net-cw1200.h

Thanks, will do.

