Return-Path: <linux-wireless+bounces-33533-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MI3QMF+evGke1gIAu9opvQ
	(envelope-from <linux-wireless+bounces-33533-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 02:09:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3E22D495E
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 02:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A4693017338
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 01:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60481274FFD;
	Fri, 20 Mar 2026 01:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3eBLb8S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A5B1A6809
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 01:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773968985; cv=pass; b=U4OXxnh9084cvKIio/Akys23aqOSrJza1KDpKbU6fUWlDzNPAxdKF1M67BV4U9x+JGxUCBOfPdN2QvW1URh0djeUU1dgl4Jxjd1Ro3TX27J9AhA91RlQd/c9EuqWSHvTHFqQE8llDfiVNHJhStT96QAZJ4H1bgQk8s/LfFR3LCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773968985; c=relaxed/simple;
	bh=h9FYZIr2A+hjKh2Rat0BM58nJBlXZ2BpqM81PPfQ/K0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VGcSzD2+G3I/kMbQr7EhmbsnmRpmGQh47XCxt6nTdlv5JpZTA96FeYkV0DWv3hrBxDjsVFN+jg/4NmbAInVKEO873WJiHYOx0zrgyM1CRPRapVMaNmez3HH7luytveksmEDRANUQx0fezxeVeETSzTBO2UGh6sBMyi8+otgrGN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3eBLb8S; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1273c690e5bso152327c88.2
        for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 18:09:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773968983; cv=none;
        d=google.com; s=arc-20240605;
        b=lWNSJ4xpPFrqWbq8SlWDMxQZM0aGn46xFCs1jP9ai7CpQU/lut1xxphn7K69XQsIdW
         +/AOdfMK9XcyOfgGSucIw1irum7epy+SQePtFLegz3tHi0JMKEFn1kfzU57R+yH50ed6
         sPuRvLArXfi1klm09b+LxnRNfWXYPRBI8JZ12Nleox21dcn2O19xVA5oDzqD1zdlDimU
         1ZC3IRe7S7xZyql0tkQpEbj0bCOBVm7TV+3tKyhn7KnZ7nZqkMoJMNQVRxi/0mgH+m27
         xW51AgwGWh4PMRB5nFNmLXhMb22ED+cY6ASPXOwiz/2AiHalu0EjMNWmEpEx+iJAY9CH
         pOuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h9FYZIr2A+hjKh2Rat0BM58nJBlXZ2BpqM81PPfQ/K0=;
        fh=Y1F10pqWWgQSKk3Yihlcy31pAKvuIhkcRjIp07apYY4=;
        b=UdsGEm0CCp/kYxBp8C2KLTPT87kr3NRLW6/Zy6dnItl4Nt4uwh2u1o84D8oK5qyQnx
         VZh3Xnnv9vaVoMtnTAy15uNtCdIQvyqYbkqS1QthVS3g5f1bJSkL2KN97FLsqAD2swGx
         R6VJHVA2UIyc9IzxATQl3ollkvg9FedIWF89un+rJ/OcFpSMEJ0WGK4xQqDAGI/VYu3I
         3t0L0uh/K7ig9aYSto9g71NOcMK54gsZUAJBjf58EZwsIsjWj7fmbQ8UHwt0V2c23axe
         tiuedL2S+8/3m+7gHF93oSJkXFZ2hEs1Ns4/mC6o+7Ni2BMcAC+HNsEweQGFifHO3HYS
         kAyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773968983; x=1774573783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9FYZIr2A+hjKh2Rat0BM58nJBlXZ2BpqM81PPfQ/K0=;
        b=D3eBLb8SMERSTiduHez60zIChtY6z9Zl4PZGhjzA0IM2kPej8NZpxRD1pTDzBvPmZU
         o4++P7qSeBpJnCHWl19x0xye+8qL9SxNlD0JEZxOHKCN1lAUu8cyIcy9woTzRaFzNEg2
         QqWO+2NsR3UgpbeufOWAoCuYs23OcZx62vmP5/34e/JCZZmo9PN5b0zRei8UKnGB3ogB
         GJCyI2ZJYoD3HPXloTbHccTGKjv20ktltTAVekseWrbcUjERU9ZHUajpFw5F5phLjZZh
         iVphky3NGXTvapN4R3Ugkh/MDdhFYuc/R2cmeNUEMKiOgNS9tCltCPVM8GoIqEK48l/h
         HQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773968983; x=1774573783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h9FYZIr2A+hjKh2Rat0BM58nJBlXZ2BpqM81PPfQ/K0=;
        b=KzeYMA+urZcvfoYj4+QMHv+3BV3qy9Bhmzf5vR20BGzpTGs6NjV6erlWYF/HBhiPEg
         EpR7KGD07vVXuaBvsZkO+B+J/64uh08QktuUdCcJni0Z/6sLq6hKDGVXLW2SITzUjFb/
         pPI1n09Cn2G4/CR/aNlYBaDUCnfAHj6EpPcevnJKpSSLAQMEgvlk5lHImgUdQQjhD67t
         jElV+oKrub0wIhRSY6ObQ/nw/A/O2NarBDPt5ps8pyA8aYJQzapt5k1Y6xNvizaFUYt5
         OAlBBGKVCHLSQpszzzxhskDlRY8bAdBgB5IRGs7OrJCVOD8wRP8LxRBwbRQ9a9NlhQy7
         JOoA==
X-Gm-Message-State: AOJu0YxmAgh099nMZ+cVdhx2N7wwu+mL0ArEGfh1PU0sUeweaFPK3I7u
	J9ixlsrORrRqv1iDgdafHsBvxkwVzJm1ysrKwixpvvo5zY4uePbI8Dgn7WyGhP4DDbOHqHhV54M
	eKWD8iqYC9kpjwONMr2wKy8RNeUKKDP4=
X-Gm-Gg: ATEYQzyxY5JOT3qTETSZWK1eBVVNA7QRCZuSxT9u8sBnDYHCmvThiasFO3/Ldneowvr
	LpaB/IaKqiBjJ0LXWkJLmE1ypm9LJBGiR66s/LDvCadbvRbNB9c5hGOQTJQ8r1a4MKEKpLG1xyI
	vQeP6rheygttcBPCJSfpsrVmvYiIecC4QACrcnSjblAJCNlKRrIsyKarAWXtpLbDS/PlkMORY6t
	pgF9My5QjxAQCMUAy0mG9GFOGdPp0htvaA7uS0Hf4QEL0JQWjdQchqofF60xSVMUzkBUoAtaQ5f
	lDJzHS934nvIxpAvmRew0pzdIBisuIgVmrehi2QeJGDlKqHryHPjuJzH5C4vD4qupO0OlYe7T7Z
	llGYOQqGYp5Tcu/bpD0T5qxU=
X-Received: by 2002:a05:7022:e16:b0:128:d0cb:7a97 with SMTP id
 a92af1059eb24-12a726bff43mr275355c88.3.1773968983089; Thu, 19 Mar 2026
 18:09:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319212110.29819-1-adriangarciacasado42@gmail.com>
In-Reply-To: <20260319212110.29819-1-adriangarciacasado42@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 20 Mar 2026 02:09:30 +0100
X-Gm-Features: AaiRm53RYFxkPfVZbSANZ2b6XtRhjcMKERhM9WsaZoNaVlzyvyvD3nvBe7G4URg
Message-ID: <CANiq72mXOgn6dx44WYxL7T2kpsJWwVEL8be3JF7OmKeYauLGLg@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] wifi: iwlwifi: pcie: migrate to modern
 pci_alloc_irq_vectors API
To: =?UTF-8?Q?Adri=C3=A1n_Garc=C3=ADa_Casado?= <adriangarciacasado42@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33533-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.926];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: CE3E22D495E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 10:21=E2=80=AFPM Adri=C3=A1n Garc=C3=ADa Casado
<adriangarciacasado42@gmail.com> wrote:
>
> Thank you for the feedback. You are absolutely right; I've been overly en=
thusiastic in sending successive versions without allowing enough time for =
feedback to be processed. I'll slow down and wait for technical responses b=
efore the next iteration.
>
> I also apologize for the incorrect CC in the WiFi thread; I've double-che=
cked with get_maintainer.pl and will use the correct lists going forward.
>
> To clarify, I am an independent contributor learning the kernel developme=
nt process on my own time (not as part of a school or lab project). I reall=
y appreciate you taking the time to point out these etiquette details.

Thanks for the reply Adri=C3=A1n.

I apologize if my last reply sounded a bit dry -- we were starting to
wonder if we were dealing with some sort of automated patch submission
system or similar, due to the lack of replies.

To avoid that, I would suggest trying to reply to the feedback you get
between versions, explaining your thought process -- that will likely
help both you and the maintainers :)

Please continue learning and contributing, and good luck!

Cheers,
Miguel

