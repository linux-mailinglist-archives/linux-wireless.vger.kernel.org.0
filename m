Return-Path: <linux-wireless+bounces-31581-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBeoAGBShGkx2gMAu9opvQ
	(envelope-from <linux-wireless+bounces-31581-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 09:18:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAB3EFCD0
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 09:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FCE4300C009
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Feb 2026 08:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC5935CB6F;
	Thu,  5 Feb 2026 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJPTJ9oj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77473355042
	for <linux-wireless@vger.kernel.org>; Thu,  5 Feb 2026 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.194
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770279503; cv=pass; b=jCgzfRQMqK6FuAvCq+KfGNLlIhMZ32hZwplrZ0xwVJP/IZr8NW6I6tHm2CsZcOC8LwyCwfzmB63/eiMGVip/9bKby9aCK7c9VMFKmfUkJ09yBllmxZwemnbab5hWC/s1p0RDzS/V7MK2gxRl0k3p83NkXzSyYGxjnsxoOU5tat4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770279503; c=relaxed/simple;
	bh=dEHmEZtfljzeKDJhyqfkp2NPnFNEfyMYV12kR3/lE68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l1ktDM2bwKCT+FdG59Jqjz+IgNoM0xhwzEIj+9R2XJtW9KeYHrbQp2JVHhbcCVyxMrIyMzEfcCH2VdEWsAwS30BNorzfX/z6J7wjatVJdWEBqXQvVD7LWSBmsJeNDow/XTj3qSoenw639/ScfejYNXF3O80koeQEs9f8Ihnj7Sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJPTJ9oj; arc=pass smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-50143fe869fso9228441cf.1
        for <linux-wireless@vger.kernel.org>; Thu, 05 Feb 2026 00:18:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770279502; cv=none;
        d=google.com; s=arc-20240605;
        b=PCvORbObPnjowNiyeRM0drPhXUqgmuHOk2ds/onxwX+Qui5PVxTj2A4VBDUfz70oR6
         BDNQVfWhEvZWmfqVBdHfSoBw3lHeB/4V5k4MLd70LJghPjqfnHdhkEw3Yq4//4y5g/9I
         sL7j/CDatxZNNcu8vxNlPaLeeBtJdUQyyIorIvzdY+MbUP01BHUfwKu+lmjCCjkvBMgt
         n0Sksl8COp78G6vcaYhjfRxzeDHICmOHEqABy+AwbAgP4pWXstj3EP/LvK7Ujs+N/H0a
         FloDYyYS/68qx/DVPNp5WksTrZufxtDHoicf4Aeo99Jk68y8CPCsyWHdITQrMOC+4ehh
         ClyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dEHmEZtfljzeKDJhyqfkp2NPnFNEfyMYV12kR3/lE68=;
        fh=dq+Bwpv/XR2VaxZ+lUKcPIisCgplfv8JWDJMJmgO3xY=;
        b=eZx+89oaqrZ7uREOu6573oKIXdbLR15MVrUYy7UH6c8LMxcu5vPyqEAnniNuJyh30p
         db9UjiHg235Sguuib8pMP2cK4N8pUi+/iKiVqpZdE8sdoAqL4U8My9IcxYpEPwGVYp3f
         Xb69/lIGHx+ZutmDl6Vvro4wxyB2puAeBpS2s8rx9i2TSyUMFe5j+cFvIiqs5ZbjpIvW
         FWYZDRvSX55lUWvWS1yVGeFihxK6mTTSwGTz0keKGWmByGad59ZEd+1C9cFXrOt+g+eN
         bKtZJ6g/6665XVOhsuqGPFRQs1+5zLax5kY7zlIxN8xC69GySdONS+EzOD5iJIA1zlMs
         qi4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770279502; x=1770884302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEHmEZtfljzeKDJhyqfkp2NPnFNEfyMYV12kR3/lE68=;
        b=WJPTJ9ojBzj6DNngLToHBl2X0/oGQkvDV4kjObfvklfHyT6N6h42fRgzVndYvLmvvE
         1rEDuviD0PcCOtMDJRCz/1YrrLSHJYDy0Vg0Q+5bqs002Y2yabAg5l+XRHhBtH6Uv1gk
         yjLtOZRkfMLvk6FV7qMH9Rl1q0kjQPcDZEIFVOTdqduBtrCrxBAjFm6t5FrfEzirSkPC
         Kp96uWeR+YJbgO05CABaas7bqUluLGO9Wc9LQxVs82P+UH+SoUDq4iEK78B+6NdgOnSh
         11J4ueohKbX4T53An8eflVAqPzWb52/3AkBa/1tZeF+Yfcb8Y5Z6P5ONJYwL1lGHWtef
         BKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770279502; x=1770884302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dEHmEZtfljzeKDJhyqfkp2NPnFNEfyMYV12kR3/lE68=;
        b=Vj4u5eOoxxhZYV2eU7yyfiedU3VGB2e4KzgJh9vBfj61l6ng8ePuwqteUaGc7J0wvK
         EzN5KxnGhvQog8MKiRKg5T9M/ziHmE5T9YbdXLlqUzCiXow017H03uBjPnKZIlF8/njJ
         dJ7hO0HHQIBc8ydUTHmhdamFdmApiBavG+icQERQFdDfQET2OStA8MHu7XN0KKbbuF/I
         1CmJUO0ZwXYR2n8sklP4/SCLVU1YjOT+lx+H6Ms3x6weD2T+VY3qI3LU3VuK99ETZu7a
         sCOONCwbeF1zFd1VVfVrDeBDEx62Y+dYSGyU0rlHopDjetEcD0wCD07oq3FdM5mY9UoJ
         tU/g==
X-Forwarded-Encrypted: i=1; AJvYcCVoi//58F0Zdi1QkkYBA8Q5/kqXJ2KrGDxF8DgEeFHVWxtipgz9aw3K/GLhunOvpAc/8Ht+5jtmqSplnPruLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ1TlzflOn3F0GI7nYAHGN6L8/JZ4EiSlwMKelX/mQgFWZZ/Pc
	zNGnq+tbfzfOjGZkMCe1/n9oIPGmXnctS6UTqsBozwZ8l+icUnvaRngyTa0FMJwWYKovU7TXYtF
	b4JHZ6YBYti3C0mS7d41fvXyTVSf5lPc=
X-Gm-Gg: AZuq6aJvyqmB6j1J8mWXSGVEHQDrGZMFDLX/sR2RIzZgxpznEnsRObQ6YFbxt8u6yT1
	lodzxFkSXb4+/vvhLe4H1S1PyL1JZpkXxyGJcngkpWMO4gapkevGE7FQ3NEGR2D22yS9fvTw9hU
	1nXZS/uu7WO+CuIrp95JDJnKN1R8Eh7GRs5AEEm3BrwFVC9BjeRoj99GrqVB4vyJa2E+Q7xDFNh
	CG+4IxA14yZU5R7aJM+mxq71tOtv5/y/KDTuAuB7YCh/Z2Y4Zghym+Nzgi6z/Ljw3K9RJHxvPoC
	z3uFpjvhdgkc0FIPkzbv4moObnnPd9yK5GBudRr1hwMW3oTNRiC1pCkez7/MyBRKu3I=
X-Received: by 2002:ac8:5942:0:b0:4ee:275c:28d7 with SMTP id
 d75a77b69052e-5061c1e24dcmr70234931cf.75.1770279502432; Thu, 05 Feb 2026
 00:18:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205075445.43347-1-enelsonmoore@gmail.com> <IA3PR11MB89868B6110780F90795E4ED7E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB89868B6110780F90795E4ED7E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Thu, 5 Feb 2026 00:18:11 -0800
X-Gm-Features: AZwV_Qi279RFUb8dryBzOPG7K4OPVJ4GK9tbcGC43GVruOveblEFmaOLVgoO04w
Message-ID: <CADkSEUiNrMCGzECO2t+Stx7Xnk=bCAp+mk=99FrMZFq4wOmgFQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: intel: fix PCI device ID conflict between
 i40e and ipw2200
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stanislav Yakovlev <stas.yakovlev@gmail.com>, Alice Michael <alice.michael@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31581-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,sipsolutions.net,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4BAB3EFCD0
X-Rspamd-Action: no action

Hi, Alexandr,

On Thu, Feb 5, 2026 at 12:13=E2=80=AFAM Loktionov, Aleksandr
<aleksandr.loktionov@intel.com> wrote:
> Commit message could be more detailed.
> - Why the PCI ID is being reused (if known) Is this actually a reuse afte=
r EOL, or is there a misunderstanding? The commit message hand-waves this c=
ritical detail.
> - Whether this is documented in hardware datasheets
> - If there are bug reports of the conflict in the wild
I don't know any of this information. I found this conflict via a
script I was motivated to write by noticing an ID conflict between
r8169 and 8139too.

> If it's quite critical fix why not to send it to [PATCH net] ?
I used that prefix because the patch is against net-next. It will make
it into stable versions regardless.

Ethan

