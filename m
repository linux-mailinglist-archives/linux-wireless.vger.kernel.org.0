Return-Path: <linux-wireless+bounces-33794-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QN7VLh0lw2l6ogQAu9opvQ
	(envelope-from <linux-wireless+bounces-33794-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 00:58:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA5531DDD0
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 00:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB865301F9CD
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 23:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042573CB2EC;
	Tue, 24 Mar 2026 23:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qy3F/VeY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4BA3CBE63
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 23:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774396595; cv=pass; b=I68F2RADVlvCVnKFfDjTdcij6KEpS6z4ZoSIUjsd3fXuNuHJjr1qXHurNYdIvfeTbg5XLNhLuewtFhSYQVGn4QR/pf4HaC//G1Jbi4P5YWCF2eDpa8UNG8lrLAsCrto2zs58mcQrhAvLZOF/DPUUYoaHDGuOZ1NgAkEt4SdBO4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774396595; c=relaxed/simple;
	bh=WIbMIvo4aod+OTQYNFdrgI9mR4RzQfiH2kBoFhq/28g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uvXiPjMQnzEhjs8z7wzYToqnNFyELTVAN7i0G1RkD+lJ+BEjqYC0qH544a8pO60IvLzsjUoiJvVVkY97sv+6B+9YfzLF2602RpFgDNXwD4zVNYHW6X6zWDBbSYKxKkNldTd4RWg5WUaavjZb5aTEO1ffkvys9KzzMWCMnZ/Bwt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qy3F/VeY; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d86eb7c854so1935812a34.3
        for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 16:56:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774396593; cv=none;
        d=google.com; s=arc-20240605;
        b=KTtdIjfWC56+hgzVzwvJmjaxajnmu0dys9GoB027TZp5TcRqYSuwaHpOuUMfaIF1jX
         FWcTSogE3ppOwr44cSq/ifGB90h7ynjQ32x4LhN5iJmNxIJwBIYbsjhMA86t/6YhVSQJ
         tptNjrV6qFd4E9cRwIWV6F76pANKnw3tnvjhLszAbDMbr/p00U5502wT3C+XKfT0VQeg
         fH5Uu91uMKjgJu79F2GNrAKDl3bwAXLl8s17V/dUYIt+5+oNOotjKu9S1lGgNde3tsmW
         ib60CK31tUAdo40agjwp+F/4XMMKy5B68E8o4+oDov8tEsvjB9XUU/p/w26nhSt9n5Cv
         eDVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=v2HFHx6mTE6L9tnL3K3v2yNICguQt90D28bKt6CxSgg=;
        fh=E0TB4y4LMaoFv6/Nw7x0a0BXVcSkrLpEywfy4qTdIUc=;
        b=f9wUmjrlyRzLtx/ARb9+1dHyNmJtQmKLBSnUPwsj/fJ6WJm9Bb9rqTInggDlRmc2lf
         OEB10+9fbZAfZrXjh598ikqxGrsIqsrIpGtlVMRC9zKXn4OLrenUIQhdDPQjjhGx79s6
         48dGWTk+L/KvwWh8RBWlvmDAxdw4LdnlLB9BWlWMu1e5PQPuyYQo3A2MjeJT+nenPuVa
         aneXDiEyfz9mP/gB5m1MPJTrjfZQHnaKL22x0TsaQjnwtgimjxMK7Fdbj1kEkLB6Pgt2
         feiAXbi7EPdbmF803BnuUiDRyKBLZctbHMAiilK6hhtwee4KcvWXd03Tuf/r15ugAtgL
         HGlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774396593; x=1775001393; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v2HFHx6mTE6L9tnL3K3v2yNICguQt90D28bKt6CxSgg=;
        b=Qy3F/VeY7uTjXgYssHxriWpFGZrLMtw5RgWoa2hgiPvmzLsciMya8ybOUcLRao9ZRh
         4J6pwhz73gjiXzDiQFccy2DrP22GQnN9a4SC6j0qx9hAw++Q0HfwfBtQp5gbz4+j+hx/
         GYV3bin1iF+knl0b9c+xWUE6qOa0F/5f20SpOeh6Iw0uVfNPYPRWr035aC1aeTi/YsTO
         /bEqsTs68eRYpuR7N1ffYOhYseqWXFIZLTxcv7DF8X0N3+V1uFTlUNUEKSkvW21NJumg
         6Qo8TcuIUeMUEasegqr0doqHMqCrEdghacqijWFXeXwXx+JoJsMVeRcSWxPEdvSWnM2i
         KR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774396593; x=1775001393;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2HFHx6mTE6L9tnL3K3v2yNICguQt90D28bKt6CxSgg=;
        b=A85KrI+ndM6OcBmaIJ/YPGSI81gtK0C7Q4XmCzvor3XrwpIgkqpknb538CVZ9kZhAq
         KTDUuWo46R0IodTCk3ndYV0j/Zg7uw8etcCSLOHMGW/JxcV1oYw30oTWfjZ4QzoP36xr
         egvQJeq9S0DK4ChPmv8WMRqszSWPR+gWOe1sYYlsk6M3odj9DvCYtKaHw4yFvX7ZWcen
         Pgwr4yErwE60Xy5DYhMIOtpXKSZcM3QzQlunPpVWlXeHhs/SfKfWjfbVnUy5KNYdvCha
         bo87N6DDKHNuXSHkj5PeP/efPPHfueuXdmCpkDAvtjC5PYalerGOE/djbx6dYsOuxM7+
         Bqdg==
X-Gm-Message-State: AOJu0Yzf0HAZyCtv+ktkai1tQGUkB6SHSaz7VcAxFix0Qy+9xHPthcxv
	fjKf2lGcYR1/V3Xoyq9z5nYIZWzVxY5+evt5fgkzO0SE3z/Guki4lKwltSxl56FpyQTaWY+9tOZ
	LcZ3DkNNX5YL1SSrJUJSXDfTjFF58dnuyZMsg4WvWmfGd
X-Gm-Gg: ATEYQzzYUmVaAApjc3wOfppJfVqPoMMOy6noqDllc1KH5O2xi4Y8eXetAzbtWhcBSNx
	ePjMxL5bFtTxoaalZwbfksnC9wv96bOmBYStJbfYEmTg00OV5z1DdluG+/FP8LfTPrgybuaElKU
	+Bo0Wb527JO6ryR+KvZyDLg2r497GANizM9OcrTtai2CKVtI9o6FZui0dlPFvBz8XwuAafVZSf9
	slgnUr/weZT7gW6gahzVE1uA60To0fSNGSiw2sERfVExRGYce36ldPtH7xEEFPy4dyKeneypLUc
	39MrD2bN
X-Received: by 2002:a05:6808:50a0:b0:467:5572:ea97 with SMTP id
 5614622812f47-46a5c57e06dmr858751b6e.7.1774396593519; Tue, 24 Mar 2026
 16:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324011001.5742-1-pkshih@realtek.com>
In-Reply-To: <20260324011001.5742-1-pkshih@realtek.com>
From: LB F <goainwo@gmail.com>
Date: Wed, 25 Mar 2026 01:55:57 +0200
X-Gm-Features: AQROBzDT8nsydv48uFbiIzjBDMDb6utjSon0qRkfCrfOQiW8sMgZ-x2lFoBRnnw
Message-ID: <CALdGYqQj9zB6C_OBxA84dtvGQCHk0nE+Zd-MHw=XE5=m60qZ9A@mail.gmail.com>
Subject: Re: [PATCH v2 rtw-next] wifi: rtw88: validate RX rate to prevent out-of-bound
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33794-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:email]
X-Rspamd-Queue-Id: 2DA5531DDD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ping-Ke Shih <pkshih@realtek.com> wrote:
> The reported RX rate might be unexpected, causing kernel warns:
>
>   Rate marked as a VHT rate but data is invalid: MCS: 0, NSS: 0
>   WARNING: net/mac80211/rx.c:5491 at ieee80211_rx_list+0x183/0x1020 [mac80211]
>
> As the RX rate can be index of an array under certain conditions, validate
> it to prevent accessing array out-of-bound potentially.

Tested on HP Notebook P3S95EA#ACB (kernel 6.19.9-1-cachyos):

  - No WARNING: net/mac80211/rx.c:5491 observed after the v2 patch.
The unexpected `NSS: 0, MCS: 0` VHT rate warnings are successfully
mitigated.
  - The system remains fully stable through prolonged idle periods,
high network load, active Bluetooth A2DP usage, and multiple deep
suspend/resume cycles.
  - Zero h2c timeouts or firmware lps state errors observed in dmesg.

The v2 patch (with the added `unlikely()` hint) functions flawlessly.

Tested-by: Oleksandr Havrylov <goainwo@gmail.com>

