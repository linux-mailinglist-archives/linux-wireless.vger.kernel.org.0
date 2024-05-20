Return-Path: <linux-wireless+bounces-7841-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 795998C9C90
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 13:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A47283329
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 11:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F85C7711E;
	Mon, 20 May 2024 11:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="uhjp+uMG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A326977F2F;
	Mon, 20 May 2024 11:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716205543; cv=none; b=oQsV6IuF+hX6WJBBAig/pIJTM2ykXdfOOXlCH+ynVubbdewrdtukhHAxzfHywXtCXl/9pdQvAJzruQaLgNYFEvfoEPP023uhhtak7AYGlmC/4+9YpSWb8Vx9rYAIMUlMonLJAu7rHHHcD0aesPESESpCkhIa2MOfgJJ/siQpNOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716205543; c=relaxed/simple;
	bh=F3rZG5RorXcLyQ01SqQykrqAbDvDdcRo5CeTiIqlEfs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FJbWhEAJ4i3LZCCLbcK9ThEcZd15alGFlVk/fO4aFmo3xzNyCqqKMsYkhT2Aqh+KmqyvD5tT4nJOeIOfk9L8CqQgNuU2x/pAhC4qS/tzidJycbm3oMbb6DRSVuOTvXPZ7j9ccqTEZrT+4iVOdwgvJItCaO5EBphx1PF1mjDZfUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=uhjp+uMG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=KpJ6k4J59qKz0uHRTXxneTJbQDK8g074xXtvyyznLwk=;
	t=1716205541; x=1717415141; b=uhjp+uMGuc+bFOkFese4kzhquCy2tQ6KSUgx1Hs9K1vLmKy
	RrzhRbmjY4SgUZC+mQBDqadkkvTYikbZ9CpEHjl2CHP3E4qQtWziQDYBssl7NuiAyhcQAmzY3Bbk6
	yybQhEV60jmsYse3O2VJhgL7QraYBT8WORoja9HNwS/V36fVDxtmRddob8OUS/TTNQgI1TjwE8+aA
	6yNlPdIODmaLPF0sB5SaiDSLI4jTJwIX/xz4QuLjEXR8G+mIhde8ouKyxRX22zjGzq8+rxLgeeK7v
	9GjL3iQ2Of2Km8YuV93gN9lGBAAK962Ycw0bAGOCGqLDQMxOKbXTZgHtqFp41NuA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s91SU-00000000C2y-1k4V;
	Mon, 20 May 2024 13:45:38 +0200
Message-ID: <95f3e147de837b4833e6cf6eb67108f96640af4e.camel@sipsolutions.net>
Subject: Re: [WARNING] memcpy: detected field-spanning write (size 1005) of
 single field "&out_cmd->cmd.payload" at
 drivers/net/wireless/intel/iwlegacy/common.c:3173 (size 320)
From: Johannes Berg <johannes@sipsolutions.net>
To: Stanislaw Gruszka <stf_xl@wp.pl>, Kees Cook <keescook@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Xose Vazquez Perez
	 <xose.vazquez@gmail.com>, linux-wireless@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Date: Mon, 20 May 2024 13:45:37 +0200
In-Reply-To: <20240520073210.GA693073@wp.pl>
References: <2c534d01-449a-43f4-9216-eacdb3b35577@gmail.com>
	 <20240518092939.GA643846@wp.pl> <202405181033.6399B7E416@keescook>
	 <20240520073210.GA693073@wp.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned


> +++ b/drivers/net/wireless/intel/iwlegacy/commands.h
> @@ -201,9 +201,6 @@ struct il_cmd_header {
>  	 *  15          unsolicited RX or uCode-originated notification
>  	 */
>  	__le16 sequence;
> -
> -	/* command or response/notification data follows immediately */
> -	u8 data[];
>  } __packed;

[...]


> -	memcpy(&out_cmd->cmd.payload, cmd->data, cmd->len);
> +	memcpy(&out_cmd->cmd.raw, cmd->data, cmd->len);

[...]

> +++ b/drivers/net/wireless/intel/iwlegacy/common.h
> @@ -555,6 +555,7 @@ struct il_device_cmd {
>  		u32 val32;
>  		struct il_tx_cmd tx;
>  		u8 payload[DEF_CMD_PAYLOAD_SIZE];
> +		DECLARE_FLEX_ARRAY(u8, raw);
>=20

I don't think this is right, now the raw comes after
DEF_CMD_PAYLOAD_SIZE? You want it to be a union with payload, I'd think.

johannes

