Return-Path: <linux-wireless+bounces-17754-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48510A16C63
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 13:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D9213A4A6E
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 12:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A061DF996;
	Mon, 20 Jan 2025 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTOtiKAY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAAC1BBBDD;
	Mon, 20 Jan 2025 12:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737376242; cv=none; b=AQDUxPfKlOWwgSNoWmxbmD2hLSDUBFKVypNyi68vIHicL7Ijo4E+aLBu/PIxri0uwSjR489BfveXlzrFiKbIwROLL4mRHNLFR3dMNpcGawF9e43G8vEuIDWBTq/9TpDJFLQfyZH+xa9rcy/oGqvyufj3UcgkiP2wHMOjyO0GqHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737376242; c=relaxed/simple;
	bh=PfANpzjmkKRZON6fzATdINiEuObkXps3LNdB7bLN7AU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=LUMEuzZiT2e/adminrZ1gXZCFYzdh1Gx7tzWXKZuMKon9B8cEaJEvj5yniGOfXvvQQaZfgRXDRGS/BEkbX42KRZVaqZ3KfXiDxWJTAliCb6rkotD/jelZiqTMBNnnUFVC/E/4omck7U/GFZlyxwEIUMMl5FDvQVBHxMlbj2ocug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTOtiKAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27B8C4CEDD;
	Mon, 20 Jan 2025 12:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737376241;
	bh=PfANpzjmkKRZON6fzATdINiEuObkXps3LNdB7bLN7AU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=gTOtiKAYV7A09QL07ttKUyI4to3Y3d9opjBcp53dxbmrDVGgw+tALN9QQZktQqEWp
	 yesmlD7vwBassXOBZ05gHEr1268lOVO+UXA9y38es/W+35CkwgDoTbm+TBkHAIEnzE
	 uItgIfA4IasEDuBm5+R41bbSepIioDnbHhSSmNS0xbBv0FhB6nvr4JKE2um1aWuAIM
	 rz6OvEibIqV27KrjMrb4XHr/ZtAXtf775iD3INNLYcNvq4ym4OBmz9esRFNoGECRIn
	 jOQG9xpH7DwEy64NRHR/I1z9p1VuKKZpauXOnNFK5+Dsk1CIYh6K2b+yZ1CJbXhHGw
	 GxE11lBbnrLdw==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Chen <jeff.chen_1@nxp.com>
Cc: linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org,
  briannorris@chromium.org,  francesco@dolcini.it,
  tsung-hsien.hsieh@nxp.com,  s.hauer@pengutronix.de
Subject: Re: [PATCH] wifi: mwifiex: Resolve the failure in downloading
 calibration data.
References: <20250120074011.720358-1-jeff.chen_1@nxp.com>
Date: Mon, 20 Jan 2025 14:30:37 +0200
In-Reply-To: <20250120074011.720358-1-jeff.chen_1@nxp.com> (Jeff Chen's
	message of "Mon, 20 Jan 2025 15:40:10 +0800")
Message-ID: <87frldllaq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Chen <jeff.chen_1@nxp.com> writes:

> Correct the command format for downloading calibration data.
>
> Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>

Like Francesco mentioned in patch 2, please also expand here why you are
doing all this. One sentence commit message is usually a bad idea,
unless the patch is really trivial.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

