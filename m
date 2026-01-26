Return-Path: <linux-wireless+bounces-31191-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Hd3Bwfld2k9mQEAu9opvQ
	(envelope-from <linux-wireless+bounces-31191-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 23:04:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6828DCFB
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 23:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0708C3028C0A
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 22:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECD9302753;
	Mon, 26 Jan 2026 22:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeB0gI+/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3212FF160
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 22:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769465086; cv=pass; b=QBxn+2AY9sKXz/NChOC//q6b1tqY1IKZdLQWnUW5smrssWJg0L29QozyifLz7r1Vck0DHdpc6lNkjBSIkh+tcSqcVhOIpGjSzG/xcpU65jjy2kEVjJ0toq3p3YbHUzbhHpl/6TAHAXPsQbRi4C+ii5ScxjYbVa6oDB/hpu8y4Lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769465086; c=relaxed/simple;
	bh=7YG21uS5Q3aTxJoxgOLQVMsuQQQPt4JTzGp95ovsFsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxevATwcDhsGMPoT4Cd1YyGfYB052gYVMV3HxFVU8XvZTVSuxn8Zhwd0VlOcuMVB2CDNd+Iy6Te1Mt8Q3HLyIwVWULYgDjiipASzhxk6gj5uTgoNrB8sX6/4ilu2IQ98Wmrkv30GDSaBFDRFTue98Hmfy9kfYuRZzjj73QbdhJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeB0gI+/; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-790b7b3e594so51648787b3.3
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 14:04:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769465083; cv=none;
        d=google.com; s=arc-20240605;
        b=LhRAS9q512u2BZxh37z7FNbbtErMcxxuiuF4Qtl0r591Gk6X6ovfrGucoGeUo1zhEa
         AUBI/bnWW4Oi+2OT9USyKWpGX1XZtj9pJfDwO/GmcabA2RhKsKERnV00ZmQeRNkRHPBp
         3SOL6IlRw4vwh+ED7j/ob0PRBAu3UbgQspAyhjK8IxUPCxOHGtSVzCmDGOf9WrZpozBr
         3lUB/wx+OSQIqXnWgElLoRdVo06X1eIAhIaS0Zy9ywQ+VdyF78segbsDqdch0tRwCx9x
         65fvgF+vcfXggo3hl2cc4M27zckvHOflejwgxYEZpCgQkvf0GTddi3tHgnRb1udBiN8L
         Zi8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7YG21uS5Q3aTxJoxgOLQVMsuQQQPt4JTzGp95ovsFsE=;
        fh=T5IxPbi3VvnpZDwR0gb5lLL/BDvrUcSstBG9Ma838Wk=;
        b=J1n3nLCIamTaNOMCIcmg1M+Wg0Y8Q1WgS7abs6MdB06q3xXhst7qYXy7T6tryYb0d1
         ABRjJcrzQ3wCrkx0VhHn+9KEs7EvrZMe4LbYscGP/aVQ4suFi2vvZSYxxKQChAtlp9hJ
         3QnkKSOFD0xjh9SfHMjoNtnwjLcTr1kaxu/bYXbvy+uXV5AjwZObDtk1Jk76J+cKXNwO
         BDcSqdfsXJbxMS9sxDdFLdybrTu36nAd5DszKODsrxOyB0mUUKjsYGDrmMrDcTITYSqb
         eLv3QeCq9qKBrsDqIJSAis+Yum4HJjmN6AXAeJgjsm4HvVz8lFVMakMIKBLIrFLfULsU
         SUbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769465083; x=1770069883; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7YG21uS5Q3aTxJoxgOLQVMsuQQQPt4JTzGp95ovsFsE=;
        b=SeB0gI+/2Wx2lV50hnRI/YgaHZvHsKB28MOlNnzpAI5vdgs7gZiN4AB425/Hhclvjz
         bLhN3ZNejxhIoqyKoVyviDlSJkhUF+379Ghqa0cmYteBzLqorjm8Zw+JZREQGziTH58P
         WmKXqRte247yz/AFC3xrDqN70GtoTNspJXrpHCkvw11dkRPusn47aQOkiIBApUDTAAjZ
         hgzkqsZl0MRTh/jWLLLytrleb4wtwlidiJMi4HecXnS32JShIY8mGKaCC+zBPTutZi0i
         oUW3CLr5O0QzInsOQPjf5U1HZeVvJX9fmmkCqwr2978ua0z4Zj1Qn3U9FbXH/U9nYIzD
         rZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769465083; x=1770069883;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YG21uS5Q3aTxJoxgOLQVMsuQQQPt4JTzGp95ovsFsE=;
        b=ACiYJfZdWVz+sWLzQ8lesCjg+Tljf+gB1dE/yTg2H8sqMKT0xBUTFjxtvm3StLQOuU
         RoPEZR44sODb20PFsAS7QE90f9H7hC15GeFtb03MmF2xNhf1iMVntR/LOpKQv0tigw5S
         YY/TJF+rZo8Y2axOnSPS5pulZYn49aKLnm2S99paF3D+/yK0R3P8qEY0rXYnxfCyTGfX
         ArfrSZzhD795pwgdp+IetxDXsKS6IKEmVPdqcOwrfYMBWC33cBOpxVGYWEhFbMLB1LF9
         ddO1kvhyHw8/4btwC++3Hv39DG20j9seTQFh6adggMOTi4H6VxoHKV7KdxdzsbfelwIL
         LTPw==
X-Forwarded-Encrypted: i=1; AJvYcCUmCI3vV7LXl4w/0qaK8MRdLZZCuiQ6Puyviztx9NM9U4fNgqEU7LwHZlQA7n9QnKrgYuvAJsxvqiExoCrHBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdlQMpi7+t0vbCBYF7uYax9htZHi72Uu9PioznNm4lRzIocyes
	+tLTGGYqB/tUnvwXZsTL3ZmXyK0KDSvY4PRrN2sxm2/gNWiE+ceNp6AqAB9H1fX3cfnVcKI/jgH
	8TojCkl3RGP6DpDK+bstPrCIEDuzApFJFLq5RuiqM4F4s
X-Gm-Gg: AZuq6aJODsmxhb7IWzQQZd9GFHWMDBuJ3O9qOaVrckldT25TIMYSxqA91gjZgAkZlRu
	lSfj07Jjr9NOe+d8EqY5XEprmpoct/hjlul+lb8fYeWeEWgJSxS4iTuP30bxMrDyVNyN2KqirRs
	2sCuk5FyZ18VmVC63iWBNjgzqi+kRN5HZbdmEJjHjY518Tuac20wRYfWQi0roIIA/L1PEi8af/l
	00dDFfjK/fpmx4nIehnIlxRiI0I8IwAymitFtvdmab86W3xy4MsZp6Fw4tWHpkUrtdrpaUi6yOa
	h9AEIRd+oY66p2pwu5GM67EvkEQB
X-Received: by 2002:a05:690c:e3eb:b0:794:2c3d:7952 with SMTP id
 00721157ae682-7945a845df7mr47379077b3.3.1769465082722; Mon, 26 Jan 2026
 14:04:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125233335.6875-1-chris.bainbridge@gmail.com>
 <DM3PPF63A6024A93B1437A144E82CC38B7AA393A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <aXcovK8uhsiaHumT@debian.local> <DM3PPF63A6024A907097A88AEB32669C1E5A393A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
In-Reply-To: <DM3PPF63A6024A907097A88AEB32669C1E5A393A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
From: Chris Bainbridge <chris.bainbridge@gmail.com>
Date: Mon, 26 Jan 2026 22:04:31 +0000
X-Gm-Features: AZwV_QiceH7qsXObZwUw3W1_GqQzTM8Z2nnHyRpegpE1rqs3Px19JUyms_T0uKk
Message-ID: <CAP-bSRZ60CSEtR-_9OL6k_Lzg=w8MtD2i79KpwF+nYYzgak=-Q@mail.gmail.com>
Subject: Re: [PATCH] Revert "wifi: iwlwifi: trans: remove STATUS_SUSPENDED"
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "kvalo@kernel.org" <kvalo@kernel.org>, "Berg, Johannes" <johannes.berg@intel.com>, 
	"benjamin@sipsolutions.net" <benjamin@sipsolutions.net>, "gustavoars@kernel.org" <gustavoars@kernel.org>, 
	"linux-intel-wifi@intel.com" <linux-intel-wifi@intel.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31191-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisbainbridge@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8E6828DCFB
X-Rspamd-Action: no action

On Mon, 26 Jan 2026 at 13:45, Korenblit, Miriam Rachel
<miriam.rachel.korenblit@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Chris Bainbridge <chris.bainbridge@gmail.com>
> > Sent: Monday, January 26, 2026 10:42 AM
> > To: Korenblit, Miriam Rachel <miriam.rachel.korenblit@intel.com>
> > Cc: kvalo@kernel.org; Berg, Johannes <johannes.berg@intel.com>;
> > benjamin@sipsolutions.net; gustavoars@kernel.org; linux-intel-wifi@intel.com;
> > linux-wireless@vger.kernel.org; netdev@vger.kernel.org; linux-
> > kernel@vger.kernel.org; stable@vger.kernel.org
> > Subject: Re: [PATCH] Revert "wifi: iwlwifi: trans: remove STATUS_SUSPENDED"
> >
> > On Mon, Jan 26, 2026 at 07:15:54AM +0000, Korenblit, Miriam Rachel wrote:
> > >
> > > Hi Chris, could you please provide the full log?
> > >
> > > Miri
> >
> > Sure, for 6.18.0 see https://lore.kernel.org/linux-
> > wireless/aTDoDiD55qlUZ0pn@debian.local/
> >
> >
> Thanks!
>
> could you please test if the attached patch eliminates the panic?

Yes, that seems to work fine.

Reported-and-tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>

