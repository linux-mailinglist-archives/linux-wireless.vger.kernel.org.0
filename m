Return-Path: <linux-wireless+bounces-18090-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71765A21205
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 20:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9690188886C
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 19:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42511DE8A5;
	Tue, 28 Jan 2025 19:14:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns.iliad.fr (ns.iliad.fr [212.27.33.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595F11C5F2C
	for <linux-wireless@vger.kernel.org>; Tue, 28 Jan 2025 19:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.33.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738091649; cv=none; b=e4mCnBK6jKJDD+DUfkhkyRyz+iQO5kA0jYRgSFAAlr0SgKDsI20gEX5vOqmOEJ/rdwvhFfJsBJ9GVBAaRaSi2YpNA8D+m1mmr4+oX4j9J6ZHsBH7nrabGVlxIfpmquoeqD18U3dfhL/LRkOldHFtq/EoDDAq2k/l8u5vK2vjgI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738091649; c=relaxed/simple;
	bh=zuJsGRkQsFYTiaY6imygnPrbK4A2tpmbVu0lGGjQ5Wc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DQurR/75wWMC2aAHBQyut2Ugzj1KF6PiLxiagufME5+gNQQlZA4FXCuejD8bhyzQi99NOe5x0CQdUUsD+GzcfpwDowLhaRQIOq2Sg18u1iwTKkwiC0VE41psPAgRkkH2LPdDle3LZ+o7+jxY8qIpu3YJICdoPhu35sdyEBfWxIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=srs.iliad.fr; arc=none smtp.client-ip=212.27.33.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=srs.iliad.fr
Received: from ns.iliad.fr (localhost [127.0.0.1])
	by ns.iliad.fr (Postfix) with ESMTP id 6981020913;
	Tue, 28 Jan 2025 20:13:57 +0100 (CET)
Received: from [192.168.108.70] (freebox.vlq16.iliad.fr [213.36.7.13])
	by ns.iliad.fr (Postfix) with ESMTP id 4FAB8206E8;
	Tue, 28 Jan 2025 20:13:57 +0100 (CET)
Message-ID: <54d456f00aa8a806768099df55dc9f2ef734209b.camel@freebox.fr>
Subject: Re: [PATCH v9 6/9] wifi: ath12k: add support for setting fixed HE
 rate/GI/LTF
From: Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>, 
	ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Muna Sinada <quic_msinada@quicinc.com>, 
	Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 28 Jan 2025 20:13:57 +0100
In-Reply-To: <961df6e7-0b5c-4972-9324-5c4d430cb172@quicinc.com>
References: <20250114003813.2783550-1-quic_pradeepc@quicinc.com>
	 <20250114003813.2783550-7-quic_pradeepc@quicinc.com>
	 <f5c6d874e9d7682d52c5ed107a0ede952b5cf53f.camel@freebox.fr>
	 <5861c953-436e-4f36-ae8b-5ef52fceb3b6@quicinc.com>
	 <2aba18dc3448b5a60a1a06b33fa591e562927693.camel@freebox.fr>
	 <961df6e7-0b5c-4972-9324-5c4d430cb172@quicinc.com>
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


On Tue, 2025-01-28 at 10:44 -0800, Pradeep Kumar Chitrapu wrote:


Hello,


> Currently default is configured as FORCE_SGI

"Currently" with or without your patch applied ?

From my perspective:
 - without your patch: DEFAULT_SGI
 - with your patch applied, no fixed rate: FORCE_SGI
 - with your patch applied, fixed rates: user decides

--=20
Maxime




