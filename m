Return-Path: <linux-wireless+bounces-12811-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC229765DD
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2024 11:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E37DE28591D
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2024 09:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF3E18C90C;
	Thu, 12 Sep 2024 09:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="grONRflI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E3119E982
	for <linux-wireless@vger.kernel.org>; Thu, 12 Sep 2024 09:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726134010; cv=none; b=fjWqpr/g8gL2TWT5FUUAYmNeAgoJ6emGd9zdswX3JOSQr/U535dUUCoGY3cs+mG5alcs1ypUXuc960PxgSOZ3Sv9cYb/qnwVmluudWq8B3XREahGNnK4UI+ovy7BXRYYkzI3MfVKxtygmg0Yw/mhTpaJ6Qmxon9pEyduLShEn1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726134010; c=relaxed/simple;
	bh=32A7mtoiTwrAP2CN+YkaC5Gp249jc9zREwQCABujAuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ew40sazvrzgVLIbeEtI9lCws2B7ukqHykryG50Rs1jUggfcH9G7BigWgJphZZXQRHCS/Oc2i1dAJ9Ln8rUk54VzTB7ZJ3k4XMdz8cTkg7aWU2NfBRB5FkDTml/tgKNmZU+KBPMby/Ib2B0V+TJuB1Ehygwr/ObzAyigQQoKkqkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=grONRflI; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 43316 invoked from network); 12 Sep 2024 10:40:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1726130400; bh=NSNPO1OnVrFUBHbdGWrQyf3M9RLOSH9dTu1kXpgUHG8=;
          h=From:To:Cc:Subject;
          b=grONRflIHNi7WlEPJIEfbUnMC37qDrn5+3LYXZ1IjKXcsnsH2YWinKzzEKjrHLy6g
           n9SpnKgJBSO+/BXZJojmnxxVwTKUsaegcz8TCe9VKV8KtNu1rVMA2s/rSctStMnXKn
           zBBs2brgk8zHqrg83xZ3fU8UrfJughAGje3g7b28=
Received: from 89-64-9-121.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.9.121])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <ben@decadent.org.uk>; 12 Sep 2024 10:40:00 +0200
Date: Thu, 12 Sep 2024 10:39:59 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: linux-wireless@vger.kernel.org,
	=?iso-8859-1?Q?Martin-=C9ric?= Racine <martin-eric.racine@iki.fi>,
	Brandon Nielsen <nielsenb@jetfuse.net>
Subject: Re: [PATCH] wifi: iwlegacy: Fix "field-spanning write" warning in
 il_enqueue_hcmd()
Message-ID: <20240912083959.GA132706@wp.pl>
References: <ZuIhQRi/791vlUhE@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZuIhQRi/791vlUhE@decadent.org.uk>
X-WP-MailID: 993568ca9aecb587a2ea8283de274a90
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000004 [QVdQ]                               

On Thu, Sep 12, 2024 at 01:01:21AM +0200, Ben Hutchings wrote:
> iwlegacy uses command buffers with a payload size of 320
> bytes (default) or 4092 bytes (huge).  The struct il_device_cmd type
> describes the default buffers and there is no separate type describing
> the huge buffers.
> 
> The il_enqueue_hcmd() function works with both default and huge
> buffers, and has a memcpy() to the buffer payload.  The size of
> this copy may exceed 320 bytes when using a huge buffer, which
> now results in a run-time warning:
> 
>     memcpy: detected field-spanning write (size 1014) of single field "&out_cmd->cmd.payload" at drivers/net/wireless/intel/iwlegacy/common.c:3170 (size 320)
> 
> To fix this:
> 
> - Define a new struct type for huge buffers, with a correctly sized
>   payload field
> - When using a huge buffer in il_enqueue_hcmd(), cast the command
>   buffer pointer to that type when looking up the payload field
> 
> Reported-by: Martin-Éric Racine <martin-eric.racine@iki.fi>
> References: https://bugs.debian.org/1062421
> References: https://bugzilla.kernel.org/show_bug.cgi?id=219124
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> Fixes: 54d9469bc515 ("fortify: Add run-time WARN for cross-field memcpy()")
> Tested-by: Martin-Éric Racine <martin-eric.racine@iki.fi>
> Tested-by: Brandon Nielsen <nielsenb@jetfuse.net>

I proposed diffrent fix for this here:
https://lore.kernel.org/linux-wireless/20240520073210.GA693073@wp.pl/
but never get feedback if it works on real HW.
So I prefer this one, sice it was tested.

Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

Martin-Éric and Brandon, could you plase also test patch from 
https://lore.kernel.org/linux-wireless/Zr2gxERA3RL3EwRe@elsanto/
if it does not break the driver?

Thanks
Stanislaw

> ---
>  drivers/net/wireless/intel/iwlegacy/common.c | 13 ++++++++++++-
>  drivers/net/wireless/intel/iwlegacy/common.h | 12 ++++++++++++
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
> index 9d33a66a49b5..4616293ec0cf 100644
> --- a/drivers/net/wireless/intel/iwlegacy/common.c
> +++ b/drivers/net/wireless/intel/iwlegacy/common.c
> @@ -3122,6 +3122,7 @@ il_enqueue_hcmd(struct il_priv *il, struct il_host_cmd *cmd)
>  	struct il_cmd_meta *out_meta;
>  	dma_addr_t phys_addr;
>  	unsigned long flags;
> +	u8 *out_payload;
>  	u32 idx;
>  	u16 fix_size;
>  
> @@ -3157,6 +3158,16 @@ il_enqueue_hcmd(struct il_priv *il, struct il_host_cmd *cmd)
>  	out_cmd = txq->cmd[idx];
>  	out_meta = &txq->meta[idx];
>  
> +	/* The payload is in the same place in regular and huge
> +	 * command buffers, but we need to let the compiler know when
> +	 * we're using a larger payload buffer to avoid "field-
> +	 * spanning write" warnings at run-time for huge commands.
> +	 */
> +	if (cmd->flags & CMD_SIZE_HUGE)
> +		out_payload = ((struct il_device_cmd_huge *)out_cmd)->cmd.payload;
> +	else
> +		out_payload = out_cmd->cmd.payload;
> +
>  	if (WARN_ON(out_meta->flags & CMD_MAPPED)) {
>  		spin_unlock_irqrestore(&il->hcmd_lock, flags);
>  		return -ENOSPC;
> @@ -3170,7 +3181,7 @@ il_enqueue_hcmd(struct il_priv *il, struct il_host_cmd *cmd)
>  		out_meta->callback = cmd->callback;
>  
>  	out_cmd->hdr.cmd = cmd->id;
> -	memcpy(&out_cmd->cmd.payload, cmd->data, cmd->len);
> +	memcpy(out_payload, cmd->data, cmd->len);
>  
>  	/* At this point, the out_cmd now has all of the incoming cmd
>  	 * information */
> diff --git a/drivers/net/wireless/intel/iwlegacy/common.h b/drivers/net/wireless/intel/iwlegacy/common.h
> index 69687fcf963f..027dae5619a3 100644
> --- a/drivers/net/wireless/intel/iwlegacy/common.h
> +++ b/drivers/net/wireless/intel/iwlegacy/common.h
> @@ -560,6 +560,18 @@ struct il_device_cmd {
>  
>  #define TFD_MAX_PAYLOAD_SIZE (sizeof(struct il_device_cmd))
>  
> +/**
> + * struct il_device_cmd_huge
> + *
> + * For use when sending huge commands.
> + */
> +struct il_device_cmd_huge {
> +	struct il_cmd_header hdr;	/* uCode API */
> +	union {
> +		u8 payload[IL_MAX_CMD_SIZE - sizeof(struct il_cmd_header)];
> +	} __packed cmd;
> +} __packed;
> +
>  struct il_host_cmd {
>  	const void *data;
>  	unsigned long reply_page;



