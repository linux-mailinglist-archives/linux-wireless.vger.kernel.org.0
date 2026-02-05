Return-Path: <linux-wireless+bounces-31582-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GH1uM6tThGkx2gMAu9opvQ
	(envelope-from <linux-wireless+bounces-31582-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 09:24:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 025CDEFDAF
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 09:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 929613002F45
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Feb 2026 08:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE720362141;
	Thu,  5 Feb 2026 08:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfS3vu51"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8018F35CB76
	for <linux-wireless@vger.kernel.org>; Thu,  5 Feb 2026 08:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770279845; cv=pass; b=lHc9mkGD465Jw2Tx4YoOU0iEzu/RmE6we1OEDNCBVTjwVtAaflqqJhEKtUKfPuIGDMwIO4Skm+N0KFiSje8XUxaFNj1LIPtBT8KYtW7UPvSlIwUaiXnYytBI89SoswnaMVQCw4vOLguq4KCqsgYhYxmjSzZ+LEQaN6JzHb95vzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770279845; c=relaxed/simple;
	bh=GX3DfIw4/nlUoK0mVdD5eAocRguJPk8NCBMsKIhLbTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXaK0g0P/jDHNsRW8gI0ViHbD6LPtbiCkajasUaEySwHs+r/U+PtaNaYclFCefK1SkRYZxdT87GRtQCVKrDAYGlCtonkru9Gbl6oZkG08I0rkfNWicNdIthT9Bh49qFo9ze2y6OV9i+LsPsoTgakndPUk/lMrRkyoz5+avdXB0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfS3vu51; arc=pass smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-88ffcb14e11so10095706d6.0
        for <linux-wireless@vger.kernel.org>; Thu, 05 Feb 2026 00:24:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770279844; cv=none;
        d=google.com; s=arc-20240605;
        b=WVJI0RfPb/FdIgMnBqGFaxuCr6/Pu6f/UPRwJ+MJoQkzPhn3Q6fM5N5H5CgOn8WZtM
         qn65uyuD41UV0LDMxMzaB8g8ARo3LbQoMQscrXbnqxfQxW0ECBHNoCkhVx2Dl2dXRAxX
         Pku2ScXMg4x/nGZuh0+/0uzo9TuWEgwlP+kc4VrNOg+K14qW/Mdd7zbXDUI22FwCnrCZ
         nuSiv4chYYoMfxCEaWe7BAV6iTl+gpWh++OL5IXdVwCXYI2YUcLb/uBQubcEwOvqfJRb
         5vf829/BAwNEAHWFKFwgKVgZntVeuqDCGI+YmV8PLkP6vgRGv0JG42KBKYZ9VAtymK1s
         XoDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GX3DfIw4/nlUoK0mVdD5eAocRguJPk8NCBMsKIhLbTU=;
        fh=al7R+0odqwO6sTtUrOQmAdgZeMotpgXa2CO3T3Q3ByY=;
        b=itktZXhSMGMyLpzW/hwCCfbR7h49GYvTutiR5qed6mTtexCzNVNTHkbpp6WWlvmQ5r
         xNZn4ulbsTevtemXw/D8DwlKnaXY4EGdoyBfzciwIzIkyAQS4HvoL85JsYn7KyhB33CU
         4JY+k+NXgYDBKo0shWBg0aeiEsYO8o9eguaV7nW+a7cxHTFl9EsibGLJc44CQl1uxLCa
         olTgZS+doSs2dEX/YAt56MQIynn1dSRHVZi8SNtq5oVVw8oLJddKQiLphVuwPTmQwC5c
         d7o/Xkqt3n3Wa3F9YydksMlFEis4Nv/0EUntIYNLVi0gjlUfha3t3NA/4m64KTWlo70b
         wELA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770279844; x=1770884644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GX3DfIw4/nlUoK0mVdD5eAocRguJPk8NCBMsKIhLbTU=;
        b=kfS3vu51fW2wed09gbRGs5gmsjV0kZ/+69FnEXKeFlgRwraur+QkPD/f89jEyt8T+I
         YeN0sCBXopttTJWC0VUp6B81ItdQd96eSjDLsCkWnsccVYf4qmsodCzIAfB7/0hAZreT
         hsfwhpmdYr3kE5Gmc8A4GbJlkNGkVtxJ0yXgvOwqZKsaNSzEIu1e/R+BrL12ukW4iCM0
         ysa+Utqh4NYgBFOUAFE1bfGPhl5OY2EfCt2LmvuvtiZP+EY+s3hDMEdH+NfqeMRJOoq2
         vt8SpbDIImmE+XVRpF7QyS09cCeE/JYGng+5pFdZS5nN7AfhSFhld/tEx5F+Z8IBSWg/
         NNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770279844; x=1770884644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GX3DfIw4/nlUoK0mVdD5eAocRguJPk8NCBMsKIhLbTU=;
        b=SjsYwasdG0CGUlX70wOJ9chiB6pAV2cpSJH3S4l26cAdumW9C5KwEyw8ItTq3hkDWn
         7uhA4THakuxNZmFPchzte2WMJmp8az+corrqiogZljGyb47G1T7vJAaSJ5h5bCrWcvQO
         d+QKra+WXiWXYY1H36Y+Jl9EQ/MkHWMCFTGPP25zhJF40r6i8FvjxGXmF4tOPPKSvToI
         7BMGICGDY4Ri2cM7c8+j42R3abMvA4NSxOCTMRno7NJw0V3PvJ6wlaMOUGs/TGetVxF4
         y1E3sSp0EaTd71EOPhdXmdDSch0WYbnBHHeaDnn9b9MCofrAU1pwTI47nSBUGkSWEhDT
         oaNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZvmtb0BWzt6Cb0Qk3BkN2/Zwk29z4xBcHKVFtY7zeYE2EXseAkjBiqXz+PRgXgN/vk1xoxDcyuexVtpKnXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+1vWXz3QtN+FuGEy8VQG6KizafkMDKIVDgdVuQfY6ESQSZjwk
	YxOUZYRJqGK8Egz/yEnuK4YBgLzl+0nt00Ne8pb3I9YzK9hAElwBLx+FcxeKUGx5DHs0iDecFbV
	xbHG8LXDeF7OqUDLaaBa8MCbTAh+VIHA=
X-Gm-Gg: AZuq6aL5eRir+LIxa4w3kWQMR9pGqrah+xe0ZKT4jerjKbGnXi2Bb0aLrlK1emMVeIT
	31ytjVx5qRhTL71cIjf0OxbrSeJUuE2oxK824BhoUuOeNmalBggIViV7rjOAe/tX94UzhTFZ5rI
	jctH4dtDigTdLaffCBkDY4wtS1almLTPjH0GlbhZPp93uHMJQl1afCFZ9hnT91u5n6aSs19dhRi
	nvnVF2sV9sQAdWW2mTG6sE7cEggJu+/VNAZsrrIXxEcUlkJR87w2la6NDZiSdnZzgNj++31mNe2
	qGdes04LFnegHtzFObdHkwgrRdzd0U5N4hcTsMWhhz7SE9SP0IK5gJb/2ItiistWhG4=
X-Received: by 2002:ad4:5743:0:b0:888:883d:ee7c with SMTP id
 6a1803df08f44-895221c64cemr74556836d6.58.1770279844313; Thu, 05 Feb 2026
 00:24:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205075445.43347-1-enelsonmoore@gmail.com> <b7a1e57d6bfde3ea5c9204323341a74325a63ab8.camel@sipsolutions.net>
In-Reply-To: <b7a1e57d6bfde3ea5c9204323341a74325a63ab8.camel@sipsolutions.net>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Thu, 5 Feb 2026 00:23:53 -0800
X-Gm-Features: AZwV_QjDshPtNQhbiRoSQ7v_pb5laGun2CBxH2EoHYYJ--lOze85oiN7TE9ObVQ
Message-ID: <CADkSEUiQAZidhX-CJAiTCm3c8PQNM-uenc7ExGg7d2KUVTXyBg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: intel: fix PCI device ID conflict between
 i40e and ipw2200
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	stable@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stanislav Yakovlev <stas.yakovlev@gmail.com>, Alice Michael <alice.michael@intel.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31582-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 025CDEFDAF
X-Rspamd-Action: no action

Hi, Johannes,

On Thu, Feb 5, 2026 at 12:13=E2=80=AFAM Johannes Berg <johannes@sipsolution=
s.net> wrote:
> Right, good solution. How did you figure out that ipw2200 uses OTHER?
> I'd thought about this but was afraid it'd also just use ETHERNET.
I used linux-hardware.org, which is a database of user-contributed
hardware probes. It didn't have any entries for this particular device
ID (which implies the devices affected are rare in the wild and might
explain why no one noticed this before), but I looked at other ipw2200
and i40e IDs - it shows the class code if you click on the individual
probe ID.

> (FWIW, I've found the database internally, but not who maintains it nor
> any historic information in it ... still digging I guess, if only to
> avoid this happening again in the future)
Thanks for looking into this. Have a nice day.

Ethan

