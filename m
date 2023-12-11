Return-Path: <linux-wireless+bounces-632-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9BD80C255
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 08:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3AACB20804
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 07:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCCA208B6;
	Mon, 11 Dec 2023 07:47:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89B3F4;
	Sun, 10 Dec 2023 23:47:03 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 6FFCD2033B;
	Mon, 11 Dec 2023 08:47:01 +0100 (CET)
Date: Mon, 11 Dec 2023 08:47:00 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, kvalo@kernel.org, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] wifi: mwifiex: fix STA cannot connect to AP
Message-ID: <ZXa+dHwPe0D4p0pn@francesco-nb.int.toradex.com>
References: <20231208234127.2251-1-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208234127.2251-1-yu-hao.lin@nxp.com>

On Sat, Dec 09, 2023 at 07:41:27AM +0800, David Lin wrote:
> AP BSSID configuration is missing at AP start.
> Without this fix, FW returns STA interface MAC address after first init.
> When hostapd restarts, it gets MAC address from netdev before driver
> sets STA MAC to netdev again. Now MAC address between hostapd and net
> interface are different causes STA cannot connect to AP.
> After that MAC address of uap0 mlan0 become the same. And issue
> disappears after following hostapd restart (another issue is AP/STA MAC
> address become the same).
> This patch fixes the issue cleanly.
> 
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> Fixes: 12190c5d80bd ("mwifiex: add cfg80211 start_ap and stop_ap handlers")
> Cc: stable@vger.kernel.org

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Francesco


