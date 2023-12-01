Return-Path: <linux-wireless+bounces-280-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E56E180088F
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 11:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BEEE1C20BAC
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 10:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CA620300;
	Fri,  1 Dec 2023 10:40:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24B6196;
	Fri,  1 Dec 2023 02:40:22 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 1B27220645;
	Fri,  1 Dec 2023 11:40:21 +0100 (CET)
Date: Fri, 1 Dec 2023 11:40:19 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, kvalo@kernel.org, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com
Subject: Re: [PATCH v7 11/12] wifi: mwifiex: misc modifications for review
 comments.
Message-ID: <ZWm4E+JjrFFl8U/o@francesco-nb.int.toradex.com>
References: <20231128083115.613235-1-yu-hao.lin@nxp.com>
 <20231128083115.613235-12-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128083115.613235-12-yu-hao.lin@nxp.com>

On Tue, Nov 28, 2023 at 04:31:14PM +0800, David Lin wrote:
> 1. Moved struct mwifiex_ieee80211_mgmt from cfg80211.c to fw.h.
> 2. Defined WLAN_AUTH_NONE instead of using 0xFFFF directly.
> 3. Changed host_mlme of struct mwifiex_adapter to host_mlme_enabled.
> 4. Moved mwifiex_check_key_api_ver() to end of mwifiex_ret_get_hw_spec().
> 5. Redefined MWIFIEX_MGMT_HEADER_LEN and MWIFIEX_AUTH_BODY_LEN.

You should fix the existing patch, not create a fixup commit on top.

Francesco

