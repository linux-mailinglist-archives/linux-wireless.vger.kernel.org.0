Return-Path: <linux-wireless+bounces-39005-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mu51ACehVWqJrAAAu9opvQ
	(envelope-from <linux-wireless+bounces-39005-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 04:38:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 591A9750672
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 04:38:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=LzP8XZcE;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39005-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39005-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63288301C925
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 02:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6C33815CE;
	Tue, 14 Jul 2026 02:38:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A059381AE4
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 02:38:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783996706; cv=pass; b=SBvAEPv8rJBwzZvVLV8YXl2jDmrsKv04TLN54lmb86lKP/Oon8oQt9OMA+iXIYNIKARPX81owTApFkk4BOyuqwS0dF5phlCcOu4gn07DfNBLhB05ek9k2fWs0+KRG21ase0HBewv7VMUY1V7C6Ik0GAxL0h+8E62sqyo7LNbXug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783996706; c=relaxed/simple;
	bh=y/d9RTLRv5JinBYgTb6BGJL8/az+AyrEr0a4TEEeb6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FUKfgaE9Q7XYIBVyE9HXVXlt6B9OETjfv61zo5p9GImpShQ/wUA5YiSJJF1YW3MGNCkVwyqX41UqqLWSR+QXEBTjtMpO0y0YYzcdirYPQYbz6Le9L/gDZiWOmBVo/FUcCmw1xvjANTvI+bdpFLqkENYvgdSYIM9uCPD5bZEXl7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzP8XZcE; arc=pass smtp.client-ip=209.85.208.50
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-69c5eb6dfd3so4259587a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 19:38:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783996704; cv=none;
        d=google.com; s=arc-20260327;
        b=OPmSY4n1Nqol+lyOVYgh0W0T68TQAy5pji9hNSUHgE32ZEVz9RCe0bkR/6IAYU9f5G
         pmU749N3DdceH+RZoJWtmd8oZbAJHXsm30FrmNc/MGCc6p8PJIl+TPfA9jeRI9aU3D3R
         hqo1o2Az6BRuZY++oTp29hrTJbxiqSJNllef+5T4Y5UUBO3rerQ3DVffb1MQosBjmWHW
         eKWGGSpnypVXPKQsBvmqG2IOs0dJ1CXWOBRl04Of6CBHklv3Cnf7xY4COEHhiwZ2iYfg
         PdsUxIARFbNSHSmvo7vHYuqVbnUA6yS79GnzTGjwSJIKX9VIDp3lUGzK18DpjPwvw3j9
         Jc2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y/d9RTLRv5JinBYgTb6BGJL8/az+AyrEr0a4TEEeb6k=;
        fh=7uzYYsWNoOaitRJaJj7iIvZXpV59+qnGdPIfLICSokE=;
        b=EK3biSlwCAMT81WXJWv19Fqq4gkX63Tsc/jDrLIRLhTRSmNoea0viOo2qsMLpnVHcE
         ARDqfwQr5ufPAni836gbZzxzLzgJI+YmsZiDSPbvw9D8NWm4mq/p6T1BtpmTvvygVyox
         r17rEJ4KlLS3pHPPxL0u07iUAZnHsy8qYBF3fKBO3+qxg7f/oQ+C3+4RhuGFU9JIvQCX
         QEcvV/Bw0FbyYloYMZyFIl1wgQhf1HeplF8j5u/S1Z7G6qI599tSM4sLIb1spidW+6Bj
         mmTR+3TvAf8bSLQRhpm9lsGOhxP0Wc/OWBaDpHW9BXclLRlSmVjvJF/27u8X1uSiSvpa
         POMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783996704; x=1784601504; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y/d9RTLRv5JinBYgTb6BGJL8/az+AyrEr0a4TEEeb6k=;
        b=LzP8XZcEWXZxPLHH5eCkBUueDaEuiHWvlWH2KpauvxL8II3NWKp/LeIQrlfDlz4u7v
         60OdhIC0N1L6FBWdpp8GkUX+gV5AsQjzHF4emDxirNjTtaN2jXVqVQJEikd/V+E/bXbT
         kFt8DxhJuWsBIdG7KIQvywwhF/z9Mm8W+fbI7jxyyqx3kCkHsg16yXWY7giGX1fsk8/T
         CW9Ir5jOJj+uWxjgmKl7wHqtMucEQhVu5YupDDEygKdQASlOSFG8NsE1gmvSuXd4CsHE
         SgF40ZW0Dt2HbXm0ouW5z2I7M4vPScDI2pqwnQfU5OtRsMh7/SyMDW0O7LTmeGz0MK/H
         6PLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783996704; x=1784601504;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y/d9RTLRv5JinBYgTb6BGJL8/az+AyrEr0a4TEEeb6k=;
        b=QA1YpAs3WjpEvFG/1WBYqhJhWthmAKImV/PoCLaZWOfQYoX4nsIdD9N1n4DIXsnYV/
         mbv2YTDGm+gt+hGk48ZFSWOSQ2xwHyLJ0V+3m8LD+qSFjWd2HcPctDP1hTt4Tjm8CHXc
         6hjshxpilckYhgvyiHUXZgEM7CW96bMKGmBc0+QO0NBh89IJS3jv17uXRe8hTJflteI6
         d1Fn6+v96QHUoaIvDDKgH2Bvefyh37au5BzoBG61zVJPQlA8ML6VevNxTL3NVEfsKPrH
         +3NOrymPMNtn7/bAOxqr/rWSUlj/fNOS3LKtO6YBWss0ZwYUGZ4Y1EQ0zZrHz0U7DN9Z
         d7WQ==
X-Forwarded-Encrypted: i=1; AHgh+RrjsahtlK6XjvLzkFWf0aVqKT0CyOI2LXeFPPktK/IkrhN0pDYTXdVccIQyawjX2SiW6f7oWLwR8o2pYQab+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkiDV4F8lNSejl/e0oQPYRo0hoWX1/pTAkSAufPg0QUvAZ9xkI
	HuXUWThoODOLNa+Ur1xveNZY477QG+wV5LFFbFWCJhOFoDsXYuUDkV2SDbatJ1NIUXNcZ3ensgK
	QsKTl61Ls14ZbaTTwdNM3S7glqTFXQxu/wg==
X-Gm-Gg: AfdE7ckMQt81zoxqp12wM8TBsAZhI7skXiPoSw6xYfcatG0bsgs+oRCHS8MPpihpW/i
	UHkVbHJG4zw/93NvkqFuBJMPYgLaTyBLVVBPWrR3iGVFU6IL9GZF9hu8GLqAMzHKdTayqJUyTyg
	t64unYAFRg+alNESw/PZt4UofBn3LPIYbucBWykSvb7tHf38iap8K06eXBXRC/1WiZGT68Us7sc
	qj8hvqFTdihgRYEGPJcKiT7TSnr7IhorNP6s9a3SBMW/Fp3SwdCQSIJfWNMq7AgXiLx5IJciw==
X-Received: by 2002:a05:6402:5193:b0:698:3469:faa3 with SMTP id
 4fb4d7f45d1cf-69cd6c711c8mr188428a12.10.1783996703384; Mon, 13 Jul 2026
 19:38:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711153336.542-1-hujy652@gmail.com> <20260713150151.2343583-1-jtornosm@redhat.com>
In-Reply-To: <20260713150151.2343583-1-jtornosm@redhat.com>
From: Zhi-Jun You <hujy652@gmail.com>
Date: Tue, 14 Jul 2026 10:38:12 +0800
X-Gm-Features: AUfX_mylnAVWH5R49FbGlpdpL213f370VJI3VfyGRvACS5Vk2L5N9PDNAgH5wpA
Message-ID: <CAHGaMk_FbjCShGw++0m9UT+sK+w23okwvx1vkqid6n9M=WScxQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] wifi: ath11k: implement custom wake_tx_queue with
 flow control
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: ath11k@lists.infradead.org, ath12k@lists.infradead.org, 
	jjohnson@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jtornosm@redhat.com,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:jjohnson@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hujy652@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-39005-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hujy652@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 591A9750672

On Mon, Jul 13, 2026 at 11:02=E2=80=AFPM Jose Ignacio Tornos Martinez
<jtornosm@redhat.com> wrote:
>
> Hi Zhi-Jun,
>
> Thank you for the review.
>
> > In wake_tx_queue:
> > ring_id =3D txq->ac % ar->ab->hw_params.hal_params->num_tx_rings;
> >
> >In ath11k_dp_tx which is called by ath11k_mac_op_tx:
> >ring_selector =3D ab->hw_params.hw_ops->get_ring_selector(skb);
> > ti.ring_id =3D ring_selector % num_tx_rings;
> >
> > Are you sure ring_id will be the same?
> You're right =E2=80=94 txq->ac % num_tx_rings doesn't match
> get_ring_selector(skb) % num_tx_rings on all platforms.
> In v1 the ring identification was only correct for platforms where the ri=
ng
> selector happens to coincide with the AC, but not for platforms.
>
> I will send a v2 trying to solve this globally for all the platforms.
>
> > Also mgmt frames use a different path.
> Correct =E2=80=94 management frames go through WMI, not the TCL data ring=
s, so they
> are not affected. The flow control applies to data frames, which are the
> ones causing the problem since they use different TCL rings depending on =
the
> platform's ring selector.
>
> Best regards,
> Jose Ignacio
>

Hi Jose,

While you are reworking it would you mind looking at the previous attempt?

It tried to follow the behaviour in ath10k but lacks throttling mechanism.

https://lore.kernel.org/linux-wireless/20230501130725.7171-1-quic_tamizhr@q=
uicinc.com/

Best regards,
Zhi-Jun

