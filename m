Return-Path: <linux-wireless+bounces-29159-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 195AAC73387
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 10:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A3F64ED543
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 09:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A52307ACE;
	Thu, 20 Nov 2025 09:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jtpnrJQr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BA82116E0;
	Thu, 20 Nov 2025 09:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763631051; cv=none; b=T2G2zWhB+gODubcdCfWYW5imgbp4AMNbqdqB63idPxSwpbSXyH9BF+IUdWfK0gd3sG5IhCh8OX4j+VJM558jZXhQdvN2w+XTqBpCZ74QR9h7fSZ2ypORBJiYejoDwu+M7zeeHADp5NTKvgGLIgOtzhmnv7jEfMtmxPKPIG4fd4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763631051; c=relaxed/simple;
	bh=VZCryycMuuub8gwndXgz+NkhPDu+4Me43OruLIXPCYw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mFnWyDnix0KuKwmwnnMuRdOgwOmWqteEiisdUvG6lkw9EparOj7903VDiR0kSpIBorfAffe9ecrUb7piop8wXo6MRNr9IsSQpSka/9ANQJSBfPE0eKz9gprQYFwT67xdBvDbI2HMEBFeR/TPTNmEseirWp/gkapsbS558pjRn/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jtpnrJQr; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SfNn2B6rncibV5kJ6sYUacOKlwMjZLOOtEbVuhSqGzI=;
	t=1763631050; x=1764840650; b=jtpnrJQriuGfOxyLyKQD+0DI2kOI7jyX7XWMj/C2AXVnvwS
	Bex5/bjdyAq0AVYP3I4f3V16jxlmWOG6QLUU2tK0hRtcbeyC4ofs6bcsPWNs7aePk/48zkgxjLZlF
	Y0oX/YwC1TTdjg50SUlDFLEP8UREk0b4Wt/fQJC5cjd3Ig2HEfRi+DtB52J9Q9UbqbH7n9cpGx70d
	I4P+AR2f7KT8ei02JyR30i0fewuEZQfSMIlFFBDPKIndavVP3hRxL4XWyWonz29ErHGM7dwQnthOm
	g366Ghs1QX3CZ0+SOX4dqU0zyevGevHbB/0kZEW0f4xo0KtRzA4MTMXip9adc8jw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vM103-00000004XYn-2taL;
	Thu, 20 Nov 2025 10:30:47 +0100
Message-ID: <1ac162bbcb11abdbb0b3c74df3bb1df02a5068ab.camel@sipsolutions.net>
Subject: Re: [PATCH][next] iwlegacy: Avoid multiple
 -Wflex-array-member-not-at-end warnings
From: Johannes Berg <johannes@sipsolutions.net>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Stanislaw Gruszka
	 <stf_xl@wp.pl>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Date: Thu, 20 Nov 2025 10:30:46 +0100
In-Reply-To: <aR2CtqZI3atH0HmE@kspp>
References: <aR2CtqZI3atH0HmE@kspp>
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

On Wed, 2025-11-19 at 17:41 +0900, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.

Look, I honor your noble goals, but ... it'd be useful if the code
actually worked after :)


> --- a/drivers/net/wireless/intel/iwlegacy/commands.h
> +++ b/drivers/net/wireless/intel/iwlegacy/commands.h
> @@ -2664,10 +2664,12 @@ struct il3945_beacon_notif {
>  } __packed;
> =20
>  struct il4965_beacon_notif {
> -	struct il4965_tx_resp beacon_notify_hdr;
>  	__le32 low_tsf;
>  	__le32 high_tsf;
>  	__le32 ibss_mgr_status;
> +
> +	/* Must be last as it ends in a flexible-array member. */
> +	struct il4965_tx_resp beacon_notify_hdr;
>  } __packed;

You can't just randomly rearrange firmware API. The __packed and __le32
really ought to have given you a hint here.

johannes

