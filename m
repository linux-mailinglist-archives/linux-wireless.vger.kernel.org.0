Return-Path: <linux-wireless+bounces-7845-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F28718C9F57
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 17:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90031F2190B
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 15:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AED028E7;
	Mon, 20 May 2024 15:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="oHHa9Pov"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35378136E05
	for <linux-wireless@vger.kernel.org>; Mon, 20 May 2024 15:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716217745; cv=none; b=hyggMn8gyBfJGsEvKhY5zy9drEcLNmGlLSgaUVGQJkBCQ+ICsHUH28XwDdNCriHeWTa0vNg0e5FQdcvi2M3eL+kBs2/D6mfVOfENay5vz6lyeorT4rGOSMh6m0m40dJ1EmUhnwlMfcV8AF3nP+75eSvrgs9/6mID3lOiWO62p08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716217745; c=relaxed/simple;
	bh=RIwnFL3zBhOLkBjWxc42GiZ1KUoAUEnOT28xaci3Pkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9L+/SWGlknsYYvQAIlC9P8nheSTEw4BI8F9g2moDwELZO7GFrEwuVa02oXQGDZGTT5VdX3pEDd8ZyhmShMKQ5DpqWERYjsbV8NJs8c7evlDvk685ZSfDeHK8+eHA7wKknvLr614FVDElw9SjYWBoWo3MBucG6maelbyWQ3BWqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=oHHa9Pov; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 627 invoked from network); 20 May 2024 17:08:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1716217737; bh=ukF5w1hULeUmf7Sumw9VZixY3Si7EdfWlS1/RA7IoLY=;
          h=From:To:Cc:Subject;
          b=oHHa9PovYeYI4xYUmGGKHEtCUC89XyMommNPWlKlnXNLDaVS1i7yebXPS6HctoK8J
           u2rgZzMzN0Y6riRLGr4tIb9IxpZKXS2k0F/ORmDyai11lGD0VXyUkM9p6De3+b1A1N
           cVKrRWnHmOZdLR8/B+39wt7HTnTVBY7UDrU76CQc=
Received: from 89-64-9-76.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.9.76])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <johannes@sipsolutions.net>; 20 May 2024 17:08:57 +0200
Date: Mon, 20 May 2024 17:08:57 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Xose Vazquez Perez <xose.vazquez@gmail.com>,
	linux-wireless@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [WARNING] memcpy: detected field-spanning write (size 1005) of
 single field "&out_cmd->cmd.payload" at
 drivers/net/wireless/intel/iwlegacy/common.c:3173 (size 320)
Message-ID: <20240520150857.GA709412@wp.pl>
References: <2c534d01-449a-43f4-9216-eacdb3b35577@gmail.com>
 <20240518092939.GA643846@wp.pl>
 <202405181033.6399B7E416@keescook>
 <20240520073210.GA693073@wp.pl>
 <95f3e147de837b4833e6cf6eb67108f96640af4e.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95f3e147de837b4833e6cf6eb67108f96640af4e.camel@sipsolutions.net>
X-WP-MailID: 7ce9955f4eb8755dbe7b3baaff537806
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [kdMh]                               

On Mon, May 20, 2024 at 01:45:37PM +0200, Johannes Berg wrote:
> 
> > +++ b/drivers/net/wireless/intel/iwlegacy/commands.h
> > @@ -201,9 +201,6 @@ struct il_cmd_header {
> >  	 *  15          unsolicited RX or uCode-originated notification
> >  	 */
> >  	__le16 sequence;
> > -
> > -	/* command or response/notification data follows immediately */
> > -	u8 data[];
> >  } __packed;
> 
> [...]
> 
> 
> > -	memcpy(&out_cmd->cmd.payload, cmd->data, cmd->len);
> > +	memcpy(&out_cmd->cmd.raw, cmd->data, cmd->len);
> 
> [...]
> 
> > +++ b/drivers/net/wireless/intel/iwlegacy/common.h
> > @@ -555,6 +555,7 @@ struct il_device_cmd {
> >  		u32 val32;
> >  		struct il_tx_cmd tx;
> >  		u8 payload[DEF_CMD_PAYLOAD_SIZE];
> > +		DECLARE_FLEX_ARRAY(u8, raw);
> > 
> 
> I don't think this is right, now the raw comes after
> DEF_CMD_PAYLOAD_SIZE? You want it to be a union with payload, I'd think.

Not sure if I understand. I think we have union with payload with 
the patch. The structure looks like this:

struct il_device_cmd {
	struct il_cmd_header hdr;	/* uCode API */
	union {
		u32 flags;
		u8 val8;
		u16 val16;
		u32 val32;
		struct il_tx_cmd tx;
		u8 payload[DEF_CMD_PAYLOAD_SIZE];
		DECLARE_FLEX_ARRAY(u8, raw);
	} __packed cmd;
} __packed;

BTW, the first four cmd union fields i.e. flags, val8 ...
can be removed as well, seems nothing touch those fields in the code.

Regards
Stanislaw


