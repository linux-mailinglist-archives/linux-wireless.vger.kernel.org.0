Return-Path: <linux-wireless+bounces-33531-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KO8BsqXvGkN1AIAu9opvQ
	(envelope-from <linux-wireless+bounces-33531-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 01:41:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B152D47BF
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 01:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B17E306FE22
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 00:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF493222584;
	Fri, 20 Mar 2026 00:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/bBQnQx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7577D1F5847
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 00:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773967303; cv=pass; b=PusAjzO23VbzyZSu9AgCbR99Y0YwBbv8nqQapvE5gAYiqzYWq9yRtL4rWwXYT8vMGdyqn0pz+BtebQCMttmz5HsQXvsoGqOXf+8Gb5ZPmguxmBJqkCe34hw2mCg7BUnk8g+kZY9j33YRrd5Bu7ZohSpNtLUBu/nOhq9s3yFUtvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773967303; c=relaxed/simple;
	bh=I0oCFLUCbjXYDU9XAxYwhJSxv6GrX40yQbmEOJDblvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PjPswp9k5tXLqy7gQ0mH0luGrRrIyC/85hdawtvTC/ZMnkD7WRdkprhLgMo/FjLz6gEF579yZhzohw+gLiUW8nKya/pze9HO9NgK8C8ght5hNH/TlkTNfPwBZuilRA6EsGiYPLFdpWrXMHVe6oVit4XYsnyTAzqWlwpmZESC53M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/bBQnQx; arc=pass smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-467161c4ba7so991992b6e.0
        for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 17:41:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773967301; cv=none;
        d=google.com; s=arc-20240605;
        b=WtYZl/QmYKVe1+f5RqCUaxLRDGBZBeUfTl0H1Q7RLZeWjnYLgaV+9QS36TzSanQyOA
         q3lom7EM1lEEoSJtgbvTLUvKMcPeFlUFxxBtGXvFCBYHAG9JCEud7NEEzepbW9AKgvQ9
         hLBlafnvMjSmfCMFHONJXKlNVf8A55f091Aj8xAnzhzw2TUa2TiLYHOk+2tl5W+B7KZF
         1D5qg4+NJPDmX5lmfAZR7B85ykb0G9Uxp4htYie8UxhbAO6LQPsOXWBwB9FxoU7FAFB8
         zYIqLQ8QZUprk4LpCigERKL5QH+/xbLJqVbCQYYHB94O2iLlLXQwrdM+swPzueEE52sM
         2LXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BzErQot0/zdrjb/Mn2QlytuNQv1XXJau0yRhppIVFUE=;
        fh=fFUQ3bDSnwWYL/1dqZwPKYywXd5TONRsAevI/mvHYbI=;
        b=idPJztH8/j9DW8YlFC4zasasKP8Sd/R5Ns0aZLQxnTh5M5YVpzt7uLyuqL0H7XarQg
         RAdf8pjRRVhX3RhJqUEQ+4VXNY/qChLTSpbrD3/sVnb6n8vFKq5JJTpm6vGJecX1tQiQ
         oMMp9feGY2iDd63snYGm0wMQBeFWvsxcTDlTUsC1MDiIsZfiu3c88jX6VDPQ9txhcdaG
         C7i/U3hr+ADyNHnZQzrExQINj9gAjseMLtc33DVeqxUYaOwgMjPGut6GCbIcjm4U7vE4
         dZNzkYO86GIO2f2TmRbs1C2N9pLEuGIYX4/HsmE/u0POQ5TfTdbVhbd9UFk/38wroAvk
         sJYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773967301; x=1774572101; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BzErQot0/zdrjb/Mn2QlytuNQv1XXJau0yRhppIVFUE=;
        b=P/bBQnQx9wiW3a3rhFENvPugZrYW9E8+UzOzd5le9UYeQU9FcF7bpPBSA/RxjOg8LG
         UJz2J/WYIdkpd+Sc+6BGdLAxmd8MQBInE2RNsPFkYwyoqx8F1iO88+T1GcA0Fyv1ZNPu
         f7c6ZIgadHY6OcHK+7REMzcDYDp0mwdVl39xiF/5vsHduEjQ5HOHpU6zEI0CCF5lFO3R
         8a1TFAhWg8NJVnr06KhAukX9n3T+btBuoop4jIthBFLnD5elZT3HoWjFP1/7p/rI1/Vq
         nn3MuY9vXoaWdGOUWLZT7tpunVEyzfUSjGiu5sftAYVs2altw1YXdpPOSi4iVyxcKTb5
         H8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773967301; x=1774572101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzErQot0/zdrjb/Mn2QlytuNQv1XXJau0yRhppIVFUE=;
        b=Z30a8FBYH/8tgYUom+DobxMUXjd0GC1KpPb9em2RtgLJPjdF3/OzJ86gkKpx5B1j/L
         KzSLts+H4020dnLCinO1cmKFANlGQfd/AA3Q6GOxwo/aiHGFMOM4RByVOO7WeHOeWJPw
         Wz6S9ficG+ZI9CqokMbgy6iQk6Ydtcq484PnPN2/YwuFswVQ8kFdpw3A0wmbpzqGx6RJ
         rmQSSTfIaA2/TyTJ5RY8T9CMX/pM0aDiCpI3BYEmtEHFy4QP4gX0qJD4vKpZrKnSv/wV
         c7xpIBWyxzfKEN6u4W/kPuEcJtUB+Kd6B0ty0lTgsXKVSX+vhm2SqWlP2UaAQMfPl+Hh
         /90w==
X-Gm-Message-State: AOJu0YxmU5Qk30GbidBZT+h1c0XB0wiJUBHDOaiS5pfNGqtlvxIS593A
	+ESCztiAgGiNVce1Zn3B0R1BiToHdewJYwjOwM+HJ16p5yKpk51Orw/8YDdlA5zKLRF6lAth5qG
	OPN7GsmeaXSWRIt8WltDTqWnhqJKkgaeUw8skVV/gRQiD
X-Gm-Gg: ATEYQzwWHzt5Aafh1vxKImJ6DQtSVJy0JtHTrnFM2qR442KelqA4BlL3DgntAAZYrTO
	8Fy/Ui7UCseHGtvDdrJQRsC4wrKGRWb8rtHRPeyfKkdB4ht5nrO8F+SojAFYK5cYQqX6mTBg5Lw
	4JHmSsXnJkXeuhz63pvLro8vlljagIXm3KCHGfMWqrKcQaU9D10r1li3t5WJW3U7B9l1xBKLRJ6
	NKYX7/bwxa8qwuS10+jDourcigHZ+jVRNd9xMsr67QmZz86RPMRd8NQpL8Xk5VrY5v3VRm4Ezdw
	inGVuvvf
X-Received: by 2002:a05:6808:50a2:b0:45f:318:adb8 with SMTP id
 5614622812f47-467cd76830fmr3159089b6e.28.1773967301249; Thu, 19 Mar 2026
 17:41:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <1e96af437fa24674b353ddb530b2d8e7@realtek.com> <CALdGYqQb=Vt0jjqW7k8RGMV1gczL0cg-26cHgCm3MmzBjezGMQ@mail.gmail.com>
 <792645eed36041f0b3df951f1b28a08a@realtek.com> <e6720993c8c14245981432cfa4ae902b@realtek.com>
 <CALdGYqQn8GGXXjZTsL+a5Mfdmw5HRYB2Jyvqq5M5SUwxK9yd_g@mail.gmail.com>
 <CALdGYqQee1sjgdBAPJSyb1gL6ksK4z8Uw_v3ANTnyXE+LXFAiA@mail.gmail.com>
 <458ed80e39734ea99610050140bb31ce@realtek.com> <CALdGYqQykO9ZzO=-+D17R_8LC=Win5nGN6-9zFqChtNEyUzEfg@mail.gmail.com>
 <CALdGYqTHz5Pz3uSGLbrVuNMWAXaqniUCuOSQACXUYHSL22ySvw@mail.gmail.com>
 <CALdGYqQ5K0iuxjjX4TwNLi9Km5O+YL3Y9r6Bwfk9BaiuV3BHPA@mail.gmail.com>
 <CALdGYqRYVxGbg+qRNUvRNr9V4f2YVZ7p=amwq1ktdmZVkwxjQg@mail.gmail.com>
 <CALdGYqSq416qqqZ7t+wG5fir9NWfi3578+brdaj05q-42Gj14w@mail.gmail.com>
 <CALdGYqSf66mBiufysr3tjm74A_w98LRN50fik0U9WGVvkBJ_5g@mail.gmail.com>
 <1bd495ffe57c47eb827eec084729afa2@realtek.com> <CALdGYqSMUPnPfW-_q1RgYr0_SjoXUejAaJJr-o+jpwCk1S7ndQ@mail.gmail.com>
 <e5f00d0a42994812b42df867718fa087@realtek.com> <CALdGYqRbkV7_w7WDiqD-vYMa8MUFV7nSYz-=q2FzotgLHRy=HA@mail.gmail.com>
 <cb32c1eefb614a8bb96ef6fe2c4f4989@realtek.com> <CALdGYqQ3tS_aQpmf7xLkaCG9W55ATQXP=tnRNdjBAG8waqg8yA@mail.gmail.com>
 <dbe78a09fafe4a0ab16cd691049896a8@realtek.com> <CALdGYqQ3JQgFvvjiqh-ck8UqUQpAoJ0zeUzEL4i4Un8qPmqxJA@mail.gmail.com>
In-Reply-To: <CALdGYqQ3JQgFvvjiqh-ck8UqUQpAoJ0zeUzEL4i4Un8qPmqxJA@mail.gmail.com>
From: LB F <goainwo@gmail.com>
Date: Fri, 20 Mar 2026 02:41:04 +0200
X-Gm-Features: AaiRm516uh2X9MUTqw7BqwQgnJSp2d99IHl6vw8hXpNYF5Qk8zfqeY2F3cq7ALc
Message-ID: <CALdGYqQuS5EOWCaeimr6PY758feF-DPo5i3XFwoQ8ewf4xnm7A@mail.gmail.com>
Subject: Re: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33531-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.916];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,realtek.com:email]
X-Rspamd-Queue-Id: 73B152D47BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ping-Ke Shih <pkshih@realtek.com> wrote:
> Not sure what hardware get wrong. Let's validate rate when reading
> from hardware.

Hi Ping-Ke,

One additional observation while monitoring logs with your rate
validation patch installed.

During normal usage with Wi-Fi connected and a Bluetooth A2DP device
connecting to the system, the following message appeared in dmesg:

  [180.420000] rtw_8821ce 0000:13:00.0: unused phy status page (11)

Looking at rtw_rx_fill_phy_info() in rx.c, this message is emitted
when the firmware sends a PHY status report with a page number that
the driver does not recognize. In this case page 11 appeared at the
moment the Bluetooth device was establishing its connection.

We have not observed any stability issues or connectivity drops
associated with this message -- the driver appears to handle it
gracefully by ignoring it. We are not sure whether this is related
to the rate=0x65 issue or is simply a separate artifact of BT/Wi-Fi
coexistence on this chip. We wanted to mention it in case it is
useful context.

Best regards,
Oleksandr Havrylov

