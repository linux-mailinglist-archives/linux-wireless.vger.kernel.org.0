Return-Path: <linux-wireless+bounces-33318-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GhuJg6luGkChAEAu9opvQ
	(envelope-from <linux-wireless+bounces-33318-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 01:49:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A2B2A2535
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 01:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DBCA3027111
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 00:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F237618A921;
	Tue, 17 Mar 2026 00:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGmqJr9E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A956C125D0
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 00:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773708555; cv=pass; b=ImeK2pkDi86ZocSR9SmOp35+2ujwIJB1b4FdNEbcYvgOIKuw8gFpk+wzKOHejubw4WUJ98P/rS2TOfc/jihwA5CcMut3XMz91Z5q1vNMJoJQiEArda9Izrcl1FkaObMAI+wj76465pJzB/O3ZBW7ucfJHXEEhLY3HtVUFqDCkgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773708555; c=relaxed/simple;
	bh=ekQhPR0WPg+AXAq9YQnPARMf52L9x6dl51AAQkEkIbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJHe//zLVczOzMe8nqtSMXvZav9XbTz5Xo1U0vnKVHCH/rlO3MRF8fZGQYKN0qm8hlAkA0cnhJvNzx12qQaBHMl82MFghxkMJ702/+wg1CU/t8FQB0rJ7hhFz0jDF9BtItsib4i23NZpi1tcEmixgaA0hRTT05alippZBalzYZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGmqJr9E; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-417c34b0509so2575987fac.1
        for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 17:49:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773708553; cv=none;
        d=google.com; s=arc-20240605;
        b=Agio1mKgBYJrjnmsVLgAGe2NDVsDr0M2rv7PL+I9O0Z9XDMxNY1/eYcbrSc/DsRhwR
         RfB+d8pf1WOHvVZyDM1vO0fajRGOp985QMCFinVBmv+J2wnk0+afQ4jR0/+DIQys21JD
         nSCdPKHg58ASUDJo9PmYduBiW1Fckw5a1eaX9YWATrr3m2nAyDyuIBRRGh7mt5WLQTL8
         1LYBFtJpSadV1kBAGlq8rlK9IqLD9S3ke4MiiKt8mdUeIUzVYsCj/8BAv6b6iW95LY0b
         N7U6tax2OozbmrypZDyxoHGcxIllo4gbxYlcmxqZP5ZFZXl5HxucyIUpnu3xr8qmn0Fk
         Kp/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MG3iXdT2UZKfId50YtByQeiZdk9665ZRTobyPofHj4U=;
        fh=E0TB4y4LMaoFv6/Nw7x0a0BXVcSkrLpEywfy4qTdIUc=;
        b=caVXWymBwjmz73z13RtIqOeAP+sik3j7sV8NjkspjdMDXtfz4RCzdSQzfwl37cRmar
         xVKB45ccbMRZPRq40sTjoYrP1gsNLaXApNJP3VHxAvp2iQwrT1NYSBSzfu/e/FGvGCp4
         eEhh6K/JlMJWo73O49jQgJbdZb1MghKMw8YGcVoesrgn7F2DIIUUtIO8kS6IxlkJ6C95
         3YE9PSTs0ccPJX8GmwqH7n5xg2FJTgPKg1aLIikbkMKGCQiq9PbgRUgN3yg4hOAlEfX+
         edtfnaEhzMP3qjSO4ny/qpHs0mebI313tctowYVd3NAgEs5syu/h8ZR2hUjS9qu13NA2
         S7HQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773708553; x=1774313353; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MG3iXdT2UZKfId50YtByQeiZdk9665ZRTobyPofHj4U=;
        b=fGmqJr9ET500K/EjqKuYXtDH/Yt4rqX1QhYBDV7oXpKqYE3j0LgKzm/3ux7ZQb59lu
         1zIzNiPMP8sdNKIcW5egxEEKXnk4F7MpuyONS5inSLYox3thQRXFlzuVUGfHwMQa8bwQ
         IsH2AJmvigsYsG9hJCkvnrzkTAay1wBybvXAkuL57kukLAtNaZ1ukvw6QeHG57P/Ok6E
         OBL11J/dUjpE/3VBWS1Q4uvp1dRPpURL5YPazKbFSH3Q349pB6p/rxesAewzUswFtMUW
         0QQ4WuMrXscjmC7j/TXoIGHOxjCognvK091WZzI9e6qVSas/dLUIqJop32hujYrKR+Oa
         fKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773708553; x=1774313353;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MG3iXdT2UZKfId50YtByQeiZdk9665ZRTobyPofHj4U=;
        b=P+rQkxHvJxV5w31ew9jfIv0WWraikRzTutJ979zi2ZcFViE4ecU3AyNa7aLDYfxxVI
         8RD8phbvoRv8Wc6OJ0iOUNbagXHfWAA7trya/m7yKvC9UDKyinoWQLw0qgFrWQstyNOT
         AFDSkzTDU9m3LGdpET3/87mbT6243SMbkOtepCrQVOYlKOJUjK6fM7RFL5rkKMHoJJx6
         WAF7Lg6okT2P51/CdINYzzBRKkrqYXuYf9xTHXrAbEbiHWrtS3fJA9icZq7hxjppV9H8
         V/T9JUAHe9LXb10Mwj4AuYmePiA0bBHZxfPg5rpvt4hcA2Fz3szvtxC+rSSnl4BfHdTR
         V50Q==
X-Gm-Message-State: AOJu0Yy90OG9Nk6XR2wE6kvmUKj/EPA3sD3wjnqEzZ1H4dvLIX71X6B2
	vZmIqvmeFBKGT2k6EpN+vL3rpkEBAuCNlYFrPKfbxs89PawTLWmjymqW/yn9WSjGFZmXSqo+mXN
	IN2BkcIPy9cA+ujhuFLrHcY1Hwrc0Mts+52KHU7sNYWgC
X-Gm-Gg: ATEYQzximayPF+wFvjFBqSVaIa+qNkWoWOymviZWwl+sM53AKkx2NipVxQOICq/N9UY
	YMhIyLLaIbRu1zOdocsFT1hTFnaJda1F7TgA4gXB8coF0uMI6IFN4K6pFRZpKCYqyNNZgdEq+kW
	MewzIsBQgss5921nO+K+iebbbr5wGqSHEsNzLl9M1Pxr8k46fvO0cZ7Pae6tVzbg20Kwyd+MW2Z
	yapCdvl9oKuY07vvJYTtZ5qBllUHj1Sb4Znkvga2okMGuN4ITJZXjPXoUDecDph6/MHFvFNPSRm
	mLAQRsr/QZrFtlmB5A==
X-Received: by 2002:a05:6871:69f:b0:417:5825:caba with SMTP id
 586e51a60fabf-417b8c590aamr10255723fac.0.1773708553415; Mon, 16 Mar 2026
 17:49:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316035635.16550-1-pkshih@realtek.com>
In-Reply-To: <20260316035635.16550-1-pkshih@realtek.com>
From: LB F <goainwo@gmail.com>
Date: Tue, 17 Mar 2026 02:48:37 +0200
X-Gm-Features: AaiRm52-UcH2TGKblEs3uz6cFVUgtEyIfG8RKJ2SW-pYPbOKKNTbvqb_u7yjnLY
Message-ID: <CALdGYqTbH1NVW7HT8JaUJ2xay5190WmpOm1TH7YJP9LfoHoFLw@mail.gmail.com>
Subject: Re: [PATCH rtw-next] wifi: rtw88: add quirks to disable PCI ASPM and
 deep LPS for HP P3S95EA#ACB
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33318-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,realtek.com:email]
X-Rspamd-Queue-Id: 06A2B2A2535
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ping-Ke Shih <pkshih@realtek.com> wrote:
> On an HP laptop (P3S95EA#ACB) equipped with a Realtek RTL8821CE 802.11ac
> PCIe adapter (PCI ID: 10ec:c821), the system experiences a hard lockup
> (complete freeze of the UI and kernel, sysrq doesn't work, requires
> holding the power button) when the WiFi adapter enters the power
> saving state. Disable PCI ASPM to avoid system freeze.
> In addition, driver throws messages periodically. Though this doesn't
> always cause unstable connection, missing H2C commands might cause
> unpredictable results. Disable deep LPS to avoid this as well.

Tested on HP Notebook P3S95EA#ACB (kernel 6.19.7-1-cachyos):

  - No hard freeze observed during idle or active usage.
  - Zero h2c or lps errors in dmesg across idle (10 min),
    load stress (100MB download), and suspend/resume cycle.
  - Both quirk flags confirmed active via sysfs without any
    manual modprobe parameters.

Tested-by: Oleksandr Havrylov <goainwo@gmail.com>

Best regards,
Oleksandr Havrylov

