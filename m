Return-Path: <linux-wireless+bounces-38991-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cMGGE0UsVWqQkwAAu9opvQ
	(envelope-from <linux-wireless+bounces-38991-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 20:19:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D66F474E6D5
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 20:19:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=0sec.ai header.s=google header.b=akfdfwC1;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38991-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38991-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F3BC8301CD22
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 18:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7DE3081D6;
	Mon, 13 Jul 2026 18:19:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD689274658
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 18:19:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966754; cv=pass; b=Ih4Ki8burxdpfUDm6nGoqDtzMRekzni4HZwFzP5N2HMd/EMqMtbGp0etldR1WW/19bd/GIqq7ZpHIeUMi21EjTai/LH4UqxoEFabPtpmPV5dulgjUvb7l1GpBT5+czY12gEcvwIrFhIJm2OX/JG3f9wcvLqkuE2w05Z6AO9J+Yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966754; c=relaxed/simple;
	bh=a7J2o/Uawyqjxcq822ubh31HNGfGy3Dyi9p/J54OSA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GscpQkQS1XT5lWspMn4wtyOiafFRcrbjOB/QRrcVDo6MQTIyI7SMhW+Q/qrAZfF0Ug9JVT88OOZwRZGffP2CGSIep0LMbfabl6uNBH9CDvkSvUKlULRd7dCA1pJcd3nX+OWHNDNBPc4iG/nwMY8jHfzTUs/LYB/QEI4qLYdj6xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=akfdfwC1; arc=pass smtp.client-ip=209.85.214.178
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2caed617615so38421985ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 11:19:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783966751; cv=none;
        d=google.com; s=arc-20260327;
        b=RLb/VmFrVviSjFBadsCM0uu9Yo283vgURDmZteQ1HRbRlJPNqyb3NAmbhZ600DUq9s
         5neKYd60yvMhnkwo9blfLlUxB9ObaGlfrTdq5ha5CQh9zeysJCkYVpP59F/kbHexLhKA
         dAtFqTWxvF/fhwvTd0d/ZX0P1iM06n/TiRDTvhh9Y1DG9dU9fdkJpa2LkWpQWDKxgl3o
         FtEinXoQl/L1YopzZRH761vUSYBn8ylcTlQr9yE5uCt667irTvRcBOfAL7z/xMAoDwRN
         2rXfmNCkvcH0MT9+W2yZJqE30hUL75eGfLEuNO2/gpOqNbvXk9H724ZiIw6oKTIXUp3T
         LBSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oMyPiF7lny3DatTRlbMwq40lHfzP3eH6xTvYxwG42rU=;
        fh=oIukcTsuore6C/ObdnDyxb6s34N/7wPUZ1rqdUPvJfM=;
        b=mIipHNOFpYPIHHF2OWtuTDhhtEooTNCTyjxDezHMll8ZYzyoPs2HFTvNKD1/0EZAIY
         FrtSEXFYg9IClZhuFv82lmom9qUaxQVBd9jH2OETaHc9gW1pNYNNluQeyQc3WIlqHiwb
         LjFtva0dkRcsXRGFZFghM2dJ2A50s5jFR9KeCM4//VP7fkY7fsAk4iNPl+jTsc90oqL7
         wkvZyirD70VSCqHC48weIGqglHGSgSzxFesGqhVuHEs4TylozUb9mgUY7o+3J6EfOeKs
         6P0P7Jq87g/zLrTV7IzU5Yo9218xiPgfWw0GZXUa1M/KafKRD/YGFCtuI9FxiDwvDvdd
         N41A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783966751; x=1784571551; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oMyPiF7lny3DatTRlbMwq40lHfzP3eH6xTvYxwG42rU=;
        b=akfdfwC1gWKnXlOaKIrr36v1gDkMDXb3e66zZbNTLs8iYvzO5smFEeG/755bf3KEPS
         zDONj3HwK8nJC84vUIXOObk1HYVdSXnbGCZjI0FaOCcJuroaV3/9+18hGC2kfaAuZ3mk
         eZWNxSXk8/q1lWnf5CBggcdOUSzBRgNzuZaCqg4qUl3vVxQNm+0v8X0x1vI3tnT05NI+
         jG405xgRp2dcJUEIFjNw9c+MQLq46HAgq6KZ7qas+PpVnsfvARuFH7r7kcBQaIl7XWua
         yo5fnimRe06QyVVY5DqTdjW1skDNLgIKCNir6aVSGxii2vkAmmf+SVEgB/Ez3kZI5VyM
         toRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783966751; x=1784571551;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oMyPiF7lny3DatTRlbMwq40lHfzP3eH6xTvYxwG42rU=;
        b=CQ3NvuRzJeWxzbzLh1E6pthXHP7oZslvTtaI8RM95yvuw0m5UryCQm4VwdbElkcpFi
         FToImIs7dCZeF1K2wR6uwVxu0R7MoAV7hJXGo2qN8TzuU5v4rVKuhl9oz0moVZpKJiku
         Osh+HvccFZK9En4ESbqWx5f2vEJfgecnKNSDUS/hG/NtoG1iww0kg63AvUkQTuPo2a3B
         XJ/YyaWIePWLFlXYCqXWnJcqbCOEZ1OtV5BcVpo/mJL5rA8Ba/K3t3PhqJQ+Zxq7Vcrz
         gvTfHuTkuAeB85rHW49UUqkqGSJkgpFIEcsSIwo4Fx3vX4lyhPhyH7y69Z3/+UdM3TVh
         0KNw==
X-Forwarded-Encrypted: i=1; AHgh+RrKhexCtKO1I7Vp27iX1AoYRMbpKudAR+YdxarMcBv1/Ci4MzSWeDgC+9TAU5k3sez8/fK684fM6JVEsQlonA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMaGmrLEY+Xv+rTQ8elFUlHoRIdzUcOY11OXnaKT1ZvwLwAYSt
	PRb7+lrU/w2hwFZooX5qxV3zxdcOC8uUoesC4gsfuZNpQaRtr8Ehd/1HcQF1RR9xurcGZQa/tVO
	0Hcl2p3U8cRqOzKIOJ/r7uhTHqeui9pguV24ZBiKdWwg=
X-Gm-Gg: AfdE7ckbo+Wi0QHiog9OHIAKwiQWTp8ECq7C7bntxd87QKMuXe6gpnUiVvIGLZdAlrG
	l+3zXpFWDY0alXgSPYL61fbjJn57Mar7fq/PNCWCMfWonnx9Gjf+6ZAeJ7NVELp6GymiL2U2UIw
	pdvyQGHLQEaHJTqH63DLlDaYuCA+m0tszCJ5FGzXIcdcVlT+uP3iU6It6Tb0t+GAQ/jov+WOeJI
	Z2R8sM2z+F2n7J4iXNFT5VjXThBDLAELUjjyGxZu149uCX5i6TrBc1oCpT2u/es/xe7siwAuiWC
	ehB/0TQY/uFJeyOIUVaMlo6v7q3MSqpSrIKsj0ikEq9XUaPAoz2QMw4E3r2RWf0Sp+A6gQE=
X-Received: by 2002:a17:902:d546:b0:2c9:cf62:6f61 with SMTP id
 d9443c01a7336-2ce9eac212bmr103069735ad.17.1783966750843; Mon, 13 Jul 2026
 11:19:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711071336.58324-1-doruk@0sec.ai> <779ee099-5132-4752-bdb8-354dfdc53926@oss.qualcomm.com>
In-Reply-To: <779ee099-5132-4752-bdb8-354dfdc53926@oss.qualcomm.com>
From: "Doruk (0sec)" <doruk@0sec.ai>
Date: Mon, 13 Jul 2026 20:18:59 +0200
X-Gm-Features: AVVi8CenKr8Md-_ghFq-SY_VTIPefNoGzVmvVLnHgY8iSBM67OYes4dP0hXi20g
Message-ID: <CAPdMp1okStu9UiWn-Kb4xrTEdGj1POT4t+moh77JHpLSzD-pZQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath6kl: validate assoc info lengths in the WMI
 connect event
To: jeff.johnson@oss.qualcomm.com, linux-wireless@vger.kernel.org
Cc: tristmd@gmail.com, johannes@sipsolutions.net, 
	peddolla.reddy@oss.qualcomm.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_REJECT(1.00)[0sec.ai:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38991-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[0sec.ai];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jeff.johnson@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:tristmd@gmail.com,m:johannes@sipsolutions.net,m:peddolla.reddy@oss.qualcomm.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,sipsolutions.net,oss.qualcomm.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[doruk@0sec.ai,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[0sec.ai:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,0sec.ai:url,0sec.ai:email,0sec.ai:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D66F474E6D5

On 7/11/2026, Jeff Johnson wrote:
> Some aspects of your patch are already addressed by:
> https://lore.kernel.org/all/20260421135009.348084-3-tristmd@gmail.com
> So you will need to rebase once that lands.

Thanks for the heads up! One thing that looks like it may remain after
Tristan's patch, in case it's useful: the aggregate check bounds the case
where the declared lengths are too large, but ath6kl_cfg80211_connect_event=
()
still underflows when a length is too small. It does, on u8 values
with no lower bound:

assoc_req_len -=3D assoc_req_ie_offset; /* -=3D 4 */
assoc_resp_len -=3D assoc_resp_ie_offset; /* -=3D 6 */

so an assoc request/response shorter than the fixed offset wraps to ~250, a=
nd
cfg80211_connect_result()/cfg80211_roamed() then treat that as the IE lengt=
h and
copy that many bytes out of the small assoc_info buffer to user space. That=
 path
is separate from the aggregate over-read Tristan's check covers.

Happy to send a small follow-on clamping those two subtractions on top of
Tristan's series once it lands -- or Tristan, please feel free to fold it i=
nto
your series if you'd rather keep it together. Whatever's easiest for you bo=
th.

Best
Doruk

DORUK TAN =C3=96ZT=C3=9CRK

Co-Founder


0sec

Universit=C3=A4tstrasse 33

8006 Z=C3=BCrich, Switzerland

www.0sec.ai | doruk@0sec.ai | Linkedin



On Sat, 11 Jul 2026 at 16:39, Jeff Johnson
<jeff.johnson@oss.qualcomm.com> wrote:
>
> On 7/11/2026 12:13 AM, Doruk Tan Ozturk wrote:
> > ath6kl_wmi_connect_event_rx() only checks that the received event is at
> > least sizeof(struct wmi_connect_event); it never checks that the traili=
ng
> > beacon_ie_len + assoc_req_len + assoc_resp_len fields fit within the
> > received buffer. Those attacker/AP-influenced lengths then drive two
> > out-of-bounds accesses:
> >
> >   - The WMM information-element scan builds
> >     peie =3D assoc_info + beacon_ie_len + assoc_req_len + assoc_resp_le=
n
> >     and walks up to it, reading past the end of the event buffer when t=
he
> >     declared lengths exceed the buffer. The walk also dereferences
> >     pie[1..6] and pie[1] (for the advance) without checking they stay
> >     within peie.
> >
> >   - ath6kl_cfg80211_connect_event() subtracts fixed offsets from
> >     assoc_req_len (-=3D 4) and assoc_resp_len (-=3D 6), both u8, with n=
o lower
> >     bound. A short assoc request/response underflows the length to ~250=
,
> >     which cfg80211_connect_result() / cfg80211_roamed() then treat as t=
he
> >     IE length and copy out of bounds from the small assoc_info buffer,
> >     disclosing adjacent slab memory to user space via nl80211.
> >
> > Bound the declared IE lengths against the received buffer, bound the WM=
M
> > element reads against peie, and clamp the assoc request/response length=
s
> > before the subtraction. The sibling wil6210 driver already performs the
> > equivalent length check for the same WMI connect event.
> >
> > Found by 0sec (https://0sec.ai) using automated source analysis; the
> > missing bounds are evident from source and cross-checked against the
> > sibling wil6210 driver. Compile-tested.
> >
> > Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
> > Cc: stable@vger.kernel.org
> > Assisted-by: 0sec:claude-opus-4-8
> > Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
>
> Some aspects of your patch are already addressed by:
> https://lore.kernel.org/all/20260421135009.348084-3-tristmd@gmail.com
>
> So you will need to rebase once that lands.
>
> /jeff

