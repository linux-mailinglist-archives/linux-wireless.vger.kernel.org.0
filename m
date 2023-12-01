Return-Path: <linux-wireless+bounces-275-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDB680083C
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 11:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF04028139C
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 10:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EA120B01;
	Fri,  1 Dec 2023 10:31:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6635C106;
	Fri,  1 Dec 2023 02:31:03 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 8B6C820645;
	Fri,  1 Dec 2023 11:31:01 +0100 (CET)
Date: Fri, 1 Dec 2023 11:31:00 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, kvalo@kernel.org, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com
Subject: Re: [PATCH v7 06/12] wifi: mwifiex: added mac address for AP config.
Message-ID: <ZWm15Nb4tZ5LfjFp@francesco-nb.int.toradex.com>
References: <20231128083115.613235-1-yu-hao.lin@nxp.com>
 <20231128083115.613235-7-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128083115.613235-7-yu-hao.lin@nxp.com>

On Tue, Nov 28, 2023 at 04:31:09PM +0800, David Lin wrote:
> Added TLV command TLV_TYPE_UAP_MAC_ADDRESS for AP configuration.
> 
> Without this TLV command, client can't connect to AP after restart of
> hostapd.

Do I understand correctly this is a fix for an existing issue that has
nothing to do with the HOST MLE topic?

If so, that great to have this fixed (and it looks like something I am
affected by, I will try it in the coming days), but it should be:
 - separate patch from this series
 - fixes tag 
 - cc stable

Francesco



