Return-Path: <linux-wireless+bounces-11601-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3CB9564B1
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 09:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F311B2237D
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 07:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E2513D251;
	Mon, 19 Aug 2024 07:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="IG3l4RBU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536D0208A4
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 07:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724052595; cv=none; b=gNzqIS1VeMMqNfW7MgtB4HeAfsdKm5zx+BRkP2YhsgxXlvFK7wvA7J3K4Rxu4mNz0G0AsZbV3sYtUKUrluqDvIQs92BtS8YKmT6Dq9cIvB0CyJE8rUMQCQ/3IyjFiuW+4bZeVv7jJpwkdAFprEdzGdd+wnXtJjoqIrhsjiOiQJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724052595; c=relaxed/simple;
	bh=KvD/sFPhH9p4oHzbLuLRy2HL2yHFXVkefRE4CGGRImY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O1FwY1DZWDtPepa8fGSmsnLW8hR1vifa3AqgPokIwfFS+VZegqBCDYVdzq/NmbG7G9A+enlS99gSsFqApE/5JHdgmop7UsUYdRaf2v2PAng7PNzG7zZ+x0nARhksll/m8oJNk9GMRTdypOFf/kzLorFMmm7nbxuyAID+rIWaB3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=IG3l4RBU; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=FfRZB2MMPSgyQRjyjzJ8y4UvNG9AadZqZ4RiW69Gqm8=;
	t=1724052591; x=1725262191; b=IG3l4RBUXaebORujOoKBYl/yQppmh4oTB4YzvD78saiiA+C
	IgQVKAAiqGtOyrqsDnAEfbSMNqSWbseMRn08vAITnApwbYQ48oG13ZZpJY9gYTxOf6aIsmp8rGg9N
	wa/mvphxRUugghcbhZ5KFHWJxnw1YV6GpPTSHGxiJjbdpN/A9dYVENMifZlVsTpFUzt9d+JrgOAue
	lmEQUaFeOi0B71mVGTIJhNEv5fAPfRXC7xKq7SZ8N6wEnqvfyPkmbRT187R12yN8Pj3uiFTxRN6T0
	lQjs30Yu2y5S/6LtRxh90hC3ADxxCRJbuypk+VEHzrLIweeD5hqwrMEZEuFMhgPg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sfwph-00000007E1H-2ts4;
	Mon, 19 Aug 2024 09:29:41 +0200
Message-ID: <554fce82a0c10e0718b9066cbc1e37c67395741b.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] wifi: mac80211: export ieee80211_purge_tx_queue()
 for drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
Cc: pbrobinson@gmail.com
Date: Mon, 19 Aug 2024 09:29:40 +0200
In-Reply-To: <20240819065855.25678-1-pkshih@realtek.com>
References: <20240819065855.25678-1-pkshih@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-08-19 at 14:58 +0800, Ping-Ke Shih wrote:
> Drivers need to purge TX SKB when stopping. Use skb_queue_purge() can't

"Using"?

> report TX status to mac80211, causing ieee80211_free_ack_frame() warns
> "Have pending ack frames!".

Should say what you do - i.e. "Export ... to not have to reimplement it"
or so?

> +/**
> + * ieee80211_purge_tx_queue - purge TX skb queue
> + * @hw: the hardware
> + * @skbs: the skbs
> + *
> + * Free a set of transmit skbs. Use this function when device is going t=
o stop
> + * but some transmit skbs without TX status are still queued.
> + */
> +void ieee80211_purge_tx_queue(struct ieee80211_hw *hw,
> +			      struct sk_buff_head *skbs);

Unlike skb_queue_purge()/skb_queue_purge_reason(), this doesn't take the
lock, that seems important to note here?

> +++ b/net/mac80211/status.c
> @@ -1301,3 +1301,4 @@ void ieee80211_purge_tx_queue(struct ieee80211_hw *=
hw,
>  	while ((skb =3D __skb_dequeue(skbs)))
>  		ieee80211_free_txskb(hw, skb);
>  }
> +EXPORT_SYMBOL(ieee80211_purge_tx_queue);

see the context here.

johannes

