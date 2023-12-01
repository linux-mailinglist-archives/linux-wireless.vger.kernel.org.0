Return-Path: <linux-wireless+bounces-296-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D199800B3D
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 13:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1CB7B20C34
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 12:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C271CF87;
	Fri,  1 Dec 2023 12:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGes+BSB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F8F1C685
	for <linux-wireless@vger.kernel.org>; Fri,  1 Dec 2023 12:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3A1C433C9;
	Fri,  1 Dec 2023 12:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701434569;
	bh=CtiSCjURkWMe8ITnZMluTnnP2YCNvb5gqkCS/m6xU5w=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=XGes+BSBynJBlPYl+f0fdwqcc+pQ6BHz9RKG818Wf9ujBcRD/rkbevpIT+paMiUUP
	 Ur0b6iSCNLfITRZOyvgaXCanXL6+Icdp/XCUyPhqosyxNE12rq+mHhLH4CxxdMOd1Z
	 eaLNCbvlE9vjM+ut2QdVN4mM+PoDnnyGvsE+KWgR4jo5iMd2yTDc+ipVMSWGJ+32TH
	 gJj/4ac+QucJZ2YQygRDSfSvEO4aSfsQ4vv5eoq+rJDWK4OtdyjnS/jmzBAB0mH6hz
	 Z2i+fX1CN++Rxtfc/D5nTfg6mgFkH1Wsi3QZXq/LnL3U71qgoL0FIAG1TIKuXBaP5o
	 z9OCuGSOK3olg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rt2x00: make watchdog param per device
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231126195358.500259-1-stf_xl@wp.pl>
References: <20231126195358.500259-1-stf_xl@wp.pl>
To: stf_xl@wp.pl
Cc: linux-wireless@vger.kernel.org, Shiji Yang <yangshiji66@outlook.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170143456710.2072551.16697678854955960698.kvalo@kernel.org>
Date: Fri,  1 Dec 2023 12:42:48 +0000 (UTC)

stf_xl@wp.pl wrote:

> From: Stanislaw Gruszka <stf_xl@wp.pl>
> 
> We can run PCI/MMIO devices together with USB devices in the system.
> Make watchdog parameter per device to avoid situation when plugin
> USB device change modparam_watchdog for PCI/MMIO device.
> 
> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
> Tested-by: Shiji Yang <yangshiji66@outlook.com>

Patch applied to wireless-next.git, thanks.

62ad3b976cd7 wifi: rt2x00: make watchdog param per device

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231126195358.500259-1-stf_xl@wp.pl/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


