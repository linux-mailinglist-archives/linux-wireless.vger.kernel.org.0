Return-Path: <linux-wireless+bounces-34812-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBwyDu7J32nVYwAAu9opvQ
	(envelope-from <linux-wireless+bounces-34812-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 19:25:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5090406C66
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 19:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F24931282A2
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 17:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7463E5590;
	Wed, 15 Apr 2026 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAQT0wOc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6554D3E639A
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 17:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776272641; cv=pass; b=Ji7uEqcMX81GYUfn4EQxiTnI/C8i1mSYUa6i+SJBEwmIAq3u1KoLGICUs9oaxc1NravkiSQSPkqbAepDCvEOPlY/zoRWAbE9QMj8u70PUvbbCLs1gRItxbyjJqjvJjKooRjaYEYlHIwYDzlFifIb+o0xbAgxeEIlvscRn3bj+n4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776272641; c=relaxed/simple;
	bh=S5NhDLLih0xWHY1USnTam+lNuj714IEk59kE3isHgEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EXj76kEmxPKY233aE8PX1XfSJIY+QqSK9LC66RB7/1LkzmXA5vQlv6CNcN95Vbyh+PdrJnniohT/dF3gvIa3qX1UwnllrcYpfKgsBOyaYBJpe5ACgu/bc+/NOwCHxLiZq57drjOiGMobDn5pvgl2iLBVUG1adlCErNfggN/oXO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAQT0wOc; arc=pass smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d86eb7c854so3483522a34.3
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 10:03:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776272637; cv=none;
        d=google.com; s=arc-20240605;
        b=E5OEQTpqWQDmQG5IKnxXh1ImolP3iH93hlKz96ytHyXmXZrFqZqS35dTWOu6jLRZuy
         HBHmsSZr5VyMsyn+p+6C7eP62HuqDJGY7XkvsimSjVg6M6i2KktMnU02JqR1sELtrlAS
         EQblQ+Bzu/TnRgsUBgYmkmC9SE9lHHOx3gUO5wkQWVlLSdop67kubxldGP7Ad54AZcEv
         jieWl0FIAQIOIAiecSypYOdweuR+KJy0jYD4JXtFcRfoqnLPQheO0RWobvVU9odrrRiG
         la1JWpvm0aM9vmeTaz8CENFHhY53imwPa7O0HmbbgUwafJ/FsRS4pwclzXSYzmIwGscv
         exaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=S5NhDLLih0xWHY1USnTam+lNuj714IEk59kE3isHgEY=;
        fh=rXjh9mvtsYw3eG+YQ3StxTwY26w6ijf+9wcS0T7g+Go=;
        b=XnNcPGH+wDXA+MHkD3I+7rtNbVWQ+pZZpcWrGRyiXbth5WwK0a784SEtG8TMx8WvRN
         hogiPFoim6nDlS1KGo58BuutVRTNfMwNaySx4GI3iPye5zQPvIormvF5yRm1nz1nU+gF
         ffZPKVMkAQnoc9KuowTZTeXj5OzDPhsq7Am0bk3qQtOWLfRsNVrQBqZdNPlkGP0TdPEm
         GliYFEAvtxHMvCkvMFQdESQ95c4BP+Hp9RIVhBxzP2sLQaA3A8O/TiPejf2NRAEPCSeI
         2Xh1I7gFLmGuIblq4f2KyruPtoC8d3pBn6WhK4SpjnOwrsuxocI78YCwiQMGl5PCEXuD
         jm7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776272637; x=1776877437; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S5NhDLLih0xWHY1USnTam+lNuj714IEk59kE3isHgEY=;
        b=aAQT0wOcuQyxZAPHkoJnJ21zRkSFAPeHa2ddRAt8R34e1GxvFi/ofe84n977SR0H0N
         9OBUk5ue6lD3pDTFAkFXUHkBXzkdZYD6fClVXaomqVH+/FkmPPC5WkGqeO7mz4xR3UOM
         WEATORc98mPI3eJn6IZrOMIRXZ6EFZdwdOHh8iSi0SnhZ06F/a8p7W0eu+DYgsjAzF1t
         H55GeNUmtrjZG8Z8Budno5pMjuSIkGNxTdR0UUk2ojdvPoQBxltIiXx/rYHOEb+FMu8Q
         Ir458E+qOLMKoZ4T+2649ZOVYmawTnxXHsE+ifrwQPBBLh8jU+HQYclOJgDucZAcPUSg
         C6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776272637; x=1776877437;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5NhDLLih0xWHY1USnTam+lNuj714IEk59kE3isHgEY=;
        b=QwOQUjo5y5IBJ6q6PYRkHHyh1ptR5CMmBTFTV6rG6CSSAFDSjZLQ0LD9NZrbhNTSZ8
         hyXDITIoi6lYt7D9DH8nftJ6IigqqbwEduY9MEWYMt7CJEYBZo216UfsdhNFqh8N+Lg0
         fS1XpOEvkn5XyWovCjjVlGH2T4TqAOCFzZxUbZbNOHwqNlrjsQQ2scnWU+b7rBGPnHnR
         aRgzFZWtaEQnetQkpHw1fuid41fWsQyV7YfiQctokum/+2Vga98yhW8XcVYgiI67gMCT
         lDi98xBVRoLvuWz4PBWggL6EAYqW2ALOReMd3E/rCPNFmTnWeJvd6mlTuwMN2gpYKoGW
         doWw==
X-Forwarded-Encrypted: i=1; AFNElJ/2U20bmo0N9Lwk9nHSm6GEnbXhKlfClEbTnDYTpOo3hD8++wHvcPTbftwg/9HTAP57adMcqZxC5JWlabIMOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdARSF4I2Z5zLvoWCO1wnEuBQsqKE+4RKhZ6ZLXDzK/dEypGZn
	CbIgZkkH6vBNrWBGeazerxflaCxlqHeylUgU+kDt1bD6vS5y8m/boQ+NrlRK0JacDbLsfXBn87g
	PQFraRpXaNPyw3VQx9KPntOb1mKo1rNaCxb6YhjDgHQ==
X-Gm-Gg: AeBDiesBRfzsqgZu94pUdiydruhl4XhUPJbkuheMcPDSTnPuKZMXboSyiieW8giI4O8
	beBRj2wCvyCirfTQggPdvkfNchNq21pQxZuOKsNBn8WJp/QTPxqr2E9tu+/Eoi7L+wDUirrqbyQ
	UHONFn9KUmaH+wuuqgtq2Y+qzMdtDidjFeT00rIYYQOygzt/O6xaXZv36iJ/bv/QvcvbxPsC+bX
	aZb+oseNUnjwpsKRd3w1q3SfXv18p64hpbZ8UojZuh4nY6Ge/OYMloPNwOzBnlvu1YiwDrYF+p1
	MdbiCdHK4n5hAN2b+sk=
X-Received: by 2002:a05:6808:344c:b0:467:bfa:bdb2 with SMTP id
 5614622812f47-478a0400607mr11838977b6e.25.1776272636884; Wed, 15 Apr 2026
 10:03:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414194757.163339-1-npetrakopoulos2003@gmail.com>
 <20260415052959.14844-1-npetrakopoulos2003@gmail.com> <ad69b2f3dbc74ea6b9b1a17f2a77fbb4@realtek.com>
In-Reply-To: <ad69b2f3dbc74ea6b9b1a17f2a77fbb4@realtek.com>
From: LB F <goainwo@gmail.com>
Date: Wed, 15 Apr 2026 20:03:20 +0300
X-Gm-Features: AQROBzDgga_jZUeB1-sQh2Y0w7VvH3nw1Bq63jbFFR1fUFTE2ABRpoPIcAqLO9I
Message-ID: <CALdGYqSepO3xy9UerKXFfKLdj1BS1jGQh5YgkcSHrxYYY=n3Kg@mail.gmail.com>
Subject: Re: [PATCH v3] wifi: rtw88: Add NULL check for chip->edcca_th in rtw_fw_adaptivity_result()
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34812-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B5090406C66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 15 Apr 2026, Panagiotis Petrakopoulos wrote:
> Add a NULL check for edcca_th before dereferencing
> it in rtw_fw_adaptivity_result() in fw.c.

Hi Panagiotis,

I have applied this v3 patch to my local out-of-tree rtw88 build
(openSUSE Tumbleweed, kernel 6.19) on the affected RTL8821CE
hardware. The driver compiles cleanly and the module loads
without issues.

I am now starting a structured stability test covering suspend,
hibernation, high-throughput transfers, and long uptime. I will
follow up with a Tested-by once I have sufficient confidence in
the results.

Best regards,
Oleksandr Havrylov

