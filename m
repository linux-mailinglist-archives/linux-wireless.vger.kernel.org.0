Return-Path: <linux-wireless+bounces-276-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7886680085F
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 11:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EA60B212B0
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 10:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE80E20B18;
	Fri,  1 Dec 2023 10:36:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A689F4;
	Fri,  1 Dec 2023 02:36:48 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 5FB93206C0;
	Fri,  1 Dec 2023 11:36:46 +0100 (CET)
Date: Fri, 1 Dec 2023 11:36:44 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, kvalo@kernel.org, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com
Subject: Re: [PATCH v7 07/12] wifi: mwifiex: fixed TLV error for station add
 cmd.
Message-ID: <ZWm3PPilLWbxNrRr@francesco-nb.int.toradex.com>
References: <20231128083115.613235-1-yu-hao.lin@nxp.com>
 <20231128083115.613235-8-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128083115.613235-8-yu-hao.lin@nxp.com>

On Tue, Nov 28, 2023 at 04:31:10PM +0800, David Lin wrote:
> TLV commands setting for host command HostCmd_CMD_ADD_NEW_STATION is
> not correct. This issue will set wrong station information to firmware.
> 
> Without this patch, transmission will get 50-70% low throughput for host
> mlme AP mode.

Is this an issue affecting also the existing code, or it depends on the
host MLE one?

From the commit message to me it looks like it should be a dedicated and
separated patch, therefore should probably be before the other patch (or
maybe even a separated one, maybe is easier to get it done this way?)

Francesco


