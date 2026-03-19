Return-Path: <linux-wireless+bounces-33530-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HIJ5Er+NvGkQ0gIAu9opvQ
	(envelope-from <linux-wireless+bounces-33530-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 00:58:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A0B2D454C
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 00:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 317F230D5E9F
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 23:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2829339FCC5;
	Thu, 19 Mar 2026 23:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aM5wPn8U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02FF37F73D
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 23:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773964732; cv=pass; b=I2OIGX7tZWdMjKYx4sPZxcgvHNCMsWDhII/+F5b2i6NGvzP/kl+43F9PKjcZOYnxOSpdktYxc7ETnxFTIokfcj2c9Fg5hIq63TkiCu5oFWsWfuZDERn+c2M6bsxuMkm1vF0TRMl/kUNpTl4YoNuXFwvvJDpz8tlj/VJBqpSGm5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773964732; c=relaxed/simple;
	bh=qBjA8cX0wGWtIAHiuXxD2bFal/kkFcexgu2D8X6q9gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c3p82OtUV/W57IjKaohAu1ztdxat+ETtZ/R2hWQIq36Gwp40f1WJdAthFT3rqW78LVyRTASEX4cs9D8Hfat06rAktiFkPrPE5fdNQZs7K3P03VsIEMzQzy8336V9/JT1fc3Zpqo+TWJv6jTdo0y1HgNU0V7zXRW8wpU/fEhe8m4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aM5wPn8U; arc=pass smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-466f1c3c627so84049b6e.1
        for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 16:58:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773964730; cv=none;
        d=google.com; s=arc-20240605;
        b=QduqrNp6HJlry4QUEX7+kQJOrFiPgyY+sLrTCVfajUso7XsS3+04duhkNwq+WrTZ0h
         polFQJFjaWP3HtHdFVsoTI9elON0KMOs44aHf5kY0QlhezI34oCaWN30KIMdu4GDwqH/
         j9gmiw0+3MqtUacs1aLtEeHmmILGehtm6u3WD0B5VhH1C2Szj6ouqa5PdZtAJ/9hg1Iy
         EwDWLbh7PgC2xwsCJs4lpH91dVc6z3d8JkMs71+YlNArv5LKeclfQCO74Vm82pAG5m9C
         vcf+RbMzDKbHRb7XQXjp/G23PnICb53SKfc42BaP5GPqLcIDmwHI05BKs4eE1ztD9FPj
         RIlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=09dt1W9Q838znUdBswhk+Ubmk3etxZx0mf/5nmJBCXw=;
        fh=fFUQ3bDSnwWYL/1dqZwPKYywXd5TONRsAevI/mvHYbI=;
        b=csCFrVUN0XxmKBjRlhY993RszP7SgmuzbZgIttqcDSLCIybSFL81KpsWZyaGY/2Mh0
         Xhpi7T43xUHP7XMEjk9tRu9y1dMt7iG2kiNKiV/LyatA79VYAluxBnFDsAgl3Q6PUqLp
         tglEAE2NxyaonziBicLhocV05OaocC16iDxk72Ez/2xVd2eghoBmpjW+Kffe2BCQ5N7L
         1Q6iTowbP9yGlGt3Yo6AFu51FHYNUbkkKHgJML49sng9r4Ba3ib9qzqGnfS3mkKx8f1v
         WJj6YFwZS4ZDE+RWtCx8kLAEWZ52JTIhwhgvapx9QpWLueM7H24sEoiXjyfoTxNfQvxl
         EZ2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773964730; x=1774569530; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=09dt1W9Q838znUdBswhk+Ubmk3etxZx0mf/5nmJBCXw=;
        b=aM5wPn8U358ZWV98MWYEG9i1ag1b2G/WFrEFIrL2zBAEe4u8XP5Xs3S9X5FxVIvZXs
         prOHv7XXvWA5JdyGcKDcx7e+WjeXMSJU9AnZUjzxsZ4DyyxCel1bnlj5V9NWt11RJrej
         wDI0KRjVtbRs6yuyDA50Zb86I7g96PvPRt8YMo/gwkl554aih0ukCbZJmBuvvsKHqDxD
         Tbk9YDCWZ2fn3XKyYRw+SyDwx0WtxLWDBGBrO/vS4y8fTq5sy5GaSMe97gOMtJ+Apb+z
         GmG1UJeHL9a8xNrlryFKccTv0bELfOT25ilYLSEnphWenRP6rVrWBRGz+5QT3tfdFKau
         wz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773964730; x=1774569530;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09dt1W9Q838znUdBswhk+Ubmk3etxZx0mf/5nmJBCXw=;
        b=Z03na4E/qU2/qBJ91ujnrXOq3RgfVQk5MfYM2U6tPnbp51rvTRvCQi/Qz0+Hvsxx1m
         39aemLiDNJdJY2gxGGwYFbsEhmbfkIBh3R0RKwRB4d+3pB1WJ07RYMtx+q5UAWaWpqzm
         KT4mmYEqSYEF23p39iQvJKGDyI3ZD1RmKfQfZNUo/oFbJQpmzsJXqIR+HVbKaWmE9Ra3
         C98GGLaSVqyY1vq6mQ+x87iRW09LuVVZn5csHPm9hKxA3KhiLOos60FHWTWibk9f58bO
         tJx5l2MVQFriHZiC+sq+4wS6FaSuUVt5LjjFjfr54sJvtqy7zTzgmKOyx+sqr5mxNvp4
         fxgg==
X-Gm-Message-State: AOJu0YwA/R41MDvEnYKgO0AYknUpj/AXNANbl8kiDfqO3db2Z7ObqgW+
	L0P6B2/VAp3FI30yC30fUKpjsxncAsJ8hPoamsKBN9K4Hd+cDnXkO/hjTUGlizVfqfGnBtTs0gt
	TnwSnZvWH0ZPxiJppyxyuMaUq4sAV+9Y=
X-Gm-Gg: ATEYQzzqAMCc5PtFbebAA9PN8sHkoMdOB32TXYmdkG5b8DpUb+Ag6JWlHHbFOKnqCq2
	tfjSvSjizi0EuJXQ29YYfbo7IpXPNNrUxHBneGCwmK5msZNnCrwy3w49FP8IVm+mT5LLexkMHq+
	Xxqt+IRaK2TNHYUs/b728+srnunOSMevMwwnYhBaQ0CTouJOyKnJb9aJCrr7Olo6qfmYrlebR8/
	d64/U3tTZjuF504TJE5mqXNkMQkwJKOjkJn/uE4qqY+fvLUc6KKVQ3lHxwQTLSFVHkJa1FveCHA
	8aRGq/QXo3+XF59Oe48=
X-Received: by 2002:a05:6808:4483:b0:466:f57b:2ae2 with SMTP id
 5614622812f47-467e600292cmr768423b6e.52.1773964729647; Thu, 19 Mar 2026
 16:58:49 -0700 (PDT)
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
 <dbe78a09fafe4a0ab16cd691049896a8@realtek.com>
In-Reply-To: <dbe78a09fafe4a0ab16cd691049896a8@realtek.com>
From: LB F <goainwo@gmail.com>
Date: Fri, 20 Mar 2026 01:58:13 +0200
X-Gm-Features: AaiRm50uYhmZW-U34lUzJQ6hyZoENsUk8WmXyZJls2V_w9gd0LmqwFIaANUE7DQ
Message-ID: <CALdGYqQ3JQgFvvjiqh-ck8UqUQpAoJ0zeUzEL4i4Un8qPmqxJA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33530-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.943];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:email]
X-Rspamd-Queue-Id: 91A0B2D454C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ping-Ke Shih <pkshih@realtek.com> wrote:
> Maybe we should check the capabilities of PCI bridge side?
> I think there are two problems. One is ASPM causing system frozen,
> and the other is LPS deep mode causing H2C timeouts.

Hi Ping-Ke,

You were right on both counts. Here are the PCI bridge capabilities.

The upstream bridge for the RTL8821CE (13:00.0) is:
  Intel Corporation Wildcat Point-LP PCI Express Root Port #5 (00:1c.4)

Bridge (00:1c.4):
  LnkCap: Port #5, Speed 5GT/s, Width x1, ASPM L0s L1,
          Exit Latency L0s <512ns, L1 <16us
  LnkCtl: ASPM L0s L1 Enabled

WiFi card (13:00.0):
  LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
          Exit Latency L0s <2us, L1 <64us
  LnkCtl: ASPM L0s L1 Enabled

So ASPM L0s and L1 are enabled by the BIOS on both ends of the bus,
despite the ACPI FADT claiming the OS has no ASPM control. ASPM was
active on this machine all along. I apologize for the incorrect
earlier conclusion that ASPM was not active.

This confirms your analysis: there are indeed two separate problems --
ASPM causing the hard freeze, and LPS Deep Mode causing the H2C
timeouts. The v2 patch correctly addresses both.

---

Regarding your rate validation patch: I applied it (removing the
earlier pr_err block and inserting the new check in
rtw_rx_query_rx_desc). The patch compiled and installed correctly --
verified via strings on the installed .zst module.

I was unable to reproduce the "weird rate" condition or the WARNING
during this test session. The diagnostic module remains installed and
active -- I will report back immediately if I manage to catch it.

Best regards,
Oleksandr Havrylov

