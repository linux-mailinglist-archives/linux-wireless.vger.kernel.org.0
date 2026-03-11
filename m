Return-Path: <linux-wireless+bounces-32997-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AaBBdfWsWnVFgAAu9opvQ
	(envelope-from <linux-wireless+bounces-32997-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 21:55:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8399B26A2EC
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 21:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 550EA302A549
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 20:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B562DF3F2;
	Wed, 11 Mar 2026 20:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuBSV3Qm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3783D2DA759
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 20:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773262548; cv=pass; b=ZtufDPXcGj0KXyNtwN0pUGkR3LOW3ntjpNhATg549L3dYbbCrLKiiIESPWc5PMvAcTLiHVupkvIFaV6JfU12yrVBpf19/QN24xZN+kaEyR7BhHDJfV1O9DCLKM7ILY+Pi/FojBoZFE13LR7/WWo+9hPfj8/lrW9wA+KIHOu18WU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773262548; c=relaxed/simple;
	bh=/z9d4Yy+JbTXsyKEjQ8q3XZpIEuA3YXvuFn2DHuoW4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uI6mdwXw+rVb31wC+maqmhv+eqrKhJBUGNY+dFIEBwZXPzGSa34oiwzMbknFwbQ0nxFP9d2xHMHlAYlld7OikfcESiAx2mRkUVF6xJTlgoUMpUtGPDJDecbFB5yAPBtk42AnJSdvAMty0jVuauxpCESbsjAZqDE7UlnYAzsJYM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuBSV3Qm; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-661d20c9787so379550a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 13:55:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773262545; cv=none;
        d=google.com; s=arc-20240605;
        b=f7i2ADL6naZ7/nf8VQX/WtFVMC4z4/q/E+MhsbVO0gdyMw2e34IzL0i2xXGYnp409Q
         U2Ew3W0ATJC0SobIdKTy6G1jMVYeMXGIQuGltrwqXdHv4E4c9FJGzZKs12T2OUGLbLbm
         QWertH9kP6YfjefZG3EroNW/fjIcFtUjlFy2/J9Mo+zfHrCgZ4NknquRYn8cfi/3GdjH
         b6SamAXMzNguycd3c8UyqldCV3qcujYZqibFb7O6vZA6p6PIuNvd1KquxivM7N2Iy5vj
         yoScxY7mPMdgvo3bWIeXsXYglRzEEzaNk3cJIBYfidoBTiolrLzryCgdYL8IM3tm4W+a
         KW8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E0VNfV7tCxEmtjzb83AyCqRFqhxI3HDw0zXzskLFZxE=;
        fh=MXkW9Xo5Ym/gIF9EG8Fk1lbc8jJJ90IIrm4Se6meZo4=;
        b=Cq9Oe15FMbNFtB5c1EAJpacLmtYeAT9ic9NytotiAY6Bg+T6HWkAcV/8vkXlP5BiGn
         0y2xs9BnLgQPe09eSEdbCAZH2QNMoze6r6y2R+uQ65y4Lj5gitfmxq40h7p7lZ3o/vMt
         yj7AvPrXJ6fkD0XIxBDMzp84jRmnGATHubMc3j8Nj54rfAtMwvLpGn+NUt8EBMyrugVk
         2OihOEpXDMsLbCMs6CF8TtYJWJAEdmm5gzBd7XUhJJ9gsFOGktECyq+NnOQPh+SXNhKs
         xuilroruiuh0LPLbPFWhb6yTv7SI0TeM+NILTbQz0UC4+4xI7NQ5BqvZIvrtdhVLgKrb
         TPhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773262545; x=1773867345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0VNfV7tCxEmtjzb83AyCqRFqhxI3HDw0zXzskLFZxE=;
        b=VuBSV3Qm760riN426G5wI7+tyYsHTgrEkhNsUzx7k8vq6EFI88NBy35Aunz+4+HJaw
         GnK0bGhgMRtNy+1w4kE7XiwgwSHsWCc+VmNBly0nx57srfaFOUHfUg8N3x+YY0w8KRVO
         2cdVQS4lhJy8of6awyYyEogolI2XSKWcS7wrN6k1OS2K3XrhJjG0HpxnF387WsRFGpYx
         +C8DtEni6lL2hU5ESDt7ybVrRfqgyONkB/VY8JE2ClKWqcyJYjFY/b7tlXpxP0ROjncd
         5ZmGkOXhx4plec0yl39WLJKXKLFGLGM48GmcWt4pKvyCoa4nTGTJLteGSKkxA3Aanmfz
         cRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773262545; x=1773867345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E0VNfV7tCxEmtjzb83AyCqRFqhxI3HDw0zXzskLFZxE=;
        b=PJ2SE3jjatrLRbdvVipaQg97pgXhqS7xtgrevdRmZDaDV24b4iSrspyG3ynsGPJj9p
         aH1X9J+g/KbOBN6i9fSS8WyJxOafL3X3KYnlRh3zUylpXt9oqaUPWM7p+LZ8QhFulHZo
         Bdo+b5fu3H5FkANk9Um5QTpMBu0vCJ7c4fbifjLPnuyTG3pZkovKeRSs5i/iInnDxvUS
         jrF9LLe+a4EsGepw8Wka8G1VA2AxnPxfv/uNEzk0Y6Fd+pcev5SRTWJoIb+mRQDQkxjk
         jXsjD4yntnBAJfFeJbgvZ37NhiLtAVKdF/1oenaXYKjg1X3nptKcQsj+0K3ayLqhx79o
         eOiw==
X-Gm-Message-State: AOJu0YyzAjt8hfIQYoMsXlEjYfMAfBOfO5Jd4qoCdcSgsCn5OySG42NA
	Z79k++92mmcAQm1lHuRMesJM79anqlVnPIp6apdlLIodr8HtkZamHezTmtOrb8LFDRSCuWQvIjj
	4jOClp0UfK1AQX+ZJnwcmH2M7xYHBc2ZO92IF
X-Gm-Gg: ATEYQzyjkI6csfCNodJ42GoNcxrHRfnNQ0/EwI4f4eAosYWQ5+8i3X2Ql2g9ALyim1b
	woshzkPkAHCJ6Ee6IcYZA5Blp9VJhTKD3/tMPnvP9+c3DDJuaftmHrWrIRuKGL+HdFqrOd5eQ5d
	2nJOJ9UOHK6oEnCgzmo3Kb9AOePR+yI2bO/lRtWHHU94H9JIk2U4v4FtrmejvdqEBABRGs7Ges3
	nHRAoIgkwd6fZOpJnHzeytSKMyMFQhKoHyG/Aq1z74hfkXREGnrbnX+Sce1V/BPQms8U2RF1st2
	gwE+3w==
X-Received: by 2002:a17:907:7f8b:b0:b96:f0a0:c7be with SMTP id
 a640c23a62f3a-b972e4e65c3mr258431666b.24.1773262545016; Wed, 11 Mar 2026
 13:55:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANAPQzi3BkfnRS4CEXAA560O5cO8e6MEYxeVVx1u+xUeXS-gmA@mail.gmail.com>
 <CAGp9LzoidBL1iYYC371+Fw+drbArLRTneJKxCoFiitx=dweKCg@mail.gmail.com> <CANAPQzjiBf8Rqphn2SypYN2O6bddj6vB=63Mp=T5YVEt2oGvyw@mail.gmail.com>
In-Reply-To: <CANAPQzjiBf8Rqphn2SypYN2O6bddj6vB=63Mp=T5YVEt2oGvyw@mail.gmail.com>
From: bryam vargas <bryamestebanvargas@gmail.com>
Date: Wed, 11 Mar 2026 15:55:33 -0500
X-Gm-Features: AaiRm53s2BHcShazZ_pjmigUvkBoNI8RYCyLF6CKrVcuvllGJ-ue4U9Rd67-g0I
Message-ID: <CANAPQzgiE1rMP3F=5NJg3hp2uBXtq44+vTRBdkHwdfHyXJ8MQQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mt76: connac: fix txpower_cur not updated in mt76_connac_mcu_set_rate_txpower()
To: Sean Wang <sean.wang@kernel.org>
Cc: linux-wireless@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32997-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bryamestebanvargas@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8399B26A2EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Changes in v2:
- patch 1: implement mt7921-specific .get_txpower callback instead of
  updating txpower_cur in the write path, as suggested by Sean Wang
- patch 2: trigger USB reset only when mt792xu_wfsys_reset() returns
  -ETIMEDOUT, avoiding the race condition with async
  usb_queue_reset_device(), as suggested by Sean Wang

Both patches compile clean against v6.18 and tested for two days on
MT7921U USB at 2400m altitude (Bogot=C3=A1, Colombia).

Bryam Vargas (2):
  mt76: mt7921: add mt7921-specific get_txpower callback
  mt76: mt7921u: trigger USB reset only on wfsys timeout

