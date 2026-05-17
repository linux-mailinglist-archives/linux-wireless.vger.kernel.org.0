Return-Path: <linux-wireless+bounces-36555-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Ky8FzXqCWpavAQAu9opvQ
	(envelope-from <linux-wireless+bounces-36555-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 18:17:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C74E05623E3
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 18:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DF2D3006963
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 16:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469F72F3C0A;
	Sun, 17 May 2026 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5EOp738"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF051B808
	for <linux-wireless@vger.kernel.org>; Sun, 17 May 2026 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779034674; cv=pass; b=ahADgvfXXYY0oUjmb7UE9aZplQewJwZZA5d+t33B/iJyRf51G3FUVtJFvBn9TlqAwR1bjOnPGjLNlVFozOIF0/esDEiBIzMMBnRtXe217qWCMM7tcioPlU2aw5nLPU/iSPJNaKPi8xCELXJ6z0LYS+Q670h62GSC0XiwMOexRlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779034674; c=relaxed/simple;
	bh=w0KXSabjo5W2e46wliVAIC8ZMwNox3eEzxCIpucJh/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVWOGzHSZstaMAkDxNlL+giK9Pi3CN9MLq4Gndyvhh62tSpGRz9gKXzvSMMOfCC7BNvlel27kHy+RPODHQ0nqgw289fMBJswusZfS26GaSjA5BZeGDDRnnOMIcOJMsBRgnH4NCXd6vwjHwLXsb6ThAcJVtTrExnrgm9CiuWnZZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5EOp738; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-40ea36b56b7so1215196fac.3
        for <linux-wireless@vger.kernel.org>; Sun, 17 May 2026 09:17:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779034672; cv=none;
        d=google.com; s=arc-20240605;
        b=RMc1g2ZMPi70BF3eXhVarGm8Qv07dSURvvUlwhgLkHg3y3LA+jnoJ+7Ytrnw88GZw0
         1tShJb9gnohZ8WE+hPHG7ckJTVrEO5dRw0UI8o2GKnWv54diLjD/2xM6OhEdCfg17e2T
         We1WXk7bxnqKiULWJPkaWNz5Ea3Pa7sWhGjVNN+FhejUVGnFSYePYDGyFu+a8q5znWT5
         VEar0J94+U6LDGg6n6tk1M/5KnesFE2NrF1zS15vWFHd61vdUmZJhjlkpgYWdWILWCUO
         Nis+mAyOIlPxP8vNiYPAN17dfcMXu+KYGMqQSFA1iwOFLCOJr5vAlkbSmJu+pyakpEht
         o63A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w0KXSabjo5W2e46wliVAIC8ZMwNox3eEzxCIpucJh/Y=;
        fh=eE01mNjt8UjS+CA8KEnETPQCKHecU3/TI/JYOj6Om8M=;
        b=UMY2wTw5mBVpUiA0hs1GsvKqpJkTvqHfO0yr1vPbPTf79Tk+C7VDPheDRG8jtRYclw
         eS07cK3qVYJL+gk062xtN+DdZVLcj0BTs2ArrLNym2fyeGRI88lW2qS3wOMFWwaxWbi0
         8yEZ6qGOwM/Un0SFrJ7GzxI/EcD8QnHFty0MfsKpBOEUj9y4ZP6Pbrv9KJl9Nl39BPUj
         0QO0FBB+FOLbLNKUy8shR0Z9v2LOOCXQI6509dLN90m3w5jt1T9f920BJNnbQvRVouyr
         HgV7V1tBCULqh/BuHRi6g6ue00A015sbwcp1XzeAaI012fji3uLB8X0KHiuUwSljKrwD
         uV6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779034672; x=1779639472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0KXSabjo5W2e46wliVAIC8ZMwNox3eEzxCIpucJh/Y=;
        b=U5EOp738tKDuifGGJy4mHV0fPB9s5nFja+loGl4a7nOfDHEU3FKgfm5mZlo3tUO+vZ
         aeMcxtZLWD1W7zgmt7vHxF/OfJGfVk0eaejCDXkOH+5WI+m7AyE66ZEQc5GhxnbrM+Rx
         TEKdL1Z8N2DfyIMQpFT7GpIgiy6DkXfyQyDjrobLI3nqixLY2yo9LfxVvV5LFdkvwJYl
         2C62RFJHmEJPqz3x9rteFvZt8QRdJAA8d3KE2W2OQiaaJv6cnt6uy42Nex1SSRIpEH5f
         S+r1Uu0AYfL2S4gfgc++PmF3O4uGRhUGYo4UU6UPYdW6Yfjbbl/q0mAtRn3bILIfWrrK
         d7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779034672; x=1779639472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w0KXSabjo5W2e46wliVAIC8ZMwNox3eEzxCIpucJh/Y=;
        b=cwaizjdQSkU+iof2R2iOQ0G4OyGaXYpocbKeteQzCF557JqnDh6NNf4F4ojKUcKC2I
         ppKKcYjhQzcsziE3nhbOVJNf0v7d/TEEE+rOH9yY2uHqhJN4GD5ALqoj9EoUWhKH27Nq
         lSGs4Bqm5226J6j+ODEIImznaz6kj1saor9bzVrJGeDeCLyRyhNO7jrv9dAnvVZ/S5Sk
         m4bC9nty/2CSOelrgbssl6X1BqFCaBmvcFnbYsu9NMcFgjZ6ADHQHnlrBYpv+QbhKLoa
         0t71OLWQJZw0skSd/uW3NzPPx7++KXkE+4wK8Zp+uT0c3mkxpOcUWslMmFmsa+Oyq4VW
         gQwQ==
X-Gm-Message-State: AOJu0YxFAfliTR6SUYryHf48uQRzMc+a4iwDlPLlYadyy+dMQHMGoJep
	sjT5Lyou/bOGYhm7baH54FcH/ZFSK47cRPhozeWdg/8jNs0eZd/u8ThOknK5HnVlRE4207uR9ri
	yd6jP2gyzzRjHGzGjUsnzN13tZnky0ro=
X-Gm-Gg: Acq92OH/v6XzyOpINqSLi2vkwFbmeSTBkcebqFRHrumX7bjhA9ODOGuPYXaDS6QGt6W
	veyuBBMQKuXhpkvKi4Rn/hO3Svqr1weGRc+i0YKsziHxxG6agUlrXTEewQQkNMNW2h1OhtiHikT
	GBPSSGYUL4pcbbTuv3Zo7XoynIgQ4z64HZ/UBAG6uQsQgIl9pfvR93ERIqNsX9bjDIkk2NxFxsP
	25au+p3AMoVrCq0Olz23LOH30QR3CoxLzmdMrKM7w54sqjG8oNY6M9IRjvk/tgKnGKnUBZA5Mdn
	RoKiv6VS6bONM5Rr27wZo6h8/O6TKSJFzAP6tjwyQnVDOF4fnTk=
X-Received: by 2002:a05:6820:1889:b0:694:99b9:5361 with SMTP id
 006d021491bc7-69c94375832mr6606825eaf.38.1779034671813; Sun, 17 May 2026
 09:17:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a237ba9e-9f05-451f-9dfc-9aa8b11b7bc4@gmail.com>
In-Reply-To: <a237ba9e-9f05-451f-9dfc-9aa8b11b7bc4@gmail.com>
From: Oleksandr Havrylov <goainwo@gmail.com>
Date: Sun, 17 May 2026 19:17:15 +0300
X-Gm-Features: AVHnY4Ikc9lQ-DPZJxv7wm20I49ElIGKmf8bhtmkTBwbgeCKaQPUjZfL57lAT44
Message-ID: <CALdGYqQFgybQ3uHKKP47ocZDn7VRtqCKmMFdm8ikB18UNU=9xQ@mail.gmail.com>
Subject: Re: [PATCH rtw-next] wifi: rtw88: Add more validation for the RX descriptor
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Ping-Ke Shih <pkshih@realtek.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Fiona Klute <fiona.klute@gmx.de>, 
	andrej.skvortzov@gmail.com, anarsoul@gmail.com, 
	Zhen XIN <zhen.xin@nokia-sbell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C74E05623E3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36555-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,realtek.com,googlemail.com,gmx.de,gmail.com,nokia-sbell.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Bitterblue,

Thank you for the patch.

I have manually applied and tested this patch on top of kernel
7.0.7-1-default (x86_64) running on openSUSE Slowroll.

The test was conducted on the following hardware:
Machine: HP Notebook (SKU: P3S95EA#ACB)
Adapter: Realtek Semiconductor Co., Ltd. RTL8821CE 802.11ac PCIe
Wireless Network Adapter [10ec:c821]

I verified the driver stability through a series of rigorous tests:
1. Heavy Concurrent Load: Downloading a 1.5GB Linux ISO image while
running a continuous flood ping.
2. Wi-Fi/BT Coexistence: The load test was performed while maintaining
an active Bluetooth audio stream (AVRCP profile) to check for
coexistence issues.
3. Interface Toggling: Repeatedly turning the Wi-Fi radio off and on
to simulate the network stack behavior.
4. Power Management (S3 Sleep & S4 Hibernation): Forced the system
into Suspend-to-RAM and Suspend-to-Disk (via rtcwake) and verified
that the driver successfully resumed, reinitialized the firmware, and
automatically re-associated with the AP without any lockups or
descriptor errors upon waking up.

The driver handled all tests flawlessly without any connection drops
or hangs. The new RX descriptor validation checks work exactly as
intended=E2=80=94they successfully caught and discarded malformed frames,
completely preventing the kernel crashes and warnings that were
previously triggered by corrupted descriptors. No regressions were
observed in network throughput, coexistence, or power management
flows.

Tested-by: Oleksandr Havrylov <goainwo@gmail.com>

