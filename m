Return-Path: <linux-wireless+bounces-31413-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1h94H11jfWmtRwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31413-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Jan 2026 03:05:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A375BC0331
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Jan 2026 03:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A6443009F93
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Jan 2026 02:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EA8311967;
	Sat, 31 Jan 2026 02:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="26wN7Dwy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0924B30C36D
	for <linux-wireless@vger.kernel.org>; Sat, 31 Jan 2026 02:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769825114; cv=pass; b=HMkwLpNRGkVWyoI2IdLQX3IqmD/vhGvVUKXWsQbMTcNhnP8FpalGZD6FEpV+T+KwtCs8YRhTw1jASBam0If2oIUFp+wO4duNhgsYk+Roy908y14x4Np9NpWH1PHNknxiwQ1n/LBqaODVupwUa/dmY7C9Cu8u7nHs0aa+8C47Qko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769825114; c=relaxed/simple;
	bh=Et1LJjq+me05jisNBQoUpKr3ed6Fid9VeSP+iy1Nl3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gqZgYUXOaWK6ljtN3TPMkhW1J/Spp5018XVh1tZfLiTDgdZGIVs/6Otnptfsoir67MmhjTTBX0jKA1lPsAGcdjf+Gpt9C/cHt/VLDbPdICX5lcM42Nk9o/bQRIzPywzsY4YYOP7UkjeoD4VCquXnnQKkATTdjM01hjmKRfy4A0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=26wN7Dwy; arc=pass smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7cfd2423793so1789905a34.2
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 18:05:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769825112; cv=none;
        d=google.com; s=arc-20240605;
        b=k0f81iKojClJ6Y3Y7vSjKhu37R4XtWdFdj/YcVqMtLJoXApHP9pY3vmpV5/keu44l9
         Sw6YAXZXwdQBxO0e0NAjc6ruArjpuQlbr9qWl0e+99qfys/w9q0Ku74JB/6QGBALQcH0
         C5iGkBujO3l20+/gqecXMaIHNoubQTu+omQkz6zKC3AfeRGd/73z+ZB77qqbYnA5QNh0
         RgnffQAOHF+J4P/oJ9P2Jv2XoOXfQLDGz8MA41VrmfcXrFenRUPl7avVicrU8QeKmLID
         h/3Qqyh1YHTjjwiwiiBLCtaUjns8VRJBG+bcUxhi/5kuxYNUMtzRTQUad4mYfmVzW7r0
         +EUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Et1LJjq+me05jisNBQoUpKr3ed6Fid9VeSP+iy1Nl3w=;
        fh=tPpwep4bOd79UZOuCbRqI8NqX9adYJHvGlTFNmIIGWA=;
        b=PCq2nRXbSVwfLH1hGTJ5fgT1bRJ1+VdO5aN2UISH5Yy3BPOvok3Uyjg5FW8+h523pM
         V0Wj6/bjcv5+k+16+H1bGjtqRppCvNd9UMf1zl/xKFsbhQvDonb9Y37CuO8d5oYXikM7
         cT70m6SjXFVlEjbO5+7i8I4MEwU4iRNErJdXGFlZKzEeyQb+I/o7t8wEVT74+4yFPapB
         6CpUFEmiJcIHPu0B4LOHYkxB5l5SjyQUJdibG0kitV08nW1V4dspaxYR29eUay1dmazb
         85/Y3yiZeni6rG94OI5GZRkagjFru3Y2eAACFMakAVWgGzm7TB4pLqJgyUgBfMjUZ7A3
         8XsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1769825112; x=1770429912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Et1LJjq+me05jisNBQoUpKr3ed6Fid9VeSP+iy1Nl3w=;
        b=26wN7Dwy1eLvVH8VFs/OKnvVlZKZimdzWxBPrIcnsmQ8wKYd5fSxzuOr33nTuV7WqX
         6REbBMr+zr/gnF9LDpkFJF1THN1gRCab19vuBwALV4FcYUnvfxNr5EvWl1uMTut8dmtR
         ZagxFyTEkpnQ8MSQ17+/H4WOu/t97E5kpmZgO/dIIsqTKExR9K0+QNvwAA4hcybQpUuH
         wKPVspk13RE6aMo1Ql2yAPIA7peMgijseNDWrgHOklyUcW/yPTGI0GZIL8VS/3uwe8K3
         gfx5fuCb6jQOmjZ7E2qnTQ5x+sahdjXL6n7osxVXRyfRgsqmhSzu/wA+/Uh0MLwKY+EJ
         XaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769825112; x=1770429912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Et1LJjq+me05jisNBQoUpKr3ed6Fid9VeSP+iy1Nl3w=;
        b=kMZAf/cciDaZGzkJ81ETxfyrdYBujxgFoDnJxEHSXZ+FHy6O1VxHhbbrZQX6ok7pWB
         QaGMfBJMottnQrLgJA6JoKLhDxV4hxHtya/kg2jvA73sX/e7fJbMHvPCvQsfQTUQmvZj
         QKTAPgaQjSOOqN33ZvypBg2PWYTX0lDgIsDXuFwiC/8gA5cQWcXZgNIHs4YlcE5/+gGX
         sFrDrQNI/7lXmLReH8jj+3Ldf/KYjVuSyuuafPCvCrgbfo+T+cfER42G6qIlH/1+0GNa
         YTYmRH/wyO+QpipEixPtakZem+QhABA6ckgN+Q5eMRYx7kxDGsXIIZYZ0umYB5Wr9oqB
         HViQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY+v+CwGFN57G2p9QLVb1KSnvFtM2HMi1EH9f5dghLU0dvg0yjTppFd1hcJkESRS7Y7kK2pyaWuSPrmosPfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDWrGDZF+2dp7MdViDODyur2eYR8lH3qABZHKZwq3wYFGsXC1H
	jTQRHqok67QugEtwv5zaXuJw1NBVuxSwaRU8hzMN+2BdMwsGBfYfXqDWFBn4l0b2YPbvuZXNpuG
	tcwmYCRxEiw64oxtT8nWSqSYz/UJeBJWg3vY5L9ovtA==
X-Gm-Gg: AZuq6aLMhb2mfdXW9xo9FwaG/RE7Tr45QJvfK7pUUehG0wt3QnbkEYa97b6NfAy9f6l
	HThuXoZzziIYlIlKBsImdbNq2lg9KG2okPb53YefkwzfbHggpfeVdjjN3Ssy3NhuY6F69sfxZhb
	s2fWk2LVwFV7Uqds6PA5F2qQMHWpX+YpHtYc2amPsFoy47B2KOLKFCX0xwdM+5uRTTBmdPigT/+
	TfTw4q57TYbgSLEyYUZhjxf9UC5wdqaaljQr4Rr0jXR65QQGVsjb9F3R1KZy7rd5zs7lasy5o5b
	cWS6Xhb67GQl8wnAUduJ4WPc4nuyPfAZ6ZmbpRBJ4L2fFIizaEZ14U0giBI8XQ==
X-Received: by 2002:a05:6830:3698:b0:7cf:d642:d36c with SMTP id
 46e09a7af769-7d1a52a7495mr2787735a34.2.1769825111961; Fri, 30 Jan 2026
 18:05:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130032517.173590-1-n7l8m4@u.northwestern.edu> <CAGp9LzqQ45LAeeG1Cijs1QmtzBjOmML_qY=9Y5zH8tYmZeQWZQ@mail.gmail.com>
In-Reply-To: <CAGp9LzqQ45LAeeG1Cijs1QmtzBjOmML_qY=9Y5zH8tYmZeQWZQ@mail.gmail.com>
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
Date: Fri, 30 Jan 2026 21:05:01 -0500
X-Gm-Features: AZwV_Qj3ZqdJVfOqPn3A8gLGh5XdNUoxV_dzTMgg-iq3V96ImWZgH2oWndFPTiA
Message-ID: <CAMFT1=YkqTrgVTmnf1YLQ_djk-2sU8VpDDDbw=TFBzoWs+MW9g@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: add missing lock protection in mt76_sta_state
 for sta_event callback
To: Sean Wang <sean.wang@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[u-northwestern-edu.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[northwestern.edu : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-31413-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[u-northwestern-edu.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n7l8m4@u.northwestern.edu,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A375BC0331
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 8:37=E2=80=AFPM Sean Wang <sean.wang@kernel.org> wr=
ote:
>
> The mt7921 / mt7925 .sta_event callback already holds the lock; this
> patch would cause a deadlock. Suggest adding the implementation to
> MT7915.
>

Thanks for the review, I'll add to MT7915, and send a v2 patch.

