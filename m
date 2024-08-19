Return-Path: <linux-wireless+bounces-11621-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 483BD956D6D
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 16:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C1891C2247A
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 14:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691D416D314;
	Mon, 19 Aug 2024 14:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhTYBgDz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC1E15F336;
	Mon, 19 Aug 2024 14:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724078164; cv=none; b=ts136+Y7qDNZfd1Woz2Ix/6/QXVgesYW1Xk5X3XBlryKXeP5i5o60CeVhLrua37NpyhHtly0A4pcwroE88H8yslYESAyc6GstQ7xkP8TiF71ysdaUxgLkuTkaiVrN5COIX7QHuSESuQvOpQls+QYF1f7dWxySamRW769Z0C6xCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724078164; c=relaxed/simple;
	bh=lOhVDAbDSbamnoXSZGytjq4rcSZI6pRdUdlaop0BxTk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=bVj+a0Bmxo06xRUWcwdKjDKIDgs5JMJjR8rZa0gVQ+i1TN7sG8CU5/GDaUEM2iaQFXgtH+wC4mHDbdyinVYh/TxQwtNzH8uiu+KupqMZChUBcX6wKuvFhOArhUXcrTnx2RHQ5TNkoKWZzlijo0SuPFbiEPFDJNv1Nnjib6X38Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhTYBgDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29CBC32782;
	Mon, 19 Aug 2024 14:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724078163;
	bh=lOhVDAbDSbamnoXSZGytjq4rcSZI6pRdUdlaop0BxTk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=KhTYBgDzbrSs4l90WaKYic8RY5F/Sgy9acPi/QyNOGe2IQ3d9n8njIK3DyIcmba1M
	 iqWIBUv/iX0fso0CTOCpCBaModyf7xgwX1/cNxRe4HGgjqhq81NErlcWK3iK9pU+m8
	 rOZ0SlLCb0PVyngp5Evf/ec24bN4pAUSssXMci9OaYN5M5GrMQ/Yl3VrBIPq4107s6
	 OB82u33Ww15nLnNPXfRpB6lnGtlqCPcILDgHBDCJh5i1GchXlJ5/o4om8sQ73Pn+4I
	 neo5LeaH5QHjBWqQmHsxmK/9+41ZoCfYkXQ293uMYKWavdyjOD5K9F5elt4CteT88a
	 cAQzMhz1Eub+w==
From: Kalle Valo <kvalo@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: linux-wireless@vger.kernel.org,  Chung-Hsien Hsu
 <stanley.hsu@cypress.com>,  Chung-Hsien Hsu
 <chung-hsien.hsu@infineon.com>,  "Dr. David Alan Gilbert"
 <linux@treblig.org>,  "Gustavo A. R. Silva" <gustavoars@kernel.org>,
  =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,  Arend van Spriel
 <arend.vanspriel@broadcom.com>,  Bjorn Helgaas <bhelgaas@google.com>,
  Carter Chen <carter.chen@infineon.com>,  Duoming Zhou
 <duoming@zju.edu.cn>,  Erick Archer <erick.archer@outlook.com>,  Kees Cook
 <kees@kernel.org>,  Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
  Mathias Krause <minipli@grsecurity.net>,  Matthias Brugger
 <mbrugger@suse.com>,  Owen Huang <Owen.Huang@infineon.com>,  Ulf Hansson
 <ulf.hansson@linaro.org>,  brcm80211-dev-list.pdl@broadcom.com,
  brcm80211@lists.linux.dev
Subject: Re: [PATCH 1/2] wifi: brcmfmac: add support for TRX firmware download
References: <20240818201533.89669-1-marex@denx.de>
Date: Mon, 19 Aug 2024 17:35:57 +0300
In-Reply-To: <20240818201533.89669-1-marex@denx.de> (Marek Vasut's message of
	"Sun, 18 Aug 2024 22:12:25 +0200")
Message-ID: <871q2ky3zm.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marek Vasut <marex@denx.de> writes:

> From: Chung-Hsien Hsu <stanley.hsu@cypress.com>
>
> Add support to download TRX firmware for PCIe and SDIO.
>
> Signed-off-by: Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>
> Signed-off-by: Marek Vasut <marex@denx.de> # Upport to current linux-next

The commit message should answer to the question 'Why?'. What's TRX
firmware and why do we need it?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

