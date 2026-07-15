Return-Path: <linux-wireless+bounces-39148-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tV4DMmGQV2qYXAAAu9opvQ
	(envelope-from <linux-wireless+bounces-39148-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 15:51:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CD275EFDE
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 15:51:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=LHI1XP3z;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39148-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39148-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2DB053006828
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 13:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1792A420466;
	Wed, 15 Jul 2026 13:38:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EED2EBBB9
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 13:38:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784122712; cv=pass; b=MNI4Bk3uYkARkunPRl3DNdu0Dbp5JYkwx5RwsPP/uui7tJ17D+6olbYqnhWJeY2E/svwHLA3sjhf/oIwCWDcbDd5HA+myJShaCBvcF73CxuOF3pYUzegJMFtu8UiBtBbidop4/ybGNf5fN7Rh8kRFkzOHaHKaS7RJAIvhMBNhRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784122712; c=relaxed/simple;
	bh=o8AGu87KhED7l+0KQfJDZo2MlT4WUl5hwY6jbhRTbFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pL/7bAuDnTda32jw3meiUU1WF9nq1QppLcAelHPGmxgS0Sci/bPPQJ9saggwXyqoE12T0dTtS+jbMqc2gwB1+lBWVg8SqA0lPDelct0QBsKs4TgadeZYb96Ygi2VEOKhgxo4zlR3fiFpmj3ytFgsbYPmNtR0Wt7KbiOw4bTcpxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHI1XP3z; arc=pass smtp.client-ip=209.85.128.170
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-81e86df8987so71581067b3.3
        for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 06:38:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784122709; cv=none;
        d=google.com; s=arc-20260327;
        b=TY9Cxn9lT7iqzXE7caaY0zVWVHH3k40V53JKxmtPkMKEDIGDwYnDivZf8dtQvg5aIP
         FrBp4UbHSUj8cg0Fxg7QnUjL1qsdx/YZ8iOiU6txRP/JKEhem/nmwqM/97Ajbocsw+3O
         FGplpd+1bncOxoVgIdpPolTStIyZZEhYJbIZlKAxVN0bZcfVLX+11PnaecilgBUcub2P
         i9TZtsCS2JVnzsjFRvRoqZn78vq9LHH9DaVGBNoiFqYksO8cWvimqSFlMEpNCAhsIeiy
         aYck1QDQQB5qObRWZVm3DWVBXXsqh4iiayMS6uS/YuHiUI2+8NQViezxJ91iq/XTyILC
         ArLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=p4VE2YniAd/lygwGqDSvrY/NCQ0zXtAOgiK4gE5r4zw=;
        fh=lQ87HrakKSAYJf6jjKpEcN7Gd7sBnuA+/vSMxELsjrQ=;
        b=G9KDUD+gMM8hGPh8I5Tailmo2oLSl6AttQXl4pXv/6b0Y/0eYorFPcBxpP30GBoX4Y
         hEDUM9sNQcFthxqGgt/f8VADRk4kUS3nyiWWW5VKNH9QJEDfppe9tXmfDWyKYiJ7KM4h
         cFEh7Gdn+pxThWrVxW/no63mC3efzSl6saWMbZVFeCAdALrwuba/jVv2+Ljf5ujnLGex
         hBKaCVVgTUWaD8/AXq18kq7VmQvUxTBrGNUApz4y9PTr8RPOwPP21FecwqWgDwi+TfWn
         W3pwCu2oDcRLjcjMDuyyNuFNHo8qjnqjnYiy8daJkD4lqPEjYdfIV/zFGai4tlapPzaP
         MmtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784122709; x=1784727509; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p4VE2YniAd/lygwGqDSvrY/NCQ0zXtAOgiK4gE5r4zw=;
        b=LHI1XP3zLQRoNFc0xG+NU/z/BO5LYqeLwvS1zHdeNsBNrfw//LNogSe/rq2+zOPKtU
         d/N7zze0vcxVjFXo4+TsY+nJYVXIyWQds9ezjZlE3blA2z8E16bebNPE+RyaWGREeI5p
         BXkf/qqUkOWSHty5VqE3ExKGI5y3fv/jXVCMzxk41hvBb4SoaaGDaPImDawNlwzH/5cb
         PJURmI8ntirX5//ZVMeV4oM/8ATjUDn2YI84Pl/D2360IDNsGPnNqlDtsMkAwB72W7aw
         hoGUvuJQNwOV2YbIl4WHdKlj18IR7XsNYLv9WylOcJ4XJqT1wzvcx0XTC71HNApa+oai
         n6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784122709; x=1784727509;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=p4VE2YniAd/lygwGqDSvrY/NCQ0zXtAOgiK4gE5r4zw=;
        b=c3sKUmNhB6awLmULBBOVMGlMBq9Pr/b9qsHljJpFXmujlAwzv/m+mFbU6vpes+kHOX
         cDmvY5NHWXogVkuzw15hsVugojHRUIeO/F0qoEWXr2czH1BE3nC57mBplmlcqKeiROlx
         lypJR3AV2BooPTzke+qbkF6VoigbA3MgNMlrHyXasObsjsP3vYhdaR5uukTtct7uVB6N
         qbDYkjG2+wbyuRizCti9e0Yt+ETdHjvilcVYUDc0N6uIiVbnkypuJkitj+XNpAtkShIm
         kqbn4mg3pnJAlOQ7ucUPobg3K6Bb6bTMZKxYQgd8M1K3URxw0nHyV5RzF8bdYJejHjEC
         XwAg==
X-Forwarded-Encrypted: i=1; AHgh+RqGV6R2F1aYRSeurt9y4BH1Qvvz/HvDINHQmDhrrv38oK3SK6vHegx5Hi7UA69DBYJr7Pt7a4g2Ubcuke1mYw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd0XlU93SpWbxlybSWO1/upP4K2zyzi61XJMfHHsALsrJIcKmd
	MbRx/71VCvAv/NXNwN3ltsRiRgiNOYEzDwigas0H8WlGAxxy6MN2FcN5aNxyBhm8r03NVgaeJDi
	JlbTG2EIEjA6BFHIWJV+Ydsnffw+WfRE=
X-Gm-Gg: AfdE7cn1IK8uviNQ2lLIm0KdBXBoAebYGIsmIyCpg2LSfH6UCQchBXldYnh8k5ngF/R
	JhjTfn+nu9lD2j6yBPtXTwwR+xxf/zgqFb05exRJ8Y42dERaz7zmZIeaFMP3pxMkw62P7W3efqu
	eNFrlYysK/hmvnnN49q0RAOZXkPAwe99OcRJNLtzHlw1edDG8cA2/qlDJhALql1LdvFCUvXtWCU
	naxluM7x4dBGBySdsOqPMEE3/wZsUY/6z6Wj5g4gTFKjsyucyH3JQHE3ugAkJUDIFiJ6P8MhY9L
	k5psIoHvw7GBhIDd6tXHGNx0mOM=
X-Received: by 2002:a05:690c:9982:b0:81e:a3d3:9b0f with SMTP id
 00721157ae682-81ecf7765a3mr20669077b3.15.1784122709478; Wed, 15 Jul 2026
 06:38:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629120333.94222-1-skyexpoc@gmail.com> <20260715132234.GA56330@francesco-nb>
In-Reply-To: <20260715132234.GA56330@francesco-nb>
From: =?UTF-8?B?SEUgV0VJ77yI44Ku44Kr44Kv77yJ?= <skyexpoc@gmail.com>
Date: Wed, 15 Jul 2026 22:38:16 +0900
X-Gm-Features: AUfX_mwZ-Qmxe7T6ufd6JWsk3NojXUopKMgXdpK3otI1LCnRzPV4Lb--TGPld0I
Message-ID: <CAOC0qyJi_P77-Q0gqwo=UoP3HcZrfgTjFae1AgHpcq4xvCP07A@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: bound uAP association event IEs to the
 event buffer
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Brian Norris <briannorris@chromium.org>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, Johannes Berg <johannes.berg@intel.com>, 
	Kalle Valo <kvalo@kernel.org>, Kees Cook <kees@kernel.org>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-39148-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[104.64.211.4:from];
	FORGED_SENDER(0.00)[skyexpoc@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:francesco@dolcini.it,m:briannorris@chromium.org,m:miriam.rachel.korenblit@intel.com,m:johannes.berg@intel.com,m:kvalo@kernel.org,m:kees@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skyexpoc@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,209.85.128.170:received];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C5CD275EFDE
X-Rspamd-Action: no action

> Why not validating event->len instead, when we receive an
> MWIFIEX_TYPE_EVENT from the firmware? we could just add a new,
> validated, u16 event_len, in struct mwifiex_adapter and after that we
> can just use it in the code. and we reject invalid events as soon as
> possible in the software.

Thanks for the review. I don't think that maps onto the code cleanly,
because event->len is not the transport-level event length. It is
struct mwifiex_assoc_event.len (fw.h), a __le16 that lives at offset 8
*inside* the event body and is specific to the EVENT_UAP_STA_ASSOC /
TLV_TYPE_UAP_MGMT_FRAME payload. It measures the 802.11 (re)assoc
frame starting at frame_control, not the whole event.

At the point where we receive an MWIFIEX_TYPE_EVENT (usb.c, sdio.c,
pcie.c -> mwifiex_process_event) the driver only looks at the 4-byte
event_cause and the transport frame length (skb->len, or the PCIe
transfer-header length); it copies the rest of the body into
event_body[] without interpreting it, and each of the ~40 event causes
then casts event_body to its own type-specific struct. So a generic,
receive-time u16 in struct mwifiex_adapter can validate how many bytes
the transport delivered, but it cannot validate event->len there, and
the two are not interchangeable: event->len excludes the
sta_addr/type/len header, so it is about 10 bytes smaller than the
delivered length. Substituting it in the code would compute a wrong
assoc_req_ies_len and re-introduce an over-read.

Storing a validated received length in the adapter is a reasonable
hardening on its own. It would give a tighter bound than
event_body[MAX_EVENT_SIZE] and could help other handlers, but it
touches all three transports (which I can't exercise on real hardware)
and it still needs this per-event check on event->len. I'd rather keep
the security fix minimal and in the one function that knows the
assoc-event layout, and leave the receive-time refactor as a separate
change if you would like it.

> In case we want to keep the change here, I would ask you to make the
> code slightly more compact. just define a evt_len =
> le16_to_cpu(event->len) and use it.

v2 folds event->len into a local evt_len as you suggested, which also
shortens the bounds check. I'll send it as a proper [PATCH v2]; the
hunk is:

if (len != -1) {
u16 evt_len = le16_to_cpu(event->len);

sinfo->assoc_req_ies = &event->data[len];
len = (u8 *)sinfo->assoc_req_ies -
      (u8 *)&event->frame_control;

/*
* event->len is reported by the device firmware
* and is not otherwise validated.  Reject a
* length that underflows the header, or that
* would place the association request IEs
* outside the fixed-size event_body[] buffer the
* event was copied into; otherwise the IE walk
* in mwifiex_set_sta_ht_cap() reads past
* event_body and out of the adapter slab object.
*/
if (evt_len < len ||
    (u8 *)&event->frame_control + evt_len >
    adapter->event_body + MAX_EVENT_SIZE) {
mwifiex_dbg(adapter, ERROR,
    "invalid STA assoc event length\n");
kfree(sinfo);
return -1;
}
sinfo->assoc_req_ies_len = evt_len - (u16)len;
}

