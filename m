Return-Path: <linux-wireless+bounces-34892-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LUYMbLY4GlymgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34892-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 14:40:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D0C40E534
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 14:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D19D3119305
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 12:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89710386428;
	Thu, 16 Apr 2026 12:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCjcX8+U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469FE33120C
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 12:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776342897; cv=pass; b=SfsvGcZsQ0zkwNQnnfpHMrjr/s625D1vh0ASJHZ/sYIoS3nYK1dQQwgMYOYGkxINSjknjLxt8YhLMCza/3NqkDjKAOFCWRi53tIu+0Hb3J2SNx+MoQI5nbeSWZvtYPWyNNXS9NDI8r8dk3J/jdPfYNMa2XGwLiGVlL8W/6OJqW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776342897; c=relaxed/simple;
	bh=X4C473nxsJsSh7dOp2a/Yj9++Ii1sJAJ2NXg4F2E5LI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FUCeawR0KIyBcPRc0B4hoyNHCISUYkRxjdnlw/S20QAaxeewF3CTVCakPGWWV3D5w2cMSggixnNwJB3sSgInToVdfEZNXTvtQMO8lhr0GpVVE6ACBRCy7tVev/myN0ofCRA0lYRV77YTpPnmNL7VL1w56SoDR13YfAi6537SOr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCjcX8+U; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35fc2b18363so4044732a91.0
        for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 05:34:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776342896; cv=none;
        d=google.com; s=arc-20240605;
        b=lCnVdZ53oaewsq2wR8sKT0TAy7NViMmHFXHfy8nyjYRAZjAUvjaj8XtPyjG11m6ASm
         ALMOMmkkuYuCfXjF73YT4JExAn0Qr5+ybtOMdYuRPevawUpzgUxDBmkNUGFQUTbUOYuP
         YDp4AZsbnvm81gmyDRweSncjWvsiNFwDQWi2/tVeAXS/oFJKgDSRwsUcTBSuABQTD+v+
         rU3NObS2iWpTxKe9hBo4y7rxWNePozZ5mUIxL7QzAWdI37uZvn7RvIPzs0WpTg7MBA+L
         YNw+8yh0MAlm7w+csYsM6YxbTbotJAeqg75og3cmK+rIyTIjpsAzGiJvf6PPG6IIKD3O
         e7eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AKbgfl8cjDFtHLlUHMnIlnW2bJEa8KFVIoLVQkyKF8U=;
        fh=C6LApgc9NK0pnnt83W+yqOoTu97u7h9piqaZtLW1yPE=;
        b=cnZPkIx86qTS9QJDpt33Vgj8erx3BPO5H5H4RHscahLFp8lAkqdpzu1bQKMZY0U/Wd
         0aSoLf5KJjoclIO2K2nBmz0zUnTW6jy4QjOdvJ8Hy8eKoLlTgmdancEFcv11sRo7R9Nv
         kMaqn3mhwYU7ZsVkN9lPKtXJoqGl1Vns0oUajKfKdWsKnE2IqolDvlmNCfMYSbFDjGkt
         fYFi+V23Uoo2ZO+6nkx86FcI52nou1YhLFHAmPj3dS0sAmLlpQRmM92yQ2DSdkuSu8aG
         +PYP7seM5zgCrdsw2k7/61aaCOuW4A3CrIFArBJWLURoV8kRYInuFF1QaB/aKXkHfYOG
         EEJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776342895; x=1776947695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKbgfl8cjDFtHLlUHMnIlnW2bJEa8KFVIoLVQkyKF8U=;
        b=LCjcX8+Uxk5yl15AnuvLmOebKPCVEZQCcpA6gMH9A7ZXYiGLIYi8z9ZPRrXnBLnnI5
         qlsTlzEX31L7FeTTcW8TbfBZV7QlZZ2KPPoHi3DdbZsTgCMoe0yAj/inxQxFDbG767ir
         gdVsRjySLnkfkKtMx0ZJ9ejVnj7VHWQvCu/ixLNqO7qs3Ejtg8S0f6rPA91VvMayXfRN
         CDC1RZMhB5m1VoeaHDl+Hc+9Pntl2zWqH7pVxCE6/PdLGHVX18SUdc6Ge7a3PvhNWmTb
         waM+FihIym55Y07bAxlAf9sd2ByDS1Sdg75OG1w47SgLaJza5LWEypCk3Ft+UXOFIiS+
         yWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776342895; x=1776947695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AKbgfl8cjDFtHLlUHMnIlnW2bJEa8KFVIoLVQkyKF8U=;
        b=UrFwAYnoZeqQq7WPvdrrr8/7e/A1kywGcjc3iy0i5/hO59ancAlT0WwjkNfnHHPjMy
         hkkx5b1cGTSXEXk/CinG/WETPJDp1yYAamESuWGfsQhbd8lTnq/My5+lk+t5N7EHNPEI
         LfmyAH2Hzz3zzJP/Y/oGAU2riyQgIGpRVx/fy2ngsCRl+VHOrjYDafnteMefIiSQpbuV
         Y6RtN/N4NYsBqax43hMu/JRKNC4IDFtFrDL9MAQI4hqbhWqfbiexUoXUtra9e7VgnwNU
         maRss2fNjPPEPLTullEubhQbLLgZiFFENYWAIUnE1HMYUoyoXVLEGYeQdex0nGSSo2qg
         xW8Q==
X-Gm-Message-State: AOJu0YymgU0nbLecv8RMRwuQ03hZUcMfEKoxnMFWEUyjEWDec+K1esbg
	o/oApcPDy86p4OokYHElibSNbj0iFkDrNXlic+UbVKaxvvSb7bFwljWPDQQXPmkGvdb8nSGgODf
	cc45Y4WXDE4JUCmzFNoDFd11gv8bQLPcIfgQS
X-Gm-Gg: AeBDiesflCOYLw3EiwbSS9CHiAYOmwNF9luC5irGqEavz8ro6v67klS2VpRyay/onxh
	79WoIstKE/LaaJ9a6R+VGKCU0B4aJUuatJhd6DhIhivXTXEX9zJfWzqN+s0tHEjk2X9WbnA4bkk
	RWa3ykJ0zyDLi5ERM+XqlJEvML9tGGdAZVWwcDlIXvoOivqd7B0zS71uWe1xrPtfxKzwdQpds59
	x/fY2ZfEXTgJ0nWkvgIcJVQdctLSqclkCPSBUIosxKqIEyPPhv7GNfdf9Nx0RnwACcLl0etlNzP
	Mc1Bpz9Oi6nPJbJmO2zQog==
X-Received: by 2002:a17:90b:3d86:b0:35c:30a8:319 with SMTP id
 98e67ed59e1d1-35e423f41c8mr27076015a91.0.1776342895485; Thu, 16 Apr 2026
 05:34:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACM6vn7QGKQcR5Rs=wmzNA-SgMDZX4Hw=UiPQHfYkWgLURcbAA@mail.gmail.com>
 <b1a7678d-8e87-444e-b38a-bb7aedcd4f30@eskapa.be> <CACM6vn6UXfSXw2WpYvzF+ODPGHw-LtsBMgtvc6n7s9iF9eaS6Q@mail.gmail.com>
 <beee4be9-2bfc-4c38-ad1b-13ecc7d90aa3@eskapa.be>
In-Reply-To: <beee4be9-2bfc-4c38-ad1b-13ecc7d90aa3@eskapa.be>
From: Benson Bear <benson.bear@gmail.com>
Date: Thu, 16 Apr 2026 08:34:43 -0400
X-Gm-Features: AQROBzD5gawCQhqONXB1JPHx60y1h1FToFnQSpXQNYAlyoPqsECgF9QjdguiWI8
Message-ID: <CACM6vn7Dau9cX4tUCVQZmEpRmd7JiNtALUfR_fFARMbR_VZ_7A@mail.gmail.com>
Subject: Re: Wi-Fi speeds degrade from 600Mps to 30Mps while using WPA2
 security, but not on open network, shortly after ISP firmware upgrade.
To: Pablo MARTIN-GOMEZ <pablomg@eskapa.be>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34892-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bensonbear@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,eskapa.be:email]
X-Rspamd-Queue-Id: 07D0C40E534
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 7:47=E2=80=AFAM Pablo MARTIN-GOMEZ <pablomg@eskapa.=
be> wrote:


> Given that your client does not have the MFP flag and you can connect
> without PMF, that means that your AP advertise MFP Capable (and so is
> your client when it is not disabled), and following the association +
> 4-way handshake, the AP believes it has correctly negotiated MFP but not
> your client, so the AP is sending the client encrypted action framed
> that are dropped by the client and the client is sending non-encrypted
> action frames that are refused by the AP. The easiest way to debug this
> would be to capture over the air the auth + assoc + 4-way handshake +
> action frame and provide the SSID + the PSK to be able to decrypt
> everything and understand who is in the wrong. If it's an issue on the
> client side, it is most probably an issue in wpa_supplicant and not in
> the kernel.

Thanks again.  Sadly it looks like linux (the wpa_supplicant) is
in the wrong here, just reasoning about it.   I assume the AP
always offers the option.   It doesn't get a rejection before it
even makes an offer.   So that means when it offered it when
PMF was not disabled in the client, the client must have
accepted the offer.   Because we know in the other case,
when PMF *is* disabled, that it works fine, which must mean
the AP received correctly a rejection of the offer.  So had
the client sent a rejection in the first case, like it did in the
second, there is no reason the AP would not have accepted
that rejection.  So the client must have sent an acceptance.

Not iron clad, because maybe the AP is just plain crazy.

But it seems that this craziness would be hard to accomplish,
since there is nothing to distinguish the two cases from its
point of view if the client correctly rejects in both of them.

Unless you can say that, contrary to my initial assumption,
the client makes the rejection even before the offer is made.

I was hoping I could go back to Rogers and tell them their
AP is buggy on this point, but it looks like perhaps not.

Unless you see some other flaw in the reasoning.  If you
don't, I will take the issue over to the wpa_supplicant people,
if you think that is a good idea.

It does seem weird, though, that the client here would
send an acceptance and then not carry through with it!

(Since my own problem is solved I might lose interest, and
not be able to carry out the over the air examination,
something like this I have never done... but still we should
get it resolved somehow)

