Return-Path: <linux-wireless+bounces-7823-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84B58C91C5
	for <lists+linux-wireless@lfdr.de>; Sat, 18 May 2024 19:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D8B1C20C16
	for <lists+linux-wireless@lfdr.de>; Sat, 18 May 2024 17:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27104087C;
	Sat, 18 May 2024 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ig9mgmOA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5104A41E22
	for <linux-wireless@vger.kernel.org>; Sat, 18 May 2024 17:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716054493; cv=none; b=KEZ6sKrXkNct8bhM04piOwccNQCL4BI9MndanC7fzVLy7f7BprGCCvcdTNr6nQJ0dw8+ta0A4K8VgZ8lVwSjhqsDIgCkimxHBuN15HsuZjajJAxP6iIzam5xQ5fLYF2mtBk0ULaRcyTlK1uTc0sJOOBsXXEcOaizLE3lUR+zKxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716054493; c=relaxed/simple;
	bh=ab2fSU/1mw8R2Ew62uMTyOAvkBnxl3xXW7S935p/f3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fH04ptx5mup6kflXfkwewEvFP1uHDrGu+Gnu/+LjhVO3cm3jH1s7lZiKZmQ+zv/Dg4VLXtLo/zCjy/8lIx4HyZVmOJjR8UALfdnoIxgQhpIUpM1tduf1S8vPhwYIbOjRSR1MxwJelETHmMtQziiFLQAs1GxHOjprv9/WS4rJtaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ig9mgmOA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1eca195a7c8so39263475ad.2
        for <linux-wireless@vger.kernel.org>; Sat, 18 May 2024 10:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716054491; x=1716659291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wh6Sw6JSS/WYAHtw7Fcgjy+KhVfjlazONeD51Ga0TSM=;
        b=ig9mgmOAjmw7NLVfIIh40kZCvNFK17E0S+AZ/IA4P9fLe9qLmgyKxd8ylhchByfRXz
         tcYezqBXAfozSXAc/3ATXV5p3NH29E8vME/mLeRacjQO/JgzF7HgQRAUOSUjR00x9abo
         Lz3kO92Kk8I2O7JLE+MGmeRFti63CVuNdK8Rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716054491; x=1716659291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wh6Sw6JSS/WYAHtw7Fcgjy+KhVfjlazONeD51Ga0TSM=;
        b=vAatvB3V81Lgut63zJHlSvPpq2fwQIs/nslWNX73XiCqFIxSI4wD4EiUbwXeYp5IyM
         3sS0zTPsDY85wHPHJXG6Z/MA28M64akXDSGi00ZfwGrAmdqMlS0D5q+q3wLxCSGUdoGr
         ZoVxGfCTCMT+EVCC0lMKguaNLhzV6wJtSL0FW6P4lb9MeNHFSFnDLW4HeobVPR4r4YS0
         A8mqLgpK12+1RoqUSl6GieF2+eMVPMc4jaKGZdV7xoJpr5MORvUx1WuX7SaNfsZXrQS3
         gNkXcrwwn00sqG+hRyxBRycQzs5JsmTM1sWFnhh+1UuhmVPchcPv7UW8cYUg2UGAJA5A
         /91A==
X-Forwarded-Encrypted: i=1; AJvYcCXYO7Nrh7uprt6mW+kegms2RZPejrARCQ43SDygoDhuEZhK0ZNp46XvzBaJ8WtU3niNbqg1KEUHi2kagcimNS5Q5XsDU7pQfFmTyzB7z+E=
X-Gm-Message-State: AOJu0YyORA4TAvEP1AcARTdnCAtLY0ZC1a2FteHZDM6Ppm0KI1HpXJ+o
	YNko/VPuqKO+YOm8KfPS1Mwq1zpl/Wm9U7HBJE3yHN+w4Y2gCu/h7z5a1NkURA==
X-Google-Smtp-Source: AGHT+IH7H0VKfPMl12YY15R5AggGWaUWF/k2UjM1MezoI0lIarULhsl7t808DjdAi9uIUaH9DzywtA==
X-Received: by 2002:a17:902:d4c8:b0:1f0:9395:7521 with SMTP id d9443c01a7336-1f093957864mr121083245ad.5.1716054490614;
        Sat, 18 May 2024 10:48:10 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0badcdb9sm176445875ad.109.2024.05.18.10.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 10:48:09 -0700 (PDT)
Date: Sat, 18 May 2024 10:48:08 -0700
From: Kees Cook <keescook@chromium.org>
To: Stanislaw Gruszka <stf_xl@wp.pl>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Xose Vazquez Perez <xose.vazquez@gmail.com>,
	linux-wireless@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [WARNING] memcpy: detected field-spanning write (size 1005) of
 single field "&out_cmd->cmd.payload" at
 drivers/net/wireless/intel/iwlegacy/common.c:3173 (size 320)
Message-ID: <202405181033.6399B7E416@keescook>
References: <2c534d01-449a-43f4-9216-eacdb3b35577@gmail.com>
 <20240518092939.GA643846@wp.pl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240518092939.GA643846@wp.pl>

On Sat, May 18, 2024 at 11:29:39AM +0200, Stanislaw Gruszka wrote:
> Hi
> 
> On Fri, Apr 12, 2024 at 07:48:39PM +0200, Xose Vazquez Perez wrote:
> > Hi,
> > 
> > In Fedora kernel 6.8.5-301.fc40.x86_64, dmesg shows:
> > 
> > [ device: 03:00.0 Network controller [0280]: Intel Corporation PRO/Wireless 4965 AG or AGN [Kedron] Network Connection [8086:4230] (rev 61) ]
> > 
> > Thanks.
> > 
> > [   53.407607] ------------[ cut here ]------------
> > [   53.407622] memcpy: detected field-spanning write (size 1005) of single field "&out_cmd->cmd.payload" at drivers/net/wireless/intel/iwlegacy/common.c:3173 (size 320)
> > [   53.407721] WARNING: CPU: 1 PID: 1632 at drivers/net/wireless/intel/iwlegacy/common.c:3173 il_enqueue_hcmd+0x477/0x560 [iwlegacy]
> 
> For CMD_SIZE_HUGE we have allocated 4k, so we do not do anything wrong.
> Except maybe code is convoluted, since we use same structure for
> huge and small il_device_cmd allocations.
> 
> But I'm thinking how to fix this fortify warning without refactoring and
> some extra runtime cost ...   
> 
> Xose, could you test below patch? I did not tested it, but I think
> it should make this particular warning gone and does not break
> anything. But maybe it will trigger some others fortify warnings.

tl;dr: the proposed patch should work. Refactoring will still be needed
in the future. :)

Long version:

struct il_device_cmd {
        struct il_cmd_header hdr;       /* uCode API */
        union {
                u32 flags;
                u8 val8;
                u16 val16;
                u32 val32;
                struct il_tx_cmd tx;
                u8 payload[DEF_CMD_PAYLOAD_SIZE];
        } __packed cmd;
} __packed;

struct il_cmd_header {
	...
        /* command or response/notification data follows immediately */
        u8 data[];
} __packed;

Yes, the proposed fix will silence the warning, but this struct is
certainly on Gustavo's list to fix for "flexible arrays not-at-end"
warnings[1].

This memcpy() is the perfect example of why we need to refactor these
kinds of structs: the object size is ambiguous for the compiler. It
could be as little as sizeof(struct il_device_cmd), but it could larger,
because of the "hdr" member. Right now, it depends on how we happen to
address it (as your change is doing).

Regardless, thanks for tracking this down and fixing it!

-Kees

[1] https://lore.kernel.org/lkml/ZgsAFhl90kecIR00@neat/

> 
> Regards
> Stanislaw
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
> index 9d33a66a49b5..c4ccc5df6419 100644
> --- a/drivers/net/wireless/intel/iwlegacy/common.c
> +++ b/drivers/net/wireless/intel/iwlegacy/common.c
> @@ -3170,7 +3170,7 @@ il_enqueue_hcmd(struct il_priv *il, struct il_host_cmd *cmd)
>  		out_meta->callback = cmd->callback;
>  
>  	out_cmd->hdr.cmd = cmd->id;
> -	memcpy(&out_cmd->cmd.payload, cmd->data, cmd->len);
> +	memcpy(&out_cmd->hdr.data, cmd->data, cmd->len);
>  
>  	/* At this point, the out_cmd now has all of the incoming cmd
>  	 * information */

-- 
Kees Cook

