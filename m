Return-Path: <linux-wireless+bounces-7838-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F264D8C9957
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 09:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D27281306
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 07:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368F718EA1;
	Mon, 20 May 2024 07:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="EfuHjjdH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B839F17BA3
	for <linux-wireless@vger.kernel.org>; Mon, 20 May 2024 07:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716190343; cv=none; b=dMHvml0vrp+sa/oJJu6o9zWHBMsHz1MV5WgYVePYs/n3jRgEgOlEErRxtbvP/23lZLNdl8RDWKYIVwwuUGnDMeUpdjEsKtmKeXVVv7seDlIJYCxipP0vc5i2gTLlqEPlo8sh5r+q8y052iHNm+UrpdiRSi3uOz8hs5ZG0QEmxVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716190343; c=relaxed/simple;
	bh=SXWLRqg/cx1GwPNZn/xC44bifhSGMJ1Ot6OtCQCtJ/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrH7EB/cLsflp39gZp9e9a5FRjFwZRHPoDGG939cRedP83dPRhgZUMiJ2pu/j9H3GjSspfRke/GZ5pumqWp8fWFkAr9V9lTcltLh5AckKXkVzE8SrHzGVpDZBnWQ3ST+HSl1vZC6C2BKYR6Tgjtl/+q/caKciedP3AuijypjTwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=EfuHjjdH; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 43762 invoked from network); 20 May 2024 09:32:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1716190330; bh=E/kjzu1Wex4qcsfYIAvHw87WxHOGH99XN8pJZ/+CH0Q=;
          h=From:To:Cc:Subject;
          b=EfuHjjdHSt0YksyHxNYWhj5RZIg5INw1WjZZ2lJ5z/oG5CIeaDjzbMsN4TSwCk90f
           fk3kXqSpGMc2dbMXoYO4FhjnZfZI0bmyb4Uwa6OveFzcDP/oxZJPsKhlSYcx+EgSgd
           s2wF54eg6X86ZHz4OKLQ+yXSF8N+o4Hmn8/pbeS8=
Received: from 89-64-9-76.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.9.76])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <keescook@chromium.org>; 20 May 2024 09:32:10 +0200
Date: Mon, 20 May 2024 09:32:10 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Kees Cook <keescook@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Xose Vazquez Perez <xose.vazquez@gmail.com>,
	linux-wireless@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [WARNING] memcpy: detected field-spanning write (size 1005) of
 single field "&out_cmd->cmd.payload" at
 drivers/net/wireless/intel/iwlegacy/common.c:3173 (size 320)
Message-ID: <20240520073210.GA693073@wp.pl>
References: <2c534d01-449a-43f4-9216-eacdb3b35577@gmail.com>
 <20240518092939.GA643846@wp.pl>
 <202405181033.6399B7E416@keescook>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202405181033.6399B7E416@keescook>
X-WP-MailID: 39b0581376fbfbf62c4d4b81b3d927d8
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000002 [ARGB]                               

On Sat, May 18, 2024 at 10:48:08AM -0700, Kees Cook wrote:
> On Sat, May 18, 2024 at 11:29:39AM +0200, Stanislaw Gruszka wrote:
> > Hi
> > 
> > On Fri, Apr 12, 2024 at 07:48:39PM +0200, Xose Vazquez Perez wrote:
> > > Hi,
> > > 
> > > In Fedora kernel 6.8.5-301.fc40.x86_64, dmesg shows:
> > > 
> > > [ device: 03:00.0 Network controller [0280]: Intel Corporation PRO/Wireless 4965 AG or AGN [Kedron] Network Connection [8086:4230] (rev 61) ]
> > > 
> > > Thanks.
> > > 
> > > [   53.407607] ------------[ cut here ]------------
> > > [   53.407622] memcpy: detected field-spanning write (size 1005) of single field "&out_cmd->cmd.payload" at drivers/net/wireless/intel/iwlegacy/common.c:3173 (size 320)
> > > [   53.407721] WARNING: CPU: 1 PID: 1632 at drivers/net/wireless/intel/iwlegacy/common.c:3173 il_enqueue_hcmd+0x477/0x560 [iwlegacy]
> > 
> > For CMD_SIZE_HUGE we have allocated 4k, so we do not do anything wrong.
> > Except maybe code is convoluted, since we use same structure for
> > huge and small il_device_cmd allocations.
> > 
> > But I'm thinking how to fix this fortify warning without refactoring and
> > some extra runtime cost ...   
> > 
> > Xose, could you test below patch? I did not tested it, but I think
> > it should make this particular warning gone and does not break
> > anything. But maybe it will trigger some others fortify warnings.
> 
> tl;dr: the proposed patch should work. Refactoring will still be needed
> in the future. :)
> 
> Long version:
> 
> struct il_device_cmd {
>         struct il_cmd_header hdr;       /* uCode API */
>         union {
>                 u32 flags;
>                 u8 val8;
>                 u16 val16;
>                 u32 val32;
>                 struct il_tx_cmd tx;
>                 u8 payload[DEF_CMD_PAYLOAD_SIZE];
>         } __packed cmd;
> } __packed;
> 
> struct il_cmd_header {
> 	...
>         /* command or response/notification data follows immediately */
>         u8 data[];
> } __packed;
> 
> Yes, the proposed fix will silence the warning, but this struct is
> certainly on Gustavo's list to fix for "flexible arrays not-at-end"
> warnings[1].
> 
> This memcpy() is the perfect example of why we need to refactor these
> kinds of structs: the object size is ambiguous for the compiler. It
> could be as little as sizeof(struct il_device_cmd), but it could larger,
> because of the "hdr" member. Right now, it depends on how we happen to
> address it (as your change is doing).

I think we can just remove "data" from il_cmd_heder (I relized it's not
used anyway) and put it into command union. So below patch should fix
current warning and potential future warnings as well. 

Xose, could you give it a try ?

Thanks
Stanislaw

diff --git a/drivers/net/wireless/intel/iwlegacy/commands.h b/drivers/net/wireless/intel/iwlegacy/commands.h
index 28cf4e832152..dca8ecf89d1e 100644
--- a/drivers/net/wireless/intel/iwlegacy/commands.h
+++ b/drivers/net/wireless/intel/iwlegacy/commands.h
@@ -201,9 +201,6 @@ struct il_cmd_header {
 	 *  15          unsolicited RX or uCode-originated notification
 	 */
 	__le16 sequence;
-
-	/* command or response/notification data follows immediately */
-	u8 data[];
 } __packed;
 
 /**
diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
index 9d33a66a49b5..8f02f252b577 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.c
+++ b/drivers/net/wireless/intel/iwlegacy/common.c
@@ -3170,7 +3170,7 @@ il_enqueue_hcmd(struct il_priv *il, struct il_host_cmd *cmd)
 		out_meta->callback = cmd->callback;
 
 	out_cmd->hdr.cmd = cmd->id;
-	memcpy(&out_cmd->cmd.payload, cmd->data, cmd->len);
+	memcpy(&out_cmd->cmd.raw, cmd->data, cmd->len);
 
 	/* At this point, the out_cmd now has all of the incoming cmd
 	 * information */
diff --git a/drivers/net/wireless/intel/iwlegacy/common.h b/drivers/net/wireless/intel/iwlegacy/common.h
index 69687fcf963f..5682cccfa394 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.h
+++ b/drivers/net/wireless/intel/iwlegacy/common.h
@@ -555,6 +555,7 @@ struct il_device_cmd {
 		u32 val32;
 		struct il_tx_cmd tx;
 		u8 payload[DEF_CMD_PAYLOAD_SIZE];
+		DECLARE_FLEX_ARRAY(u8, raw);
 	} __packed cmd;
 } __packed;
 

