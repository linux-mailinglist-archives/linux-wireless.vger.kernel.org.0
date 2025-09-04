Return-Path: <linux-wireless+bounces-27007-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1237B43A54
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 13:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 681FC545D6C
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 11:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A762D3A6A;
	Thu,  4 Sep 2025 11:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RLhbYEg5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025942BE7B5;
	Thu,  4 Sep 2025 11:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756985845; cv=none; b=NG7gMYsMVGvohXppFtQwt5dkm1oseZ6rRZc9Ymj/Kmcz+BBK149lnZif0a8asXwiYnGq56vZzL+cmXTlOa1SfUUrMy3dXP0oqIHA6DrNGafaoPZjQ/ZG7Yeiupe0pdNeOqipHHGHabDcrdlnuGDuirWbh1KT7i1g6uckhLVuS3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756985845; c=relaxed/simple;
	bh=Q4jfgD20x2B7lfwTG+nsjBkx74xKusKlr1NJe4tcKs4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A7V9tjqVKcIqDEE7dILTJMytSyPRUhdJMx30T9Xy2prh3jlCIYalDgCq+YWZkxCgCDR3Ssi3PrePUdOCGL/Yq33L3xoT4CDIy873b1c0vs9JtSELfJeICAPD2+1DgezAChUvJC7h3eyr5mSRTJQwm1DRdUsK6Py5CISfEUeXosQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RLhbYEg5; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=brpPuPKsHj0xYX7qb+mIRu4ZZuWxnZaYaYuDlNzAyxY=;
	t=1756985844; x=1758195444; b=RLhbYEg5FtzaoVXzHxZgL514N1ehKGwiNU94fISciey/kmG
	jd0ZT3eMZQTIF8lBhHlhiWBMxX8yD7WyoGXkFyIWisve7B9L/MMlL15mlXRmhdRr0peQ7mdayoc17
	JAZJ3nyrw7jfSysZbu8OvAeC19uti4nTUsQcIhHBfPdBo0jdLWxBHhLDfuRu5CW0NIEqxkpojOpmo
	hpVshZw3z9dsS3nilOzM4td9C3BQlRwVhUqYFQB61PZkp7PvZeb+5/yrp+lB7FsH/7RZjiDBIaaN3
	3ayHwI63pw/Esb4vVuPdW9ugdtLn9Co94BiJZI9LJGEc04W1cuLzGc+Z2INS/2KA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uu8HJ-0000000E710-1tvs;
	Thu, 04 Sep 2025 13:37:21 +0200
Message-ID: <6b8ff5139bb9c361468840046b757dfa5ebe1aba.camel@sipsolutions.net>
Subject: Re: [PATCH v5 18/22] wifi: nxpwifi: add core files
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Chen <jeff.chen_1@nxp.com>, linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, briannorris@chromium.org, 
	francesco@dolcini.it, tsung-hsien.hsieh@nxp.com, s.hauer@pengutronix.de, 
	brian.hsu@nxp.com
Date: Thu, 04 Sep 2025 13:37:20 +0200
In-Reply-To: <20250804154018.3563834-19-jeff.chen_1@nxp.com>
References: <20250804154018.3563834-1-jeff.chen_1@nxp.com>
	 <20250804154018.3563834-19-jeff.chen_1@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-08-04 at 23:40 +0800, Jeff Chen wrote:
>=20
> +/* The main process.
> + *
> + * This function is the main procedure of the driver and handles various=
 driver
> + * operations. It runs in a loop and provides the core functionalities.
> + *
> + * The main responsibilities of this function are -
> + *      - Ensure concurrency control
> + *      - Handle pending interrupts and call interrupt handlers
> + *      - Wake up the card if required
> + *      - Handle command responses and call response handlers
> + *      - Handle events and call event handlers
> + *      - Execute pending commands
> + *      - Transmit pending data packets
> + */
> +void nxpwifi_main_process(struct nxpwifi_adapter *adapter)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&adapter->main_proc_lock, flags);
> +
> +	/* Check if already processing */
> +	if (adapter->nxpwifi_processing || adapter->main_locked) {
> +		adapter->more_task_flag =3D true;
> +		spin_unlock_irqrestore(&adapter->main_proc_lock, flags);
> +		return;
> +	}
> +
> +	adapter->nxpwifi_processing =3D true;
> +	spin_unlock_irqrestore(&adapter->main_proc_lock, flags);


This makes me very nervous, it at least means it's super hard to
understand when this may or may not be running ... It's also the sort of
custom locking that's kind of frowned upon.

Could this not be with wiphy mutex and be very clear? Though maybe you
wouldn't want TX to go through that ... and maybe it can't since sdio
calls it? But that seems odd, why is it both a worker and called for
every interrupt? Should it even be a single function for those two
cases?

Also it sets more_task_flag when it's entered while already running, but
that's just weird? Should other work coming in really get processed by
the SDIO interrupt processing?

It seems to me this is one of those awful design things inherited by
mwifiex that just happens to work? Can you document it well? If so maybe
do that and that can say why it really needs to be this way. If not, you
should probably change it completely and redesign it from first
principles, i.e. figure out what it has to do and build it accordingly?

The whole function is also everything and the kitchen sink, could use
some serious refactoring?

> +		if (adapter->delay_null_pkt && !adapter->cmd_sent &&
> +		    !adapter->curr_cmd && !is_command_pending(adapter) &&
> +		    (nxpwifi_wmm_lists_empty(adapter) &&
> +		     nxpwifi_bypass_txlist_empty(adapter) &&
> +		     skb_queue_empty(&adapter->tx_data_q))) {
> +			if (!nxpwifi_send_null_packet
> +			    (nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_STA),
> +			     NXPWIFI_TxPD_POWER_MGMT_NULL_PACKET |
> +			     NXPWIFI_TxPD_POWER_MGMT_LAST_PACKET)) {
> +				adapter->delay_null_pkt =3D false;
> +				adapter->ps_state =3D PS_STATE_SLEEP;
> +			}
> +			break;
> +		}
> +	} while (true);


Sao that ... those conditions are awful? If this were a separate
function at least you could write it in multiple lines with return
true/false there.

> +/* CFG802.11

(side note: there's really no such thing as "CFG802.11" FWIW, it was
always just called "cfg80211")

johannes

