Return-Path: <linux-wireless+bounces-10963-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9819947CD9
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 16:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25FC9B2102D
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 14:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D27B51016;
	Mon,  5 Aug 2024 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="r5zXWhJe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D0C78297
	for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2024 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722868280; cv=none; b=hzYokDvNi1nfg5Emc/3q2UctTZb23ty5Y2fzrMZ5JjIL+kUy6MdxNM0Pt/iRU3Bb3P60USU635aakhnca1yWBWjbE21O3plH99d8jrwT6CtYni8abARN/Ec2lLKINKlsXWbU/xCnAIUsGX5Vdswj8HWlSc04eiPUChT5xYKj+qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722868280; c=relaxed/simple;
	bh=VT5yFT9c41Qe+Y+hoo6g0S8Acvs5LzzZDS14huOoPBE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SznZIQp2CiN+vZs3zyFF/m4Y40Pw+D8ueKXhRPyfb4ehPbBj41gyb7IbjhKGcy5pNkX6IVLf7wAxHAtlHXIW3m5YyD95m2lzcmKUvA1z1/AvGTyH7KRd2XEcnsZq93aYU4mKnhGEZFhrPvXe0volxMBdUa8XTE/hU0f/yGfHt3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=r5zXWhJe; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1722868276; bh=VT5yFT9c41Qe+Y+hoo6g0S8Acvs5LzzZDS14huOoPBE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=r5zXWhJetVO1Tq2vHRHHy1MpoA5koDIWy2Jy/haztyX8yBnHt0CH5TEf7DkZiXw9o
	 OD8CsL9N4IzWENE+xQmjG2VPU64mQAn93NBYAO2Q1LYM63G6YNX6Ey8Nd0zRA2RHCi
	 2QtT2ozP3tvbRGOYoSH0fCtJS7/NHeZPadenr8jwkAAFosdW6msTeKa8JW9Yy3VLHt
	 PK1GEHwqHVktf3ITCTUnHNbDeOaFz/0vceyDZBKk8hmAxUj4So/BIXRt11tLAVatIY
	 JSE1AFIRSMkVTcO3aJgRpFBLkDIcQIBN7HM59TOzmDWJ9eqjBz28EqUb4NgTMct1WG
	 9Z3uvXsQHObjg==
To: Chien Wong <m@xv97.com>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: ath9k_htc: limit MTU
In-Reply-To: <fc8659fb-7e86-4d29-8966-1f17383b0efe@xv97.com>
References: <20240405145211.15185-1-m@xv97.com> <8734nrp4uy.fsf@toke.dk>
 <fc8659fb-7e86-4d29-8966-1f17383b0efe@xv97.com>
Date: Mon, 05 Aug 2024 16:31:15 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ttfzdoss.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chien Wong <m@xv97.com> writes:

>>> Shouldn't this be the same as the extra_tx_headroom set above? Not sure
>>> what the +4 is for in that assignment, but it seems a bit odd to not be
>>> consistent. Did you verify that an MTU of 1580 works without crashing?
>>> 
>>> Maybe this should just be:
>>> 
>>> 	hw->max_mtu = MAX_USB_WLAN_TX_PIPE_MSG_SIZE - hw->extra_tx_headroom;
>>> 
>>> just to be sure?
>
> The +4 is for the header at the very beginning of the USB packet:
>  >/* hif_usb_send_mgmt() in hif_usb.c */
>  >	hdr = skb_push(skb, 4);
>  >	*hdr++ = cpu_to_le16(skb->len - 4);
>  >	*hdr++ = cpu_to_le16(ATH_USB_TX_STREAM_MODE_TAG);
>
> I suppose that the four bytes are consumed by the USB hardware and they 
> do not occupy buffer in the firmware. And my experiment proved this.
> Unfortunately, setting MTU=1580 alone could not prevent the firmware 
> from crashing. The MTU only limits upper layer length, not taking MAC 
> overhead into account. That's why we need to take other measures such as
> dropping packets before sending via USB, as proposed by my earlier
> patch.

Well, we can also just take the upper layer overhead into account in the
MTU limit? Presumably there's a maximum MTU size that you can use
without the firmware crashing? So just set the MTU limit to that :)

-Toke

