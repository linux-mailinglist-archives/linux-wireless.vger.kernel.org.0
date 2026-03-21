Return-Path: <linux-wireless+bounces-33653-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFgeJsoQv2kRsgMAu9opvQ
	(envelope-from <linux-wireless+bounces-33653-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 22:42:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B722E7573
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 22:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CCD83014BCA
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 21:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44616274670;
	Sat, 21 Mar 2026 21:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/Kl6bCR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF041225417
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 21:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774129351; cv=none; b=my0rliN+1YL7k2jmB4UkWn+GvCvhSl0qJNqrYvRa4p9AU35Hbyt4OACQOrHiPF0iMuZGvyCBkdsB7O7/gsK4r8PL/NtB/446EGkEc9g8Jmsgp7bZTd1wS0LE/2wouqvU+h8aHJ3Bqj4/XGewc83eu2MImFtY0WOeYEGUQo9ziYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774129351; c=relaxed/simple;
	bh=t8XlJRXf5fPDta/1bIP/yZ2gwXXouY5Ub6uorQSULao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e2aC/WRFqdp5ChyDgpM0/fr52HTPxhHNr8pj6VuMr36rr4k3xKVP2QAZpdV+8+dXBWDVCe3LLb/sw5w6zRH5FaIj+E+NrUHM5ZRNMOSED0TlfBUNYYW4Npv0+9/WKIP4U/MuiyrVicnaWT7IFiOs258LMMsb2Y2ECfdYMMuLNxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/Kl6bCR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso24269165e9.3
        for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 14:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774129348; x=1774734148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MpZ3JTZ0lExcVZ0jEZsvQBID3uzvau7Jfv1+ZKESRzQ=;
        b=L/Kl6bCReRamvI/AZAcP6ACsULurftKYAFMZYX632cnPB5fzX5KzXNudJrPRq13YrE
         I2L967q3ADTMk2CcS1CJIy8Dbw2LC5MQrBeGaLtDuIBJ3tgh8xbK9sadxkbQFwodRSzY
         4DZdIcRNeC9f0l2DQ6hWCkrSsUVgy3jwbV2/udsgM9aPHwc6F2ai36rGPrHVFjs/aWyn
         +7KzdHsJg5fw7F+CAiUlAH/QghyBMpPXiKSPugDG6ATPKHVCHIlvI/ueb8M5/Zwde5Uz
         YOLqd0OVmsvBfivFdDHDIaRADIZxomXK5a2hbTmlBQfAcQypAp9F4Zc4xqvTx1AIrLjJ
         x+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774129348; x=1774734148;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MpZ3JTZ0lExcVZ0jEZsvQBID3uzvau7Jfv1+ZKESRzQ=;
        b=itzhWdwcCBilKGC4jmeAAnXMj3zLFQ+/1QdEt2WY3MD19d/W9K46heOOxKgMWHgMhe
         ZznTq2L7MDSyD27Ld69e44kNwMOfCYPH+r3E+4EAHxw13AR5ndww9U1yG+6fMVQkE4oD
         hqyH1Sd6s3Lum+cpSdBl7Xxmcd+AAMS+GB6lWjFuJjK6jID9nFcglIIW/NMv//0szKEV
         r97oAw64DXgZPWpb5pWRsimbt9tD5eYe9ej/rgRr6lUgigAIFXspRDouQO88zKCPhwSS
         q50WPL298y6DBRqa98qr+9GSNxjIX8Ah2YZQU1i8w58lhrq4n8S3L1cEX9W/gjqktJYk
         rG4Q==
X-Gm-Message-State: AOJu0YzDpK+1pRWteJQ78SvPPC93cFo0ldVUisQVmJk8gBwrk/LKEgf/
	mI1e+O4DErLq+LYldZPyeVSnK+8vMSYzzrKzoMUIFLqE5oQJrHfcTSos
X-Gm-Gg: ATEYQzyX3/CLQpe3iNVvwDf9TXFh7jXpsg1hUpBvO15OgIqUUpA6TjrJAcpS4OwKqFp
	jUkvkmhGjagJsZ2Pd/2X/o5AxKhclhz0vPJ/kxvmJh78MpWTzZZ0oDgcUfVjZzMuqsvkafgU80Y
	NPEt9kP+tx/UmJk44vheSds1jzhqyTIKacyBQUpai+SP886/kPsTCY56XQbdDHHURz0PA7p6gxG
	9vxOd1cBPPIjXMs9H3X1UOe/MXLyNpsGnnCZbmcSCtag7jSo3WkMh4IVY2A1oPHaZQzHNOGVTcu
	Uzzccz1XWf1t6yKWD/Bb6ipCHz0V7IqUh/fDSU48M0joY5HvF1ABmK2ZciHbOFCXHlTPtJkcsay
	K8BoVvE92H1dD0ujj4g4hJVh7bIfOoo1ADewZkPKSglmynHLCBZF9hIiml4yQm4OBUYzZAWZ26/
	JN7szEsxWmwiNVPL5EzCdlKcaWkUx8uxju7Rn1TXqsRNaQ+eDVTqZji7/dCY8UytFW7OtA0d1cN
	qwpzIGVbn/k0MtEM/wtZQ9wRsoYLiTi
X-Received: by 2002:a05:600c:3514:b0:483:a27e:6706 with SMTP id 5b1f17b1804b1-486fedb54cdmr103970865e9.9.1774129347951;
        Sat, 21 Mar 2026 14:42:27 -0700 (PDT)
Received: from shift.daheim (p200300d5ff07e00050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff07:e000:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48703e26408sm112656335e9.11.2026.03.21.14.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 14:42:27 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.99.1)
	(envelope-from <chunkeey@gmail.com>)
	id 1w442r-00000001Prb-08or;
	Sat, 21 Mar 2026 22:42:26 +0100
Message-ID: <cbeeac30-ff8e-4db0-bba9-30942001f557@gmail.com>
Date: Sat, 21 Mar 2026 22:42:26 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] carl9170: rx: handle zeroed PLCP CCK rate as
 corrupted frame
To: Masi Osmani <mas-i@hotmail.de>
Cc: linux-wireless@vger.kernel.org
References: <20260315225609.61791-1-mas-i@hotmail.de>
 <AM7PPF5613FA0B686F41D14D2742825BE219443A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Language: de-DE, en-US
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <AM7PPF5613FA0B686F41D14D2742825BE219443A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33653-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[hotmail.de];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chunkeey@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: E4B722E7573
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/15/26 11:56 PM, Masi Osmani wrote:
> The firmware occasionally delivers frames tagged as CCK modulation
> with a zeroed PLCP rate byte (plcp[0] == 0x00).  This typically
> happens after PHY state degradation from a failed channel change or
> from RF noise on weak signals.

And the firmware just "delivers" the frame that it gets from the hardware.
Apart from filtering (if enabled) it doesn't/shouldn't edit it.

> Currently these frames fall through to the default case and produce
> a rate-limited wiphy_err log:
> 
>    ieee80211 phy3: invalid plcp cck rate (0).
> 
> The frame is garbage regardless of the log level.  Handle plcp[0]
> == 0x00 as a dedicated case: increment the rx_dropped counter
> (visible via debugfs) and return -EINVAL silently.  Downgrade the
> remaining default case log from wiphy_err to wiphy_dbg so that
> genuinely unexpected PLCP values can still be investigated via
> dynamic debug without polluting normal dmesg output.
> 
> Signed-off-by: Masi Osmani <mas-i@hotmail.de>
> ---
>   drivers/net/wireless/ath/carl9170/rx.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> --- a/drivers/net/wireless/ath/carl9170/rx.c	2026-03-15 23:51:23.599698582 +0100
> +++ b/drivers/net/wireless/ath/carl9170/rx.c	2026-03-15 23:52:21.041912498 +0100
> @@ -372,9 +372,18 @@ static int carl9170_rx_mac_status(struct
>   		case AR9170_RX_PHY_RATE_CCK_11M:
>   			status->rate_idx = 3;
>   			break;
> +		case 0x00:
> +			/*
> +			 * Zeroed PLCP rate byte: the firmware delivered a
> +			 * corrupted frame, typically after PHY degradation
> +			 * from a failed channel change or from RF noise on
> +			 * weak signals.  Drop silently.
> +			 */
> +			ar->rx_dropped++;
> +			return -EINVAL;

I don't think we can really tell? From what I know the antenna must have pick up
this frame that way already. Is there some insight in how the hardware works?
Because from what I can gleam this "head->plcp[0]" seems to be pretty much the raw
value from what the PHY produced.

Note: This all might be because AR9170_MAC_RX_CTRL_PASS_TO_HOST is enabled.

>   		default:
>   			if (net_ratelimit()) {
> -				wiphy_err(ar->hw->wiphy, "invalid plcp cck "
> +				wiphy_dbg(ar->hw->wiphy, "invalid plcp cck "
>   				       "rate (%x).\n", head->plcp[0]);
>   			}

Downgrading this to debug? Yes, that I'm totally fine with.

