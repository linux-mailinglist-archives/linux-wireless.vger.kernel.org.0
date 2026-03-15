Return-Path: <linux-wireless+bounces-33233-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAlYIln8tWlN8AAAu9opvQ
	(envelope-from <linux-wireless+bounces-33233-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 01:24:57 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA81D28FA6A
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 01:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DF16302A6AD
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 00:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F6D1D63E4;
	Sun, 15 Mar 2026 00:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dE57daqg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C257260D
	for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 00:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773534295; cv=pass; b=TZHJ9VB7ENORY4yNNlzeZPkirtqIiPGRY6/n8uphucymWlGHYH+L8HOeDsc/eTvbUS/31OkW3zcRt/Sm+fkVc5OA+3B8cvaC46O70LwHnXo7s8x6c05Ad02bI3B3P3gvgGb1PYtDgsCSqvSTicNIp2KXM52Cac9amj2bQ7S/i9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773534295; c=relaxed/simple;
	bh=4xVOHYzfU0yoVdHovfIIGpVOKPZIDt47vjVdLmPvZJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ii1JMFh/FEwyqsfmO17YhshAGyZBCUMOXkoH6YqNN0Yae6ewz2om6z+ZwXWyhsYf5iMAZJiw1ITm2RrIJq7z93lmrc590j3DRiF3GmdRM1BgKMcl3x9vkXGNYBYRzyBVXbEVIK4IA0pDKQA3HIcYSrhbzkezdq7UllQ9OhlNn84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dE57daqg; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-40427db1300so2059975fac.0
        for <linux-wireless@vger.kernel.org>; Sat, 14 Mar 2026 17:24:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773534293; cv=none;
        d=google.com; s=arc-20240605;
        b=PvOHPi6T53ZT53ERP85geF0YQT+mXwIcZSn6el6KtriL5rApVmv94H5TP/uSprUh7h
         7XZZM2XJxUlwTPABO96KvNoAQMZoYk3KIXqdJjQpTXxFdnPAkrksaIx2A/mejrPwtOav
         v/8tBkEAm8YR4wN6ehklsEmIl3l1fsYX6HQPXd0aBFM0WkiGYBkAHTua9i3l0OVGI4+3
         Ht89t2iVuN6F5m5c59P2RQUyioTjZkjnC/6eOq7ZGV4L20H3kDM2mcg3hEq14dgcIXTV
         3UgL6q9v7E44eMbE//Py+7tYSnvzZMQk78d8pgbLpu3tskEa34+YjuJqHFG11PPcjgfu
         govQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BLWXWF569OWT0qxIa/LLbnC/DKXrVkUi5rPpp4vD54A=;
        fh=fFUQ3bDSnwWYL/1dqZwPKYywXd5TONRsAevI/mvHYbI=;
        b=YB8RNN0+4AXOF9rnSQUjFcD7Bsrhf4moZwPIO8ty7Dn4cvnUuZ5hRPMGvlZdiA+WNP
         RlM+pUDSZ3Y29rU0eAKgDQdlhjxo2FjYhl4TSg3kKBKqk3NIPHjSRkk/ENr/fB4IzPwP
         5JjHFrYLwB3HosaMmHIMHlsNIIxlXVlxkiXJAkdGyAe8T5zJYs4U1nbB+aM4DiqExkGu
         4EfSUObqxlNLndYyyU+yrU7bTrGXSgKsPvE56daG34IDVaz8ysTeRPjtVGGfVExflHXM
         s8IZDq4tsJ7JRXHH88N8/vZSweQg0P6pEthn6GSi6jbWo/QVajtOt26214yAPLm0N0ab
         nPxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773534293; x=1774139093; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BLWXWF569OWT0qxIa/LLbnC/DKXrVkUi5rPpp4vD54A=;
        b=dE57daqgUP4xTC8IzrW+IPqMwDSIAU0AkF1z9BnhshPyuCIpjv8jCeKiPhzGnxiWQQ
         BodiciXKE9ycHecZAa1HMyu7AqGXY/9UvlCaZm1KX0VQ1XFvNPrWM8l1YojsvNz8e95Z
         X2Rgnxw/POKc/N9urx6Fr2c8uvZVVdG8QUk5BIqtIA42h79aCOHch0DmzIBL/Ta4Pm/M
         zali9pI8CGGY08DSBtC9qJVXRFSr7/xT/bTTV9U2ThMB0Lsku0hvXULabIKdBRTsSWmX
         xP7wemoSFfTTEJhUTVqnYHED6VILc5CaTvPoia91AV3ckRTz2Q3LO/VjvCdzbUlbP4Kg
         pEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773534293; x=1774139093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLWXWF569OWT0qxIa/LLbnC/DKXrVkUi5rPpp4vD54A=;
        b=iR7rIZAhN4G0Cr0VyV3bQIOSe2F+XZ8qru2VhkspFF2HLE0HzhOznS027schead130
         zHSki/VS582A06SYWXbf5ia8BV5DdNy/xCd2NvMWXisBSkp58q6l/6XMgYUJIvSMMId4
         pwWGvZtRRNQXVSB2gkOSvhF9A5YF9iOvtwwgcwGX/dCxp7Wrmy8DzV7MJ+j9PyZNrG//
         emo9qhuj2mLxht0v7ROgoyJ1AhPkOPp0V47b54rAfziLKWdvcpIr5Qzd3iFVYMRri+Yj
         CyupQ6OdPmEfNg3sUs5/QQRCEkJCeypjKtHtHJ6TvIl29ttZrQQtpBX6qOdqo3RzCJ4r
         MtzQ==
X-Gm-Message-State: AOJu0YwAEaM3DoNnzqvh52xcYY55bPV2SGu+yr4MYRCRp4PfKJjW8GpF
	9xs2TrWhWw3W/nyMd3pYwuQRwolxPT8bdiTOJa0XX3lEQIzxfGSXvxzPxt9bcAVgjle1hgPj7Nr
	YCfSVG9SpqWSODIgbKhrt6MXVxVgCQmo=
X-Gm-Gg: ATEYQzy8TGfCKMKGIpseUGEifCupm3BfzAuJA7XI4aeMhjLLzNujk6IPkAh3JCgLlXp
	wNRv1KP6/2cZ8LDFmMOFVDzHuxcyTafLtX2QySrpsdmYIiSVPl18PeXXxxFHh9C0t5yIO2kGFT5
	ZmQvm8uUFVLdueQfSigdAgEbP8s7XydsLJIo2UrwjlH33Mo8NRMvY+NAuqv0kjGQV7ZoZZX2JOp
	4bHQ+D6ikX1h2zbos/h7gqLqiK4i9wFmDTdhu+YqRWhp3eJzq25VXRYLN7ht9dezI/IESONpYPo
	QFv+ATQ=
X-Received: by 2002:a05:6870:44d3:b0:417:3c76:6582 with SMTP id
 586e51a60fabf-417b9174e0amr5241069fac.7.1773534292770; Sat, 14 Mar 2026
 17:24:52 -0700 (PDT)
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
 <CALdGYqRYVxGbg+qRNUvRNr9V4f2YVZ7p=amwq1ktdmZVkwxjQg@mail.gmail.com> <CALdGYqSq416qqqZ7t+wG5fir9NWfi3578+brdaj05q-42Gj14w@mail.gmail.com>
In-Reply-To: <CALdGYqSq416qqqZ7t+wG5fir9NWfi3578+brdaj05q-42Gj14w@mail.gmail.com>
From: LB F <goainwo@gmail.com>
Date: Sun, 15 Mar 2026 02:24:16 +0200
X-Gm-Features: AaiRm50Nmft2lRhg5SB9CAXRliJc81c3yisTfslYkjODM9jZLHhsYMtyZ8WEn-g
Message-ID: <CALdGYqSf66mBiufysr3tjm74A_w98LRN50fik0U9WGVvkBJ_5g@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-33233-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: EA81D28FA6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Oleksandr Havrylov <goainwo@gmail.com> wrote:
> After extended testing with your DMI patch applied, the hard freeze is
> gone. However, with ASPM disabled but LPS Deep still active, I observe
> periodic h2c timeouts during idle which cause occasional WiFi throughput
> drops and Bluetooth audio stuttering. When I additionally set
> disable_lps_deep=Y, all symptoms disappear completely. This confirms
> that combining the ASPM quirk with dynamic LPS_DEEP_MODE_NONE would be
> the complete fix. Ready to test an updated patch if you decide to
> include this.

Hi Ping-Ke,

While monitoring logs with the current patch applied, I noticed two
things that might be useful.

First, the following message appears each time the driver loads:

  rtw88_8821ce 0000:13:00.0: can't disable ASPM; OS doesn't have ASPM control

This suggests the BIOS retains control over ASPM and prevents any
OS-level override via pci_disable_link_state(). The system remains
stable regardless, which confirms that the rtw_pci_disable_aspm flag
approach in your patch is the correct and effective method here.

Second, during normal operation I observe this warning periodically:

  WARNING: net/mac80211/rx.c:5491 at ieee80211_rx_list+0x177/0x1020 [mac80211]

This is the same location that appeared in the call trace just before
the hard freeze. You mentioned earlier that malformed RX data reaching
mac80211 could be a factor. I'm not sure if this warning is related,
but I wanted to flag it in case it is useful for your RX validation
investigation.

No h2c timeouts or firmware errors have been observed. The system
remains fully stable.

Best regards,
Oleksandr Havrylov

