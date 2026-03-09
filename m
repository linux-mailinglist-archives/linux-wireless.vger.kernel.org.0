Return-Path: <linux-wireless+bounces-32770-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DYSFHD5rmnZKgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32770-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 17:46:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F006B23CFB7
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 17:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4BFA3023326
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 16:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4511938F255;
	Mon,  9 Mar 2026 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xn1uX/g4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A4D385501
	for <linux-wireless@vger.kernel.org>; Mon,  9 Mar 2026 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773074185; cv=pass; b=CI8lnN04jFURYoxDE3lbsoCvNVM2766FpSTGUwi6R0IKCbcrMzLZlF05zF58rRI0dnTKM6T5Xy8A6qcOoBuuyAPWIXgxHBPMq/alS6LSac2DiIvhZR6JEk0RWjJwbq6y9yNbRiS30LVY2trJRcwgSg1z3CPSVJQoZ9tD3raoY8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773074185; c=relaxed/simple;
	bh=/8JlkWtJXJilTweLrLD4+Wo/zd+tXSF3dlwLCx57kQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eFe0jSrIAke4nP/bnzBlja1ekMlJKvklAWKl64IzC3XOXi9ljI575FAsZKWv8yBjN3NXKfCwL7V3F4VdodQFcOJ6VGZXj2/3ABv9b7pseExFf4szGt9BZ/Ns/rLAGsR+JC7C3h6wyaqCaBVZiB0tYTcc/HfIGTvkhtxYsNcPwJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xn1uX/g4; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6617f0bcad2so6120334a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 09 Mar 2026 09:36:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773074182; cv=none;
        d=google.com; s=arc-20240605;
        b=X4/hdbkr+Z+iP7+b1QUHyV7j5/wWreBuaH3cNdyJnKDScEaTVM9yexvyLjw5aigILj
         zTw1EdhdGMZsVWozPzebL37+W1+n9u4WwolqNJf4AnLwqH0MCfUDTKUrWpcqF5C5nOkz
         v1Yl1X6Ti9Qn0Zf5jQiaE++ACSOoD9nX00L09GN3iANN4RgaRr6tjeyrq2B2i906TEKK
         kiqpWuR6gmUQ97T3UGSFs67TjEdwLHAIWujru+cG8dIiwPhL95fJobngt6YAzf5HuIeX
         R3Pg3s88J4njhNCpx6FqmsQosXJgxvENj4fDE1ZYLEYgBEiKV0SP/kbUs//qHOB35EGg
         qtRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/8JlkWtJXJilTweLrLD4+Wo/zd+tXSF3dlwLCx57kQ4=;
        fh=MXkW9Xo5Ym/gIF9EG8Fk1lbc8jJJ90IIrm4Se6meZo4=;
        b=SOvM7vJgn7JtBfOIAbHSKpUEhPYzBusz1YntJLLpU0oR18vw1+Hm8JOKF4jSQn71pQ
         EkngEDYo+lW1u08NkGedR8Xlib/Z/Pf08ntew3ihvoYAn02+cZ7BXutX9lPLTbTdez0R
         Rp63XjYFtusf+VDigpB2Ajb5BPwKl9cfYMA4vnAft+sPByRdTCBsDzNx0IAMG8aVVF2T
         6jPNpopaKk25nkTL+zxNr9NDBhLGl2UNHDYEa70ZBh4iuskB2xOAX7olKUrXOVj4W401
         UxwfN27I3DclpRIF6eOk42W+CyVbc8nhDXLlVvoD8P7x/GeGol0qM17IzUTD6zlKstXy
         YZeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773074182; x=1773678982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8JlkWtJXJilTweLrLD4+Wo/zd+tXSF3dlwLCx57kQ4=;
        b=Xn1uX/g4uXpqQj9QzvyxyZDwQkGhd6VMJIeXAR8D5wZnZu+wSUGyYJki5XOWT1Mc6D
         DHM1QFGflsf3yguYiNq3JLwQAYWEJKu/h8RrLnh8vydHEoG91oQ5fryyafJKZAKtTqzb
         IZnoc1wc3Gakj/hnY7xl/wyPp3OF2wnQ+AsK/4zBaavjGfCjYNODharwIcnPF5g0MYCO
         B3HJCo1bxdPTBfrJLyf5lLnDRIOKyt1UwH5GCunN/tUc/Jne+xlMBc+MCTw/8diZ8oIq
         rizavs6ASt+3ry61AgmmB2ZpdXf5l+7VJx/oDcRBAhG6c4gllTmDMer7lS+rJRpzds1V
         uljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773074182; x=1773678982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/8JlkWtJXJilTweLrLD4+Wo/zd+tXSF3dlwLCx57kQ4=;
        b=l+bn6fyfkRDtayRivykJrZps5832JTMOwVUjlM19ns1Vr3GSwKI65IhSiHKhfer/Cx
         i0rR0fdafXIDsIi1aRcXYTVvqs++dZqOKSkd0DQREpjyEZP4ki2CdjnAaIwBmHdasE7s
         n1ZSEYBRzMQPnciq7D/psqSyC73efxslrJ05+I/NW2wuZrPbZw+hue76pbZJtUdH6TW2
         28AlwQjyelfJb8LnD/j+vtOXe4pJcrXMztaDDMT+SOdAyE7zU8+TjIKb4iDyFCHCv3Yq
         banZwoU38TA8jqHxDfAyLpQjhNp/6t6v6HoZNPTzgLg45WBp9EBFmS7OefcC/F1gkDUf
         h4eQ==
X-Gm-Message-State: AOJu0YyjmyFHceB29VqjxmSRG2uT3Er4wW0WIYinndawirvPF5nhETnj
	hV/8JMI2IVd+y4Py9rsFB5cB53j2NjuI86blqyoIOevxnb1CTh5kidnz5hUnD3GpgGl4MncsfsO
	P23dUi/GwS6PXaDb3PEykGrgDBbmA5w8=
X-Gm-Gg: ATEYQzwzAaj9tVHAkYNIXKdms5czW71nGChlR0IHIJ14IcRPWViJC0S2BWCKutO00/q
	AvWc+dhVqw7FXxVk78vCjDw7UTHZ6ZJ78CSlghUbzlCBWujDdMyhZUnXslPevgQkuwyjkYFWaYq
	dGpjjQ37jfvGRkVPxwMxXAJVSROeEpRwjP2QzCtTpyw8mDZrICgMNJHVW5nkTYUtewFSqsv1P7g
	GGxLJoicLe3KqYanPjKxzlX4SYquo54rMcKCHVl4fpaqAX22sPgEOWwow3YsYP4vpT3NeL6vW5c
	8BiXHg==
X-Received: by 2002:a17:907:980d:b0:b7f:f862:df26 with SMTP id
 a640c23a62f3a-b942dcec505mr647443366b.14.1773074181199; Mon, 09 Mar 2026
 09:36:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANAPQzi3BkfnRS4CEXAA560O5cO8e6MEYxeVVx1u+xUeXS-gmA@mail.gmail.com>
 <CAGp9LzoidBL1iYYC371+Fw+drbArLRTneJKxCoFiitx=dweKCg@mail.gmail.com>
In-Reply-To: <CAGp9LzoidBL1iYYC371+Fw+drbArLRTneJKxCoFiitx=dweKCg@mail.gmail.com>
From: bryam vargas <bryamestebanvargas@gmail.com>
Date: Mon, 9 Mar 2026 11:36:10 -0500
X-Gm-Features: AaiRm53VWl3-9agawQkBx36EPIJKLrChGbKxKcgkpyuLm8tQnnRcvQuJKHepZ7s
Message-ID: <CANAPQzjiBf8Rqphn2SypYN2O6bddj6vB=63Mp=T5YVEt2oGvyw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mt76: connac: fix txpower_cur not updated in mt76_connac_mcu_set_rate_txpower()
To: Sean Wang <sean.wang@kernel.org>
Cc: linux-wireless@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: F006B23CFB7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32770-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.874];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bryamestebanvargas@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Sean,

Thank you for the thorough review.

For patch 1, I agree that updating txpower_cur in the write path mixes
concerns. I'll implement a mt7921-specific .get_txpower callback that
derives the reported TX power directly from the SKU limits instead.

For patch 2, you're right about the race condition =E2=80=94 scheduling an
async USB reset while the driver continues the normal reset flow is
problematic. I'll rework this to trigger the USB reset only after
detecting USB transaction errors or repeated mt792xu_init_reset()
failures, as you suggested.

I'll send a v2 series addressing both points.

Best regards,
Bryam Vargas

