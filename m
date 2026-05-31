Return-Path: <linux-wireless+bounces-37186-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPt/NkHOG2prGQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37186-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 07:59:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DE222614A2D
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 07:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ED0FF3008CAE
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 05:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDC731E859;
	Sun, 31 May 2026 05:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlcQk8Yc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7796C306767
	for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 05:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780207164; cv=pass; b=d562bNe4qixF1T1DN3i3HqN973elpYoE0p+svEGVSF9HD+D51s4AR8ovYdgEf8a87QZ6ZM5ZbeBi/0laXxIth/hJhAqnkNRf7PJYlL2lt7GlCu1K17zTSudJvGuadW3/nDVG4eKbHbqPPnbDGnejT4cDZ+113MIUNT5POGVzbQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780207164; c=relaxed/simple;
	bh=8Qxitf8kEOy9xsS2YtUu3djCAogZZAZr9zPFjBlZ5v8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4+SclAdg3rN6NT/nElkQLQsElaV9yk7Cq5jqpKGVj9hW9GSaiYUG0X6+xGnOOuOs9ivVW7CnQLmHmlxcgP+Rju1A9HrT+9fOZT0QgMt6YhU39XBARbvVrUj9ROOiwJJUqL3rgh7pkLbW42Wql6BtFEN3w8m8A9+/PluMXxIijw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlcQk8Yc; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aa4a628ab0so3992061e87.2
        for <linux-wireless@vger.kernel.org>; Sat, 30 May 2026 22:59:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780207162; cv=none;
        d=google.com; s=arc-20240605;
        b=YzC3pcudnx/G8aA/plQv6661IQ52rTmr37NW1p/PcHHlmcOqiR2I1YFHUnFnXtMb60
         5sW8PkO5FqCKf9AeNFB1Wc3/vsgbR/ntHOhz2aCjBFlOq22nmMvd1HsFWp39f7TNO4Pr
         uY0wBQf1qPPYrjMFGcsmxslp7bedzW5K96TYtqLyEh8swvqMJBl/5pyx375EnMhx1jm7
         QmlbGnsZDYl38PWuk4A6weaGQWWYyRUsKw+0YmrjZVeSrdyuzZ1L4F0lwLVYQ3OiBXf4
         ntLJNlDn7C3tT9DFkGh1Z089YE4JWnEhQFUaom4bdj5uDWLOu3yxr/oTdjTTsoFAeklg
         WnOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d0EaNBSUbiey68m2B5KxxQ/OahX+MOW+bnYUMvPb50w=;
        fh=mbvKUJAjyFFbVUNrd9ijw01ypZk+tu5w23LYQkVko8c=;
        b=RC55pAFmI3ttI/4rJCLMjfPI72t8nlpakZz5T8ugHfJIc2VBRCbFWpuDChmcR2Vx3g
         IfQdwcgJiaC80/eHStwfg561xpg0HPZMaSCc39794jlSI3OpphG8WGyRm4FHSmT+VB0C
         dYs/7sFQZ6zH4k0alSmeqEsqtRKir8MLVr7cmt/JCGpd3amG54zoDaJULThPwjmvnnT1
         ktcBC7FQYSyU6J4ZiUC3viAFMrk4N71W5njEN1pdO9iyXutpKOKn0jEobgF5vZhBlYAS
         9POKnoTo2B5jGq/u8rZepPt3ZAMrmhCP7jchHRzhGWK+Rfj33qigN/3Kw0jZYviM2mi9
         78fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780207162; x=1780811962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0EaNBSUbiey68m2B5KxxQ/OahX+MOW+bnYUMvPb50w=;
        b=MlcQk8Yc8SGFrwaOT2fREFsc07HglrxEXsWRFhUARED63vSj4Hrs4LEBVf0ED5CNnt
         wdC8YhLofRM5rXjK6V032FltL61qf6/Y3tYU8n2jOlkHDEosYqOc8yXOGiCWQuHwUuvt
         RtBjDAx2B/2mGpD0DTJC8XwI+xgmxmWQpnW9TagSMY3wY8AmOozbHUcEgfLp/EEAUjTM
         iS6A3PdM/xF+x6JrN7kybAi+4GADfmmP3C9unHsVsEYXnuenrywE9jwP87zS7LlnhY2E
         sOWpR7fKquj3iBGceau9qjApfGz4icHwJa1dKOAj5n0TW2+CQreJfNv8r/pBWisf/txb
         DWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780207162; x=1780811962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d0EaNBSUbiey68m2B5KxxQ/OahX+MOW+bnYUMvPb50w=;
        b=Gwtogrq9KQeM8o3yWxWZDwwKI7kWLqjuI90O5kfEbV3UrM4c1DFzS+rBw/T2odMg/x
         v2JQqESpQRt+XxjaMUq5aNWg7n4+dMnuJ1gztFKtyazXfUR8OEwfrJgc2SexwTTbENiO
         ZIJFIkFKLvWbCkwC7XXZf+jHznu2XSZlPUAxAEucBW02yP3lmdEPemoQQGNKAAWhMj1C
         h8ejGy1849Pe1hIH7GIboQCLlgrKpWSiLMfh3N6chuCYcrFR+6zUBrqqh/STUQSbHM7L
         yJ9DVzVoKH5YTTt/F32QtFQaR5h0Dse0tV9Tloltu/NHc9zXHq7MIOpas6gm6YlVSh+d
         CU/Q==
X-Gm-Message-State: AOJu0YyYBOLtM4RBwS6pTUF2Tldv3DI6w3aFPawbdV2acJKvShCr2OB1
	R8MPWUzpqQgwIZMksvt08wNuhClnmcFgVW/jWLojASfnWth1ODL0zDfCcRBqxaAms2K4Xp2NOMO
	i69JPStoAMVMTRuNWhMit4WQhp6np6y0=
X-Gm-Gg: Acq92OHypBPqikqekEVl2H2dnlcAiDG8NZOPsfvgacZ83AvMUREiMHK0f7BXu5FFxga
	w3lh9NQBl+WhiPdLrMfMLlC1wAQR5uVC+emEeS+A3KxLTOGb1WBeGkPKYitKd19wwJahPtsMf94
	CIqglI5qDjI4KtedqpFziJ/jmmBfRhgepG10smbtvGbzXNKtYOhi4cPg7Oou19nbvVZObsGuacj
	8jFQ7AAst2WKrQC+ImTKTHt0KaHkUx9Pb8uvTpJ9+jscPwCJYJQqLg5gUqECu6yS8P+kxQmuzaJ
	aXlh0kxVJWPoxFfyU21DEwC7wEqA7ONnQAzDMleY7pXlRAfsdg==
X-Received: by 2002:a05:6512:3b09:b0:5a8:ecfa:aaa4 with SMTP id
 2adb3069b0e04-5aa60a36e32mr1542251e87.35.1780207161414; Sat, 30 May 2026
 22:59:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531034010.85002-1-kerneljasonxing@gmail.com>
In-Reply-To: <20260531034010.85002-1-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 31 May 2026 13:58:43 +0800
X-Gm-Features: AVHnY4IDBsTbtJSkQUbrAj53Zk8fcQlUiMvhkRCywse58mdAN72-b7H8kaeSAsc
Message-ID: <CAL+tcoC6gdWagJYKvW+0928xdkL3bLGmgCg2xegANbHBbMYjjw@mail.gmail.com>
Subject: Re: [PATCH 0/3] wifi: mt76: use __relay_write to avoid race issues.
To: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com, 
	shayne.chen@mediatek.com, sean.wang@mediatek.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, akpm@linux-foundation.org, 
	axboe@kernel.dk
Cc: linux-wireless@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37186-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,linux-foundation.org,kernel.dk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DE222614A2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 31, 2026 at 11:40=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> __relay_reserve() that is even though efficient has a disadvantage:
> it's not easy to prevent the writer and reader race conditions since
> readers can read incorrect data just after the offset is advanced at
> which point where no data or only partial data has been written into
> relayfs.
>
> ---
> The series is only complied. I came across this caller and spotted
> the issue when developing relayfs.

I think I need to rephrase a bit since it's technically not an
__issue__. I should also remove the "Fixes:" tag in patch 2/3. The
reader in mt76 tools doesn't conflict with the per flush mode in the
kernel because everytime the kernel writes a bulk of data, it will
switch to a new subbuf which is a signal that makes sure the reader
only reads one subbuf at one time.

What I'm trying to do is to avoid relay_reserve causing potential
problems in the long run from a broader perspective. It heavily relies
on how the application handles the logic. To be honest, the current
approach to reading is not efficient due to the arch of relay.

In this case, replacing reserve with write is more secure/robust
without introducing any bad side effects.

Thanks,
Jason

>
>
> Jason Xing (3):
>   relayfs: introduce relay_subbuf_avail()
>   wifi: mt76: mt7915: use relay_subbuf_avail() to fix stale fwlog reads
>   wifi: mt76: mt7996: use relay_subbuf_avail() to fix stale fwlog reads
>
>  .../wireless/mediatek/mt76/mt7915/debugfs.c   | 27 +++++++++----------
>  .../wireless/mediatek/mt76/mt7996/debugfs.c   | 25 +++++++++--------
>  include/linux/relay.h                         | 24 +++++++++++++++++
>  3 files changed, 49 insertions(+), 27 deletions(-)
>
> --
> 2.43.7
>

