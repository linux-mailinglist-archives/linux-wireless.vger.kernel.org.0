Return-Path: <linux-wireless+bounces-17793-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D0DA17D0E
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 12:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 448D21884863
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 11:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618121EEA46;
	Tue, 21 Jan 2025 11:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="oWnH7oGL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D99D26AFA
	for <linux-wireless@vger.kernel.org>; Tue, 21 Jan 2025 11:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737459171; cv=none; b=u9wCSh3nBiUlYZ0d/7RZudtm+zA91P4EQL85bLCfYj38ZR6hSEQT/XwAL/0m6uOfeLPDXi7kXvrALPyXIxlZidPXfhRW1YIWYuBfQdFzHoopnLHvsou9e0lti0Ck5BOxel9BPnO0pgTL8AGmeKRourrI0GFeZ29cqg1XOrlS93A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737459171; c=relaxed/simple;
	bh=2hXM2a2eS/x9t4Qg7uHryYXc+55ZCWlomya/9VHVijM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7rddUgCdNLafJgL5ZZIcsSsO8Q5vmyL3SWcttqE58R3KkK6uMoV0S5EVA01nWH1nOVuRB4mWpbMevcj9Vgg/b4iBLiThq6jUfHccckSU2/9aOzSOvVeviamB1djxyPvHtgJdXNV3YZFqEqWbrWaBft7IeUsT0o8iC3w45wSDHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=oWnH7oGL; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id A0A4E1F98F;
	Tue, 21 Jan 2025 12:32:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1737459158;
	bh=2hXM2a2eS/x9t4Qg7uHryYXc+55ZCWlomya/9VHVijM=; h=From:To:Subject;
	b=oWnH7oGLvOCk/Kt9hS6wX4Ws1DENW4sBdAr/N1lQwxdBcx4ma5uedwptZf4abQQIc
	 BIXSr2zauZJmiOLvodY0YblUAdSA8O8fHT+DzZDlYz7WVMGK6BiXLIWoRSirFamF+B
	 Tfj0PxlPKoJOT4gJC2aoCcmkL85XXo/ZY8IpQKThaL9Vc2v3MonIJN8AqU3KtKB0yw
	 r6rszksU6ugx3PjKIA+35vgnDNSSmfFOAagUp/0OPk/hg9ni8mBEMSV7C/XA8pNIWg
	 XAhppPf11dauJcAzfa+P8g4SCDDnQYcH3H/MPTrsA9lo6vVOBHq3WvPuVicmu8YQWi
	 2X0bArnd3d2mA==
Date: Tue, 21 Jan 2025 12:32:34 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
	Kalle Valo <kvalo@qca.qualcomm.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: Re: ath11k-firmware: WCN6855 hw2.1: add Silex SX-PCEAX specific BDF
Message-ID: <20250121113234.GA28230@francesco-nb>
References: <Z1bc_jn-k-88Io3f@gaggiata.pivistrello.it>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1bc_jn-k-88Io3f@gaggiata.pivistrello.it>

+Jeff, that seems to be active on this area.

Hello all,

On Mon, Dec 09, 2024 at 01:05:18PM +0100, Francesco Dolcini wrote:
> I'd like to ask for inclusion for the board file for Silex SX-PCEAX
> radio module [1].

Any comment on this? It's been a while since I sent this and I had no
feedback so far.

Francesco


