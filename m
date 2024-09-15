Return-Path: <linux-wireless+bounces-12874-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B45E979968
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 00:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 359FF283820
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Sep 2024 22:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637D482D91;
	Sun, 15 Sep 2024 22:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QMeeIeMz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAEE135A79
	for <linux-wireless@vger.kernel.org>; Sun, 15 Sep 2024 22:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726440310; cv=none; b=MvemeK2YYj2jx9JRwWtY9/If3DC1DEYrCo47brN09eJzwnd+Eom8/heTCY0K5YLblPj/XItVLZ24e6k1u02izSP8gdaQBvizw8KBSqn6c3MnegnV7bfcJ+zUA+1uL8Mo5JiRb2Gb+qcgVS9lGZ5tCHtPCUMh/KselvtbF8hebOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726440310; c=relaxed/simple;
	bh=sRHSmC4I4lxe/Csx9+kfEzFHuEfbKT0NRn/AM4yYXR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCOcH4UabxV3mgurFKZtSU0G7N5MbMFlLBcKTw+jQinTUpYEdQWfnmfSYRDzZUaQhh4YSJ0fuYeNPqhBNlOpbEqVrooxPqQevBGEpB7LG1DpTqODpiIlzvGTtjIWhEHKRzGoybKV0aU++hN+3H5jvUtxDILTh3umiOrtON9qq6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QMeeIeMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D166C4CEC3;
	Sun, 15 Sep 2024 22:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726440309;
	bh=sRHSmC4I4lxe/Csx9+kfEzFHuEfbKT0NRn/AM4yYXR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QMeeIeMzuoHqt8DHc0oniNF3wZpMPOf8oDmLm82J0LTLitjO2I2ar6qksfwO6+uwG
	 TJGyK4ftv79W7iRVINEoiMJgTCE2/RJy6AjDtcg7fb5l8oKw+mvxoBesMBeelDkZal
	 AKd99bYMMDfiBfviviIk0KBDvcedhcu0s+gNcq+Y=
Date: Mon, 16 Sep 2024 00:45:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sherlock Fang <wf27@st-andrews.ac.uk>
Cc: "security@kernel.org" <security@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: {Disarmed} Two potential 1-byte BOF in cfg80211.c of driver
 MWIFIEX
Message-ID: <2024091654-flagship-untried-1c23@gregkh>
References: <AM6PR06MB55447E199A092E593B82986AA0672@AM6PR06MB5544.eurprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM6PR06MB55447E199A092E593B82986AA0672@AM6PR06MB5544.eurprd06.prod.outlook.com>

On Sun, Sep 15, 2024 at 06:12:21PM +0000, Sherlock Fang wrote:
> Dear Security Team,
> 
> 
> I have used static code analysis tools to scan the Linux Kernel of the latest build, and with collaborative help from Prof. Yueqi Chen, we have been able to manually confirm the presence of two 1-byte BOF in drivers/net/wireless/marvell/mwifiex/cfg80211.c
> 
> At both line https://github.com/torvalds/linux/blob/master/drivers/net/wireless/marvell/mwifiex/cfg80211.c#L2679 and https://github.com/torvalds/linux/blob/master/drivers/net/wireless/marvell/mwifiex/cfg80211.c#L2777, the calls to
> 
> memcpy(&priv->vs_ie[i].ie, ie, sizeof(*ie) + ie->len);
> 
> are theoretically possible to cause a buffer overflow since the destination buffer is an array of bytes with a size defined by MWIFIEX_MAX_VSIE_LEN<https://github.com/torvalds/linux/blob/master/drivers/net/wireless/marvell/mwifiex/ioctl.h#L416> of 256 bytes, which is the maximum amount of data that can safely be stored in priv->vs_ie[i].ie<https://github.com/torvalds/linux/blob/master/drivers/net/wireless/marvell/mwifiex/main.h#L483>. The size parameter "sizeof(*ie) + ie->len" theoretically has the maximum value of "2 + 255 = 257" given that len is of type u8 which has upper limit of 255, and sizeof(*ie) is equivalent to sizeof(struct ieee_types_header<https://github.com/torvalds/linux/blob/master/drivers/net/wireless/marvell/mwifiex/main.h#L343>), that is just the size of two u8 field (two bytes).
> 
> Our suggested fix would be to add a check before calling memcpy:
> 
> If (sizeof(*ie) + ie->len > sizeof(&priv->vs_ie[i].ie)) {
>       continue;
> }
> 
> memcpy(&priv->vs_ie[i].ie, ie, sizeof(*ie) + ie->len);

Great, can you submit a real patch for this so that it can be reviewed
and accepted if ok?

Also, you are sure that the data being copied could really be that big,
right?  Where does it come from?

thanks,

greg k-h

