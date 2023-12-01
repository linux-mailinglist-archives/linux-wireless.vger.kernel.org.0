Return-Path: <linux-wireless+bounces-273-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A48C2800811
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 11:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5DC11C20997
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 10:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B096208C3;
	Fri,  1 Dec 2023 10:18:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83472C7;
	Fri,  1 Dec 2023 02:17:58 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id A9A7B20645;
	Fri,  1 Dec 2023 11:17:56 +0100 (CET)
Date: Fri, 1 Dec 2023 11:17:55 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, kvalo@kernel.org, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com
Subject: Re: [PATCH v7 03/12] wifi: mwifiex: fixed reassocation issue for
 WPA3.
Message-ID: <ZWmy0799XL9Vy4zT@francesco-nb.int.toradex.com>
References: <20231128083115.613235-1-yu-hao.lin@nxp.com>
 <20231128083115.613235-4-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128083115.613235-4-yu-hao.lin@nxp.com>

On Tue, Nov 28, 2023 at 04:31:06PM +0800, David Lin wrote:
> This issue is related to resatart/reconfigure AP.
> 
> When AP is restarted or reconfigured, wpa_supplilcant will use cached
> PMKSA to do association to AP.
> Because association failure does not report to cfg80211/wpa_supplicant,
> wpa_supplicant will always use cached PMKSA to do assocaiton.
> Connection can't be established under this way.

Same comment as patch 2, this seems a fixup of commit 1, you should fix
that patch, not add a followup fixup commit.

Francesco


