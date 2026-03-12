Return-Path: <linux-wireless+bounces-33068-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBSDA+tfsmlmMAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33068-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 07:40:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 653BD26DFF0
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 07:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDA833068EF1
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 06:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A333859D6;
	Thu, 12 Mar 2026 06:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OR3OPxHB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C79381B13
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 06:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773297542; cv=none; b=Z5xqFC93fi4kabKY7kIADHOMiu1ref3EcOzAza87qIYtiEHn6hpCzxpJlX0iaVUAo32whgwDRzO8yF1U8X+dvahS9Wr5uNf5qeRjPZ7laN2MugLziLzngXOvO71adHrv0O6u9KHXBVYeaJJRheo6M9fWOF1P6LGo37SddgZM0lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773297542; c=relaxed/simple;
	bh=ExVN2iam1n3QcBJ0mimHMDanTA5hxSZ/H/cT/2H9azw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BbMprsEjmkL2xAgIL49ho7RBVuCCUbLQE28bh5MkE8jfWoCs2YDcVTt4KuEgGqz9CoP/ah45TC62xBB0VMu6aQfQIczLUfQF/GDj87pmmNL5DixAQansXqebmyproCbWCSfuWMGe8wA2/q1l1Zet22aZbzhKpItFArDFj5+xQm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OR3OPxHB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B322DC19424
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 06:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773297541;
	bh=ExVN2iam1n3QcBJ0mimHMDanTA5hxSZ/H/cT/2H9azw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OR3OPxHBF5ZYVMt5hbIzB8s2wu8EP5c+TMns2WLl5hFA3YlgBD5aDuCqzYefh1g1K
	 hi5CdvPzp0vlb7d5l+aJlm85AyVFGrbwjLAZpuEhxK0ub5bHlal7isLpLwt69J0Abv
	 dL96A7wduHHVnwrOi1i9O69quAe7CS/YRWExWWteY0vsb3GOOlzMJekDibrMXbAOIL
	 wJ6jSAGwOq/43CM9YgcAI4ujwYit3ZpZSebZHx/PkJfzBD52Ts3bsX0+xiFwrBlLPB
	 rc0jdlVqQfi4wF+xfgNyD6PGp8qiWNm/qyR3E6rDSeNdUmsgQXeDiGd2JOOAKdsoiR
	 9633fV3RvIfRQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a1307438ddso831466e87.1
        for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 23:39:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7L7+sc6XeC1/fhApONQusbZBg1aq7Wpmn79ZDm9lOcr09D2GZi+ohBPZK98kMzy0JZQE9FssdvksrDL6wCg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0jSChWbdBakDhOEjuiCnh0koYkutbJB7ke+11bzPR3iNeTmlM
	sVyqFWjayMZfD5tYLid0QTZJkAVD9hHMAPXDnhhZPBtRU1tf9qYkDPgnlFY1cIQga0tglM0+cMv
	0Cwh4Ip4fNLAXnWIUjL1UGj9jkQ3Ynps=
X-Received: by 2002:ac2:5d6d:0:b0:5a1:3e3b:9dd6 with SMTP id
 2adb3069b0e04-5a156bbe882mr1264873e87.20.1773297539984; Wed, 11 Mar 2026
 23:38:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130215458.52886-1-lucid_duck@justthetip.ca> <20260309215011.96403-1-lucid_duck@justthetip.ca>
In-Reply-To: <20260309215011.96403-1-lucid_duck@justthetip.ca>
From: Sean Wang <sean.wang@kernel.org>
Date: Thu, 12 Mar 2026 01:38:48 -0500
X-Gmail-Original-Message-ID: <CAGp9Lzp0LEac0DnAzs477fG5rmA+ZjdDHfdAPWccK3GKEY05rw@mail.gmail.com>
X-Gm-Features: AaiRm51yQrY0VV2R-uvLgQ9crAFkl7k7c9Ynnt3qjXWGgE-5kTG_PksHroxlTBc
Message-ID: <CAGp9Lzp0LEac0DnAzs477fG5rmA+ZjdDHfdAPWccK3GKEY05rw@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: mt76: mt7921: fix txpower reporting
To: Lucid Duck <lucid_duck@justthetip.ca>
Cc: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-33068-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,justthetip.ca:email]
X-Rspamd-Queue-Id: 653BD26DFF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Lucid,

On Mon, Mar 9, 2026 at 4:55=E2=80=AFPM Lucid Duck <lucid_duck@justthetip.ca=
> wrote:
>
> Hi Felix,
>
> Friendly ping on this v2 from January 30. Life got in the way of
> following up sooner -- apologies for the delay.
>
> Since submitting, Nick (morrownr, USB-WiFi maintainer) has tested and
> confirmed the fix works on his MT7921U adapter -- 33 dBm on 2.4 GHz
> and 24 dBm on 5 GHz, both matching regulatory limits as expected.
>
> I noticed Bryam Vargas recently submitted a competing fix that updates
> txpower_cur in mt76_connac_mcu_set_rate_txpower(). That function is
> only called from mt7921_set_sar_specs(), so it wouldn't fire during
> normal AP association or channel changes. My v2 hooks
> bss_info_changed() on BSS_CHANGED_TXPOWER, which covers the common
> case.
>

The maximum value tracked in the loop inside
mt76_connac_mcu_rate_txpower_band() is close to the actual maximum power
that users generally expect to see reported.

If the value is not derived from that path, the reported txpower may not
reflect the SAR limits that are actually applied to the hardware.

mt7921_set_sar_specs() is mainly the userspace entry point for SAR
configuration. The actual SAR power update path goes through
mt7921_set_tx_sar_pwr().

If you look closely, mt7921_set_tx_sar_pwr() is invoked in several
situations, including device start and regulatory updates. Therefore it
is still part of the configuration flow that determines the effective
transmit power.
> Happy to rework if you'd prefer a different approach -- just wanted to
> make sure this wasn't lost in the shuffle.
>
> Thanks,
> Lucid Duck
>

