Return-Path: <linux-wireless+bounces-7820-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4742E8C9039
	for <lists+linux-wireless@lfdr.de>; Sat, 18 May 2024 11:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76FA61C20DD4
	for <lists+linux-wireless@lfdr.de>; Sat, 18 May 2024 09:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8E0DDDF;
	Sat, 18 May 2024 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="pnOYrEe0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349368BEA
	for <linux-wireless@vger.kernel.org>; Sat, 18 May 2024 09:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716024986; cv=none; b=V39K+9+r3fBypNgdOO5Ai4cK/SmNZPBTMZKSb+st2XgSqBbdg6wQO4O966lUbUczdsP153+JTjOG9QGj45p0RdAGcU9NNI6EgVGl+r1XV9pZVnrYMKDKgo8SuwAhyTPUyn0fICqGXAY3JTf8NLeRS0F8g0BLYQIDR9/CtXOYVjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716024986; c=relaxed/simple;
	bh=/ff+y6N/bVLEJkZA7IjiDKP1wE0nrhWuCxMNrhj4rx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtnzU+rsWV6mCAOFCbiOr+k0Acw5SrLVF9pM92Iuh9MzJOyRBr/MyMp3N3oa2dwhJGWv8dsFtn3mQpJ7+UzvMiF3KfIwsq9X98gJNmqpP4TozVtMWxiBmNqHpRxMQtMoAvGcn4AlBW3xYauTwIt5f9+Gor+lgIyr3MaeX4Z6Upw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=pnOYrEe0; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 12094 invoked from network); 18 May 2024 11:29:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1716024580; bh=iY9and2fRgy70/SkFGL1EiobywiSyLTQmpLGJth6Z1E=;
          h=From:To:Cc:Subject;
          b=pnOYrEe04rgwoi5hrFGpXBXtYJockzJPNcQtQEZhmn5PI3VQ1F0ZH8uMbQqw8ahuT
           kzZ30+U6mXVF7jBhZiUUbgmD+p3u8DHStYvgEafPOPdp/BW8ESq8U9W1PxrQW5gGnR
           i3r87zXrMkWEyAFRmrlcg7OeIN3K1jQp06HlnedY=
Received: from 89-64-9-76.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.9.76])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <xose.vazquez@gmail.com>; 18 May 2024 11:29:40 +0200
Date: Sat, 18 May 2024 11:29:39 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Xose Vazquez Perez <xose.vazquez@gmail.com>
Cc: linux-wireless@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [WARNING] memcpy: detected field-spanning write (size 1005) of
 single field "&out_cmd->cmd.payload" at
 drivers/net/wireless/intel/iwlegacy/common.c:3173 (size 320)
Message-ID: <20240518092939.GA643846@wp.pl>
References: <2c534d01-449a-43f4-9216-eacdb3b35577@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c534d01-449a-43f4-9216-eacdb3b35577@gmail.com>
X-WP-MailID: e9b5917407e67f223ec504bc876e22cb
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000002 [AVHg]                               

Hi

On Fri, Apr 12, 2024 at 07:48:39PM +0200, Xose Vazquez Perez wrote:
> Hi,
> 
> In Fedora kernel 6.8.5-301.fc40.x86_64, dmesg shows:
> 
> [ device: 03:00.0 Network controller [0280]: Intel Corporation PRO/Wireless 4965 AG or AGN [Kedron] Network Connection [8086:4230] (rev 61) ]
> 
> Thanks.
> 
> [   53.407607] ------------[ cut here ]------------
> [   53.407622] memcpy: detected field-spanning write (size 1005) of single field "&out_cmd->cmd.payload" at drivers/net/wireless/intel/iwlegacy/common.c:3173 (size 320)
> [   53.407721] WARNING: CPU: 1 PID: 1632 at drivers/net/wireless/intel/iwlegacy/common.c:3173 il_enqueue_hcmd+0x477/0x560 [iwlegacy]

For CMD_SIZE_HUGE we have allocated 4k, so we do not do anything wrong.
Except maybe code is convoluted, since we use same structure for
huge and small il_device_cmd allocations.

But I'm thinking how to fix this fortify warning without refactoring and
some extra runtime cost ...   

Xose, could you test below patch? I did not tested it, but I think
it should make this particular warning gone and does not break
anything. But maybe it will trigger some others fortify warnings.

Regards
Stanislaw

diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
index 9d33a66a49b5..c4ccc5df6419 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.c
+++ b/drivers/net/wireless/intel/iwlegacy/common.c
@@ -3170,7 +3170,7 @@ il_enqueue_hcmd(struct il_priv *il, struct il_host_cmd *cmd)
 		out_meta->callback = cmd->callback;
 
 	out_cmd->hdr.cmd = cmd->id;
-	memcpy(&out_cmd->cmd.payload, cmd->data, cmd->len);
+	memcpy(&out_cmd->hdr.data, cmd->data, cmd->len);
 
 	/* At this point, the out_cmd now has all of the incoming cmd
 	 * information */

