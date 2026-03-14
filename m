Return-Path: <linux-wireless+bounces-33230-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HjPExw+tWlEyAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33230-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Mar 2026 11:53:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAA128CCC3
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Mar 2026 11:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9534E3008098
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Mar 2026 10:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DFC3537FF;
	Sat, 14 Mar 2026 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLSOLnZu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6993537E8
	for <linux-wireless@vger.kernel.org>; Sat, 14 Mar 2026 10:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773485589; cv=pass; b=LNdBASenOYI3FI2W9NNjseHZsHKkmUCDCTR0o1x5CFX664ZUC0mR9ilSdRopWgqCiqBB5g1hxP4WrlBX/MzABDRiIVL6KwPic3ldoXgjb94PT+HzHsBaWDAIhG4Tq+5IipmMHm6NxFXolq6MZBPUQs234cZ2HhhqnXBHLnoLrGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773485589; c=relaxed/simple;
	bh=HmthXqOWlKMnZVAAjcUNeFjabsKh/rVpa+Mqjl+oo5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbHz2Je1STCZb+194U6RmVlmUXOC1J+/NCbtbdsVjHeBczpXYzRu/x/NlnfjwNhenJLfE4UpobPCziFJjgp6gPtxwU2oUPsAihE/b2fBoUZZ7aUCsBnTkh7AK2WdtYGT75LGf94jaFlA39AnihAaZXSmNqkK8QOah72k1o4nb9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLSOLnZu; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-415b23dd6e5so1045852fac.3
        for <linux-wireless@vger.kernel.org>; Sat, 14 Mar 2026 03:53:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773485587; cv=none;
        d=google.com; s=arc-20240605;
        b=VYBL1ce4Ov+H3WP1igT6lHMhO+KpL5oyYTob6JN1projhKHm368yCnrOMOmVAAOlUC
         27nSR7BIeDCd/ZgOWk94Nd4dk+fAapBwbq9jBTa/s8LTZHnvBdN/k3aQHljEI9wBPZhj
         QvVSYDGm2HnfT9hoxgsIWMXQ1zuTdoRlgTSBy6D6U46EoxRELfOQWJajHle7TSt+Cbyp
         vj1q9Uu+BDspc01JzqqTo/fMTlx2CgT13TDc+Zi5XT4YYCRltMMwA80utwtu/ivSYJr3
         IPMbBptc+nSHTDb4h4ahA4oQL3SfLJWOkRY5W5decmrLrC0pOcwRFitfbwLrOenKEvcY
         MXnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HmthXqOWlKMnZVAAjcUNeFjabsKh/rVpa+Mqjl+oo5w=;
        fh=fFUQ3bDSnwWYL/1dqZwPKYywXd5TONRsAevI/mvHYbI=;
        b=LSbuC1pU6pNBAYlgUxe8KFPV/z77qjTTztYn6CSUj39N+pkZTLC7y1gUDxlYw92ZAs
         RASZ8ObSoHnDCWQkJvf/L1IDmqhQan+WYiE+vRHBGy3njWHr2ePKucrj9Q2FifQErrZP
         4gWVv3FhVZdoiHX7vxTp9Nco6PdPNzxPvSHFPTUCbXIzUAAfYoGJs5pqB+zYUj+FximM
         MFzDBDtbyrbQCnYDADnCD0he05yH0XL3ZbEX2CRP0w4S9EGQPSqSYUnA3MabhXfbkj6A
         QvfUi8DpodhP8EDlKyANIcSCVbwxjVJR/AzlJvUd9YDZmxPNRHZr+cZjyARgNViHuy0V
         PYoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773485587; x=1774090387; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HmthXqOWlKMnZVAAjcUNeFjabsKh/rVpa+Mqjl+oo5w=;
        b=FLSOLnZuixN2xd0MZKskcWSU1DHBG0UwO9i1GS/sZW/cMQHaOoGyEX1unJJAAaqKPC
         OXqRsIm8zPXA8cnI6DEW0jqQojcxGBO9gUHDausLjNUyg1Ab/hx6wxCd2MiK9R8P1Er2
         PhXERD92ElydhErUll1OldncFZNrrhCKHtJ3EfWj2Jns/3XSxH1FgTy/Yb+0gQMNzKdU
         57Hq1n4RuhRQpJzZP1bo5rRnGuRFxcJVPdi3CZC/OdncD+1T1Mi/YClXt2KAK9wWX2WT
         sKC4rdgWbawqFpDabKwa0T7WCpOt7nHhLG0QLIufvztRY5ZaQBisKQjW5qBYWJlgdfqU
         uwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773485587; x=1774090387;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmthXqOWlKMnZVAAjcUNeFjabsKh/rVpa+Mqjl+oo5w=;
        b=XGtKeX63KFPkgyF45raEp8u+jHPT3FtkmDmQY748wUVHHAVDKMjsuwwYs/JI0TF+HI
         fUj4dSqWiYMAFukoG+3gpP5v4vNu23nb4uWUU10Q1OvUDvI9fDuGO2Rc8M8nILPRIEtp
         qrG/VqZ3nv5fjc8xvt97+k3bQ6oL75Shuw+L/1q4IokVooQHBATfZM54A7xmFcsxOv74
         yropT8qZYq75aVOvfeUN8QAeZ0Pg5Uocd8OrD7O3OfTjQRobfTndfCHzO9ox6lvYhEvQ
         e2Ed/zZbltGRCP72oME6JmTB+jp35ValktcW911lTRQZpDMVX8Uv7kONSQpo3PNuPfR6
         SYqg==
X-Gm-Message-State: AOJu0YwEZ5jrheXjLOA0XukVbgnhXZ8JglBWD4fAeN6x/fdgU4snOqUf
	GXpgiLr4Mr0CeisABC0eDxafedKrweGjCfwioWcOHmEox8LX+Ty2fqbUZyMC4HL+kGtUUr7JV7f
	6R+jESnfFOgXhv+8Ipc+TbHUt81ODD6g=
X-Gm-Gg: ATEYQzxCJyOuy4kX76MnHlrmFqmqF3Rfbkg7pMHqouqDmh7+BKrnUsCnKoC7JUsxetU
	Qq3nA1QsTlvLDd72FW5kfDmjBX1kZ360HrQafI8aSsooczxvw3JS5Hqx+FJHdRA+IO3/G9wzs3F
	k12gnjhjShuqHhzqfl7ziacGfPLjmxPmYzbVKwpFTUpoawaG4Js44MURTL3Ji+IQvh3tPVgsDQo
	SJlgm17H9+t7Rme7/csydIgMmVOUOG19oIeReA8b9a6tWmQzTlZ/bNnQqPBmMO2UbCoCYgOpUDD
	2+GBdzZOwyZhe3fswQ==
X-Received: by 2002:a05:6871:741f:b0:417:6279:37c2 with SMTP id
 586e51a60fabf-417b9058482mr3173993fac.5.1773485587450; Sat, 14 Mar 2026
 03:53:07 -0700 (PDT)
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
 <CALdGYqTHz5Pz3uSGLbrVuNMWAXaqniUCuOSQACXUYHSL22ySvw@mail.gmail.com> <CALdGYqQ5K0iuxjjX4TwNLi9Km5O+YL3Y9r6Bwfk9BaiuV3BHPA@mail.gmail.com>
In-Reply-To: <CALdGYqQ5K0iuxjjX4TwNLi9Km5O+YL3Y9r6Bwfk9BaiuV3BHPA@mail.gmail.com>
From: LB F <goainwo@gmail.com>
Date: Sat, 14 Mar 2026 12:52:31 +0200
X-Gm-Features: AaiRm50RtPZD3MBW8TqBSl8WjTh_vaMj1G0ubfohnNWl25Q3y8nJ42rKx7QW5VQ
Message-ID: <CALdGYqRYVxGbg+qRNUvRNr9V4f2YVZ7p=amwq1ktdmZVkwxjQg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33230-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5FAA128CCC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After extended testing with your DMI patch applied, the hard freeze is
gone. However, with ASPM disabled but LPS Deep still active, I observe
periodic h2c timeouts during idle which cause occasional WiFi
throughput drops and Bluetooth audio stuttering. When I additionally
set disable_lps_deep=Y, all symptoms disappear completely. This
confirms that combining the ASPM quirk with dynamic LPS_DEEP_MODE_NONE
would be the complete fix. Ready to test an updated patch if you
decide to include this.

