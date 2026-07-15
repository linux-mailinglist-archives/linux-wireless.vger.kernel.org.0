Return-Path: <linux-wireless+bounces-39149-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id idBcE2SRV2rXXAAAu9opvQ
	(envelope-from <linux-wireless+bounces-39149-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 15:55:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 982CD75F09B
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 15:55:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=dolcini.it header.s=default header.b=Leflqfnq;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39149-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39149-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=dolcini.it;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E2713040D99
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 13:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F93C311969;
	Wed, 15 Jul 2026 13:50:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7253043DB;
	Wed, 15 Jul 2026 13:50:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123440; cv=none; b=q8jAUq3D71i1PO76d3pXH6CsAobv4p8N4kDgCoaphs5CWWq3Druh6Rtf4nL80hMlwPMU+T4mC/E9I3gg6cJzbSalPe1dDeEf53RpmbgGAaXwqeSuNLYYVyNGeYYoPdWC9I9AZAgKniVqnAS7emEQ2ZVT8DBjdff6Z2QrJM8YFOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123440; c=relaxed/simple;
	bh=xEnolgkcI7GVuLtF+soLLOtWr5kgoZLsi3OR+0Nfpo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzOUl/Pny4lxMpc1+F0BkfnC62aEwypXH3GAGu07uIAfUzTIMRQPN6r1DOrGiiZi3SfPQP907LDksFMgTmZTXFDJQEyh9C31QsIHT4GdWqLg/tZda+jre1G+C6EgZQrwnrIelaP5q39Kc1bFFOKhf6jQAV12HVKZYdaXeE6knuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Leflqfnq; arc=none smtp.client-ip=217.194.8.81
Received: from francesco-nb (xcpe-178-82-120-96.dyn.res.sunrise.net [178.82.120.96])
	by mail11.truemail.it (Postfix) with ESMTPA id 939311FD06;
	Wed, 15 Jul 2026 15:50:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1784123435;
	bh=eJts9OLzXtWK5m7FwmI9CP9B932j+MqHKpkB6sBud8Y=; h=From:To:Subject;
	b=Leflqfnqh7FCy8AyqATa6tBXaESHle+wvZrzK+VitDs7eFwwkJPL9G3HY1rGMdbxC
	 xs4WXsv328hC1wZL4PlMABBK6oLqmTjZOwjEkei5fbEMNyaexSSJP9ZZv9WqBpfrVS
	 ncwnpWV3pWHeIyh0KdtMccocva/85lY6n8wv+zZ2QIb6EdMPqvOPRTJno8cFtpVMNZ
	 n/qrXSOQ3Hc+PsR0+WYr++q13BHXt/ofxonezKlWzxqTH7OTzB46egF1BkZerG/fuH
	 lj7XSvbfzbbCVPZseKNObOr7cEPwBXgPyVD2kWfq9JZFYH+Dp/u591BYpe/ijo1chc
	 Go2kVqr5ZF6Bg==
Date: Wed, 15 Jul 2026 15:50:34 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: copy only event bodies after headers
Message-ID: <20260715135034.GB56330@francesco-nb>
References: <20260704011317.50900-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704011317.50900-1-pengpeng@iscas.ac.cn>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[dolcini.it,none];
	R_DKIM_ALLOW(-0.20)[dolcini.it:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pengpeng@iscas.ac.cn,m:briannorris@chromium.org,m:francesco@dolcini.it,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[francesco@dolcini.it,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-39149-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[francesco@dolcini.it,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[dolcini.it:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iscas.ac.cn:email,dolcini.it:dkim,dolcini.it:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 982CD75F09B
X-Rspamd-Action: no action

On Sat, Jul 04, 2026 at 09:13:17AM +0800, Pengpeng Hou wrote:
> mwifiex event packets carry a four-byte event cause followed by the
> event body.  The USB and SDIO receive paths read the event cause and
> then copy adapter->event_body from skb->data + MWIFIEX_EVENT_HEADER_LEN,
> but pass the full skb->len as the copy length.  That makes the source
> range extend past the skb by the size of the event header.
> 
> Require the event header before reading the event cause, and copy only
> the bytes after the header into adapter->event_body.  Keep the existing
> per-path total event-size checks so this stays a narrow bounds fix.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/net/wireless/marvell/mwifiex/sdio.c | 10 ++++++++--
>  drivers/net/wireless/marvell/mwifiex/usb.c  |  5 +++--
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> --- a/drivers/net/wireless/marvell/mwifiex/sdio.c
> +++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
> @@ -1712,12 +1712,18 @@
>  	case MWIFIEX_TYPE_EVENT:
>  		mwifiex_dbg(adapter, EVENT,
>  			    "info: --- Rx: Event ---\n");
> +		if (skb->len < MWIFIEX_EVENT_HEADER_LEN) {
> +			mwifiex_dbg(adapter, ERROR,
> +				    "event packet too short: %u\n", skb->len);
> +			dev_kfree_skb_any(skb);
> +			return -1;
> +		}
>  		adapter->event_cause = get_unaligned_le32(skb->data);
>  
> -		if ((skb->len > 0) && (skb->len  < MAX_EVENT_SIZE))
> +		if (skb->len < MAX_EVENT_SIZE)

if (skb->len >= MWIFIEX_EVENT_HEADER_LEN && ... , instead ?


if we want to free the skb and return -1, we should probably not just do
it when skb->len < MWIFIEX_EVENT_HEADER_LEN, but also when the frame is
too big?

Francesco


