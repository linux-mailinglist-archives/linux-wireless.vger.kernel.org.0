Return-Path: <linux-wireless+bounces-1671-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 290BA829CDE
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 15:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361D11C212A8
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 14:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850724BA84;
	Wed, 10 Jan 2024 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzaGILYT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCB34BA82
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jan 2024 14:54:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E64AC433C7;
	Wed, 10 Jan 2024 14:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704898461;
	bh=CRQOolx/akJ6xXywT8NkUokRhvm4/LmXCeNCy8ZBcJU=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=ZzaGILYTSG5swvJw3s+o+SOBCyNjEZYVyHRG0A5O6jmB8ZKvVoptyLwqrTe/LR5wD
	 VjrlHee6lIsIH6K/Z7gvmTILxoYFck0bESjJiV7pUUYRcIpQ+gObI7wWRQYJj/8QkZ
	 5HwB7+zTEbu9S/qX5/WCgeH262TJaKcb5J/6SXGIDAjT0dDL6LN8f7NYUjo2IfO/P4
	 8ZgdIyHYr+TvgSCqI3buVB6ESEDeAE08t7Qfs5KBGkV8cynB6RNbT3p8P5mZCb6tzt
	 cMgGOwWph89jsNKRwrlkr57805dsu2D7gqzUSo/o/6OOgwUoChV/+0KnlUy/7ZIU9/
	 TKNNlg7PB1w5g==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 01/21] wifi: rtl8xxxu: remove assignment of priv->vif
 in
 rtl8xxxu_bss_info_changed()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231222101442.626837-2-martin.kaistra@linutronix.de>
References: <20231222101442.626837-2-martin.kaistra@linutronix.de>
To: Martin Kaistra <martin.kaistra@linutronix.de>
Cc: linux-wireless@vger.kernel.org, Jes Sorensen <Jes.Sorensen@gmail.com>,
 Ping-Ke Shih <pkshih@realtek.com>,
 Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170489845789.471554.4000045370111948764.kvalo@kernel.org>
Date: Wed, 10 Jan 2024 14:54:19 +0000 (UTC)

Martin Kaistra <martin.kaistra@linutronix.de> wrote:

> priv->vif gets already set in rtl8xxxu_add_interface, there is no need
> to set it also in rtl8xxxu_bss_info_changed().
> 
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

21 patches applied to wireless-next.git, thanks.

d55cb6d8a994 wifi: rtl8xxxu: remove assignment of priv->vif in rtl8xxxu_bss_info_changed()
2bbd7d584046 wifi: rtl8xxxu: prepare supporting two virtual interfaces
7f444692cde8 wifi: rtl8xxxu: support setting linktype for both interfaces
a047e46a7b98 wifi: rtl8xxxu: 8188e: convert usage of priv->vif to priv->vifs[0]
00add60cad3c wifi: rtl8xxxu: support setting mac address register for both interfaces
9aa776209ca3 wifi: rtl8xxxu: extend wifi connected check to both interfaces
80fd8687db41 wifi: rtl8xxxu: extend check for matching bssid to both interfaces
f86dd8eaf8da wifi: rtl8xxxu: don't parse CFO, if both interfaces are connected in STA mode
3ff7a05996f9 wifi: rtl8xxxu: support setting bssid register for multiple interfaces
43532c050f8e wifi: rtl8xxxu: support multiple interfaces in set_aifs()
05b22e9b7d84 wifi: rtl8xxxu: support multiple interfaces in update_beacon_work_callback()
6b7663828705 wifi: rtl8xxxu: support multiple interfaces in configure_filter()
3f9baa99f842 wifi: rtl8xxxu: support multiple interfaces in watchdog_callback()
eef55f1545c9 wifi: rtl8xxxu: support multiple interfaces in {add,remove}_interface()
073401c3b6b9 wifi: rtl8xxxu: support multiple interfaces in bss_info_changed()
61fdbd9e2a9d wifi: rtl8xxxu: support multiple interface in start_ap()
5ce0d7e8aee0 wifi: rtl8xxxu: add macids for STA mode
f232e9d91bb8 wifi: rtl8xxxu: remove obsolete priv->vif
b837f78fbffa wifi: rtl8xxxu: add hw crypto support for AP mode
69abad618efd wifi: rtl8xxxu: make supporting AP mode only on port 0 transparent
1cd165adf314 wifi: rtl8xxxu: declare concurrent mode support for 8188f

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231222101442.626837-2-martin.kaistra@linutronix.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


