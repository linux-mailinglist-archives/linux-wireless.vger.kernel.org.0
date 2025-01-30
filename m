Return-Path: <linux-wireless+bounces-18217-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D869EA22B09
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 10:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B02C3A5CB4
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 09:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319E820E6;
	Thu, 30 Jan 2025 09:57:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns.iliad.fr (ns.iliad.fr [212.27.33.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB0C19C561
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 09:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.33.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738231079; cv=none; b=bBg9xUeytLV/Z+rtTAH+EZgnLMt41nWI9z25E2Nn2ecY1uryrDs9xgxcj5mPyGvAuomSlmX1TKsI4fIXZbA1BJnPNzzVgR31nWPmCh4OVHWq9feAxPMblKKswCN57+sl+ZheS6l3OduU3DMRhEUZdjHunlaucj5R+oAAbqGIBSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738231079; c=relaxed/simple;
	bh=Dv2Z+6bVMvXwet2VrBhZc5kxtnNUesmhBOyXn9ypccQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lev2yrY2QCZbsoavRqT8RvzKqnVKh1fKRtNVgl+wxqunDYUXEkZkPAvo+saPKMsd+VlGIdHM8lxGkOKvyRuh5sa8D4t8XHD3BFQ/JwOjt1ceBf9VXAHtdQ/uUmERzueFVGHH5CGzRJJRdfpdhxXYh6ZJ4lkuk7ALrERSGtsnmUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=srs.iliad.fr; arc=none smtp.client-ip=212.27.33.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=srs.iliad.fr
Received: from ns.iliad.fr (localhost [127.0.0.1])
	by ns.iliad.fr (Postfix) with ESMTP id B4ADD20166;
	Thu, 30 Jan 2025 10:57:46 +0100 (CET)
Received: from [192.168.108.70] (freebox.vlq16.iliad.fr [213.36.7.13])
	by ns.iliad.fr (Postfix) with ESMTP id A5511200CE;
	Thu, 30 Jan 2025 10:57:46 +0100 (CET)
Message-ID: <1a6316872ecb6b49cbaab70d5e8fd01e78fe0ba6.camel@freebox.fr>
Subject: Re: [PATCH v9 6/9] wifi: ath12k: add support for setting fixed HE
 rate/GI/LTF
From: Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>, 
	ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Muna Sinada <quic_msinada@quicinc.com>, 
	Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 30 Jan 2025 10:57:46 +0100
In-Reply-To: <dedfdb8e-c5b4-42fa-bd76-ca866ab1cf41@quicinc.com>
References: <20250114003813.2783550-1-quic_pradeepc@quicinc.com>
	 <20250114003813.2783550-7-quic_pradeepc@quicinc.com>
	 <f5c6d874e9d7682d52c5ed107a0ede952b5cf53f.camel@freebox.fr>
	 <5861c953-436e-4f36-ae8b-5ef52fceb3b6@quicinc.com>
	 <2aba18dc3448b5a60a1a06b33fa591e562927693.camel@freebox.fr>
	 <961df6e7-0b5c-4972-9324-5c4d430cb172@quicinc.com>
	 <54d456f00aa8a806768099df55dc9f2ef734209b.camel@freebox.fr>
	 <dedfdb8e-c5b4-42fa-bd76-ca866ab1cf41@quicinc.com>
Organization: Freebox
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


On Wed, 2025-01-29 at 11:30 -0800, Pradeep Kumar Chitrapu wrote:

Hello,


> Yes, your understanding is correct..

So your patch actually does two things:
  - add support for fixed rate
  - fix default value sent for GI config to the firmware

> If peer support SGI, param_value 1 is sent to firmware where firmware
> switches between SGI/LGI based on packet error rate. This param value
> 1 corresponds to NL80211_TXRATE_FORCE_SGI in nl80211.

Is this what we really want ?

I understand the nl80211 enum like this:

NL80211_TXRATE_FORCE_SGI:
 =3D> if STA supports SGI: use SGI only
 =3D> if STA does not support SGI: use LGI only (or SGI only ? IDK)

NL80211_TXRATE_FORCE_LGI:
 =3D> always use LGI

NL80211_TXRATE_DEFAULT_GI (no forcing)
 =3D> if STA does not support SGI: use LGI only
 =3D> if STA supports SGI: implementation defined, most likely SGI/LGI
chosen by rate control


Assuming my understanding is correct, should you not adapt
ath12k_peer_assoc_h_ht() to match this semantic ?

--=20
Maxime




